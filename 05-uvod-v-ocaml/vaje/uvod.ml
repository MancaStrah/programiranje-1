(* ========== Vaja 1: Uvod v OCaml  ========== *)
 
(*----------------------------------------------------------------------------*]
 Funkcija [square] vrne kvadrat podanega celega števila.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # square 2;;
 - : int = 4
[*----------------------------------------------------------------------------*)

let rec square x = x * x

let square x = x * x

(* let square = x -> x * x *)

(*----------------------------------------------------------------------------*]
 Funkcija [middle_of_triple] vrne srednji element trojice.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # middle_of_triple (true, false, true);;
 - : bool = false
[*----------------------------------------------------------------------------*)

let rec middle_of_triple triple = 
	match triple with
	| (x, y, z) -> y

let middle_of_triple = function 
	(x, y, z) -> y

let middle_of_triple (_, y, _) = y


(*----------------------------------------------------------------------------*]
 Funkcija [starting_element] vrne prvi element danega seznama. V primeru
 prekratkega seznama vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # starting_element [1; 2; 3; 4];;
 - : int = 1
[*----------------------------------------------------------------------------*)

let rec starting_element list =
	match list with
	| [] -> failwith "Empty list has no starting element."
	| x :: xs -> x

let starting_element = function
	| [] -> failwith "Empty list has no starting element."
	| x :: xs -> x

let _ = assert (starting_element [1; 2; 3; 4] = 1)

(*----------------------------------------------------------------------------*]
 Funkcija [multiply] zmnoži vse elemente seznama. V primeru praznega seznama
 vrne vrednost, ki je smiselna za rekurzijo.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # multiply [2; 4; 6];;
 - : int = 48
[*----------------------------------------------------------------------------*)

let rec multiply list =
	match list with
	| [] -> 1
	| x :: xs -> x * multiply xs

(*----------------------------------------------------------------------------*]
 Napišite funkcijo ekvivalentno python kodi:

  def sum_int_pairs(pair_list):
      if len(pair_list) == 0:
        return []
      else:
        x, y = pair_list[0]
        return [x + y] + sum_int_pairs(pair_list[1:])

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # sum_int_pairs [(1, -2); (3, 4); (0, -0)];;
 - : int list = [-1; 7; 0]
[*----------------------------------------------------------------------------*)

let rec sum_int_pairs list =
	match list with
	| [] -> []
	| (x, y) :: xs -> x + y :: sum_int_pairs xs

let rec sum_int_pairs list =
	match list with
	| [] -> []
  | el :: els -> (
    match el with 
    | (x, y) -> (x + y) :: sum_int_pairs els
  )

let rec sum_int_pairs = function
	| [] -> []
  | (x, y) :: els -> (x + y) :: sum_int_pairs els
  
(*----------------------------------------------------------------------------*]
 Funkcija [get k list] poišče [k]-ti element v seznamu [list]. Številčenje
 elementov seznama (kot ponavadi) pričnemo z 0. Če je k negativen, funkcija
 vrne ničti element. V primeru prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # get 2 [0; 0; 1; 0; 0; 0];;
 - : int = 1
[*----------------------------------------------------------------------------*)

let rec get k list =
  if k <= 0 then 
    match list with 
      | []  -> failwith "List too short."
      | x :: xs -> x
  else
    match list with 
      | []  -> failwith "List too short."
      | x :: xs -> get (k - 1) xs

let rec get k list =
  match list with 
      | []  -> failwith "List too short."
      | x :: xs ->
        if k <= 0 then
          x
        else
          get (k-1) xs

	
(*----------------------------------------------------------------------------*]
 Funkcija [double] podvoji pojavitve elementov v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # double [1; 2; 3];;
 - : int list = [1; 1; 2; 2; 3; 3]
[*----------------------------------------------------------------------------*)

let rec double = function
	| [] -> []
	| x :: xs -> x :: x :: double xs

let rec double = function
	| [] -> []
	| x :: xs -> [x; x] @ double xs 
(* ta operator je precej počasnejši *)


(*----------------------------------------------------------------------------*]
 Funkcija [insert x k list] na [k]-to mesto seznama [list] vrine element [x].
 Če je [k] izven mej seznama, ga funkcija doda na začetek oziroma na konec.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # insert 1 3 [0; 0; 0; 0; 0];;
 - : int list = [0; 0; 0; 1; 0; 0]
 # insert 1 (-2) [0; 0; 0; 0; 0];;
 - : int list = [1; 0; 0; 0; 0; 0]
[*----------------------------------------------------------------------------*)

let rec insert x k list  = 
  match list with
  | [] -> [x]
  | y :: ys -> 
    if k <= 0 then
      k :: y :: ys
    else
      y :: (insert x (k - 1) ys)

(* Malo ekstra *)
let rec insert x k = function
  | [] -> [x]
  | y :: ys when k <= 0 -> x :: y :: ys
  | y :: ys (* when k > 0 *) -> y :: (insert x (k - 1) ys)

(*----------------------------------------------------------------------------*]
 Funkcija [divide k list] seznam razdeli na dva seznama. Prvi vsebuje prvih [k]
 elementov, drugi pa vse ostale. Funkcija vrne par teh seznamov. V primeru, ko
 je [k] izven mej seznama, je primeren od seznamov prazen.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # divide 2 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2], [3; 4; 5])
 # divide 7 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2; 3; 4; 5], [])
[*----------------------------------------------------------------------------*)

(* 
let rec divide k list = 
  match list with
  | [] -> ([], [])
  | x :: xs -> *)


(*----------------------------------------------------------------------------*]
 Funkcija [rotate n list] seznam zavrti za [n] mest v levo. Predpostavimo, da
 je [n] v mejah seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # rotate 2 [1; 2; 3; 4; 5];;
 - : int list = [3; 4; 5; 1; 2]
[*----------------------------------------------------------------------------*)

let rec rotate n list = 
  match list with
  | [] -> []
  | x :: xs -> 
    if n - 1 > 0 then rotate (n - 1) (xs @ [x]) else (xs @ [x]) 

(*----------------------------------------------------------------------------*]
 Funkcija [remove x list] iz seznama izbriše vse pojavitve elementa [x].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # remove 1 [1; 1; 2; 3; 1; 2; 3; 1; 1];;
 - : int list = [2; 3; 2; 3]
[*----------------------------------------------------------------------------*)

let rec remove x list = 
  match list with
    | [] -> []
    | y :: ys ->
      if y = x then remove x ys else y :: remove x ys

(*----------------------------------------------------------------------------*]
 Funkcija [is_palindrome] za dani seznam ugotovi ali predstavlja palindrom.
 Namig: Pomagaj si s pomožno funkcijo, ki obrne vrstni red elementov seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # is_palindrome [1; 2; 3; 2; 1];;
 - : bool = true
 # is_palindrome [0; 0; 1; 0];;
 - : bool = false
[*----------------------------------------------------------------------------*)

let rec is_palindrome list = 
  let rec reverse sez =
    match sez with
    | [] -> []
    | x :: xs -> (reverse xs) @ [x] in
  reverse list = list

(*----------------------------------------------------------------------------*]
 Funkcija [max_on_components] sprejme dva seznama in vrne nov seznam, katerega
 elementi so večji od istoležnih elementov na danih seznamih. Skupni seznam ima
 dolžino krajšega od danih seznamov.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # max_on_components [5; 4; 3; 2; 1] [0; 1; 2; 3; 4; 5; 6];;
 - : int list = [5; 4; 3; 3; 4]
[*----------------------------------------------------------------------------*)

let rec max_on_components list1 list2 = 
  match list1 with
    | [] -> []
    | x :: xs -> 
      match list2 with
      |[] -> []
      | y :: ys -> 
      if x > y then x :: max_on_components xs ys
      else y :: max_on_components xs ys


(*----------------------------------------------------------------------------*]
 Funkcija [second_largest] vrne drugo največjo vrednost v seznamu. Pri tem se
 ponovitve elementa štejejo kot ena vrednost. Predpostavimo, da ima seznam vsaj
 dve različni vrednosti.
 Namig: Pomagaj si s pomožno funkcijo, ki poišče največjo vrednost v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # second_largest [1; 10; 11; 11; 5; 4; 10];;
 - : int = 10
[*----------------------------------------------------------------------------*)

let largest list = 
  match list with 
  | [] -> failwith "List too short."
  | x :: xs ->


let rec second_largest list = ()
  







(* pogosta napaka
let rec x_is_in_list x = function
  | [] -> false
  | y :: ys when x = y -> true (*Tukaj ne smemo reči x :: xs, zato ker bi samo 
                                x na novo definiral*)
  | y :: ys -> x_is_in_list  *)