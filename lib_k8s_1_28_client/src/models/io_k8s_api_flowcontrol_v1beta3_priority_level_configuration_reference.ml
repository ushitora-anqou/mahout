(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_reference.t : PriorityLevelConfigurationReference contains information that points to the \''request-priority\'' being used.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* `name` is the name of the priority level configuration being referenced Required. *)
    name: string [@yojson.key "name"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


