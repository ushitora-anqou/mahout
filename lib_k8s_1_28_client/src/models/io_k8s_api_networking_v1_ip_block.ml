(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1_ip_block.t : IPBlock describes a particular CIDR (Ex. \''192.168.1.0/24\'',\''2001:db8::/64\'') that is allowed to the pods matched by a NetworkPolicySpec's podSelector. The except entry describes CIDRs that should not be included within this rule.
 *)

type t = {
    (* cidr is a string representing the IPBlock Valid examples are \''192.168.1.0/24\'' or \''2001:db8::/64\'' *)
    cidr: string;
    (* except is a slice of CIDRs that should not be included within an IPBlock Valid examples are \''192.168.1.0/24\'' or \''2001:db8::/64\'' Except values will be rejected if they are outside the cidr range *)
    except: string list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** IPBlock describes a particular CIDR (Ex. \''192.168.1.0/24\'',\''2001:db8::/64\'') that is allowed to the pods matched by a NetworkPolicySpec's podSelector. The except entry describes CIDRs that should not be included within this rule. *)
let create (cidr : string) : t = {
    cidr = cidr;
    except = [];
}

