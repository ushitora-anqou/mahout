(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_webhook_conversion.t : WebhookConversion describes how to call a conversion webhook
 *)

type t = {
    client_config: Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_webhook_client_config.t option [@default None];
    (* conversionReviewVersions is an ordered list of preferred `ConversionReview` versions the Webhook expects. The API server will use the first version in the list which it supports. If none of the versions specified in this list are supported by API server, conversion will fail for the custom resource. If a persisted Webhook configuration specifies allowed versions and does not include any versions known to the API Server, calls to the webhook will fail. *)
    conversion_review_versions: string list;
} [@@deriving yojson { strict = false }, show ];;

(** WebhookConversion describes how to call a conversion webhook *)
let create (conversion_review_versions : string list) : t = {
    client_config = None;
    conversion_review_versions = conversion_review_versions;
}

