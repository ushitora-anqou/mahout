(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_custom_resource_conversion.t : CustomResourceConversion describes how to convert different versions of a CR.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* strategy specifies how custom resources are converted between versions. Allowed values are: - `\''None\''`: The converter only change the apiVersion and would not touch any other field in the custom resource. - `\''Webhook\''`: API Server will call to an external webhook to do the conversion. Additional information   is needed for this option. This requires spec.preserveUnknownFields to be false, and spec.conversion.webhook to be set. *)
    strategy: string [@yojson.key "strategy"];
    webhook: Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_webhook_conversion.t option [@yojson.default None] [@yojson.key "webhook"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


