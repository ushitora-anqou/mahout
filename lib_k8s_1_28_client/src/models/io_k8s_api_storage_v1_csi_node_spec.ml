(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_storage_v1_csi_node_spec.t : CSINodeSpec holds information about the specification of all CSI drivers installed on a node
 *)

type t = {
    (* drivers is a list of information of all CSI Drivers existing on a node. If all drivers in the list are uninstalled, this can become empty. *)
    drivers: Io_k8s_api_storage_v1_csi_node_driver.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** CSINodeSpec holds information about the specification of all CSI drivers installed on a node *)
let create (drivers : Io_k8s_api_storage_v1_csi_node_driver.t list) : t = {
    drivers = drivers;
}

