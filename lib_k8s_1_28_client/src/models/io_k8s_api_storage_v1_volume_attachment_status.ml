(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_storage_v1_volume_attachment_status.t : VolumeAttachmentStatus is the status of a VolumeAttachment request.
 *)

type t = {
    attach_error: Io_k8s_api_storage_v1_volume_error.t option [@default None] [@key attachError];
    (* attached indicates the volume is successfully attached. This field must only be set by the entity completing the attach operation, i.e. the external-attacher. *)
    attached: bool [@key attached];
    (* attachmentMetadata is populated with any information returned by the attach operation, upon successful attach, that must be passed into subsequent WaitForAttach or Mount calls. This field must only be set by the entity completing the attach operation, i.e. the external-attacher. *)
    attachment_metadata: Yojson.Safe.t [@key attachmentMetadata];
    detach_error: Io_k8s_api_storage_v1_volume_error.t option [@default None] [@key detachError];
} [@@deriving yojson { strict = false }, show ];;

(** VolumeAttachmentStatus is the status of a VolumeAttachment request. *)
let create (attached : bool) : t = {
    attach_error = None;
    attached = attached;
    attachment_metadata = `List [];
    detach_error = None;
}

