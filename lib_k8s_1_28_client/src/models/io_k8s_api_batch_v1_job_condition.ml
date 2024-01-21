(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_batch_v1_job_condition.t : JobCondition describes current state of a job.
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_probe_time: string option [@default None];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string option [@default None];
    (* Human readable message indicating details about last transition. *)
    message: string option [@default None];
    (* (brief) reason for the condition's last transition. *)
    reason: string option [@default None];
    (* Status of the condition, one of True, False, Unknown. *)
    status: string;
    (* Type of job condition, Complete or Failed. *)
    _type: string;
} [@@deriving yojson { strict = false }, show ];;

(** JobCondition describes current state of a job. *)
let create (status : string) (_type : string) : t = {
    last_probe_time = None;
    last_transition_time = None;
    message = None;
    reason = None;
    status = status;
    _type = _type;
}

