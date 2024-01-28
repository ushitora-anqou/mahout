(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_volume_device.t : volumeDevice describes a mapping of a raw block device within a container.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* devicePath is the path inside of the container that the device will be mapped to. *)
    device_path: string [@yojson.key "devicePath"];
    (* name must match the name of a persistentVolumeClaim in the pod *)
    name: string [@yojson.key "name"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


