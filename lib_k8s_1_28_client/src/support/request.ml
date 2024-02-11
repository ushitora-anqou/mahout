let bearer_token =
  let token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token" in
  try
    let ic = open_in_bin token_file in
    Fun.protect
      ~finally:(fun () -> close_in ic)
      (fun () -> In_channel.input_all ic)
  with _ -> ""

let api_key = "Bearer " ^ bearer_token

let base_url =
  try
    let host = Sys.getenv "KUBERNETES_SERVICE_HOST" in
    let port = Sys.getenv "KUBERNETES_SERVICE_PORT" in
    "https://" ^ host ^ ":" ^ port
  with _ -> ""

let default_headers = Cohttp.Header.init_with "Content-Type" "application/json"
let option_fold f default o = match o with Some v -> f v | None -> default
let build_uri operation_path = Uri.of_string (base_url ^ operation_path)
let add_string_header headers key value = Cohttp.Header.add headers key value

let add_string_header_multi headers key values =
  Cohttp.Header.add_multi headers key values

let add_header headers key to_string value =
  Cohttp.Header.add headers key (to_string value)

let add_header_multi headers key to_string value =
  Cohttp.Header.add_multi headers key (to_string value)

let maybe_add_header headers key to_string value =
  option_fold (add_header headers key to_string) headers value

let maybe_add_header_multi headers key to_string value =
  option_fold (add_header_multi headers key to_string) headers value

let write_string_body s = Cohttp_eio.Body.of_string s

let write_json_body payload =
  Cohttp_eio.Body.of_string (Yojson.Safe.to_string payload ~std:true)

let write_as_json_body to_json payload = write_json_body (to_json payload)

let handle_response resp on_success_handler =
  match resp.Http.Response.status with
  | #Cohttp.Code.success_status -> Ok (on_success_handler ())
  | _ -> Error resp

let handle_unit_response resp = handle_response resp (fun () -> ())

let read_json_body resp body =
  handle_response resp (fun () -> Json_response_scanner.consume body)

let read_json_body_as of_json resp body =
  read_json_body resp body
  |> Result.map (Json_response_scanner.with_conv of_json)

let read_json_body_as_list resp body =
  read_json_body resp body
  |> Result.map (Json_response_scanner.with_conv Yojson.Safe.Util.to_list)

let read_json_body_as_list_of of_json resp body =
  read_json_body_as_list resp body
  |> Result.map (Json_response_scanner.with_conv (List.map of_json))

let read_json_body_as_map resp body =
  read_json_body resp body
  |> Result.map (Json_response_scanner.with_conv Yojson.Safe.Util.to_assoc)

let read_json_body_as_map_of of_json resp body =
  read_json_body_as_map resp body
  |> Result.map
       (Json_response_scanner.with_conv
          (List.map (fun (s, v) -> (s, of_json v))))

let replace_string_path_param uri param_name param_value =
  let regexp = Str.regexp (Str.quote ("{" ^ param_name ^ "}")) in
  let path =
    Str.global_replace regexp param_value (Uri.pct_decode (Uri.path uri))
  in
  Uri.with_path uri path

let replace_path_param uri param_name to_string param_value =
  replace_string_path_param uri param_name (to_string param_value)

let maybe_replace_path_param uri param_name to_string param_value =
  option_fold (replace_path_param uri param_name to_string) uri param_value

let add_query_param uri param_name to_string param_value =
  Uri.add_query_param' uri (param_name, to_string param_value)

let add_query_param_list uri param_name to_string param_value =
  Uri.add_query_param uri (param_name, to_string param_value)

let maybe_add_query_param uri param_name to_string param_value =
  option_fold (add_query_param uri param_name to_string) uri param_value

let init_form_encoded_body () = ""

let add_form_encoded_body_param params param_name to_string param_value =
  let new_param_enc =
    Printf.sprintf {|%s=%s|}
      (Uri.pct_encode param_name)
      (Uri.pct_encode (to_string param_value))
  in
  if params = "" then new_param_enc
  else Printf.sprintf {|%s&%s|} params new_param_enc

let add_form_encoded_body_param_list params param_name to_string new_params =
  add_form_encoded_body_param params param_name (String.concat ",")
    (to_string new_params)

let maybe_add_form_encoded_body_param params param_name to_string param_value =
  option_fold
    (add_form_encoded_body_param params param_name to_string)
    params param_value

let finalize_form_encoded_body body = Cohttp_eio.Body.of_string body
