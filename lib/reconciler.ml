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

  let watch env ~sw client ~watch_all ~list_all f t =
    K.loop_until_sw_fail env ~sw (fun () ->
        Eio.Fiber.both
          (fun () ->
            (* This fiber should start first. Watching should start before listing *)
            watch_all ~sw client () |> Result.get_ok
            |> K.Json_response_scanner.iter (fun (_, x) ->
                   f x |> List.iter (Eio.Stream.add t.mailbox)))
          (fun () ->
            match list_all ~sw client () with
            | Error msg -> failwith (K.show_error msg)
            | Ok xs ->
                xs
                |> List.iter (fun x ->
                       f x |> List.iter (Eio.Stream.add t.mailbox))));
    ()

  let start env ~sw client args t =
    K.loop_until_sw_fail env ~sw (fun () ->
        let name, namespace = Eio.Stream.take t.mailbox in
        match S.reconcile ~sw client ~name ~namespace args with
        | Ok () -> ()
        | Error e ->
            Logg.err (fun m -> m "reconciler failed" [ ("error", `String e) ]));
    ()
end
