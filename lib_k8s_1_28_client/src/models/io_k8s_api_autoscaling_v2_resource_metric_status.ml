(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_resource_metric_status.t : ResourceMetricStatus indicates the current value of a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the \''pods\'' source.
 *)

type t = {
    current: Io_k8s_api_autoscaling_v2_metric_value_status.t;
    (* name is the name of the resource in question. *)
    name: string;
} [@@deriving yojson { strict = false }, show ];;

(** ResourceMetricStatus indicates the current value of a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the \''pods\'' source. *)
let create (current : Io_k8s_api_autoscaling_v2_metric_value_status.t) (name : string) : t = {
    current = current;
    name = name;
}

