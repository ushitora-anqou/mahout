(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_flow_schema_status.t : FlowSchemaStatus represents the current state of a FlowSchema.
 *)

type t = {
    (* `conditions` is a list of the current states of FlowSchema. *)
    conditions: Io_k8s_api_flowcontrol_v1beta3_flow_schema_condition.t list [@yojson.default []] [@yojson.key "conditions"];
} [@@deriving yojson { strict = false }, show, make];;


