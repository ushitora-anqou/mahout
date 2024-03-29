module Bare = struct
  open K8s_1_28_client

  exception Not_available

  module type S = sig
    type t
    type t_list

    val metadata :
      t -> Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta.t option

    val list_metadata :
      t_list -> Io_k8s_apimachinery_pkg_apis_meta_v1_list_meta.t option

    val to_list : t_list -> t list

    val read_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      ?pretty:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val create_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      namespace:string ->
      body:t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val patch_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:Yojson.Safe.t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      ?force:bool ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val delete_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      ?pretty:string ->
      ?dry_run:string ->
      ?grace_period_seconds:int32 ->
      ?orphan_dependents:bool ->
      ?propagation_policy:string ->
      body:Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.t ->
      unit ->
      (unit, Cohttp.Response.t) result

    val watch_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      namespace:string ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?pretty:string ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      ( Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t
        Json_response_scanner.t,
        Cohttp.Response.t )
      result

    val watch_for_all_namespaces :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?pretty:string ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      ( Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t
        Json_response_scanner.t,
        Cohttp.Response.t )
      result

    val list_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      namespace:string ->
      ?pretty:string ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      (t_list Json_response_scanner.t, Cohttp.Response.t) result

    val list_for_all_namespaces :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      ?allow_watch_bookmarks:bool ->
      ?continue:string ->
      ?field_selector:string ->
      ?label_selector:string ->
      ?limit:int32 ->
      ?pretty:string ->
      ?resource_version:string ->
      ?resource_version_match:string ->
      ?send_initial_events:bool ->
      ?timeout_seconds:int32 ->
      ?watch:bool ->
      unit ->
      (t_list Json_response_scanner.t, Cohttp.Response.t) result

    val replace_namespaced :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val read_status :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      ?pretty:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val replace_status :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val patch_status :
      sw:Eio.Switch.t ->
      Cohttp_eio.Client.t ->
      ?headers:Cohttp.Header.t ->
      name:string ->
      namespace:string ->
      body:Yojson.Safe.t ->
      ?pretty:string ->
      ?dry_run:string ->
      ?field_manager:string ->
      ?field_validation:string ->
      ?force:bool ->
      unit ->
      (t Json_response_scanner.t, Cohttp.Response.t) result

    val of_yojson : Yojson.Safe.t -> (t, string) result
    val to_yojson : t -> Yojson.Safe.t
  end

  module Config_map = struct
    type t = Io_k8s_api_core_v1_config_map.t
    type t_list = Io_k8s_api_core_v1_config_map_list.t

    let metadata (v : t) = v.metadata
    let list_metadata (v : t_list) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Core_v1_api.read_core_v1_namespaced_config_map
    let create_namespaced = Core_v1_api.create_core_v1_namespaced_config_map
    let patch_namespaced = Core_v1_api.patch_core_v1_namespaced_config_map

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Core_v1_api.delete_core_v1_namespaced_config_map ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Core_v1_api.watch_core_v1_namespaced_config_map_list
    let replace_namespaced = Core_v1_api.replace_core_v1_namespaced_config_map
    let list_namespaced = Core_v1_api.list_core_v1_namespaced_config_map

    let watch_for_all_namespaces =
      Core_v1_api.watch_core_v1_config_map_list_for_all_namespaces

    let list_for_all_namespaces =
      Core_v1_api.list_core_v1_config_map_for_all_namespaces

    let read_status ~sw:_ _ ?headers:_ ~name:_ ~namespace:_ ?pretty:_ _ =
      raise Not_available

    let patch_status ~sw:_ _ ?headers:_ ~name:_ ~namespace:_ ~body:_ ?pretty:_
        ?dry_run:_ ?field_manager:_ ?field_validation:_ ?force:_ _ =
      raise Not_available

    let replace_status ~sw:_ _ ?headers:_ ~name:_ ~namespace:_ ~body:_ ?pretty:_
        ?dry_run:_ ?field_manager:_ ?field_validation:_ _ =
      raise Not_available

    let of_yojson = Io_k8s_api_core_v1_config_map.of_yojson
    let to_yojson = Io_k8s_api_core_v1_config_map.to_yojson
  end

  module Deployment = struct
    type t = Io_k8s_api_apps_v1_deployment.t
    type t_list = Io_k8s_api_apps_v1_deployment_list.t

    let metadata (v : t) = v.metadata
    let list_metadata (v : t_list) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Apps_v1_api.read_apps_v1_namespaced_deployment
    let create_namespaced = Apps_v1_api.create_apps_v1_namespaced_deployment
    let patch_namespaced = Apps_v1_api.patch_apps_v1_namespaced_deployment

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Apps_v1_api.delete_apps_v1_namespaced_deployment ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Apps_v1_api.watch_apps_v1_namespaced_deployment_list
    let replace_namespaced = Apps_v1_api.replace_apps_v1_namespaced_deployment
    let list_namespaced = Apps_v1_api.list_apps_v1_namespaced_deployment

    let watch_for_all_namespaces =
      Apps_v1_api.watch_apps_v1_deployment_list_for_all_namespaces

    let list_for_all_namespaces =
      Apps_v1_api.list_apps_v1_deployment_for_all_namespaces

    let read_status = Apps_v1_api.read_apps_v1_namespaced_deployment_status
    let patch_status = Apps_v1_api.patch_apps_v1_namespaced_deployment_status

    let replace_status =
      Apps_v1_api.replace_apps_v1_namespaced_deployment_status

    let of_yojson = Io_k8s_api_apps_v1_deployment.of_yojson
    let to_yojson = Io_k8s_api_apps_v1_deployment.to_yojson
  end

  module Job = struct
    type t = Io_k8s_api_batch_v1_job.t
    type t_list = Io_k8s_api_batch_v1_job_list.t

    let metadata (v : t) = v.metadata
    let list_metadata (v : t_list) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Batch_v1_api.read_batch_v1_namespaced_job
    let create_namespaced = Batch_v1_api.create_batch_v1_namespaced_job
    let patch_namespaced = Batch_v1_api.patch_batch_v1_namespaced_job

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Batch_v1_api.delete_batch_v1_namespaced_job ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Batch_v1_api.watch_batch_v1_namespaced_job_list
    let replace_namespaced = Batch_v1_api.replace_batch_v1_namespaced_job
    let list_namespaced = Batch_v1_api.list_batch_v1_namespaced_job

    let watch_for_all_namespaces =
      Batch_v1_api.watch_batch_v1_job_list_for_all_namespaces

    let list_for_all_namespaces =
      Batch_v1_api.list_batch_v1_job_for_all_namespaces

    let read_status = Batch_v1_api.read_batch_v1_namespaced_job_status
    let patch_status = Batch_v1_api.patch_batch_v1_namespaced_job_status
    let replace_status = Batch_v1_api.replace_batch_v1_namespaced_job_status
    let of_yojson = Io_k8s_api_batch_v1_job.of_yojson
    let to_yojson = Io_k8s_api_batch_v1_job.to_yojson
  end

  module Pod = struct
    type t = Io_k8s_api_core_v1_pod.t
    type t_list = Io_k8s_api_core_v1_pod_list.t

    let metadata (v : t) = v.metadata
    let list_metadata (v : t_list) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Core_v1_api.read_core_v1_namespaced_pod
    let create_namespaced = Core_v1_api.create_core_v1_namespaced_pod
    let patch_namespaced = Core_v1_api.patch_core_v1_namespaced_pod

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Core_v1_api.delete_core_v1_namespaced_pod ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Core_v1_api.watch_core_v1_namespaced_pod_list
    let replace_namespaced = Core_v1_api.replace_core_v1_namespaced_pod
    let list_namespaced = Core_v1_api.list_core_v1_namespaced_pod

    let watch_for_all_namespaces =
      Core_v1_api.watch_core_v1_pod_list_for_all_namespaces

    let list_for_all_namespaces =
      Core_v1_api.list_core_v1_pod_for_all_namespaces

    let read_status = Core_v1_api.read_core_v1_namespaced_pod_status
    let patch_status = Core_v1_api.patch_core_v1_namespaced_pod_status
    let replace_status = Core_v1_api.replace_core_v1_namespaced_pod_status
    let of_yojson = Io_k8s_api_core_v1_pod.of_yojson
    let to_yojson = Io_k8s_api_core_v1_pod.to_yojson
  end

  module Service = struct
    type t = Io_k8s_api_core_v1_service.t
    type t_list = Io_k8s_api_core_v1_service_list.t

    let metadata (v : t) = v.metadata
    let list_metadata (v : t_list) = v.metadata
    let to_list (v : t_list) = v.items
    let read_namespaced = Core_v1_api.read_core_v1_namespaced_service
    let create_namespaced = Core_v1_api.create_core_v1_namespaced_service
    let patch_namespaced = Core_v1_api.patch_core_v1_namespaced_service

    let delete_namespaced ~sw client ?headers ~name ~namespace ?pretty ?dry_run
        ?grace_period_seconds ?orphan_dependents ?propagation_policy ~body () =
      Core_v1_api.delete_core_v1_namespaced_service ~sw client ?headers ~name
        ~namespace ?pretty ?dry_run ?grace_period_seconds ?orphan_dependents
        ?propagation_policy ~body ()
      |> Result.map ignore

    let watch_namespaced = Core_v1_api.watch_core_v1_namespaced_service_list
    let replace_namespaced = Core_v1_api.replace_core_v1_namespaced_service
    let list_namespaced = Core_v1_api.list_core_v1_namespaced_service

    let watch_for_all_namespaces =
      Core_v1_api.watch_core_v1_service_list_for_all_namespaces

    let list_for_all_namespaces =
      Core_v1_api.list_core_v1_service_for_all_namespaces

    let read_status = Core_v1_api.read_core_v1_namespaced_service_status
    let patch_status = Core_v1_api.patch_core_v1_namespaced_service_status
    let replace_status = Core_v1_api.replace_core_v1_namespaced_service_status
    let of_yojson = Io_k8s_api_core_v1_service.of_yojson
    let to_yojson = Io_k8s_api_core_v1_service.to_yojson
  end
end

include K8s_1_28_client

type error =
  [ `Connection_failure of string
  | `No_metadata
  | `Not_found
  | `Scan_failure of string ]
[@@deriving show]

module Make (B : Bare.S) = struct
  open struct
    let expect : _ -> (_, error) result = function
      | Ok x -> Ok x
      | Error (resp : Cohttp.Response.t) when resp.status = `Not_found ->
          Error `Not_found
      | Error resp ->
          Error
            (`Connection_failure (Format.asprintf "%a" Http.Response.pp resp))

    let expect_one x : (_, error) result =
      match expect x with
      | Error e -> Error e
      | Ok scanner -> (
          match Json_response_scanner.scan scanner with
          | Error (`Msg msg) -> Error (`Scan_failure msg)
          | Ok v -> Ok v)

    let get_name_and_ns body =
      match B.metadata body with
      | None | Some { name = None; _ } -> None
      | Some { name = Some name; namespace; _ } ->
          Some (name, Option.value ~default:"default" namespace)
  end

  type t = B.t

  let of_yojson = B.of_yojson
  let to_yojson = B.to_yojson

  type watch_event = [ `Added | `Modified | `Deleted ] * t

  let string_of_watch_event : watch_event -> string = function
    | `Added, v -> "ADDED " ^ (v |> to_yojson |> Yojson.Safe.to_string)
    | `Modified, v -> "MODIFIED " ^ (v |> to_yojson |> Yojson.Safe.to_string)
    | `Deleted, v -> "DELETED " ^ (v |> to_yojson |> Yojson.Safe.to_string)

  let parse_watch_event
      (ev : Io_k8s_apimachinery_pkg_apis_meta_v1_watch_event.t) =
    match ev._type with
    | "ADDED" -> (`Added, ev._object |> B.of_yojson |> Result.get_ok)
    | "MODIFIED" -> (`Modified, ev._object |> B.of_yojson |> Result.get_ok)
    | "DELETED" -> (`Deleted, ev._object |> B.of_yojson |> Result.get_ok)
    | _ -> failwith "invalid watch event"

  module Watcher = struct
    type t = {
      mtx : Eio.Mutex.t;
      mutable started : bool;
      mutable handlers : (watch_event -> unit) list;
    }

    let make () = { mtx = Eio.Mutex.create (); started = false; handlers = [] }

    let start client t =
      let ( let* ) = Result.bind in

      Eio.Mutex.use_rw ~protect:true t.mtx (fun () ->
          if t.started then failwith "watcher: start: already started";
          t.started <- true);

      let call_handlers ev =
        Eio.Mutex.use_ro t.mtx @@ fun () ->
        t.handlers |> List.rev |> List.iter (fun handler -> handler ev)
      in

      let latest_resource_version = ref "" in
      let list () =
        Eio.Switch.run @@ fun sw ->
        let* xs = B.list_for_all_namespaces ~sw client () |> expect_one in
        let resource_version =
          Option.get (Option.get (B.list_metadata xs)).resource_version
        in
        xs |> B.to_list |> List.iter (fun x -> call_handlers (`Added, x));
        latest_resource_version := resource_version;
        Ok ()
      in
      let watch () =
        Eio.Switch.run @@ fun sw ->
        (* NOTE: This fiber runs first, so listing should be performed after watching. *)
        let* scanner =
          B.watch_for_all_namespaces ~sw client ~watch:true
            ~resource_version:!latest_resource_version ()
          |> expect
        in
        Ok
          (scanner
          |> Json_response_scanner.iter (fun src ->
                 let event = parse_watch_event src in
                 (match B.metadata (snd event) with
                 | Some { resource_version = Some resource_version; _ } ->
                     latest_resource_version := resource_version
                 | _ -> ());
                 call_handlers event;
                 ()))
      in

      let rec loop () : unit =
        (if !latest_resource_version = "" then
           match list () with
           | Ok x -> x
           | Error e ->
               Logg.err (fun m ->
                   m "watcher: list failed"
                     [ ("error", `String (show_error e)) ]);
               failwith "list failed");
        (match watch () with
        | Ok () -> ()
        | Error e ->
            Logg.err (fun m ->
                m "watcher: watch failed" [ ("error", `String (show_error e)) ]));
        loop ()
      in
      loop ()

    let register_handler f t =
      Eio.Mutex.use_rw ~protect:true t.mtx @@ fun () ->
      t.handlers <- f :: t.handlers
  end

  module Cache = struct
    type 'a t = {
      mtx : Eio.Mutex.t;
      name_ns : (string * string, 'a) Hashtbl.t;
      ns_name : (string, (string, 'a) Hashtbl.t) Hashtbl.t;
    }

    let make () =
      {
        mtx = Eio.Mutex.create ();
        name_ns = Hashtbl.create 0;
        ns_name = Hashtbl.create 0;
      }

    let unsafe_update ~name ~namespace data t =
      Hashtbl.replace t.name_ns (name, namespace) data;

      let h =
        match Hashtbl.find_opt t.ns_name namespace with
        | Some h -> h
        | None -> Hashtbl.create 1
      in
      Hashtbl.replace h name data;
      Hashtbl.replace t.ns_name namespace h

    let reset data t =
      Eio.Mutex.use_rw ~protect:true t.mtx @@ fun () ->
      Hashtbl.clear t.name_ns;
      Hashtbl.clear t.ns_name;
      data
      |> List.iter (fun (name, namespace, v) ->
             unsafe_update ~name ~namespace v t);
      ()

    let update ~name ~namespace data t =
      Eio.Mutex.use_rw ~protect:true t.mtx @@ fun () ->
      unsafe_update ~name ~namespace data t

    let get ~name ~namespace t =
      Eio.Mutex.use_ro t.mtx @@ fun () ->
      Hashtbl.find_opt t.name_ns (name, namespace)

    let list ~namespace ?label_selector t =
      Eio.Mutex.use_ro t.mtx @@ fun () ->
      Hashtbl.find_opt t.ns_name namespace
      |> Option.map (fun h ->
             h |> Hashtbl.to_seq_values
             |> Seq.filter (fun resource ->
                    match label_selector with
                    | None -> true
                    | Some label_selector ->
                        let metadata = B.metadata resource |> Option.get in
                        let labels =
                          Yojson.Safe.Util.to_assoc metadata.labels
                        in
                        Label_selector.check label_selector labels)
             |> List.of_seq)
      |> Option.value ~default:[]

    let list_all t =
      Eio.Mutex.use_ro t.mtx @@ fun () ->
      Hashtbl.fold (fun _ v acc -> v :: acc) t.name_ns []

    let delete ~name ~namespace t =
      Eio.Mutex.use_rw ~protect:true t.mtx @@ fun () ->
      Hashtbl.remove t.name_ns (name, namespace);
      Hashtbl.find_opt t.ns_name namespace
      |> Option.iter (fun h -> Hashtbl.remove h name)
  end

  let watcher = Watcher.make ()
  let start_watcher client () = Watcher.start client watcher
  let register_watcher f = watcher |> Watcher.register_handler f
  let cache = ref None

  let enable_cache () =
    cache := Some (Cache.make ());
    register_watcher (fun (ty, data) ->
        let name, namespace = get_name_and_ns data |> Option.get in
        let cache = Option.get !cache in
        match ty with
        | `Added | `Modified -> cache |> Cache.update ~name ~namespace data
        | `Deleted -> cache |> Cache.delete ~name ~namespace);
    ()

  let get client ~name ~namespace () =
    Eio.Switch.run @@ fun sw ->
    match !cache with
    | None -> B.read_namespaced ~sw client ~name ~namespace () |> expect_one
    | Some cache ->
        cache |> Cache.get ~name ~namespace |> Option.to_result ~none:`Not_found

  let get_status client ~name ~namespace () =
    Eio.Switch.run @@ fun sw ->
    B.read_status ~sw client ~name ~namespace () |> expect_one

  let update client body =
    Eio.Switch.run @@ fun sw ->
    match get_name_and_ns body with
    | None -> Error `No_metadata
    | Some (name, namespace) ->
        B.replace_namespaced ~sw client ~name ~namespace ~body () |> expect_one

  let update_status client body =
    Eio.Switch.run @@ fun sw ->
    match get_name_and_ns body with
    | None -> Error `No_metadata
    | Some (name, namespace) ->
        B.replace_status ~sw client ~name ~namespace ~body () |> expect_one

  let create client body =
    Eio.Switch.run @@ fun sw ->
    match get_name_and_ns body with
    | None -> Error `No_metadata
    | Some (_, namespace) ->
        B.create_namespaced ~sw client ~namespace ~body () |> expect_one

  let create_or_update client ~name ~namespace f =
    match get client ~name ~namespace () with
    | Error `Not_found -> create client (f None)
    | Error _ as e -> e
    | Ok v -> update client (f (Some v))

  let create_or_update_status client ~name ~namespace f =
    match get_status client ~name ~namespace () with
    | Error `Not_found -> create client (f None)
    | Error _ as e -> e
    | Ok v -> update_status client (f (Some v))

  let list client ~namespace ?label_selector () =
    Eio.Switch.run @@ fun sw ->
    match !cache with
    | Some cache -> cache |> Cache.list ~namespace ?label_selector |> Result.ok
    | _ ->
        let label_selector =
          label_selector |> Option.map Label_selector.to_string
        in
        B.list_namespaced ~sw client ~namespace ?label_selector ()
        |> expect_one |> Result.map B.to_list

  let list_all client () =
    Eio.Switch.run @@ fun sw ->
    match !cache with
    | Some cache -> cache |> Cache.list_all |> Result.ok
    | None ->
        B.list_for_all_namespaces ~sw client ()
        |> expect_one |> Result.map B.to_list

  let delete client ?uid ~namespace ~name () =
    Eio.Switch.run @@ fun sw ->
    B.delete_namespaced ~sw client ~name ~namespace
      ~body:
        (Io_k8s_apimachinery_pkg_apis_meta_v1_delete_options.make
           ~preconditions:
             (Io_k8s_apimachinery_pkg_apis_meta_v1_preconditions.make ?uid ())
           ())
      ()
    |> expect
end

module Config_map = struct
  include Make (Bare.Config_map)

  let make = Io_k8s_api_core_v1_config_map.make
end

module Deployment = struct
  include Make (Bare.Deployment)

  let make = Io_k8s_api_apps_v1_deployment.make
end

module Job = struct
  include Make (Bare.Job)

  let make = Io_k8s_api_batch_v1_job.make
end

module Pod = struct
  include Make (Bare.Pod)

  let make = Io_k8s_api_core_v1_pod.make
end

module Service = struct
  include Make (Bare.Service)

  let make = Io_k8s_api_core_v1_service.make
end

(* Not implemented *)
module Config_map_volume_source = Io_k8s_api_core_v1_config_map_volume_source
module Container = Io_k8s_api_core_v1_container
module Container_port = Io_k8s_api_core_v1_container_port
module Deployment_spec = Io_k8s_api_apps_v1_deployment_spec
module Empty_dir_volume_source = Io_k8s_api_core_v1_empty_dir_volume_source
module Env_from_source = Io_k8s_api_core_v1_env_from_source
module Env_var = Io_k8s_api_core_v1_env_var
module Job_spec = Io_k8s_api_batch_v1_job_spec
module Job_template_spec = Io_k8s_api_batch_v1_job_template_spec
module Key_to_path = Io_k8s_api_core_v1_key_to_path
module Label_selector = Io_k8s_apimachinery_pkg_apis_meta_v1_label_selector
module Object_meta = Io_k8s_apimachinery_pkg_apis_meta_v1_object_meta
module Owner_reference = Io_k8s_apimachinery_pkg_apis_meta_v1_owner_reference
module Pod_spec = Io_k8s_api_core_v1_pod_spec
module Pod_template_spec = Io_k8s_api_core_v1_pod_template_spec
module Probe = Io_k8s_api_core_v1_probe
module Service_port = Io_k8s_api_core_v1_service_port
module Service_spec = Io_k8s_api_core_v1_service_spec
module Tcp_socket_action = Io_k8s_api_core_v1_tcp_socket_action
module Volume = Io_k8s_api_core_v1_volume
module Http_get_action = Io_k8s_api_core_v1_http_get_action
module Volume_mount = Io_k8s_api_core_v1_volume_mount
