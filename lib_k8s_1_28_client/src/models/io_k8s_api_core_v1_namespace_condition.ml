(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_namespace_condition.t : NamespaceCondition contains details about state of namespace.
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string option [@yojson.default None] [@yojson.key "lastTransitionTime"];
    message: string option [@yojson.default None] [@yojson.key "message"];
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    (* Status of the condition, one of True, False, Unknown. *)
    status: string [@yojson.key "status"];
    (* Type of namespace controller condition. *)
    _type: string [@yojson.key "type"];
} [@@deriving yojson { strict = false }, show, make];;


