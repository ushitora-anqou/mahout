(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_host_path_volume_source.t : Represents a host path mapped into a pod. Host path volumes do not support ownership management or SELinux relabeling.
 *)

type t = {
    (* path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath *)
    path: string [@yojson.key "path"];
    (* type for HostPath Volume Defaults to \''\'' More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath *)
    _type: string option [@yojson.default None] [@yojson.key "type"];
} [@@deriving yojson { strict = false }, show, make];;


