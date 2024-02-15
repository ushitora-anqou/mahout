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

let start_reconcile env ~sw client ~watch_all ~list_all f =
  K.loop_until_sw_fail env ~sw @@ fun () ->
  Eio.Fiber.both
    (fun () ->
      (* This fiber should start first. Watching should start before listing *)
      watch_all ~sw client () |> Result.get_ok
      |> K.Json_response_scanner.iter (fun (_, x) -> f x))
    (fun () -> list_all ~sw client () |> Result.get_ok |> List.iter f)

let controller gw_nginx_conf_templ_cm_name =
  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  Eio.Fiber.fork ~sw (Http_server.start env ~sw);

  let client =
    (* FIXME: use ca cert *)
    Cohttp_eio.Client.make
      ~https:(Some (https ~authenticator:null_auth))
      (Eio.Stdenv.net env)
  in

  K.Job.enable_watcher env ~sw client;
  K.Pod.enable_watcher env ~sw client;
  K.Deployment.enable_watcher env ~sw client;
  K.Service.enable_watcher env ~sw client;
  K.Config_map.enable_watcher env ~sw client;
  Mastodon.enable_watcher env ~sw client;

  (*
  K.Job.enable_cache env ~sw client;
  K.Pod.enable_cache env ~sw client;
  K.Deployment.enable_cache env ~sw client;
  K.Service.enable_cache env ~sw client;
  K.Config_map.enable_cache env ~sw client;
  Mastodon.enable_cache env ~sw client;
  *)
  Mastodon_reconciler.start env ~sw client gw_nginx_conf_templ_cm_name;

  ()
