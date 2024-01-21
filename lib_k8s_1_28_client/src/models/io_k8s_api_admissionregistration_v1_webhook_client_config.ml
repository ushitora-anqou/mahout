(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1_webhook_client_config.t : WebhookClientConfig contains the information to make a TLS connection with the webhook
 *)

type t = {
    (* `caBundle` is a PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used. *)
    ca_bundle: string option [@default None] [@key caBundle];
    service: Io_k8s_api_admissionregistration_v1_service_reference.t option [@default None] [@key service];
    (* `url` gives the location of the webhook, in standard URL form (`scheme://host:port/path`). Exactly one of `url` or `service` must be specified.  The `host` should not refer to a service running in the cluster; use the `service` field instead. The host might be resolved via external DNS in some apiservers (e.g., `kube-apiserver` cannot resolve in-cluster DNS as that would be a layering violation). `host` may also be an IP address.  Please note that using `localhost` or `127.0.0.1` as a `host` is risky unless you take great care to run this webhook on all hosts which run an apiserver which might need to make calls to this webhook. Such installs are likely to be non-portable, i.e., not easy to turn up in a new cluster.  The scheme must be \''https\''; the URL must begin with \''https://\''.  A path is optional, and if present may be any string permissible in a URL. You may use the path to pass an arbitrary string to the webhook, for example, a cluster identifier.  Attempting to use a user or basic auth e.g. \''user:password@\'' is not allowed. Fragments (\''#...\'') and query parameters (\''?...\'') are not allowed, either. *)
    url: string option [@default None] [@key url];
} [@@deriving yojson { strict = false }, show ];;

(** WebhookClientConfig contains the information to make a TLS connection with the webhook *)
let create () : t = {
    ca_bundle = None;
    service = None;
    url = None;
}

