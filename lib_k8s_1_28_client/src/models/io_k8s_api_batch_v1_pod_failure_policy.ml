(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_batch_v1_pod_failure_policy.t : PodFailurePolicy describes how failed pods influence the backoffLimit.
 *)

type t = {
    (* A list of pod failure policy rules. The rules are evaluated in order. Once a rule matches a Pod failure, the remaining of the rules are ignored. When no rule matches the Pod failure, the default handling applies - the counter of pod failures is incremented and it is checked against the backoffLimit. At most 20 elements are allowed. *)
    rules: Io_k8s_api_batch_v1_pod_failure_policy_rule.t list [@default []] [@key "rules"];
} [@@deriving yojson { strict = false }, show ];;

(** PodFailurePolicy describes how failed pods influence the backoffLimit. *)
let create (rules : Io_k8s_api_batch_v1_pod_failure_policy_rule.t list) : t = {
    rules = rules;
}

