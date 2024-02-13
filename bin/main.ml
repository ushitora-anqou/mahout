let () =
  Mahout.Logg.setup @@ fun () ->
  (* Initialize PRNG *)
  (try Unix.getenv "RANDOM_INIT" |> int_of_string |> Random.init
   with Not_found -> Random.self_init ());

  let open Cmdliner in
  let cmd =
    Cmd.(
      group (info "mahout")
        [ v (info "controller") Term.(const Mahout.Cmd.controller $ const ()) ])
  in
  exit (Cmd.eval cmd)
