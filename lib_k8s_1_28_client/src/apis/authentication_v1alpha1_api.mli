(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

val create_authentication_v1alpha1_self_subject_review : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> body:Io_k8s_api_authentication_v1alpha1_self_subject_review.t -> ?dry_run:string -> ?field_manager:string -> ?field_validation:string -> ?pretty:string -> unit -> Io_k8s_api_authentication_v1alpha1_self_subject_review.t Json_response_scanner.t
val get_authentication_v1alpha1_api_resources : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> unit -> Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource_list.t Json_response_scanner.t
