(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_pods_metric_status.t : PodsMetricStatus indicates the current value of a metric describing each pod in the current scale target (for example, transactions-processed-per-second).
 *)

type t = {
    current: Io_k8s_api_autoscaling_v2_metric_value_status.t;
    metric: Io_k8s_api_autoscaling_v2_metric_identifier.t;
} [@@deriving yojson { strict = false }, show ];;

(** PodsMetricStatus indicates the current value of a metric describing each pod in the current scale target (for example, transactions-processed-per-second). *)
let create (current : Io_k8s_api_autoscaling_v2_metric_value_status.t) (metric : Io_k8s_api_autoscaling_v2_metric_identifier.t) : t = {
    current = current;
    metric = metric;
}

