(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_rbd_volume_source.t : Represents a Rados Block Device mount that lasts the lifetime of a pod. RBD volumes support ownership management and SELinux relabeling.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
    let string_of_yojson = function
      | `String s -> s
      | `Int i -> string_of_int i
      | _ -> failwith "string_of_yojson: string or int needed"
end)
type t = {
    (* fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    image: string [@yojson.key "image"];
    (* keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    keyring: string option [@yojson.default None] [@yojson.key "keyring"];
    (* monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    monitors: string list [@default []] [@yojson.key "monitors"];
    (* pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    pool: string option [@yojson.default None] [@yojson.key "pool"];
    (* readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    secret_ref: Io_k8s_api_core_v1_local_object_reference.t option [@yojson.default None] [@yojson.key "secretRef"];
    (* user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it *)
    user: string option [@yojson.default None] [@yojson.key "user"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


