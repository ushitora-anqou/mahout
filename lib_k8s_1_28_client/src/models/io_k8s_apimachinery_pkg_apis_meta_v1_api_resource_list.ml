(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource_list.t : APIResourceList is a list of APIResource, it is used to expose the name of the resources supported in a specific group and version, and if the resource is namespaced.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None] [@key apiVersion];
    (* groupVersion is the group and version this APIResourceList is for. *)
    group_version: string [@key groupVersion];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None] [@key kind];
    (* resources contains the name of the resources and if they are namespaced. *)
    resources: Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource.t list [@default []] [@key resources];
} [@@deriving yojson { strict = false }, show ];;

(** APIResourceList is a list of APIResource, it is used to expose the name of the resources supported in a specific group and version, and if the resource is namespaced. *)
let create (group_version : string) (resources : Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource.t list) : t = {
    api_version = None;
    group_version = group_version;
    kind = None;
    resources = resources;
}

