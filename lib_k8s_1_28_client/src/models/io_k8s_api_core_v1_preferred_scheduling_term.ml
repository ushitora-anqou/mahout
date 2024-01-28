(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_preferred_scheduling_term.t : An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).
 *)

type t = {
    preference: Io_k8s_api_core_v1_node_selector_term.t [@yojson.key "preference"];
    (* Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100. *)
    weight: int32 [@yojson.key "weight"];
} [@@deriving yojson { strict = false }, show, make];;


