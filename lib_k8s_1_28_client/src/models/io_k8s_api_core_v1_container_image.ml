(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_container_image.t : Describe a container image
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* Names by which this image is known. e.g. [\''kubernetes.example/hyperkube:v1.0.7\'', \''cloud-vendor.registry.example/cloud-vendor/hyperkube:v1.0.7\''] *)
    names: string list [@yojson.default []] [@yojson.key "names"];
    (* The size of the image in bytes. *)
    size_bytes: int64 option [@yojson.default None] [@yojson.key "sizeBytes"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


