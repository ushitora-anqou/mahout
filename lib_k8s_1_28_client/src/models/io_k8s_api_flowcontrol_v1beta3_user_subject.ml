(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_user_subject.t : UserSubject holds detailed information for user-kind subject.
 *)

type t = {
    (* `name` is the username that matches, or \''*\'' to match all usernames. Required. *)
    name: string [@key name];
} [@@deriving yojson { strict = false }, show ];;

(** UserSubject holds detailed information for user-kind subject. *)
let create (name : string) : t = {
    name = name;
}

