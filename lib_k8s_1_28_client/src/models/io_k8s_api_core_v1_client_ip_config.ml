(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_client_ip_config.t : ClientIPConfig represents the configurations of Client IP based session affinity.
 *)

type t = {
    (* timeoutSeconds specifies the seconds of ClientIP type session sticky time. The value must be >0 && <=86400(for 1 day) if ServiceAffinity == \''ClientIP\''. Default value is 10800(for 3 hours). *)
    timeout_seconds: int32 option [@default None];
} [@@deriving yojson { strict = false }, show ];;

(** ClientIPConfig represents the configurations of Client IP based session affinity. *)
let create () : t = {
    timeout_seconds = None;
}

