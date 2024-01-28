(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_flowcontrol_v1beta3_limit_response.t : LimitResponse defines how to handle requests that can not be executed right now.
 *)

type t = {
    queuing: Io_k8s_api_flowcontrol_v1beta3_queuing_configuration.t option [@yojson.default None] [@yojson.key "queuing"];
    (* `type` is \''Queue\'' or \''Reject\''. \''Queue\'' means that requests that can not be executed upon arrival are held in a queue until they can be executed or a queuing limit is reached. \''Reject\'' means that requests that can not be executed upon arrival are rejected. Required. *)
    _type: string [@yojson.key "type"];
} [@@deriving yojson { strict = false }, show, make];;


