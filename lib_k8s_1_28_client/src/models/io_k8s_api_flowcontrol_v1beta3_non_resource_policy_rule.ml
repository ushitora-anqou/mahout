(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_non_resource_policy_rule.t : NonResourcePolicyRule is a predicate that matches non-resource requests according to their verb and the target non-resource URL. A NonResourcePolicyRule matches a request if and only if both (a) at least one member of verbs matches the request and (b) at least one member of nonResourceURLs matches the request.
 *)

type t = {
    (* `nonResourceURLs` is a set of url prefixes that a user should have access to and may not be empty. For example:   - \''/healthz\'' is legal   - \''/hea*\'' is illegal   - \''/hea\'' is legal but matches nothing   - \''/hea/*\'' also matches nothing   - \''/healthz/*\'' matches all per-component health checks. \''*\'' matches all non-resource urls. if it is present, it must be the only entry. Required. *)
    non_resource_urls: string list [@yojson.default []] [@yojson.key "nonResourceURLs"];
    (* `verbs` is a list of matching verbs and may not be empty. \''*\'' matches all verbs. If it is present, it must be the only entry. Required. *)
    verbs: string list [@yojson.default []] [@yojson.key "verbs"];
} [@@deriving yojson { strict = false }, show, make];;


