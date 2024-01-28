(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authorization_v1_self_subject_access_review.t : SelfSubjectAccessReview checks whether or the current user can perform an action.  Not filling in a spec.namespace means \''in all namespaces\''.  Self is a special case, because users should always be able to check whether they can perform an action
 *)

type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@yojson.default None] [@yojson.key "apiVersion"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@yojson.default None] [@yojson.key "kind"];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@yojson.default None] [@yojson.key "metadata"];
    spec: Io_k8s_api_authorization_v1_self_subject_access_review_spec.t [@yojson.key "spec"];
    status: Io_k8s_api_authorization_v1_subject_access_review_status.t option [@yojson.default None] [@yojson.key "status"];
} [@@deriving yojson { strict = false }, show, make];;


