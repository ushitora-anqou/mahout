exception Process_status_error of Unix.process_status

let eventually ?(count = 3) ?(interval = 1) f =
  let rec loop i =
    try f () with
    | e when i = 0 -> raise e
    | _ ->
        Unix.sleep interval;
        loop (i - 1)
  in
  loop count

[@@@warning "-21"]

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
  match Unix.close_process_full (stdout_ch, stdin_ch, stderr_ch) with
  | WEXITED 0 -> (stdout, stderr)
  | status -> raise (Process_status_error status)

let wait_deploy_available name =
  try
    run_command
      ({|kubectl wait --for='condition=Available' --timeout=5s deploy |} ^ name)
    |> ignore
  with Process_status_error (Unix.WEXITED 1) ->
    failwith ("condition Available not met for deployments/" ^ name)

let http_get uri =
  run_command
    (Printf.sprintf {|kubectl exec -it deploy/toolbox -- curl --silent '%s'|}
       uri)

let () =
  eventually (fun () ->
      wait_deploy_available "mastodon-operator";
      wait_deploy_available "mastodon0-gateway-nginx";
      wait_deploy_available "mastodon0-sidekiq";
      wait_deploy_available "mastodon0-streaming";
      wait_deploy_available "mastodon0-web";
      http_get "http://mastodon0-gateway-svc.default.svc/health" |> ignore;
      ());
  ()
