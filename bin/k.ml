module Bare = struct
  open K8s_1_28_client

  exception Not_available

  module type S = sig
    type t
    type t_list

    val metadata :
      t -> Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option

    val to_list : t_list -> t list

    val read_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      ?pretty:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val create_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      namespace:string ->
      body:t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val patch_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:Yojson.Safe.t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      ?force:bool ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val delete_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      ?pretty:string ->
      ?dry_run:string ->
      ?grace_period_seconds:int32 ->
      ?orphan_dependents:bool ->
      ?propagation_policy:string ->
      body:Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.t ->
      unit ->
      (unit, Cohttp.Response.t) result

    val watch_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      namespace:string ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?pretty:string ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      ( Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t
        Json_response_scanner.t,
        Cohttp.Response.t )
      result

    val watch_for_all_namespaces :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?pretty:string ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      ( Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t
        Json_response_scanner.t,
        Cohttp.Response.t )
      result

    val list_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      namespace:string ->
      ?pretty:string ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      (t_list Json_response_scanner.t, Cohttp.Response.t) result

    val list_for_all_namespaces :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?pretty:string ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      (t_list Json_response_scanner.t, Cohttp.Response.t) result

    val replace_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val read_status :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      ?pretty:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val replace_status :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val patch_status :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:Yojson.Safe.t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      ?force:bool ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val of_yojson : Yojson.Safe.t -> (t, string) result
    val to_yojson : t -> Yojson.Safe.t
  end

  module Config_map = struct
    type t = Io_k8s_api_core_v1_config_map.t
    type t_list = Io_k8s_api_core_v1_config_map_list.t

    let metadata (v : t) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Core_v1_api.read_core_v1_namespaced_config_map
    let create_namespaced = Core_v1_api.create_core_v1_namespaced_config_map
    let patch_namespaced = Core_v1_api.patch_core_v1_namespaced_config_map

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Core_v1_api.delete_core_v1_namespaced_config_map ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Core_v1_api.watch_core_v1_namespaced_config_map_list
    let replace_namespaced = Core_v1_api.replace_core_v1_namespaced_config_map
    let list_namespaced = Core_v1_api.list_core_v1_namespaced_config_map

    let watch_for_all_namespaces =
      Core_v1_api.watch_core_v1_config_map_list_for_all_namespaces

    let list_for_all_namespaces =
      Core_v1_api.list_core_v1_config_map_for_all_namespaces

    let read_status ~sw:_ _ ?headers:_ ~name:_ ~namespace:_ ?pretty:_ _ =
      raise Not_available

    let patch_status ~sw:_ _ ?headers:_ ~name:_ ~namespace:_ ~body:_ ?pretty:_
        ?dry_run:_ ?field_manager:_ ?field_validation:_ ?force:_ _ =
      raise Not_available

    let replace_status ~sw:_ _ ?headers:_ ~name:_ ~namespace:_ ~body:_ ?pretty:_
        ?dry_run:_ ?field_manager:_ ?field_validation:_ _ =
      raise Not_available

    let of_yojson = Io_k8s_api_core_v1_config_map.of_yojson
    let to_yojson = Io_k8s_api_core_v1_config_map.to_yojson
  end

  module Deployment = struct
    type t = Io_k8s_api_apps_v1_deployment.t
    type t_list = Io_k8s_api_apps_v1_deployment_list.t

    let metadata (v : t) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Apps_v1_api.read_apps_v1_namespaced_deployment
    let create_namespaced = Apps_v1_api.create_apps_v1_namespaced_deployment
    let patch_namespaced = Apps_v1_api.patch_apps_v1_namespaced_deployment

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Apps_v1_api.delete_apps_v1_namespaced_deployment ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Apps_v1_api.watch_apps_v1_namespaced_deployment_list
    let replace_namespaced = Apps_v1_api.replace_apps_v1_namespaced_deployment
    let list_namespaced = Apps_v1_api.list_apps_v1_namespaced_deployment

    let watch_for_all_namespaces =
      Apps_v1_api.watch_apps_v1_deployment_list_for_all_namespaces

    let list_for_all_namespaces =
      Apps_v1_api.list_apps_v1_deployment_for_all_namespaces

    let read_status = Apps_v1_api.read_apps_v1_namespaced_deployment_status
    let patch_status = Apps_v1_api.patch_apps_v1_namespaced_deployment_status

    let replace_status =
      Apps_v1_api.replace_apps_v1_namespaced_deployment_status

    let of_yojson = Io_k8s_api_apps_v1_deployment.of_yojson
    let to_yojson = Io_k8s_api_apps_v1_deployment.to_yojson
  end

  module Job = struct
    type t = Io_k8s_api_batch_v1_job.t
    type t_list = Io_k8s_api_batch_v1_job_list.t

    let metadata (v : t) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Batch_v1_api.read_batch_v1_namespaced_job
    let create_namespaced = Batch_v1_api.create_batch_v1_namespaced_job
    let patch_namespaced = Batch_v1_api.patch_batch_v1_namespaced_job

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Batch_v1_api.delete_batch_v1_namespaced_job ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Batch_v1_api.watch_batch_v1_namespaced_job_list
    let replace_namespaced = Batch_v1_api.replace_batch_v1_namespaced_job
    let list_namespaced = Batch_v1_api.list_batch_v1_namespaced_job

    let watch_for_all_namespaces =
      Batch_v1_api.watch_batch_v1_job_list_for_all_namespaces

    let list_for_all_namespaces =
      Batch_v1_api.list_batch_v1_job_for_all_namespaces

    let read_status = Batch_v1_api.read_batch_v1_namespaced_job_status
    let patch_status = Batch_v1_api.patch_batch_v1_namespaced_job_status
    let replace_status = Batch_v1_api.replace_batch_v1_namespaced_job_status
    let of_yojson = Io_k8s_api_batch_v1_job.of_yojson
    let to_yojson = Io_k8s_api_batch_v1_job.to_yojson
  end

  module Pod = struct
    type t = Io_k8s_api_core_v1_pod.t
    type t_list = Io_k8s_api_core_v1_pod_list.t

    let metadata (v : t) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Core_v1_api.read_core_v1_namespaced_pod
    let create_namespaced = Core_v1_api.create_core_v1_namespaced_pod
    let patch_namespaced = Core_v1_api.patch_core_v1_namespaced_pod

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Core_v1_api.delete_core_v1_namespaced_pod ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Core_v1_api.watch_core_v1_namespaced_pod_list
    let replace_namespaced = Core_v1_api.replace_core_v1_namespaced_pod
    let list_namespaced = Core_v1_api.list_core_v1_namespaced_pod

    let watch_for_all_namespaces =
      Core_v1_api.watch_core_v1_pod_list_for_all_namespaces

    let list_for_all_namespaces =
      Core_v1_api.list_core_v1_pod_for_all_namespaces

    let read_status = Core_v1_api.read_core_v1_namespaced_pod_status
    let patch_status = Core_v1_api.patch_core_v1_namespaced_pod_status
    let replace_status = Core_v1_api.replace_core_v1_namespaced_pod_status
    let of_yojson = Io_k8s_api_core_v1_pod.of_yojson
    let to_yojson = Io_k8s_api_core_v1_pod.to_yojson
  end

  module Service = struct
    type t = Io_k8s_api_core_v1_service.t
    type t_list = Io_k8s_api_core_v1_service_list.t

    let metadata (v : t) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Core_v1_api.read_core_v1_namespaced_service
    let create_namespaced = Core_v1_api.create_core_v1_namespaced_service
    let patch_namespaced = Core_v1_api.patch_core_v1_namespaced_service

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Core_v1_api.delete_core_v1_namespaced_service ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Core_v1_api.watch_core_v1_namespaced_service_list
    let replace_namespaced = Core_v1_api.replace_core_v1_namespaced_service
    let list_namespaced = Core_v1_api.list_core_v1_namespaced_service

    let watch_for_all_namespaces =
      Core_v1_api.watch_core_v1_service_list_for_all_namespaces

    let list_for_all_namespaces =
      Core_v1_api.list_core_v1_service_for_all_namespaces

    let read_status = Core_v1_api.read_core_v1_namespaced_service_status
    let patch_status = Core_v1_api.patch_core_v1_namespaced_service_status
    let replace_status = Core_v1_api.replace_core_v1_namespaced_service_status
    let of_yojson = Io_k8s_api_core_v1_service.of_yojson
    let to_yojson = Io_k8s_api_core_v1_service.to_yojson
  end
end

include K8s_1_28_client

type error =
  [ `Connection_failure of string
  | `No_metadata
  | `Not_found
  | `Scan_failure of string ]
[@@deriving show]

module Make (B : Bare.S) = struct
  open struct
    let expect_one : _ -> (_, error) result = function
      | Error (resp : Cohttp.Response.t) when resp.status = `Not_found ->
          Error `Not_found
      | Error resp ->
          Error
            (`Connection_failure (Format.asprintf "%a" Http.Response.pp resp))
      | Ok scanner -> (
          match Json_response_scanner.scan scanner with
          | Error (`Msg msg) -> Error (`Scan_failure msg)
          | Ok v -> Ok v)

    let get_name_and_ns body =
      match B.metadata body with
      | None | Some { name = None; _ } -> None
      | Some { name = Some name; namespace; _ } ->
          Some (name, Option.value ~default:"default" namespace)
  end

  type t = B.t

  let of_yojson = B.of_yojson
  let to_yojson = B.to_yojson

  type watch_event = [ `Added | `Modified | `Deleted ] * t

  let string_of_watch_event : watch_event -> string = function
    | `Added, v -> "ADDED " ^ (v |> to_yojson |> Yojson.Safe.to_string)
    | `Modified, v -> "MODIFIED " ^ (v |> to_yojson |> Yojson.Safe.to_string)
    | `Deleted, v -> "DELETED " ^ (v |> to_yojson |> Yojson.Safe.to_string)

  let get ~sw client ~name ~namespace () =
    B.read_namespaced ~sw client ~name ~namespace () |> expect_one

  let get_status ~sw client ~name ~namespace () =
    B.read_status ~sw client ~name ~namespace () |> expect_one

  let update ~sw client body =
    match get_name_and_ns body with
    | None -> Error `No_metadata
    | Some (name, namespace) ->
        B.replace_namespaced ~sw client ~name ~namespace ~body () |> expect_one

  let update_status ~sw client body =
    match get_name_and_ns body with
    | None -> Error `No_metadata
    | Some (name, namespace) ->
        B.replace_status ~sw client ~name ~namespace ~body () |> expect_one

  let create ~sw client body =
    match get_name_and_ns body with
    | None -> Error `No_metadata
    | Some (_, namespace) ->
        B.create_namespaced ~sw client ~namespace ~body () |> expect_one

  let watch ~sw client ~namespace () :
      (watch_event Json_response_scanner.t, Http.Response.t) result =
    B.watch_namespaced ~sw client ~namespace ~watch:true ()
    |> Result.map (fun scanner ->
           scanner
           |> Json_response_scanner.with_conv
                (fun
                  (ev : Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t) ->
                  match ev._type with
                  | "ADDED" ->
                      (`Added, ev._object |> B.of_yojson |> Result.get_ok)
                  | "MODIFIED" ->
                      (`Modified, ev._object |> B.of_yojson |> Result.get_ok)
                  | "DELETED" ->
                      (`Deleted, ev._object |> B.of_yojson |> Result.get_ok)
                  | _ -> failwith "invalid watch event"))

  let create_or_update ~sw client ~name ~namespace f =
    match get ~sw client ~name ~namespace () with
    | Error `Not_found ->
        Logs.info (fun m -> m "not found %s %s" name namespace);
        create ~sw client (f None)
    | Error _ as e -> e
    | Ok v ->
        Logs.info (fun m ->
            m "found %s %s %s" name namespace
              (Yojson.Safe.to_string (B.to_yojson v)));
        update ~sw client (f (Some v))

  let create_or_update_status ~sw client ~name ~namespace f =
    match get_status ~sw client ~name ~namespace () with
    | Error `Not_found -> create ~sw client (f None)
    | Error _ as e -> e
    | Ok v -> update_status ~sw client (f (Some v))

  let list ~sw client ~namespace ?label_selector () =
    B.list_namespaced ~sw client ~namespace ?label_selector ()
    |> expect_one |> Result.map B.to_list
end

module Config_map = struct
  include Make (Bare.Config_map)

  let make = Io_k8s_api_core_v1_config_map.make
end

module Deployment = struct
  include Make (Bare.Deployment)

  let make = Io_k8s_api_apps_v1_deployment.make
end

module Job = struct
  include Make (Bare.Job)

  let make = Io_k8s_api_batch_v1_job.make
end

module Pod = struct
  include Make (Bare.Pod)

  let make = Io_k8s_api_core_v1_pod.make
end

module Service = struct
  include Make (Bare.Service)

  let make = Io_k8s_api_core_v1_service.make
end

(* Not implemented *)
module Config_map_volume_source = Io_k8s_api_core_v1_config_map_volume_source
module Container = Io_k8s_api_core_v1_container
module Container_port = Io_k8s_api_core_v1_container_port
module Deployment_spec = Io_k8s_api_apps_v1_deployment_spec
module Empty_dir_volume_source = Io_k8s_api_core_v1_empty_dir_volume_source
module Env_from_source = Io_k8s_api_core_v1_env_from_source
module Env_var = Io_k8s_api_core_v1_env_var
module Job_spec = Io_k8s_api_batch_v1_job_spec
module Job_template_spec = Io_k8s_api_batch_v1_job_template_spec
module Key_to_path = Io_k8s_api_core_v1_key_to_path
module Label_selector = Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector
module Object_meta = Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta
module Owner_reference = Io_k8s_apimachinery_pkg_apis_meta_v1_owner_reference
module Pod_spec = Io_k8s_api_core_v1_pod_spec
module Pod_template_spec = Io_k8s_api_core_v1_pod_template_spec
module Probe = Io_k8s_api_core_v1_probe
module Service_port = Io_k8s_api_core_v1_service_port
module Service_spec = Io_k8s_api_core_v1_service_spec
module Tcp_socket_action = Io_k8s_api_core_v1_tcp_socket_action
module Volume = Io_k8s_api_core_v1_volume
module Http_get_action = Io_k8s_api_core_v1_http_get_action
module Volume_mount = Io_k8s_api_core_v1_volume_mount
