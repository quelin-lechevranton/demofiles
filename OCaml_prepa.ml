(* Fonctions recurrentes
Accumulateurs
Listes
Filtrages
Types
Constructeurs
Arbres
Pile
File
 *)

(* PREMIÈRE ANNÉE *)

(* ================================================================================= *)
(* ================================================================================= *)


(* CHAPITRE 1 : RÉCURSIVITÉ *)

(* exemple TD/TP *)

let rec factorielle n = 
	if n=0 then 1 
	else n*(factorielle (n-1))
;;

let rec pair n =
	if n=0 then true
	else impair (n-1)
	and 
	impair n =
	if n=0 then false 
	else pair (n-1)
;; 


(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 2 : LISTES ET FILTRAGE *)

(* [2,3] = (int * int) list *)
(* [2;3] = int list *)

let liste_vide = [] ;;
let l = [3;4] ;;
let m = 1::(2::l) ;; 

(* Les listes doivent être de type homogène *)

let n = [[3;5;3];[4]] ;;		(* type : int list list *)

List.hd l ;;			(* O(1) *)
List.tl l ;;			(* O(1) *)
List.length l ;;
let f x = x*2 in
List.map f l ;;
List.rev l ;;			(* O(n) miroir *)
List.append l m ;;		(* O(n) concaténation = l @ m *)




(* exemple TD/TP *)

let rec somme l =
	if l=[] then 0
	else List.hd l + (somme (List.tl l))
;;

let rec somme l = match l with
	| [] -> 0
	| t::q -> t + (somme q)
;;

let rec somme = function
	| [] -> 0
	| t::q -> t + (somme q)
;;

let rec concat l m = match l with
	| [] -> m
	| t::q -> t::(concat q m)
;;

let rec lecture l i = match l,i with 
	| t::_ , 0 -> t
	| _::q , n -> lecture q (n-1)
	| [] , _ -> failwith "indice hors limites"
;;

let miroir l = 
	let rec aux accu = function
		| [] -> accu 
		| t::q -> aux (t::accu) q
	in aux [] l
;;

let rec somme_mutliples n = function
	| [] -> 0
	| t::q when t mod n = 0 -> t + somme_mutliples n q
	| _::q -> somme_mutliples n q
;;

let rec supp_elements_egaux_consecutifs = function
	| [] -> []
	| t1::(t2::_ as q) when t1=t2 -> supp_elements_egaux_consecutifs q
	| t::q -> t::(supp_elements_egaux_consecutifs q)
;; 



(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 3 : TYPES ET ARBRES *)

(* Renommage de varible et forçage du type *)

type rationnel = int * int ;;
let r : rationnel = 1,3 ;;					 
let inverse_int_x_int r = snd r,fst r ;;
let inverse_rationnel (r : rationnel) : rationnel = snd r,fst r ;;

type complexe = float * float ;;
let j : complexe = -0.5 , sqrt 3./.2. ;;								
let norme (z : complexe) = let x , y = z in sqrt(x**2. +. y**2.) ;;

(* Types énumérés *)

(* les majuscules en début de mot sont réservées aux constructeurs *)

type meteo = Soleil | Nuageux | Pluie 

(* constructeurs non constants *)

type nombre = Entier of int | Reel of float

(* Piles et files *)

(* notion de pile : liste de valeurs sur laquelle on peut faire deux actions : 
on peut empiler ou dépiler un élément suivant la règle : le dernier arrivé est 
le premier sorti *)

(* notion de file : liste de valeurs sur laquelle on peut faire deux actions : 
on peut enfiler ou défiler un élément suivant la règle : le premier arrivé est
le premier sorti *)

(* Arbres binaires *)

type 'a arbre = | F of 'a | N of 'a arbre * 'a * 'a arbre ;;


(* exemple TD/TP *)

type arbre = | V | N of arbre * int * arbre ;;

let rec somme = function
	| V -> 0
	| N (d,x,g) -> somme d + x + somme g 
;;

let rec nbfeuille = function
	| V -> 0
	| N (V,_,V) -> 1
	| N (d,_,g) -> nbfeuille d + nbfeuille g 
;;



(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 4 : IMPÉRATIF *)

(* les variables Caml ne sont pas modifiables seulement remplaçables : 
s += 1 est impossible *)

(* Références *)

let a = ref 5;; 	(* référencement *)
!a;;				(* déréférecement *)
a := 6;;			(* modification *)
incr a;;			(* équivaut à : r:=!r+1 *)
decr a;;			(* équivaut à : r:=!r-1 *)

(* Boucles for *)

let s = ref 0;;
(* int ref = {contents = 0} *)
for k = 1 to 10 do s := !s + k done ; !s ;;		(* fin incluse ; pas = 1 *)
for k = 10 downto 1 do s := !s + k done ;;		(* pas = -1 *)

(* Boucles while *)

let s = ref 0 and k = ref 0 in 
while !s < 1000 do incr k ; s := !s + !k done ; !k ;; 

(* Tableaux *)

let t = [|3;4;6|];;
t.(2);;					(* accès à un élément : O(1) *)
t.(2) <- 5;;			(* idem *)
						(* ajout/retrait d'un élément et concaténation : O(n) *)

let s = t ;;			(* simple vue *)
let s = Array.copy t;;
s = t ;;				(* test d'une égalité structurelle ; négation : <> *)
s == t ;;				(* test d'une égalité physique ; négation : != *)
						(* s == t => (s = t) *)

(* https://caml.inria.fr/pub/docs/manual-ocaml/libref/Stdlib.Array.html *)
Array.length t;;
Array.make 8 0.;;
Array.to_list t;;
Array.of_list [3;4;5];;
Array.sub [|0;1;2;3;4;5;6;7;8;9|] 3 4;;		(* array indice_début longueur *)  
Array.append t s;;							(* concaténation : O(n) *)
Array.init 8 (let f x = x*2 in f);; 		(* [|f 0;f 1;...;f 8|] avec f : int -> 'a *)
let g x = float_of_int x/.2. in
Array.map g t;;								(* [|g (t.(0));g (t.(1));...|] avec g : 'a -> 'b *)
Array.mem 2 t;;								(* test d'appartenance *)

(* Matrices *)

let m = Array.make 3 (Array.make 4 0);;		(* matrice 3x4 avec ∀ k, m.(k) == m.(0) *)
let m = Array.make_matrix 3 4 0 ;;			(* int -> int -> 'a -> 'a array array *)

let copy_matrix m = 
	let n = Array.make (Array.length m) [||] in 
	for k=0 to Array.length m - 1 do n.(k) <- Array.copy m.(k) done ;
	n
;;


(* Chaînes de caractères *)

(* string : "hello" ; "h" 
   char	  : 'h' 	; ('hello' n'a pas de sens) *)

let s = "Hello World" ;;
s.[3] ;;

(* Les chaînes de caractères ne sont pas modifiables *)
let t = s ^ " !" ;;
String.sub s 6 5 ;;
String.make 4 'a' ^ "h" ;;		(* int -> char -> string *)


(* exemple TD/TP *)

(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 5 : TYPE ENREGISTREMENT *)

type date = { annee : int ; mois : int ; jour : int ; heure : int * int };;
let anniversaire = { annee = 2001 ; mois = 04 ; jour = 02 ; heure = 15,15 };;
anniversaire.annee;;


(* Variable Modifiable : ( les variables Caml ne sont pas modifiables ) *)

type complexe_modifiable = { mutable re : float ; mutable im : float };;
let j = { re = -1./.2. ; im = (sqrt 3.)/.2. };;
j;;
j.re <- j.re +. 1. ;;
j;;

(* ================================================================================= *)

(* Références et Enregistrement *)

type 'a reference = { mutable value : 'a };;
let referencement a = { value = a };;
let dereferencement ref_a = ref_a.value;;
let modification ref_a b = ref_a.value <- b;;

type rectmodif = { mutable longueur : int ; mutable largeur : int };;
let double r = r.longueur <- 2*r.longueur ; r.largeur <- 2*r.largeur;;
let rec double_liste_de_rectangle = function
	| [] -> []
	| t::q -> double t::(double_liste_de_rectangle q)
;;
let rec double_array_de_rectangle = function
	| [||] -> [||]
	| t -> for k=0 to Array.length t - 1 do double t.(k) done ; t
;; 

(* ================================================================================= *)

(* Fonction à effets de bord *)


(* la suite u(n+1) = 4u(n)(1-u(n)) avec u(0)∈(0,1) a un comportement chaotique *)
let tirage = 
	let x = ref (sqrt 0.5) in
	function () -> x:= 4.*.(!x)*.(1.-.(!x)) ; !x
;;

(* rectangle de dimensions aléatoires comprises entre 3 et n *)
let rect_alea n = { longueur = Random.int (n-2) + 3 ; largeur = Random.int (n-2) + 3 } ;;


(* exemple TD/TP *)

type compalg = { re : float ; im : float };;
type comptrig = { modu : float ; arg : float };;
type complexe = Alg of compalg | Trig of comptrig;;
let abs = function
	| Trig z -> z.modu
	| Alg z -> sqrt (z.re**2. +. z.im**2.)
;;

type rectangle = { longueur : int ; largeur : int };;
let aire r = r.longueur * r.largeur ;;
let rec somme_aire_liste = function
	| [] -> 0
	| t::q -> aire t + (somme_aire_liste q)
;;

type 'a file = { mutable sommet : int ; mutable lgr : int ; mutable elements : 'a list ; lgrmax : int };;
let test = { sommet = 2 ; lgr = 2 ; elements = [3;4] ; lgrmax = 8 };;
let est_vide = function
  | f when f.lgr = 0 -> true
  | _ -> false
;;
let cree_file l n = { sommet = 0 ; lgr = 1 ; elements = [l] ; lgrmax = n } ;;
let enfile a = function 
  | f when f.lgr = f.lgrmax -> failwith "file pleine"
  | f -> if f.sommet=0 then f.sommet <- f.lgrmax - 1 
  		else f.sommet <- f.sommet - 1 ; f.lgr <- f.lgr + 1 ; f.elements <- a::(f.elements) 
;; 



(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 6 : PREUVE PAR INDUCTION *)

(* type 'a arbre = | V | N of 'a arbre * 'a * 'a arbre;; *)

(* Théorème (admis) : 
P(V) ∧ ( ∀ (d,g) un couple de 'a arbre, ∀ e de type 'a, P(d) ∧ P(g) => P(N(d,e,g)) )
=> ∀ x un 'a arbre, P(x) *)


(* exemple TD/TP *)

(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 7 : ALGORITHME DE TRI ET COMPLEXITÉ *)

(* conserve les différences en abaissant la valeur minimale à zéro *)
let partir_de_0 t = 
	let min=ref t.(0) in
	let n=Array.length t in
	for k=0 to n-1 do let a=t.(k) in if a < !min then min:=a done ;
	for k=0 to n-1 do t.(k) <- t.(k) - !min done  
;;

let tri_insertion l =
	let rec insertion x = function
		| [] -> [x]
		| t::q when x > t -> t::(insertion x q)
		| m -> x::m
	in let rec tri accu = function
		| [] -> accu
		| t::q -> tri (insertion t accu) q
	in tri [] l
;; 

let rec tri_partition_fusion = function 
		| [] -> []
		| [x] -> [x]
		| l -> let rec partition = function
					| [] -> [],[]
					| [x] -> [x],[]
					| t1::t2::q -> let l1,l2 = partition q in t1::l1,t2::l2
				in let rec fusion = function
					| l1,[] -> l1
					| [],l2 -> l2
					| t1::q1,(t2::_ as l2) when t1 < t2 -> t1::(fusion (q1,l2))
					| l1,t2::q2 -> t2::(fusion (q2,l1))
				in let l1,l2 = partition l in fusion (tri_partition_fusion l1,tri_partition_fusion l2)		 
;;

let rech_dichotomique x l =
	let rec aux a b = 
		if b-a<2 then l.(a)=x 
		else match (b-a)/2 with
			| m when m=a -> false
			| m when l.(m)=x -> true
			| m when l.(m)>x -> aux a m				(* a revoir !!! *)
			| m when l.(m)<x -> aux m b
			| _ -> failwith "erreur"
	in aux 0 (Array.length l)
;;

(* exemple TD/TP *)



(* ================================================================================= *)
(* ================================================================================= *)

(* NOTES *)

let a=1 and b=2 in a+b = 
let c=1 in let d=2 in c+d;;	 (* contexte = { c <- 1 , d <- 2 } *)


let a = 5 in a+3 ;;		(* a est une variable locale ne modifiant pas le a déjà existant *)
let b = 5 ;;			(* b est une variable globale remplaçant le b déjà existant *)
b+3 ;;		

4.**5. ;;				(* l'exponentiation n'existe que pour les ints ; cf TP .... pour implémentation pour les int *)
(* ????????????????????????????????????????????????????????????????????????????????????? *)


ignore (b+4) ; b ;;		(* ignore une expression de type quelconque et la considère de type unit *)

(* concaténation liste : @ ; string : ^ *)

(* égalité structurelle : = ; <> ;; égalité physique == ; != *)

(* l'équivalent de (+) pour * ? *)


(* logique : && not ... ? *)


(* ================================================================================= *)
(* ================================================================================= *)

(* DEUXIÈME ANNÉE *)

(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 1 : ARBRES *)

(* Arbres Binaires de Recherche *)

(* Définition : arbre binaire tel que si A=N(g,x,d)
alors toute étiquette de g est inférieure ou égale à x et
toute étiquette de d est supéireure ou égale à x. *)

type arbre = | Vide | N of arbre * int * arbre

let rec recherche_ABR x = function
	| Vide -> false
	| N(_,y,_) when x=y -> true
	| N(_,y,d) when x>y -> recherche_ABR x d
	| N(g,_,_) -> recherche_ABR x g
;; (* O(hauteur de l'arbre) *)

let rec insertion_ABR x = function
	| Vide -> N(Vide,x,Vide)
	| N(g,y,d) when x>y -> N(g,y,insertion_ABR x d)
	| N(g,y,d) when x<y -> N(insertion_ABR x g,y,d)
	| a -> a
;; (* O(hauteur de l'arbre) *)

let rec suppression_ABR x arbre =
	let rec recherche_max = function
		| Vide -> failwith "erreur"
		| N(g,y,Vide) -> y,g
		| N(g,y,d) -> let max,arb = recherche_max d in max,N(g,y,arb)  
	in let supprime_racine = function
		| Vide -> Vide 
		| N(g,y,d) -> let max,arb = recherche_max g in N(arb,max,d)
	in match arbre with 
		| Vide -> Vide
		| N(g,y,d) when x>y -> N(g,y,suppression_ABR x d)
		| N(g,y,d) when x<y -> N(suppression_ABR x g,x,d)
		| N(_,y,_) as a when x=y -> supprime_racine a
		| a -> a
;; (* O(hauteur de l'arbre) *)


(* ================================================================================= *)

(* Tas et Liste de priorité *)

(* Définition : un tas est un arbre binaire tel que 
les feuilles sont de profondeur h ou h-1, 
Tous les noeuds de profondeur h sont à gauche,
∀p<h, il y a 2^p noeud de hauteur p,
chaque noeud à une étiquette ≥ à celles de ses fils. *)

(* Imprémentation : tableau d'entiers longeur quelconque suffisante, 
le première élément est la taille du tas,
t.(1) est la racine,
l'étiquette du fils gauche de t.(k) est t.(2*k),
l'étiquette du fils droit de t.(k) est t.(2*k+1). *)

let creer_tas_vide nmax = Array.make nmax 0 ;;

let test_vide tas = ( tas.(0)=0 ) ;;

let rech_max tas = if test_vide tas then failwith "erreur" 
				else tas.(1) ;; 

let echange t i j =
	let x = t.(i) in t.(i) <- t.(j) ; t.(j) <- x
;;

let insertion_tas x tas =
	let rec remonte t i =
		if i <> 1 && t.(i/2) < t.(i) then ( echange t (i/2) i ; remonte t (i/2) )
	in tas.(0) <- tas.(0) +1 ;
	tas.(tas.(0)) <- x ;
	remonte tas tas.(0)
;;

let supprime_tas tas =
	let rec descente t i =
		let n = ref i in
		if 2*i < t.(0) && t.(2*i) > t.(i) then n := 2*i ;
		if 2*i+1 < t.(0) && t.(2*i+1) > t.(i) then n := 2*i+1 ;
		if !n <> i then ( echange t i !n ; descente t !n ) 
	in tas.(0) <- tas.(0) -1 ;
	echange tas 1 tas.(0) ;
	descente tas 1
;;



(* ================================================================================= *)
(* ================================================================================= *)

(* CHAPITRE 3 : GRAPHES *)


(* Définition : un graphe est un couple (V,E) ... *)

(* I Graphes Orientés *)

(* Implémentation avec un matrice d'adjacence *)
(* g.(i).(j) est l'arrête de i à j *)

type graphe = int array array ;;

let ajoute_arete_matrice g i j =
	g.(i).(j) <- 1
;;

let supprime_arete_matrice g i j =
	g.(i).(j) <- 0
;;

(* Implémentation par une liste d'adjacence *)

type graphe = int list array ;;

let ajoute_arete_liste g i j =
	let rec ajoute_liste l x = match l with
		| [] -> [x]
		| t::q when t=x -> l
		| t::q -> t::(ajoute_liste q x)
	in g.(i) <- ajoute_liste g.(i) j
;;

let supprime_arete_liste g i j =
	let rec supprime_liste l x = match l with
		| [] -> []
		| t::q when t=x -> q
		| t::q -> t::(supprime_liste q x)
	in g.(i) <- supprime_liste g.(i) j
;;

let graphe_matrice_to_liste m =
	let n = Array.length m in
	let l = Array.make n [] in
	for i=0 to n-1 do
		for j=0 to n-1 do
			if m.(i).(j)=1 then l.(i) <- j::l.(i)
		done ;
	done ; l
;;

let graphe_liste_to_matrice l =
	let n = Array.length l in
	let m = Array.make_matrix n n 0 in
	for i=0 to n-1 do
		while l.(i) <> [] do 
			let t::q = l.(i) in
			m.(i).(t) <- 1 ;
			l.(i) <- q
		done ;
	done ; m
;;

(* Implémentation du parcours de graphe *)
(* liste d'adjacence *)

(* parcours en largeur : avec une file *)

let cree_file_vide () = ref [] ;;

let est_vide_file f = (!f == []) ;;

let enfile f a = f:= !f@[a] ;;

let defile f = match !f with
	| [] -> failwith "file vide"
	| t::q -> f:=q ; t
;;

let rec enfile_liste_nonvisite visit f l = match l with
	| [] -> ()
	| t::q -> if visit.(t) <> 2 then (enfile f t ; visit.(t) <- 1 ) ; enfile_liste_nonvisite visit f q
;;

let parcours_largeur g s0 =
	let visit = Array.make (Array.length g) 0 in
	let rec parcours atraiter acc =
		if est_vide_file atraiter then acc
		else (let u = defile atraiter in 
			if visit.(u) <> 2 then (visit.(u) <-2 ;
				enfile_liste_nonvisite visit atraiter g.(u) ;
				parcours atraiter (u::acc) )
			else parcours atraiter acc )
	in let f = cree_file_vide () in
	enfile f s0 ; List.rev (parcours f [])
;; (* Complexité ... *)

(* parcours en profondeur : avec une pile *)

let parcours_profondeur g s0 =
	let visit = Array.make (Array.length g) false in
	let rec parcours atraiter acc = match atraiter with
		| [] -> acc
		| t::q -> if not visit.(t) then (visit.(t) <- true ; 
					parcours q (parcours g.(t) (t::acc)) )
				else parcours q acc
	in visit.(s0) <- true ; List.rev (parcours g.(s0) [])
;;

(* recherche plus court chemin *)

(* on enfile les sommets non visités d'une liste en gardant le sommet précédent p en mémoire *)
let rec enfile_liste_precedent visit f l p = match l with
	| [] -> ()
	| t::q -> if visit.(t) = 0
			then (enfile f (t,p) ; visit.(t) <- 1) ;
			enfile_liste_precedent visit f q p
;;

(* on reconstruit le chemin jusqu'à s0 à l'aide d'un array des précédents de chaque sommet *)
let rec reconstruit prec acc s s0 =
	if s=s0 then (s::acc)
	else reconstruit prec (s::acc) (prec.(s)) s0
;;

(* plus court chemin du sommet s0 au sommet sf, en supposant qu'il existe un chemin
on utilise un parcours en largeur donc avec une file implémenté comme (int*int) ref list *)
let plus_court_chemin g s0 sf =
	let n = Array.length g in
	let visit = Array.make n 0 in
	let prec = Array.make n 0 in
	let rec parcours atraiter =
		let (s,p) = defile atraiter in
		visit.(s) <- 2 ; prec.(s) <- p ;
		if s <> sf then ( enfile_liste_precedent visit atraiter g.(s) s ;
				parcours atraiter )
	in let f = cree_file_vide () in 
	enfile f (s0,s0) ; parcours f ; reconstruit prec [] sf s0
;; 


(* ================================================================================= *)

(* II Graphes Orientés *)

(* même implémentation ; les matrices d'adjacences sont symétriques *)

let est_non_oriente g =
	let n = Array.length g in
	let rec parcours voisin s = match voisin with
		| [] -> true
		| t::q -> if List.mem t g.(t) then parcours q s
				else false 
	in let b = ref true in
	let i = ref 0 in
	while !i < n && !b do
		b := parcours g.(!i) !i ;
		incr i
	done ; !b
;;


(* Recherche des composantes connexes *)

(* parcours en profoneur renvoyant la composante connexe contenant les sommets d'une liste *)

let rec parcours g visit cc atraiter = match atraiter with
	| [] -> cc 
	| t::q when visit.(t) -> parcours g visit cc q 
	| t::q -> visit.(t) <- true ; parcours g visit (t::cc) (q@g.(t)) 
;;

let compConnexes g =
	let n = Array.length g in
	let visit = Array.make n false in
	let s = ref 0 in
	let l = ref [] in
	while !s < n do 
		if not visit.(!s) then ( visit.(!s) <- true ;
					l := (parcours g visit [!s] g.(!s))::!l) ;
		incr s
	done ;
	!l
;;


(* ================================================================================= *)

(* III Graphes Pondérés *)


type int_inf = | Inf | Entier of int

let add_inf x y = match x,y with
	| Inf,_ -> Inf 
	| _,Inf -> Inf
	| Entier a , Entier b -> Entier (a+b)
;;

let min_inf x y = match x,y with
	| Inf,_ -> x 
	| _,Inf -> y
	| Entier a , Entier b -> Entier (min a b)
;;

let plus_petit x y = match x,y with
	| Inf,_ -> false 
	| _,Inf -> true
	| Entier a , Entier b -> a < b
;;

(* Recherche du chemin du plus faible poids *)

(* Algorithme de Floyd-Warshall *)

let floyd_warshall g =
	let n = Array.length g in
	let mat = Array.make_matrix n n (Entier 0) in
	for i=0 to n-1 do
		mat.(i) <- Array.copy g.(i)
	done ;
	for k=0 to n-1 do
		for i=0 to n-1 do
			for j=0 to n-1 do
				mat.(i).(j) <- min_inf mat.(i).(j) (add_inf mat.(i).(k) mat.(k).(j))
			done ;
		done ;
	done ; mat
;;	

(* Algorithme de Dijkstra *)

=======================================

(* exemples *)



let rec f = function
  | [] -> 0
  | t::q -> t+10*(f q);;

type arbre = | F of int | N of arbre * int * arbre;;

let a = N (N(F 2,15,F 22),28,F 41);;

let rec profondeur = function
  | F n -> 0
  | N (g,n,d) -> if (profondeur g) > (profondeur d) then (profondeur g)+1 else (profondeur d)+1;;

let f a b = a > b ;;

type rationnel = int * int ;;

(* let r : rationnel = 5,6 *)

let gauche r = fst(r),(fst r +(snd r));;




type 'a noeud = { pere : 'a noeud ; fils : 'a noeud list ; etiquette : 'a } ;;

let noeud_nbfilsmax m =
	let p = ref (List.length m.fils) in
	let r = ref m in
	let rec aux a = match a.fils with 
		| [] -> ()
		| t::q -> let l=List.length t.fils in
					if l > !p then (p:=l ; r:=t) ;
					aux t ; aux { pere = a.pere ; fils = q ; etiquette = a.etiquette }
	in aux m ; !r
;;


(* COURS 8 *)

let rec binome n p = match n with
	| n when n<p || p<0 -> 0
	| 0 -> 1
	| _ -> binome (n-1) (p-1) + binome (n-1) p
;; (* C(n,p)=2^n - 1 *)

let binom n p = 
	let t = Array.make_matrix (n+1) (n+1) 0 in
	for i=0 to n do
		for j=0 to i do
			match (i,j) with
				| _,0 -> t.(i).(j) <- 1 
				| _ -> t.(i).(j) <- t.(i-1).(j-1) + t.(i-1).(j)   
		done
	done ; t.(n).(p)
;; (* C(n,p)=O(n^2) *)

let binom2 n p = 
    let t = Array.make (n+1) 0 in
    t.(0) <- 1 ;
    for i = 1 to n do
        for j = i downto 1 do
            t.(j) <- t.(j) + t.(j-1)
            done
		done ; t.(p)
;; (* Compléxité spatiale plus faible *)



(* TP6 2 : morse code *)

let alphabet = [|('A',".-");('B',"-...");('C',"-.-.");('D',"-..");
        ('E',".");('F',"..-.");('G',"--.");('H',"....");
        ('I',"..");('J',".---");('K',"-.-");('L',".-..");
        ('M',"--");('N',"-.");('O',"---");('P',".--.");
        ('Q',"--.-");('R',".-.");('S',"...");('T',"-");
        ('U',"..-");('V',"...-");('W',".--");('X',"-..-");
        ('Y',"-.--");('Z',"--..")|] ;;

let demorse code =
    let i = ref 0 and rep = ref '_' in
    while !i < 26 && !rep = '_' do
        if snd alphabet.(!i) = code then rep := fst alphabet.(!i)
        else incr i done;
    !rep;;

(* 1 *)

let extrait_liste_hasard refliste =
	let i = Random.int (List.length (!refliste)) in
	let rec aux l accu n = 
		match n,!l with
		| 0,t::q -> refliste := accu@q ; t
		| n,t::q -> aux (ref q) (t::accu) (n-1)
	in aux refliste [] i
;; 

(* 2 *)

type labyrinthe = { longueur : int ; 
						hauteur : int ; 
						mur_vert : bool array array ; 
						mur_hori : bool array array }
;;

let  initialise_labyrinthe long haut = 
	{ longueur = long ; hauteur = haut ; 
		mur_vert = Array.make_matrix (long-1) haut true ;
		mur_hori = Array.make_matrix long (haut-1) true } 
;;

(* 3 *)

type coord = { x : int ; y : int };;
type mur = { pos : coord ; vertical : bool };;

let long,haut = 10,8 ;;

let connecte = Array.make_matrix long haut false ;;
connecte.(0).(0) <- true ;;

let frontiere = ref [{ pos = { x = 0 ; y =0 } ; vertical = true };
					{ pos = { x = 0 ; y =0 } ; vertical = false }];;

let nbre_cases_non_connectees = ref (long*haut-1);;

let laby = initialise_labyrinthe long haut ;;

(* 4 *)

let case_adjacente_non_connectee m = 
	let c = m.pos in 
		if connecte.(c.x).(c.y) then (true , c) 
		else if m.vertical && connecte.(c.x+1).(c.y) then (true , { x = c.x+1 ; y = c.y})
		else if not m.vertical && connecte.(c.x).(c.y+1) then (true , { x = c.x ; y = c.y+1})
		else (false , c)
;;

(* 5 *)

let abattre_mur m = 
	if m.vertical then laby.mur_vert.(m.pos.x).(m.pos.y) <- false 
	else laby.mur_hori.(m.pos.x).(m.pos.y) <- false 
;;

(* 6 *)

(* 7 *)

let cree_labyrinthe long haut =  

	let connecte = Array.make_matrix long haut false in
	connecte.(0).(0) <- true ;
	let frontiere = ref [{ pos = { x = 0 ; y =0 } ; vertical = true };
					{ pos = { x = 0 ; y =0 } ; vertical = false }] in
	let nbre_cases_non_connectees = ref (long*haut-1) in 
	let laby = initialise_labyrinthe long haut in

	while !nbre_cases_non_connectees >=0 do
		let m = extrait_liste_hasard frontiere in
		let (existe , c) = case_adjacente_non_connectee m in 
			if existe 
			then begin
				abattre_mur m ;
				connecte.(c.x).(c.y) <- true ;
				ajoute_murs_adjacents c ;
				decr nbre_cases_non_connectees
			end
		done ;
	laby
;;

(* 8 *)

#load "graphics.cma" ;;
open Graphics ;;
open_graph "" ;;

(* 9 *)

(* 10 *)

let trace_mur m = 
	moveto (m.pos.x+1) (m.pos.y+1) ;
	if m.vertical then lineto (m.pos.x+1) (m.pos.y) 
	else lineto (m.pos.x) (m.pos.y+1)
;;

let trace_labyrinthe lab =
	let l,h = lab.longueur,lab.hauteur in
	moveto 0 0 ;
	lineto 0 h ;
	lineto l h ;
	lineto l 0 ;
	lineto 0 0 ;	
	for i=0 to l do 
		for j=0 to h do 
			if lab.mur_hori.(i).(j) then trace_mur { pos = { x=i ; y=j } ; vertical=false } ;
			if lab.mur_vert.(i).(j) then trace_mur { pos = { x=i ; y=j } ; vertical=true } ;
;;

(* 12 *)

type direction = Inconnue | Haut | Bas | Gauche | Droite | Arrivee ;;

let construit_carte laby =
	let carte = Array.make_matrix laby.longueur laby.hauteur Inconnue in
	let rec construit_carte_depuis i j = match i,j with
		| 0,0 -> ()
		| i,j -> if not laby.mur_hori.(i).(j) && carte.(i).(j+1) = Inconnue
					then carte.(i).(j+1) <- Bas ; construit_carte_depuis i (j+1) ;
				if not laby.mur_vert.(i).(j) && carte.(i+1).(j) = Inconnue 
					then carte.(i+1).(j) <- Gauche ; construit_carte_depuis (i+1) j ;
				if not laby.mur_hori.(i).(j-1) && carte.(i).(j-1) = Inconnue
					then carte.(i).(j-1) <- Haut ; construit_carte_depuis i (j-1) ;
				if not laby.mur_vert.(i-1).(j) && carte.(i-1).(j) = Inconnue
					then carte.(i-1).(j) <- Droite ; construit_carte_depuis (i-1) j
	in
		carte.(laby.longueur-1).(laby.hauteur-1) <- Arrivee ;
		construit_carte_depuis (laby.longueur-1) (laby.hauteur-1) ;
		carte
;;

(* 13 *)

let reconstitue_chemin lab =
	let carte = construit_carte lab in
	let rec aux accu i j = match carte.(i).(j) with
			| Arrivee -> accu
			| Haut -> aux ({ x=i ; y=j+1 }::accu) i (j+1) 
			| Bas -> aux ({ x=i ; y=j-1 }::accu) i (j-1) 
			| Gauche -> aux ({ x=i ; y=j+1 }::accu) (i-1) j 
			| Droite -> aux ({ x=i ; y=j+1 }::accu) (i+1) j
	in aux [{ x=0 ; y=0 }] 0 0
;; 

(* 14 *)

let coordonnees_centre_case c = (float_of_int c.x+.0.5,float_of_int c.y+.0.5) ;;

let chemin = Array.of_list (reconstitue_chemin laby) ;;
moveto 0.5 0.5 ;;
for k=1 to (Array.length chemin) do 
	lineto (fst (coordonnees_centre_case chemin.(k))) (snd (coordonnees_centre_case chemin.(k)))
;;

(* 15 *)

(* On test toutes les directions possibles en revenant en arrière à chaque impasse
jusqu'à atteindre la case arrivée. *)

(* *)



let rec concat l1 l2 = match l1 with 
  | [] -> l2
  | t::q -> t::(concat q l2)
;;  



(* Parcours d'arbre *)

type 'a arbre = | V | N of 'a arbre * 'a * 'a arbre ;;

let arbre1 = N(N(N(V,2,V),15,N(V,22,V)),28,N(V,41,V))
;;

let rec prefixe = function
  | V -> []
  | N(g,v,d) -> [v]@(prefixe g)@(prefixe d)
;;

let rec infixe = function
  | V -> []
  | N(g,v,d) -> (infixe g)@[v]@(infixe d)
;;

let rec postfixe = function
  | V -> []
  | N(g,v,d) -> (postfixe g)@(postfixe d)@[v]
;;



(* Arbre de calcul, logique polonaise inversé *)

type calcul = | N of calcul * char * calcul | F of int 
;;

let arbre2 = N(N(F 2,'+', F 22),'*',F 41)
;;

let dico = [(let f x y = x+y in ('+',f));
                    (let f x y = x*y in ('*',f));
                    (let f x y = x-y in ('-',f));
                    (let f x y = x/y in ('/',f));
                    (let f x y = x mod y in ('%',f));]
;;
              
let rech_op op =
    let rec recherche = function
        |[] -> failwith "impossible"
        |t::q  -> if fst(t) = op then snd(t) else recherche q 
        in
    recherche dico
;;

let rec eval = function
  | F x -> x
  | N(g,o,d) -> rech_op o (eval g) (eval d)  
;;

let rec infixe_cal = function
 | F x -> string_of_int x
 | N(g,o,d) -> "(" ^ (infixe_cal g) ^ (Char.escaped o) ^ (infixe_cal d) ^ ")"
;;

let arbre3 = N(N(F 34,'+',F 52),'-',N(F 19,'-',N(F 12,'*',F 3)))
;;

type token = | E of int | O of char
;;

let rec tokenlist_of_cal = function
  | F x -> [E x]
  | N(g,o,d) -> (tokenlist_of_cal g)@(tokenlist_of_cal d)@[O o]
;;

let tok = tokenlist_of_cal arbre3
;;

let depile = function
  | [] -> failwith "impossible"
  | t::q -> t,q
;;

let pol_inv t = 
  let rec aux accu = function
    | [] -> List.hd accu   
    | (E x)::q -> aux (x::accu) q
    | (O o)::q -> aux (let a = depile accu in let b = depile (snd a) in (rech_op o (fst b)  (fst a))::(snd b)) q
  in aux [] t
;;

(* l'accu change l'ordre => b (op) a et non a (op) b 
version corrigé*)

let pol_inv t = 
  let rec aux pile t = match pile,t with
    | [x],[] -> x   
    | _,(E x)::q -> aux (x::pile) q
    | a::b::c,(O o)::q -> aux (rech_op o b a::c) q
    | _ -> failwith "erreur"
  in aux [] t
;;

let cal_of_tokenlist c = 
  let rec aux accu = function
  | [] -> List.hd accu
  | t::q -> match t with
            | E x -> aux (F x::accu) q
            | O o -> let a::b::c = accu in aux (N(b,o,a)::c) q
  in aux [] c
;;



(* Arbre-tournoi *)

type tournoi = | V | N of tournoi * int * tournoi
;;

let tou = N(
          N(
            N(V,
              18,
              N(N(V,7,V),9,V)),
            31,
            N(V,4,V)),
          39,
          N(
            N(V,15,V),
            36,
            N(V,26,V))
          )
;;

let rec insert n = function
  | V -> N(V,n,V)
  | N(g,x,d) -> if n>=x then N(N(g,x,d),n,V)
                else N(g,x,(insert n d))
;;  

let sup_max = function
  | V -> failwith "pas de max"
  | N(g,_,d) -> let rec recolle t1 t2 = match t1,t2 with
                  | V,x -> x
                  | x,V -> x 
                  | N(g1,x1,d1),N(g2,x2,d2) -> if x1<=x2 then N(recolle (N(g1,x1,d1)) g2,x2,d2)
                                                         else N(g1,x1,recolle d1 (N(g2,x2,d2)))
                in recolle g d
;; 



(* Listes imbriquées de degrés variables *)

type 'a suplist = | E of 'a | L of 'a suplist list
;;

let liste = [E 12;L [E 3;L [E 4;L [E 1]]]; L [E 15]]
;;

let rec app = function
  | [] -> []
  | E x::q -> x::(app q)
  | L [x]::q -> (app x)@(app q) 
