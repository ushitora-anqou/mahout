(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type any = Yojson.Safe.t

let log_file_handler ~sw client ?(headers = Request.default_headers) ~logpath =
    let uri = Request.build_uri "/logs/{logpath}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "logpath" (fun x -> x) logpath in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.handle_unit_response resp

let log_file_list_handler ~sw client ?(headers = Request.default_headers) () =
    let uri = Request.build_uri "/logs/" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.handle_unit_response resp

