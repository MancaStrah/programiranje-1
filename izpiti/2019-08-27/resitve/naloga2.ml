type 'a gnezdenje = 
  | Element of 'a
  | Podseznam of 'a gnezdenje list

(* a *)

let gnezdenje_pruner = 
	[
		Element 1;
		Element 2; 
		Podseznam [
			Element 3;
			Podseznam [Element 4];
			Podseznam [];
		]
		Podseznam [Element 5]
	]


(* b *)

let rec najvecja_globina = function
	| [] -> 1
	| Element x :: gnezdenja ->
		max 1 (najvecja_globina gnezdenja)
	| Podseznam sez_gnezdenj :: gnezdenja -> max (1 + najvecja_globina sez_gnezdenj) 
		(najvecja_globina gnezdenja)


(* c *)

let preslikaj f = function
	| [] -> []
	| Element x :: gnezdenje -> Element (f x) :: preslikaj f gnezdenje
	| Podseznam sez :: gnezdenje -> Podseznam (preslikaj f sez) :: preslikaj f gnezdenje

(* 
Ohranjati mora tipe. Na to naj bo človek pozoren, on bi tukaj morda 
naredil kar navaden seznam. Ojoj.  
*)

(* d *)

let splosci sez = 
	| [] -> [] 
	| Element x :: gnezdenje -> x :: splosci gnezdenje
	| Podseznam sez :: gnezdenje -> (splosci sez) @ splosci gnezdenje

(* e *)

let rec alternirajoci_konstruktorji = function
	| [] | _ __ [] -> true
	| Element _ :: Podseznam sezz :: gnezdenje -> alternirajoci_konstruktorji (Podseznam sez :: gnezdenje)
	| Podseznam _ :: Element x :: gnezdenje -> alternirajoci_konstruktorji (Element x :: gnezdenje)
	| Element _ :: Element _ :: _ 
	| Podseznam _ :: Podseznam _ :: _ -> false

(* f *)

let rec zlozi_preko_gnezdenja f acc sez = 
	sez |> splosci |> List.fold_left f acc


(* Bolj kot zanimivost, repno rekurzivno *)
let rec zlozi_preko_gnezdenja_fancy f acc sez = 
	let rec zlozi acc todo_list 


