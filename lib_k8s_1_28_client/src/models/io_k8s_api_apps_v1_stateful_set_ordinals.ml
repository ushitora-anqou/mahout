(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_stateful_set_ordinals.t : StatefulSetOrdinals describes the policy used for replica ordinal assignment in this StatefulSet.
 *)

type t = {
    (* start is the number representing the first replica's index. It may be used to number replicas from an alternate index (eg: 1-indexed) over the default 0-indexed names, or to orchestrate progressive movement of replicas from one StatefulSet to another. If set, replica indices will be in the range:   [.spec.ordinals.start, .spec.ordinals.start + .spec.replicas). If unset, defaults to 0. Replica indices will be in the range:   [0, .spec.replicas). *)
    start: int32 option [@default None] [@key start];
} [@@deriving yojson { strict = false }, show ];;

(** StatefulSetOrdinals describes the policy used for replica ordinal assignment in this StatefulSet. *)
let create () : t = {
    start = None;
}

