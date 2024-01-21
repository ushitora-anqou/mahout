(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_node_v1_overhead.t : Overhead structure represents the resource overhead associated with running a pod.
 *)

type t = {
    (* podFixed represents the fixed resource overhead associated with running a pod. *)
    pod_fixed: (string * string) list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** Overhead structure represents the resource overhead associated with running a pod. *)
let create () : t = {
    pod_fixed = [];
}

