(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_rbac_v1_aggregation_rule.t : AggregationRule describes how to locate ClusterRoles to aggregate into the ClusterRole
 *)

type t = {
    (* ClusterRoleSelectors holds a list of selectors which will be used to find ClusterRoles and create the rules. If any of the selectors match, then the ClusterRole's permissions will be added *)
    cluster_role_selectors: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** AggregationRule describes how to locate ClusterRoles to aggregate into the ClusterRole *)
let create () : t = {
    cluster_role_selectors = [];
}

