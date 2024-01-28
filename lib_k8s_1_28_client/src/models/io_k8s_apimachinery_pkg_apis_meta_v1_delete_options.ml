(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.t : DeleteOptions may be provided when deleting an API object.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@yojson.default None] [@yojson.key "apiVersion"];
    (* When present, indicates that modifications should not be persisted. An invalid or unrecognized dryRun directive will result in an error response and no further processing of the request. Valid values are: - All: all dry run stages will be processed *)
    dry_run: string list [@yojson.default []] [@yojson.key "dryRun"];
    (* The duration in seconds before the object should be deleted. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period for the specified type will be used. Defaults to a per object value if not specified. zero means delete immediately. *)
    grace_period_seconds: int64 option [@yojson.default None] [@yojson.key "gracePeriodSeconds"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@yojson.default None] [@yojson.key "kind"];
    (* Deprecated: please use the PropagationPolicy, this field will be deprecated in 1.7. Should the dependent objects be orphaned. If true/false, the \''orphan\'' finalizer will be added to/removed from the object's finalizers list. Either this field or PropagationPolicy may be set, but not both. *)
    orphan_dependents: bool option [@yojson.default None] [@yojson.key "orphanDependents"];
    preconditions: Io_k8s_apimachinery_pkg_apis_meta_v1_preconditions.t option [@yojson.default None] [@yojson.key "preconditions"];
    (* Whether and how garbage collection will be performed. Either this field or OrphanDependents may be set, but not both. The default policy is decided by the existing finalizer set in the metadata.finalizers and the resource-specific default policy. Acceptable values are: 'Orphan' - orphan the dependents; 'Background' - allow the garbage collector to delete the dependents in the background; 'Foreground' - a cascading policy that deletes all dependents in the foreground. *)
    propagation_policy: string option [@yojson.default None] [@yojson.key "propagationPolicy"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


