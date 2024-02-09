exception Process_status_error of Unix.process_status * string * string

let or_true f = try f () with Process_status_error _ -> ()
let failwithf f = Printf.ksprintf failwith f

let eventually ?(count = 60) ?(interval = 5) f =
  let rec loop i =
    try f () with
    | e when i = 0 -> raise e
    | e ->
        Logs.err (fun m -> m "eventually: failed: %s" (Printexc.to_string e));
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
  Logs.info (fun m ->
      m "RUN: %s\nstdout: %s\nstderr: %s" (String.trim command)
        (String.trim stdout) (String.trim stderr));
  match Unix.close_process_full (stdout_ch, stdin_ch, stderr_ch) with
  | WEXITED 0 -> (stdout, stderr)
  | status -> raise (Process_status_error (status, stdout, stderr))

let kubectl args =
  let kubectl = Sys.getenv_opt "KUBECTL" |> Option.value ~default:"kubectl" in
  run_command (kubectl ^ " " ^ args)

let wait_available kind condition name =
  try
    kubectl
      (Printf.sprintf {|wait --for='condition=%s' --timeout=1s %s %s|} condition
         kind name)
    |> ignore
  with Process_status_error (Unix.WEXITED 1, _, _) ->
    failwith ("condition Available not met for " ^ kind ^ "/" ^ name)

let wait_deploy_available name = wait_available "deploy" "Available" name
let wait_pod_available name = wait_available "pod" "Ready" name

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

let wait_not_found kind name =
  kubectl
    (Printf.sprintf {|get %s %s 2>&1 | grep "\"%s\" not found"|} kind name name)
  |> ignore

let setup () =
  or_true (fun () -> kubectl {|delete deploy mastodon-operator|} |> ignore);
  or_true (fun () -> kubectl {|delete mastodon mastodon0|} |> ignore);
  or_true (fun () -> delete_manifest "postgres.yaml" |> ignore);
  or_true (fun () -> delete_manifest "redis.yaml" |> ignore);
  or_true (fun () -> apply_manifest "postgres.yaml");
  or_true (fun () -> apply_manifest "redis.yaml");
  or_true (fun () -> apply_manifest "operator.yaml");
  eventually (fun () -> wait_pod_available "postgres-0");
  eventually (fun () -> wait_pod_available "redis-0");
  eventually (fun () -> wait_deploy_available "mastodon-operator");
  ()

let () =
  Mahout.Logg.setup ();
  setup ();

  apply_manifest "mastodon0-v4.1.9.yaml";

  eventually (fun () ->
      wait_deploy_available "mastodon0-gateway-nginx";
      wait_deploy_available "mastodon0-sidekiq";
      wait_deploy_available "mastodon0-streaming";
      wait_deploy_available "mastodon0-web";
      http_get "http://mastodon0-gateway-svc.default.svc/health" |> ignore;
      check_mastodon_version ~host:"mastodon0.ket-apps.test"
        ~endpoint:"http://mastodon0-gateway-svc.default.svc" ~expected:"4.1.9";
      ());

  apply_manifest "mastodon0-v4.2.0.yaml";

  eventually (fun () ->
      wait_deploy_available "mastodon0-gateway-nginx";
      wait_deploy_available "mastodon0-sidekiq";
      wait_deploy_available "mastodon0-streaming";
      wait_deploy_available "mastodon0-web";
      http_get "http://mastodon0-gateway-svc.default.svc/health" |> ignore;
      check_mastodon_version ~host:"mastodon0.ket-apps.test"
        ~endpoint:"http://mastodon0-gateway-svc.default.svc" ~expected:"4.2.0";
      ());

  delete_manifest "mastodon0-v4.2.0.yaml";
  eventually (fun () ->
      wait_not_found "deploy" "mastodon0-gateway-nginx";
      wait_not_found "deploy" "mastodon0-sidekiq";
      wait_not_found "deploy" "mastodon0-streaming";
      wait_not_found "deploy" "mastodon0-web");

  ()
