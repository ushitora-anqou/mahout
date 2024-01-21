(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_object_metric_status.t : ObjectMetricStatus indicates the current value of a metric describing a kubernetes object (for example, hits-per-second on an Ingress object).
 *)

type t = {
    current: Io_k8s_api_autoscaling_v2_metric_value_status.t;
    described_object: Io_k8s_api_autoscaling_v2_cross_version_object_reference.t;
    metric: Io_k8s_api_autoscaling_v2_metric_identifier.t;
} [@@deriving yojson { strict = false }, show ];;

(** ObjectMetricStatus indicates the current value of a metric describing a kubernetes object (for example, hits-per-second on an Ingress object). *)
let create (current : Io_k8s_api_autoscaling_v2_metric_value_status.t) (described_object : Io_k8s_api_autoscaling_v2_cross_version_object_reference.t) (metric : Io_k8s_api_autoscaling_v2_metric_identifier.t) : t = {
    current = current;
    described_object = described_object;
    metric = metric;
}

