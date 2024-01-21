(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_custom_resource_definition_status.t : CustomResourceDefinitionStatus indicates the state of the CustomResourceDefinition
 *)

type t = {
    accepted_names: Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_custom_resource_definition_names.t option [@default None];
    (* conditions indicate state for particular aspects of a CustomResourceDefinition *)
    conditions: Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_custom_resource_definition_condition.t list;
    (* storedVersions lists all versions of CustomResources that were ever persisted. Tracking these versions allows a migration path for stored versions in etcd. The field is mutable so a migration controller can finish a migration to another version (ensuring no old objects are left in storage), and then remove the rest of the versions from this list. Versions may not be removed from `spec.versions` while they exist in this list. *)
    stored_versions: string list;
} [@@deriving yojson { strict = false }, show ];;

(** CustomResourceDefinitionStatus indicates the state of the CustomResourceDefinition *)
let create () : t = {
    accepted_names = None;
    conditions = [];
    stored_versions = [];
}

