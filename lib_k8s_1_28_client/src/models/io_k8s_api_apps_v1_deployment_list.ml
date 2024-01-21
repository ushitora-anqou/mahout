(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_deployment_list.t : DeploymentList is a list of Deployments.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None];
    (* Items is the list of Deployments. *)
    items: Io_k8s_api_apps_v1_deployment.t list [@default []];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_list_meta.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** DeploymentList is a list of Deployments. *)
let create (items : Io_k8s_api_apps_v1_deployment.t list) : t = {
    api_version = None;
    items = items;
    kind = None;
    metadata = None;
}

