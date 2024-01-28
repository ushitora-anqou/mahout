(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_persistent_volume_claim_spec.t : PersistentVolumeClaimSpec describes the common attributes of storage devices and allows a Source for provider-specific attributes
 *)

type t = {
    (* accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1 *)
    access_modes: string list [@yojson.default []] [@yojson.key "accessModes"];
    data_source: Io_k8s_api_core_v1_typed_local_object_reference.t option [@yojson.default None] [@yojson.key "dataSource"];
    data_source_ref: Io_k8s_api_core_v1_typed_object_reference.t option [@yojson.default None] [@yojson.key "dataSourceRef"];
    resources: Io_k8s_api_core_v1_resource_requirements.t option [@yojson.default None] [@yojson.key "resources"];
    selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@yojson.default None] [@yojson.key "selector"];
    (* storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1 *)
    storage_class_name: string option [@yojson.default None] [@yojson.key "storageClassName"];
    (* volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. *)
    volume_mode: string option [@yojson.default None] [@yojson.key "volumeMode"];
    (* volumeName is the binding reference to the PersistentVolume backing this claim. *)
    volume_name: string option [@yojson.default None] [@yojson.key "volumeName"];
} [@@deriving yojson { strict = false }, show, make];;


