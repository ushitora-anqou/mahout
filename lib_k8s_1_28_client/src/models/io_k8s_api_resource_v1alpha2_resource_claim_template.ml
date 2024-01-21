(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_resource_v1alpha2_resource_claim_template.t : ResourceClaimTemplate is used to produce ResourceClaim objects.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None] [@key "apiVersion"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None] [@key "kind"];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None] [@key "metadata"];
    spec: Io_k8s_api_resource_v1alpha2_resource_claim_template_spec.t [@key "spec"];
} [@@deriving yojson { strict = false }, show ];;

(** ResourceClaimTemplate is used to produce ResourceClaim objects. *)
let create (spec : Io_k8s_api_resource_v1alpha2_resource_claim_template_spec.t) : t = {
    api_version = None;
    kind = None;
    metadata = None;
    spec = spec;
}

