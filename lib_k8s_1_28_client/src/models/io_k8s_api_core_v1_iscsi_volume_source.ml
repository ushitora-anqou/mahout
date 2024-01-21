(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_iscsi_volume_source.t : Represents an ISCSI disk. ISCSI volumes can only be mounted as read/write once. ISCSI volumes support ownership management and SELinux relabeling.
 *)

type t = {
    (* chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication *)
    chap_auth_discovery: bool option [@default None];
    (* chapAuthSession defines whether support iSCSI Session CHAP authentication *)
    chap_auth_session: bool option [@default None];
    (* fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi *)
    fs_type: string option [@default None];
    (* initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection. *)
    initiator_name: string option [@default None];
    (* iqn is the target iSCSI Qualified Name. *)
    iqn: string;
    (* iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp). *)
    iscsi_interface: string option [@default None];
    (* lun represents iSCSI Target Lun number. *)
    lun: int32;
    (* portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260). *)
    portals: string list;
    (* readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. *)
    read_only: bool option [@default None];
    secret_ref: Io_k8s_api_core_v1_local_object_reference.t option [@default None];
    (* targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260). *)
    target_portal: string;
} [@@deriving yojson { strict = false }, show ];;

(** Represents an ISCSI disk. ISCSI volumes can only be mounted as read/write once. ISCSI volumes support ownership management and SELinux relabeling. *)
let create (iqn : string) (lun : int32) (target_portal : string) : t = {
    chap_auth_discovery = None;
    chap_auth_session = None;
    fs_type = None;
    initiator_name = None;
    iqn = iqn;
    iscsi_interface = None;
    lun = lun;
    portals = [];
    read_only = None;
    secret_ref = None;
    target_portal = target_portal;
}

