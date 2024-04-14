module Logg = Mahout.Logg

exception Process_status_error of Unix.process_status * string * string

let _or_true f = try f () with Process_status_error _ -> ()
let failwithf f = Printf.ksprintf failwith f

let consistently ?(count = 24) ?(interval = 5) f =
  let rec loop i =
    if i = 0 then ()
    else (
      (try f ()
       with e ->
         Logg.err (fun m ->
             m "consistently: failed"
               [ ("exc", `String (Printexc.to_string e)) ]);
         raise e);
      Unix.sleep interval;
      loop (i - 1))
  in
  loop count

let eventually ?(count = 60) ?(interval = 5) f =
  let rec loop i =
    try f () with
    | e when i = 0 ->
        Logg.err (fun m ->
            m "eventually: failed" [ ("exc", `String (Printexc.to_string e)) ]);
        raise e
    | _ ->
        Unix.sleep interval;
        loop (i - 1)
  in
  loop count

let run_command command =
  let stdout_ch, stdin_ch, stderr_ch =
    Unix.open_process_args_full "bash"
      [| "bash"; "-c"; command |]
      [|
        Printf.sprintf "PATH=%s"
          (Sys.getenv_opt "PATH" |> Option.value ~default:"");
        Printf.sprintf "KUBECONFIG=%s"
          (Sys.getenv_opt "KUBECONFIG" |> Option.value ~default:"");
      |]
  in
  let stdout = In_channel.input_all stdout_ch in
  let stderr = In_channel.input_all stderr_ch in
  Logg.info (fun m ->
      m "run"
        [
          ("command", `String (String.trim command));
          ("stdout", `String (String.trim stdout));
          ("stderr", `String (String.trim stderr));
        ]);
  match Unix.close_process_full (stdout_ch, stdin_ch, stderr_ch) with
  | WEXITED 0 -> (stdout, stderr)
  | status -> raise (Process_status_error (status, stdout, stderr))

let kubectl args =
  let kubectl = Sys.getenv_opt "KUBECTL" |> Option.value ~default:"kubectl" in
  run_command (kubectl ^ " " ^ args)

let wait_available ~n kind condition name =
  try
    kubectl
      (Printf.sprintf {|wait -n %s --for='condition=%s' --timeout=1s %s %s|} n
         condition kind name)
    |> ignore
  with Process_status_error (Unix.WEXITED 1, _, _) ->
    failwith ("condition Available not met for " ^ kind ^ "/" ^ name)

let wait_deploy_available name = wait_available "deploy" "Available" name
let _wait_pod_available name = wait_available "pod" "Ready" name

let http_get uri =
  kubectl (Printf.sprintf {|exec deploy/toolbox -- curl --silent '%s'|} uri)

let apply_manifest file_name =
  kubectl (Printf.sprintf {|apply -f manifests/%s|} file_name) |> ignore

let delete_manifest file_name =
  kubectl (Printf.sprintf {|delete -f manifests/%s|} file_name) |> ignore

let check_mastodon_version ~host ~endpoint ~expected =
  let got =
    kubectl
      (Printf.sprintf
         {|exec deploy/toolbox -- curl --silent -H 'Host: %s' %s/api/v1/instance | jq -r .version|}
         host endpoint)
    |> fst |> String.trim
  in
  if got <> expected then
    failwithf "check_mastodon_version: got %s, expected %s" got expected

let wait_not_found ~n kind name =
  kubectl
    (Printf.sprintf {|get -n %s %s %s 2>&1 | grep "\"%s\" not found"|} n kind
       name name)
  |> ignore

let check_schema_migrations_count ~expected =
  let src =
    kubectl
      {|exec -n e2e postgres-0 -- psql -U mastodon mastodon_production -c 'SELECT COUNT(version) FROM schema_migrations;'|}
    |> fst |> String.split_on_char '\n'
  in
  let count = List.nth src 2 |> String.trim |> int_of_string in
  if count <> expected then
    failwithf "check_schema_migrations_count: got %d, expected %d" count
      expected

let check_deploy_annotation ~n deploy_name key expected_value =
  let got_value =
    kubectl
      (Printf.sprintf
         {|get -n %s deploy %s -o json | jq -r '.metadata.annotations."%s"'|} n
         deploy_name key)
    |> fst |> String.trim
  in
  if got_value <> expected_value then
    failwithf "check_deploy_annotation: got '%s', expected '%s'" got_value
      expected_value

let setup () = ()

let () =
  Mahout.Logg.setup ~enable_trace:false @@ fun () ->
  setup ();

  apply_manifest "mastodon0-v4.1.9.yaml";

  eventually (fun () ->
      wait_deploy_available ~n:"e2e" "mastodon0-gateway-nginx";
      wait_deploy_available ~n:"e2e" "mastodon0-sidekiq";
      wait_deploy_available ~n:"e2e" "mastodon0-streaming";
      wait_deploy_available ~n:"e2e" "mastodon0-web";

      check_deploy_annotation ~n:"e2e" "mastodon0-gateway-nginx"
        "test.mahout.anqou.net/role" "gateway";
      check_deploy_annotation ~n:"e2e" "mastodon0-sidekiq"
        "test.mahout.anqou.net/role" "sidekiq";
      check_deploy_annotation ~n:"e2e" "mastodon0-streaming"
        "test.mahout.anqou.net/role" "streaming";
      check_deploy_annotation ~n:"e2e" "mastodon0-web"
        "test.mahout.anqou.net/role" "web";

      http_get "http://mastodon0-gateway.e2e.svc/health" |> ignore;
      check_mastodon_version ~host:"mastodon.test"
        ~endpoint:"http://mastodon0-gateway.e2e.svc" ~expected:"4.1.9";
      check_schema_migrations_count ~expected:395;
      ());

  apply_manifest "mastodon0-v4.2.0.yaml";

  eventually (fun () ->
      check_schema_migrations_count ~expected:417;
      ());

  eventually (fun () ->
      wait_deploy_available ~n:"e2e" "mastodon0-gateway-nginx";
      wait_deploy_available ~n:"e2e" "mastodon0-sidekiq";
      wait_deploy_available ~n:"e2e" "mastodon0-streaming";
      wait_deploy_available ~n:"e2e" "mastodon0-web";
      http_get "http://mastodon0-gateway.e2e.svc/health" |> ignore;
      check_mastodon_version ~host:"mastodon.test"
        ~endpoint:"http://mastodon0-gateway.e2e.svc" ~expected:"4.2.0";
      check_schema_migrations_count ~expected:422;
      ());

  apply_manifest "patched-gateway-nginx-conf.yaml";
  eventually (fun () ->
      let stdout, _ =
        http_get "http://mastodon0-gateway.e2e.svc/thisisanendpointfore2etest"
      in
      if stdout <> "THIS IS AN ENDPOINT FOR E2E TEST" then
        failwith "patched gateway nginx.conf doesn't work";

      let stdout, _ =
        kubectl
          {|get cm -n e2e -l mahout.anqou.net/mastodon=mastodon0 -o json | jq '.items | length'|}
      in
      let length = String.trim stdout in
      if length <> "1" then
        failwithf "old gateway nginx.conf is not removed: %s <> 1" length;

      ());

  (* Check that the age of a web Pod must be smaller than 90 seconds *)
  consistently (fun () ->
      let stdout, _ =
        kubectl
          {|get pod -n e2e -l app.kubernetes.io/component=web -o json | jq -r '.items[].metadata.creationTimestamp'|}
      in
      let now = Ptime_clock.now () in
      let b =
        stdout |> String.split_on_char '\n'
        |> List.for_all (fun create ->
               if create = "" then true
               else
                 let t, _, _ = Ptime.of_rfc3339 create |> Result.get_ok in
                 let dur =
                   Ptime.diff now t |> Ptime.Span.to_int_s |> Option.get
                 in
                 dur < 90)
      in
      assert b);

  delete_manifest "mastodon0-v4.2.0.yaml";
  eventually (fun () ->
      wait_not_found ~n:"e2e" "deploy" "mastodon0-gateway-nginx";
      wait_not_found ~n:"e2e" "deploy" "mastodon0-sidekiq";
      wait_not_found ~n:"e2e" "deploy" "mastodon0-streaming";
      wait_not_found ~n:"e2e" "deploy" "mastodon0-web");

  ()
