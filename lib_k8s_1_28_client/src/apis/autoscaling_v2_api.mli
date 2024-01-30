(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type any = Yojson.Safe.t

val create_autoscaling_v2_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> namespace:string -> body:Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t Json_response_scanner.t, Cohttp.Response.t) result
val delete_autoscaling_v2_collection_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> namespace:string -> ?pretty:string -> ?continue:string -> ?dry_run:string -> ?field_selector:string -> ?grace_period_seconds:int32 -> ?label_selector:string -> ?limit:int32 -> ?orphan_dependents:bool -> ?propagation_policy:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> body:Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.t -> unit -> (Io_k8s_apimachinery_pkg_apis_meta_v1_status.t Json_response_scanner.t, Cohttp.Response.t) result
val delete_autoscaling_v2_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> ?pretty:string -> ?dry_run:string -> ?grace_period_seconds:int32 -> ?orphan_dependents:bool -> ?propagation_policy:string -> body:Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.t -> unit -> (Io_k8s_apimachinery_pkg_apis_meta_v1_status.t Json_response_scanner.t, Cohttp.Response.t) result
val get_autoscaling_v2_api_resources : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> unit -> (Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource_list.t Json_response_scanner.t, Cohttp.Response.t) result
val list_autoscaling_v2_horizontal_pod_autoscaler_for_all_namespaces : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler_list.t Json_response_scanner.t, Cohttp.Response.t) result
val list_autoscaling_v2_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> namespace:string -> ?pretty:string -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler_list.t Json_response_scanner.t, Cohttp.Response.t) result
val patch_autoscaling_v2_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> body:any -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> ?force:bool -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t Json_response_scanner.t, Cohttp.Response.t) result
val patch_autoscaling_v2_namespaced_horizontal_pod_autoscaler_status : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> body:any -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> ?force:bool -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t Json_response_scanner.t, Cohttp.Response.t) result
val read_autoscaling_v2_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> ?pretty:string -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t Json_response_scanner.t, Cohttp.Response.t) result
val read_autoscaling_v2_namespaced_horizontal_pod_autoscaler_status : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> ?pretty:string -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t Json_response_scanner.t, Cohttp.Response.t) result
val replace_autoscaling_v2_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> body:Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t Json_response_scanner.t, Cohttp.Response.t) result
val replace_autoscaling_v2_namespaced_horizontal_pod_autoscaler_status : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> body:Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> unit -> (Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler.t Json_response_scanner.t, Cohttp.Response.t) result
val watch_autoscaling_v2_horizontal_pod_autoscaler_list_for_all_namespaces : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> (Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t Json_response_scanner.t, Cohttp.Response.t) result
val watch_autoscaling_v2_namespaced_horizontal_pod_autoscaler : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> name:string -> namespace:string -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> (Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t Json_response_scanner.t, Cohttp.Response.t) result
val watch_autoscaling_v2_namespaced_horizontal_pod_autoscaler_list : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> namespace:string -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> (Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t Json_response_scanner.t, Cohttp.Response.t) result
