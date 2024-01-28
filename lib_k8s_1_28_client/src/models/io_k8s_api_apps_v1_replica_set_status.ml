(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_replica_set_status.t : ReplicaSetStatus represents the current status of a ReplicaSet.
 *)

type t = {
    (* The number of available replicas (ready for at least minReadySeconds) for this replica set. *)
    available_replicas: int32 option [@yojson.default None] [@yojson.key "availableReplicas"];
    (* Represents the latest available observations of a replica set's current state. *)
    conditions: Io_k8s_api_apps_v1_replica_set_condition.t list [@yojson.default []] [@yojson.key "conditions"];
    (* The number of pods that have labels matching the labels of the pod template of the replicaset. *)
    fully_labeled_replicas: int32 option [@yojson.default None] [@yojson.key "fullyLabeledReplicas"];
    (* ObservedGeneration reflects the generation of the most recently observed ReplicaSet. *)
    observed_generation: int64 option [@yojson.default None] [@yojson.key "observedGeneration"];
    (* readyReplicas is the number of pods targeted by this ReplicaSet with a Ready Condition. *)
    ready_replicas: int32 option [@yojson.default None] [@yojson.key "readyReplicas"];
    (* Replicas is the most recently observed number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#what-is-a-replicationcontroller *)
    replicas: int32 [@yojson.key "replicas"];
} [@@deriving yojson { strict = false }, show, make];;


