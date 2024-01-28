(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_discovery_v1_endpoint_port.t : EndpointPort represents a Port used by an EndpointSlice
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* The application protocol for this port. This is used as a hint for implementations to offer richer behavior for protocols that they understand. This field follows standard Kubernetes label syntax. Valid values are either:  * Un-prefixed protocol names - reserved for IANA standard service names (as per RFC-6335 and https://www.iana.org/assignments/service-names).  * Kubernetes-defined prefixed names:   * 'kubernetes.io/h2c' - HTTP/2 over cleartext as described in https://www.rfc-editor.org/rfc/rfc7540   * 'kubernetes.io/ws'  - WebSocket over cleartext as described in https://www.rfc-editor.org/rfc/rfc6455   * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455  * Other protocols should use implementation-defined prefixed names such as mycompany.com/my-custom-protocol. *)
    app_protocol: string option [@yojson.default None] [@yojson.key "appProtocol"];
    (* name represents the name of this port. All ports in an EndpointSlice must have a unique name. If the EndpointSlice is dervied from a Kubernetes service, this corresponds to the Service.ports[].name. Name must either be an empty string or pass DNS_LABEL validation: * must be no more than 63 characters long. * must consist of lower case alphanumeric characters or '-'. * must start and end with an alphanumeric character. Default is empty string. *)
    name: string option [@yojson.default None] [@yojson.key "name"];
    (* port represents the port number of the endpoint. If this is not specified, ports are not restricted and must be interpreted in the context of the specific consumer. *)
    port: int32 option [@yojson.default None] [@yojson.key "port"];
    (* protocol represents the IP protocol for this port. Must be UDP, TCP, or SCTP. Default is TCP. *)
    protocol: string option [@yojson.default None] [@yojson.key "protocol"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


