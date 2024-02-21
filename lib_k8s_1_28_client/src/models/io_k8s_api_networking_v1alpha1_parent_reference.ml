(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1alpha1_parent_reference.t : ParentReference describes a reference to a parent object.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
    let string_of_yojson = function
      | `String s -> s
      | `Int i -> string_of_int i
      | _ -> failwith "string_of_yojson: string or int needed"
end)
type t = {
    (* Group is the group of the object being referenced. *)
    group: string option [@yojson.default None] [@yojson.key "group"];
    (* Name is the name of the object being referenced. *)
    name: string option [@yojson.default None] [@yojson.key "name"];
    (* Namespace is the namespace of the object being referenced. *)
    namespace: string option [@yojson.default None] [@yojson.key "namespace"];
    (* Resource is the resource of the object being referenced. *)
    resource: string option [@yojson.default None] [@yojson.key "resource"];
    (* UID is the uid of the object being referenced. *)
    uid: string option [@yojson.default None] [@yojson.key "uid"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))

