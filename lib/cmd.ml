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

  Eio.Fiber.fork ~sw (K.Job.start_watcher client);
  Eio.Fiber.fork ~sw (K.Pod.start_watcher client);
  Eio.Fiber.fork ~sw (K.Deployment.start_watcher client);
  Eio.Fiber.fork ~sw (K.Service.start_watcher client);
  Eio.Fiber.fork ~sw (K.Config_map.start_watcher client);
  Eio.Fiber.fork ~sw (Mastodon.start_watcher client);

  K.Job.enable_cache ();
  K.Pod.enable_cache ();
  K.Deployment.enable_cache ();
  K.Service.enable_cache ();
  K.Config_map.enable_cache ();
  Mastodon.enable_cache ();

  Eio.Fiber.fork ~sw
    (Mastodon_reconciler.start env client gw_nginx_conf_templ_cm_name);

  ()
