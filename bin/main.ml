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

  (*
  K.Core_v1_api.watch_core_v1_namespaced_pod_list ~sw client
    ~namespace:"mastodon0" ~watch:true ()
  |> K.Json_response_scanner.iter
       (fun (result : K.Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t) ->
         let item =
           K.Io_k8s_api_core_v1_pod.of_yojson result._object |> Result.get_ok
         in
         Logs.info (fun m ->
             m ">>> %s %s / %s" result._type
               (Option.get (Option.get item.metadata).name)
               (Option.get (Option.get item.metadata).namespace)));
  *)
  Mastodon.watch ~sw client ~namespace:"default" ()
  |> Result.get_ok
  |> K.Json_response_scanner.iter (fun ev ->
         match Mastodon_reconciler.reconcile ~sw client ev with
         | Ok () -> ()
         | Error e ->
             Logs.err (fun m ->
                 m "mastodon reconciler failed: %s" (K.show_error e)))
  (*
       (fun (result : K.Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t) ->
         Logs.info (fun m ->
             m "%s %s" result._type (Yojson.Safe.to_string result._object));
         match result._type with
         | "ADDED" ->
             let item =
               Net_anqou_mahout.V1alpha1.Mastodon.of_yojson result._object
               |> Result.get_ok
             in
             let body =
               Net_anqou_mahout.V1alpha1.Mastodon.(
                 { item with status = Some Status.{ message = Some "Hello" } }
                 |> to_yojson)
             in
             let _ =
               Mahout_v1alpha1_api.patch_mahout_v1alpha1_namespaced_mastodon ~sw
                 client
                 ~name:(Option.get (Option.get item.metadata).name)
                 ~namespace:"default" ~body ()
             in
             Logs.info (fun m -> m "patched");
             ()
         | _ -> ()) *);

  ()

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
