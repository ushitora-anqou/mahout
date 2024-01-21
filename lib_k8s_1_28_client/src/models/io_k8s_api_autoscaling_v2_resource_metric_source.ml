(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_resource_metric_source.t : ResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the \''pods\'' source.  Only one \''target\'' type should be set.
 *)

type t = {
    (* name is the name of the resource in question. *)
    name: string;
    target: Io_k8s_api_autoscaling_v2_metric_target.t;
} [@@deriving yojson { strict = false }, show ];;

(** ResourceMetricSource indicates how to scale on a resource metric known to Kubernetes, as specified in requests and limits, describing each pod in the current scale target (e.g. CPU or memory).  The values will be averaged together before being compared to the target.  Such metrics are built in to Kubernetes, and have special scaling options on top of those available to normal per-pod metrics using the \''pods\'' source.  Only one \''target\'' type should be set. *)
let create (name : string) (target : Io_k8s_api_autoscaling_v2_metric_target.t) : t = {
    name = name;
    target = target;
}

