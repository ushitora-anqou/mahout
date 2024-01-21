(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type t = {
    (* Error is to record the problem with the service port The format of the error shall comply with the following rules: - built-in error values shall be specified in this file and those shall use   CamelCase names - cloud provider specific error values must have names that comply with the   format foo.example.com/CamelCase. *)
    error: string option [@default None] [@key "error"];
    (* Port is the port number of the service port of which status is recorded here *)
    port: int32 [@key "port"];
    (* Protocol is the protocol of the service port of which status is recorded here The supported values are: \''TCP\'', \''UDP\'', \''SCTP\'' *)
    protocol: string [@key "protocol"];
} [@@deriving yojson { strict = false }, show ];;

let create (port : int32) (protocol : string) : t = {
    error = None;
    port = port;
    protocol = protocol;
}

