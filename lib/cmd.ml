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

  K.Job.enable_cache env ~sw client;

  Mastodon.enable_cache env ~sw client;
  K.Pod.enable_cache env ~sw client;
  K.Deployment.enable_cache env ~sw client;
  K.Service.enable_cache env ~sw client;
  K.Config_map.enable_cache env ~sw client;

  let reconciler = Mastodon_reconciler.make () in

  reconciler
  |> Mastodon_reconciler.watch env ~sw client ~watch_all:Mastodon.watch_all
       ~list_all:Mastodon.list_all (fun (mastodon : Mastodon.t) ->
         let metadata = Option.get mastodon.metadata in
         let name = Option.get metadata.name in
         let namespace = Option.get metadata.namespace in
         [ (name, namespace) ]);

  reconciler
  |> Mastodon_reconciler.watch env ~sw client ~watch_all:K.Job.watch_all
       ~list_all:K.Job.list_all (fun (job : K.Job.t) ->
         let is_owned =
           (Option.get job.metadata).owner_references
           |> List.find_opt (fun (r : K.Owner_reference.t) ->
                  r.api_version = "mahout.anqou.net/v1alpha1"
                  && r.kind = "Mastodon" && r.controller = Some true)
           |> Option.is_some
         in
         if is_owned then
           Mastodon_reconciler.find_mastodon_from_job ~sw client job
           |> Option.fold ~none:[] ~some:(fun (name, namespace) ->
                  [ (name, namespace) ])
         else []);

  reconciler
  |> Mastodon_reconciler.watch env ~sw client ~watch_all:K.Pod.watch_all
       ~list_all:K.Pod.list_all (fun (pod : K.Pod.t) ->
         Mastodon_reconciler.find_mastodon_from_pod ~sw client pod
         |> Option.fold ~none:[] ~some:(fun (name, namespace) ->
                [ (name, namespace) ]));

  reconciler
  |> Mastodon_reconciler.start env ~sw client gw_nginx_conf_templ_cm_name;

  ()
