(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_user_subject.t : UserSubject holds detailed information for user-kind subject.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* `name` is the username that matches, or \''*\'' to match all usernames. Required. *)
    name: string [@yojson.key "name"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


