(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_iscsi_volume_source.t : Represents an ISCSI disk. ISCSI volumes can only be mounted as read/write once. ISCSI volumes support ownership management and SELinux relabeling.
 *)

type t = {
    (* chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication *)
    chap_auth_discovery: bool option [@yojson.default None] [@yojson.key "chapAuthDiscovery"];
    (* chapAuthSession defines whether support iSCSI Session CHAP authentication *)
    chap_auth_session: bool option [@yojson.default None] [@yojson.key "chapAuthSession"];
    (* fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \''ext4\'', \''xfs\'', \''ntfs\''. Implicitly inferred to be \''ext4\'' if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi *)
    fs_type: string option [@yojson.default None] [@yojson.key "fsType"];
    (* initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection. *)
    initiator_name: string option [@yojson.default None] [@yojson.key "initiatorName"];
    (* iqn is the target iSCSI Qualified Name. *)
    iqn: string [@yojson.key "iqn"];
    (* iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp). *)
    iscsi_interface: string option [@yojson.default None] [@yojson.key "iscsiInterface"];
    (* lun represents iSCSI Target Lun number. *)
    lun: int32 [@yojson.key "lun"];
    (* portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260). *)
    portals: string list [@yojson.default []] [@yojson.key "portals"];
    (* readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    secret_ref: Io_k8s_api_core_v1_local_object_reference.t option [@yojson.default None] [@yojson.key "secretRef"];
    (* targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260). *)
    target_portal: string [@yojson.key "targetPortal"];
} [@@deriving yojson { strict = false }, show, make];;


