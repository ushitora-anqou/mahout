(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_authorization_v1_subject_access_review_status.t : SubjectAccessReviewStatus
 *)

type t = {
    (* Allowed is required. True if the action would be allowed, false otherwise. *)
    allowed: bool [@key "allowed"];
    (* Denied is optional. True if the action would be denied, otherwise false. If both allowed is false and denied is false, then the authorizer has no opinion on whether to authorize the action. Denied may not be true if Allowed is true. *)
    denied: bool option [@default None] [@key "denied"];
    (* EvaluationError is an indication that some error occurred during the authorization check. It is entirely possible to get an error and be able to continue determine authorization status in spite of it. For instance, RBAC can be missing a role, but enough roles are still present and bound to reason about the request. *)
    evaluation_error: string option [@default None] [@key "evaluationError"];
    (* Reason is optional.  It indicates why a request was allowed or denied. *)
    reason: string option [@default None] [@key "reason"];
} [@@deriving yojson { strict = false }, show ];;

(** SubjectAccessReviewStatus *)
let create (allowed : bool) : t = {
    allowed = allowed;
    denied = None;
    evaluation_error = None;
    reason = None;
}

