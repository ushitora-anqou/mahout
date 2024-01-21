(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_volume.t : Volume represents a named volume in a pod that may be accessed by any container in the pod.
 *)

type t = {
    aws_elastic_block_store: Io_k8s_api_core_v1_aws_elastic_block_store_volume_source.t option [@default None] [@key "awsElasticBlockStore"];
    azure_disk: Io_k8s_api_core_v1_azure_disk_volume_source.t option [@default None] [@key "azureDisk"];
    azure_file: Io_k8s_api_core_v1_azure_file_volume_source.t option [@default None] [@key "azureFile"];
    cephfs: Io_k8s_api_core_v1_ceph_fs_volume_source.t option [@default None] [@key "cephfs"];
    cinder: Io_k8s_api_core_v1_cinder_volume_source.t option [@default None] [@key "cinder"];
    config_map: Io_k8s_api_core_v1_config_map_volume_source.t option [@default None] [@key "configMap"];
    csi: Io_k8s_api_core_v1_csi_volume_source.t option [@default None] [@key "csi"];
    downward_api: Io_k8s_api_core_v1_downward_api_volume_source.t option [@default None] [@key "downwardAPI"];
    empty_dir: Io_k8s_api_core_v1_empty_dir_volume_source.t option [@default None] [@key "emptyDir"];
    ephemeral: Io_k8s_api_core_v1_ephemeral_volume_source.t option [@default None] [@key "ephemeral"];
    fc: Io_k8s_api_core_v1_fc_volume_source.t option [@default None] [@key "fc"];
    flex_volume: Io_k8s_api_core_v1_flex_volume_source.t option [@default None] [@key "flexVolume"];
    flocker: Io_k8s_api_core_v1_flocker_volume_source.t option [@default None] [@key "flocker"];
    gce_persistent_disk: Io_k8s_api_core_v1_gce_persistent_disk_volume_source.t option [@default None] [@key "gcePersistentDisk"];
    git_repo: Io_k8s_api_core_v1_git_repo_volume_source.t option [@default None] [@key "gitRepo"];
    glusterfs: Io_k8s_api_core_v1_glusterfs_volume_source.t option [@default None] [@key "glusterfs"];
    host_path: Io_k8s_api_core_v1_host_path_volume_source.t option [@default None] [@key "hostPath"];
    iscsi: Io_k8s_api_core_v1_iscsi_volume_source.t option [@default None] [@key "iscsi"];
    (* name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names *)
    name: string [@key "name"];
    nfs: Io_k8s_api_core_v1_nfs_volume_source.t option [@default None] [@key "nfs"];
    persistent_volume_claim: Io_k8s_api_core_v1_persistent_volume_claim_volume_source.t option [@default None] [@key "persistentVolumeClaim"];
    photon_persistent_disk: Io_k8s_api_core_v1_photon_persistent_disk_volume_source.t option [@default None] [@key "photonPersistentDisk"];
    portworx_volume: Io_k8s_api_core_v1_portworx_volume_source.t option [@default None] [@key "portworxVolume"];
    projected: Io_k8s_api_core_v1_projected_volume_source.t option [@default None] [@key "projected"];
    quobyte: Io_k8s_api_core_v1_quobyte_volume_source.t option [@default None] [@key "quobyte"];
    rbd: Io_k8s_api_core_v1_rbd_volume_source.t option [@default None] [@key "rbd"];
    scale_io: Io_k8s_api_core_v1_scale_io_volume_source.t option [@default None] [@key "scaleIO"];
    secret: Io_k8s_api_core_v1_secret_volume_source.t option [@default None] [@key "secret"];
    storageos: Io_k8s_api_core_v1_storage_os_volume_source.t option [@default None] [@key "storageos"];
    vsphere_volume: Io_k8s_api_core_v1_vsphere_virtual_disk_volume_source.t option [@default None] [@key "vsphereVolume"];
} [@@deriving yojson { strict = false }, show ];;

(** Volume represents a named volume in a pod that may be accessed by any container in the pod. *)
let create (name : string) : t = {
    aws_elastic_block_store = None;
    azure_disk = None;
    azure_file = None;
    cephfs = None;
    cinder = None;
    config_map = None;
    csi = None;
    downward_api = None;
    empty_dir = None;
    ephemeral = None;
    fc = None;
    flex_volume = None;
    flocker = None;
    gce_persistent_disk = None;
    git_repo = None;
    glusterfs = None;
    host_path = None;
    iscsi = None;
    name = name;
    nfs = None;
    persistent_volume_claim = None;
    photon_persistent_disk = None;
    portworx_volume = None;
    projected = None;
    quobyte = None;
    rbd = None;
    scale_io = None;
    secret = None;
    storageos = None;
    vsphere_volume = None;
}

