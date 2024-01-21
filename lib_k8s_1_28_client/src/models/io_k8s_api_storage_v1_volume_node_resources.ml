(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_storage_v1_volume_node_resources.t : VolumeNodeResources is a set of resource limits for scheduling of volumes.
 *)

type t = {
    (* count indicates the maximum number of unique volumes managed by the CSI driver that can be used on a node. A volume that is both attached and mounted on a node is considered to be used once, not twice. The same rule applies for a unique volume that is shared among multiple pods on the same node. If this field is not specified, then the supported number of volumes on this node is unbounded. *)
    count: int32 option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** VolumeNodeResources is a set of resource limits for scheduling of volumes. *)
let create () : t = {
    count = None;
}

