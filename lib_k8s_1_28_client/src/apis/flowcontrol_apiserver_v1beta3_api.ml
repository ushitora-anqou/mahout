(*
 * This file has been generated by the OCamlClientCodegen generator for openapi-generator.
 *
 * Generated by: https://openapi-generator.tech
 *
 *)

type any = Yojson.Safe.t

let create_flowcontrol_apiserver_v1beta3_flow_schema ~sw client ?(headers = Request.default_headers) ~body ?pretty ?dry_run ?field_manager ?field_validation () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let body = Request.write_as_json_body Io_k8s_api_flowcontrol_v1beta3_flow_schema.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `POST uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema.of_yojson) resp body

let create_flowcontrol_apiserver_v1beta3_priority_level_configuration ~sw client ?(headers = Request.default_headers) ~body ?pretty ?dry_run ?field_manager ?field_validation () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let body = Request.write_as_json_body Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `POST uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.of_yojson) resp body

let delete_flowcontrol_apiserver_v1beta3_collection_flow_schema ~sw client ?(headers = Request.default_headers) ?pretty ?continue ?dry_run ?field_selector ?grace_period_seconds ?label_selector ?limit ?orphan_dependents ?propagation_policy ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ~body () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "gracePeriodSeconds" Int32.to_string grace_period_seconds in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "orphanDependents" string_of_bool orphan_dependents in
    let uri = Request.maybe_add_query_param uri "propagationPolicy" (fun x -> x) propagation_policy in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let body = Request.write_as_json_body Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `DELETE uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_status.of_yojson) resp body

let delete_flowcontrol_apiserver_v1beta3_collection_priority_level_configuration ~sw client ?(headers = Request.default_headers) ?pretty ?continue ?dry_run ?field_selector ?grace_period_seconds ?label_selector ?limit ?orphan_dependents ?propagation_policy ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ~body () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "gracePeriodSeconds" Int32.to_string grace_period_seconds in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "orphanDependents" string_of_bool orphan_dependents in
    let uri = Request.maybe_add_query_param uri "propagationPolicy" (fun x -> x) propagation_policy in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let body = Request.write_as_json_body Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `DELETE uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_status.of_yojson) resp body

let delete_flowcontrol_apiserver_v1beta3_flow_schema ~sw client ?(headers = Request.default_headers) ~name ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "gracePeriodSeconds" Int32.to_string grace_period_seconds in
    let uri = Request.maybe_add_query_param uri "orphanDependents" string_of_bool orphan_dependents in
    let uri = Request.maybe_add_query_param uri "propagationPolicy" (fun x -> x) propagation_policy in
    let body = Request.write_as_json_body Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `DELETE uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_status.of_yojson) resp body

let delete_flowcontrol_apiserver_v1beta3_priority_level_configuration ~sw client ?(headers = Request.default_headers) ~name ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "gracePeriodSeconds" Int32.to_string grace_period_seconds in
    let uri = Request.maybe_add_query_param uri "orphanDependents" string_of_bool orphan_dependents in
    let uri = Request.maybe_add_query_param uri "propagationPolicy" (fun x -> x) propagation_policy in
    let body = Request.write_as_json_body Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `DELETE uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_status.of_yojson) resp body

let get_flowcontrol_apiserver_v1beta3_api_resources ~sw client ?(headers = Request.default_headers) () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_api_resource_list.of_yojson) resp body

let list_flowcontrol_apiserver_v1beta3_flow_schema ~sw client ?(headers = Request.default_headers) ?pretty ?allow_watch_bookmarks ?continue ?field_selector ?label_selector ?limit ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ?watch () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "allowWatchBookmarks" string_of_bool allow_watch_bookmarks in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema_list.of_yojson) resp body

let list_flowcontrol_apiserver_v1beta3_priority_level_configuration ~sw client ?(headers = Request.default_headers) ?pretty ?allow_watch_bookmarks ?continue ?field_selector ?label_selector ?limit ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ?watch () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "allowWatchBookmarks" string_of_bool allow_watch_bookmarks in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration_list.of_yojson) resp body

let patch_flowcontrol_apiserver_v1beta3_flow_schema ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation ?force () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let uri = Request.maybe_add_query_param uri "force" string_of_bool force in
    let body = Request.write_json_body  body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PATCH uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema.of_yojson) resp body

let patch_flowcontrol_apiserver_v1beta3_flow_schema_status ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation ?force () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas/{name}/status" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let uri = Request.maybe_add_query_param uri "force" string_of_bool force in
    let body = Request.write_json_body  body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PATCH uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema.of_yojson) resp body

let patch_flowcontrol_apiserver_v1beta3_priority_level_configuration ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation ?force () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let uri = Request.maybe_add_query_param uri "force" string_of_bool force in
    let body = Request.write_json_body  body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PATCH uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.of_yojson) resp body

let patch_flowcontrol_apiserver_v1beta3_priority_level_configuration_status ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation ?force () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations/{name}/status" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let uri = Request.maybe_add_query_param uri "force" string_of_bool force in
    let body = Request.write_json_body  body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PATCH uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.of_yojson) resp body

let read_flowcontrol_apiserver_v1beta3_flow_schema ~sw client ?(headers = Request.default_headers) ~name ?pretty () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema.of_yojson) resp body

let read_flowcontrol_apiserver_v1beta3_flow_schema_status ~sw client ?(headers = Request.default_headers) ~name ?pretty () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas/{name}/status" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema.of_yojson) resp body

let read_flowcontrol_apiserver_v1beta3_priority_level_configuration ~sw client ?(headers = Request.default_headers) ~name ?pretty () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.of_yojson) resp body

let read_flowcontrol_apiserver_v1beta3_priority_level_configuration_status ~sw client ?(headers = Request.default_headers) ~name ?pretty () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations/{name}/status" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.of_yojson) resp body

let replace_flowcontrol_apiserver_v1beta3_flow_schema ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let body = Request.write_as_json_body Io_k8s_api_flowcontrol_v1beta3_flow_schema.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PUT uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema.of_yojson) resp body

let replace_flowcontrol_apiserver_v1beta3_flow_schema_status ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/flowschemas/{name}/status" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let body = Request.write_as_json_body Io_k8s_api_flowcontrol_v1beta3_flow_schema.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PUT uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_flow_schema.of_yojson) resp body

let replace_flowcontrol_apiserver_v1beta3_priority_level_configuration ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let body = Request.write_as_json_body Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PUT uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.of_yojson) resp body

let replace_flowcontrol_apiserver_v1beta3_priority_level_configuration_status ~sw client ?(headers = Request.default_headers) ~name ~body ?pretty ?dry_run ?field_manager ?field_validation () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/prioritylevelconfigurations/{name}/status" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
    let uri = Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager in
    let uri = Request.maybe_add_query_param uri "fieldValidation" (fun x -> x) field_validation in
    let body = Request.write_as_json_body Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.to_yojson body in
    let resp, body = Cohttp_eio.Client.call ~sw client `PUT uri ~headers ~body  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_api_flowcontrol_v1beta3_priority_level_configuration.of_yojson) resp body

let watch_flowcontrol_apiserver_v1beta3_flow_schema ~sw client ?(headers = Request.default_headers) ~name ?allow_watch_bookmarks ?continue ?field_selector ?label_selector ?limit ?pretty ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ?watch () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/watch/flowschemas/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "allowWatchBookmarks" string_of_bool allow_watch_bookmarks in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson) resp body

let watch_flowcontrol_apiserver_v1beta3_flow_schema_list ~sw client ?(headers = Request.default_headers) ?allow_watch_bookmarks ?continue ?field_selector ?label_selector ?limit ?pretty ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ?watch () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/watch/flowschemas" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "allowWatchBookmarks" string_of_bool allow_watch_bookmarks in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson) resp body

let watch_flowcontrol_apiserver_v1beta3_priority_level_configuration ~sw client ?(headers = Request.default_headers) ~name ?allow_watch_bookmarks ?continue ?field_selector ?label_selector ?limit ?pretty ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ?watch () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/watch/prioritylevelconfigurations/{name}" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.replace_path_param uri "name" (fun x -> x) name in
    let uri = Request.maybe_add_query_param uri "allowWatchBookmarks" string_of_bool allow_watch_bookmarks in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson) resp body

let watch_flowcontrol_apiserver_v1beta3_priority_level_configuration_list ~sw client ?(headers = Request.default_headers) ?allow_watch_bookmarks ?continue ?field_selector ?label_selector ?limit ?pretty ?resource_version ?resource_version_match ?send_initial_events ?timeout_seconds ?watch () =
    let uri = Request.build_uri "/apis/flowcontrol.apiserver.k8s.io/v1beta3/watch/prioritylevelconfigurations" in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri = Request.maybe_add_query_param uri "allowWatchBookmarks" string_of_bool allow_watch_bookmarks in
    let uri = Request.maybe_add_query_param uri "continue" (fun x -> x) continue in
    let uri = Request.maybe_add_query_param uri "fieldSelector" (fun x -> x) field_selector in
    let uri = Request.maybe_add_query_param uri "labelSelector" (fun x -> x) label_selector in
    let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
    let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
    let uri = Request.maybe_add_query_param uri "resourceVersion" (fun x -> x) resource_version in
    let uri = Request.maybe_add_query_param uri "resourceVersionMatch" (fun x -> x) resource_version_match in
    let uri = Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool send_initial_events in
    let uri = Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string timeout_seconds in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers  in
    Request.read_json_body_as (JsonSupport.unwrap Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson) resp body

