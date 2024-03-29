(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_resource_v1alpha2_resource_claim_consumer_reference.t : ResourceClaimConsumerReference contains enough information to let you locate the consumer of a ResourceClaim. The user must be a resource in the same namespace as the ResourceClaim.
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
    (* APIGroup is the group for the resource being referenced. It is empty for the core API. This matches the group in the APIVersion that is used when creating the resources. *)
    api_group: string option [@yojson.default None] [@yojson.key "apiGroup"];
    (* Name is the name of resource being referenced. *)
    name: string [@yojson.key "name"];
    (* Resource is the type of resource being referenced, for example \''pods\''. *)
    resource: string [@yojson.key "resource"];
    (* UID identifies exactly one incarnation of the resource. *)
    uid: string [@yojson.key "uid"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


