type ('a, 'b) t = Empty | Node of 'a * 'b * ('a, 'b) t * ('a, 'b) t

let empty = Empty

let rec insert queue prio elt =
  match queue with
  | Empty -> Node (prio, elt, Empty, Empty)
  | Node (p, e, left, right) ->
      if prio <= p then Node (prio, elt, insert right p e, left)
      else Node (p, e, insert right prio elt, left)

exception Queue_is_empty

let rec remove_top = function
  | Empty -> raise Queue_is_empty
  | Node (_prio, _elt, left, Empty) -> left
  | Node (_prio, _elt, Empty, right) -> right
  | Node
      ( _prio,
        _elt,
        (Node (lprio, lelt, _, _) as left),
        (Node (rprio, relt, _, _) as right) ) ->
      if lprio <= rprio then Node (lprio, lelt, remove_top left, right)
      else Node (rprio, relt, left, remove_top right)

let extract = function
  | Empty -> raise Queue_is_empty
  | Node (prio, elt, _, _) as queue -> (prio, elt, remove_top queue)
