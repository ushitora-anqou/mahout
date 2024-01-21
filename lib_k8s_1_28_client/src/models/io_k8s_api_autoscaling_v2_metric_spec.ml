(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_metric_spec.t : MetricSpec specifies how to scale based on a single metric (only `type` and one other matching field should be set at once).
 *)

type t = {
    container_resource: Io_k8s_api_autoscaling_v2_container_resource_metric_source.t option [@default None];
    _external: Io_k8s_api_autoscaling_v2_external_metric_source.t option [@default None];
    _object: Io_k8s_api_autoscaling_v2_object_metric_source.t option [@default None];
    pods: Io_k8s_api_autoscaling_v2_pods_metric_source.t option [@default None];
    resource: Io_k8s_api_autoscaling_v2_resource_metric_source.t option [@default None];
    (* type is the type of metric source.  It should be one of \''ContainerResource\'', \''External\'', \''Object\'', \''Pods\'' or \''Resource\'', each mapping to a matching field in the object. Note: \''ContainerResource\'' type is available on when the feature-gate HPAContainerMetrics is enabled *)
    _type: string;
} [@@deriving yojson { strict = false }, show ];;

(** MetricSpec specifies how to scale based on a single metric (only `type` and one other matching field should be set at once). *)
let create (_type : string) : t = {
    container_resource = None;
    _external = None;
    _object = None;
    pods = None;
    resource = None;
    _type = _type;
}

