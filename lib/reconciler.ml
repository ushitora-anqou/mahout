module Runqueue = struct
  type 'a t = {
    mtx : Eio.Mutex.t;
    cond : Eio.Condition.t;
    mutable q : (float, 'a) Priority_queue.t;
  }

  let create () =
    {
      mtx = Eio.Mutex.create ();
      cond = Eio.Condition.create ();
      q = Priority_queue.empty;
    }

  let push (t : 'a t) ~deadline x =
    Eio.Mutex.use_rw ~protect:true t.mtx (fun () ->
        t.q <- Priority_queue.insert t.q deadline x);
    Eio.Condition.broadcast t.cond;
    ()

  let collect t now =
    let rec loop acc =
      try
        let deadline, task, q = Priority_queue.extract t.q in
        if deadline > now then acc
        else (
          t.q <- q;
          loop (task :: acc))
      with Priority_queue.Queue_is_empty -> acc
    in
    loop []

  exception Cancel

  let take env t =
    Eio.Mutex.use_rw t.mtx (fun () ->
        let rec loop () =
          let now = Eio.Time.now env#clock in
          match collect t now with
          | [] ->
              (try
                 Eio.Switch.run (fun sw ->
                     (match Priority_queue.extract t.q with
                     | deadline, _, _ ->
                         Eio.Fiber.fork ~sw (fun () ->
                             Eio.Time.sleep_until env#clock deadline;
                             Eio.Condition.broadcast t.cond);
                         ()
                     | exception Priority_queue.Queue_is_empty -> ());
                     Eio.Condition.await t.cond t.mtx;
                     Eio.Switch.fail sw Cancel)
               with Cancel -> ());
              loop ()
          | xs -> xs
        in
        loop ())
end

module Make (S : sig
  type args

  val reconcile :
    Cohttp_eio.Client.t ->
    name:string ->
    namespace:string ->
    args ->
    (unit, string) result
end) =
struct
  type task = { name : string; namespace : string; i : int }
  type t = { rq : task Runqueue.t }

  let make () = { rq = Runqueue.create () }

  let start_watching env ~register_watcher f t =
    register_watcher (fun (_, x) ->
        f x
        |> List.iter (fun (name, namespace) ->
               Runqueue.push t.rq { name; namespace; i = 0 }
                 ~deadline:(Eio.Time.now env#clock)))

  let start env client args t =
    let reconcile_each { name; namespace; i } =
      (* Run reconcile up to 10 times per second *)
      Eio.Time.sleep env#clock 0.1;

      match S.reconcile client ~name ~namespace args with
      | Ok () -> ()
      | Error e ->
          Logg.err (fun m -> m "reconciler failed" [ ("error", `String e) ]);
          let deadline =
            (* Thanks to: https://danielmangum.com/posts/controller-runtime-client-go-rate-limiting/ *)
            let sec = 0.005 *. Float.pow 2.0 (float_of_int i) in
            let sec = if sec > 1000.0 then 1000.0 else sec in
            Eio.Time.now env#clock +. sec
          in
          Runqueue.push t.rq ~deadline { name; namespace; i = i + 1 };
          ()
    in
    let rec loop () =
      Eio.Fiber.yield ();
      Runqueue.take env t.rq ~protect:true
      |> List.sort_uniq compare |> List.iter reconcile_each;
      loop ()
    in
    loop ()
end
