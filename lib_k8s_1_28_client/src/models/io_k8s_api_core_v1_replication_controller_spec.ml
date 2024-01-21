(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_replication_controller_spec.t : ReplicationControllerSpec is the specification of a replication controller.
 *)

type t = {
    (* Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready) *)
    min_ready_seconds: int32 option [@default None] [@key minReadySeconds];
    (* Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#what-is-a-replicationcontroller *)
    replicas: int32 option [@default None] [@key replicas];
    (* Selector is a label query over pods that should match the Replicas count. If Selector is empty, it is defaulted to the labels present on the Pod template. Label keys and values that must match in order to be controlled by this replication controller, if empty defaulted to labels on Pod template. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors *)
    selector: Yojson.Safe.t [@key selector];
    template: Io_k8s_api_core_v1_pod_template_spec.t option [@default None] [@key template];
} [@@deriving yojson { strict = false }, show ];;

(** ReplicationControllerSpec is the specification of a replication controller. *)
let create () : t = {
    min_ready_seconds = None;
    replicas = None;
    selector = `List [];
    template = None;
}

