(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta2_resource_policy_rule.t : ResourcePolicyRule is a predicate that matches some resource requests, testing the request's verb and the target resource. A ResourcePolicyRule matches a resource request if and only if: (a) at least one member of verbs matches the request, (b) at least one member of apiGroups matches the request, (c) at least one member of resources matches the request, and (d) either (d1) the request does not specify a namespace (i.e., `Namespace==\''\''`) and clusterScope is true or (d2) the request specifies a namespace and least one member of namespaces matches the request's namespace.
 *)

type t = {
    (* `apiGroups` is a list of matching API groups and may not be empty. \''*\'' matches all API groups and, if present, must be the only entry. Required. *)
    api_groups: string list [@default []] [@key apiGroups];
    (* `clusterScope` indicates whether to match requests that do not specify a namespace (which happens either because the resource is not namespaced or the request targets all namespaces). If this field is omitted or false then the `namespaces` field must contain a non-empty list. *)
    cluster_scope: bool option [@default None] [@key clusterScope];
    (* `namespaces` is a list of target namespaces that restricts matches.  A request that specifies a target namespace matches only if either (a) this list contains that target namespace or (b) this list contains \''*\''.  Note that \''*\'' matches any specified namespace but does not match a request that _does not specify_ a namespace (see the `clusterScope` field for that). This list may be empty, but only if `clusterScope` is true. *)
    namespaces: string list [@default []] [@key namespaces];
    (* `resources` is a list of matching resources (i.e., lowercase and plural) with, if desired, subresource.  For example, [ \''services\'', \''nodes/status\'' ].  This list may not be empty. \''*\'' matches all resources and, if present, must be the only entry. Required. *)
    resources: string list [@default []] [@key resources];
    (* `verbs` is a list of matching verbs and may not be empty. \''*\'' matches all verbs and, if present, must be the only entry. Required. *)
    verbs: string list [@default []] [@key verbs];
} [@@deriving yojson { strict = false }, show ];;

(** ResourcePolicyRule is a predicate that matches some resource requests, testing the request's verb and the target resource. A ResourcePolicyRule matches a resource request if and only if: (a) at least one member of verbs matches the request, (b) at least one member of apiGroups matches the request, (c) at least one member of resources matches the request, and (d) either (d1) the request does not specify a namespace (i.e., `Namespace==\''\''`) and clusterScope is true or (d2) the request specifies a namespace and least one member of namespaces matches the request's namespace. *)
let create (api_groups : string list) (resources : string list) (verbs : string list) : t = {
    api_groups = api_groups;
    cluster_scope = None;
    namespaces = [];
    resources = resources;
    verbs = verbs;
}

