(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_event.t : Event is a report of an event somewhere in the cluster.  Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
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
    (* What action was taken/failed regarding to the Regarding object. *)
    action: string option [@yojson.default None] [@yojson.key "action"];
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@yojson.default None] [@yojson.key "apiVersion"];
    (* The number of times this event has occurred. *)
    count: int32 option [@yojson.default None] [@yojson.key "count"];
    (* MicroTime is version of Time with microsecond level precision. *)
    event_time: string option [@yojson.default None] [@yojson.key "eventTime"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    first_timestamp: string option [@yojson.default None] [@yojson.key "firstTimestamp"];
    involved_object: Io_k8s_api_core_v1_object_reference.t [@yojson.key "involvedObject"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@yojson.default None] [@yojson.key "kind"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_timestamp: string option [@yojson.default None] [@yojson.key "lastTimestamp"];
    (* A human-readable description of the status of this operation. *)
    message: string option [@yojson.default None] [@yojson.key "message"];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t [@yojson.key "metadata"];
    (* This should be a short, machine understandable string that gives the reason for the transition into the object's current status. *)
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    related: Io_k8s_api_core_v1_object_reference.t option [@yojson.default None] [@yojson.key "related"];
    (* Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`. *)
    reporting_component: string option [@yojson.default None] [@yojson.key "reportingComponent"];
    (* ID of the controller instance, e.g. `kubelet-xyzf`. *)
    reporting_instance: string option [@yojson.default None] [@yojson.key "reportingInstance"];
    series: Io_k8s_api_core_v1_event_series.t option [@yojson.default None] [@yojson.key "series"];
    source: Io_k8s_api_core_v1_event_source.t option [@yojson.default None] [@yojson.key "source"];
    (* Type of this event (Normal, Warning), new types could be added in the future *)
    _type: string option [@yojson.default None] [@yojson.key "type"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


