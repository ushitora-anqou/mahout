(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authentication_v1_token_request_status.t : TokenRequestStatus is the result of a token request.
 *)

type t = {
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    expiration_timestamp: string [@key "expirationTimestamp"];
    (* Token is the opaque bearer token. *)
    token: string [@key "token"];
} [@@deriving yojson { strict = false }, show ];;

(** TokenRequestStatus is the result of a token request. *)
let create (expiration_timestamp : string) (token : string) : t = {
    expiration_timestamp = expiration_timestamp;
    token = token;
}

