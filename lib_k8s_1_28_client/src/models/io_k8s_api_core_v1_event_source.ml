(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_event_source.t : EventSource contains information for an event.
 *)

type t = {
    (* Component from which the event is generated. *)
    component: string option [@yojson.default None] [@yojson.key "component"];
    (* Node name on which the event is generated. *)
    host: string option [@yojson.default None] [@yojson.key "host"];
} [@@deriving yojson { strict = false }, show, make];;


