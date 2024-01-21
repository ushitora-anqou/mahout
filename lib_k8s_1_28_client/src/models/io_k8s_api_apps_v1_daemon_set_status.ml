(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_daemon_set_status.t : DaemonSetStatus represents the current status of a daemon set.
 *)

type t = {
    (* Count of hash collisions for the DaemonSet. The DaemonSet controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ControllerRevision. *)
    collision_count: int32 option [@default None];
    (* Represents the latest available observations of a DaemonSet's current state. *)
    conditions: Io_k8s_api_apps_v1_daemon_set_condition.t list;
    (* The number of nodes that are running at least 1 daemon pod and are supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/ *)
    current_number_scheduled: int32;
    (* The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod). More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/ *)
    desired_number_scheduled: int32;
    (* The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds) *)
    number_available: int32 option [@default None];
    (* The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod. More info: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/ *)
    number_misscheduled: int32;
    (* numberReady is the number of nodes that should be running the daemon pod and have one or more of the daemon pod running with a Ready Condition. *)
    number_ready: int32;
    (* The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds) *)
    number_unavailable: int32 option [@default None];
    (* The most recent generation observed by the daemon set controller. *)
    observed_generation: int64 option [@default None];
    (* The total number of nodes that are running updated daemon pod *)
    updated_number_scheduled: int32 option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** DaemonSetStatus represents the current status of a daemon set. *)
let create (current_number_scheduled : int32) (desired_number_scheduled : int32) (number_misscheduled : int32) (number_ready : int32) : t = {
    collision_count = None;
    conditions = [];
    current_number_scheduled = current_number_scheduled;
    desired_number_scheduled = desired_number_scheduled;
    number_available = None;
    number_misscheduled = number_misscheduled;
    number_ready = number_ready;
    number_unavailable = None;
    observed_generation = None;
    updated_number_scheduled = None;
}

