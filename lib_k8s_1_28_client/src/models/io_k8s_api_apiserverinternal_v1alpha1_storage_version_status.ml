(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apiserverinternal_v1alpha1_storage_version_status.t : API server instances report the versions they can decode and the version they encode objects to when persisting objects in the backend.
 *)

type t = {
    (* If all API server instances agree on the same encoding storage version, then this field is set to that version. Otherwise this field is left empty. API servers should finish updating its storageVersionStatus entry before serving write operations, so that this field will be in sync with the reality. *)
    common_encoding_version: string option [@default None] [@key commonEncodingVersion];
    (* The latest available observations of the storageVersion's state. *)
    conditions: Io_k8s_api_apiserverinternal_v1alpha1_storage_version_condition.t list [@default []] [@key conditions];
    (* The reported versions per API server instance. *)
    storage_versions: Io_k8s_api_apiserverinternal_v1alpha1_server_storage_version.t list [@default []] [@key storageVersions];
} [@@deriving yojson { strict = false }, show ];;

(** API server instances report the versions they can decode and the version they encode objects to when persisting objects in the backend. *)
let create () : t = {
    common_encoding_version = None;
    conditions = [];
    storage_versions = [];
}

