(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_persistent_volume_claim_template.t : PersistentVolumeClaimTemplate is used to produce PersistentVolumeClaim objects as part of an EphemeralVolumeSource.
 *)

type t = {
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@default None] [@key metadata];
    spec: Io_k8s_api_core_v1_persistent_volume_claim_spec.t [@key spec];
} [@@deriving yojson { strict = false }, show ];;

(** PersistentVolumeClaimTemplate is used to produce PersistentVolumeClaim objects as part of an EphemeralVolumeSource. *)
let create (spec : Io_k8s_api_core_v1_persistent_volume_claim_spec.t) : t = {
    metadata = None;
    spec = spec;
}

