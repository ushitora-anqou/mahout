(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1_ingress_service_backend.t : IngressServiceBackend references a Kubernetes Service as a Backend.
 *)

type t = {
    (* name is the referenced service. The service must exist in the same namespace as the Ingress object. *)
    name: string [@key "name"];
    port: Io_k8s_api_networking_v1_service_backend_port.t option [@default None] [@key "port"];
} [@@deriving yojson { strict = false }, show ];;

(** IngressServiceBackend references a Kubernetes Service as a Backend. *)
let create (name : string) : t = {
    name = name;
    port = None;
}

