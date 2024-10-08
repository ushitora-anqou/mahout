type deploy_image_map = {
  gateway_image : string;
  web_image : string;
  sidekiq_image : string;
  streaming_image : string;
}
[@@deriving yojson]

let ignore_not_found_error = function
  | Ok _ | Error `Not_found -> Ok ()
  | e -> e

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
  | `PreMigration -> mastodon_name ^ "-pre-migration"
  | `PostMigration -> mastodon_name ^ "-post-migration"

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

let get_running_pod client =
  let name = Sys.getenv "POD_NAME" in
  K.Pod.get client ~name ~namespace:running_pod_namespace () |> Result.get_ok

let create_or_update_mastodon_service client
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
    K.Service.create_or_update client ~name:svc_name ~namespace (fun _ -> body)
    |> Result.map_error K.show_error
  in

  Ok ()

let create_or_update_mastodon_deployment client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) ~image_map ~kind =
  let ( let* ) = Result.bind in

  let spec = Option.get mastodon.spec in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let env_from = spec.env_from in

  let image =
    match kind with
    | `Sidekiq -> image_map.sidekiq_image
    | `Streaming -> image_map.streaming_image
    | `Web -> image_map.web_image
  in

  let deploy_name = get_deploy_name name kind in
  let selector, labels =
    get_deployment_labels ~mastodon_name:name ~deploy_image:image ~kind
  in
  let owner_references = get_owner_references mastodon in

  let replicas =
    match kind with
    | `Sidekiq -> (Option.get spec.sidekiq).replicas
    | `Streaming -> (Option.get spec.streaming).replicas
    | `Web -> (Option.get spec.web).replicas
  in
  let replicas = Option.value ~default:1l replicas in

  let deploy_annotations =
    (match kind with
    | `Web -> (spec.web |> Option.get).annotations
    | `Sidekiq -> (spec.sidekiq |> Option.get).annotations
    | `Streaming -> (spec.streaming |> Option.get).annotations)
    |> Option.fold ~none:[] ~some:Yojson.Safe.Util.to_assoc
  in
  let deploy_annotations = `Assoc deploy_annotations in

  let pod_annotations old =
    let annotations = match old with `Assoc x -> x | _ -> [] in
    match
      List.assoc_opt kind
        [
          (`Web, Label.web_restart_time_key);
          (`Sidekiq, Label.sidekiq_restart_time_key);
        ]
    with
    | None -> `Assoc annotations
    | Some label ->
        let annotations = List.remove_assoc label annotations in
        let annotations =
          match
            (Option.get mastodon.metadata).annotations
            |> Yojson.Safe.Util.to_assoc |> List.assoc_opt label
          with
          | None -> annotations
          | Some restartTime -> (label, restartTime) :: annotations
        in
        `Assoc annotations
  in

  let resources =
    match kind with
    | `Sidekiq -> (
        match spec.sidekiq with None -> None | Some x -> x.resources)
    | `Streaming -> (
        match spec.streaming with None -> None | Some x -> x.resources)
    | `Web -> ( match spec.web with None -> None | Some x -> x.resources)
  in

  let container =
    let open K.Container in
    match kind with
    | `Sidekiq ->
        make ~name:"sidekiq" ~image ?resources
          ~command:[ "bash"; "-c"; "bundle exec sidekiq" ]
          ~env_from ()
    | `Streaming ->
        make ~name:"streaming" ~image ?resources
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
        make ~name:"web" ~image ?resources
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

  let* _ =
    K.Deployment.create_or_update client ~name:deploy_name ~namespace (fun d ->
        K.Deployment.with_ d
          ~metadata:(fun x ->
            Some
              (K.Object_meta.with_ x
                 ~name:(fun _ -> Some deploy_name)
                 ~namespace:(fun _ -> Some namespace)
                 ~owner_references:(fun _ -> owner_references)
                 ~annotations:(fun _ -> deploy_annotations)
                 ()))
          ~spec:(fun x ->
            Some
              (K.Deployment_spec.with_ x
                 ~replicas:(fun _ -> Some replicas)
                 ~selector:(fun _ ->
                   K.Label_selector.make ~match_labels:(`Assoc selector) ())
                 ~template:(fun x ->
                   K.Pod_template_spec.with_
                     ~metadata:(fun x ->
                       Some
                         (K.Object_meta.with_ x
                            ~labels:(fun _ -> `Assoc labels)
                            ~annotations:pod_annotations ()))
                     ~spec:(fun x ->
                       Some
                         (K.Pod_spec.with_ x
                            ~containers:(fun _ -> [ container ])
                            ()))
                     x ())
                 ()))
          ())
    |> Result.map_error K.show_error
  in

  Ok ()

let create_or_update_gateway client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) ~image
    ~gw_nginx_conf_templ_cm =
  let ( let* ) = Result.bind in

  let nginx_image = (Option.get mastodon.spec).gateway.image in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let nginx_conf_template_cm_name = fst gw_nginx_conf_templ_cm in
  let nginx_conf_template_cm_namespace = snd gw_nginx_conf_templ_cm in
  let nginx_conf_template_cm_key = "nginx.conf" in

  let nginx_conf_cm_name_prefix = name ^ "-gateway-nginx-conf" in
  let nginx_conf_cm_key = "mastodon-nginx.conf" in
  let nginx_deploy_name = get_deploy_name name `Gateway in
  let svc_name = get_svc_name name `Gateway in
  let selector, labels =
    get_deployment_labels ~kind:`Gateway ~mastodon_name:name ~deploy_image:image
  in

  let server_name = (Option.get mastodon.spec).server_name in

  let owner_references = get_owner_references mastodon in

  let* nginx_conf_template_cm =
    K.Config_map.get client ~name:nginx_conf_template_cm_name
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
  let nginx_conf_body =
    nginx_conf_template
    |> Jingoo.Jg_template.from_string
         ~models:
           [
             ("web_svc_name", Tstr (get_svc_name name `Web));
             ("streaming_svc_name", Tstr (get_svc_name name `Streaming));
             ("server_name", Tstr server_name);
             ("namespace", Tstr namespace);
           ]
  in
  let nginx_conf_cm_name_short_hash =
    String.sub (nginx_conf_body |> Sha256.string |> Sha256.to_hex) 0 8
  in
  let nginx_conf_cm_name =
    nginx_conf_cm_name_prefix ^ "-" ^ nginx_conf_cm_name_short_hash
  in

  let replicas =
    (Option.get mastodon.spec).gateway.replicas |> Option.value ~default:1l
  in

  let deploy_annotations =
    (mastodon.spec |> Option.get).gateway.annotations
    |> Option.fold ~none:[] ~some:Yojson.Safe.Util.to_assoc
  in
  let deploy_annotations = `Assoc deploy_annotations in

  let body =
    K.Config_map.make
      ~metadata:
        (K.Object_meta.make ~name:nginx_conf_cm_name ~namespace
           ~owner_references
           ~labels:
             (`Assoc
               [
                 (Label.mastodon_key, `String name);
                 ( Label.nginx_conf_cm_hash_key,
                   `String nginx_conf_cm_name_short_hash );
               ])
           ())
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
    K.Config_map.create_or_update client ~name:nginx_conf_cm_name ~namespace
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
              ?resources:(mastodon.spec |> Option.get).gateway.resources
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
  let* _ =
    K.Deployment.create_or_update client ~name:nginx_deploy_name ~namespace
      (fun x ->
        K.Deployment.with_ x
          ~metadata:(fun x ->
            Some
              (K.Object_meta.with_ x
                 ~name:(fun _ -> Some nginx_deploy_name)
                 ~namespace:(fun _ -> Some namespace)
                 ~owner_references:(fun _ -> owner_references)
                 ~annotations:(fun _ -> deploy_annotations)
                 ()))
          ~spec:(fun x ->
            Some
              (K.Deployment_spec.with_ x
                 ~replicas:(fun _ -> Some replicas)
                 ~selector:(fun _ ->
                   K.Label_selector.make ~match_labels:(`Assoc selector) ())
                 ~template:(fun x ->
                   K.Pod_template_spec.with_ x
                     ~metadata:(fun x ->
                       Some
                         (K.Object_meta.with_ x
                            ~labels:(fun _ -> `Assoc labels)
                            ()))
                     ~spec:(fun _ -> Some pod_spec)
                     ())
                 ()))
          ())
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
    K.Service.create_or_update client ~name:svc_name ~namespace (fun _ -> body)
    |> Result.map_error K.show_error
  in

  (* Drop unnecessary configmaps *)
  let* unnecessary_cms =
    K.Config_map.list client ~namespace
      ~label_selector:
        Label_selector.
          [
            Eq (Label.mastodon_key, name);
            Exist Label.nginx_conf_cm_hash_key;
            NotEq (Label.nginx_conf_cm_hash_key, nginx_conf_cm_name_short_hash);
          ]
      ()
    |> Result.map_error K.show_error
  in
  let* () =
    unnecessary_cms
    |> List.fold_left
         (fun e (cm : K.Config_map.t) ->
           let* _ = e in
           let metadata = Option.get cm.metadata in
           let name = Option.get metadata.name in
           let namespace = Option.get metadata.namespace in
           let uid = Option.get metadata.uid in
           Logg.info (fun m ->
               m "deleting unnecessary gateway cm"
                 [ ("name", `String name); ("namespace", `String namespace) ]);
           K.Config_map.delete client ~name ~namespace ~uid ()
           |> ignore_not_found_error
           |> Result.map_error K.show_error)
         (Ok ())
  in

  Ok ()

let create_or_update_restart_rbac client ~(mastodon : Mastodon.t)
    ~service_account_name =
  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let owner_references = get_owner_references mastodon in

  let role_name = Printf.sprintf "%s-restart" name in
  let role_binding_name = Printf.sprintf "%s-restart" name in

  let ( let* ) = Result.bind in
  let* _ =
    K.Role.create_or_update client ~name:role_name ~namespace (fun _ ->
        K.Role.make
          ~metadata:
            (K.Object_meta.make ~name:role_name ~namespace ~owner_references ())
          ~rules:
            [
              K.Policy_rule.make ~api_groups:[ "mahout.anqou.net" ]
                ~resources:[ "mastodons" ] ~resource_names:[ name ]
                ~verbs:
                  [
                    "create";
                    "delete";
                    "get";
                    "list";
                    "patch";
                    "update";
                    "watch";
                  ]
                ();
            ]
          ())
    |> Result.map_error K.show_error
  in

  let* _ =
    K.Role_binding.create_or_update client ~name:role_binding_name ~namespace
      (fun _ ->
        K.Role_binding.make
          ~metadata:
            (K.Object_meta.make ~name:role_binding_name ~namespace
               ~owner_references ())
          ~subjects:
            [
              K.Subject.make ~kind:"ServiceAccount" ~namespace
                ~name:service_account_name ();
            ]
          ~role_ref:
            (K.Role_ref.make ~api_group:"rbac.authorization.k8s.io" ~kind:"Role"
               ~name:role_name)
          ())
    |> Result.map_error K.show_error
  in

  Ok ()

let create_or_update_restart_cronjob client ~(mastodon : Mastodon.t)
    ~service_account_name kind =
  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let owner_references = get_owner_references mastodon in

  let operator_pod = get_running_pod client in
  let image =
    ((operator_pod.spec |> Option.get).containers |> List.hd).image
    |> Option.get
  in

  let cronjob_name =
    Printf.sprintf "%s-restart-%s" name
      (match kind with `Web -> "web" | `Sidekiq -> "sidekiq")
  in
  let suspend, schedule =
    match
      let ( let* ) = Option.bind in
      let* spec = mastodon.spec in
      match kind with
      | `Web ->
          let* s = spec.web in
          let* p = s.periodic_restart in
          p.schedule
      | `Sidekiq ->
          let* s = spec.sidekiq in
          let* p = s.periodic_restart in
          p.schedule
    with
    | None -> (true, None)
    | Some sched -> (false, Some sched)
  in
  let schedule = schedule |> Option.value ~default:"0 0 * * *" in

  let target = match kind with `Web -> "web" | `Sidekiq -> "sidekiq" in

  let args =
    [ "restart"; "--name"; name; "--namespace"; namespace; "--target"; target ]
  in

  let body =
    K.Cron_job.make
      ~metadata:
        (K.Object_meta.make ~name:cronjob_name ~namespace ~owner_references ())
      ~spec:
        (K.Cron_job_spec.make ~schedule ~suspend
           ~job_template:
             (K.Job_template_spec.make
                ~spec:
                  (K.Job_spec.make
                     ~template:
                       (K.Pod_template_spec.make
                          ~spec:
                            (K.Pod_spec.make ~service_account_name
                               ~restart_policy:"OnFailure"
                               ~containers:
                                 [
                                   K.Container.make ~name:"restart" ~image ~args
                                     ();
                                 ]
                               ())
                          ())
                     ())
                ())
           ())
      ()
  in
  K.Cron_job.create_or_update client ~name:cronjob_name ~namespace (function
    | None -> body
    | Some body0 -> { body0 with spec = body.spec })
  |> Result.map_error K.show_error

let create_or_update_stuff client ~mastodon ~image_map ~gw_nginx_conf_templ_cm =
  let ( let* ) = Result.bind in
  let service_account_name = "default" in
  let deploy =
    create_or_update_mastodon_deployment client ~mastodon ~image_map
  in
  let svc = create_or_update_mastodon_service client ~mastodon in
  let* _ =
    create_or_update_gateway client ~mastodon ~image:image_map.gateway_image
      ~gw_nginx_conf_templ_cm
  in
  let* _ = deploy ~kind:`Web in
  let* _ = deploy ~kind:`Sidekiq in
  let* _ = deploy ~kind:`Streaming in
  let* _ = svc ~kind:`Web in
  let* _ = svc ~kind:`Streaming in
  let* _ =
    create_or_update_restart_rbac client ~mastodon ~service_account_name
  in
  let cronjob =
    create_or_update_restart_cronjob client ~mastodon ~service_account_name
  in
  let* _ = cronjob `Web in
  let* _ = cronjob `Sidekiq in
  Ok ()

let image_of_deployment (deploy : K.Deployment.t) =
  let pod_spec = Option.get (Option.get deploy.spec).template.spec in
  let containers =
    match pod_spec.init_containers with
    | [] -> pod_spec.containers
    | _ -> pod_spec.init_containers
  in
  Option.get (List.hd containers).image

let fetch_deployments_images client ~name ~namespace =
  let fetch_deploy_image kind =
    K.Deployment.get client ~namespace ~name:(get_deploy_name name kind) ()
    |> Result.map image_of_deployment
    |> Result.map_error (fun (e : K.error) -> `K e)
  in

  let ( let* ) = Result.bind in
  let* gateway_image = fetch_deploy_image `Gateway in
  let* web_image = fetch_deploy_image `Web in
  let* sidekiq_image = fetch_deploy_image `Sidekiq in
  let* streaming_image = fetch_deploy_image `Streaming in

  Ok { gateway_image; web_image; sidekiq_image; streaming_image }

let get_deployments_pod_statuses client ~name ~namespace ~image_map =
  let ( let* ) = Result.bind in

  let* all_pods =
    K.Pod.list client ~namespace
      ~label_selector:
        Label_selector.
          [ Eq (Label.mastodon_key, name); Exist Label.deploy_image_key ]
      ()
  in

  let* live_pods =
    K.Pod.list client ~namespace
      ~label_selector:
        Label_selector.
          [
            Eq (Label.mastodon_key, name);
            In
              ( Label.deploy_image_key,
                [
                  Label.encode_deploy_image image_map.gateway_image;
                  Label.encode_deploy_image image_map.streaming_image;
                  Label.encode_deploy_image image_map.sidekiq_image;
                  Label.encode_deploy_image image_map.web_image;
                ] );
          ]
      ()
  in
  let live_pods =
    live_pods
    |> List.filter (fun (p : K.Pod.t) ->
           (Option.get p.status).phase = Some "Running")
  in

  Ok
    (if List.length all_pods = List.length live_pods then `Ready image_map
     else `NotReady image_map)

let get_deployments_status client ~name ~namespace =
  match fetch_deployments_images client ~name ~namespace with
  | Error (`K `Not_found) -> Ok `NotFound
  | Error (`K e) -> Error e
  | Ok image_map ->
      get_deployments_pod_statuses client ~name ~namespace ~image_map

let get_job_status client ~name ~namespace ~kind =
  match K.Job.get client ~name:(get_job_name name kind) ~namespace () with
  | Error `Not_found -> Ok `NotFound
  | Error e -> Error e
  | Ok j when (Option.get j.status).succeeded = Some 1l -> Ok `Completed
  | Ok j when (Option.get j.status).failed = Some 1l -> Ok `Failed
  | Ok _ -> Ok `NotCompleted

let string_of_job_status = function
  | `NotFound -> "NotFound"
  | `Completed -> "Completed"
  | `NotCompleted -> "NotCompleted"
  | `Failed -> "Failed"

let delete_job client ~(mastodon : Mastodon.t) ~kind =
  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let job_name = get_job_name name kind in
  K.Job.delete client ~name:job_name ~namespace ~propagation_policy:"Background"
    ()
  |> ignore_not_found_error
  |> Result.map_error K.show_error

let create_migration_job client ~(mastodon : Mastodon.t) ~image ~kind =
  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let env_from = (Option.get mastodon.spec).env_from in
  let owner_references = get_owner_references mastodon in
  let job_name =
    get_job_name name
      (match kind with `Pre -> `PreMigration | `Post -> `PostMigration)
  in

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
  K.Job.create client body

let int_of_state = function
  | `S1 -> 1
  | `S2 -> 2
  | `S5 -> 5
  | `S6 -> 6
  | `S7 -> 7
  | `S8 -> 8
  | `S9 -> 9
  | `S12 -> 12
  | `S13 -> 13
  | `S14 -> 14
  | `S15 -> 15
  | `S16 -> 16
  | `S20 -> 20
  | `S21 -> 21
  | `S22 -> 22
  | `S23 -> 23
  | `S26 -> 26
  | `S27 -> 27
  | `S28 -> 28
  | `S29 -> 29
  | `S30 -> 30
  | `S31 -> 31
  | `S32 -> 32
  | `S33 -> 33
  | `S34 -> 34

type reconcile_args = { gw_nginx_conf_templ_cm_name : string }

let reconcile client ~name ~namespace { gw_nginx_conf_templ_cm_name }
    (mastodon : Mastodon.t) =
  let ( let* ) = Result.bind in

  let gw_nginx_conf_templ_cm =
    (gw_nginx_conf_templ_cm_name, running_pod_namespace)
  in

  let spec = Option.get mastodon.spec in
  let spec_image =
    {
      gateway_image = spec.image;
      web_image = spec.image;
      sidekiq_image = spec.image;
      streaming_image =
        (match spec.streaming with
        | Some { image = Some image; _ } -> image
        | _ -> spec.image);
    }
  in
  let migrating_image_map =
    match mastodon.status with
    | Some
        {
          migrating_image = Some image;
          streaming = Some { migrating_image = Some streaming_image };
        } ->
        Some
          {
            gateway_image = image;
            web_image = image;
            sidekiq_image = image;
            streaming_image;
          }
    | _ -> None
  in
  let* deployments_status =
    get_deployments_status client ~name ~namespace
    |> Result.map_error K.show_error
  in
  let* pre_mig_job =
    get_job_status client ~name ~namespace ~kind:`PreMigration
    |> Result.map_error K.show_error
  in
  let* post_mig_job =
    get_job_status client ~name ~namespace ~kind:`PostMigration
    |> Result.map_error K.show_error
  in

  let current_state =
    match
      (pre_mig_job, post_mig_job, deployments_status, migrating_image_map)
    with
    | `NotFound, `NotFound, `NotFound, Some _ -> `S1
    | `NotFound, `NotFound, `NotFound, None -> `S2
    | `NotFound, `NotFound, (`Ready version | `NotReady version), Some mig ->
        if version = mig then `S5 else `S6
    | `NotFound, `NotFound, (`Ready version | `NotReady version), None ->
        if version = spec_image then `S7 else `S33
    | `NotFound, `Completed, `NotFound, Some _ -> `S8
    | `NotFound, `Completed, `NotFound, None -> `S9
    | `NotFound, `Completed, (`Ready version | `NotReady version), Some mig ->
        if version = mig then `S12 else `S13
    | `NotFound, `Completed, (`Ready _ | `NotReady _), None -> `S14
    | `Completed, `NotFound, `NotFound, Some _ -> `S15
    | `Completed, `NotFound, `NotFound, None -> `S16
    | `Completed, `NotFound, `Ready version, Some mig ->
        if version = mig then `S31 else `S20
    | `Completed, `NotFound, `NotReady version, Some mig ->
        if version = mig then `S32 else `S20
    | `Completed, `NotFound, (`Ready _ | `NotReady _), None -> `S21
    | `Completed, `Completed, `NotFound, Some _ -> `S22
    | `Completed, `Completed, `NotFound, None -> `S23
    | `Completed, `Completed, (`Ready version | `NotReady version), Some mig ->
        if version = mig then `S26 else `S27
    | `Completed, `Completed, (`Ready _ | `NotReady _), None -> `S28
    | `NotCompleted, _, _, _ | _, `NotCompleted, _, _ -> `S34
    | `Failed, _, _, _ -> `S29
    | _, `Failed, _, _ -> `S30
  in

  Logg.info (fun m ->
      m "reconcile"
        [
          ("spec_image", deploy_image_map_to_yojson spec_image);
          ( "migrating_image",
            match migrating_image_map with
            | None -> `Assoc []
            | Some x -> deploy_image_map_to_yojson x );
          ( "deployments_status",
            match deployments_status with
            | `NotFound -> `String "NotFound"
            | `NotReady s ->
                `List [ `String "NotReady"; deploy_image_map_to_yojson s ]
            | `Ready s ->
                `List [ `String "Ready"; deploy_image_map_to_yojson s ] );
          ("pre_mig_job", `String (string_of_job_status pre_mig_job));
          ("post_mig_job", `String (string_of_job_status post_mig_job));
          ("current_state", `Int (int_of_state current_state));
        ]);

  match current_state with
  | `S1 ->
      let* _ =
        create_migration_job client ~mastodon
          ~image:(Option.get migrating_image_map).web_image ~kind:`Post
        |> Result.map_error K.show_error
      in
      Ok ()
  | `S2 | `S33 ->
      let* _ =
        Mastodon.update_status client
          {
            mastodon with
            status =
              Some
                {
                  migrating_image = Some spec_image.web_image;
                  streaming =
                    Some { migrating_image = Some spec_image.streaming_image };
                };
          }
        |> Result.map_error K.show_error
      in
      Ok ()
  | `S5 ->
      let* _ =
        Mastodon.update_status client
          {
            mastodon with
            status =
              Some
                {
                  migrating_image = None;
                  streaming = Some { migrating_image = None };
                };
          }
        |> Result.map_error K.show_error
      in
      Ok ()
  | `S6 ->
      let* _ =
        create_migration_job client ~mastodon
          ~image:(Option.get migrating_image_map).web_image ~kind:`Pre
        |> Result.map_error K.show_error
      in
      Ok ()
  | `S7 ->
      let* _ =
        create_or_update_stuff client ~mastodon ~image_map:spec_image
          ~gw_nginx_conf_templ_cm
      in
      Ok ()
  | `S8 | `S20 | `S32 ->
      let* _ =
        create_or_update_stuff client ~mastodon
          ~image_map:(Option.get migrating_image_map)
          ~gw_nginx_conf_templ_cm
      in
      Ok ()
  | `S12 | `S30 ->
      let* _ = delete_job client ~mastodon ~kind:`PostMigration in
      Ok ()
  | `S31 ->
      let* _ =
        create_migration_job client ~mastodon
          ~image:(Option.get migrating_image_map).web_image ~kind:`Post
        |> Result.map_error K.show_error
      in
      Ok ()
  | `S26 | `S29 ->
      let* _ = delete_job client ~mastodon ~kind:`PreMigration in
      Ok ()
  | `S34 -> Ok ()
  | _ ->
      Logg.err (fun m ->
          m "unexpected current state"
            [ ("current_state", `Int (int_of_state current_state)) ]);
      Ok ()

let reconcile client ~name ~namespace args =
  Logg.info (fun m ->
      m "reconcile" [ ("name", `String name); ("namespace", `String namespace) ]);
  Fun.protect ~finally:(fun () ->
      Logg.info (fun m ->
          m "reconcile done"
            [ ("name", `String name); ("namespace", `String namespace) ]))
  @@ fun () ->
  match Mastodon.get client ~name ~namespace () with
  | Error `Not_found ->
      Logg.info (fun m ->
          m "Mastodon resource not found"
            [ ("name", `String name); ("namespace", `String namespace) ]);
      Ok ()
  | Error e -> Error (K.show_error e)
  | Ok mastodon -> (
      match (Option.get mastodon.metadata).deletion_timestamp with
      | Some _ -> Error "Mastodon resource already deleted"
      | None -> reconcile client ~name ~namespace args mastodon)

let find_mastodon_from_job _client (job : K.Job.t) =
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

let find_mastodon_from_pod _client (pod : K.Pod.t) =
  let ( let* ) = Option.bind in
  let* metadata = pod.metadata in
  let* labels = match metadata.labels with `Assoc l -> Some l | _ -> None in
  match labels |> List.assoc_opt Label.mastodon_key with
  | Some (`String name) -> Some (name, Option.get metadata.namespace)
  | _ -> None

open Reconciler.Make (struct
  type args = reconcile_args

  let reconcile = reconcile
end)

let start env client ({ gw_nginx_conf_templ_cm_name; _ } as args) () =
  let reconciler = make () in

  reconciler
  |> start_watching env ~register_watcher:Mastodon.register_watcher
       (fun (mastodon : Mastodon.t) ->
         let metadata = Option.get mastodon.metadata in
         let name = Option.get metadata.name in
         let namespace = Option.get metadata.namespace in
         [ (name, namespace) ]);

  reconciler
  |> start_watching env ~register_watcher:K.Job.register_watcher
       (fun (job : K.Job.t) ->
         let is_owned =
           (Option.get job.metadata).owner_references
           |> List.find_opt (fun (r : K.Owner_reference.t) ->
                  r.api_version = "mahout.anqou.net/v1alpha1"
                  && r.kind = "Mastodon" && r.controller = Some true)
           |> Option.is_some
         in
         if is_owned then
           find_mastodon_from_job client job
           |> Option.fold ~none:[] ~some:(fun (name, namespace) ->
                  [ (name, namespace) ])
         else []);

  reconciler
  |> start_watching env ~register_watcher:K.Pod.register_watcher
       (fun (pod : K.Pod.t) ->
         find_mastodon_from_pod client pod
         |> Option.fold ~none:[] ~some:(fun (name, namespace) ->
                [ (name, namespace) ]));

  reconciler
  |> start_watching env ~register_watcher:K.Config_map.register_watcher
       (fun (cm : K.Config_map.t) ->
         if
           Option.get (Option.get cm.metadata).namespace
           <> running_pod_namespace
           || Option.get (Option.get cm.metadata).name
              <> gw_nginx_conf_templ_cm_name
         then []
         else
           Mastodon.list_all client ()
           |> Result.get_ok
           |> List.map (fun (m : Mastodon.t) ->
                  let metadata = Option.get m.metadata in
                  (Option.get metadata.name, Option.get metadata.namespace)));

  reconciler |> start env client args
