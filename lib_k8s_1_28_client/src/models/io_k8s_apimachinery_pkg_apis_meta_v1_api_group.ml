(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_api_group.t : APIGroup contains the name, the supported versions, and the preferred version of a group.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None];
    (* name is the name of the group. *)
    name: string;
    preferred_version: Io_k8s_apimachinery_pkg_apis_meta_v1_group_version_for_discovery.t option [@default None];
    (* a map of client CIDR to server address that is serving this group. This is to help clients reach servers in the most network-efficient way possible. Clients can use the appropriate server address as per the CIDR that they match. In case of multiple matches, clients should use the longest matching CIDR. The server returns only those CIDRs that it thinks that the client can match. For example: the master will return an internal IP CIDR only, if the client reaches the server using an internal IP. Server looks at X-Forwarded-For header or X-Real-Ip header or request.RemoteAddr (in that order) to get the client IP. *)
    server_address_by_client_cidrs: Io_k8s_apimachinery_pkg_apis_meta_v1_server_address_by_client_cidr.t list;
    (* versions are the versions supported in this group. *)
    versions: Io_k8s_apimachinery_pkg_apis_meta_v1_group_version_for_discovery.t list;
} [@@deriving yojson { strict = false }, show ];;

(** APIGroup contains the name, the supported versions, and the preferred version of a group. *)
let create (name : string) (versions : Io_k8s_apimachinery_pkg_apis_meta_v1_group_version_for_discovery.t list) : t = {
    api_version = None;
    kind = None;
    name = name;
    preferred_version = None;
    server_address_by_client_cidrs = [];
    versions = versions;
}

