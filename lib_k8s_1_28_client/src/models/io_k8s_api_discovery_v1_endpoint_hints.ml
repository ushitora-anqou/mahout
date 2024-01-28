(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_discovery_v1_endpoint_hints.t : EndpointHints provides hints describing how an endpoint should be consumed.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* forZones indicates the zone(s) this endpoint should be consumed by to enable topology aware routing. *)
    for_zones: Io_k8s_api_discovery_v1_for_zone.t list [@yojson.default []] [@yojson.key "forZones"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


