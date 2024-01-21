(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_apiextensions_apiserver_pkg_apis_apiextensions_v1_custom_resource_column_definition.t : CustomResourceColumnDefinition specifies a column for server side printing.
 *)

type t = {
    (* description is a human readable description of this column. *)
    description: string option [@default None] [@key description];
    (* format is an optional OpenAPI type definition for this column. The 'name' format is applied to the primary identifier column to assist in clients identifying column is the resource name. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details. *)
    format: string option [@default None] [@key format];
    (* jsonPath is a simple JSON path (i.e. with array notation) which is evaluated against each custom resource to produce the value for this column. *)
    json_path: string [@key jsonPath];
    (* name is a human readable name for the column. *)
    name: string [@key name];
    (* priority is an integer defining the relative importance of this column compared to others. Lower numbers are considered higher priority. Columns that may be omitted in limited space scenarios should be given a priority greater than 0. *)
    priority: int32 option [@default None] [@key priority];
    (* type is an OpenAPI type definition for this column. See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details. *)
    _type: string [@key type];
} [@@deriving yojson { strict = false }, show ];;

(** CustomResourceColumnDefinition specifies a column for server side printing. *)
let create (json_path : string) (name : string) (_type : string) : t = {
    description = None;
    format = None;
    json_path = json_path;
    name = name;
    priority = None;
    _type = _type;
}

