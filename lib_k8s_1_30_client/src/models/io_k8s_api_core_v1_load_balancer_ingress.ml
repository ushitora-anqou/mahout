(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_load_balancer_ingress.t : LoadBalancerIngress represents the status of a load-balancer ingress point: traffic intended for the service should be sent to an ingress point.
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
    (* Hostname is set for load-balancer ingress points that are DNS based (typically AWS load-balancers) *)
    hostname: string option [@yojson.default None] [@yojson.key "hostname"];
    (* IP is set for load-balancer ingress points that are IP based (typically GCE or OpenStack load-balancers) *)
    ip: string option [@yojson.default None] [@yojson.key "ip"];
    (* IPMode specifies how the load-balancer IP behaves, and may only be specified when the ip field is specified. Setting this to \''VIP\'' indicates that traffic is delivered to the node with the destination set to the load-balancer's IP and port. Setting this to \''Proxy\'' indicates that traffic is delivered to the node or pod with the destination set to the node's IP and node port or the pod's IP and port. Service implementations may use this information to adjust traffic routing. *)
    ip_mode: string option [@yojson.default None] [@yojson.key "ipMode"];
    (* Ports is a list of records of service ports If used, every port defined in the service should have an entry in it *)
    ports: Io_k8s_api_core_v1_port_status.t list [@default []] [@yojson.key "ports"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


