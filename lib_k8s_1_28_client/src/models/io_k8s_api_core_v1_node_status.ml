(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_node_status.t : NodeStatus is information about the current status of a node.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
end)
type t = {
    (* List of addresses reachable to the node. Queried from cloud provider, if available. More info: https://kubernetes.io/docs/concepts/nodes/node/#addresses Note: This field is declared as mergeable, but the merge key is not sufficiently unique, which can cause data corruption when it is merged. Callers should instead use a full-replacement patch. See https://pr.k8s.io/79391 for an example. Consumers should assume that addresses can change during the lifetime of a Node. However, there are some exceptions where this may not be possible, such as Pods that inherit a Node's address in its own status or consumers of the downward API (status.hostIP). *)
    addresses: Io_k8s_api_core_v1_node_address.t list [@default []] [@yojson.key "addresses"];
    (* Allocatable represents the resources of a node that are available for scheduling. Defaults to Capacity. *)
    allocatable: any [@default (`Assoc [])] [@yojson.key "allocatable"];
    (* Capacity represents the total resources of a node. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#capacity *)
    capacity: any [@default (`Assoc [])] [@yojson.key "capacity"];
    (* Conditions is an array of current observed node conditions. More info: https://kubernetes.io/docs/concepts/nodes/node/#condition *)
    conditions: Io_k8s_api_core_v1_node_condition.t list [@default []] [@yojson.key "conditions"];
    config: Io_k8s_api_core_v1_node_config_status.t option [@yojson.default None] [@yojson.key "config"];
    daemon_endpoints: Io_k8s_api_core_v1_node_daemon_endpoints.t option [@yojson.default None] [@yojson.key "daemonEndpoints"];
    (* List of container images on this node *)
    images: Io_k8s_api_core_v1_container_image.t list [@default []] [@yojson.key "images"];
    node_info: Io_k8s_api_core_v1_node_system_info.t option [@yojson.default None] [@yojson.key "nodeInfo"];
    (* NodePhase is the recently observed lifecycle phase of the node. More info: https://kubernetes.io/docs/concepts/nodes/node/#phase The field is never populated, and now is deprecated. *)
    phase: string option [@yojson.default None] [@yojson.key "phase"];
    (* List of volumes that are attached to the node. *)
    volumes_attached: Io_k8s_api_core_v1_attached_volume.t list [@default []] [@yojson.key "volumesAttached"];
    (* List of attachable volumes in use (mounted) by the node. *)
    volumes_in_use: string list [@default []] [@yojson.key "volumesInUse"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


