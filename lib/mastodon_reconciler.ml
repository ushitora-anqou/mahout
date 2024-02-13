let get_deploy_name mastodon_name = function
  | `Web -> mastodon_name ^ "-web"
  | `Sidekiq -> mastodon_name ^ "-sidekiq"
  | `Streaming -> mastodon_name ^ "-streaming"
  | `Gateway -> mastodon_name ^ "-gateway-nginx"

let get_svc_name mastodon_name = function
  | `Web -> mastodon_name ^ "-web"
  | `Streaming -> mastodon_name ^ "-streaming"
  | `Gateway -> mastodon_name ^ "-gateway"

let get_job_name mastodon_name = function
  | `Migration -> mastodon_name ^ "-migration"

let get_deployment_selector ~kind =
  let name, component =
    match kind with
    | `Sidekiq -> ("sidekiq", "sidekiq")
    | `Web -> ("puma", "web")
    | `Streaming -> ("node", "streaming")
    | `Gateway -> ("nginx", "gateway")
  in
  [
    ("app.kubernetes.io/name", `String name);
    ("app.kubernetes.io/component", `String component);
    ("app.kubernetes.io/part-of", `String "mastodon");
  ]

let get_deployment_labels ~mastodon_name ~deploy_image ~kind =
  let selector = get_deployment_selector ~kind in
  let labels =
    Label.(
      (mastodon_key, `String mastodon_name)
      :: (deploy_image_key, `String (encode_deploy_image deploy_image))
      :: selector)
  in
  (selector, labels)

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

let running_pod_namespace =
  Sys.getenv_opt "POD_NAMESPACE" |> Option.value ~default:""

let get_running_pod ~sw client =
  let name = Sys.getenv "POD_NAME" in
  K.Pod.get ~sw client ~name ~namespace:running_pod_namespace ()
  |> Result.get_ok

let create_or_update_deployment ~sw client ~name ~namespace body =
  K.Deployment.create_or_update ~sw client ~name ~namespace @@ function
  | None -> body
  | Some body0 ->
      {
        body0 with
        spec =
          Some
            {
              (Option.get body0.spec) with
              template =
                {
                  metadata =
                    Some
                      {
                        (Option.get (Option.get body0.spec).template.metadata) with
                        labels =
                          (Option.get (Option.get body.spec).template.metadata)
                            .labels;
                      };
                  spec =
                    Some
                      {
                        (Option.get (Option.get body0.spec).template.spec) with
                        init_containers =
                          List.combine
                            (Option.get (Option.get body0.spec).template.spec)
                              .init_containers
                            (Option.get (Option.get body.spec).template.spec)
                              .init_containers
                          |> List.map
                               (fun
                                 ((c : K.Container.t), (c' : K.Container.t)) ->
                                 { c with image = c'.image });
                        containers =
                          List.combine
                            (Option.get (Option.get body0.spec).template.spec)
                              .containers
                            (Option.get (Option.get body.spec).template.spec)
                              .containers
                          |> List.map
                               (fun
                                 ((c : K.Container.t), (c' : K.Container.t)) ->
                                 { c with image = c'.image });
                      };
                };
            };
      }

let create_or_update_mastodon_service ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) ~kind =
  let ( let* ) = Result.bind in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let svc_name = get_svc_name name kind in
  let owner_references = get_owner_references mastodon in
  let selector = get_deployment_selector ~kind in

  let port = match kind with `Web -> 3000l | `Streaming -> 4000l in
  let body =
    K.Service.make
      ~metadata:
        (K.Object_meta.make ~name:svc_name ~namespace ~owner_references ())
      ~spec:
        (K.Service_spec.make ~selector:(`Assoc selector)
           ~ports:[ K.Service_port.make ~port () ]
           ())
      ()
  in
  let* _ =
    K.Service.create_or_update ~sw client ~name:svc_name ~namespace (fun _ ->
        body)
    |> Result.map_error K.show_error
  in

  Ok ()

let create_or_update_mastodon_deployment ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) ~image ~kind =
  let ( let* ) = Result.bind in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let env_from = (Option.get mastodon.spec).env_from in

  let deploy_name = get_deploy_name name kind in
  let selector, labels =
    get_deployment_labels ~mastodon_name:name ~deploy_image:image ~kind
  in
  let owner_references = get_owner_references mastodon in

  let container =
    let open K.Container in
    match kind with
    | `Sidekiq ->
        make ~name:"sidekiq" ~image
          ~command:[ "bash"; "-c"; "bundle exec sidekiq" ]
          ~env_from ()
    | `Streaming ->
        make ~name:"streaming" ~image
          ~command:[ "bash"; "-c"; "node ./streaming" ]
          ~env_from
          ~ports:
            K.Container_port.
              [
                make ~name:"streaming" ~container_port:4000l ~protocol:"TCP" ();
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
          ()
    | `Web ->
        make ~name:"web" ~image
          ~command:[ "bash"; "-c"; "bundle exec puma -C config/puma.rb" ]
          ~env_from
          ~ports:
            K.Container_port.
              [ make ~name:"http" ~container_port:3000l ~protocol:"TCP" () ]
          ~liveness_probe:
            (K.Probe.make
               ~tcp_socket:(K.Tcp_socket_action.make ~port:"http" ())
               ())
          ~readiness_probe:
            (K.Probe.make
               ~http_get:
                 (K.Http_get_action.make ~path:"/health" ~port:"http" ())
               ())
          ~startup_probe:
            (K.Probe.make
               ~http_get:
                 (K.Http_get_action.make ~path:"/health" ~port:"http" ())
               ~failure_threshold:30l ~period_seconds:5l ())
          ()
  in

  let body =
    K.Deployment.make
      ~metadata:
        (K.Object_meta.make ~name:deploy_name ~namespace ~owner_references ())
      ~spec:
        K.Deployment_spec.(
          make ~replicas:1l
            ~selector:(K.Label_selector.make ~match_labels:(`Assoc selector) ())
            ~template:
              (K.Pod_template_spec.make
                 ~metadata:(K.Object_meta.make ~labels:(`Assoc labels) ())
                 ~spec:(K.Pod_spec.make ~containers:[ container ] ())
                 ())
            ())
      ()
  in

  let* _ =
    create_or_update_deployment ~sw client ~name:deploy_name ~namespace body
    |> Result.map_error K.show_error
  in

  Ok ()

let create_or_update_gateway ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) ~image
    ~gw_nginx_conf_templ_cm =
  let ( let* ) = Result.bind in

  let nginx_image = "nginx:1.25.3" in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let nginx_conf_template_cm_name = fst gw_nginx_conf_templ_cm in
  let nginx_conf_template_cm_namespace = snd gw_nginx_conf_templ_cm in
  let nginx_conf_template_cm_key = "nginx.conf" in

  let nginx_conf_cm_name = name ^ "-gateway-nginx-conf" in
  let nginx_conf_cm_key = "mastodon-nginx.conf" in
  let nginx_deploy_name = get_deploy_name name `Gateway in
  let svc_name = get_svc_name name `Gateway in
  let selector, labels =
    get_deployment_labels ~kind:`Gateway ~mastodon_name:name ~deploy_image:image
  in

  let server_name = (Option.get mastodon.spec).server_name in

  let owner_references = get_owner_references mastodon in

  let* nginx_conf_template_cm =
    K.Config_map.get ~sw client ~name:nginx_conf_template_cm_name
      ~namespace:nginx_conf_template_cm_namespace ()
    |> Result.map_error K.show_error
  in
  let* nginx_conf_template =
    try
      nginx_conf_template_cm.data |> Yojson.Safe.Util.to_assoc
      |> List.assoc nginx_conf_template_cm_key
      |> Yojson.Safe.Util.to_string |> Result.ok
    with _ ->
      Error
        (Printf.sprintf "nginxConfTemplateConfigMap doesn't have correct %s"
           nginx_conf_template_cm_key)
  in

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
                (nginx_conf_template
                |> Jingoo.Jg_template.from_string
                     ~models:
                       [
                         ("web_svc_name", Tstr (get_svc_name name `Web));
                         ( "streaming_svc_name",
                           Tstr (get_svc_name name `Streaming) );
                         ("server_name", Tstr server_name);
                         ("namespace", Tstr namespace);
                       ]) );
          ])
      ()
  in
  let* _ =
    K.Config_map.create_or_update ~sw client ~name:nginx_conf_cm_name ~namespace
      (fun _ -> body)
    |> Result.map_error K.show_error
  in

  let pod_spec =
    let open K.Pod_spec in
    make
      ~init_containers:
        K.Container.
          [
            make ~name:"copy-assets" ~image
              ~command:
                [ "bash"; "-c"; "cp -ra /opt/mastodon/public/* /mnt/public/" ]
              ~volume_mounts:
                K.Volume_mount.
                  [ make ~mount_path:"/mnt/public" ~name:"mnt-public" () ]
              ();
          ]
      ~containers:
        K.Container.
          [
            make ~name:"gateway" ~image:nginx_image
              ~ports:K.Container_port.[ make ~container_port:80l () ]
              ~volume_mounts:
                K.Volume_mount.
                  [
                    make ~mount_path:"/mnt/public" ~name:"mnt-public"
                      ~read_only:true ();
                    make ~mount_path:"/etc/nginx/conf.d" ~name:"nginx-conf"
                      ~read_only:true ();
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
                        [ make ~key:nginx_conf_cm_key ~path:"mastodon.conf" () ]
                    ())
              ();
          ]
      ()
  in
  let body =
    K.Deployment.make ~api_version:"apps/v1" ~kind:"Deployment"
      ~metadata:
        (K.Object_meta.make ~name:nginx_deploy_name ~namespace ~owner_references
           ())
      ~spec:
        K.Deployment_spec.(
          make ~replicas:1l
            ~selector:(K.Label_selector.make ~match_labels:(`Assoc selector) ())
            ~template:
              (K.Pod_template_spec.make
                 ~metadata:(K.Object_meta.make ~labels:(`Assoc labels) ())
                 ~spec:pod_spec ())
            ())
      ()
  in
  let* _ =
    create_or_update_deployment ~sw client ~name:nginx_deploy_name ~namespace
      body
    |> Result.map_error K.show_error
  in

  let body =
    K.Service.make
      ~metadata:
        (K.Object_meta.make ~name:svc_name ~namespace ~owner_references ())
      ~spec:
        (K.Service_spec.make ~selector:(`Assoc selector)
           ~ports:[ K.Service_port.make ~port:80l () ]
           ())
      ()
  in
  let* _ =
    K.Service.create_or_update ~sw client ~name:svc_name ~namespace (fun _ ->
        body)
    |> Result.map_error K.show_error
  in

  Ok ()

let update_mastodon_status ~sw client ~name ~namespace f =
  let ( let* ) = Result.bind in
  let* mastodon = Mastodon.get ~sw client ~name ~namespace () in
  let status =
    match mastodon.status with
    | None -> Net_anqou_mahout.V1alpha1.Mastodon.Status.make ()
    | Some status -> status
  in
  let status = f status in
  Mastodon.update_status ~sw client { mastodon with status = Some status }

let create_or_update_deployments ~sw client ~mastodon ~image
    ~gw_nginx_conf_templ_cm =
  let ( let* ) = Result.bind in
  let deploy =
    create_or_update_mastodon_deployment ~sw client ~mastodon ~image
  in
  let svc = create_or_update_mastodon_service ~sw client ~mastodon in
  let* _ =
    create_or_update_gateway ~sw client ~mastodon ~image ~gw_nginx_conf_templ_cm
  in
  let* _ = deploy ~kind:`Web in
  let* _ = deploy ~kind:`Sidekiq in
  let* _ = deploy ~kind:`Streaming in
  let* _ = svc ~kind:`Web in
  let* _ = svc ~kind:`Streaming in
  Ok ()

let image_of_deployment (deploy : K.Deployment.t) =
  let pod_spec = Option.get (Option.get deploy.spec).template.spec in
  let containers =
    match pod_spec.init_containers with
    | [] -> pod_spec.containers
    | _ -> pod_spec.init_containers
  in
  Option.get (List.hd containers).image

let fetch_deployments_image ~sw client ~name ~namespace =
  let fetch_deploy_image kind =
    K.Deployment.get ~sw client ~namespace ~name:(get_deploy_name name kind) ()
    |> Result.map image_of_deployment
    |> Result.map_error (fun (e : K.error) -> `K e)
  in

  let ( let* ) = Result.bind in
  let* image0 = fetch_deploy_image `Gateway in
  let* image1 = fetch_deploy_image `Web in
  let* image2 = fetch_deploy_image `Sidekiq in
  let* image3 = fetch_deploy_image `Streaming in

  if image0 = image1 && image1 = image2 && image2 = image3 then Ok image0
  else Error `NotCommon

let get_deployments_pod_statuses ~sw client ~name ~namespace ~image =
  let ( let* ) = Result.bind in

  let image_label_value = Label.encode_deploy_image image in

  let* all_pods =
    K.Pod.list ~sw client ~namespace
      ~label_selector:
        Label_selector.
          [ Eq (Label.mastodon_key, name); Exist Label.deploy_image_key ]
      ()
  in

  let* live_pods =
    K.Pod.list ~sw client ~namespace
      ~label_selector:
        Label_selector.
          [
            Eq (Label.mastodon_key, name);
            Eq (Label.deploy_image_key, image_label_value);
          ]
      ()
  in
  let live_pods =
    live_pods
    |> List.filter (fun (p : K.Pod.t) ->
           (Option.get p.status).phase = Some "Running")
  in

  Ok
    (if List.length all_pods = List.length live_pods then `Ready image
     else `NotReady image)

let get_deployments_status ~sw client ~name ~namespace =
  match fetch_deployments_image ~sw client ~name ~namespace with
  | Error (`K `Not_found) -> Ok `NotFound
  | Error (`K e) -> Error e
  | Error `NotCommon -> Ok `NotCommon
  | Ok image -> get_deployments_pod_statuses ~sw client ~name ~namespace ~image

let get_migration_job_status ~sw client ~name ~namespace =
  match
    K.Job.get ~sw client ~name:(get_job_name name `Migration) ~namespace ()
  with
  | Error `Not_found -> Ok `NotFound
  | Error e -> Error e
  | Ok j when (Option.get j.status).succeeded = Some 1l -> Ok `Completed
  | Ok _ -> Ok `NotCompleted

let delete_migration_job ~sw client ~(mastodon : Mastodon.t) =
  let ( let* ) = Result.bind in
  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let job_name = get_job_name name `Migration in
  let* _ = K.Job.delete ~sw client ~name:job_name ~namespace () in
  Ok ()

let create_migration_job ~sw client ~(mastodon : Mastodon.t) ~image ~kind =
  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let env_from = (Option.get mastodon.spec).env_from in
  let owner_references = get_owner_references mastodon in
  let job_name = get_job_name name `Migration in

  let env =
    match kind with
    | `Post -> []
    | `Pre ->
        K.Env_var.
          [ make ~name:"SKIP_POST_DEPLOYMENT_MIGRATIONS" ~value:"true" () ]
  in

  let body =
    K.Job.make
      ~metadata:
        (K.Object_meta.make ~name:job_name ~namespace ~owner_references ())
      ~spec:
        (K.Job_spec.make
           ~template:
             (K.Pod_template_spec.make
                ~spec:
                  (K.Pod_spec.make ~restart_policy:"OnFailure"
                     ~containers:
                       K.Container.
                         [
                           make ~name:"migration" ~image ~env_from ~env
                             ~command:
                               [
                                 "bash";
                                 "-c";
                                 "bundle exec rake db:create;\n\
                                  bundle exec rake db:migrate";
                               ]
                             ();
                         ]
                     ())
                ())
           ())
      ()
  in
  K.Job.create ~sw client body

type current_state =
  | NoDeployments
  | StartPreMigration
  | RolloutDeployments
  | StartPostMigration
  | PostMigrationCompleted
  | Migrating
  | Normal
[@@deriving show]

let reconcile ~sw client ~name ~namespace ~gw_nginx_conf_templ_cm_name =
  let ( let* ) = Result.bind in
  Logg.info (fun m ->
      m "reconcile" [ ("name", `String name); ("namespace", `String namespace) ]);

  let* mastodon =
    Mastodon.get ~sw client ~name ~namespace () |> Result.map_error K.show_error
  in
  let* _ =
    match (Option.get mastodon.metadata).deletion_timestamp with
    | None -> Ok ()
    | Some _ -> Error "Mastodon resource already deleted"
  in

  let gw_nginx_conf_templ_cm =
    (gw_nginx_conf_templ_cm_name, running_pod_namespace)
  in

  let spec = Option.get mastodon.spec in
  let spec_image = spec.image in
  let migrating_image =
    match mastodon.status with
    | None -> None
    | Some status -> status.migrating_image
  in
  let* deployments_status =
    get_deployments_status ~sw client ~name ~namespace
    |> Result.map_error K.show_error
  in
  let* migration_job_status =
    get_migration_job_status ~sw client ~name ~namespace
    |> Result.map_error K.show_error
  in

  let current_state =
    if deployments_status = `NotFound then NoDeployments
    else if
      Option.is_none migrating_image
      && migration_job_status = `NotFound
      &&
      match deployments_status with
      | `Ready image when image <> spec_image -> true
      | _ -> false
    then StartPreMigration
    else if
      Option.is_some migrating_image
      && migration_job_status = `NotFound
      &&
      match deployments_status with
      | `Ready image when image <> Option.get migrating_image -> true
      | _ -> false
    then StartPreMigration
    else if
      Option.is_some migrating_image
      && migration_job_status = `Completed
      &&
      match deployments_status with
      | `NotCommon -> (* Case when the previous deployment was cancelled *) true
      | `Ready image when image <> Option.get migrating_image -> true
      | _ -> false
    then RolloutDeployments
    else if
      Option.is_some migrating_image
      && migration_job_status = `NotFound
      && deployments_status = `Ready (Option.get migrating_image)
    then StartPostMigration
    else if
      Option.is_some migrating_image
      && migration_job_status = `Completed
      && deployments_status = `Ready (Option.get migrating_image)
    then PostMigrationCompleted
    else if Option.is_some migrating_image then Migrating
    else Normal
  in

  Logg.info (fun m ->
      m "reconcile"
        [
          ("spec_image", `String spec_image);
          ( "migration_image",
            `String (migrating_image |> Option.value ~default:"") );
          ( "deployments_status",
            `String
              (match deployments_status with
              | `NotFound -> "NotFound"
              | `NotCommon -> "NotCommon"
              | `NotReady s -> "NotReady " ^ s
              | `Ready s -> "Ready " ^ s) );
          ( "migration_job_status",
            `String
              (match migration_job_status with
              | `NotFound -> "NotFound"
              | `Completed -> "Completed"
              | `NotCompleted -> "NotCompleted") );
          ("current_state", `String (show_current_state current_state));
        ]);

  match current_state with
  | NoDeployments ->
      let* _ =
        update_mastodon_status ~sw client ~name ~namespace (fun status ->
            { status with migrating_image = Some spec_image })
        |> Result.map_error K.show_error
      in
      let* _ =
        create_migration_job ~sw client ~mastodon ~image:spec_image ~kind:`Post
        |> Result.map_error K.show_error
      in
      let* _ =
        create_or_update_deployments ~sw client ~mastodon ~image:spec_image
          ~gw_nginx_conf_templ_cm
      in
      Ok ()
  | StartPreMigration ->
      let* _ =
        update_mastodon_status ~sw client ~name ~namespace (fun status ->
            {
              status with
              migrating_image =
                (match migrating_image with
                | Some x -> Some x
                | None -> Some spec_image);
            })
        |> Result.map_error K.show_error
      in
      let* _ =
        create_migration_job ~sw client ~mastodon ~image:spec_image ~kind:`Pre
        |> Result.map_error K.show_error
      in
      Ok ()
  | RolloutDeployments ->
      let* _ =
        delete_migration_job ~sw client ~mastodon
        |> Result.map_error K.show_error
      in
      let* _ =
        create_or_update_deployments ~sw client ~mastodon
          ~image:(Option.get migrating_image)
          ~gw_nginx_conf_templ_cm
      in
      Ok ()
  | StartPostMigration ->
      let* _ =
        create_migration_job ~sw client ~mastodon ~image:spec_image ~kind:`Post
        |> Result.map_error K.show_error
      in
      Ok ()
  | PostMigrationCompleted ->
      let* _ =
        delete_migration_job ~sw client ~mastodon
        |> Result.map_error K.show_error
      in
      let* _ =
        update_mastodon_status ~sw client ~name ~namespace (fun status ->
            { status with migrating_image = None })
        |> Result.map_error K.show_error
      in
      Ok ()
  | Migrating -> Ok ()
  | Normal ->
      create_or_update_deployments ~sw client ~mastodon ~image:spec_image
        ~gw_nginx_conf_templ_cm

let find_mastodon_from_job ~sw:_ _client (job : K.Job.t) =
  let ( let* ) = Option.bind in
  let* metadata = job.metadata in
  let* owner_reference =
    metadata.owner_references
    |> List.find_opt (fun (r : K.Owner_reference.t) ->
           r.api_version = "mahout.anqou.net/v1alpha1"
           && r.kind = "Mastodon" && r.controller = Some true)
  in
  let name = owner_reference.name in
  let* namespace = metadata.namespace in
  Some (name, namespace)

let find_mastodon_from_pod ~sw:_ _client (pod : K.Pod.t) =
  let ( let* ) = Option.bind in
  let* metadata = pod.metadata in
  let* labels = match metadata.labels with `Assoc l -> Some l | _ -> None in
  match labels |> List.assoc_opt Label.mastodon_key with
  | Some (`String name) -> Some (name, Option.get metadata.namespace)
  | _ -> None
