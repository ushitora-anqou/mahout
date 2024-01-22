(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

val create_coordination_v1_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> namespace:string -> body:Io_k8s_api_coordination_v1_lease.t -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> unit -> Io_k8s_api_coordination_v1_lease.t Json_response_scanner.t
val delete_coordination_v1_collection_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> namespace:string -> ?pretty:string -> ?continue:string -> ?dry_run:string -> ?field_selector:string -> ?grace_period_seconds:int32 -> ?label_selector:string -> ?limit:int32 -> ?orphan_dependents:bool -> ?propagation_policy:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> body:Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.t -> unit -> Io_k8s_apimachinery_pkg_apis_meta_v1_status.t Json_response_scanner.t
val delete_coordination_v1_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> name:string -> namespace:string -> ?pretty:string -> ?dry_run:string -> ?grace_period_seconds:int32 -> ?orphan_dependents:bool -> ?propagation_policy:string -> body:Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.t -> unit -> Io_k8s_apimachinery_pkg_apis_meta_v1_status.t Json_response_scanner.t
val get_coordination_v1_api_resources : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> unit -> Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource_list.t Json_response_scanner.t
val list_coordination_v1_lease_for_all_namespaces : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> Io_k8s_api_coordination_v1_lease_list.t Json_response_scanner.t
val list_coordination_v1_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> namespace:string -> ?pretty:string -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> Io_k8s_api_coordination_v1_lease_list.t Json_response_scanner.t
val patch_coordination_v1_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> name:string -> namespace:string -> body:Yojson.Safe.t -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> ?force:bool -> unit -> Io_k8s_api_coordination_v1_lease.t Json_response_scanner.t
val read_coordination_v1_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> name:string -> namespace:string -> ?pretty:string -> unit -> Io_k8s_api_coordination_v1_lease.t Json_response_scanner.t
val replace_coordination_v1_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> name:string -> namespace:string -> body:Io_k8s_api_coordination_v1_lease.t -> ?pretty:string -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> unit -> Io_k8s_api_coordination_v1_lease.t Json_response_scanner.t
val watch_coordination_v1_lease_list_for_all_namespaces : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t Json_response_scanner.t
val watch_coordination_v1_namespaced_lease : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> name:string -> namespace:string -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t Json_response_scanner.t
val watch_coordination_v1_namespaced_lease_list : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> namespace:string -> ?allow_watch_bookmarks:bool -> ?continue:string -> ?field_selector:string -> ?label_selector:string -> ?limit:int32 -> ?pretty:string -> ?resource_version:string -> ?resource_version_match:string -> ?send_initial_events:bool -> ?timeout_seconds:int32 -> ?watch:bool -> unit -> Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t Json_response_scanner.t
