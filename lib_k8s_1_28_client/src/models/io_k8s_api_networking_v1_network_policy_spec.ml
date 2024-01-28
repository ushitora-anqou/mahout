(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1_network_policy_spec.t : NetworkPolicySpec provides the specification of a NetworkPolicy
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
end)
type t = {
    (* egress is a list of egress rules to be applied to the selected pods. Outgoing traffic is allowed if there are no NetworkPolicies selecting the pod (and cluster policy otherwise allows the traffic), OR if the traffic matches at least one egress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy limits all outgoing traffic (and serves solely to ensure that the pods it selects are isolated by default). This field is beta-level in 1.8 *)
    egress: Io_k8s_api_networking_v1_network_policy_egress_rule.t list [@default []] [@yojson.key "egress"];
    (* ingress is a list of ingress rules to be applied to the selected pods. Traffic is allowed to a pod if there are no NetworkPolicies selecting the pod (and cluster policy otherwise allows the traffic), OR if the traffic source is the pod's local node, OR if the traffic matches at least one ingress rule across all of the NetworkPolicy objects whose podSelector matches the pod. If this field is empty then this NetworkPolicy does not allow any traffic (and serves solely to ensure that the pods it selects are isolated by default) *)
    ingress: Io_k8s_api_networking_v1_network_policy_ingress_rule.t list [@default []] [@yojson.key "ingress"];
    pod_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t [@yojson.key "podSelector"];
    (* policyTypes is a list of rule types that the NetworkPolicy relates to. Valid options are [\''Ingress\''], [\''Egress\''], or [\''Ingress\'', \''Egress\'']. If this field is not specified, it will default based on the existence of ingress or egress rules; policies that contain an egress section are assumed to affect egress, and all policies (whether or not they contain an ingress section) are assumed to affect ingress. If you want to write an egress-only policy, you must explicitly specify policyTypes [ \''Egress\'' ]. Likewise, if you want to write a policy that specifies that no egress is allowed, you must specify a policyTypes value that include \''Egress\'' (since such a policy would not include an egress section and would otherwise default to just [ \''Ingress\'' ]). This field is beta-level in 1.8 *)
    policy_types: string list [@default []] [@yojson.key "policyTypes"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


