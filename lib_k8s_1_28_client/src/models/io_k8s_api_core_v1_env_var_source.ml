(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_env_var_source.t : EnvVarSource represents a source for the value of an EnvVar.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
end)
type t = {
    config_map_key_ref: Io_k8s_api_core_v1_config_map_key_selector.t option [@yojson.default None] [@yojson.key "configMapKeyRef"];
    field_ref: Io_k8s_api_core_v1_object_field_selector.t option [@yojson.default None] [@yojson.key "fieldRef"];
    resource_field_ref: Io_k8s_api_core_v1_resource_field_selector.t option [@yojson.default None] [@yojson.key "resourceFieldRef"];
    secret_key_ref: Io_k8s_api_core_v1_secret_key_selector.t option [@yojson.default None] [@yojson.key "secretKeyRef"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


