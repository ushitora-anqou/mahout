(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_admissionregistration_v1_match_resources.t : MatchResources decides whether to run the admission control policy on an object based on whether it meets the match criteria. The exclude rules take precedence over include rules (if a resource matches both, it is excluded)
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
    (* ExcludeResourceRules describes what operations on what resources/subresources the ValidatingAdmissionPolicy should not care about. The exclude rules take precedence over include rules (if a resource matches both, it is excluded) *)
    exclude_resource_rules: Io_k8s_api_admissionregistration_v1_named_rule_with_operations.t list [@default []] [@yojson.key "excludeResourceRules"];
    (* matchPolicy defines how the \''MatchResources\'' list is used to match incoming requests. Allowed values are \''Exact\'' or \''Equivalent\''.  - Exact: match a request only if it exactly matches a specified rule. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, but \''rules\'' only included `apiGroups:[\''apps\''], apiVersions:[\''v1\''], resources: [\''deployments\'']`, a request to apps/v1beta1 or extensions/v1beta1 would not be sent to the ValidatingAdmissionPolicy.  - Equivalent: match a request if modifies a resource listed in rules, even via another API group or version. For example, if deployments can be modified via apps/v1, apps/v1beta1, and extensions/v1beta1, and \''rules\'' only included `apiGroups:[\''apps\''], apiVersions:[\''v1\''], resources: [\''deployments\'']`, a request to apps/v1beta1 or extensions/v1beta1 would be converted to apps/v1 and sent to the ValidatingAdmissionPolicy.  Defaults to \''Equivalent\'' *)
    match_policy: string option [@yojson.default None] [@yojson.key "matchPolicy"];
    namespace_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@yojson.default None] [@yojson.key "namespaceSelector"];
    object_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@yojson.default None] [@yojson.key "objectSelector"];
    (* ResourceRules describes what operations on what resources/subresources the ValidatingAdmissionPolicy matches. The policy cares about an operation if it matches _any_ Rule. *)
    resource_rules: Io_k8s_api_admissionregistration_v1_named_rule_with_operations.t list [@default []] [@yojson.key "resourceRules"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


