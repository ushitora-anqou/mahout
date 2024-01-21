(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_stateful_set_status.t : StatefulSetStatus represents the current state of a StatefulSet.
 *)

type t = {
    (* Total number of available pods (ready for at least minReadySeconds) targeted by this statefulset. *)
    available_replicas: int32 option [@default None];
    (* collisionCount is the count of hash collisions for the StatefulSet. The StatefulSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision. *)
    collision_count: int32 option [@default None];
    (* Represents the latest available observations of a statefulset's current state. *)
    conditions: Io_k8s_api_apps_v1_stateful_set_condition.t list [@default []];
    (* currentReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision. *)
    current_replicas: int32 option [@default None];
    (* currentRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [0,currentReplicas). *)
    current_revision: string option [@default None];
    (* observedGeneration is the most recent generation observed for this StatefulSet. It corresponds to the StatefulSet's generation, which is updated on mutation by the API Server. *)
    observed_generation: int64 option [@default None];
    (* readyReplicas is the number of pods created for this StatefulSet with a Ready Condition. *)
    ready_replicas: int32 option [@default None];
    (* replicas is the number of Pods created by the StatefulSet controller. *)
    replicas: int32;
    (* updateRevision, if not empty, indicates the version of the StatefulSet used to generate Pods in the sequence [replicas-updatedReplicas,replicas) *)
    update_revision: string option [@default None];
    (* updatedReplicas is the number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision. *)
    updated_replicas: int32 option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** StatefulSetStatus represents the current state of a StatefulSet. *)
let create (replicas : int32) : t = {
    available_replicas = None;
    collision_count = None;
    conditions = [];
    current_replicas = None;
    current_revision = None;
    observed_generation = None;
    ready_replicas = None;
    replicas = replicas;
    update_revision = None;
    updated_replicas = None;
}

