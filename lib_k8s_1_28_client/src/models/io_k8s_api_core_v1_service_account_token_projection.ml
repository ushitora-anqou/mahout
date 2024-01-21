(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_service_account_token_projection.t : ServiceAccountTokenProjection represents a projected service account token volume. This projection can be used to insert a service account token into the pods runtime filesystem for use against APIs (Kubernetes API Server or otherwise).
 *)

type t = {
    (* audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver. *)
    audience: string option [@default None] [@key "audience"];
    (* expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes. *)
    expiration_seconds: int64 option [@default None] [@key "expirationSeconds"];
    (* path is the path relative to the mount point of the file to project the token into. *)
    path: string [@key "path"];
} [@@deriving yojson { strict = false }, show ];;

(** ServiceAccountTokenProjection represents a projected service account token volume. This projection can be used to insert a service account token into the pods runtime filesystem for use against APIs (Kubernetes API Server or otherwise). *)
let create (path : string) : t = {
    audience = None;
    expiration_seconds = None;
    path = path;
}

