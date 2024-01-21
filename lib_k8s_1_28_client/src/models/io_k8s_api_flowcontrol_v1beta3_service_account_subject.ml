(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_service_account_subject.t : ServiceAccountSubject holds detailed information for service-account-kind subject.
 *)

type t = {
    (* `name` is the name of matching ServiceAccount objects, or \''*\'' to match regardless of name. Required. *)
    name: string;
    (* `namespace` is the namespace of matching ServiceAccount objects. Required. *)
    namespace: string;
} [@@deriving yojson { strict = false }, show ];;

(** ServiceAccountSubject holds detailed information for service-account-kind subject. *)
let create (name : string) (namespace : string) : t = {
    name = name;
    namespace = namespace;
}

