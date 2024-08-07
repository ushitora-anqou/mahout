(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_security_context.t : SecurityContext holds security configuration that will be applied to a container. Some fields are present in both SecurityContext and PodSecurityContext.  When both are set, the values in SecurityContext take precedence.
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
    (* AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows. *)
    allow_privilege_escalation: bool option [@yojson.default None] [@yojson.key "allowPrivilegeEscalation"];
    app_armor_profile: Io_k8s_api_core_v1_app_armor_profile.t option [@yojson.default None] [@yojson.key "appArmorProfile"];
    capabilities: Io_k8s_api_core_v1_capabilities.t option [@yojson.default None] [@yojson.key "capabilities"];
    (* Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false. Note that this field cannot be set when spec.os.name is windows. *)
    privileged: bool option [@yojson.default None] [@yojson.key "privileged"];
    (* procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled. Note that this field cannot be set when spec.os.name is windows. *)
    proc_mount: string option [@yojson.default None] [@yojson.key "procMount"];
    (* Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows. *)
    read_only_root_filesystem: bool option [@yojson.default None] [@yojson.key "readOnlyRootFilesystem"];
    (* The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows. *)
    run_as_group: int64 option [@yojson.default None] [@yojson.key "runAsGroup"];
    (* Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. *)
    run_as_non_root: bool option [@yojson.default None] [@yojson.key "runAsNonRoot"];
    (* The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence. Note that this field cannot be set when spec.os.name is windows. *)
    run_as_user: int64 option [@yojson.default None] [@yojson.key "runAsUser"];
    se_linux_options: Io_k8s_api_core_v1_se_linux_options.t option [@yojson.default None] [@yojson.key "seLinuxOptions"];
    seccomp_profile: Io_k8s_api_core_v1_seccomp_profile.t option [@yojson.default None] [@yojson.key "seccompProfile"];
    windows_options: Io_k8s_api_core_v1_windows_security_context_options.t option [@yojson.default None] [@yojson.key "windowsOptions"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


