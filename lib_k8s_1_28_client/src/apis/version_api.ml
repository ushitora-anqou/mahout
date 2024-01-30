(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type any = Yojson.Safe.t

let get_code_version ~sw client ?(headers = Request.default_headers) () =
    let uri = Request.build_uri "/version/" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_version_info.of_yojson) resp body

