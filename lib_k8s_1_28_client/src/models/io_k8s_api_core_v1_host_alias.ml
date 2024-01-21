(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_host_alias.t : HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the pod's hosts file.
 *)

type t = {
    (* Hostnames for the above IP address. *)
    hostnames: string list;
    (* IP address of the host file entry. *)
    ip: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the pod's hosts file. *)
let create () : t = {
    hostnames = [];
    ip = None;
}

