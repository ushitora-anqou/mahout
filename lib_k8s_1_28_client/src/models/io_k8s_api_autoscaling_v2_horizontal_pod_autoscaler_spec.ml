(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler_spec.t : HorizontalPodAutoscalerSpec describes the desired functionality of the HorizontalPodAutoscaler.
 *)

type t = {
    behavior: Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler_behavior.t option [@default None];
    (* maxReplicas is the upper limit for the number of replicas to which the autoscaler can scale up. It cannot be less that minReplicas. *)
    max_replicas: int32;
    (* metrics contains the specifications for which to use to calculate the desired replica count (the maximum replica count across all metrics will be used).  The desired replica count is calculated multiplying the ratio between the target value and the current value by the current number of pods.  Ergo, metrics used must decrease as the pod count is increased, and vice-versa.  See the individual metric source types for more information about how each type of metric must respond. If not set, the default metric will be set to 80% average CPU utilization. *)
    metrics: Io_k8s_api_autoscaling_v2_metric_spec.t list [@default []];
    (* minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the alpha feature gate HPAScaleToZero is enabled and at least one Object or External metric is configured.  Scaling is active as long as at least one metric value is available. *)
    min_replicas: int32 option [@default None];
    scale_target_ref: Io_k8s_api_autoscaling_v2_cross_version_object_reference.t;
} [@@deriving yojson { strict = false }, show ];;

(** HorizontalPodAutoscalerSpec describes the desired functionality of the HorizontalPodAutoscaler. *)
let create (max_replicas : int32) (scale_target_ref : Io_k8s_api_autoscaling_v2_cross_version_object_reference.t) : t = {
    behavior = None;
    max_replicas = max_replicas;
    metrics = [];
    min_replicas = None;
    scale_target_ref = scale_target_ref;
}

