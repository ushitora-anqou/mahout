(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1alpha1_validating_admission_policy_spec.t : ValidatingAdmissionPolicySpec is the specification of the desired behavior of the AdmissionPolicy.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* auditAnnotations contains CEL expressions which are used to produce audit annotations for the audit event of the API request. validations and auditAnnotations may not both be empty; a least one of validations or auditAnnotations is required. *)
    audit_annotations: Io_k8s_api_admissionregistration_v1alpha1_audit_annotation.t list [@yojson.default []] [@yojson.key "auditAnnotations"];
    (* failurePolicy defines how to handle failures for the admission policy. Failures can occur from CEL expression parse errors, type check errors, runtime errors and invalid or mis-configured policy definitions or bindings.  A policy is invalid if spec.paramKind refers to a non-existent Kind. A binding is invalid if spec.paramRef.name refers to a non-existent resource.  failurePolicy does not define how validations that evaluate to false are handled.  When failurePolicy is set to Fail, ValidatingAdmissionPolicyBinding validationActions define how failures are enforced.  Allowed values are Ignore or Fail. Defaults to Fail. *)
    failure_policy: string option [@yojson.default None] [@yojson.key "failurePolicy"];
    (* MatchConditions is a list of conditions that must be met for a request to be validated. Match conditions filter requests that have already been matched by the rules, namespaceSelector, and objectSelector. An empty list of matchConditions matches all requests. There are a maximum of 64 match conditions allowed.  If a parameter object is provided, it can be accessed via the `params` handle in the same manner as validation expressions.  The exact matching logic is (in order):   1. If ANY matchCondition evaluates to FALSE, the policy is skipped.   2. If ALL matchConditions evaluate to TRUE, the policy is evaluated.   3. If any matchCondition evaluates to an error (but none are FALSE):      - If failurePolicy=Fail, reject the request      - If failurePolicy=Ignore, the policy is skipped *)
    match_conditions: Io_k8s_api_admissionregistration_v1alpha1_match_condition.t list [@yojson.default []] [@yojson.key "matchConditions"];
    match_constraints: Io_k8s_api_admissionregistration_v1alpha1_match_resources.t option [@yojson.default None] [@yojson.key "matchConstraints"];
    param_kind: Io_k8s_api_admissionregistration_v1alpha1_param_kind.t option [@yojson.default None] [@yojson.key "paramKind"];
    (* Validations contain CEL expressions which is used to apply the validation. Validations and AuditAnnotations may not both be empty; a minimum of one Validations or AuditAnnotations is required. *)
    validations: Io_k8s_api_admissionregistration_v1alpha1_validation.t list [@yojson.default []] [@yojson.key "validations"];
    (* Variables contain definitions of variables that can be used in composition of other expressions. Each variable is defined as a named CEL expression. The variables defined here will be available under `variables` in other expressions of the policy except MatchConditions because MatchConditions are evaluated before the rest of the policy.  The expression of a variable can refer to other variables defined earlier in the list but not those after. Thus, Variables must be sorted by the order of first appearance and acyclic. *)
    variables: Io_k8s_api_admissionregistration_v1alpha1_variable.t list [@yojson.default []] [@yojson.key "variables"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


