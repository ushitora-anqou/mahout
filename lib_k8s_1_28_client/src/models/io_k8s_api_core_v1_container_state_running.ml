(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_container_state_running.t : ContainerStateRunning is a running state of a container.
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    started_at: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** ContainerStateRunning is a running state of a container. *)
let create () : t = {
    started_at = None;
}

