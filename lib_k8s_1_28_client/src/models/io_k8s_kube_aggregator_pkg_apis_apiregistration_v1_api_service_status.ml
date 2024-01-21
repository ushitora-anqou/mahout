(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_kube_aggregator_pkg_apis_apiregistration_v1_api_service_status.t : APIServiceStatus contains derived information about an API server
 *)

type t = {
    (* Current service state of apiService. *)
    conditions: Io_k8s_kube_aggregator_pkg_apis_apiregistration_v1_api_service_condition.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** APIServiceStatus contains derived information about an API server *)
let create () : t = {
    conditions = [];
}

