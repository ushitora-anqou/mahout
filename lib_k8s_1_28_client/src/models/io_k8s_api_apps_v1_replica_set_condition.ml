(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_replica_set_condition.t : ReplicaSetCondition describes the state of a replica set at a certain point.
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string option [@default None] [@key "lastTransitionTime"];
    (* A human readable message indicating details about the transition. *)
    message: string option [@default None] [@key "message"];
    (* The reason for the condition's last transition. *)
    reason: string option [@default None] [@key "reason"];
    (* Status of the condition, one of True, False, Unknown. *)
    status: string [@key "status"];
    (* Type of replica set condition. *)
    _type: string [@key "type"];
} [@@deriving yojson { strict = false }, show ];;

(** ReplicaSetCondition describes the state of a replica set at a certain point. *)
let create (status : string) (_type : string) : t = {
    last_transition_time = None;
    message = None;
    reason = None;
    status = status;
    _type = _type;
}

