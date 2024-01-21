(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_pod_ip.t : PodIP represents a single IP address allocated to the pod.
 *)

type t = {
    (* IP is the IP address assigned to the pod *)
    ip: string option [@default None] [@key ip];
} [@@deriving yojson { strict = false }, show ];;

(** PodIP represents a single IP address allocated to the pod. *)
let create () : t = {
    ip = None;
}

