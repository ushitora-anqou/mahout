(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_event.t : Event is a report of an event somewhere in the cluster.  Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data.
 *)

type t = {
    (* What action was taken/failed regarding to the Regarding object. *)
    action: string option [@default None];
    (* APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources *)
    api_version: string option [@default None];
    (* The number of times this event has occurred. *)
    count: int32 option [@default None];
    (* MicroTime is version of Time with microsecond level precision. *)
    event_time: string option [@default None];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    first_timestamp: string option [@default None];
    involved_object: Io_k8s_api_core_v1_object_reference.t;
    (* Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_timestamp: string option [@default None];
    (* A human-readable description of the status of this operation. *)
    message: string option [@default None];
    metadata: Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t;
    (* This should be a short, machine understandable string that gives the reason for the transition into the object's current status. *)
    reason: string option [@default None];
    related: Io_k8s_api_core_v1_object_reference.t option [@default None];
    (* Name of the controller that emitted this Event, e.g. `kubernetes.io/kubelet`. *)
    reporting_component: string option [@default None];
    (* ID of the controller instance, e.g. `kubelet-xyzf`. *)
    reporting_instance: string option [@default None];
    series: Io_k8s_api_core_v1_event_series.t option [@default None];
    source: Io_k8s_api_core_v1_event_source.t option [@default None];
    (* Type of this event (Normal, Warning), new types could be added in the future *)
    _type: string option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** Event is a report of an event somewhere in the cluster.  Events have a limited retention time and triggers and messages may evolve with time.  Event consumers should not rely on the timing of an event with a given Reason reflecting a consistent underlying trigger, or the continued existence of events with that Reason.  Events should be treated as informative, best-effort, supplemental data. *)
let create (involved_object : Io_k8s_api_core_v1_object_reference.t) (metadata : Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t) : t = {
    action = None;
    api_version = None;
    count = None;
    event_time = None;
    first_timestamp = None;
    involved_object = involved_object;
    kind = None;
    last_timestamp = None;
    message = None;
    metadata = metadata;
    reason = None;
    related = None;
    reporting_component = None;
    reporting_instance = None;
    series = None;
    source = None;
    _type = None;
}

