(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1_service_backend_port.t : ServiceBackendPort is the service port being referenced.
 *)

type t = {
    (* name is the name of the port on the Service. This is a mutually exclusive setting with \''Number\''. *)
    name: string option [@yojson.default None] [@yojson.key "name"];
    (* number is the numerical port number (e.g. 80) on the Service. This is a mutually exclusive setting with \''Name\''. *)
    number: int32 option [@yojson.default None] [@yojson.key "number"];
} [@@deriving yojson { strict = false }, show, make];;


