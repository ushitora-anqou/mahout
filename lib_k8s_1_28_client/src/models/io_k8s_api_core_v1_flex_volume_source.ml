(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_flex_volume_source.t : FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin.
 *)

type t = {
    (* driver is the name of the driver to use for this volume. *)
    driver: string;
    (* fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \''ext4\'', \''xfs\'', \''ntfs\''. The default filesystem depends on FlexVolume script. *)
    fs_type: string option [@default None];
    (* options is Optional: this field holds extra command options if any. *)
    options: (string * string) list;
    (* readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. *)
    read_only: bool option [@default None];
    secret_ref: Io_k8s_api_core_v1_local_object_reference.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin. *)
let create (driver : string) : t = {
    driver = driver;
    fs_type = None;
    options = [];
    read_only = None;
    secret_ref = None;
}

