(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_reference.t : PriorityLevelConfigurationReference contains information that points to the \''request-priority\'' being used.
 *)

type t = {
    (* `name` is the name of the priority level configuration being referenced Required. *)
    name: string [@key name];
} [@@deriving yojson { strict = false }, show ];;

(** PriorityLevelConfigurationReference contains information that points to the \''request-priority\'' being used. *)
let create (name : string) : t = {
    name = name;
}

