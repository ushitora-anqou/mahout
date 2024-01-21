(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_condition.t : Condition contains details for one aspect of the current state of this API Resource.
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string;
    (* message is a human readable message indicating details about the transition. This may be an empty string. *)
    message: string;
    (* observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance. *)
    observed_generation: int64 option [@default None];
    (* reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty. *)
    reason: string;
    (* status of the condition, one of True, False, Unknown. *)
    status: string;
    (* type of condition in CamelCase or in foo.example.com/CamelCase. *)
    _type: string;
} [@@deriving yojson { strict = false }, show ];;

(** Condition contains details for one aspect of the current state of this API Resource. *)
let create (last_transition_time : string) (message : string) (reason : string) (status : string) (_type : string) : t = {
    last_transition_time = last_transition_time;
    message = message;
    observed_generation = None;
    reason = reason;
    status = status;
    _type = _type;
}

