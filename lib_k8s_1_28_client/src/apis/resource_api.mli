(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type any = Yojson.Safe.t

val get_resource_api_group : sw:Eio.Switch.t -> Cohttp_eio.Client.t -> ?headers:Cohttp.Header.t -> unit -> (Io_k8s_apimachinery_pkg_apis_meta_v1_api_group.t Json_response_scanner.t, Cohttp.Response.t) result