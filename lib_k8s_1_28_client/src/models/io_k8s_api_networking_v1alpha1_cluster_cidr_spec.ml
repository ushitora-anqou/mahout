(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1alpha1_cluster_cidr_spec.t : ClusterCIDRSpec defines the desired state of ClusterCIDR.
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
    (* ipv4 defines an IPv4 IP block in CIDR notation(e.g. \''10.0.0.0/8\''). At least one of ipv4 and ipv6 must be specified. This field is immutable. *)
    ipv4: string option [@yojson.default None] [@yojson.key "ipv4"];
    (* ipv6 defines an IPv6 IP block in CIDR notation(e.g. \''2001:db8::/64\''). At least one of ipv4 and ipv6 must be specified. This field is immutable. *)
    ipv6: string option [@yojson.default None] [@yojson.key "ipv6"];
    node_selector: Io_k8s_api_core_v1_node_selector.t option [@yojson.default None] [@yojson.key "nodeSelector"];
    (* perNodeHostBits defines the number of host bits to be configured per node. A subnet mask determines how much of the address is used for network bits and host bits. For example an IPv4 address of 192.168.0.0/24, splits the address into 24 bits for the network portion and 8 bits for the host portion. To allocate 256 IPs, set this field to 8 (a /24 mask for IPv4 or a /120 for IPv6). Minimum value is 4 (16 IPs). This field is immutable. *)
    per_node_host_bits: int32 [@yojson.key "perNodeHostBits"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


