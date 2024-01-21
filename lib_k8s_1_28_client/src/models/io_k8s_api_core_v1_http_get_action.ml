(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_http_get_action.t : HTTPGetAction describes an action based on HTTP Get requests.
 *)

type t = {
    (* Host name to connect to, defaults to the pod IP. You probably want to set \''Host\'' in httpHeaders instead. *)
    host: string option [@default None] [@key host];
    (* Custom headers to set in the request. HTTP allows repeated headers. *)
    http_headers: Io_k8s_api_core_v1_http_header.t list [@default []] [@key httpHeaders];
    (* Path to access on the HTTP server. *)
    path: string option [@default None] [@key path];
    (* IntOrString is a type that can hold an int32 or a string.  When used in JSON or YAML marshalling and unmarshalling, it produces or consumes the inner type.  This allows you to have, for example, a JSON field that can accept a name or number. *)
    port: string [@key port];
    (* Scheme to use for connecting to the host. Defaults to HTTP. *)
    scheme: string option [@default None] [@key scheme];
} [@@deriving yojson { strict = false }, show ];;

(** HTTPGetAction describes an action based on HTTP Get requests. *)
let create (port : string) : t = {
    host = None;
    http_headers = [];
    path = None;
    port = port;
    scheme = None;
}

