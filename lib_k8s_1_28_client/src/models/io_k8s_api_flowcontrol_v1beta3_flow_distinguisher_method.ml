(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_flow_distinguisher_method.t : FlowDistinguisherMethod specifies the method of a flow distinguisher.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* `type` is the type of flow distinguisher method The supported types are \''ByUser\'' and \''ByNamespace\''. Required. *)
    _type: string [@yojson.key "type"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


