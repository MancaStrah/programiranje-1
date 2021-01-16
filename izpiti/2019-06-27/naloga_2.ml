(* 2. naloga *)

type najemnik = string ;;

type vrt = Obdelovan of najemnik
| Oddan of najemnik * (vrt * vrt list)
| Prost

(* a *)

let vrt_primer = Oddan ("Kovalevskaya", (Obdelovan "Galois", [Obdelovan "Lagrange"; Prost]))


(* b *)

let obdelovalec_vrta = function
  | Oddan (n, list) -> None
  | Prost -> None 
  | Obdelovan n -> Some n


(* c *)

let rec globina_oddajanja vrt = 
  let rec  check_list vrt_list =
  match vrt_list with
  | [] -> 0
  | x :: xs -> globina_oddajanja x + check_list xs
  in
  match vrt with
  | Prost -> 0
  | Obdelovan n -> 0 
  | Oddan (n, tuple) -> (
      match tuple with
      | (v, []) -> 1 + globina_oddajanja v 
      | (v, list) -> 1 + globina_oddajanja v + check_list list
    )

(* d *)

let rec v_uporabi vrt = 
  let rec  check_list vrt_list =
    match vrt_list with
    | [] -> false
    | x :: xs -> (v_uporabi x) || (check_list xs)
  in
  match vrt with
  | Obdelovan n -> true
  | Prost -> false 
  | Oddan (n, tuple) -> (
      match tuple with
      | (v, []) -> v_uporabi v
      | (v, list) -> (v_uporabi v) || (check_list list)
 )


(* e *)

let rec vsi_najemniki vrt = 
  let rec  check_list acc vrt_list =  
    match vrt_list with 
    | [] -> acc
    | x :: xs -> check_list ((vsi_najemniki x) @ acc) xs
  in
  match vrt with 
  | Prost -> []
  | Obdelovan n -> [n]
  | Oddan (n, tuple) -> (
      match tuple with
      | (v, []) -> n :: vsi_najemniki v
      | (v, list) -> n :: (vsi_najemniki v) @ check_list [] list
 )

(* f *)

let vsi_obdelovalci vrt = 
