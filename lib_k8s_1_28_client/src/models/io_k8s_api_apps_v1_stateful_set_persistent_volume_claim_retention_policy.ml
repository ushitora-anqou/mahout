(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_apps_v1_stateful_set_persistent_volume_claim_retention_policy.t : StatefulSetPersistentVolumeClaimRetentionPolicy describes the policy used for PVCs created from the StatefulSet VolumeClaimTemplates.
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
    (* WhenDeleted specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is deleted. The default policy of `Retain` causes PVCs to not be affected by StatefulSet deletion. The `Delete` policy causes those PVCs to be deleted. *)
    when_deleted: string option [@yojson.default None] [@yojson.key "whenDeleted"];
    (* WhenScaled specifies what happens to PVCs created from StatefulSet VolumeClaimTemplates when the StatefulSet is scaled down. The default policy of `Retain` causes PVCs to not be affected by a scaledown. The `Delete` policy causes the associated PVCs for any excess pods above the replica count to be deleted. *)
    when_scaled: string option [@yojson.default None] [@yojson.key "whenScaled"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


