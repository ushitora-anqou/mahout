(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_ceph_fs_persistent_volume_source.t : Represents a Ceph Filesystem mount that lasts the lifetime of a pod Cephfs volumes do not support ownership management or SELinux relabeling.
 *)

type t = {
    (* monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it *)
    monitors: string list [@yojson.default []] [@yojson.key "monitors"];
    (* path is Optional: Used as the mounted root, rather than the full Ceph tree, default is / *)
    path: string option [@yojson.default None] [@yojson.key "path"];
    (* readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    (* secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it *)
    secret_file: string option [@yojson.default None] [@yojson.key "secretFile"];
    secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@yojson.default None] [@yojson.key "secretRef"];
    (* user is Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it *)
    user: string option [@yojson.default None] [@yojson.key "user"];
} [@@deriving yojson { strict = false }, show, make];;


