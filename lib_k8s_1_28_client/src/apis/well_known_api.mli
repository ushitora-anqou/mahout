(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type any = Yojson.Safe.t

val get_service_account_issuer_open_id_configuration : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> unit -> (string Json_response_scanner.t, Cohttp.Response.t) result
