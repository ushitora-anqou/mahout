(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_autoscaling_v1_cross_version_object_reference.t : CrossVersionObjectReference contains enough information to let you identify the referred resource.
 *)

type t = {
    (* apiVersion is the API version of the referent *)
    api_version: string option [@default None] [@key "apiVersion"];
    (* kind is the kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string [@key "kind"];
    (* name is the name of the referent; More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names *)
    name: string [@key "name"];
} [@@deriving yojson { strict = false }, show ];;

(** CrossVersionObjectReference contains enough information to let you identify the referred resource. *)
let create (kind : string) (name : string) : t = {
    api_version = None;
    kind = kind;
    name = name;
}

