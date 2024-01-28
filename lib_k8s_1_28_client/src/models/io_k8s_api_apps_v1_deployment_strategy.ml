(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_deployment_strategy.t : DeploymentStrategy describes how to replace existing pods with new ones.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    rolling_update: Io_k8s_api_apps_v1_rolling_update_deployment.t option [@yojson.default None] [@yojson.key "rollingUpdate"];
    (* Type of deployment. Can be \''Recreate\'' or \''RollingUpdate\''. Default is RollingUpdate. *)
    _type: string option [@yojson.default None] [@yojson.key "type"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


