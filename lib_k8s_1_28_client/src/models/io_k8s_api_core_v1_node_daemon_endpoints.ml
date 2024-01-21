(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_node_daemon_endpoints.t : NodeDaemonEndpoints lists ports opened by daemons running on the Node.
 *)

type t = {
    kubelet_endpoint: Io_k8s_api_core_v1_daemon_endpoint.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** NodeDaemonEndpoints lists ports opened by daemons running on the Node. *)
let create () : t = {
    kubelet_endpoint = None;
}

