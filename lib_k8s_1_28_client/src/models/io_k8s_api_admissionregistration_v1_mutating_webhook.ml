(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1_mutating_webhook.t : MutatingWebhook describes an admission webhook and the resources and operations it applies to.
 *)

type t = {
    (* AdmissionReviewVersions is an ordered list of preferred `AdmissionReview` versions the Webhook expects. API server will try to use first version in the list which it supports. If none of the versions specified in this list supported by API server, validation will fail for this object. If a persisted webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail and be subject to the failure policy. *)
    admission_review_versions: string list [@default []] [@key "admissionReviewVersions"];
    client_config: Io_k8s_api_admissionregistration_v1_webhook_client_config.t [@key "clientConfig"];
    (* FailurePolicy defines how unrecognized errors from the admission endpoint are handled - allowed values are Ignore or Fail. Defaults to Fail. *)
    failure_policy: string option [@default None] [@key "failurePolicy"];
    (* MatchConditions is a list of conditions that must be met for a request to be sent to this webhook. Match conditions filter requests that have already been matched by the rules, namespaceSelector, and objectSelector. An empty list of matchConditions matches all requests. There are a maximum of 64 match conditions allowed.  The exact matching logic is (in order):   1. If ANY matchCondition evaluates to FALSE, the webhook is skipped.   2. If ALL matchConditions evaluate to TRUE, the webhook is called.   3. If any matchCondition evaluates to an error (but none are FALSE):      - If failurePolicy=Fail, reject the request      - If failurePolicy=Ignore, the error is ignored and the webhook is skipped  This is a beta feature and managed by the AdmissionWebhookMatchConditions feature gate. *)
    match_conditions: Io_k8s_api_admissionregistration_v1_match_condition.t list [@default []] [@key "matchConditions"];
    (* matchPolicy defines how the \''rules\'' list is used to match incoming requests. Allowed values are \''Exact\'' or \''Equivalent\''.  - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but \''rules\'' only included `apiGroups:[\''apps\''], apiVersions:[\''v1\''], resources: [\''deployments\'']`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the webhook.  - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and \''rules\'' only included `apiGroups:[\''apps\''], apiVersions:[\''v1\''], resources: [\''deployments\'']`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the webhook.  Defaults to \''Equivalent\'' *)
    match_policy: string option [@default None] [@key "matchPolicy"];
    (* The name of the admission webhook. Name should be fully qualified, e.g., imagepolicy.kubernetes.io, where \''imagepolicy\'' is the name of the webhook, and kubernetes.io is the name of the organization. Required. *)
    name: string [@key "name"];
    namespace_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None] [@key "namespaceSelector"];
    object_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None] [@key "objectSelector"];
    (* reinvocationPolicy indicates whether this webhook should be called multiple times as part of a single admission evaluation. Allowed values are \''Never\'' and \''IfNeeded\''.  Never: the webhook will not be called more than once in a single admission evaluation.  IfNeeded: the webhook will be called at least one additional time as part of the admission evaluation if the object being admitted is modified by other admission plugins after the initial webhook call. Webhooks that specify this option *must* be idempotent, able to process objects they previously admitted. Note: * the number of additional invocations is not guaranteed to be exactly one. * if additional invocations result in further modifications to the object, webhooks are not guaranteed to be invoked again. * webhooks that use this option may be reordered to minimize the number of additional invocations. * to validate an object after all mutations are guaranteed complete, use a validating admission webhook instead.  Defaults to \''Never\''. *)
    reinvocation_policy: string option [@default None] [@key "reinvocationPolicy"];
    (* Rules describes what operations on what resources/subresources the webhook cares about. The webhook cares about an operation if it matches _any_ Rule. However, in order to prevent ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks from putting the cluster in a state which cannot be recovered from without completely disabling the plugin, ValidatingAdmissionWebhooks and MutatingAdmissionWebhooks are never called on admission requests for ValidatingWebhookConfiguration and MutatingWebhookConfiguration objects. *)
    rules: Io_k8s_api_admissionregistration_v1_rule_with_operations.t list [@default []] [@key "rules"];
    (* SideEffects states whether this webhook has side effects. Acceptable values are: None, NoneOnDryRun (webhooks created via v1beta1 may also specify Some or Unknown). Webhooks with side effects MUST implement a reconciliation system, since a request may be rejected by a future step in the admission chain and the side effects therefore need to be undone. Requests with the dryRun attribute will be auto-rejected if they match a webhook with sideEffects == Unknown or Some. *)
    side_effects: string [@key "sideEffects"];
    (* TimeoutSeconds specifies the timeout for this webhook. After the timeout passes, the webhook call will be ignored or the API call will fail based on the failure policy. The timeout value must be between 1 and 30 seconds. Default to 10 seconds. *)
    timeout_seconds: int32 option [@default None] [@key "timeoutSeconds"];
} [@@deriving yojson { strict = false }, show ];;

(** MutatingWebhook describes an admission webhook and the resources and operations it applies to. *)
let create (admission_review_versions : string list) (client_config : Io_k8s_api_admissionregistration_v1_webhook_client_config.t) (name : string) (side_effects : string) : t = {
    admission_review_versions = admission_review_versions;
    client_config = client_config;
    failure_policy = None;
    match_conditions = [];
    match_policy = None;
    name = name;
    namespace_selector = None;
    object_selector = None;
    reinvocation_policy = None;
    rules = [];
    side_effects = side_effects;
    timeout_seconds = None;
}

