(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_status.t : PriorityLevelConfigurationStatus represents the current state of a \''request-priority\''.
 *)

type t = {
    (* `conditions` is the current state of \''request-priority\''. *)
    conditions: Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_condition.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** PriorityLevelConfigurationStatus represents the current state of a \''request-priority\''. *)
let create () : t = {
    conditions = [];
}

