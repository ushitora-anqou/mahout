(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_endpoint_address.t : EndpointAddress is a tuple that describes single IP address.
 *)

type t = {
    (* The Hostname of this endpoint *)
    hostname: string option [@default None];
    (* The IP of this endpoint. May not be loopback (127.0.0.0/8 or ::1), link-local (169.254.0.0/16 or fe80::/10), or link-local multicast (224.0.0.0/24 or ff02::/16). *)
    ip: string;
    (* Optional: Node hosting this endpoint. This can be used to determine endpoints local to a node. *)
    node_name: string option [@default None];
    target_ref: Io_k8s_api_core_v1_object_reference.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** EndpointAddress is a tuple that describes single IP address. *)
let create (ip : string) : t = {
    hostname = None;
    ip = ip;
    node_name = None;
    target_ref = None;
}

