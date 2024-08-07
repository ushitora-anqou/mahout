(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_container_status.t : ContainerStatus contains details for the current status of this container.
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
    (* AllocatedResources represents the compute resources allocated for this container by the node. Kubelet sets this value to Container.Resources.Requests upon successful pod admission and after successfully admitting desired pod resize. *)
    allocated_resources: any [@default (`Assoc [])] [@yojson.key "allocatedResources"];
    (* ContainerID is the ID of the container in the format '<type>://<container_id>'. Where type is a container runtime identifier, returned from Version call of CRI API (for example \''containerd\''). *)
    container_id: string option [@yojson.default None] [@yojson.key "containerID"];
    (* Image is the name of container image that the container is running. The container image may not match the image used in the PodSpec, as it may have been resolved by the runtime. More info: https://kubernetes.io/docs/concepts/containers/images. *)
    image: string [@yojson.key "image"];
    (* ImageID is the image ID of the container's image. The image ID may not match the image ID of the image used in the PodSpec, as it may have been resolved by the runtime. *)
    image_id: string [@yojson.key "imageID"];
    last_state: Io_k8s_api_core_v1_container_state.t option [@yojson.default None] [@yojson.key "lastState"];
    (* Name is a DNS_LABEL representing the unique name of the container. Each container in a pod must have a unique name across all container types. Cannot be updated. *)
    name: string [@yojson.key "name"];
    (* Ready specifies whether the container is currently passing its readiness check. The value will change as readiness probes keep executing. If no readiness probes are specified, this field defaults to true once the container is fully started (see Started field).  The value is typically used to determine whether a container is ready to accept traffic. *)
    ready: bool [@yojson.key "ready"];
    resources: Io_k8s_api_core_v1_resource_requirements.t option [@yojson.default None] [@yojson.key "resources"];
    (* RestartCount holds the number of times the container has been restarted. Kubelet makes an effort to always increment the value, but there are cases when the state may be lost due to node restarts and then the value may be reset to 0. The value is never negative. *)
    restart_count: int32 [@yojson.key "restartCount"];
    (* Started indicates whether the container has finished its postStart lifecycle hook and passed its startup probe. Initialized as false, becomes true after startupProbe is considered successful. Resets to false when the container is restarted, or if kubelet loses state temporarily. In both cases, startup probes will run again. Is always true when no startupProbe is defined and container is running and has passed the postStart lifecycle hook. The null value must be treated the same as false. *)
    started: bool option [@yojson.default None] [@yojson.key "started"];
    state: Io_k8s_api_core_v1_container_state.t option [@yojson.default None] [@yojson.key "state"];
    (* Status of volume mounts. *)
    volume_mounts: Io_k8s_api_core_v1_volume_mount_status.t list [@default []] [@yojson.key "volumeMounts"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


