open K

let list_mahout_v1alpha1_mastodon_for_all_namespaces ~sw client
    ?(headers = Request.default_headers) ?allow_watch_bookmarks ?continue
    ?field_selector ?label_selector ?limit ?pretty ?resource_version
    ?resource_version_match ?send_initial_events ?timeout_seconds ?watch () =
  let uri = Request.build_uri "/apis/mahout.anqou.net/v1alpha1/mastodons" in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri =
    Request.maybe_add_query_param uri "allowWatchBookmarks" string_of_bool
      allow_watch_bookmarks
  in
  let uri =
    Request.maybe_add_query_param uri "continue" (fun x -> x) continue
  in
  let uri =
    Request.maybe_add_query_param uri "fieldSelector"
      (fun x -> x)
      field_selector
  in
  let uri =
    Request.maybe_add_query_param uri "labelSelector"
      (fun x -> x)
      label_selector
  in
  let uri = Request.maybe_add_query_param uri "limit" Int32.to_string limit in
  let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
  let uri =
    Request.maybe_add_query_param uri "resourceVersion"
      (fun x -> x)
      resource_version
  in
  let uri =
    Request.maybe_add_query_param uri "resourceVersionMatch"
      (fun x -> x)
      resource_version_match
  in
  let uri =
    Request.maybe_add_query_param uri "sendInitialEvents" string_of_bool
      send_initial_events
  in
  let uri =
    Request.maybe_add_query_param uri "timeoutSeconds" Int32.to_string
      timeout_seconds
  in
  let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
  let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers in
  Request.read_json_body_as
    (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.t_list_of_yojson)
    resp body

let read_mahout_v1alpha1_namespaced_mastodon ~sw client
    ?(headers = Request.default_headers) ~name ~namespace ?pretty () =
  let uri =
    Request.build_uri
      "/apis/mahout.anqou.net/v1alpha1/namespaces/{namespace}/mastodons/{name}"
  in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri = Request.replace_path_param uri "name" (fun x -> x) name in
  let uri = Request.replace_path_param uri "namespace" (fun x -> x) namespace in
  let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
  let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers in
  Request.read_json_body_as
    (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.of_yojson)
    resp body

let read_mahout_v1alpha1_namespaced_mastodon_status ~sw client
    ?(headers = Request.default_headers) ~name ~namespace ?pretty () =
  let uri =
    Request.build_uri
      "/apis/mahout.anqou.net/v1alpha1/namespaces/{namespace}/mastodons/{name}/status"
  in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri = Request.replace_path_param uri "name" (fun x -> x) name in
  let uri = Request.replace_path_param uri "namespace" (fun x -> x) namespace in
  let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
  let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers in
  Request.read_json_body_as
    (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.of_yojson)
    resp body

let watch_mahout_v1alpha1_namespaced_mastodon_list ~sw client ~namespace ?watch
    () =
  let uri =
    Request.build_uri
      "/apis/mahout.anqou.net/v1alpha1/watch/namespaces/{namespace}/mastodons"
  in
  let headers = Request.default_headers in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri = Request.replace_path_param uri "namespace" (fun x -> x) namespace in
  let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
  let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers in
  Request.read_json_body_as
    (JsonSupport.unwrap
       Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson)
    resp body

let watch_mahout_v1alpha1_mastodon_list_for_all_namespaces ~sw client ?watch ()
    =
  let uri =
    Request.build_uri "/apis/mahout.anqou.net/v1alpha1/watch/mastodons"
  in
  let headers = Request.default_headers in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
  let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers in
  Request.read_json_body_as
    (JsonSupport.unwrap
       Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson)
    resp body

let patch_mahout_v1alpha1_namespaced_mastodon_status ~sw client ~name ~namespace
    ~body () =
  let uri =
    Request.build_uri
      "/apis/mahout.anqou.net/v1alpha1/namespaces/{namespace}/mastodons/{name}/status"
  in
  let headers =
    Cohttp.Header.init_with "Content-Type" "application/merge-patch+json"
  in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri = Request.replace_path_param uri "name" (fun x -> x) name in
  let uri = Request.replace_path_param uri "namespace" (fun x -> x) namespace in
  let body = Request.write_json_body body in
  let resp, body =
    Cohttp_eio.Client.call ~sw client `PATCH uri ~headers ~body
  in
  Request.read_json_body_as
    (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.of_yojson)
    resp body

let replace_mahout_v1alpha1_namespaced_mastodon ~sw client
    ?(headers = Request.default_headers) ~name ~namespace ~body ?pretty ?dry_run
    ?field_manager ?field_validation () =
  let uri =
    Request.build_uri
      "/apis/mahout.anqou.net/v1alpha1/namespaces/{namespace}/mastodons/{name}"
  in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri = Request.replace_path_param uri "name" (fun x -> x) name in
  let uri = Request.replace_path_param uri "namespace" (fun x -> x) namespace in
  let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
  let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
  let uri =
    Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager
  in
  let uri =
    Request.maybe_add_query_param uri "fieldValidation"
      (fun x -> x)
      field_validation
  in
  let body =
    Request.write_as_json_body Net_anqou_mahout.V1alpha1.Mastodon.to_yojson body
  in
  let resp, body = Cohttp_eio.Client.call ~sw client `PUT uri ~headers ~body in
  Request.read_json_body_as
    (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.of_yojson)
    resp body

let replace_mahout_v1alpha1_namespaced_mastodon_status ~sw client
    ?(headers = Request.default_headers) ~name ~namespace ~body ?pretty ?dry_run
    ?field_manager ?field_validation () =
  let uri =
    Request.build_uri
      "/apis/mahout.anqou.net/v1alpha1/namespaces/{namespace}/mastodons/{name}/status"
  in
  let headers = Cohttp.Header.add headers "authorization" Request.api_key in
  let uri = Request.replace_path_param uri "name" (fun x -> x) name in
  let uri = Request.replace_path_param uri "namespace" (fun x -> x) namespace in
  let uri = Request.maybe_add_query_param uri "pretty" (fun x -> x) pretty in
  let uri = Request.maybe_add_query_param uri "dryRun" (fun x -> x) dry_run in
  let uri =
    Request.maybe_add_query_param uri "fieldManager" (fun x -> x) field_manager
  in
  let uri =
    Request.maybe_add_query_param uri "fieldValidation"
      (fun x -> x)
      field_validation
  in
  let body =
    Request.write_as_json_body Net_anqou_mahout.V1alpha1.Mastodon.to_yojson body
  in
  let resp, body = Cohttp_eio.Client.call ~sw client `PUT uri ~headers ~body in
  Request.read_json_body_as
    (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.of_yojson)
    resp body
