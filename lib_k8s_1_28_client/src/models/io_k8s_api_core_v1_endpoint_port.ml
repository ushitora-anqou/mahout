(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_endpoint_port.t : EndpointPort is a tuple that describes a single port.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* The application protocol for this port. This is used as a hint for implementations to offer richer behavior for protocols that they understand. This field follows standard Kubernetes label syntax. Valid values are either:  * Un-prefixed protocol names - reserved for IANA standard service names (as per RFC-6335 and https://www.iana.org/assignments/service-names).  * Kubernetes-defined prefixed names:   * 'kubernetes.io/h2c' - HTTP/2 over cleartext as described in https://www.rfc-editor.org/rfc/rfc7540   * 'kubernetes.io/ws'  - WebSocket over cleartext as described in https://www.rfc-editor.org/rfc/rfc6455   * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455  * Other protocols should use implementation-defined prefixed names such as mycompany.com/my-custom-protocol. *)
    app_protocol: string option [@yojson.default None] [@yojson.key "appProtocol"];
    (* The name of this port.  This must match the 'name' field in the corresponding ServicePort. Must be a DNS_LABEL. Optional only if one port is defined. *)
    name: string option [@yojson.default None] [@yojson.key "name"];
    (* The port number of the endpoint. *)
    port: int32 [@yojson.key "port"];
    (* The IP protocol for this port. Must be UDP, TCP, or SCTP. Default is TCP. *)
    protocol: string option [@yojson.default None] [@yojson.key "protocol"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


