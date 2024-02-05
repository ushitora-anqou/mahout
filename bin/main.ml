let null_auth ?ip:_ ~host:_ _ =
  Ok None (* Warning: use a real authenticator in your code! *)

let https ~authenticator =
  let tls_config = Tls.Config.client ~authenticator () in
  fun uri raw ->
    let host =
      try
        uri |> Uri.host |> Option.get |> Domain_name.of_string_exn
        |> Domain_name.host_exn |> Option.some
      with _ -> None
    in
    Tls_eio.client_of_flow ?host tls_config raw

let controller () =
  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  let client =
    (* FIXME: use ca cert *)
    Cohttp_eio.Client.make
      ~https:(Some (https ~authenticator:null_auth))
      (Eio.Stdenv.net env)
  in

  let mailbox = Eio.Stream.create 0 in

  Eio.Fiber.fork ~sw (fun () ->
      Mastodon.watch ~sw client ~namespace:"default" ()
      |> Result.get_ok
      |> K.Json_response_scanner.iter (fun ev -> Eio.Stream.add mailbox ev));

  Eio.Fiber.fork ~sw (fun () ->
      K.Job.watch ~sw client ~namespace:"default" ()
      |> Result.get_ok
      |> K.Json_response_scanner.iter (fun (ty, (job : K.Job.t)) ->
             let is_owned =
               (Option.get job.metadata).owner_references
               |> List.find_opt (fun (r : K.Owner_reference.t) ->
                      r.api_version = "mahout.anqou.net/v1alpha1"
                      && r.kind = "Mastodon" && r.controller = Some true)
               |> Option.is_some
             in
             if is_owned then
               Mastodon_reconciler.find_mastodon_from_job ~sw client job
               |> Option.iter (fun mastodon ->
                      Eio.Stream.add mailbox (ty, mastodon))));

  let rec loop () =
    let ev = Eio.Stream.take mailbox in
    (match Mastodon_reconciler.reconcile ~sw client ev with
    | Ok () -> ()
    | Error e ->
        Logs.err (fun m -> m "mastodon reconciler failed: %s" (K.show_error e)));
    loop ()
  in
  loop ()

let check_env name namespace =
  let server_name = Sys.getenv "LOCAL_DOMAIN" in

  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  match
    let ( let* ) = Result.bind in
    let client =
      (* FIXME: use ca cert *)
      Cohttp_eio.Client.make
        ~https:(Some (https ~authenticator:null_auth))
        (Eio.Stdenv.net env)
    in
    let* mastodon = Mastodon.get_status ~sw client ~name ~namespace () in
    let mastodon =
      {
        mastodon with
        status =
          Some
            (match mastodon.status with
            | None ->
                Net_anqou_mahout.V1alpha1.Mastodon.Status.make ~server_name ()
            | Some status -> { status with server_name = Some server_name });
      }
    in
    let* _ = Mastodon.update_status ~sw client mastodon in
    Ok ()
  with
  | Ok () -> ()
  | Error e ->
      Logs.err (fun m -> m "result error: %s" (K.show_error e));
      exit 1
  | exception e ->
      Logs.err (fun m -> m "exc: %s" (Printexc.to_string e));
      exit 1

let () =
  Mahout.Logg.setup ();

  (* Initialize PRNG *)
  (try Unix.getenv "RANDOM_INIT" |> int_of_string |> Random.init
   with Not_found -> Random.self_init ());

  let open Cmdliner in
  let cmd =
    Cmd.(
      group (info "mahout")
        [
          v (info "controller") Term.(const controller $ const ());
          v (info "check-env")
            Term.(
              const check_env
              $ Arg.(required & pos 0 (some string) None & info ~docv:"NAME" [])
              $ Arg.(
                  required
                  & pos 1 (some string) None
                  & info ~docv:"NAMESPACE" []));
        ])
  in
  exit (Cmd.eval cmd)
