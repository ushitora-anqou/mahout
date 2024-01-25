type _ conv_ty =
  | Id : Yojson.Safe.t conv_ty
  | Conv : (Yojson.Safe.t -> 'a) -> 'a conv_ty

type 'a t = { buf : Eio.Buf_read.t; conv : 'a conv_ty }

let consume body =
  let buf = Eio.Buf_read.of_flow body ~max_size:max_int in
  { buf; conv = Id }

(* NOTE: not persistent *)
let with_conv : type a b. (a -> b) -> a t -> b t =
 fun conv t ->
  match t.conv with
  | Id -> { t with conv = Conv conv }
  | Conv conv' -> { t with conv = Conv (fun x -> x |> conv' |> conv) }

let scan : type a. a t -> (a, [ `Msg of string ]) result =
 fun t ->
  match Eio.Buf_read.line t.buf with
  | exception Failure msg -> Error (`Msg msg)
  | exception End_of_file -> Error (`Msg "end of file")
  | exception Eio.Buf_read.Buffer_limit_exceeded -> assert false
  | json -> (
      let json = Yojson.Safe.from_string json in
      match t.conv with Id -> Ok json | Conv conv -> Ok (conv json))

let iter f t =
  let rec loop t =
    match scan t with
    | Error _ -> ()
    | Ok x ->
        f x;
        loop t
  in
  loop t
