(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_env_var_source.t : EnvVarSource represents a source for the value of an EnvVar.
 *)

type t = {
    config_map_key_ref: Io_k8s_api_core_v1_config_map_key_selector.t option [@yojson.default None] [@yojson.key "configMapKeyRef"];
    field_ref: Io_k8s_api_core_v1_object_field_selector.t option [@yojson.default None] [@yojson.key "fieldRef"];
    resource_field_ref: Io_k8s_api_core_v1_resource_field_selector.t option [@yojson.default None] [@yojson.key "resourceFieldRef"];
    secret_key_ref: Io_k8s_api_core_v1_secret_key_selector.t option [@yojson.default None] [@yojson.key "secretKeyRef"];
} [@@deriving yojson { strict = false }, show, make];;


