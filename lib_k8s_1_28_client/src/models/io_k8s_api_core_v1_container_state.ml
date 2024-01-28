(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_container_state.t : ContainerState holds a possible state of container. Only one of its members may be specified. If none of them is specified, the default one is ContainerStateWaiting.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    running: Io_k8s_api_core_v1_container_state_running.t option [@yojson.default None] [@yojson.key "running"];
    terminated: Io_k8s_api_core_v1_container_state_terminated.t option [@yojson.default None] [@yojson.key "terminated"];
    waiting: Io_k8s_api_core_v1_container_state_waiting.t option [@yojson.default None] [@yojson.key "waiting"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


