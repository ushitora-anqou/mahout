(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_vsphere_virtual_disk_volume_source.t : Represents a vSphere volume resource.
 *)

type t = {
    (* fsType is filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. *)
    fs_type: string option [@default None];
    (* storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName. *)
    storage_policy_id: string option [@default None];
    (* storagePolicyName is the storage Policy Based Management (SPBM) profile name. *)
    storage_policy_name: string option [@default None];
    (* volumePath is the path that identifies vSphere volume vmdk *)
    volume_path: string;
} [@@deriving yojson { strict = false }, show ];;

(** Represents a vSphere volume resource. *)
let create (volume_path : string) : t = {
    fs_type = None;
    storage_policy_id = None;
    storage_policy_name = None;
    volume_path = volume_path;
}

