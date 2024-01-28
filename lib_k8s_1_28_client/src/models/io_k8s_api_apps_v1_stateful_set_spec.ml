(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_stateful_set_spec.t : A StatefulSetSpec is the specification of a StatefulSet.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
end)
type t = {
    (* Minimum number of seconds for which a newly created pod should be ready without any of its container crashing for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready) *)
    min_ready_seconds: int32 option [@yojson.default None] [@yojson.key "minReadySeconds"];
    ordinals: Io_k8s_api_apps_v1_stateful_set_ordinals.t option [@yojson.default None] [@yojson.key "ordinals"];
    persistent_volume_claim_retention_policy: Io_k8s_api_apps_v1_stateful_set_persistent_volume_claim_retention_policy.t option [@yojson.default None] [@yojson.key "persistentVolumeClaimRetentionPolicy"];
    (* podManagementPolicy controls how pods are created during initial scale up, when replacing pods on nodes, or when scaling down. The default policy is `OrderedReady`, where pods are created in increasing order (pod-0, then pod-1, etc) and the controller will wait until each pod is ready before continuing. When scaling down, the pods are removed in the opposite order. The alternative policy is `Parallel` which will create pods in parallel to match the desired scale without waiting, and on scale down will delete all pods at once. *)
    pod_management_policy: string option [@yojson.default None] [@yojson.key "podManagementPolicy"];
    (* replicas is the desired number of replicas of the given Template. These are replicas in the sense that they are instantiations of the same Template, but individual replicas also have a consistent identity. If unspecified, defaults to 1. *)
    replicas: int32 option [@yojson.default None] [@yojson.key "replicas"];
    (* revisionHistoryLimit is the maximum number of revisions that will be maintained in the StatefulSet's revision history. The revision history consists of all revisions not represented by a currently applied StatefulSetSpec version. The default value is 10. *)
    revision_history_limit: int32 option [@yojson.default None] [@yojson.key "revisionHistoryLimit"];
    selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t [@yojson.key "selector"];
    (* serviceName is the name of the service that governs this StatefulSet. This service must exist before the StatefulSet, and is responsible for the network identity of the set. Pods get DNS/hostnames that follow the pattern: pod-specific-string.serviceName.default.svc.cluster.local where \''pod-specific-string\'' is managed by the StatefulSet controller. *)
    service_name: string [@yojson.key "serviceName"];
    template: Io_k8s_api_core_v1_pod_template_spec.t [@yojson.key "template"];
    update_strategy: Io_k8s_api_apps_v1_stateful_set_update_strategy.t option [@yojson.default None] [@yojson.key "updateStrategy"];
    (* volumeClaimTemplates is a list of claims that pods are allowed to reference. The StatefulSet controller is responsible for mapping network identities to claims in a way that maintains the identity of a pod. Every claim in this list must have at least one matching (by name) volumeMount in one container in the template. A claim in this list takes precedence over any volumes in the template, with the same name. *)
    volume_claim_templates: Io_k8s_api_core_v1_persistent_volume_claim.t list [@default []] [@yojson.key "volumeClaimTemplates"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


