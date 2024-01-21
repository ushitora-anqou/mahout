(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_resource_quota_status.t : ResourceQuotaStatus defines the enforced hard limits and observed use.
 *)

type t = {
    (* Hard is the set of enforced hard limits for each named resource. More info: https://kubernetes.io/docs/concepts/policy/resource-quotas/ *)
    hard: Yojson.Safe.t [@default (`List [])] [@key "hard"];
    (* Used is the current observed total usage of the resource in the namespace. *)
    used: Yojson.Safe.t [@default (`List [])] [@key "used"];
} [@@deriving yojson { strict = false }, show ];;

(** ResourceQuotaStatus defines the enforced hard limits and observed use. *)
let create () : t = {
    hard = `List [];
    used = `List [];
}

