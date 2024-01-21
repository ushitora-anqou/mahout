(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_daemon_endpoint.t : DaemonEndpoint contains information about a single Daemon endpoint.
 *)

type t = {
    (* Port number of the given endpoint. *)
    port: int32 [@key Port];
} [@@deriving yojson { strict = false }, show ];;

(** DaemonEndpoint contains information about a single Daemon endpoint. *)
let create (port : int32) : t = {
    port = port;
}

