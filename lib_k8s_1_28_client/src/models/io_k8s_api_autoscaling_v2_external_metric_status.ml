(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_external_metric_status.t : ExternalMetricStatus indicates the current value of a global metric not associated with any Kubernetes object.
 *)

type t = {
    current: Io_k8s_api_autoscaling_v2_metric_value_status.t [@key "current"];
    metric: Io_k8s_api_autoscaling_v2_metric_identifier.t [@key "metric"];
} [@@deriving yojson { strict = false }, show ];;

(** ExternalMetricStatus indicates the current value of a global metric not associated with any Kubernetes object. *)
let create (current : Io_k8s_api_autoscaling_v2_metric_value_status.t) (metric : Io_k8s_api_autoscaling_v2_metric_identifier.t) : t = {
    current = current;
    metric = metric;
}

