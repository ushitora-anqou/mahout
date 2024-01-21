(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_csi_persistent_volume_source.t : Represents storage that is managed by an external CSI volume driver (Beta feature)
 *)

type t = {
    controller_expand_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@default None];
    controller_publish_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@default None];
    (* driver is the name of the driver to use for this volume. Required. *)
    driver: string;
    (* fsType to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. *)
    fs_type: string option [@default None];
    node_expand_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@default None];
    node_publish_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@default None];
    node_stage_secret_ref: Io_k8s_api_core_v1_secret_reference.t option [@default None];
    (* readOnly value to pass to ControllerPublishVolumeRequest. Defaults to false (read/write). *)
    read_only: bool option [@default None];
    (* volumeAttributes of the volume to publish. *)
    volume_attributes: (string * string) list [@default []];
    (* volumeHandle is the unique volume name returned by the CSI volume plugin’s CreateVolume to refer to the volume on all subsequent calls. Required. *)
    volume_handle: string;
} [@@deriving yojson { strict = false }, show ];;

(** Represents storage that is managed by an external CSI volume driver (Beta feature) *)
let create (driver : string) (volume_handle : string) : t = {
    controller_expand_secret_ref = None;
    controller_publish_secret_ref = None;
    driver = driver;
    fs_type = None;
    node_expand_secret_ref = None;
    node_publish_secret_ref = None;
    node_stage_secret_ref = None;
    read_only = None;
    volume_attributes = [];
    volume_handle = volume_handle;
}

