(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_status.t : Status is a return value for calls that don't return other objects.
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
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@yojson.default None] [@yojson.key "apiVersion"];
    (* Suggested HTTP return code for this status, 0 if not set. *)
    code: int32 option [@yojson.default None] [@yojson.key "code"];
    details: Io_k8s_apimachinery_pkg_apis_meta_v1_status_details.t option [@yojson.default None] [@yojson.key "details"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@yojson.default None] [@yojson.key "kind"];
    (* A human-readable description of the status of this operation. *)
    message: string option [@yojson.default None] [@yojson.key "message"];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_list_meta.t option [@yojson.default None] [@yojson.key "metadata"];
    (* A machine-readable description of why this operation is in the \''Failure\'' status. If this value is empty there is no information available. A Reason clarifies an HTTP status code but does not override it. *)
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    (* Status of the operation. One of: \''Success\'' or \''Failure\''. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status *)
    status: string option [@yojson.default None] [@yojson.key "status"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


