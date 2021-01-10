(* ========== Vaja 2: Funkcijsko Programiranje  ========== *)

(*----------------------------------------------------------------------------*]
Namig: Definirajte pomožno funkcijo za obračanje seznamov.
[*----------------------------------------------------------------------------*)

(*Slabo, zelo počasno.*)
let rec bad_reverse = function
  | [] -> [] 
  | x :: xs -> bad_reverse xs @ [x]


let rec reverse list =
  let rec reverse_aux acc list =
    match list with
    | [] -> acc
    | x :: xs -> reverse_aux (x :: acc) xs 
  in
  reverse_aux [] list


(*----------------------------------------------------------------------------*]
 Funkcija [repeat x n] vrne seznam [n] ponovitev vrednosti [x]. Za neprimerne
 vrednosti [n] funkcija vrne prazen seznam.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # repeat "A" 5;;
 - : string list = ["A"; "A"; "A"; "A"; "A"]
 # repeat "A" (-2);;
 - : string list = []
[*----------------------------------------------------------------------------*)

let rec repeat x n =  
  if n <= 0 then 
    [] 
  else 
    x :: repeat x (n - 1)

let rec repeat_tlrec x n =
  let rec aux x n acc = 
    if n <= 0 then
      acc
    else
      aux x (n -1) (x :: acc)
  in 
  aux x n []
(*----------------------------------------------------------------------------*]
 Funkcija [range] sprejme število in vrne seznam vseh celih števil od 0 do
 vključno danega števila. Za neprimerne argumente funkcija vrne prazen seznam.
 Funkcija je repno rekurzivna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # range 10;;
 - : int list = [0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
[*----------------------------------------------------------------------------*)

let rec bad_range n = 
  if n < 0 then
    []
  else 
    bad_range (n - 1) @ [n]


let rec range n = 
  let rec range_reverse n = if n < 0 then [] else n :: range_reverse (n -1) in
  n |> range_reverse |> reverse

(*----------------------------------------------------------------------------*]
 Funkcija [map f list] sprejme seznam [list] oblike [x0; x1; x2; ...] in
 funkcijo [f] ter vrne seznam preslikanih vrednosti, torej
 [f x0; f x1; f x2; ...].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # let plus_two = (+) 2 in
   map plus_two [0; 1; 2; 3; 4];;
 - : int list = [2; 3; 4; 5; 6]
[*----------------------------------------------------------------------------*)

let rec map f = function
  | [] -> []
  | x :: xs -> f x :: map f xs

(*----------------------------------------------------------------------------*]
 Funkcija [map_tlrec] je repno rekurzivna različica funkcije [map].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # let plus_two = (fun x -> x + 2) in
   map_tlrec plus_two [0; 1; 2; 3; 4];;
 - : int list = [2; 3; 4; 5; 6]
[*----------------------------------------------------------------------------*)

let rec map_tlrec f list = 
  let rec map_aux acc = function
    | [] -> reverse acc
    | x :: xs -> map_aux (f x :: acc) xs
  in 
  map_aux [] list 
(*----------------------------------------------------------------------------*]
 Funkcija [mapi] je ekvivalentna python kodi:

  def mapi(f, list):
      mapi_list = []
      index = 0
      for x in list:
          mapi_list += [f(x, index)]
          index += 1
      return mapi_list

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # mapi (+) [0; 0; 0; 2; 2; 2];;
 - : int list = [0; 1; 2; 5; 6; 7]
[*----------------------------------------------------------------------------*)

let rec mapi f list =
  (* f je funkcija dveh argumentov *)
  let rec mapi_aux i acc = function
    | [] -> reverse acc
    | x :: xs -> mapi_aux (i + 1) (f x i :: acc) xs
  in 
  mapi_aux 0 [] list

(*----------------------------------------------------------------------------*]
 Funkcija [zip] sprejme dva seznama in vrne seznam parov istoležnih
 elementov podanih seznamov. Če seznama nista enake dolžine vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # zip [1; 1; 1; 1] [0; 1; 2; 3];;
 - : (int * int) list = [(1, 0); (1, 1); (1, 2); (1, 3)]
 # zip [1; 1; 1; 1] [1; 2; 3; 4; 5];;
 Exception: Failure "Different lengths of input lists.".
[*----------------------------------------------------------------------------*)

let rec zip list1 list2 = 
  match list1 with 
  | x :: xs -> (
    match list2 with 
     | y :: ys -> (x, y) :: zip xs ys
     | [] -> failwith "Different lengths of input lists." )
  | [] -> (
    match list2 with
      | y :: ys -> failwith "Different lengths of input lists."
      | [] -> [] )

let rec zip list1 list2 = 
  match list1, list2 with 
    | x :: xs, y :: ys -> (x, y) :: zip xs ys
    | x :: xs, [] -> failwith "Different lengths of input lists."
    | [], y :: ys -> failwith "Different lengths of input lists."
    | [], [] -> []


let rec zip list1 list2 = 
  match list1, list2 with 
    | x :: xs, y :: ys -> (x, y) :: zip xs ys
    | _ :: _, [] | [], _ :: _ -> failwith "Different lengths of input lists."
    | [], [] -> []    

let rec zip list1 list2 = 
  match list1, list2 with 
    | x :: xs, y :: ys -> (x, y) :: zip xs ys
    | [], [] -> []   
    | _ -> failwith "Different lengths of input lists."

let rec zip list1 list2 = 
  let rec zip_tlrec acc list1 list2 = 
    match list1, list2 with
      | x :: xs, y :: ys -> zip_tlrec ((x,y) :: acc) xs ys
      | [], [] -> reverse acc
      | _ -> failwith "Different lengths of input lists."
  in 
zip_tlrec [] list1 list2

(*----------------------------------------------------------------------------*]
 Funkcija [unzip] je inverz funkcije [zip], torej sprejme seznam parov
 [(x0, y0); (x1, y1); ...] in vrne par seznamov ([x0; x1; ...], [y0; y1; ...]).
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # unzip [(0,"a"); (1,"b"); (2,"c")];;
 - : int list * string list = ([0; 1; 2], ["a"; "b"; "c"])
[*----------------------------------------------------------------------------*)

let rec unzip = function
  | [] -> ([], [])
  | xy :: xys ->
    let (x, y) = xy in 
    let (xs, ys) = unzip xys in 
    (x :: xs, y :: ys)

(*----------------------------------------------------------------------------*]
 Funkcija [unzip_tlrec] je repno rekurzivna različica funkcije [unzip].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # unzip_tlrec [(0,"a"); (1,"b"); (2,"c")];;
 - : int list * string list = ([0; 1; 2], ["a"; "b"; "c"])
[*----------------------------------------------------------------------------*)

let rec unzip_tlrec list = 
  let rec unzip_aux xacc yacc = function
    | (x, y) :: xys -> unzip_aux ( x :: xacc) ( y :: yacc) xys  
    | [] -> (reverse xacc, reverse yacc)
  in 
  unzip_aux [] [] list


(*----------------------------------------------------------------------------*]
 Funkcija [loop condition f x] naj se izvede kot python koda:

  def loop(condition, f, x):
      while condition(x):
          x = f(x)
      return x

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # loop (fun x -> x < 10) ((+) 4) 4;;
 - : int = 12
[*----------------------------------------------------------------------------*)

let rec loop condition f x =
  if condition x then
    let x' = f x in 
    loop condition f x' 
  else
    x

(*----------------------------------------------------------------------------*]
 Funkcija [fold_left_no_acc f list] sprejme seznam [x0; x1; ...; xn] in
 funkcijo dveh argumentov [f] in vrne vrednost izračuna
 f(... (f (f x0 x1) x2) ... xn).
 V primeru seznama z manj kot dvema elementoma vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # fold_left_no_acc (^) ["F"; "I"; "C"; "U"; "S"];;
 - : string = "FICUS"
[*----------------------------------------------------------------------------*)

let rec fold_left_no_acc f list = 
  match list with
    | [] -> failwith "List too short!"
    | x :: xs ->
      match xs with
        |[] -> x
        | y :: ys -> fold_left_no_acc f ((f x y) :: ys)


let rec fold_left_no_acc' f list =
  match list with
    | [] | _ :: [] -> failwith "Napaka."
    | x0 :: x1 :: xs ->
      if xs = [] then 
        f x0 x1
      else 
        fold_left_no_acc' f ((f x0 x1) :: xs)

(*----------------------------------------------------------------------------*]
 Funkcija [apply_sequence f x n] vrne seznam zaporednih uporab funkcije [f] na
 vrednosti [x] do vključno [n]-te uporabe, torej
 [x; f x; f (f x); ...; (f uporabljena n-krat na x)].
 Funkcija je repno rekurzivna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # apply_sequence (fun x -> x * x) 2 5;;
 - : int list = [2; 4; 16; 256; 65536; 4294967296]
 # apply_sequence (fun x -> x * x) 2 (-5);;
 - : int list = []
[*----------------------------------------------------------------------------*)

let rec apply_sequence f x n = 
  let rec apply_aux acc f x n = 
    if n < 0 then 
      reverse acc
    else 
      let x' = f x in 
      apply_aux (x :: acc) f x' (n - 1) 
  in 
apply_aux [] f x n

(*----------------------------------------------------------------------------*]
 Funkcija [filter f list] vrne seznam elementov [list], pri katerih funkcija [f]
 vrne vrednost [true].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # filter ((<)3) [0; 1; 2; 3; 4; 5];;
 - : int list = [4; 5]
[*----------------------------------------------------------------------------*)

let rec filter f list =
  let rec filter_aux f acc list = 
    match list with
      | [] -> reverse acc
      | x :: xs ->
        if f x then 
          (filter_aux f (x :: acc) xs) 
        else 
          (filter_aux f acc xs)
  in 
filter_aux f [] list


let rec filter f = function
  | [] -> []
  | x :: xs -> if f x then x :: (filter f xs) else filter f xs
(*----------------------------------------------------------------------------*]
 Funkcija [exists] sprejme seznam in funkcijo, ter vrne vrednost [true] čim
 obstaja element seznama, za katerega funkcija vrne [true] in [false] sicer.
 Funkcija je repno rekurzivna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # exists ((<) 3) [0; 1; 2; 3; 4; 5];;
 - : bool = true
 # exists ((<) 8) [0; 1; 2; 3; 4; 5];;
 - : bool = false
[*----------------------------------------------------------------------------*)

let rec exists f list = 
  match list with 
  | [] -> false
  | x :: xs -> 
    if f x then true else exists f xs

(*----------------------------------------------------------------------------*]
 Funkcija [first f default list] vrne prvi element seznama, za katerega
 funkcija [f] vrne [true]. Če takšnega elementa ni, vrne [default].
 Funkcija je repno rekurzivna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # first ((<) 3) 0 [1; 1; 2; 3; 5; 8];;
 - : int = 5
 # first ((<) 8) 0 [1; 1; 2; 3; 5; 8];;
 - : int = 0
[*----------------------------------------------------------------------------*)

let rec first f default list = 
  match list with 
  | [] -> default
  | x :: xs -> 
    if f x then x else first f default xs