(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_pod_anti_affinity.t : Pod anti affinity is a group of inter pod anti affinity scheduling rules.
 *)

type t = {
    (* The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \''weight\'' to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred. *)
    preferred_during_scheduling_ignored_during_execution: Io_k8s_api_core_v1_weighted_pod_affinity_term.t list [@default []] [@key "preferredDuringSchedulingIgnoredDuringExecution"];
    (* If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied. *)
    required_during_scheduling_ignored_during_execution: Io_k8s_api_core_v1_pod_affinity_term.t list [@default []] [@key "requiredDuringSchedulingIgnoredDuringExecution"];
} [@@deriving yojson { strict = false }, show ];;

(** Pod anti affinity is a group of inter pod anti affinity scheduling rules. *)
let create () : t = {
    preferred_during_scheduling_ignored_during_execution = [];
    required_during_scheduling_ignored_during_execution = [];
}

