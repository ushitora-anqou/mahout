(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1beta1_param_ref.t : ParamRef describes how to locate the params to be used as input to expressions of rules applied by a policy binding.
 *)

type t = {
    (* name is the name of the resource being referenced.  One of `name` or `selector` must be set, but `name` and `selector` are mutually exclusive properties. If one is set, the other must be unset.  A single parameter used for all admission requests can be configured by setting the `name` field, leaving `selector` blank, and setting namespace if `paramKind` is namespace-scoped. *)
    name: string option [@default None] [@key "name"];
    (* namespace is the namespace of the referenced resource. Allows limiting the search for params to a specific namespace. Applies to both `name` and `selector` fields.  A per-namespace parameter may be used by specifying a namespace-scoped `paramKind` in the policy and leaving this field empty.  - If `paramKind` is cluster-scoped, this field MUST be unset. Setting this field results in a configuration error.  - If `paramKind` is namespace-scoped, the namespace of the object being evaluated for admission will be used when this field is left unset. Take care that if this is left empty the binding must not match any cluster-scoped resources, which will result in an error. *)
    namespace: string option [@default None] [@key "namespace"];
    (* `parameterNotFoundAction` controls the behavior of the binding when the resource exists, and name or selector is valid, but there are no parameters matched by the binding. If the value is set to `Allow`, then no matched parameters will be treated as successful validation by the binding. If set to `Deny`, then no matched parameters will be subject to the `failurePolicy` of the policy.  Allowed values are `Allow` or `Deny`  Required *)
    parameter_not_found_action: string option [@default None] [@key "parameterNotFoundAction"];
    selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None] [@key "selector"];
} [@@deriving yojson { strict = false }, show ];;

(** ParamRef describes how to locate the params to be used as input to expressions of rules applied by a policy binding. *)
let create () : t = {
    name = None;
    namespace = None;
    parameter_not_found_action = None;
    selector = None;
}

