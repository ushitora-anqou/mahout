(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_rbac_v1_policy_rule.t : PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to.
 *)

type t = {
    (* APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. \''\'' represents the core API group and \''*\'' represents all API groups. *)
    api_groups: string list [@default []];
    (* NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as \''pods\'' or \''secrets\'') or non-resource URL paths (such as \''/api\''),  but not both. *)
    non_resource_urls: string list [@default []];
    (* ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed. *)
    resource_names: string list [@default []];
    (* Resources is a list of resources this rule applies to. '*' represents all resources. *)
    resources: string list [@default []];
    (* Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs. *)
    verbs: string list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to. *)
let create (verbs : string list) : t = {
    api_groups = [];
    non_resource_urls = [];
    resource_names = [];
    resources = [];
    verbs = verbs;
}

