(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type any = Yojson.Safe.t

let get_service_account_issuer_open_id_keyset ~sw client ?(headers = Request.default_headers) () =
    let uri = Request.build_uri "/openid/v1/jwks/" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.to_string) resp body

