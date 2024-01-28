(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_secret_projection.t : Adapts a secret into a projected volume.  The contents of the target Secret's Data field will be presented in a projected volume as files using the keys in the Data field as the file names. Note that this is identical to a secret volume source without the default mode.
 *)

type t = {
    (* items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'. *)
    items: Io_k8s_api_core_v1_key_to_path.t list [@yojson.default []] [@yojson.key "items"];
    (* Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names *)
    name: string option [@yojson.default None] [@yojson.key "name"];
    (* optional field specify whether the Secret or its key must be defined *)
    optional: bool option [@yojson.default None] [@yojson.key "optional"];
} [@@deriving yojson { strict = false }, show, make];;


