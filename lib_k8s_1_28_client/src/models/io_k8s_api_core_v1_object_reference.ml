(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_object_reference.t : ObjectReference contains enough information to let you inspect or modify the referred object.
 *)

type t = {
    (* API version of the referent. *)
    api_version: string option [@default None] [@key "apiVersion"];
    (* If referring to a piece of an object instead of an entire object, this string should contain a valid JSON/Go field access statement, such as desiredState.manifest.containers[2]. For example, if the object reference is to a container within a pod, this would take on a value like: \''spec.containers{name}\'' (where \''name\'' refers to the name of the container that triggered the event) or if no container name is specified \''spec.containers[2]\'' (container with index 2 in this pod). This syntax is chosen only to have some well-defined way of referencing a part of an object. *)
    field_path: string option [@default None] [@key "fieldPath"];
    (* Kind of the referent. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds *)
    kind: string option [@default None] [@key "kind"];
    (* Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names *)
    name: string option [@default None] [@key "name"];
    (* Namespace of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/ *)
    namespace: string option [@default None] [@key "namespace"];
    (* Specific resourceVersion to which this reference is made, if any. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency *)
    resource_version: string option [@default None] [@key "resourceVersion"];
    (* UID of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids *)
    uid: string option [@default None] [@key "uid"];
} [@@deriving yojson { strict = false }, show ];;

(** ObjectReference contains enough information to let you inspect or modify the referred object. *)
let create () : t = {
    api_version = None;
    field_path = None;
    kind = None;
    name = None;
    namespace = None;
    resource_version = None;
    uid = None;
}

