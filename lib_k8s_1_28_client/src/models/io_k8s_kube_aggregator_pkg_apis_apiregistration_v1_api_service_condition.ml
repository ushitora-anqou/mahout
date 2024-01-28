(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_kube_aggregator_pkg_apis_apiregistration_v1_api_service_condition.t : APIServiceCondition describes the state of an APIService at a particular point
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string option [@yojson.default None] [@yojson.key "lastTransitionTime"];
    (* Human-readable message indicating details about last transition. *)
    message: string option [@yojson.default None] [@yojson.key "message"];
    (* Unique, one-word, CamelCase reason for the condition's last transition. *)
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    (* Status is the status of the condition. Can be True, False, Unknown. *)
    status: string [@yojson.key "status"];
    (* Type is the type of the condition. *)
    _type: string [@yojson.key "type"];
} [@@deriving yojson { strict = false }, show, make];;


