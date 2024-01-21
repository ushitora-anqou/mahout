(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_capabilities.t : Adds and removes POSIX capabilities from running containers.
 *)

type t = {
    (* Added capabilities *)
    add: string list [@default []] [@key add];
    (* Removed capabilities *)
    drop: string list [@default []] [@key drop];
} [@@deriving yojson { strict = false }, show ];;

(** Adds and removes POSIX capabilities from running containers. *)
let create () : t = {
    add = [];
    drop = [];
}

