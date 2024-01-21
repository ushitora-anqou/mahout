(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t : A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.
 *)

type t = {
    (* matchExpressions is a list of label selector requirements. The requirements are ANDed. *)
    match_expressions: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector_requirement.t list [@default []];
    (* matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \''key\'', the operator is \''In\'', and the values array contains only \''value\''. The requirements are ANDed. *)
    match_labels: Yojson.Safe.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects. *)
let create () : t = {
    match_expressions = [];
    match_labels = [];
}

