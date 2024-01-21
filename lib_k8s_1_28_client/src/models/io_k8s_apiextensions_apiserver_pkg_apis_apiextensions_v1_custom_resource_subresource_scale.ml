(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_custom_resource_subresource_scale.t : CustomResourceSubresourceScale defines how to serve the scale subresource for CustomResources.
 *)

type t = {
    (* labelSelectorPath defines the JSON path inside of a custom resource that corresponds to Scale `status.selector`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.status` or `.spec`. Must be set to work with HorizontalPodAutoscaler. The field pointed by this JSON path must be a string field (not a complex selector struct) which contains a serialized label selector in string form. More info: https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions#scale-subresource If there is no value under the given path in the custom resource, the `status.selector` value in the `/scale` subresource will default to the empty string. *)
    label_selector_path: string option [@default None];
    (* specReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `spec.replicas`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.spec`. If there is no value under the given path in the custom resource, the `/scale` subresource will return an error on GET. *)
    spec_replicas_path: string;
    (* statusReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `status.replicas`. Only JSON paths without the array notation are allowed. Must be a JSON Path under `.status`. If there is no value under the given path in the custom resource, the `status.replicas` value in the `/scale` subresource will default to 0. *)
    status_replicas_path: string;
} [@@deriving yojson { strict = false }, show ];;

(** CustomResourceSubresourceScale defines how to serve the scale subresource for CustomResources. *)
let create (spec_replicas_path : string) (status_replicas_path : string) : t = {
    label_selector_path = None;
    spec_replicas_path = spec_replicas_path;
    status_replicas_path = status_replicas_path;
}

