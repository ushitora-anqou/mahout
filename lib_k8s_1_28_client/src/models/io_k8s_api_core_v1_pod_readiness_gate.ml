(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_pod_readiness_gate.t : PodReadinessGate contains the reference to a pod condition
 *)

type t = {
    (* ConditionType refers to a condition in the pod's condition list with matching type. *)
    condition_type: string [@key conditionType];
} [@@deriving yojson { strict = false }, show ];;

(** PodReadinessGate contains the reference to a pod condition *)
let create (condition_type : string) : t = {
    condition_type = condition_type;
}

