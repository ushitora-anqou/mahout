(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource.t : APIResource specifies the name of a resource and whether it is namespaced.
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
    (* categories is a list of the grouped resources this resource belongs to (e.g. 'all') *)
    categories: string list [@default []] [@yojson.key "categories"];
    (* group is the preferred group of the resource.  Empty implies the group of the containing resource list. For subresources, this may have a different value, for example: Scale\''. *)
    group: string option [@yojson.default None] [@yojson.key "group"];
    (* kind is the kind for the resource (e.g. 'Foo' is the kind for a resource 'foo') *)
    kind: string [@yojson.key "kind"];
    (* name is the plural name of the resource. *)
    name: string [@yojson.key "name"];
    (* namespaced indicates if a resource is namespaced or not. *)
    namespaced: bool [@yojson.key "namespaced"];
    (* shortNames is a list of suggested short names of the resource. *)
    short_names: string list [@default []] [@yojson.key "shortNames"];
    (* singularName is the singular name of the resource.  This allows clients to handle plural and singular opaquely. The singularName is more correct for reporting status on a single item and both singular and plural are allowed from the kubectl CLI interface. *)
    singular_name: string [@yojson.key "singularName"];
    (* The hash value of the storage version, the version this resource is converted to when written to the data store. Value must be treated as opaque by clients. Only equality comparison on the value is valid. This is an alpha feature and may change or be removed in the future. The field is populated by the apiserver only if the StorageVersionHash feature gate is enabled. This field will remain optional even if it graduates. *)
    storage_version_hash: string option [@yojson.default None] [@yojson.key "storageVersionHash"];
    (* verbs is a list of supported kube verbs (this includes get, list, watch, create, update, patch, delete, deletecollection, and proxy) *)
    verbs: string list [@default []] [@yojson.key "verbs"];
    (* version is the preferred version of the resource.  Empty implies the version of the containing resource list For subresources, this may have a different value, for example: v1 (while inside a v1beta1 version of the core resource's group)\''. *)
    version: string option [@yojson.default None] [@yojson.key "version"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


