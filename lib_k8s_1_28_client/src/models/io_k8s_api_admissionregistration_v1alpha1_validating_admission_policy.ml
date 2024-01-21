(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1alpha1_validating_admission_policy.t : ValidatingAdmissionPolicy describes the definition of an admission validation policy that accepts or rejects an object without changing it.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None];
    spec: Io_k8s_api_admissionregistration_v1alpha1_validating_admission_policy_spec.t option [@default None];
    status: Io_k8s_api_admissionregistration_v1alpha1_validating_admission_policy_status.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** ValidatingAdmissionPolicy describes the definition of an admission validation policy that accepts or rejects an object without changing it. *)
let create () : t = {
    api_version = None;
    kind = None;
    metadata = None;
    spec = None;
    status = None;
}

