(* 1. naloga, max 45 minut *)

(* a *)

let odstej_trojici (a , b, c) (x, y, z) =
	(a - x, b - y, c - z)

(* b *)

let rec max_rezultat_do_n f n = 
	if n = 0 then f 0
	else max (f n) (max_rezultat_do_n f (n - 1))


(* c *)

let pocisti_seznam opt_list =
	let rec pocisti acc = function
	| [] -> List.rev acc
	| None :: xs -> pocisti acc xs
	| Some x :: xs -> pocisti (acc :: x) xs
	in
	pocisti [] opt_list

(* d *)

let preveri_urejenost sez =
	let rec je_urejen = function
		| [] -> true
		| x :: [] -> true
		| x1 :: x2 :: xs -> x1 <= x2 && je_urejen (x2 :: xs)
	in 
	let lihi = List.filter (fun x -> x mod 2 = 1) list in 
	let sodi = List.filter (fun x -> x mod 2 = 0) list in 
	je_urejen sodi && je_urejen (List.rev lihi)


(*
	let rec poglej accs accl = function
	| [] -> (List.rev accs = List.sort accs && accl = List.sort accl)
	| x :: xs -> if x mod 2 = 0 then poglej (x :: accs) accl else pogleg accs (x :: accl)
	in 
	poglej [] [] sez
*)