(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_deployment_status.t : DeploymentStatus is the most recently observed status of the Deployment.
 *)

type t = {
    (* Total number of available pods (ready for at least minReadySeconds) targeted by this deployment. *)
    available_replicas: int32 option [@default None] [@key "availableReplicas"];
    (* Count of hash collisions for the Deployment. The Deployment controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ReplicaSet. *)
    collision_count: int32 option [@default None] [@key "collisionCount"];
    (* Represents the latest available observations of a deployment's current state. *)
    conditions: Io_k8s_api_apps_v1_deployment_condition.t list [@default []] [@key "conditions"];
    (* The generation observed by the deployment controller. *)
    observed_generation: int64 option [@default None] [@key "observedGeneration"];
    (* readyReplicas is the number of pods targeted by this Deployment with a Ready Condition. *)
    ready_replicas: int32 option [@default None] [@key "readyReplicas"];
    (* Total number of non-terminated pods targeted by this deployment (their labels match the selector). *)
    replicas: int32 option [@default None] [@key "replicas"];
    (* Total number of unavailable pods targeted by this deployment. This is the total number of pods that are still required for the deployment to have 100% available capacity. They may either be pods that are running but not yet available or pods that still have not been created. *)
    unavailable_replicas: int32 option [@default None] [@key "unavailableReplicas"];
    (* Total number of non-terminated pods targeted by this deployment that have the desired template spec. *)
    updated_replicas: int32 option [@default None] [@key "updatedReplicas"];
} [@@deriving yojson { strict = false }, show ];;

(** DeploymentStatus is the most recently observed status of the Deployment. *)
let create () : t = {
    available_replicas = None;
    collision_count = None;
    conditions = [];
    observed_generation = None;
    ready_replicas = None;
    replicas = None;
    unavailable_replicas = None;
    updated_replicas = None;
}

