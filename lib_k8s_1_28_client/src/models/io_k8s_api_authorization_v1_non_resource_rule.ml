(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authorization_v1_non_resource_rule.t : NonResourceRule holds information that describes a rule for the non-resource
 *)

type t = {
    (* NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path.  \''*\'' means all. *)
    non_resource_urls: string list;
    (* Verb is a list of kubernetes non-resource API verbs, like: get, post, put, delete, patch, head, options.  \''*\'' means all. *)
    verbs: string list;
} [@@deriving yojson { strict = false }, show ];;

(** NonResourceRule holds information that describes a rule for the non-resource *)
let create (verbs : string list) : t = {
    non_resource_urls = [];
    verbs = verbs;
}

