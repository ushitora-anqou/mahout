(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_container.t : A single application container that you want to run within a pod.
 *)

type t = {
    (* Arguments to the entrypoint. The container image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \''$$(VAR_NAME)\'' will produce the string literal \''$(VAR_NAME)\''. Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell *)
    args: string list [@default []] [@key "args"];
    (* Entrypoint array. Not executed within a shell. The container image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \''$$(VAR_NAME)\'' will produce the string literal \''$(VAR_NAME)\''. Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell *)
    command: string list [@default []] [@key "command"];
    (* List of environment variables to set in the container. Cannot be updated. *)
    env: Io_k8s_api_core_v1_env_var.t list [@default []] [@key "env"];
    (* List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated. *)
    env_from: Io_k8s_api_core_v1_env_from_source.t list [@default []] [@key "envFrom"];
    (* Container image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets. *)
    image: string option [@default None] [@key "image"];
    (* Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images *)
    image_pull_policy: string option [@default None] [@key "imagePullPolicy"];
    lifecycle: Io_k8s_api_core_v1_lifecycle.t option [@default None] [@key "lifecycle"];
    liveness_probe: Io_k8s_api_core_v1_probe.t option [@default None] [@key "livenessProbe"];
    (* Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated. *)
    name: string [@key "name"];
    (* List of ports to expose from the container. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \''0.0.0.0\'' address inside a container will be accessible from the network. Modifying this array with strategic merge patch may corrupt the data. For more information See https://github.com/kubernetes/kubernetes/issues/108255. Cannot be updated. *)
    ports: Io_k8s_api_core_v1_container_port.t list [@default []] [@key "ports"];
    readiness_probe: Io_k8s_api_core_v1_probe.t option [@default None] [@key "readinessProbe"];
    (* Resources resize policy for the container. *)
    resize_policy: Io_k8s_api_core_v1_container_resize_policy.t list [@default []] [@key "resizePolicy"];
    resources: Io_k8s_api_core_v1_resource_requirements.t option [@default None] [@key "resources"];
    (* RestartPolicy defines the restart behavior of individual containers in a pod. This field may only be set for init containers, and the only allowed value is \''Always\''. For non-init containers or when this field is not specified, the restart behavior is defined by the Pod's restart policy and the container type. Setting the RestartPolicy as \''Always\'' for the init container will have the following effect: this init container will be continually restarted on exit until all regular containers have terminated. Once all regular containers have completed, all init containers with restartPolicy \''Always\'' will be shut down. This lifecycle differs from normal init containers and is often referred to as a \''sidecar\'' container. Although this init container still starts in the init container sequence, it does not wait for the container to complete before proceeding to the next init container. Instead, the next init container starts immediately after this init container is started, or after any startupProbe has successfully completed. *)
    restart_policy: string option [@default None] [@key "restartPolicy"];
    security_context: Io_k8s_api_core_v1_security_context.t option [@default None] [@key "securityContext"];
    startup_probe: Io_k8s_api_core_v1_probe.t option [@default None] [@key "startupProbe"];
    (* Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false. *)
    stdin: bool option [@default None] [@key "stdin"];
    (* Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false *)
    stdin_once: bool option [@default None] [@key "stdinOnce"];
    (* Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated. *)
    termination_message_path: string option [@default None] [@key "terminationMessagePath"];
    (* Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated. *)
    termination_message_policy: string option [@default None] [@key "terminationMessagePolicy"];
    (* Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false. *)
    tty: bool option [@default None] [@key "tty"];
    (* volumeDevices is the list of block devices to be used by the container. *)
    volume_devices: Io_k8s_api_core_v1_volume_device.t list [@default []] [@key "volumeDevices"];
    (* Pod volumes to mount into the container's filesystem. Cannot be updated. *)
    volume_mounts: Io_k8s_api_core_v1_volume_mount.t list [@default []] [@key "volumeMounts"];
    (* Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated. *)
    working_dir: string option [@default None] [@key "workingDir"];
} [@@deriving yojson { strict = false }, show ];;

(** A single application container that you want to run within a pod. *)
let create (name : string) : t = {
    args = [];
    command = [];
    env = [];
    env_from = [];
    image = None;
    image_pull_policy = None;
    lifecycle = None;
    liveness_probe = None;
    name = name;
    ports = [];
    readiness_probe = None;
    resize_policy = [];
    resources = None;
    restart_policy = None;
    security_context = None;
    startup_probe = None;
    stdin = None;
    stdin_once = None;
    termination_message_path = None;
    termination_message_policy = None;
    tty = None;
    volume_devices = [];
    volume_mounts = [];
    working_dir = None;
}

