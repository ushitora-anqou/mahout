(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_pod_template_spec.t : PodTemplateSpec describes the data a pod should have when created from a template
 *)

type t = {
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None] [@key metadata];
    spec: Io_k8s_api_core_v1_pod_spec.t option [@default None] [@key spec];
} [@@deriving yojson { strict = false }, show ];;

(** PodTemplateSpec describes the data a pod should have when created from a template *)
let create () : t = {
    metadata = None;
    spec = None;
}

