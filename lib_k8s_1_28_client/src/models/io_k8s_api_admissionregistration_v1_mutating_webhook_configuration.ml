(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1_mutating_webhook_configuration.t : MutatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and may change the object.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None] [@key apiVersion];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None] [@key kind];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None] [@key metadata];
    (* Webhooks is a list of webhooks and the affected resources and operations. *)
    webhooks: Io_k8s_api_admissionregistration_v1_mutating_webhook.t list [@default []] [@key webhooks];
} [@@deriving yojson { strict = false }, show ];;

(** MutatingWebhookConfiguration describes the configuration of and admission webhook that accept or reject and may change the object. *)
let create () : t = {
    api_version = None;
    kind = None;
    metadata = None;
    webhooks = [];
}

