(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1alpha1_variable.t : Variable is the definition of a variable that is used for composition.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* Expression is the expression that will be evaluated as the value of the variable. The CEL expression has access to the same identifiers as the CEL expressions in Validation. *)
    expression: string [@yojson.key "expression"];
    (* Name is the name of the variable. The name must be a valid CEL identifier and unique among all variables. The variable can be accessed in other expressions through `variables` For example, if name is \''foo\'', the variable will be available as `variables.foo` *)
    name: string [@yojson.key "name"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


