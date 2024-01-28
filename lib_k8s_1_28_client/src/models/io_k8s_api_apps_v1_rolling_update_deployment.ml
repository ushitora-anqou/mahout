(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_rolling_update_deployment.t : Spec to control the desired behavior of rolling update.
 *)

type t = {
    (* IntOrString is a type that can hold an int32 or a string.  When used in JSON or YAML marshalling and unmarshalling, it produces or consumes the inner type.  This allows you to have, for example, a JSON field that can accept a name or number. *)
    max_surge: string option [@yojson.default None] [@yojson.key "maxSurge"];
    (* IntOrString is a type that can hold an int32 or a string.  When used in JSON or YAML marshalling and unmarshalling, it produces or consumes the inner type.  This allows you to have, for example, a JSON field that can accept a name or number. *)
    max_unavailable: string option [@yojson.default None] [@yojson.key "maxUnavailable"];
} [@@deriving yojson { strict = false }, show, make];;


