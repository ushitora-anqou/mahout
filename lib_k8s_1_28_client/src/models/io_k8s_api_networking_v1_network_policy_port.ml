(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1_network_policy_port.t : NetworkPolicyPort describes a port to allow traffic on
 *)

type t = {
    (* endPort indicates that the range of ports from port to endPort if set, inclusive, should be allowed by the policy. This field cannot be defined if the port field is not defined or if the port field is defined as a named (string) port. The endPort must be equal or greater than port. *)
    end_port: int32 option [@default None];
    (* IntOrString is a type that can hold an int32 or a string.  When used in JSON or YAML marshalling and unmarshalling, it produces or consumes the inner type.  This allows you to have, for example, a JSON field that can accept a name or number. *)
    port: string option [@default None];
    (* protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match. If not specified, this field defaults to TCP. *)
    protocol: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** NetworkPolicyPort describes a port to allow traffic on *)
let create () : t = {
    end_port = None;
    port = None;
    protocol = None;
}

