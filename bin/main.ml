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
  let result =
    K8s_1_28_client.Core_v1_api.list_core_v1_namespaced_pod ~sw client
      ~namespace:"mastodon0" ~watch:true ()
  in
  result.items
  |> List.iter (fun (item : K8s_1_28_client.Io_k8s_api_core_v1_pod.t) ->
         Logs.info (fun m ->
             m ">>> %s / %s"
               (Option.get (Option.get item.metadata).name)
               (Option.get (Option.get item.metadata).namespace)));
  ()

let () =
  Mahout.Logg.setup ();

  (* Initialize PRNG *)
  (try Unix.getenv "RANDOM_INIT" |> int_of_string |> Random.init
   with Not_found -> Random.self_init ());

  let open Cmdliner in
  let cmd =
    Cmd.(
      group (info "mahout")
        [ v (info "controller") Term.(const controller $ const ()) ])
  in
  exit (Cmd.eval cmd)
