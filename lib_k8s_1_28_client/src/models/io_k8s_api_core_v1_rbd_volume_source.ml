(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_rbd_volume_source.t : Represents a Rados Block Device mount that lasts the lifetime of a pod. RBD volumes support ownership management and SELinux relabeling.
 *)

type t = {
    (* fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd *)
    fs_type: string option [@default None] [@key fsType];
    (* image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    image: string [@key image];
    (* keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    keyring: string option [@default None] [@key keyring];
    (* monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    monitors: string list [@default []] [@key monitors];
    (* pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    pool: string option [@default None] [@key pool];
    (* readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    read_only: bool option [@default None] [@key readOnly];
    secret_ref: Io_k8s_api_core_v1_local_object_reference.t option [@default None] [@key secretRef];
    (* user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    user: string option [@default None] [@key user];
} [@@deriving yojson { strict = false }, show ];;

(** Represents a Rados Block Device mount that lasts the lifetime of a pod. RBD volumes support ownership management and SELinux relabeling. *)
let create (image : string) (monitors : string list) : t = {
    fs_type = None;
    image = image;
    keyring = None;
    monitors = monitors;
    pool = None;
    read_only = None;
    secret_ref = None;
    user = None;
}

