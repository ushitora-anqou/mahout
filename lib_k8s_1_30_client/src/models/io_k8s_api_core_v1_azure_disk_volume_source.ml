(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_azure_disk_volume_source.t : AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod.
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
    (* cachingMode is the Host Caching mode: None, Read Only, Read Write. *)
    caching_mode: string option [@yojson.default None] [@yojson.key "cachingMode"];
    (* diskName is the Name of the data disk in the blob storage *)
    disk_name: string [@yojson.key "diskName"];
    (* diskURI is the URI of data disk in the blob storage *)
    disk_uri: string [@yojson.key "diskURI"];
    (* fsType is Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared *)
    kind: string option [@yojson.default None] [@yojson.key "kind"];
    (* readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))

