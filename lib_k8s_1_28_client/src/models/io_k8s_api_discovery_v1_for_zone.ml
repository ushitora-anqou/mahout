(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_discovery_v1_for_zone.t : ForZone provides information about which zones should consume this endpoint.
 *)

type t = {
    (* name represents the name of the zone. *)
    name: string;
} [@@deriving yojson { strict = false }, show ];;

(** ForZone provides information about which zones should consume this endpoint. *)
let create (name : string) : t = {
    name = name;
}

