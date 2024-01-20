module Path_pattern = struct
  type single_pattern = L of string | P of string | S
  type t = single_pattern list

  let split_on_slash s =
    s |> String.split_on_char '/' |> List.tl |> List.filter (( <> ) "")

  let of_string (src : string) : t =
    src |> split_on_slash
    |> List.map (function
         | "*" -> S
         | x when String.starts_with ~prefix:":" x -> P x
         | x -> L x)

  let perform ~(pat : t) (src : string) : (string * string) list option =
    let rec aux param = function
      | [], [] | _, [ S ] -> Some param
      | x :: xs, L y :: ys when x = y -> aux param (xs, ys)
      | x :: xs, P y :: ys -> aux ((y, x) :: param) (xs, ys)
      | _ -> None
    in
    aux [] (split_on_slash src, pat)
end

module Status = struct
  type t = Cohttp.Code.status_code

  let to_string = Cohttp.Code.string_of_status
  let is_error (s : t) = Cohttp.Code.(code_of_status s |> is_error)
  let is_success (s : t) = Cohttp.Code.(code_of_status s |> is_success)
end

module Header = struct
  type name =
    [ `Accept
    | `Accept_encoding
    | `Access_control_allow_headers
    | `Access_control_allow_methods
    | `Access_control_allow_origin
    | `Access_control_expose_headers
    | `Access_control_request_headers
    | `Authorization
    | `Connection
    | `Content_encoding
    | `Content_length
    | `Content_type
    | `Crypto_key
    | `Date
    | `Digest
    | `Host
    | `Link
    | `Location
    | `Raw of string
    | `Sec_websocket_protocol
    | `Signature
    | `TTL
    | `User_agent ]

  let lower_string_of_name : name -> string = function
    | `Accept -> "accept"
    | `Accept_encoding -> "accept-encoding"
    | `Access_control_allow_headers -> "access-control-allow-headers"
    | `Access_control_allow_methods -> "access-control-allow-methods"
    | `Access_control_allow_origin -> "access-control-allow-origin"
    | `Access_control_expose_headers -> "access-control-expose-headers"
    | `Access_control_request_headers -> "access-control-request-headers"
    | `Authorization -> "authorization"
    | `Connection -> "connection"
    | `Content_encoding -> "content-encoding"
    | `Content_length -> "content-length"
    | `Content_type -> "content-type"
    | `Crypto_key -> "crypto-key"
    | `Date -> "date"
    | `Digest -> "digest"
    | `Host -> "host"
    | `Link -> "link"
    | `Location -> "location"
    | `Raw s -> s
    | `Sec_websocket_protocol -> "sec-websocket-protocol"
    | `Signature -> "signature"
    | `TTL -> "ttl"
    | `User_agent -> "user-agent"

  let string_of_name = lower_string_of_name

  let name_of_string (k : string) : name =
    match String.lowercase_ascii k with
    | "accept" -> `Accept
    | "accept-encoding" -> `Accept_encoding
    | "access-control-allow-headers" -> `Access_control_allow_headers
    | "access-control-allow-methods" -> `Access_control_allow_methods
    | "access-control-allow-origin" -> `Access_control_allow_origin
    | "access-control-expose-headers" -> `Access_control_expose_headers
    | "access-control-request-headers" -> `Access_control_request_headers
    | "authorization" -> `Authorization
    | "connection" -> `Connection
    | "content-encoding" -> `Content_encoding
    | "content-length" -> `Content_length
    | "content-type" -> `Content_type
    | "crypto-key" -> `Crypto_key
    | "date" -> `Date
    | "digest" -> `Digest
    | "host" -> `Host
    | "link" -> `Link
    | "location" -> `Location
    | "sec-websocket-protocol" -> `Sec_websocket_protocol
    | "signature" -> `Signature
    | "ttl" -> `TTL
    | "user-agent" -> `User_agent
    | s -> `Raw s

  type t = name * string

  let to_tuple ((n, v) : t) : string * string = (string_of_name n, v)
  let of_tuple (n, v) : t = (name_of_string n, v)
end

module Headers = struct
  type t = Header.t list

  let to_list : t -> (string * string) list = List.map Header.to_tuple
  let of_list : (string * string) list -> t = List.map Header.of_tuple
end

module Method = struct
  type t = Cohttp.Code.meth

  let to_string = Cohttp.Code.string_of_method
end

module Bare_server = struct
  module Request = struct
    include Cohttp.Request

    let headers x = x |> headers |> Cohttp.Header.to_list
  end

  module Response = struct
    type t = Http.Response.t * Cohttp_eio.Body.t
  end

  module Body = struct
    include Cohttp_eio.Body

    let to_string body =
      Eio.Buf_read.(parse_exn take_all) body ~max_size:max_int
  end

  let respond ~(status : Status.t) ~(headers : Headers.t) ~(body : string) =
    let headers = headers |> Headers.to_list |> Cohttp.Header.of_list in
    (Http.Response.make ~status ~headers (), Cohttp_eio.Body.of_string body)

  let start_server ~listen ~sw env k callback =
    let callback _conn (req : Request.t) (body : Body.t) =
      (* Invoke the handler *)
      try callback req body
      with e ->
        let uri = Request.uri req in
        let meth = Request.meth req in
        Logs.err (fun m ->
            m "Unexpected exception: %s %s: %s\n%s" (Method.to_string meth)
              (Uri.to_string uri) (Printexc.to_string e)
              (Printexc.get_backtrace ()));
        respond ~status:`Internal_server_error ~body:"" ~headers:[]
    in
    let server = Cohttp_eio.Server.make ~callback () in
    let socket =
      Eio.Net.listen (Eio.Stdenv.net env) ~sw ~backlog:128 ~reuse_addr:true
        listen
    in
    Eio.Fiber.both k (fun () ->
        Cohttp_eio.Server.run ~on_error:raise socket server)
end

module Server = struct
  type request_body =
    | JSON of Yojson.Safe.t
    | Form of (string * string list) list

  type request =
    | Request of {
        bare_req : Bare_server.Request.t;
        bare_body : Bare_server.Body.t;
        meth : Method.t;
        uri : Uri.t;
        path : string;
        query : (string * string) list;
        param : (string * string) list;
        body : (string option * request_body option) Lazy.t;
        headers : Headers.t;
      }

  type response =
    | BareResponse of Bare_server.Response.t
    | Response of {
        status : Status.t;
        headers : Headers.t;
        body : string;
        tags : string list;
      }

  type handler = request -> response
  type middleware = handler -> handler

  exception ErrorResponse of { status : Status.t; body : string }

  let raise_error_response ?(body = "") status =
    raise (ErrorResponse { status; body })

  let respond ?(status = `OK) ?(headers = []) ?(tags = []) (body : string) =
    Response { status; headers; body; tags }

  let body = function
    | Request { body; _ } -> (
        match Lazy.force body with
        | Some raw_body, _ -> raw_body
        | _ -> failwith "body: none")

  let param name = function Request { param; _ } -> List.assoc name param

  let string_of_yojson_atom = function
    | `Bool b -> string_of_bool b
    | `Int i -> string_of_int i
    | `String s -> s
    | _ -> failwith "string_of_yojson_atom"

  let list_assoc_many k1 l =
    l |> List.filter_map (fun (k, v) -> if k = k1 then Some v else None)

  let query_many name : request -> string list = function
    | Request { body; query; _ } -> (
        match query |> list_assoc_many (name ^ "[]") with
        | _ :: _ as res -> res
        | [] -> (
            match Lazy.force body with
            | _, Some (JSON (`Assoc l)) -> (
                match List.assoc_opt name l with
                | Some (`List l) -> l |> List.map string_of_yojson_atom
                | _ -> [])
            | _ -> failwith "query many"))

  let query ?default name req =
    match req with
    | Request { body; query; _ } -> (
        try
          match Lazy.force body |> snd with
          | None -> failwith "query: body none"
          | Some x -> (
              match x with
              | JSON (`Assoc l) -> List.assoc name l |> string_of_yojson_atom
              | JSON _ -> failwith "json"
              | Form body -> (
                  match query |> List.assoc_opt name with
                  | Some x -> x
                  | None -> body |> List.assoc name |> List.hd))
        with
        | _ when default <> None -> Option.get default
        | _ -> raise_error_response `Bad_request)

  let query_opt name r = try Some (query name r) with _ -> None

  let header_opt name : request -> string option = function
    | Request { headers; _ } -> headers |> List.assoc_opt name

  let header name (r : request) : string =
    match header_opt name r with None -> failwith "header: none" | Some v -> v

  let headers = function Request { headers; _ } -> headers
  let path = function Request { path; _ } -> path
  let meth = function Request { meth; _ } -> meth

  let parse_body ~body ~headers =
    let content_type = List.assoc_opt `Content_type headers in
    match
      content_type
      |> Option.map (fun s ->
             s |> String.split_on_char ';' |> List.hd |> String.trim)
    with
    | Some "application/json" -> (
        let raw_body = Bare_server.Body.to_string body in
        ( Some raw_body,
          try JSON (Yojson.Safe.from_string raw_body) with _ -> Form [] ))
    | Some "application/x-www-form-urlencoded" | _ ->
        let raw_body = Bare_server.Body.to_string body in
        (Some raw_body, Form (Uri.query_of_encoded raw_body))

  let default_handler : handler = function
    | Request req ->
        let status =
          match req.meth with `GET -> `Not_found | _ -> `Method_not_allowed
        in
        respond ~status ""

  let start_server env ~sw ?(listen = `Tcp (Eio.Net.Ipaddr.V4.loopback, 8080))
      ?error_handler (handler : handler) k : unit =
    Bare_server.start_server ~listen env ~sw k
    @@ fun (req : Bare_server.Request.t) (body : Bare_server.Body.t) :
      Bare_server.Response.t ->
    (* Parse req *)
    let uri = Bare_server.Request.uri req in
    let meth = Bare_server.Request.meth req in
    let headers = Bare_server.Request.headers req |> Headers.of_list in
    let path = Uri.path uri in
    let query =
      Uri.query uri |> List.map (fun (k, xs) -> (k, xs |> String.concat ","))
    in
    let lazy_parsed_body =
      lazy
        (match parse_body ~body ~headers with
        | exception _ -> (None, None)
        | raw_body, parsed_body -> (raw_body, Some parsed_body))
    in
    let req =
      Request
        {
          bare_req = req;
          bare_body = body;
          meth;
          uri;
          path;
          query;
          param = [];
          body = lazy_parsed_body;
          headers;
        }
    in

    (* Invoke the handler *)
    let res = handler req in

    (* Respond (after call error_handler if necessary *)
    let rec aux first = function
      | BareResponse resp -> resp
      | Response { status; headers; body; _ }
        when (not first)
             || Option.is_none error_handler
             || not (Status.is_error status)
             (* - error_handler is already called;
                - error_handler is not specified; or
                - not erroneous response *) ->
          Bare_server.respond ~status ~headers ~body
      | Response { status; headers; body; _ } ->
          let error_handler = Option.get error_handler in
          error_handler ~req ~status ~headers ~body |> aux false
    in
    aux true res

  (* Middleware Router *)
  module Router = struct
    type route = Method.t * string * (request -> response)

    type spec_entry = Route of route | Scope of (string * spec)
    and spec = spec_entry list

    let use (spec : spec) (inner_handler : handler) (req : request) : response =
      let routes =
        let rec aux (spec : spec) : route list =
          spec
          |> List.map (function
               | Route r -> [ r ]
               | Scope (name, spec) ->
                   aux spec
                   |> List.map (fun (meth, uri, h) -> (meth, name ^ uri, h)))
          |> List.flatten
        in
        aux spec
        |> List.map (fun (meth, uri, h) ->
               (meth, Path_pattern.of_string uri, h))
      in

      match req with
      | Request req -> (
          (* Choose correct handler from routes *)
          let param, handler =
            routes
            |> List.find_map (fun (meth', pat, handler) ->
                   if req.meth <> meth' then None
                   else
                     Path_pattern.perform ~pat req.path
                     |> Option.map (fun param -> (param, handler)))
            |> Option.value ~default:([], inner_handler)
          in
          let req = Request { req with param } in
          let resp =
            try handler req with
            | ErrorResponse { status; body } ->
                Logs.debug (fun m ->
                    m "Error response raised: %s\n%s" (Status.to_string status)
                      (Printexc.get_backtrace ()));
                respond ~status ~tags:[ "log" ] body
            | e ->
                Logs.debug (fun m ->
                    m "Exception raised: %s\n%s" (Printexc.to_string e)
                      (Printexc.get_backtrace ()));
                respond ~status:`Internal_server_error ""
          in
          match resp with
          | Response ({ status; tags; _ } as r) when Status.is_error status ->
              Response { r with tags = "log" :: tags }
          | r -> r)

    let get target f : spec_entry = Route (`GET, target, f)
    let post target f : spec_entry = Route (`POST, target, f)
    let patch target f : spec_entry = Route (`PATCH, target, f)
    let delete target f : spec_entry = Route (`DELETE, target, f)
    let options target f : spec_entry = Route (`OPTIONS, target, f)
    let scope (name : string) (spec : spec) : spec_entry = Scope (name, spec)
  end

  (* Middleware CORS *)
  module Cors = struct
    type t = {
      target : string;
      target_pat : Path_pattern.t;
      methods : Method.t list;
      origin : string;
      expose : Header.name list;
    }

    let make target ?(origin = "*") ~methods ?(expose = []) () =
      let target_pat = Path_pattern.of_string target in
      { target; target_pat; methods; origin; expose }

    let use (src : t list) (inner_handler : handler) (req : request) : response
        =
      (* Handler for preflight OPTIONS requests *)
      let handler (r : t) (req : request) : response =
        let headers =
          [
            ( `Access_control_allow_methods,
              r.methods |> List.map Method.to_string |> String.concat ", " );
            (`Access_control_allow_origin, r.origin);
          ]
        in
        let headers =
          match req with
          | Request req ->
              req.headers
              |> List.assoc_opt `Access_control_request_headers
              |> Option.fold ~none:headers ~some:(fun v ->
                     (`Access_control_allow_headers, v) :: headers)
        in
        respond ~status:`No_content ~headers ""
      in

      (* Construct routes for preflight requests *)
      let routes =
        src |> List.map (fun (r : t) -> Router.options r.target (handler r))
      in

      (* Construct router *)
      req
      |> Router.use routes @@ function
         (* Fallback handler: apply inner_handler, and
            if path matches, append CORS headers *)
         | Request { path; _ } as req -> (
             let path_match =
               src
               |> List.find_opt (fun { target_pat; _ } ->
                      Path_pattern.perform ~pat:target_pat path
                      |> Option.is_some)
             in
             let resp = inner_handler req in
             match (resp, path_match) with
             | _, None | BareResponse _, _ -> resp
             | Response res, Some { origin; expose; _ } ->
                 Response
                   {
                     res with
                     headers =
                       (`Access_control_allow_origin, origin)
                       :: ( `Access_control_expose_headers,
                            expose
                            |> List.map Header.string_of_name
                            |> String.concat ", " )
                       :: res.headers;
                   })
  end

  (* Middlware Logger *)
  module Logger = struct
    let string_of_request_response req res =
      match (req, res) with
      | Request { bare_req; body; _ }, Response { status; _ } ->
          let open Buffer in
          let buf = create 0 in
          let fmt = Format.formatter_of_buffer buf in
          Bare_server.Request.pp_hum fmt bare_req;
          Format.pp_print_flush fmt ();
          add_string buf "\n";
          let raw_body = body |> Lazy.force |> fst in
          raw_body
          |> Option.iter (fun s ->
                 add_string buf "\n";
                 add_string buf s;
                 add_string buf "\n");
          add_string buf "\n==============================\n";
          add_string buf ("Status: " ^ Status.to_string status);
          Buffer.contents buf
      | _ -> assert false

    let now () = Unix.gettimeofday () |> Ptime.of_float_s |> Option.get

    let use (inner_handler : handler) (req : request) : response =
      let (Request { uri; meth; _ }) = req in
      let meth = Method.to_string meth in
      let uri = Uri.to_string uri in
      Logs.debug (fun m -> m "%s %s" meth uri);
      let resp = inner_handler req in
      (match resp with
      | Response { status; _ } ->
          Logs.info (fun m -> m "%s %s %s" (Status.to_string status) meth uri)
      | BareResponse _ -> Logs.info (fun m -> m "[bare] %s %s" meth uri));
      resp
  end
end
