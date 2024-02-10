type single =
  | Eq of string * string
  | NotEq of string * string
  | Exist of string
  | NotExist of string
  | In of string * string list
  | NotIn of string * string list

let string_of_single = function
  | Eq (k, v) -> k ^ "=" ^ v
  | NotEq (k, v) -> k ^ "!=" ^ v
  | Exist k -> k
  | NotExist k -> "!" ^ k
  | In (k, vs) -> k ^ " in (" ^ (vs |> String.concat ", ") ^ ")"
  | NotIn (k, vs) -> k ^ " notin (" ^ (vs |> String.concat ", ") ^ ")"

type t = single list

let to_string (l : t) = l |> List.map string_of_single |> String.concat ", "

let check (selector : t) (labels : (string * Yojson.Safe.t) list) : bool =
  let aux = function
    | Eq (key, value) -> List.assoc_opt key labels = Some (`String value)
    | NotEq (key, value) -> List.assoc_opt key labels <> Some (`String value)
    | Exist key ->
        labels |> List.find_opt (fun (key', _) -> key = key') |> Option.is_some
    | NotExist key ->
        labels |> List.find_opt (fun (key', _) -> key = key') |> Option.is_none
    | In (key, values) -> (
        match List.assoc_opt key labels with
        | Some (`String value) when List.mem value values -> true
        | _ -> false)
    | NotIn (key, values) -> (
        match List.assoc_opt key labels with
        | Some (`String value) when List.mem value values -> false
        | _ -> true)
  in
  selector |> List.for_all aux
