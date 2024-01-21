(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_node_config_status.t : NodeConfigStatus describes the status of the config assigned by Node.Spec.ConfigSource.
 *)

type t = {
    active: Io_k8s_api_core_v1_node_config_source.t option [@default None];
    assigned: Io_k8s_api_core_v1_node_config_source.t option [@default None];
    (* Error describes any problems reconciling the Spec.ConfigSource to the Active config. Errors may occur, for example, attempting to checkpoint Spec.ConfigSource to the local Assigned record, attempting to checkpoint the payload associated with Spec.ConfigSource, attempting to load or validate the Assigned config, etc. Errors may occur at different points while syncing config. Earlier errors (e.g. download or checkpointing errors) will not result in a rollback to LastKnownGood, and may resolve across Kubelet retries. Later errors (e.g. loading or validating a checkpointed config) will result in a rollback to LastKnownGood. In the latter case, it is usually possible to resolve the error by fixing the config assigned in Spec.ConfigSource. You can find additional information for debugging by searching the error message in the Kubelet log. Error is a human-readable description of the error state; machines can check whether or not Error is empty, but should not rely on the stability of the Error text across Kubelet versions. *)
    error: string option [@default None];
    last_known_good: Io_k8s_api_core_v1_node_config_source.t option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** NodeConfigStatus describes the status of the config assigned by Node.Spec.ConfigSource. *)
let create () : t = {
    active = None;
    assigned = None;
    error = None;
    last_known_good = None;
}

