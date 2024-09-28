(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_storage_os_volume_source.t : Represents a StorageOS persistent volume resource.
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
    (* fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    secret_ref: Io_k8s_api_core_v1_local_object_reference.t option [@yojson.default None] [@yojson.key "secretRef"];
    (* volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace. *)
    volume_name: string option [@yojson.default None] [@yojson.key "volumeName"];
    (* volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \''default\'' if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created. *)
    volume_namespace: string option [@yojson.default None] [@yojson.key "volumeNamespace"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))

