(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_local_volume_source.t : Local represents directly-attached storage with node affinity (Beta feature)
 *)

type t = {
    (* fsType is the filesystem type to mount. It applies only when the Path is a block device. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. The default value is to auto-select a filesystem if unspecified. *)
    fs_type: string option [@default None] [@key fsType];
    (* path of the full path to the volume on the node. It can be either a directory or block device (disk, partition, ...). *)
    path: string [@key path];
} [@@deriving yojson { strict = false }, show ];;

(** Local represents directly-attached storage with node affinity (Beta feature) *)
let create (path : string) : t = {
    fs_type = None;
    path = path;
}

