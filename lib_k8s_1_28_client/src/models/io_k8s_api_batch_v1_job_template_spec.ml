(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_batch_v1_job_template_spec.t : JobTemplateSpec describes the data a Job should have when created from a template
 *)

type t = {
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None];
    spec: Io_k8s_api_batch_v1_job_spec.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** JobTemplateSpec describes the data a Job should have when created from a template *)
let create () : t = {
    metadata = None;
    spec = None;
}

