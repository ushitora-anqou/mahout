(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_topology_selector_term.t : A topology selector term represents the result of label queries. A null or empty topology selector term matches no objects. The requirements of them are ANDed. It provides a subset of functionality as NodeSelectorTerm. This is an alpha feature and may change in the future.
 *)

type t = {
    (* A list of topology selector requirements by labels. *)
    match_label_expressions: Io_k8s_api_core_v1_topology_selector_label_requirement.t list [@yojson.default []] [@yojson.key "matchLabelExpressions"];
} [@@deriving yojson { strict = false }, show, make];;


