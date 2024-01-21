(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector_requirement.t : A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.
 *)

type t = {
    (* key is the label key that the selector applies to. *)
    key: string;
    (* operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist. *)
    operator: string;
    (* values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch. *)
    values: string list;
} [@@deriving yojson { strict = false }, show ];;

(** A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values. *)
let create (key : string) (operator : string) : t = {
    key = key;
    operator = operator;
    values = [];
}

