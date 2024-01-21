(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_pod_affinity_term.t : Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running
 *)

type t = {
    label_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None] [@key labelSelector];
    namespace_selector: Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector.t option [@default None] [@key namespaceSelector];
    (* namespaces specifies a static list of namespace names that the term applies to. The term is applied to the union of the namespaces listed in this field and the ones selected by namespaceSelector. null or empty namespaces list and null namespaceSelector means \''this pod's namespace\''. *)
    namespaces: string list [@default []] [@key namespaces];
    (* This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed. *)
    topology_key: string [@key topologyKey];
} [@@deriving yojson { strict = false }, show ];;

(** Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running *)
let create (topology_key : string) : t = {
    label_selector = None;
    namespace_selector = None;
    namespaces = [];
    topology_key = topology_key;
}

