(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_resource_requirements.t : ResourceRequirements describes the compute resource requirements.
 *)

type t = {
    (* Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.  This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.  This field is immutable. It can only be set for containers. *)
    claims: Io_k8s_api_core_v1_resource_claim.t list [@default []];
    (* Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ *)
    limits: Yojson.Safe.t list [@default []];
    (* Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ *)
    requests: Yojson.Safe.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** ResourceRequirements describes the compute resource requirements. *)
let create () : t = {
    claims = [];
    limits = [];
    requests = [];
}

