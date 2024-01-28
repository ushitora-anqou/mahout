(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authentication_v1_token_review_spec.t : TokenReviewSpec is a description of the token authentication request.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* Audiences is a list of the identifiers that the resource server presented with the token identifies as. Audience-aware token authenticators will verify that the token was intended for at least one of the audiences in this list. If no audiences are provided, the audience will default to the audience of the Kubernetes apiserver. *)
    audiences: string list [@yojson.default []] [@yojson.key "audiences"];
    (* Token is the opaque bearer token. *)
    token: string option [@yojson.default None] [@yojson.key "token"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


