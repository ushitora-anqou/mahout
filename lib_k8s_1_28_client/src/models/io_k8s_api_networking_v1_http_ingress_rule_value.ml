(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_networking_v1_http_ingress_rule_value.t : HTTPIngressRuleValue is a list of http selectors pointing to backends. In the example: http://<host>/<path>?<searchpart> -> backend where where parts of the url correspond to RFC 3986, this resource will be used to match against everything after the last '/' and before the first '?' or '#'.
 *)

type t = {
    (* paths is a collection of paths that map requests to backends. *)
    paths: Io_k8s_api_networking_v1_http_ingress_path.t list;
} [@@deriving yojson { strict = false }, show ];;

(** HTTPIngressRuleValue is a list of http selectors pointing to backends. In the example: http://<host>/<path>?<searchpart> -> backend where where parts of the url correspond to RFC 3986, this resource will be used to match against everything after the last '/' and before the first '?' or '#'. *)
let create (paths : Io_k8s_api_networking_v1_http_ingress_path.t list) : t = {
    paths = paths;
}

