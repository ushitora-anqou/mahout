(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta2_policy_rules_with_subjects.t : PolicyRulesWithSubjects prescribes a test that applies to a request to an apiserver. The test considers the subject making the request, the verb being requested, and the resource to be acted upon. This PolicyRulesWithSubjects matches a request if and only if both (a) at least one member of subjects matches the request and (b) at least one member of resourceRules or nonResourceRules matches the request.
 *)

type t = {
    (* `nonResourceRules` is a list of NonResourcePolicyRules that identify matching requests according to their verb and the target non-resource URL. *)
    non_resource_rules: Io_k8s_api_flowcontrol_v1beta2_non_resource_policy_rule.t list [@default []];
    (* `resourceRules` is a slice of ResourcePolicyRules that identify matching requests according to their verb and the target resource. At least one of `resourceRules` and `nonResourceRules` has to be non-empty. *)
    resource_rules: Io_k8s_api_flowcontrol_v1beta2_resource_policy_rule.t list [@default []];
    (* subjects is the list of normal user, serviceaccount, or group that this rule cares about. There must be at least one member in this slice. A slice that includes both the system:authenticated and system:unauthenticated user groups matches every request. Required. *)
    subjects: Io_k8s_api_flowcontrol_v1beta2_subject.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** PolicyRulesWithSubjects prescribes a test that applies to a request to an apiserver. The test considers the subject making the request, the verb being requested, and the resource to be acted upon. This PolicyRulesWithSubjects matches a request if and only if both (a) at least one member of subjects matches the request and (b) at least one member of resourceRules or nonResourceRules matches the request. *)
let create (subjects : Io_k8s_api_flowcontrol_v1beta2_subject.t list) : t = {
    non_resource_rules = [];
    resource_rules = [];
    subjects = subjects;
}

