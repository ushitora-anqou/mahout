(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_persistent_volume_claim_spec.t : PersistentVolumeClaimSpec describes the common attributes of storage devices and allows a Source for provider-specific attributes
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
    (* accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1 *)
    access_modes: string list [@default []] [@yojson.key "accessModes"];
    data_source: Io_k8s_api_core_v1_typed_local_object_reference.t option [@yojson.default None] [@yojson.key "dataSource"];
    data_source_ref: Io_k8s_api_core_v1_typed_object_reference.t option [@yojson.default None] [@yojson.key "dataSourceRef"];
    resources: Io_k8s_api_core_v1_volume_resource_requirements.t option [@yojson.default None] [@yojson.key "resources"];
    selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@yojson.default None] [@yojson.key "selector"];
    (* storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1 *)
    storage_class_name: string option [@yojson.default None] [@yojson.key "storageClassName"];
    (* volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim. If specified, the CSI driver will create or update the volume with the attributes defined in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName, it can be changed after the claim is created. An empty string value means that no VolumeAttributesClass will be applied to the claim but it's not allowed to reset this field to empty string once it is set. If unspecified and the PersistentVolumeClaim is unbound, the default VolumeAttributesClass will be set by the persistentvolume controller if it exists. If the resource referred to by volumeAttributesClass does not exist, this PersistentVolumeClaim will be set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource exists. More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/ (Alpha) Using this field requires the VolumeAttributesClass feature gate to be enabled. *)
    volume_attributes_class_name: string option [@yojson.default None] [@yojson.key "volumeAttributesClassName"];
    (* volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. *)
    volume_mode: string option [@yojson.default None] [@yojson.key "volumeMode"];
    (* volumeName is the binding reference to the PersistentVolume backing this claim. *)
    volume_name: string option [@yojson.default None] [@yojson.key "volumeName"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


