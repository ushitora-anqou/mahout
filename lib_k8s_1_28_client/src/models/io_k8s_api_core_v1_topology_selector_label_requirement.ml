(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_topology_selector_label_requirement.t : A topology selector requirement is a selector that matches given label. This is an alpha feature and may change in the future.
 *)

type t = {
    (* The label key that the selector applies to. *)
    key: string;
    (* An array of string values. One value must match the label to be selected. Each entry in Values is ORed. *)
    values: string list;
} [@@deriving yojson { strict = false }, show ];;

(** A topology selector requirement is a selector that matches given label. This is an alpha feature and may change in the future. *)
let create (key : string) (values : string list) : t = {
    key = key;
    values = values;
}

