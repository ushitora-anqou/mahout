(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_glusterfs_persistent_volume_source.t : Represents a Glusterfs mount that lasts the lifetime of a pod. Glusterfs volumes do not support ownership management or SELinux relabeling.
 *)

type t = {
    (* endpoints is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod *)
    endpoints: string [@key endpoints];
    (* endpointsNamespace is the namespace that contains Glusterfs endpoint. If this field is empty, the EndpointNamespace defaults to the same namespace as the bound PVC. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod *)
    endpoints_namespace: string option [@default None] [@key endpointsNamespace];
    (* path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod *)
    path: string [@key path];
    (* readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod *)
    read_only: bool option [@default None] [@key readOnly];
} [@@deriving yojson { strict = false }, show ];;

(** Represents a Glusterfs mount that lasts the lifetime of a pod. Glusterfs volumes do not support ownership management or SELinux relabeling. *)
let create (endpoints : string) (path : string) : t = {
    endpoints = endpoints;
    endpoints_namespace = None;
    path = path;
    read_only = None;
}

