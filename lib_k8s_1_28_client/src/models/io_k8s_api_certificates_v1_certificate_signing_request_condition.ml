(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_certificates_v1_certificate_signing_request_condition.t : CertificateSigningRequestCondition describes a condition of a CertificateSigningRequest object
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_transition_time: string option [@default None] [@key lastTransitionTime];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_update_time: string option [@default None] [@key lastUpdateTime];
    (* message contains a human readable message with details about the request state *)
    message: string option [@default None] [@key message];
    (* reason indicates a brief reason for the request state *)
    reason: string option [@default None] [@key reason];
    (* status of the condition, one of True, False, Unknown. Approved, Denied, and Failed conditions may not be \''False\'' or \''Unknown\''. *)
    status: string [@key status];
    (* type of the condition. Known conditions are \''Approved\'', \''Denied\'', and \''Failed\''.  An \''Approved\'' condition is added via the /approval subresource, indicating the request was approved and should be issued by the signer.  A \''Denied\'' condition is added via the /approval subresource, indicating the request was denied and should not be issued by the signer.  A \''Failed\'' condition is added via the /status subresource, indicating the signer failed to issue the certificate.  Approved and Denied conditions are mutually exclusive. Approved, Denied, and Failed conditions cannot be removed once added.  Only one condition of a given type is allowed. *)
    _type: string [@key type];
} [@@deriving yojson { strict = false }, show ];;

(** CertificateSigningRequestCondition describes a condition of a CertificateSigningRequest object *)
let create (status : string) (_type : string) : t = {
    last_transition_time = None;
    last_update_time = None;
    message = None;
    reason = None;
    status = status;
    _type = _type;
}

