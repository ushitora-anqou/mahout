(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_scale_io_persistent_volume_source.t : ScaleIOPersistentVolumeSource represents a persistent ScaleIO volume
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
    (* fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. Default is \''xfs\'' *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* gateway is the host address of the ScaleIO API Gateway. *)
    gateway: string [@yojson.key "gateway"];
    (* protectionDomain is the name of the ScaleIO Protection Domain for the configured storage. *)
    protection_domain: string option [@yojson.default None] [@yojson.key "protectionDomain"];
    (* readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    secret_ref: Io_k8s_api_core_v1_secret_reference.t [@yojson.key "secretRef"];
    (* sslEnabled is the flag to enable/disable SSL communication with Gateway, default false *)
    ssl_enabled: bool option [@yojson.default None] [@yojson.key "sslEnabled"];
    (* storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned. *)
    storage_mode: string option [@yojson.default None] [@yojson.key "storageMode"];
    (* storagePool is the ScaleIO Storage Pool associated with the protection domain. *)
    storage_pool: string option [@yojson.default None] [@yojson.key "storagePool"];
    (* system is the name of the storage system as configured in ScaleIO. *)
    system: string [@yojson.key "system"];
    (* volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source. *)
    volume_name: string option [@yojson.default None] [@yojson.key "volumeName"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


