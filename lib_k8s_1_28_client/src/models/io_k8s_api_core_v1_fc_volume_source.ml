(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_fc_volume_source.t : Represents a Fibre Channel volume. Fibre Channel volumes can only be mounted as read/write once. Fibre Channel volumes support ownership management and SELinux relabeling.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* lun is Optional: FC target lun number *)
    lun: int32 option [@yojson.default None] [@yojson.key "lun"];
    (* readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    (* targetWWNs is Optional: FC target worldwide names (WWNs) *)
    target_wwns: string list [@yojson.default []] [@yojson.key "targetWWNs"];
    (* wwids Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously. *)
    wwids: string list [@yojson.default []] [@yojson.key "wwids"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


