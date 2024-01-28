(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authorization_v1_resource_rule.t : ResourceRule is the list of actions the subject is allowed to perform on resources. The list ordering isn't significant, may contain duplicates, and possibly be incomplete.
 *)

type t = {
    (* APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed.  \''*\'' means all. *)
    api_groups: string list [@yojson.default []] [@yojson.key "apiGroups"];
    (* ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.  \''*\'' means all. *)
    resource_names: string list [@yojson.default []] [@yojson.key "resourceNames"];
    (* Resources is a list of resources this rule applies to.  \''*\'' means all in the specified apiGroups.  \''*/foo\'' represents the subresource 'foo' for all resources in the specified apiGroups. *)
    resources: string list [@yojson.default []] [@yojson.key "resources"];
    (* Verb is a list of kubernetes resource API verbs, like: get, list, watch, create, update, delete, proxy.  \''*\'' means all. *)
    verbs: string list [@yojson.default []] [@yojson.key "verbs"];
} [@@deriving yojson { strict = false }, show, make];;


