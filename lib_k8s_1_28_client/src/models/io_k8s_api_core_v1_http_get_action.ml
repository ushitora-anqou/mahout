(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_http_get_action.t : HTTPGetAction describes an action based on HTTP Get requests.
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
    (* Host name to connect to, defaults to the pod IP. You probably want to set \''Host\'' in httpHeaders instead. *)
    host: string option [@yojson.default None] [@yojson.key "host"];
    (* Custom headers to set in the request. HTTP allows repeated headers. *)
    http_headers: Io_k8s_api_core_v1_http_header.t list [@default []] [@yojson.key "httpHeaders"];
    (* Path to access on the HTTP server. *)
    path: string option [@yojson.default None] [@yojson.key "path"];
    (* IntOrString is a type that can hold an int32 or a string.  When used in JSON or YAML marshalling and unmarshalling, it produces or consumes the inner type.  This allows you to have, for example, a JSON field that can accept a name or number. *)
    port: string [@yojson.key "port"];
    (* Scheme to use for connecting to the host. Defaults to HTTP. *)
    scheme: string option [@yojson.default None] [@yojson.key "scheme"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


