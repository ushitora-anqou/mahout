(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_component_status_list.t : Status of all the conditions for the component as a list of ComponentStatus objects. Deprecated: This API is deprecated in v1.19+
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@yojson.default None] [@yojson.key "apiVersion"];
    (* List of ComponentStatus objects. *)
    items: Io_k8s_api_core_v1_component_status.t list [@yojson.default []] [@yojson.key "items"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@yojson.default None] [@yojson.key "kind"];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_list_meta.t option [@yojson.default None] [@yojson.key "metadata"];
} [@@deriving yojson { strict = false }, show, make];;


