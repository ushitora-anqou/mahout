(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_photon_persistent_disk_volume_source.t : Represents a Photon Controller persistent disk resource.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* pdID is the ID that identifies Photon Controller persistent disk *)
    pd_id: string [@yojson.key "pdID"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


