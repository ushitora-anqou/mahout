(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_discovery_v1_endpoint.t : Endpoint represents a single logical \''backend\'' implementing a service.
 *)

type t = {
    (* addresses of this endpoint. The contents of this field are interpreted according to the corresponding EndpointSlice addressType field. Consumers must handle different types of addresses in the context of their own capabilities. This must contain at least one address but no more than 100. These are all assumed to be fungible and clients may choose to only use the first element. Refer to: https://issue.k8s.io/106267 *)
    addresses: string list [@default []];
    conditions: Io_k8s_api_discovery_v1_endpoint_conditions.t option [@default None];
    (* deprecatedTopology contains topology information part of the v1beta1 API. This field is deprecated, and will be removed when the v1beta1 API is removed (no sooner than kubernetes v1.24).  While this field can hold values, it is not writable through the v1 API, and any attempts to write to it will be silently ignored. Topology information can be found in the zone and nodeName fields instead. *)
    deprecated_topology: Yojson.Safe.t list [@default []];
    hints: Io_k8s_api_discovery_v1_endpoint_hints.t option [@default None];
    (* hostname of this endpoint. This field may be used by consumers of endpoints to distinguish endpoints from each other (e.g. in DNS names). Multiple endpoints which use the same hostname should be considered fungible (e.g. multiple A values in DNS). Must be lowercase and pass DNS Label (RFC 1123) validation. *)
    hostname: string option [@default None];
    (* nodeName represents the name of the Node hosting this endpoint. This can be used to determine endpoints local to a Node. *)
    node_name: string option [@default None];
    target_ref: Io_k8s_api_core_v1_object_reference.t option [@default None];
    (* zone is the name of the Zone this endpoint exists in. *)
    zone: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** Endpoint represents a single logical \''backend\'' implementing a service. *)
let create (addresses : string list) : t = {
    addresses = addresses;
    conditions = None;
    deprecated_topology = [];
    hints = None;
    hostname = None;
    node_name = None;
    target_ref = None;
    zone = None;
}

