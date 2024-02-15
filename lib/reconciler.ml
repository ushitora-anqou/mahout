module Make (S : sig
  type args

  val reconcile :
    sw:Eio.Switch.t ->
    Cohttp_eio.Client.t ->
    name:string ->
    namespace:string ->
    args ->
    (unit, string) result
end) =
struct
  type t = { mailbox : (string * string) Eio.Stream.t }

  let make () = { mailbox = Eio.Stream.create 0 }

  let start_watching ~register_watcher f t =
    register_watcher (fun (_, x) -> f x |> List.iter (Eio.Stream.add t.mailbox))

  let start env ~sw client args t =
    K.loop_until_sw_fail env ~sw (fun () ->
        let name, namespace = Eio.Stream.take t.mailbox in
        match S.reconcile ~sw client ~name ~namespace args with
        | Ok () -> ()
        | Error e ->
            Logg.err (fun m -> m "reconciler failed" [ ("error", `String e) ]));
    ()
end
