(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_replication_controller_status.t : ReplicationControllerStatus represents the current status of a replication controller.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
    let string_of_yojson = function
      | `String s -> s
      | `Int i -> string_of_int i
      | _ -> failwith "string_of_yojson: string or int needed"
end)
type t = {
    (* The number of available replicas (ready for at least minReadySeconds) for this replication controller. *)
    available_replicas: int32 option [@yojson.default None] [@yojson.key "availableReplicas"];
    (* Represents the latest available observations of a replication controller's current state. *)
    conditions: Io_k8s_api_core_v1_replication_controller_condition.t list [@default []] [@yojson.key "conditions"];
    (* The number of pods that have labels matching the labels of the pod template of the replication controller. *)
    fully_labeled_replicas: int32 option [@yojson.default None] [@yojson.key "fullyLabeledReplicas"];
    (* ObservedGeneration reflects the generation of the most recently observed replication controller. *)
    observed_generation: int64 option [@yojson.default None] [@yojson.key "observedGeneration"];
    (* The number of ready replicas for this replication controller. *)
    ready_replicas: int32 option [@yojson.default None] [@yojson.key "readyReplicas"];
    (* Replicas is the most recently observed number of replicas. More info: https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller#what-is-a-replicationcontroller *)
    replicas: int32 [@yojson.key "replicas"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


