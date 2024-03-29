(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_volume.t : Volume represents a named volume in a pod that may be accessed by any container in the pod.
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
    aws_elastic_block_store: Io_k8s_api_core_v1_aws_elastic_block_store_volume_source.t option [@yojson.default None] [@yojson.key "awsElasticBlockStore"];
    azure_disk: Io_k8s_api_core_v1_azure_disk_volume_source.t option [@yojson.default None] [@yojson.key "azureDisk"];
    azure_file: Io_k8s_api_core_v1_azure_file_volume_source.t option [@yojson.default None] [@yojson.key "azureFile"];
    cephfs: Io_k8s_api_core_v1_ceph_fs_volume_source.t option [@yojson.default None] [@yojson.key "cephfs"];
    cinder: Io_k8s_api_core_v1_cinder_volume_source.t option [@yojson.default None] [@yojson.key "cinder"];
    config_map: Io_k8s_api_core_v1_config_map_volume_source.t option [@yojson.default None] [@yojson.key "configMap"];
    csi: Io_k8s_api_core_v1_csi_volume_source.t option [@yojson.default None] [@yojson.key "csi"];
    downward_api: Io_k8s_api_core_v1_downward_api_volume_source.t option [@yojson.default None] [@yojson.key "downwardAPI"];
    empty_dir: Io_k8s_api_core_v1_empty_dir_volume_source.t option [@yojson.default None] [@yojson.key "emptyDir"];
    ephemeral: Io_k8s_api_core_v1_ephemeral_volume_source.t option [@yojson.default None] [@yojson.key "ephemeral"];
    fc: Io_k8s_api_core_v1_fc_volume_source.t option [@yojson.default None] [@yojson.key "fc"];
    flex_volume: Io_k8s_api_core_v1_flex_volume_source.t option [@yojson.default None] [@yojson.key "flexVolume"];
    flocker: Io_k8s_api_core_v1_flocker_volume_source.t option [@yojson.default None] [@yojson.key "flocker"];
    gce_persistent_disk: Io_k8s_api_core_v1_gce_persistent_disk_volume_source.t option [@yojson.default None] [@yojson.key "gcePersistentDisk"];
    git_repo: Io_k8s_api_core_v1_git_repo_volume_source.t option [@yojson.default None] [@yojson.key "gitRepo"];
    glusterfs: Io_k8s_api_core_v1_glusterfs_volume_source.t option [@yojson.default None] [@yojson.key "glusterfs"];
    host_path: Io_k8s_api_core_v1_host_path_volume_source.t option [@yojson.default None] [@yojson.key "hostPath"];
    iscsi: Io_k8s_api_core_v1_iscsi_volume_source.t option [@yojson.default None] [@yojson.key "iscsi"];
    (* name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names *)
    name: string [@yojson.key "name"];
    nfs: Io_k8s_api_core_v1_nfs_volume_source.t option [@yojson.default None] [@yojson.key "nfs"];
    persistent_volume_claim: Io_k8s_api_core_v1_persistent_volume_claim_volume_source.t option [@yojson.default None] [@yojson.key "persistentVolumeClaim"];
    photon_persistent_disk: Io_k8s_api_core_v1_photon_persistent_disk_volume_source.t option [@yojson.default None] [@yojson.key "photonPersistentDisk"];
    portworx_volume: Io_k8s_api_core_v1_portworx_volume_source.t option [@yojson.default None] [@yojson.key "portworxVolume"];
    projected: Io_k8s_api_core_v1_projected_volume_source.t option [@yojson.default None] [@yojson.key "projected"];
    quobyte: Io_k8s_api_core_v1_quobyte_volume_source.t option [@yojson.default None] [@yojson.key "quobyte"];
    rbd: Io_k8s_api_core_v1_rbd_volume_source.t option [@yojson.default None] [@yojson.key "rbd"];
    scale_io: Io_k8s_api_core_v1_scale_io_volume_source.t option [@yojson.default None] [@yojson.key "scaleIO"];
    secret: Io_k8s_api_core_v1_secret_volume_source.t option [@yojson.default None] [@yojson.key "secret"];
    storageos: Io_k8s_api_core_v1_storage_os_volume_source.t option [@yojson.default None] [@yojson.key "storageos"];
    vsphere_volume: Io_k8s_api_core_v1_vsphere_virtual_disk_volume_source.t option [@yojson.default None] [@yojson.key "vsphereVolume"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


