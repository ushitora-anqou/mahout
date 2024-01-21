(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1beta1_validating_admission_policy_binding_list.t : ValidatingAdmissionPolicyBindingList is a list of ValidatingAdmissionPolicyBinding.
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None];
    (* List of PolicyBinding. *)
    items: Io_k8s_api_admissionregistration_v1beta1_validating_admission_policy_binding.t list;
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_list_meta.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** ValidatingAdmissionPolicyBindingList is a list of ValidatingAdmissionPolicyBinding. *)
let create () : t = {
    api_version = None;
    items = [];
    kind = None;
    metadata = None;
}

