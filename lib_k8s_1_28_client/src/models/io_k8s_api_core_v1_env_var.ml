(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_core_v1_env_var.t : EnvVar represents an environment variable present in a Container.
 *)

type t = {
    (* Name of the environment variable. Must be a C_IDENTIFIER. *)
    name: string [@key "name"];
    (* Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \''$$(VAR_NAME)\'' will produce the string literal \''$(VAR_NAME)\''. Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \''\''. *)
    value: string option [@default None] [@key "value"];
    value_from: Io_k8s_api_core_v1_env_var_source.t option [@default None] [@key "valueFrom"];
} [@@deriving yojson { strict = false }, show ];;

(** EnvVar represents an environment variable present in a Container. *)
let create (name : string) : t = {
    name = name;
    value = None;
    value_from = None;
}

