(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_container_state_terminated.t : ContainerStateTerminated is a terminated state of a container.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* Container's ID in the format '<type>://<container_id>' *)
    container_id: string option [@yojson.default None] [@yojson.key "containerID"];
    (* Exit status from the last termination of the container *)
    exit_code: int32 [@yojson.key "exitCode"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    finished_at: string option [@yojson.default None] [@yojson.key "finishedAt"];
    (* Message regarding the last termination of the container *)
    message: string option [@yojson.default None] [@yojson.key "message"];
    (* (brief) reason from the last termination of the container *)
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    (* Signal from the last termination of the container *)
    signal: int32 option [@yojson.default None] [@yojson.key "signal"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    started_at: string option [@yojson.default None] [@yojson.key "startedAt"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


