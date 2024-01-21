(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta2_flow_schema_spec.t : FlowSchemaSpec describes how the FlowSchema's specification looks like.
 *)

type t = {
    distinguisher_method: Io_k8s_api_flowcontrol_v1beta2_flow_distinguisher_method.t option [@default None] [@key "distinguisherMethod"];
    (* `matchingPrecedence` is used to choose among the FlowSchemas that match a given request. The chosen FlowSchema is among those with the numerically lowest (which we take to be logically highest) MatchingPrecedence.  Each MatchingPrecedence value must be ranged in [1,10000]. Note that if the precedence is not specified, it will be set to 1000 as default. *)
    matching_precedence: int32 option [@default None] [@key "matchingPrecedence"];
    priority_level_configuration: Io_k8s_api_flowcontrol_v1beta2_priority_level_configuration_reference.t [@key "priorityLevelConfiguration"];
    (* `rules` describes which requests will match this flow schema. This FlowSchema matches a request if and only if at least one member of rules matches the request. if it is an empty slice, there will be no requests matching the FlowSchema. *)
    rules: Io_k8s_api_flowcontrol_v1beta2_policy_rules_with_subjects.t list [@default []] [@key "rules"];
} [@@deriving yojson { strict = false }, show ];;

(** FlowSchemaSpec describes how the FlowSchema's specification looks like. *)
let create (priority_level_configuration : Io_k8s_api_flowcontrol_v1beta2_priority_level_configuration_reference.t) : t = {
    distinguisher_method = None;
    matching_precedence = None;
    priority_level_configuration = priority_level_configuration;
    rules = [];
}

