(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_deployment_status.t : DeploymentStatus is the most recently observed status of the Deployment.
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
    (* Total number of available pods (ready for at least minReadySeconds) targeted by this deployment. *)
    available_replicas: int32 option [@yojson.default None] [@yojson.key "availableReplicas"];
    (* Count of hash collisions for the Deployment. The Deployment controller uses this field as a collision avoidance mechanism when it needs to create the name for the newest ReplicaSet. *)
    collision_count: int32 option [@yojson.default None] [@yojson.key "collisionCount"];
    (* Represents the latest available observations of a deployment's current state. *)
    conditions: Io_k8s_api_apps_v1_deployment_condition.t list [@default []] [@yojson.key "conditions"];
    (* The generation observed by the deployment controller. *)
    observed_generation: int64 option [@yojson.default None] [@yojson.key "observedGeneration"];
    (* readyReplicas is the number of pods targeted by this Deployment with a Ready Condition. *)
    ready_replicas: int32 option [@yojson.default None] [@yojson.key "readyReplicas"];
    (* Total number of non-terminated pods targeted by this deployment (their labels match the selector). *)
    replicas: int32 option [@yojson.default None] [@yojson.key "replicas"];
    (* Total number of unavailable pods targeted by this deployment. This is the total number of pods that are still required for the deployment to have 100% available capacity. They may either be pods that are running but not yet available or pods that still have not been created. *)
    unavailable_replicas: int32 option [@yojson.default None] [@yojson.key "unavailableReplicas"];
    (* Total number of non-terminated pods targeted by this deployment that have the desired template spec. *)
    updated_replicas: int32 option [@yojson.default None] [@yojson.key "updatedReplicas"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


