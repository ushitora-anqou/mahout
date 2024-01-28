(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_storage_v1_volume_error.t : VolumeError captures an error encountered during a volume operation.
 *)

type t = {
    (* message represents the error encountered during Attach or Detach operation. This string may be logged, so it should not contain sensitive information. *)
    message: string option [@yojson.default None] [@yojson.key "message"];
    (* Time is a wrapper around time.Time which supports correct marshaling to YAML and JSON.  Wrappers are provided for many of the factory methods that the time package offers. *)
    time: string option [@yojson.default None] [@yojson.key "time"];
} [@@deriving yojson { strict = false }, show, make];;


