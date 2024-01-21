(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_container_image.t : Describe a container image
 *)

type t = {
    (* Names by which this image is known. e.g. [\''kubernetes.example/hyperkube:v1.0.7\'', \''cloud-vendor.registry.example/cloud-vendor/hyperkube:v1.0.7\''] *)
    names: string list [@default []] [@key "names"];
    (* The size of the image in bytes. *)
    size_bytes: int64 option [@default None] [@key "sizeBytes"];
} [@@deriving yojson { strict = false }, show ];;

(** Describe a container image *)
let create () : t = {
    names = [];
    size_bytes = None;
}

