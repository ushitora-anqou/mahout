(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_volume_device.t : volumeDevice describes a mapping of a raw block device within a container.
 *)

type t = {
    (* devicePath is the path inside of the container that the device will be mapped to. *)
    device_path: string [@key devicePath];
    (* name must match the name of a persistentVolumeClaim in the pod *)
    name: string [@key name];
} [@@deriving yojson { strict = false }, show ];;

(** volumeDevice describes a mapping of a raw block device within a container. *)
let create (device_path : string) (name : string) : t = {
    device_path = device_path;
    name = name;
}

