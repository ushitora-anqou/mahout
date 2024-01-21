(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_sysctl.t : Sysctl defines a kernel parameter to be set
 *)

type t = {
    (* Name of a property to set *)
    name: string [@key "name"];
    (* Value of a property to set *)
    value: string [@key "value"];
} [@@deriving yojson { strict = false }, show ];;

(** Sysctl defines a kernel parameter to be set *)
let create (name : string) (value : string) : t = {
    name = name;
    value = value;
}

