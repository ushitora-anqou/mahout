(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_volume_mount.t : VolumeMount describes a mounting of a Volume within a container.
 *)

[@@@warning "-32-34"]
open (struct
    include Ppx_yojson_conv_lib.Yojson_conv.Primitives
    type any = Yojson.Safe.t
    let any_of_yojson = Fun.id
    let yojson_of_any = Fun.id
    let pp_any = Yojson.Safe.pp
    let show_any = Yojson.Safe.show
end)
type t = {
    (* Path within the container at which the volume should be mounted.  Must not contain ':'. *)
    mount_path: string [@yojson.key "mountPath"];
    (* mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10. *)
    mount_propagation: string option [@yojson.default None] [@yojson.key "mountPropagation"];
    (* This must match the Name of a Volume. *)
    name: string [@yojson.key "name"];
    (* Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false. *)
    read_only: bool option [@yojson.default None] [@yojson.key "readOnly"];
    (* Path within the volume from which the container's volume should be mounted. Defaults to \''\'' (volume's root). *)
    sub_path: string option [@yojson.default None] [@yojson.key "subPath"];
    (* Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \''\'' (volume's root). SubPathExpr and SubPath are mutually exclusive. *)
    sub_path_expr: string option [@yojson.default None] [@yojson.key "subPathExpr"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


