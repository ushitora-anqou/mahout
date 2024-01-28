(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_resource_v1alpha2_pod_scheduling_context_spec.t : PodSchedulingContextSpec describes where resources for the Pod are needed.
 *)

type t = {
    (* PotentialNodes lists nodes where the Pod might be able to run.  The size of this field is limited to 128. This is large enough for many clusters. Larger clusters may need more attempts to find a node that suits all pending resources. This may get increased in the future, but not reduced. *)
    potential_nodes: string list [@yojson.default []] [@yojson.key "potentialNodes"];
    (* SelectedNode is the node for which allocation of ResourceClaims that are referenced by the Pod and that use \''WaitForFirstConsumer\'' allocation is to be attempted. *)
    selected_node: string option [@yojson.default None] [@yojson.key "selectedNode"];
} [@@deriving yojson { strict = false }, show, make];;


