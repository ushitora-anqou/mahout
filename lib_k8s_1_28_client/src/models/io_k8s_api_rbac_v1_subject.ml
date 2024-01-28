(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_rbac_v1_subject.t : Subject contains a reference to the object or user identities a role binding applies to.  This can either hold a direct API object reference, or a value for non-objects such as user and group names.
 *)

type t = {
    (* APIGroup holds the API group of the referenced subject. Defaults to \''\'' for ServiceAccount subjects. Defaults to \''rbac.authorization.k8s.io\'' for User and Group subjects. *)
    api_group: string option [@yojson.default None] [@yojson.key "apiGroup"];
    (* Kind of object being referenced. Values defined by this API group are \''User\'', \''Group\'', and \''ServiceAccount\''. If the Authorizer does not recognized the kind value, the Authorizer should report an error. *)
    kind: string [@yojson.key "kind"];
    (* Name of the object being referenced. *)
    name: string [@yojson.key "name"];
    (* Namespace of the referenced object.  If the object kind is non-namespace, such as \''User\'' or \''Group\'', and this value is not empty the Authorizer should report an error. *)
    namespace: string option [@yojson.default None] [@yojson.key "namespace"];
} [@@deriving yojson { strict = false }, show, make];;


