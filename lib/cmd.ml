let controller gw_nginx_conf_templ_cm_name =
  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  Eio.Fiber.fork ~sw (Http_server.start env ~sw);

  let client = K.make_client env in
  K.setup_resource ~sw (module K.Job) client;
  K.setup_resource ~sw (module K.Pod) client;
  K.setup_resource ~sw (module K.Deployment) client;
  K.setup_resource ~sw (module K.Service) client;
  K.setup_resource ~sw (module K.Config_map) client;
  K.setup_resource ~sw (module Mastodon) client;

  Eio.Fiber.fork ~sw
    (Mastodon_reconciler.start env client { gw_nginx_conf_templ_cm_name });
  ()

let failwithf f = Printf.ksprintf failwith f

let restart name namespace target =
  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  let client = K.make_client env in

  let mastodon =
    match Mastodon.get client ~name ~namespace () with
    | Ok x -> x
    | Error e ->
        failwithf "can't get Mastodon resource: %s: %s: %s" name namespace
          (K.show_error e)
  in
  let mastodon =
    let metadata = Option.get mastodon.metadata in
    {
      mastodon with
      metadata =
        Some
          {
            metadata with
            annotations =
              `Assoc
                (let h =
                   metadata.annotations |> Yojson.Safe.Util.to_assoc
                   |> List.to_seq |> Hashtbl.of_seq
                 in
                 let current_time =
                   Eio.Time.now (Eio.Stdenv.clock env)
                   |> Ptime.of_float_s |> Option.get
                   |> Ptime.to_rfc3339 ~tz_offset_s:0 ~frac_s:3
                 in
                 Hashtbl.replace h
                   (match target with
                   | "web" -> Label.web_restart_time_key
                   | "sidekiq" -> Label.sidekiq_restart_time_key
                   | _ -> assert false)
                   (`String current_time);
                 h |> Hashtbl.to_seq |> List.of_seq);
          };
    }
  in

  let () =
    match Mastodon.update client mastodon with
    | Ok _ -> ()
    | Error e ->
        failwithf "can't update Mastodon resource: %s: %s: %s" name namespace
          (K.show_error e)
  in

  ()
