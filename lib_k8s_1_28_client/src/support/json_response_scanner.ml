type _ conv_ty =
  | Id : Yojson.Safe.t conv_ty
  | Conv : (Yojson.Safe.t -> 'a) -> 'a conv_ty

type 'a t = { body : Cohttp_eio.Body.t; conv : 'a conv_ty }

let make body = { body; conv = Id }

let with_conv : type a b. (a -> b) -> a t -> b t =
 fun conv t ->
  match t.conv with
  | Id -> { t with conv = Conv conv }
  | Conv conv' -> { t with conv = Conv (fun x -> x |> conv' |> conv) }

let scan : type a. a t -> a =
 fun t ->
  let json =
    Eio.Buf_read.(parse_exn line) t.body ~max_size:max_int
    |> Yojson.Safe.from_string
  in
  match t.conv with Id -> json | Conv conv -> conv json
