(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_persistent_volume_status.t : PersistentVolumeStatus is the current status of a persistent volume.
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_phase_transition_time: string option [@default None] [@key "lastPhaseTransitionTime"];
    (* message is a human-readable message indicating details about why the volume is in this state. *)
    message: string option [@default None] [@key "message"];
    (* phase indicates if a volume is available, bound to a claim, or released by a claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#phase *)
    phase: string option [@default None] [@key "phase"];
    (* reason is a brief CamelCase string that describes any failure and is meant for machine parsing and tidy display in the CLI. *)
    reason: string option [@default None] [@key "reason"];
} [@@deriving yojson { strict = false }, show ];;

(** PersistentVolumeStatus is the current status of a persistent volume. *)
let create () : t = {
    last_phase_transition_time = None;
    message = None;
    phase = None;
    reason = None;
}

