(* 1. naloga *)

type complex = {re: float;  im: float}

(* a *)

let complex_add z w = 
  {re = (z.re +. w.re); im = (z.im +. w.im)}

(* b *)

let complex_conjugate z =
  {re = z.re; im = -. z.im}

(* c *)

let rec list_apply_either pred f g list =
  match list with
  | [] -> []
  | x :: xs -> (
    if (pred x) then (f x) :: list_apply_either pred f g xs 
    else
    (g x ) :: (list_apply_either pred f g xs)
  )

(* d *)

let rec eval_poly p n = 
  let rec aux p n sum = 
  let f x = n * x in
    match p with
    | [] -> sum
    | x :: xs -> (aux (List.map  f xs) n (sum + x))
  in
  aux p n 0;;




(* let p = [3; -2; 0; 1];;
let a = eval_poly p 0;;
let b = eval_poly p 3;; *)