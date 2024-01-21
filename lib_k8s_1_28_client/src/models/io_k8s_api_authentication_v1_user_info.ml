(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authentication_v1_user_info.t : UserInfo holds the information about the user needed to implement the user.Info interface.
 *)

type t = {
    (* Any additional information provided by the authenticator. *)
    extra: (string * string list) list;
    (* The names of groups this user is a part of. *)
    groups: string list;
    (* A unique value that identifies this user across time. If this user is deleted and another user by the same name is added, they will have different UIDs. *)
    uid: string option [@default None];
    (* The name that uniquely identifies this user among all active users. *)
    username: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** UserInfo holds the information about the user needed to implement the user.Info interface. *)
let create () : t = {
    extra = [];
    groups = [];
    uid = None;
    username = None;
}

