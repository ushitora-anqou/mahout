(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_batch_v1_job_spec.t : JobSpec describes how the job execution will look like.
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
    (* Specifies the duration in seconds relative to the startTime that the job may be continuously active before the system tries to terminate it; value must be positive integer. If a Job is suspended (at creation or through an update), this timer will effectively be stopped and reset when the Job is resumed again. *)
    active_deadline_seconds: int64 option [@yojson.default None] [@yojson.key "activeDeadlineSeconds"];
    (* Specifies the number of retries before marking this job failed. Defaults to 6 *)
    backoff_limit: int32 option [@yojson.default None] [@yojson.key "backoffLimit"];
    (* Specifies the limit for the number of retries within an index before marking this index as failed. When enabled the number of failures per index is kept in the pod's batch.kubernetes.io/job-index-failure-count annotation. It can only be set when Job's completionMode=Indexed, and the Pod's restart policy is Never. The field is immutable. This field is alpha-level. It can be used when the `JobBackoffLimitPerIndex` feature gate is enabled (disabled by default). *)
    backoff_limit_per_index: int32 option [@yojson.default None] [@yojson.key "backoffLimitPerIndex"];
    (* completionMode specifies how Pod completions are tracked. It can be `NonIndexed` (default) or `Indexed`.  `NonIndexed` means that the Job is considered complete when there have been .spec.completions successfully completed Pods. Each Pod completion is homologous to each other.  `Indexed` means that the Pods of a Job get an associated completion index from 0 to (.spec.completions - 1), available in the annotation batch.kubernetes.io/job-completion-index. The Job is considered complete when there is one successfully completed Pod for each index. When value is `Indexed`, .spec.completions must be specified and `.spec.parallelism` must be less than or equal to 10^5. In addition, The Pod name takes the form `$(job-name)-$(index)-$(random-string)`, the Pod hostname takes the form `$(job-name)-$(index)`.  More completion modes can be added in the future. If the Job controller observes a mode that it doesn't recognize, which is possible during upgrades due to version skew, the controller skips updates for the Job. *)
    completion_mode: string option [@yojson.default None] [@yojson.key "completionMode"];
    (* Specifies the desired number of successfully finished pods the job should be run with.  Setting to null means that the success of any pod signals the success of all pods, and allows parallelism to have any positive value.  Setting to 1 means that parallelism is limited to 1 and the success of that pod signals the success of the job. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/ *)
    completions: int32 option [@yojson.default None] [@yojson.key "completions"];
    (* manualSelector controls generation of pod labels and pod selectors. Leave `manualSelector` unset unless you are certain what you are doing. When false or unset, the system pick labels unique to this job and appends those labels to the pod template.  When true, the user is responsible for picking unique labels and specifying the selector.  Failure to pick a unique label may cause this and other jobs to not function correctly.  However, You may see `manualSelector=true` in jobs that were created with the old `extensions/v1beta1` API. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#specifying-your-own-pod-selector *)
    manual_selector: bool option [@yojson.default None] [@yojson.key "manualSelector"];
    (* Specifies the maximal number of failed indexes before marking the Job as failed, when backoffLimitPerIndex is set. Once the number of failed indexes exceeds this number the entire Job is marked as Failed and its execution is terminated. When left as null the job continues execution of all of its indexes and is marked with the `Complete` Job condition. It can only be specified when backoffLimitPerIndex is set. It can be null or up to completions. It is required and must be less than or equal to 10^4 when is completions greater than 10^5. This field is alpha-level. It can be used when the `JobBackoffLimitPerIndex` feature gate is enabled (disabled by default). *)
    max_failed_indexes: int32 option [@yojson.default None] [@yojson.key "maxFailedIndexes"];
    (* Specifies the maximum desired number of pods the job should run at any given time. The actual number of pods running in steady state will be less than this number when ((.spec.completions - .status.successful) < .spec.parallelism), i.e. when the work left to do is less than max parallelism. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/ *)
    parallelism: int32 option [@yojson.default None] [@yojson.key "parallelism"];
    pod_failure_policy: Io_k8s_api_batch_v1_pod_failure_policy.t option [@yojson.default None] [@yojson.key "podFailurePolicy"];
    (* podReplacementPolicy specifies when to create replacement Pods. Possible values are: - TerminatingOrFailed means that we recreate pods   when they are terminating (has a metadata.deletionTimestamp) or failed. - Failed means to wait until a previously created Pod is fully terminated (has phase   Failed or Succeeded) before creating a replacement Pod.  When using podFailurePolicy, Failed is the the only allowed value. TerminatingOrFailed and Failed are allowed values when podFailurePolicy is not in use. This is an alpha field. Enable JobPodReplacementPolicy to be able to use this field. *)
    pod_replacement_policy: string option [@yojson.default None] [@yojson.key "podReplacementPolicy"];
    selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@yojson.default None] [@yojson.key "selector"];
    (* suspend specifies whether the Job controller should create Pods or not. If a Job is created with suspend set to true, no Pods are created by the Job controller. If a Job is suspended after creation (i.e. the flag goes from false to true), the Job controller will delete all active Pods associated with this Job. Users must design their workload to gracefully handle this. Suspending a Job will reset the StartTime field of the Job, effectively resetting the ActiveDeadlineSeconds timer too. Defaults to false. *)
    suspend: bool option [@yojson.default None] [@yojson.key "suspend"];
    template: Io_k8s_api_core_v1_pod_template_spec.t [@yojson.key "template"];
    (* ttlSecondsAfterFinished limits the lifetime of a Job that has finished execution (either Complete or Failed). If this field is set, ttlSecondsAfterFinished after the Job finishes, it is eligible to be automatically deleted. When the Job is being deleted, its lifecycle guarantees (e.g. finalizers) will be honored. If this field is unset, the Job won't be automatically deleted. If this field is set to zero, the Job becomes eligible to be deleted immediately after it finishes. *)
    ttl_seconds_after_finished: int32 option [@yojson.default None] [@yojson.key "ttlSecondsAfterFinished"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


