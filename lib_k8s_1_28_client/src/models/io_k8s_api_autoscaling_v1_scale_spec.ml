(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v1_scale_spec.t : ScaleSpec describes the attributes of a scale subresource.
 *)

type t = {
    (* replicas is the desired number of instances for the scaled object. *)
    replicas: int32 option [@yojson.default None] [@yojson.key "replicas"];
} [@@deriving yojson { strict = false }, show, make];;


