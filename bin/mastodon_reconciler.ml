let get_owner_references (mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let name = Option.get (Option.get mastodon.metadata).name in
  K.Owner_reference.
    [
      make
        ~api_version:(Option.get mastodon.api_version)
        ~kind:(Option.get mastodon.kind)
        ~uid:(Option.get (Option.get mastodon.metadata).uid)
        ~name ~controller:true ();
    ]

let get_running_pod ~sw client =
  let name = Sys.getenv "POD_NAME" in
  let namespace = Sys.getenv "POD_NAMESPACE" in
  K.Pod.get ~sw client ~name ~namespace () |> Result.get_ok

let get_check_env_job_name ~sw:_ _client
    (mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let name = Option.get (Option.get mastodon.metadata).name in
  name ^ "-check-env"

let create_check_env_job_if_not_exists ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let env_from = (Option.get mastodon.spec).env_from in
  let owner_references = get_owner_references mastodon in
  let job_name = get_check_env_job_name ~sw client mastodon in

  let p = get_running_pod ~sw client in
  let c = List.hd (Option.get p.spec).containers in
  let image = Option.get c.image in
  let service_account_name =
    Option.get (Option.get p.spec).service_account_name
  in

  let body =
    K.Job.make ~api_version:"batch/v1" ~kind:"Job"
      ~metadata:
        (K.Object_meta.make ~name:job_name ~namespace ~owner_references ())
      ~spec:
        (K.Job_spec.make
           ~template:
             (K.Pod_template_spec.make
                ~spec:
                  (K.Pod_spec.make ~service_account_name
                     ~restart_policy:"OnFailure"
                     ~containers:
                       K.Container.
                         [
                           make ~name:"check-env" ~image ~env_from
                             ~args:[ "check-env"; name; namespace ]
                             ~env:
                               [
                                 K.Env_var.make ~name:"OCAMLRUNPARAM" ~value:"b"
                                   ();
                               ]
                             ();
                         ]
                     ())
                ())
           ())
      ()
  in
  K.Job.create ~sw client body |> ignore;
  ()

let create_or_update_sidekiq ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let ( let* ) = Result.bind in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let mastodon_image = (Option.get mastodon.spec).image in
  let env_from = (Option.get mastodon.spec).env_from in

  let deploy_name = name ^ "-sidekiq" in
  let selector =
    `Assoc
      [
        ("app.kubernetes.io/name", `String "sidekiq");
        ("app.kubernetes.io/component", `String "sidekiq");
        ("app.kubernetes.io/part-of", `String "mastodon");
      ]
  in
  let owner_references = get_owner_references mastodon in

  let body =
    K.Deployment.make ~api_version:"apps/v1" ~kind:"Deployment"
      ~metadata:
        (K.Object_meta.make ~name:deploy_name ~namespace ~owner_references ())
      ~spec:
        K.Deployment_spec.(
          make ~replicas:1l
            ~selector:(K.Label_selector.make ~match_labels:selector ())
            ~template:
              (K.Pod_template_spec.make
                 ~metadata:(K.Object_meta.make ~labels:selector ())
                 ~spec:
                   K.Pod_spec.(
                     make
                       ~containers:
                         K.Container.
                           [
                             make ~name:"sidekiq" ~image:mastodon_image
                               ~command:[ "bash"; "-c"; "bundle exec sidekiq" ]
                               ~env_from ();
                           ]
                       ())
                 ())
            ())
      ()
  in
  let* _ =
    K.Deployment.create_or_update ~sw client ~name:deploy_name ~namespace
    @@ fun _ -> body
  in

  Ok ()

let create_or_update_streaming ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let ( let* ) = Result.bind in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let mastodon_image = (Option.get mastodon.spec).image in
  let env_from = (Option.get mastodon.spec).env_from in

  let deploy_name = name ^ "-streaming" in
  let svc_name = name ^ "-streaming" in
  let selector =
    `Assoc
      [
        ("app.kubernetes.io/name", `String "node");
        ("app.kubernetes.io/component", `String "streaming");
        ("app.kubernetes.io/part-of", `String "mastodon");
      ]
  in
  let owner_references = get_owner_references mastodon in

  let body =
    K.Deployment.make ~api_version:"apps/v1" ~kind:"Deployment"
      ~metadata:
        (K.Object_meta.make ~name:deploy_name ~namespace ~owner_references ())
      ~spec:
        K.Deployment_spec.(
          make ~replicas:1l
            ~selector:(K.Label_selector.make ~match_labels:selector ())
            ~template:
              (K.Pod_template_spec.make
                 ~metadata:(K.Object_meta.make ~labels:selector ())
                 ~spec:
                   K.Pod_spec.(
                     make
                       ~containers:
                         K.Container.
                           [
                             make ~name:"streaming" ~image:mastodon_image
                               ~command:[ "bash"; "-c"; "node ./streaming" ]
                               ~env_from
                               ~ports:
                                 K.Container_port.
                                   [
                                     make ~name:"streaming"
                                       ~container_port:4000l ~protocol:"TCP" ();
                                   ]
                               ~liveness_probe:
                                 (K.Probe.make
                                    ~http_get:
                                      (K.Http_get_action.make ~port:"streaming"
                                         ~path:"/api/v1/streaming/health" ())
                                    ())
                               ~readiness_probe:
                                 (K.Probe.make
                                    ~http_get:
                                      (K.Http_get_action.make ~port:"streaming"
                                         ~path:"/api/v1/streaming/health" ())
                                    ())
                               ();
                           ]
                       ())
                 ())
            ())
      ()
  in
  let* _ =
    K.Deployment.create_or_update ~sw client ~name:deploy_name ~namespace
    @@ fun _ -> body
  in

  let body =
    K.Service.make
      ~metadata:
        (K.Object_meta.make ~name:svc_name ~namespace ~owner_references ())
      ~spec:
        (K.Service_spec.make ~selector
           ~ports:[ K.Service_port.make ~port:4000l () ]
           ())
      ()
  in
  let* _ =
    K.Service.create_or_update ~sw client ~name:svc_name ~namespace @@ fun _ ->
    body
  in

  Ok ()

let create_or_update_web ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let ( let* ) = Result.bind in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let mastodon_image = (Option.get mastodon.spec).image in
  let env_from = (Option.get mastodon.spec).env_from in

  let deploy_name = name ^ "-web" in
  let svc_name = name ^ "-web" in
  let selector =
    `Assoc
      [
        ("app.kubernetes.io/name", `String "puma");
        ("app.kubernetes.io/component", `String "web");
        ("app.kubernetes.io/part-of", `String "mastodon");
      ]
  in
  let owner_references = get_owner_references mastodon in

  let body =
    K.Deployment.make ~api_version:"apps/v1" ~kind:"Deployment"
      ~metadata:
        (K.Object_meta.make ~name:deploy_name ~namespace ~owner_references ())
      ~spec:
        K.Deployment_spec.(
          make ~replicas:1l
            ~selector:(K.Label_selector.make ~match_labels:selector ())
            ~template:
              (K.Pod_template_spec.make
                 ~metadata:(K.Object_meta.make ~labels:selector ())
                 ~spec:
                   K.Pod_spec.(
                     make
                       ~containers:
                         K.Container.
                           [
                             make ~name:"web" ~image:mastodon_image
                               ~command:
                                 [
                                   "bash";
                                   "-c";
                                   "bundle exec puma -C config/puma.rb";
                                 ]
                               ~env_from
                               ~ports:
                                 K.Container_port.
                                   [
                                     make ~name:"http" ~container_port:3000l
                                       ~protocol:"TCP" ();
                                   ]
                               ~liveness_probe:
                                 (K.Probe.make
                                    ~tcp_socket:
                                      (K.Tcp_socket_action.make ~port:"http" ())
                                    ())
                               ~readiness_probe:
                                 (K.Probe.make
                                    ~http_get:
                                      (K.Http_get_action.make ~path:"/health"
                                         ~port:"http" ())
                                    ())
                               ~startup_probe:
                                 (K.Probe.make
                                    ~http_get:
                                      (K.Http_get_action.make ~path:"/health"
                                         ~port:"http" ())
                                    ~failure_threshold:30l ~period_seconds:5l ())
                               ();
                           ]
                       ())
                 ())
            ())
      ()
  in
  let* _ =
    K.Deployment.create_or_update ~sw client ~name:deploy_name ~namespace
    @@ fun _ -> body
  in

  let body =
    K.Service.make
      ~metadata:
        (K.Object_meta.make ~name:svc_name ~namespace ~owner_references ())
      ~spec:
        (K.Service_spec.make ~selector
           ~ports:[ K.Service_port.make ~port:3000l () ]
           ())
      ()
  in
  let* _ =
    K.Service.create_or_update ~sw client ~name:svc_name ~namespace @@ fun _ ->
    body
  in

  Ok ()

let create_or_update_gateway ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let ( let* ) = Result.bind in

  let nginx_image = "nginx:1.25.3" in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let mastodon_image = (Option.get mastodon.spec).image in

  let nginx_conf_cm_name = name ^ "-gateway-nginx-conf" in
  let nginx_conf_cm_key = "mastodon-nginx.conf" in
  let nginx_deploy_name = name ^ "-gateway-nginx" in
  let svc_name = name ^ "-gateway-svc" in
  let selector =
    `Assoc
      [
        ("app.kubernetes.io/name", `String "nginx");
        ("app.kubernetes.io/component", `String "gateway");
        ("app.kubernetes.io/part-of", `String "mastodon");
      ]
  in

  let server_name = Option.get (Option.get mastodon.status).server_name in

  let owner_references = get_owner_references mastodon in

  let body =
    K.Config_map.make
      ~metadata:
        (K.Object_meta.make ~name:nginx_conf_cm_name ~namespace
           ~owner_references ())
      ~data:
        (`Assoc
          [
            ( nginx_conf_cm_key,
              `String
                (Gateway_nginx_conf.s
                |> Jingoo.Jg_template.from_string
                     ~models:
                       [
                         ("server_name", Tstr server_name);
                         ("namespace", Tstr namespace);
                       ]) );
          ])
      ()
  in
  let* _ =
    K.Config_map.create_or_update ~sw client ~name:nginx_conf_cm_name ~namespace
    @@ fun _ -> body
  in

  let body =
    K.Deployment.make ~api_version:"apps/v1" ~kind:"Deployment"
      ~metadata:
        (K.Object_meta.make ~name:nginx_deploy_name ~namespace ~owner_references
           ())
      ~spec:
        K.Deployment_spec.(
          make ~replicas:1l
            ~selector:(K.Label_selector.make ~match_labels:selector ())
            ~template:
              (K.Pod_template_spec.make
                 ~metadata:(K.Object_meta.make ~labels:selector ())
                 ~spec:
                   K.Pod_spec.(
                     make
                       ~init_containers:
                         K.Container.
                           [
                             make ~name:"copy-assets" ~image:mastodon_image
                               ~command:
                                 [
                                   "bash";
                                   "-c";
                                   "cp -ra /opt/mastodon/public/* /mnt/public/";
                                 ]
                               ~volume_mounts:
                                 K.Volume_mount.
                                   [
                                     make ~mount_path:"/mnt/public"
                                       ~name:"mnt-public" ();
                                   ]
                               ();
                           ]
                       ~containers:
                         K.Container.
                           [
                             make ~name:"gateway" ~image:nginx_image
                               ~ports:
                                 K.Container_port.
                                   [ make ~container_port:80l () ]
                               ~volume_mounts:
                                 K.Volume_mount.
                                   [
                                     make ~mount_path:"/mnt/public"
                                       ~name:"mnt-public" ~read_only:true ();
                                     make ~mount_path:"/etc/nginx/conf.d"
                                       ~name:"nginx-conf" ~read_only:true ();
                                   ]
                               ();
                           ]
                       ~volumes:
                         K.Volume.
                           [
                             make ~name:"mnt-public"
                               ~empty_dir:(K.Empty_dir_volume_source.make ())
                               ();
                             make ~name:"nginx-conf"
                               ~config_map:
                                 K.Config_map_volume_source.(
                                   make ~name:nginx_conf_cm_name
                                     ~items:
                                       K.Key_to_path.
                                         [
                                           make ~key:nginx_conf_cm_key
                                             ~path:"mastodon.conf" ();
                                         ]
                                     ())
                               ();
                           ]
                       ())
                 ())
            ())
      ()
  in
  let* _ =
    K.Deployment.create_or_update ~sw client ~name:nginx_deploy_name ~namespace
    @@ fun _ -> body
  in

  let body =
    K.Service.make
      ~metadata:
        (K.Object_meta.make ~name:svc_name ~namespace ~owner_references ())
      ~spec:
        (K.Service_spec.make ~selector
           ~ports:[ K.Service_port.make ~port:80l () ]
           ())
      ()
  in
  let* _ =
    K.Service.create_or_update ~sw client ~name:svc_name ~namespace @@ fun _ ->
    body
  in

  Ok ()

let reconcile ~sw client (ev : Mastodon.watch_event) =
  Logs.info (fun m -> m "reconcile: %s" (Mastodon.string_of_watch_event ev));

  let mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t =
    match ev with `Added v | `Modified v | `Deleted v -> v
  in

  match Option.bind mastodon.status (fun x -> Some x.server_name) with
  | None -> create_check_env_job_if_not_exists ~sw client ~mastodon
  | Some _ ->
      (match create_or_update_gateway ~sw client ~mastodon with
      | Ok () -> ()
      | Error e ->
          Logs.err (fun m ->
              m "create_or_update_gateway failed: %s" (K.show_error e)));
      (match create_or_update_web ~sw client ~mastodon with
      | Ok () -> ()
      | Error e ->
          Logs.err (fun m ->
              m "create_or_update_web failed: %s" (K.show_error e)));
      (match create_or_update_sidekiq ~sw client ~mastodon with
      | Ok () -> ()
      | Error e ->
          Logs.err (fun m ->
              m "create_or_update_sidekiq failed: %s" (K.show_error e)));
      (match create_or_update_streaming ~sw client ~mastodon with
      | Ok () -> ()
      | Error e ->
          Logs.err (fun m ->
              m "create_or_update_streaming failed: %s" (K.show_error e)));
      ()
