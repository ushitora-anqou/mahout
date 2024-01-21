(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_weighted_pod_affinity_term.t : The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)
 *)

type t = {
    pod_affinity_term: Io_k8s_api_core_v1_pod_affinity_term.t [@key "podAffinityTerm"];
    (* weight associated with matching the corresponding podAffinityTerm, in the range 1-100. *)
    weight: int32 [@key "weight"];
} [@@deriving yojson { strict = false }, show ];;

(** The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s) *)
let create (pod_affinity_term : Io_k8s_api_core_v1_pod_affinity_term.t) (weight : int32) : t = {
    pod_affinity_term = pod_affinity_term;
    weight = weight;
}

