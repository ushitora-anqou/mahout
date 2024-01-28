(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_condition.t : PriorityLevelConfigurationCondition defines the condition of priority level.
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
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string option [@yojson.default None] [@yojson.key "lastTransitionTime"];
    (* `message` is a human-readable message indicating details about last transition. *)
    message: string option [@yojson.default None] [@yojson.key "message"];
    (* `reason` is a unique, one-word, CamelCase reason for the condition's last transition. *)
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    (* `status` is the status of the condition. Can be True, False, Unknown. Required. *)
    status: string option [@yojson.default None] [@yojson.key "status"];
    (* `type` is the type of the condition. Required. *)
    _type: string option [@yojson.default None] [@yojson.key "type"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


