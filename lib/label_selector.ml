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
