(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_discovery_v1_endpoint.t : Endpoint represents a single logical \''backend\'' implementing a service.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
    let string_of_yojson = function
      | `String s -> s
      | `Int i -> string_of_int i
      | _ -> failwith "string_of_yojson: string or int needed"
end)
type t = {
    (* addresses of this endpoint. The contents of this field are interpreted according to the corresponding EndpointSlice addressType field. Consumers must handle different types of addresses in the context of their own capabilities. This must contain at least one address but no more than 100. These are all assumed to be fungible and clients may choose to only use the first element. Refer to: https://issue.k8s.io/106267 *)
    addresses: string list [@default []] [@yojson.key "addresses"];
    conditions: Io_k8s_api_discovery_v1_endpoint_conditions.t option [@yojson.default None] [@yojson.key "conditions"];
    (* deprecatedTopology contains topology information part of the v1beta1 API. This field is deprecated, and will be removed when the v1beta1 API is removed (no sooner than kubernetes v1.24).  While this field can hold values, it is not writable through the v1 API, and any attempts to write to it will be silently ignored. Topology information can be found in the zone and nodeName fields instead. *)
    deprecated_topology: any [@default (`Assoc [])] [@yojson.key "deprecatedTopology"];
    hints: Io_k8s_api_discovery_v1_endpoint_hints.t option [@yojson.default None] [@yojson.key "hints"];
    (* hostname of this endpoint. This field may be used by consumers of endpoints to distinguish endpoints from each other (e.g. in DNS names). Multiple endpoints which use the same hostname should be considered fungible (e.g. multiple A values in DNS). Must be lowercase and pass DNS Label (RFC 1123) validation. *)
    hostname: string option [@yojson.default None] [@yojson.key "hostname"];
    (* nodeName represents the name of the Node hosting this endpoint. This can be used to determine endpoints local to a Node. *)
    node_name: string option [@yojson.default None] [@yojson.key "nodeName"];
    target_ref: Io_k8s_api_core_v1_object_reference.t option [@yojson.default None] [@yojson.key "targetRef"];
    (* zone is the name of the Zone this endpoint exists in. *)
    zone: string option [@yojson.default None] [@yojson.key "zone"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


