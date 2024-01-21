(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_node_v1_scheduling.t : Scheduling specifies the scheduling constraints for nodes supporting a RuntimeClass.
 *)

type t = {
    (* nodeSelector lists labels that must be present on nodes that support this RuntimeClass. Pods using this RuntimeClass can only be scheduled to a node matched by this selector. The RuntimeClass nodeSelector is merged with a pod's existing nodeSelector. Any conflicts will cause the pod to be rejected in admission. *)
    node_selector: (string * string) list;
    (* tolerations are appended (excluding duplicates) to pods running with this RuntimeClass during admission, effectively unioning the set of nodes tolerated by the pod and the RuntimeClass. *)
    tolerations: Io_k8s_api_core_v1_toleration.t list;
} [@@deriving yojson { strict = false }, show ];;

(** Scheduling specifies the scheduling constraints for nodes supporting a RuntimeClass. *)
let create () : t = {
    node_selector = [];
    tolerations = [];
}

