(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_endpoint_address.t : EndpointAddress is a tuple that describes single IP address.
 *)

type t = {
    (* The Hostname of this endpoint *)
    hostname: string option [@yojson.default None] [@yojson.key "hostname"];
    (* The IP of this endpoint. May not be loopback (127.0.0.0/8 or ::1), link-local (169.254.0.0/16 or fe80::/10), or link-local multicast (224.0.0.0/24 or ff02::/16). *)
    ip: string [@yojson.key "ip"];
    (* Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node. *)
    node_name: string option [@yojson.default None] [@yojson.key "nodeName"];
    target_ref: Io_k8s_api_core_v1_object_reference.t option [@yojson.default None] [@yojson.key "targetRef"];
} [@@deriving yojson { strict = false }, show, make];;


