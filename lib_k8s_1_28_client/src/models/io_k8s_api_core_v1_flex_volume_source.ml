(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_flex_volume_source.t : FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* driver is the name of the driver to use for this volume. *)
    driver: string [@yojson.key "driver"];
    (* fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. The default filesystem depends on FlexVolume script. *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* options is Optional: this field holds extra command options if any. *)
    options: Yojson.Safe.t [@yojson.default (`List [])] [@yojson.key "options"];
    (* readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    secret_ref: Io_k8s_api_core_v1_local_object_reference.t option [@yojson.default None] [@yojson.key "secretRef"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


