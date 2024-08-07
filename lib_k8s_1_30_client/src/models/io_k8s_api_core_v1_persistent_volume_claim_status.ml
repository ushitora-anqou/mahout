(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_persistent_volume_claim_status.t : PersistentVolumeClaimStatus is the current status of a persistent volume claim.
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
    (* accessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1 *)
    access_modes: string list [@default []] [@yojson.key "accessModes"];
    (* allocatedResourceStatuses stores status of resource being resized for the given PVC. Key names follow standard Kubernetes label syntax. Valid values are either:  * Un-prefixed keys:   - storage - the capacity of the volume.  * Custom resources must use implementation-defined prefixed names such as \''example.com/my-custom-resource\'' Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered reserved and hence may not be used.  ClaimResourceStatus can be in any of following states:  - ControllerResizeInProgress:   State set when resize controller starts resizing the volume in control-plane.  - ControllerResizeFailed:   State set when resize has failed in resize controller with a terminal error.  - NodeResizePending:   State set when resize controller has finished resizing the volume but further resizing of   volume is needed on the node.  - NodeResizeInProgress:   State set when kubelet starts resizing the volume.  - NodeResizeFailed:   State set when resizing has failed in kubelet with a terminal error. Transient errors don't set   NodeResizeFailed. For example: if expanding a PVC for more capacity - this field can be one of the following states:  - pvc.status.allocatedResourceStatus['storage'] = \''ControllerResizeInProgress\''      - pvc.status.allocatedResourceStatus['storage'] = \''ControllerResizeFailed\''      - pvc.status.allocatedResourceStatus['storage'] = \''NodeResizePending\''      - pvc.status.allocatedResourceStatus['storage'] = \''NodeResizeInProgress\''      - pvc.status.allocatedResourceStatus['storage'] = \''NodeResizeFailed\'' When this field is not set, it means that no resize operation is in progress for the given PVC.  A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus should ignore the update for the purpose it was designed. For example - a controller that only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid resources associated with PVC.  This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature. *)
    allocated_resource_statuses: any [@default (`Assoc [])] [@yojson.key "allocatedResourceStatuses"];
    (* allocatedResources tracks the resources allocated to a PVC including its capacity. Key names follow standard Kubernetes label syntax. Valid values are either:  * Un-prefixed keys:   - storage - the capacity of the volume.  * Custom resources must use implementation-defined prefixed names such as \''example.com/my-custom-resource\'' Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered reserved and hence may not be used.  Capacity reported here may be larger than the actual capacity when a volume expansion operation is requested. For storage quota, the larger value from allocatedResources and PVC.spec.resources is used. If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation. If a volume expansion capacity request is lowered, allocatedResources is only lowered if there are no expansion operations in progress and if the actual volume capacity is equal or lower than the requested capacity.  A controller that receives PVC update with previously unknown resourceName should ignore the update for the purpose it was designed. For example - a controller that only is responsible for resizing capacity of the volume, should ignore PVC updates that change other valid resources associated with PVC.  This is an alpha field and requires enabling RecoverVolumeExpansionFailure feature. *)
    allocated_resources: any [@default (`Assoc [])] [@yojson.key "allocatedResources"];
    (* capacity represents the actual resources of the underlying volume. *)
    capacity: any [@default (`Assoc [])] [@yojson.key "capacity"];
    (* conditions is the current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'Resizing'. *)
    conditions: Io_k8s_api_core_v1_persistent_volume_claim_condition.t list [@default []] [@yojson.key "conditions"];
    (* currentVolumeAttributesClassName is the current name of the VolumeAttributesClass the PVC is using. When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim This is an alpha field and requires enabling VolumeAttributesClass feature. *)
    current_volume_attributes_class_name: string option [@yojson.default None] [@yojson.key "currentVolumeAttributesClassName"];
    modify_volume_status: Io_k8s_api_core_v1_modify_volume_status.t option [@yojson.default None] [@yojson.key "modifyVolumeStatus"];
    (* phase represents the current phase of PersistentVolumeClaim. *)
    phase: string option [@yojson.default None] [@yojson.key "phase"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


