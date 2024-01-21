(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_se_linux_options.t : SELinuxOptions are the labels to be applied to the container
 *)

type t = {
    (* Level is SELinux level label that applies to the container. *)
    level: string option [@default None];
    (* Role is a SELinux role label that applies to the container. *)
    role: string option [@default None];
    (* Type is a SELinux type label that applies to the container. *)
    _type: string option [@default None];
    (* User is a SELinux user label that applies to the container. *)
    user: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** SELinuxOptions are the labels to be applied to the container *)
let create () : t = {
    level = None;
    role = None;
    _type = None;
    user = None;
}

