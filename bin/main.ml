let () =
  Mahout.Logg.setup @@ fun () ->
  let open Cmdliner in
  let cmd =
    Cmd.(
      group (info "mahout")
        [
          v (info "controller")
            Term.(
              const Mahout.Cmd.controller
              $ Arg.(
                  value & Arg.opt string ""
                  & info
                      [ "gw-nginx-conf-templ-cm" ]
                      ~docv:"NAME"
                      ~doc:"gateway nginx.conf template ConfigMap name"));
        ])
  in
  exit (Cmd.eval cmd)
