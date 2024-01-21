(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_config_map_env_source.t : ConfigMapEnvSource selects a ConfigMap to populate the environment variables with.  The contents of the target ConfigMap's Data field will represent the key-value pairs as environment variables.
 *)

type t = {
    (* Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names *)
    name: string option [@default None] [@key "name"];
    (* Specify whether the ConfigMap must be defined *)
    optional: bool option [@default None] [@key "optional"];
} [@@deriving yojson { strict = false }, show ];;

(** ConfigMapEnvSource selects a ConfigMap to populate the environment variables with.  The contents of the target ConfigMap's Data field will represent the key-value pairs as environment variables. *)
let create () : t = {
    name = None;
    optional = None;
}

