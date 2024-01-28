(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_status.t : PriorityLevelConfigurationStatus represents the current state of a \''request-priority\''.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* `conditions` is the current state of \''request-priority\''. *)
    conditions: Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_condition.t list [@yojson.default []] [@yojson.key "conditions"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


