(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authentication_v1beta1_self_subject_review_status.t : SelfSubjectReviewStatus is filled by the kube-apiserver and sent back to a user.
 *)

type t = {
    user_info: Io_k8s_api_authentication_v1_user_info.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** SelfSubjectReviewStatus is filled by the kube-apiserver and sent back to a user. *)
let create () : t = {
    user_info = None;
}

