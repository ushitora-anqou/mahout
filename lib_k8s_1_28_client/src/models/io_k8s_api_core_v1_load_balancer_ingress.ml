(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_load_balancer_ingress.t : LoadBalancerIngress represents the status of a load-balancer ingress point: traffic intended for the service should be sent to an ingress point.
 *)

type t = {
    (* Hostname is set for load-balancer ingress points that are DNS based (typically AWS load-balancers) *)
    hostname: string option [@default None] [@key "hostname"];
    (* IP is set for load-balancer ingress points that are IP based (typically GCE or OpenStack load-balancers) *)
    ip: string option [@default None] [@key "ip"];
    (* Ports is a list of records of service ports If used, every port defined in the service should have an entry in it *)
    ports: Io_k8s_api_core_v1_port_status.t list [@default []] [@key "ports"];
} [@@deriving yojson { strict = false }, show ];;

(** LoadBalancerIngress represents the status of a load-balancer ingress point: traffic intended for the service should be sent to an ingress point. *)
let create () : t = {
    hostname = None;
    ip = None;
    ports = [];
}

