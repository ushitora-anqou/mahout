(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1beta1_validating_admission_policy_status.t : ValidatingAdmissionPolicyStatus represents the status of an admission validation policy.
 *)

type t = {
    (* The conditions represent the latest available observations of a policy's current state. *)
    conditions: Io_k8s_apimachinery_pkg_apis_meta_v1_condition.t list [@default []] [@key conditions];
    (* The generation observed by the controller. *)
    observed_generation: int64 option [@default None] [@key observedGeneration];
    type_checking: Io_k8s_api_admissionregistration_v1beta1_type_checking.t option [@default None] [@key typeChecking];
} [@@deriving yojson { strict = false }, show ];;

(** ValidatingAdmissionPolicyStatus represents the status of an admission validation policy. *)
let create () : t = {
    conditions = [];
    observed_generation = None;
    type_checking = None;
}

