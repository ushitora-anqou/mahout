(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_probe.t : Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic.
 *)

type t = {
    exec: Io_k8s_api_core_v1_exec_action.t option [@default None];
    (* Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1. *)
    failure_threshold: int32 option [@default None];
    grpc: Io_k8s_api_core_v1_grpc_action.t option [@default None];
    http_get: Io_k8s_api_core_v1_http_get_action.t option [@default None];
    (* Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes *)
    initial_delay_seconds: int32 option [@default None];
    (* How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1. *)
    period_seconds: int32 option [@default None];
    (* Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1. *)
    success_threshold: int32 option [@default None];
    tcp_socket: Io_k8s_api_core_v1_tcp_socket_action.t option [@default None];
    (* Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is a beta field and requires enabling ProbeTerminationGracePeriod feature gate. Minimum value is 1. spec.terminationGracePeriodSeconds is used if unset. *)
    termination_grace_period_seconds: int64 option [@default None];
    (* Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes *)
    timeout_seconds: int32 option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic. *)
let create () : t = {
    exec = None;
    failure_threshold = None;
    grpc = None;
    http_get = None;
    initial_delay_seconds = None;
    period_seconds = None;
    success_threshold = None;
    tcp_socket = None;
    termination_grace_period_seconds = None;
    timeout_seconds = None;
}

