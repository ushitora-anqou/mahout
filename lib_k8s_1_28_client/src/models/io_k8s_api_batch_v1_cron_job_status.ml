(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_batch_v1_cron_job_status.t : CronJobStatus represents the current state of a cron job.
 *)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives
type t = {
    (* A list of pointers to currently running jobs. *)
    active: Io_k8s_api_core_v1_object_reference.t list [@yojson.default []] [@yojson.key "active"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_schedule_time: string option [@yojson.default None] [@yojson.key "lastScheduleTime"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    last_successful_time: string option [@yojson.default None] [@yojson.key "lastSuccessfulTime"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson = t_of_yojson


