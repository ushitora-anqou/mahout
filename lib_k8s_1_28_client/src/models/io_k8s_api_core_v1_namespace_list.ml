(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_namespace_list.t : NamespaceList is a list of Namespaces.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None] [@key "apiVersion"];
    (* Items is the list of Namespace objects in the list. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ *)
    items: Io_k8s_api_core_v1_namespace.t list [@default []] [@key "items"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None] [@key "kind"];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_list_meta.t option [@default None] [@key "metadata"];
} [@@deriving yojson { strict = false }, show ];;

(** NamespaceList is a list of Namespaces. *)
let create (items : Io_k8s_api_core_v1_namespace.t list) : t = {
    api_version = None;
    items = items;
    kind = None;
    metadata = None;
}

