(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_resource_v1alpha2_resource_claim_status.t : ResourceClaimStatus tracks whether the resource has been allocated and what the resulting attributes are.
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
    allocation: Io_k8s_api_resource_v1alpha2_allocation_result.t option [@yojson.default None] [@yojson.key "allocation"];
    (* DeallocationRequested indicates that a ResourceClaim is to be deallocated.  The driver then must deallocate this claim and reset the field together with clearing the Allocation field.  While DeallocationRequested is set, no new consumers may be added to ReservedFor. *)
    deallocation_requested: bool option [@yojson.default None] [@yojson.key "deallocationRequested"];
    (* DriverName is a copy of the driver name from the ResourceClass at the time when allocation started. *)
    driver_name: string option [@yojson.default None] [@yojson.key "driverName"];
    (* ReservedFor indicates which entities are currently allowed to use the claim. A Pod which references a ResourceClaim which is not reserved for that Pod will not be started.  There can be at most 32 such reservations. This may get increased in the future, but not reduced. *)
    reserved_for: Io_k8s_api_resource_v1alpha2_resource_claim_consumer_reference.t list [@default []] [@yojson.key "reservedFor"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


