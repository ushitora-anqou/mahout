(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1beta1_named_rule_with_operations.t : NamedRuleWithOperations is a tuple of Operations and Resources with ResourceNames.
 *)

type t = {
    (* APIGroups is the API groups the resources belong to. '*' is all groups. If '*' is present, the length of the slice must be one. Required. *)
    api_groups: string list [@default []] [@key "apiGroups"];
    (* APIVersions is the API versions the resources belong to. '*' is all versions. If '*' is present, the length of the slice must be one. Required. *)
    api_versions: string list [@default []] [@key "apiVersions"];
    (* Operations is the operations the admission hook cares about - CREATE, UPDATE, DELETE, CONNECT or * for all of those operations and any future admission operations that are added. If '*' is present, the length of the slice must be one. Required. *)
    operations: string list [@default []] [@key "operations"];
    (* ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed. *)
    resource_names: string list [@default []] [@key "resourceNames"];
    (* Resources is a list of resources this rule applies to.  For example: 'pods' means pods. 'pods/log' means the log subresource of pods. '*' means all resources, but not subresources. 'pods/*' means all subresources of pods. '*/scale' means all scale subresources. '*/*' means all resources and their subresources.  If wildcard is present, the validation rule will ensure resources do not overlap with each other.  Depending on the enclosing object, subresources might not be allowed. Required. *)
    resources: string list [@default []] [@key "resources"];
    (* scope specifies the scope of this rule. Valid values are \''Cluster\'', \''Namespaced\'', and \''*\'' \''Cluster\'' means that only cluster-scoped resources will match this rule. Namespace API objects are cluster-scoped. \''Namespaced\'' means that only namespaced resources will match this rule. \''*\'' means that there are no scope restrictions. Subresources match the scope of their parent resource. Default is \''*\''. *)
    scope: string option [@default None] [@key "scope"];
} [@@deriving yojson { strict = false }, show ];;

(** NamedRuleWithOperations is a tuple of Operations and Resources with ResourceNames. *)
let create () : t = {
    api_groups = [];
    api_versions = [];
    operations = [];
    resource_names = [];
    resources = [];
    scope = None;
}

