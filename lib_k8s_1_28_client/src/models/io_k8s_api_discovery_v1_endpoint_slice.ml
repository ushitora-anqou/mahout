(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_discovery_v1_endpoint_slice.t : EndpointSlice represents a subset of the endpoints that implement a service. For a given service there may be multiple EndpointSlice objects, selected by labels, which must be joined to produce the full set of endpoints.
 *)

type t = {
    (* addressType specifies the type of address carried by this EndpointSlice. All addresses in this slice must be the same type. This field is immutable after creation. The following address types are currently supported: * IPv4: Represents an IPv4 Address. * IPv6: Represents an IPv6 Address. * FQDN: Represents a Fully Qualified Domain Name. *)
    address_type: string;
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None];
    (* endpoints is a list of unique endpoints in this slice. Each slice may include a maximum of 1000 endpoints. *)
    endpoints: Io_k8s_api_discovery_v1_endpoint.t list [@default []];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None];
    (* ports specifies the list of network ports exposed by each endpoint in this slice. Each port must have a unique name. When ports is empty, it indicates that there are no defined ports. When a port is defined with a nil port value, it indicates \''all ports\''. Each slice may include a maximum of 100 ports. *)
    ports: Io_k8s_api_discovery_v1_endpoint_port.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** EndpointSlice represents a subset of the endpoints that implement a service. For a given service there may be multiple EndpointSlice objects, selected by labels, which must be joined to produce the full set of endpoints. *)
let create (address_type : string) (endpoints : Io_k8s_api_discovery_v1_endpoint.t list) : t = {
    address_type = address_type;
    api_version = None;
    endpoints = endpoints;
    kind = None;
    metadata = None;
    ports = [];
}

