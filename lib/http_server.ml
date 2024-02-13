let handle_healthz _req = Yume.Server.respond ~status:`OK "HEALTHY"
let handle_readyz _req = Yume.Server.respond ~status:`OK "READY"

let start env ~sw () =
  let listen =
    Eio.Net.getaddrinfo_stream ~service:"8080" (Eio.Stdenv.net env) "0.0.0.0"
    |> List.hd
  in
  (match listen with
  | `Tcp (ipaddr, port) ->
      Logg.info (fun m ->
          m "listen tcp"
            [
              ("host", `String (Fmt.str "%a" Eio.Net.Ipaddr.pp ipaddr));
              ("port", `Int port);
            ])
  | _ -> ());

  (* Start HTTP server *)
  let open Yume.Server in
  let routes =
    let open Router in
    [
      get "/healthz" handle_healthz;
      get "/readyz" handle_readyz;
    ] [@ocamlformat "disable"]
  in
  let handler = Logger.use @@ Router.use routes @@ default_handler in
  start_server env ~sw ~listen handler
