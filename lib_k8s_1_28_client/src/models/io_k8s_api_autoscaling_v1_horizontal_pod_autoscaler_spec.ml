(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v1_horizontal_pod_autoscaler_spec.t : specification of a horizontal pod autoscaler.
 *)

type t = {
    (* maxReplicas is the upper limit for the number of pods that can be set by the autoscaler; cannot be smaller than MinReplicas. *)
    max_replicas: int32 [@yojson.key "maxReplicas"];
    (* minReplicas is the lower limit for the number of replicas to which the autoscaler can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the alpha feature gate HPAScaleToZero is enabled and at least one Object or External metric is configured.  Scaling is active as long as at least one metric value is available. *)
    min_replicas: int32 option [@yojson.default None] [@yojson.key "minReplicas"];
    scale_target_ref: Io_k8s_api_autoscaling_v1_cross_version_object_reference.t [@yojson.key "scaleTargetRef"];
    (* targetCPUUtilizationPercentage is the target average CPU utilization (represented as a percentage of requested CPU) over all the pods; if not specified the default autoscaling policy will be used. *)
    target_cpu_utilization_percentage: int32 option [@yojson.default None] [@yojson.key "targetCPUUtilizationPercentage"];
} [@@deriving yojson { strict = false }, show, make];;


