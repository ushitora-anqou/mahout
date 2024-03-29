(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1_ip_block.t : IPBlock describes a particular CIDR (Ex. \''192.168.1.0/24\'',\''2001:db8::/64\'') that is allowed to the pods matched by a NetworkPolicySpec's podSelector. The except entry describes CIDRs that should not be included within this rule.
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
    (* cidr is a string representing the IPBlock Valid examples are \''192.168.1.0/24\'' or \''2001:db8::/64\'' *)
    cidr: string [@yojson.key "cidr"];
    (* except is a slice of CIDRs that should not be included within an IPBlock Valid examples are \''192.168.1.0/24\'' or \''2001:db8::/64\'' Except values will be rejected if they are outside the cidr range *)
    except: string list [@default []] [@yojson.key "except"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


