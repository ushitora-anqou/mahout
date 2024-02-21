(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_csi_persistent_volume_source.t : Represents storage that is managed by an external CSI volume driver (Beta feature)
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
    controller_expand_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@yojson.default None] [@yojson.key "controllerExpandSecretRef"];
    controller_publish_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@yojson.default None] [@yojson.key "controllerPublishSecretRef"];
    (* driver is the name of the driver to use for this volume. Required. *)
    driver: string [@yojson.key "driver"];
    (* fsType to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    node_expand_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@yojson.default None] [@yojson.key "nodeExpandSecretRef"];
    node_publish_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@yojson.default None] [@yojson.key "nodePublishSecretRef"];
    node_stage_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@yojson.default None] [@yojson.key "nodeStageSecretRef"];
    (* readOnly value to pass to ControllerPublishVolumeRequest. Defaults to false (read/write). *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    (* volumeAttributes of the volume to publish. *)
    volume_attributes: any [@default (`Assoc [])] [@yojson.key "volumeAttributes"];
    (* volumeHandle is the unique volume name returned by the CSI volume plugin’s CreateVolume to refer to the volume on all subsequent calls. Required. *)
    volume_handle: string [@yojson.key "volumeHandle"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))

