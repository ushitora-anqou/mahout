let test_label_selector_eq () =
  let open Mahout.Label_selector in
  assert (check [ Eq ("hoge", "piyo") ] [ ("hoge", `String "piyo") ]);
  assert (not (check [ Eq ("hoge", "piyo") ] []));
  ()

let test_label_selector_noteq () =
  let open Mahout.Label_selector in
  assert (check [ NotEq ("hoge", "piyo") ] [ ("hoge", `String "fuga") ]);
  assert (check [ NotEq ("hoge", "piyo") ] []);
  ()

let test_label_selector_exist () =
  let open Mahout.Label_selector in
  assert (check [ Exist "hoge" ] [ ("hoge", `String "piyo") ]);
  assert (not (check [ Exist "hoge" ] []));
  ()

let test_label_selector_notexist () =
  let open Mahout.Label_selector in
  assert (not (check [ NotExist "hoge" ] [ ("hoge", `String "fuga") ]));
  assert (check [ NotExist "hoge" ] []);
  ()

let test_label_selector_in () =
  let open Mahout.Label_selector in
  assert (check [ In ("hoge", [ "piyo" ]) ] [ ("hoge", `String "piyo") ]);
  assert (not (check [ In ("hoge", [ "piyo" ]) ] []));
  ()

let test_label_selector_notin () =
  let open Mahout.Label_selector in
  assert (check [ NotIn ("hoge", [ "piyo" ]) ] [ ("hoge", `String "fuga") ]);
  assert (check [ NotIn ("hoge", [ "piyo" ]) ] []);
  ()

let test_reconciler_runqueue () =
  let open Mahout.Reconciler.Runqueue in
  Eio_main.run @@ fun env ->
  let rq = create () in
  let now = Eio.Time.now (Eio.Stdenv.clock env) in
  push rq ~deadline:(now +. 0.5) 2;
  push rq ~deadline:now 1;
  assert ([ 1 ] = take ~protect:true env rq);
  assert ([ 2 ] = take ~protect:true env rq);
  ()

let () =
  let open Alcotest in
  run "mahout"
    [
      ( "label_selector",
        [
          test_case "eq" `Quick test_label_selector_eq;
          test_case "noteq" `Quick test_label_selector_noteq;
          test_case "exist" `Quick test_label_selector_exist;
          test_case "notexist" `Quick test_label_selector_notexist;
          test_case "in" `Quick test_label_selector_in;
          test_case "notin" `Quick test_label_selector_notin;
        ] );
      ("reconciler", [ test_case "runqueue" `Quick test_reconciler_runqueue ]);
    ]
