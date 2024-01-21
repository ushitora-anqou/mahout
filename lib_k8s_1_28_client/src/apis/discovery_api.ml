(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

let get_discovery_api_group ~sw client () =
    let uri = Request.build_uri "/apis/discovery.k8s.io/" in
    let headers = Request.default_headers in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_api_group.of_yojson) resp body

