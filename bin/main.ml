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

module K = struct
  include K8s_1_28_client
  module Deployment = Io_k8s_api_apps_v1_deployment
  module Object_meta = Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta
  module Label_selector = Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector
  module Pod_template_spec = Io_k8s_api_core_v1_pod_template_spec
  module Container = Io_k8s_api_core_v1_container
  module Container_port = Io_k8s_api_core_v1_container_port
  module Volume_mount = Io_k8s_api_core_v1_volume_mount
  module Pod_spec = Io_k8s_api_core_v1_pod_spec
  module Volume = Io_k8s_api_core_v1_volume
  module Empty_dir_volume_source = Io_k8s_api_core_v1_empty_dir_volume_source
  module Config_map_volume_source = Io_k8s_api_core_v1_config_map_volume_source
  module Key_to_path = Io_k8s_api_core_v1_key_to_path
  module Deployment_spec = Io_k8s_api_apps_v1_deployment_spec
  module Owner_reference = Io_k8s_apimachinery_pkg_apis_meta_v1_owner_reference
  module Config_map = Io_k8s_api_core_v1_config_map
  module Job = Io_k8s_api_batch_v1_job
  module Job_spec = Io_k8s_api_batch_v1_job_spec
  module Job_template_spec = Io_k8s_api_batch_v1_job_template_spec
  module Env_from_source = Io_k8s_api_core_v1_env_from_source
end

module Net_anqou_mahout = struct
  open K

  module V1alpha1 = struct
    module Mastodon = struct
      module Web = struct
        type t = { replicas : int [@yojson.key "replicas"] }
        [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
      end

      module Sidekiq = struct
        type t = { replicas : int [@yojson.key "replicas"] }
        [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
      end

      module Streaming = struct
        type t = { replicas : int [@yojson.key "replicas"] }
        [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
      end

      module Spec = struct
        type t = {
          image : string; [@yojson.key "image"]
          env_from : Io_k8s_api_core_v1_env_from_source.t list;
              [@yojson.default []] [@yojson.key "envFrom"]
          web : Web.t option; [@yojson.default None] [@yojson.key "web"]
          sidekiq : Sidekiq.t option;
              [@yojson.default None] [@yojson.key "sidekiq"]
          streaming : Streaming.t option;
              [@yojson.default None] [@yojson.key "streaming"]
        }
        [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
      end

      module Status = struct
        type t = {
          message : string option;
              [@yojson.default None] [@yojson.key "message"]
          server_name : string option;
              [@yojson.default None] [@yojson.key "serverName"]
        }
        [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
      end

      type t = {
        api_version : string option;
            [@yojson.default None] [@yojson.key "apiVersion"]
        kind : string option; [@yojson.default None] [@yojson.key "kind"]
        metadata : Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option;
            [@yojson.default None] [@yojson.key "metadata"]
        spec : Spec.t option; [@yojson.default None] [@yojson.key "spec"]
        status : Status.t option; [@yojson.default None] [@yojson.key "status"]
      }
      [@@deriving yojson, show, make] [@@yojson.allow_extra_fields]
    end
    [@@warning "-32"]
  end
end

module Mahout_v1alpha1_api = struct
  open K

  let watch_mahout_v1alpha1_namespaced_mastodon ~sw client ~namespace ?watch ()
      =
    let uri =
      Request.build_uri
        "/apis/mahout.anqou.net/v1alpha1/watch/namespaces/{namespace}/mastodons"
    in
    let headers = Request.default_headers in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri =
      Request.replace_path_param uri "namespace" (fun x -> x) namespace
    in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers in
    Request.read_json_body_as
      (JsonSupport.unwrap
         Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson)
      resp body

  let patch_mahout_v1alpha1_namespaced_mastodon ~sw client ~name ~namespace
      ~body () =
    let uri =
      Request.build_uri
        "/apis/mahout.anqou.net/v1alpha1/namespaces/{namespace}/mastodons/{name}/status"
    in
    let headers =
      Cohttp.Header.init_with "Content-Type" "application/merge-patch+json"
    in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri =
      Request.replace_path_param uri "namespace" (fun x -> x) namespace
    in
    let body = Request.write_json_body body in
    let resp, body =
      Cohttp_eio.Client.call ~sw client `PATCH uri ~headers ~body
    in
    Request.read_json_body_as
      (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.of_yojson)
      resp body
end

let create_or_update ~sw client ~read ~create ~patch ~to_yojson ~name ~namespace
    body =
  match read ~sw client ?headers:None ~name ~namespace ?pretty:None () with
  | Error (resp : Cohttp.Response.t) when resp.status = `Not_found ->
      create ~sw client ?headers:None ~namespace ~body ?pretty:None
        ?dry_run:None ?field_manager:None ?field_validation:None ()
      |> Result.map_error (fun resp -> `Response resp)
  | Error resp -> Error (`Response resp)
  | Ok scanner -> (
      match K.Json_response_scanner.scan scanner with
      | Error (`Msg msg) -> Error (`Msg msg)
      | Ok _ ->
          patch ~sw client ?headers:None ~name ~namespace ~body:(to_yojson body)
            ?pretty:None ?dry_run:None ?field_manager:None
            ?field_validation:None ?force:None ()
          |> Result.map_error (fun resp -> `Response resp))

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
  K.Core_v1_api.read_core_v1_namespaced_pod ~sw client ~name ~namespace ()
  |> Result.get_ok |> K.Json_response_scanner.scan |> Result.get_ok

let get_check_env_job_name ~sw:_ _client
    (mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let name = Option.get (Option.get mastodon.metadata).name in
  name ^ "-check-env"

let create_or_update_check_env_job ~sw client
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
                             ();
                         ]
                     ())
                ())
           ())
      ()
  in
  Logs.info (fun m -> m "%s" (body |> K.Job.to_yojson |> Yojson.Safe.to_string));
  let _ =
    K.Batch_v1_api.create_batch_v1_namespaced_job ~sw client ~namespace ~body ()
  in
  let _ =
    create_or_update ~sw client
      ~read:K.Batch_v1_api.read_batch_v1_namespaced_job
      ~create:K.Batch_v1_api.create_batch_v1_namespaced_job
      ~patch:K.Batch_v1_api.patch_batch_v1_namespaced_job
      ~to_yojson:K.Job.to_yojson ~name ~namespace body
  in

  ()

let create_or_update_gateway ~sw client
    ~(mastodon : Net_anqou_mahout.V1alpha1.Mastodon.t) =
  let nginx_image = "nginx:1.25.3" in

  let name = Option.get (Option.get mastodon.metadata).name in
  let namespace = Option.get (Option.get mastodon.metadata).namespace in
  let mastodon_image = (Option.get mastodon.spec).image in

  let nginx_conf_cm_name = name ^ "-gateway-nginx-conf" in
  let nginx_conf_cm_key = "mastodon-nginx.conf" in
  let nginx_deploy_name = name ^ "-gateway-nginx" in

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
  let _ =
    K.Core_v1_api.create_core_v1_namespaced_config_map ~sw client ~namespace
      ~body ()
  in

  let body =
    let selector_labels =
      `Assoc
        [
          ("app.kubernetes.io/name", `String "nginx");
          ("app.kubernetes.io/component", `String "gateway");
          ("app.kubernetes.io/part-of", `String "mastodon");
        ]
    in
    K.Deployment.make ~api_version:"apps/v1" ~kind:"Deployment"
      ~metadata:
        (K.Object_meta.make ~name:nginx_deploy_name ~namespace ~owner_references
           ())
      ~spec:
        K.Deployment_spec.(
          make ~replicas:1l
            ~selector:(K.Label_selector.make ~match_labels:selector_labels ())
            ~template:
              (K.Pod_template_spec.make
                 ~metadata:(K.Object_meta.make ~labels:selector_labels ())
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
  let _ =
    K.Apps_v1_api.create_apps_v1_namespaced_deployment ~sw client ~namespace
      ~body ()
  in
  ()

let reconcile_mastodon ~sw client
    (req : K.Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t) =
  Logs.info (fun m -> m "%s %s" req._type (Yojson.Safe.to_string req._object));

  let mastodon =
    match Net_anqou_mahout.V1alpha1.Mastodon.of_yojson req._object with
    | Ok x -> x
    | Error msg -> failwith msg
  in

  match Option.bind mastodon.status (fun x -> Some x.server_name) with
  | None -> create_or_update_check_env_job ~sw client ~mastodon
  | Some _ -> create_or_update_gateway ~sw client ~mastodon

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
  Mahout_v1alpha1_api.watch_mahout_v1alpha1_namespaced_mastodon ~sw client
    ~namespace:"default" ~watch:true ()
  |> Result.get_ok
  |> K.Json_response_scanner.iter (reconcile_mastodon ~sw client)
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
  let client =
    (* FIXME: use ca cert *)
    Cohttp_eio.Client.make
      ~https:(Some (https ~authenticator:null_auth))
      (Eio.Stdenv.net env)
  in
  let _ =
    Mahout_v1alpha1_api.patch_mahout_v1alpha1_namespaced_mastodon ~sw client
      ~name ~namespace
      ~body:
        (`Assoc [ ("status", `Assoc [ ("serverName", `String server_name) ]) ])
      ()
  in
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
