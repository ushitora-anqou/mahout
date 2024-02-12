let now () = Ptime.to_float_s (Ptime.v (Pclock.now_d_ps ()))

let to_rfc3339 unix_time =
  let time = Option.get (Ptime.of_float_s unix_time) in
  let fraction = fst (modf unix_time) *. 1000. in
  let clamped_fraction = if fraction > 999. then 999. else fraction in
  let (y, m, d), ((hh, mm, ss), _tz_offset_s) = Ptime.to_date_time time in
  Printf.sprintf "%04d-%02d-%02dT%02d:%02d:%02d.%03.0fZ" y m d hh mm ss
    clamped_fraction

let string_of_level = function
  | Logs.App -> ""
  | Logs.Error -> "ERROR"
  | Logs.Warning -> "WARN"
  | Logs.Info -> "INFO"
  | Logs.Debug -> "DEBUG"

type _ Effect.t += Trace : string Effect.t

let setup_trace ~enable f =
  Effect.(
    Deep.(
      try_with f ()
        {
          effc =
            (fun (type a) (e : a t) ->
              match e with
              | Trace ->
                  Some
                    (fun (k : (a, _) continuation) ->
                      let bt =
                        if enable then
                          Printexc.raw_backtrace_to_string (get_callstack k 100)
                        else "not enabled"
                      in
                      continue k bt)
              | _ -> None);
        }))

let log_json ?(print_trace = false) ~formatter level f : unit =
  f (fun msg args ->
      let args =
        ("time", `String (now () |> to_rfc3339))
        :: ("level", `String (string_of_level level))
        :: ("msg", `String msg)
        :: args
      in
      let args =
        if print_trace then ("trace", `String (Effect.perform Trace)) :: args
        else args
      in
      `Assoc args |> Yojson.Safe.to_string |> Format.fprintf formatter "%s@.")

let json_reporter ~formatter =
  (* Thanks to: https://github.com/aantron/dream/blob/8140a600e4f9401e28f77fee3e4328abdc8246ef/src/server/log.ml#L110 *)
  let report src level ~over k user's_callback =
    user's_callback @@ fun ?header:_ ?tags:_ format_and_arguments ->
    let buffer = Buffer.create 512 in
    let f = Fmt.with_buffer ~like:Fmt.stderr buffer in
    Format.kfprintf
      (fun _ ->
        Format.pp_print_flush f ();
        let msg = Buffer.contents buffer in
        let name = Logs.Src.name src in
        Buffer.reset buffer;
        log_json ~formatter level (fun m ->
            m msg [ ("src.name", `String name) ]);
        over ();
        k ())
      f format_and_arguments
  in
  { Logs.report }

(*
let pretty_reporter ~formatter ?(src_width = 5) () =
  (* Thanks to: https://github.com/aantron/dream/blob/8140a600e4f9401e28f77fee3e4328abdc8246ef/src/server/log.ml#L110 *)
  let report src level ~over k user's_callback =
    let level_style, level =
      match level with
      | Logs.App -> (`Fg `White, "     ")
      | Logs.Error -> (`Fg `Red, "ERROR")
      | Logs.Warning -> (`Fg `Yellow, "WARN ")
      | Logs.Info -> (`Fg `Green, "INFO ")
      | Logs.Debug -> (`Fg `Blue, "DEBUG")
    in
    user's_callback @@ fun ?header ?tags format_and_arguments ->
    ignore header;
    ignore tags;
    let time = now () |> to_rfc3339 in
    let source =
      let width = src_width in
      if Logs.Src.name src = Logs.Src.name Logs.default then
        String.make width ' '
      else
        let name = Logs.Src.name src in
        if String.length name > width then
          String.sub name (String.length name - width) width
        else String.make (width - String.length name) ' ' ^ name
    in
    let source_prefix, source =
      try
        let dot_index = String.rindex source '.' + 1 in
        ( String.sub source 0 dot_index,
          String.sub source dot_index (String.length source - dot_index) )
      with Not_found -> ("", source)
    in
    Format.kfprintf
      (fun _ ->
        over ();
        k ())
      formatter
      ("%a %a%s %a @[" ^^ format_and_arguments ^^ "@]@.")
      Fmt.(styled `Faint string)
      time
      Fmt.(styled `White string)
      source_prefix source
      Fmt.(styled level_style string)
      level
  in
  { Logs.report }
*)

let formatter = Fmt.stdout

let setup ?(enable_trace = true) f =
  Fmt.set_style_renderer formatter `Ansi_tty;
  Logs.set_reporter (json_reporter ~formatter);
  Logs.set_level (Some Logs.Info);
  setup_trace ~enable:enable_trace f

let info ?print_trace = log_json ?print_trace ~formatter Logs.Info
let err ?print_trace = log_json ?print_trace ~formatter Logs.Error
let warn ?print_trace = log_json ?print_trace ~formatter Logs.Warning
let debug ?print_trace = log_json ?print_trace ~formatter Logs.Debug
