let test_basics () = ()

let () =
  let open Alcotest in
  run "mahout" [ ("cases", [ test_case "basics" `Quick test_basics ]) ]
