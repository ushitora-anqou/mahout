let null_auth ?ip:_ ~host:_ _ =
  Ok None (* Warning: use a real authenticator in your code! *)

let https ~authenticator =
  let tls_config = Tls.Config.client ~authenticator () in
  fun uri raw ->
    let host =
      try
        uri |> Uri.host |> Option.get |> Domain_name.of_string_exn
        |> Domain_name.host_exn |> Option.some
      with _ -> None
    in
    Tls_eio.client_of_flow ?host tls_config raw

module K = K8s_1_28_client

module Net_anqou_mahout = struct
  open K

  module V1alpha1 = struct
    module Mastodon = struct
      module Web = struct
        type t = { replicas : int [@key "replicas"] }
        [@@deriving yojson { strict = false }, show]
      end

      module Sidekiq = struct
        type t = { replicas : int [@key "replicas"] }
        [@@deriving yojson { strict = false }, show]
      end

      module Streaming = struct
        type t = { replicas : int [@key "replicas"] }
        [@@deriving yojson { strict = false }, show]
      end

      module Spec = struct
        type t = {
          image : string; [@key "image"]
          env_from : Io_k8s_api_core_v1_env_from_source.t list;
              [@default []] [@key "envFrom"]
          web : Web.t option; [@default None] [@key "web"]
          sidekiq : Sidekiq.t option; [@default None] [@key "sidekiq"]
          streaming : Streaming.t option; [@default None] [@key "streaming"]
        }
        [@@deriving yojson { strict = false }, show]
      end

      module Status = struct
        type t = { message : string option [@default None] [@key "message"] }
        [@@deriving yojson { strict = false }, show]
      end

      type t = {
        api_version : string option; [@default None] [@key "apiVersion"]
        kind : string option; [@default None] [@key "kind"]
        metadata : Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option;
            [@default None] [@key "metadata"]
        spec : Spec.t option; [@default None] [@key "spec"]
        status : Status.t option; [@default None] [@key "status"]
      }
      [@@deriving yojson { strict = false }, show]
    end
    [@@warning "-32"]
  end
end

module Mahout_v1alpha1_api = struct
  open K

  let watch_mahout_v1alpha1_namespaced_mastodon ~sw client ~namespace ?watch ()
      =
    let uri =
      Request.build_uri
        "/apis/mahout.anqou.net/v1alpha1/watch/namespaces/{namespace}/mastodons"
    in
    let headers = Request.default_headers in
    let headers = Cohttp.Header.add headers "authorization" Request.api_key in
    let uri =
      Request.replace_path_param uri "namespace" (fun x -> x) namespace
    in
    let uri = Request.maybe_add_query_param uri "watch" string_of_bool watch in
    let resp, body = Cohttp_eio.Client.call ~sw client `GET uri ~headers in
    Request.read_json_body_as
      (JsonSupport.unwrap
         Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.of_yojson)
      resp body

  let patch_mahout_v1alpha1_namespaced_mastodon ~sw client ~name ~namespace
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
    let uri =
      Request.replace_path_param uri "namespace" (fun x -> x) namespace
    in
    let body = Request.write_json_body body in
    let resp, body =
      Cohttp_eio.Client.call ~sw client `PATCH uri ~headers ~body
    in
    Request.read_json_body_as
      (JsonSupport.unwrap Net_anqou_mahout.V1alpha1.Mastodon.of_yojson)
      resp body
end

let controller () =
  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  let client =
    (* FIXME: use ca cert *)
    Cohttp_eio.Client.make
      ~https:(Some (https ~authenticator:null_auth))
      (Eio.Stdenv.net env)
  in

  (*
  K.Core_v1_api.watch_core_v1_namespaced_pod_list ~sw client
    ~namespace:"mastodon0" ~watch:true ()
  |> K.Json_response_scanner.iter
       (fun (result : K.Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t) ->
         let item =
           K.Io_k8s_api_core_v1_pod.of_yojson result._object |> Result.get_ok
         in
         Logs.info (fun m ->
             m ">>> %s %s / %s" result._type
               (Option.get (Option.get item.metadata).name)
               (Option.get (Option.get item.metadata).namespace)));
  *)
  Mahout_v1alpha1_api.watch_mahout_v1alpha1_namespaced_mastodon ~sw client
    ~namespace:"default" ~watch:true ()
  |> K.Json_response_scanner.iter
       (fun (result : K.Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t) ->
         Logs.info (fun m ->
             m "%s %s" result._type (Yojson.Safe.to_string result._object));
         match result._type with
         | "ADDED" ->
             let item =
               Net_anqou_mahout.V1alpha1.Mastodon.of_yojson result._object
               |> Result.get_ok
             in
             let body =
               Net_anqou_mahout.V1alpha1.Mastodon.(
                 { item with status = Some Status.{ message = Some "Hello" } }
                 |> to_yojson)
             in
             let _ =
               Mahout_v1alpha1_api.patch_mahout_v1alpha1_namespaced_mastodon ~sw
                 client
                 ~name:(Option.get (Option.get item.metadata).name)
                 ~namespace:"default" ~body ()
             in
             Logs.info (fun m -> m "patched");
             ()
         | _ -> ());

  ()

let () =
  Mahout.Logg.setup ();

  (* Initialize PRNG *)
  (try Unix.getenv "RANDOM_INIT" |> int_of_string |> Random.init
   with Not_found -> Random.self_init ());

  let open Cmdliner in
  let cmd =
    Cmd.(
      group (info "mahout")
        [ v (info "controller") Term.(const controller $ const ()) ])
  in
  exit (Cmd.eval cmd)
