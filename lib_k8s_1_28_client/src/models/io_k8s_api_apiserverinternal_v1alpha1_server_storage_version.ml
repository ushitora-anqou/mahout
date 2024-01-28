(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apiserverinternal_v1alpha1_server_storage_version.t : An API server instance reports the version it can decode and the version it encodes objects to when persisting objects in the backend.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* The ID of the reporting API server. *)
    api_server_id: string option [@yojson.default None] [@yojson.key "apiServerID"];
    (* The API server can decode objects encoded in these versions. The encodingVersion must be included in the decodableVersions. *)
    decodable_versions: string list [@yojson.default []] [@yojson.key "decodableVersions"];
    (* The API server encodes the object to this version when persisting it in the backend (e.g., etcd). *)
    encoding_version: string option [@yojson.default None] [@yojson.key "encodingVersion"];
    (* The API server can serve these versions. DecodableVersions must include all ServedVersions. *)
    served_versions: string list [@yojson.default []] [@yojson.key "servedVersions"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


