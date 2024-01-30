(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_certificates_v1_certificate_signing_request_condition.t : CertificateSigningRequestCondition describes a condition of a CertificateSigningRequest object
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
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string option [@yojson.default None] [@yojson.key "lastTransitionTime"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_update_time: string option [@yojson.default None] [@yojson.key "lastUpdateTime"];
    (* message contains a human readable message with details about the request state *)
    message: string option [@yojson.default None] [@yojson.key "message"];
    (* reason indicates a brief reason for the request state *)
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    (* status of the condition, one of True, False, Unknown. Approved, Denied, and Failed conditions may not be \''False\'' or \''Unknown\''. *)
    status: string [@yojson.key "status"];
    (* type of the condition. Known conditions are \''Approved\'', \''Denied\'', and \''Failed\''.  An \''Approved\'' condition is added via the /approval subresource, indicating the request was approved and should be issued by the signer.  A \''Denied\'' condition is added via the /approval subresource, indicating the request was denied and should not be issued by the signer.  A \''Failed\'' condition is added via the /status subresource, indicating the signer failed to issue the certificate.  Approved and Denied conditions are mutually exclusive. Approved, Denied, and Failed conditions cannot be removed once added.  Only one condition of a given type is allowed. *)
    _type: string [@yojson.key "type"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


