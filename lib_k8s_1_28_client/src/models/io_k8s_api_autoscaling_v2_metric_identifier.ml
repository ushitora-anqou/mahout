(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_metric_identifier.t : MetricIdentifier defines the name and optionally selector for a metric
 *)

type t = {
    (* name is the name of the given metric *)
    name: string [@key name];
    selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None] [@key selector];
} [@@deriving yojson { strict = false }, show ];;

(** MetricIdentifier defines the name and optionally selector for a metric *)
let create (name : string) : t = {
    name = name;
    selector = None;
}

