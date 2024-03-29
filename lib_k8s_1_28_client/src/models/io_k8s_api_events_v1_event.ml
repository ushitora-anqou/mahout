(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_events_v1_event.t : Event is a report of an event somewhere in the cluster. It generally denotes some state change in the system. Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
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
    (* action is what action was taken/failed regarding to the regarding object. It is machine-readable. This field cannot be empty for new Events and it can have at most 128 characters. *)
    action: string option [@yojson.default None] [@yojson.key "action"];
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@yojson.default None] [@yojson.key "apiVersion"];
    (* deprecatedCount is the deprecated field assuring backward compatibility with core.v1 Event type. *)
    deprecated_count: int32 option [@yojson.default None] [@yojson.key "deprecatedCount"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    deprecated_first_timestamp: string option [@yojson.default None] [@yojson.key "deprecatedFirstTimestamp"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    deprecated_last_timestamp: string option [@yojson.default None] [@yojson.key "deprecatedLastTimestamp"];
    deprecated_source: Io_k8s_api_core_v1_event_source.t option [@yojson.default None] [@yojson.key "deprecatedSource"];
    (* MicroTime is version of Time with microsecond level precision. *)
    event_time: string [@yojson.key "eventTime"];
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@yojson.default None] [@yojson.key "kind"];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option [@yojson.default None] [@yojson.key "metadata"];
    (* note is a human-readable description of the status of this operation. Maximal length of the note is 1kB, but libraries should be prepared to handle values up to 64kB. *)
    note: string option [@yojson.default None] [@yojson.key "note"];
    (* reason is why the action was taken. It is human-readable. This field cannot be empty for new Events and it can have at most 128 characters. *)
    reason: string option [@yojson.default None] [@yojson.key "reason"];
    regarding: Io_k8s_api_core_v1_object_reference.t option [@yojson.default None] [@yojson.key "regarding"];
    related: Io_k8s_api_core_v1_object_reference.t option [@yojson.default None] [@yojson.key "related"];
    (* reportingController is the name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`. This field cannot be empty for new Events. *)
    reporting_controller: string option [@yojson.default None] [@yojson.key "reportingController"];
    (* reportingInstance is the ID of the controller instance, e.g. `kubelet-xyzf`. This field cannot be empty for new Events and it can have at most 128 characters. *)
    reporting_instance: string option [@yojson.default None] [@yojson.key "reportingInstance"];
    series: Io_k8s_api_events_v1_event_series.t option [@yojson.default None] [@yojson.key "series"];
    (* type is the type of this event (Normal, Warning), new types could be added in the future. It is machine-readable. This field cannot be empty for new Events. *)
    _type: string option [@yojson.default None] [@yojson.key "type"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


