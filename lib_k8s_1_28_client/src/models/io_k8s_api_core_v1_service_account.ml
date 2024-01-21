(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_service_account.t : ServiceAccount binds together: * a name, understood by users, and perhaps by peripheral systems, for an identity * a principal that can be authenticated and authorized * a set of secrets
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None] [@key apiVersion];
    (* AutomountServiceAccountToken indicates whether pods running as this service account should have an API token automatically mounted. Can be overridden at the pod level. *)
    automount_service_account_token: bool option [@default None] [@key automountServiceAccountToken];
    (* ImagePullSecrets is a list of references to secrets in the same namespace to use for pulling any images in pods that reference this ServiceAccount. ImagePullSecrets are distinct from Secrets because Secrets can be mounted in the pod, but ImagePullSecrets are only accessed by the kubelet. More info: https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod *)
    image_pull_secrets: Io_k8s_api_core_v1_local_object_reference.t list [@default []] [@key imagePullSecrets];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None] [@key kind];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None] [@key metadata];
    (* Secrets is a list of the secrets in the same namespace that pods running using this ServiceAccount are allowed to use. Pods are only limited to this list if this service account has a \''kubernetes.io/enforce-mountable-secrets\'' annotation set to \''true\''. This field should not be used to find auto-generated service account token secrets for use outside of pods. Instead, tokens can be requested directly using the TokenRequest API, or service account token secrets can be manually created. More info: https://kubernetes.io/docs/concepts/configuration/secret *)
    secrets: Io_k8s_api_core_v1_object_reference.t list [@default []] [@key secrets];
} [@@deriving yojson { strict = false }, show ];;

(** ServiceAccount binds together: * a name, understood by users, and perhaps by peripheral systems, for an identity * a principal that can be authenticated and authorized * a set of secrets *)
let create () : t = {
    api_version = None;
    automount_service_account_token = None;
    image_pull_secrets = [];
    kind = None;
    metadata = None;
    secrets = [];
}

