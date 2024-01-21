(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_events_v1_event_series.t : EventSeries contain information on series of events, i.e. thing that was/is happening continuously for some time. How often to update the EventSeries is up to the event reporters. The default event reporter in \''k8s.io/client-go/tools/events/event_broadcaster.go\'' shows how this struct is updated on heartbeats and can guide customized reporter implementations.
 *)

type t = {
    (* count is the number of occurrences in this series up to the last heartbeat time. *)
    count: int32 [@key count];
    (* MicroTime is version of Time with microsecond level precision. *)
    last_observed_time: string [@key lastObservedTime];
} [@@deriving yojson { strict = false }, show ];;

(** EventSeries contain information on series of events, i.e. thing that was/is happening continuously for some time. How often to update the EventSeries is up to the event reporters. The default event reporter in \''k8s.io/client-go/tools/events/event_broadcaster.go\'' shows how this struct is updated on heartbeats and can guide customized reporter implementations. *)
let create (count : int32) (last_observed_time : string) : t = {
    count = count;
    last_observed_time = last_observed_time;
}

