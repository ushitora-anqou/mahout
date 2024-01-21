(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_pod_spec.t : PodSpec is a description of a pod.
 *)

type t = {
    (* Optional duration in seconds the pod may be active on the node relative to StartTime before the system will actively try to mark it failed and kill associated containers. Value must be a positive integer. *)
    active_deadline_seconds: int64 option [@default None];
    affinity: Io_k8s_api_core_v1_affinity.t option [@default None];
    (* AutomountServiceAccountToken indicates whether a service account token should be automatically mounted. *)
    automount_service_account_token: bool option [@default None];
    (* List of containers belonging to the pod. Containers cannot currently be added or removed. There must be at least one container in a Pod. Cannot be updated. *)
    containers: Io_k8s_api_core_v1_container.t list [@default []];
    dns_config: Io_k8s_api_core_v1_pod_dns_config.t option [@default None];
    (* Set DNS policy for the pod. Defaults to \''ClusterFirst\''. Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS parameters given in DNSConfig will be merged with the policy selected with DNSPolicy. To have DNS options set along with hostNetwork, you have to specify DNS policy explicitly to 'ClusterFirstWithHostNet'. *)
    dns_policy: string option [@default None];
    (* EnableServiceLinks indicates whether information about services should be injected into pod's environment variables, matching the syntax of Docker links. Optional: Defaults to true. *)
    enable_service_links: bool option [@default None];
    (* List of ephemeral containers run in this pod. Ephemeral containers may be run in an existing pod to perform user-initiated actions such as debugging. This list cannot be specified when creating a pod, and it cannot be modified by updating the pod spec. In order to add an ephemeral container to an existing pod, use the pod's ephemeralcontainers subresource. *)
    ephemeral_containers: Io_k8s_api_core_v1_ephemeral_container.t list [@default []];
    (* HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts file if specified. This is only valid for non-hostNetwork pods. *)
    host_aliases: Io_k8s_api_core_v1_host_alias.t list [@default []];
    (* Use the host's ipc namespace. Optional: Default to false. *)
    host_ipc: bool option [@default None];
    (* Host networking requested for this pod. Use the host's network namespace. If this option is set, the ports that will be used must be specified. Default to false. *)
    host_network: bool option [@default None];
    (* Use the host's pid namespace. Optional: Default to false. *)
    host_pid: bool option [@default None];
    (* Use the host's user namespace. Optional: Default to true. If set to true or not present, the pod will be run in the host user namespace, useful for when the pod needs a feature only available to the host user namespace, such as loading a kernel module with CAP_SYS_MODULE. When set to false, a new userns is created for the pod. Setting false is useful for mitigating container breakout vulnerabilities even allowing users to run their containers as root without actually having root privileges on the host. This field is alpha-level and is only honored by servers that enable the UserNamespacesSupport feature. *)
    host_users: bool option [@default None];
    (* Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value. *)
    hostname: string option [@default None];
    (* ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod *)
    image_pull_secrets: Io_k8s_api_core_v1_local_object_reference.t list [@default []];
    (* List of initialization containers belonging to the pod. Init containers are executed in order prior to containers being started. If any init container fails, the pod is considered to have failed and is handled according to its restartPolicy. The name for an init container or normal container must be unique among all containers. Init containers may not have Lifecycle actions, Readiness probes, Liveness probes, or Startup probes. The resourceRequirements of an init container are taken into account during scheduling by finding the highest request/limit for each resource type, and then using the max of of that value or the sum of the normal containers. Limits are applied to init containers in a similar fashion. Init containers cannot currently be added or removed. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ *)
    init_containers: Io_k8s_api_core_v1_container.t list [@default []];
    (* NodeName is a request to schedule this pod onto a specific node. If it is non-empty, the scheduler simply schedules this pod onto that node, assuming that it fits resource requirements. *)
    node_name: string option [@default None];
    (* NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/ *)
    node_selector: (string * string) list;
    os: Io_k8s_api_core_v1_pod_os.t option [@default None];
    (* Overhead represents the resource overhead associated with running a pod for a given RuntimeClass. This field will be autopopulated at admission time by the RuntimeClass admission controller. If the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests. The RuntimeClass admission controller will reject Pod create requests which have the overhead already set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero. More info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md *)
    overhead: (string * string) list;
    (* PreemptionPolicy is the Policy for preempting pods with lower priority. One of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset. *)
    preemption_policy: string option [@default None];
    (* The priority value. Various system components use this field to find the priority of the pod. When Priority Admission Controller is enabled, it prevents users from setting this field. The admission controller populates this field from PriorityClassName. The higher the value, the higher the priority. *)
    priority: int32 option [@default None];
    (* If specified, indicates the pod's priority. \''system-node-critical\'' and \''system-cluster-critical\'' are two special keywords which indicate the highest priorities with the former being the highest priority. Any other name must be defined by creating a PriorityClass object with that name. If not specified, the pod priority will be default or zero if there is no default. *)
    priority_class_name: string option [@default None];
    (* If specified, all readiness gates will be evaluated for pod readiness. A pod is ready when all its containers are ready AND all conditions specified in the readiness gates have status equal to \''True\'' More info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates *)
    readiness_gates: Io_k8s_api_core_v1_pod_readiness_gate.t list [@default []];
    (* ResourceClaims defines which ResourceClaims must be allocated and reserved before the Pod is allowed to start. The resources will be made available to those containers which consume them by name.  This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.  This field is immutable. *)
    resource_claims: Io_k8s_api_core_v1_pod_resource_claim.t list [@default []];
    (* Restart policy for all containers within the pod. One of Always, OnFailure, Never. In some contexts, only a subset of those values may be permitted. Default to Always. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy *)
    restart_policy: string option [@default None];
    (* RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run. If unset or empty, the \''legacy\'' RuntimeClass will be used, which is an implicit class with an empty definition that uses the default runtime handler. More info: https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class *)
    runtime_class_name: string option [@default None];
    (* If specified, the pod will be dispatched by specified scheduler. If not specified, the pod will be dispatched by default scheduler. *)
    scheduler_name: string option [@default None];
    (* SchedulingGates is an opaque list of values that if specified will block scheduling the pod. If schedulingGates is not empty, the pod will stay in the SchedulingGated state and the scheduler will not attempt to schedule the pod.  SchedulingGates can only be set at pod creation time, and be removed only afterwards.  This is a beta feature enabled by the PodSchedulingReadiness feature gate. *)
    scheduling_gates: Io_k8s_api_core_v1_pod_scheduling_gate.t list [@default []];
    security_context: Io_k8s_api_core_v1_pod_security_context.t option [@default None];
    (* DeprecatedServiceAccount is a depreciated alias for ServiceAccountName. Deprecated: Use serviceAccountName instead. *)
    service_account: string option [@default None];
    (* ServiceAccountName is the name of the ServiceAccount to use to run this pod. More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/ *)
    service_account_name: string option [@default None];
    (* If true the pod's hostname will be configured as the pod's FQDN, rather than the leaf name (the default). In Linux containers, this means setting the FQDN in the hostname field of the kernel (the nodename field of struct utsname). In Windows containers, this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters to FQDN. If a pod does not have FQDN, this has no effect. Default to false. *)
    set_hostname_as_fqdn: bool option [@default None];
    (* Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false. *)
    share_process_namespace: bool option [@default None];
    (* If specified, the fully qualified Pod hostname will be \''<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>\''. If not specified, the pod will not have a domainname at all. *)
    subdomain: string option [@default None];
    (* Optional duration in seconds the pod needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds. *)
    termination_grace_period_seconds: int64 option [@default None];
    (* If specified, the pod's tolerations. *)
    tolerations: Io_k8s_api_core_v1_toleration.t list [@default []];
    (* TopologySpreadConstraints describes how a group of pods ought to spread across topology domains. Scheduler will schedule pods in a way which abides by the constraints. All topologySpreadConstraints are ANDed. *)
    topology_spread_constraints: Io_k8s_api_core_v1_topology_spread_constraint.t list [@default []];
    (* List of volumes that can be mounted by containers belonging to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes *)
    volumes: Io_k8s_api_core_v1_volume.t list [@default []];
} [@@deriving yojson { strict = false }, show ];;

(** PodSpec is a description of a pod. *)
let create (containers : Io_k8s_api_core_v1_container.t list) : t = {
    active_deadline_seconds = None;
    affinity = None;
    automount_service_account_token = None;
    containers = containers;
    dns_config = None;
    dns_policy = None;
    enable_service_links = None;
    ephemeral_containers = [];
    host_aliases = [];
    host_ipc = None;
    host_network = None;
    host_pid = None;
    host_users = None;
    hostname = None;
    image_pull_secrets = [];
    init_containers = [];
    node_name = None;
    node_selector = [];
    os = None;
    overhead = [];
    preemption_policy = None;
    priority = None;
    priority_class_name = None;
    readiness_gates = [];
    resource_claims = [];
    restart_policy = None;
    runtime_class_name = None;
    scheduler_name = None;
    scheduling_gates = [];
    security_context = None;
    service_account = None;
    service_account_name = None;
    set_hostname_as_fqdn = None;
    share_process_namespace = None;
    subdomain = None;
    termination_grace_period_seconds = None;
    tolerations = [];
    topology_spread_constraints = [];
    volumes = [];
}

