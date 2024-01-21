(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_coordination_v1_lease_spec.t : LeaseSpec is a specification of a Lease.
 *)

type t = {
    (* MicroTime is version of Time with microsecond level precision. *)
    acquire_time: string option [@default None];
    (* holderIdentity contains the identity of the holder of a current lease. *)
    holder_identity: string option [@default None];
    (* leaseDurationSeconds is a duration that candidates for a lease need to wait to force acquire it. This is measure against time of last observed renewTime. *)
    lease_duration_seconds: int32 option [@default None];
    (* leaseTransitions is the number of transitions of a lease between holders. *)
    lease_transitions: int32 option [@default None];
    (* MicroTime is version of Time with microsecond level precision. *)
    renew_time: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** LeaseSpec is a specification of a Lease. *)
let create () : t = {
    acquire_time = None;
    holder_identity = None;
    lease_duration_seconds = None;
    lease_transitions = None;
    renew_time = None;
}

