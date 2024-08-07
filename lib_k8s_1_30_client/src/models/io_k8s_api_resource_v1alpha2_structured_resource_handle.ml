(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 * Schema Io_k8s_api_resource_v1alpha2_structured_resource_handle.t : StructuredResourceHandle is the in-tree representation of the allocation result.
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
    (* NodeName is the name of the node providing the necessary resources if the resources are local to a node. *)
    node_name: string option [@yojson.default None] [@yojson.key "nodeName"];
    (* Results lists all allocated driver resources. *)
    results: Io_k8s_api_resource_v1alpha2_driver_allocation_result.t list [@default []] [@yojson.key "results"];
    (* RawExtension is used to hold extensions in external versions.  To use this, make a field which has RawExtension as its type in your external, versioned struct, and Object in your internal struct. You also need to register your various plugin types.  // Internal package:   type MyAPIObject struct {   runtime.TypeMeta `json:\'',inline\''`   MyPlugin runtime.Object `json:\''myPlugin\''`  }   type PluginA struct {   AOption string `json:\''aOption\''`  }  // External package:   type MyAPIObject struct {   runtime.TypeMeta `json:\'',inline\''`   MyPlugin runtime.RawExtension `json:\''myPlugin\''`  }   type PluginA struct {   AOption string `json:\''aOption\''`  }  // On the wire, the JSON will look something like this:   {   \''kind\'':\''MyAPIObject\'',   \''apiVersion\'':\''v1\'',   \''myPlugin\'': {    \''kind\'':\''PluginA\'',    \''aOption\'':\''foo\'',   },  }  So what happens? Decode first uses json or yaml to unmarshal the serialized data into your external MyAPIObject. That causes the raw JSON to be stored, but not unpacked. The next step is to copy (using pkg/conversion) into the internal struct. The runtime package's DefaultScheme has conversion functions installed which will unpack the JSON stored in RawExtension, turning it into the correct object type, and storing it in the Object. (TODO: In the case where the object is of an unknown type, a runtime.Unknown object will be created and stored.) *)
    vendor_claim_parameters: any option [@yojson.default None] [@yojson.key "vendorClaimParameters"];
    (* RawExtension is used to hold extensions in external versions.  To use this, make a field which has RawExtension as its type in your external, versioned struct, and Object in your internal struct. You also need to register your various plugin types.  // Internal package:   type MyAPIObject struct {   runtime.TypeMeta `json:\'',inline\''`   MyPlugin runtime.Object `json:\''myPlugin\''`  }   type PluginA struct {   AOption string `json:\''aOption\''`  }  // External package:   type MyAPIObject struct {   runtime.TypeMeta `json:\'',inline\''`   MyPlugin runtime.RawExtension `json:\''myPlugin\''`  }   type PluginA struct {   AOption string `json:\''aOption\''`  }  // On the wire, the JSON will look something like this:   {   \''kind\'':\''MyAPIObject\'',   \''apiVersion\'':\''v1\'',   \''myPlugin\'': {    \''kind\'':\''PluginA\'',    \''aOption\'':\''foo\'',   },  }  So what happens? Decode first uses json or yaml to unmarshal the serialized data into your external MyAPIObject. That causes the raw JSON to be stored, but not unpacked. The next step is to copy (using pkg/conversion) into the internal struct. The runtime package's DefaultScheme has conversion functions installed which will unpack the JSON stored in RawExtension, turning it into the correct object type, and storing it in the Object. (TODO: In the case where the object is of an unknown type, a runtime.Unknown object will be created and stored.) *)
    vendor_class_parameters: any option [@yojson.default None] [@yojson.key "vendorClassParameters"];
} [@@deriving yojson, show, make] [@@yojson.allow_extra_fields];;
let to_yojson = yojson_of_t
let of_yojson x =
  try
    Ok (t_of_yojson x)
  with
  | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (e, j) ->
      Error (Printf.sprintf "%s: %s" (Printexc.to_string e) (Yojson.Safe.to_string j))


