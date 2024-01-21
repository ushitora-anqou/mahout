(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_session_affinity_config.t : SessionAffinityConfig represents the configurations of session affinity.
 *)

type t = {
    client_ip: Io_k8s_api_core_v1_client_ip_config.t option [@default None] [@key clientIP];
} [@@deriving yojson { strict = false }, show ];;

(** SessionAffinityConfig represents the configurations of session affinity. *)
let create () : t = {
    client_ip = None;
}

