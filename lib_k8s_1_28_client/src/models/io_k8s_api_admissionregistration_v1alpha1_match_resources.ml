(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1alpha1_match_resources.t : MatchResources decides whether to run the admission control policy on an object based on whether it meets the match criteria. The exclude rules take precedence over include rules (if a resource matches both, it is excluded)
 *)

type t = {
    (* ExcludeResourceRules describes what operations on what resources/subresources the ValidatingAdmissionPolicy should not care about. The exclude rules take precedence over include rules (if a resource matches both, it is excluded) *)
    exclude_resource_rules: Io_k8s_api_admissionregistration_v1alpha1_named_rule_with_operations.t list [@default []];
    (* matchPolicy defines how the \''MatchResources\'' list is used to match incoming requests. Allowed values are \''Exact\'' or \''Equivalent\''.  - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but \''rules\'' only included `apiGroups:[\''apps\''], apiVersions:[\''v1\''], resources: [\''deployments\'']`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the ValidatingAdmissionPolicy.  - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and \''rules\'' only included `apiGroups:[\''apps\''], apiVersions:[\''v1\''], resources: [\''deployments\'']`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the ValidatingAdmissionPolicy.  Defaults to \''Equivalent\'' *)
    match_policy: string option [@default None];
    namespace_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None];
    object_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None];
    (* ResourceRules describes what operations on what resources/subresources the ValidatingAdmissionPolicy matches. The policy cares about an operation if it matches _any_ Rule. *)
    resource_rules: Io_k8s_api_admissionregistration_v1alpha1_named_rule_with_operations.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** MatchResources decides whether to run the admission control policy on an object based on whether it meets the match criteria. The exclude rules take precedence over include rules (if a resource matches both, it is excluded) *)
let create () : t = {
    exclude_resource_rules = [];
    match_policy = None;
    namespace_selector = None;
    object_selector = None;
    resource_rules = [];
}

