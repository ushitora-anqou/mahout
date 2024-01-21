(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v2_horizontal_pod_autoscaler_behavior.t : HorizontalPodAutoscalerBehavior configures the scaling behavior of the target in both Up and Down directions (scaleUp and scaleDown fields respectively).
 *)

type t = {
    scale_down: Io_k8s_api_autoscaling_v2_hpa_scaling_rules.t option [@default None] [@key scaleDown];
    scale_up: Io_k8s_api_autoscaling_v2_hpa_scaling_rules.t option [@default None] [@key scaleUp];
} [@@deriving yojson { strict = false }, show ];;

(** HorizontalPodAutoscalerBehavior configures the scaling behavior of the target in both Up and Down directions (scaleUp and scaleDown fields respectively). *)
let create () : t = {
    scale_down = None;
    scale_up = None;
}

