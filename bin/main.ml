let () =
  Mahout.Logg.setup ();

  (* Initialize PRNG *)
  (try Unix.getenv "RANDOM_INIT" |> int_of_string |> Random.init
   with Not_found -> Random.self_init ());

  let open Cmdliner in
  let cmd =
    Cmd.(
      group (info "mahout")
        [
          v (info "controller") Term.(const Mahout.Cmd.controller $ const ());
          v (info "check-env")
            Term.(
              const Mahout.Cmd.check_env
              $ Arg.(required & pos 0 (some string) None & info ~docv:"NAME" [])
              $ Arg.(
                  required
                  & pos 1 (some string) None
                  & info ~docv:"NAMESPACE" []));
        ])
  in
  exit (Cmd.eval cmd)
