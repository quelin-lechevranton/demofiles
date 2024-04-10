TYPES

Une format_ LaTeχ sera le bienvenue ?

t = table_
a = attribut
v = valeur
c = calcul (ex : c(a) = 4*a)
e = équation (ex : e(a) <=> a>4)
f = fonction d agrégation
x = nom arbitraire

I ALGÈBRE RELATIONNELLE

projection 				π{attribut1}(table1) 	SELECT attribut FROM table1
restriction 			σ{attribut=valeur}(t1) 	SELECT * FROM table1 WHERE attribut=valeur
renommage				ρ{attribut -> x}(t1) 	SELECT attribut AS x FROM table1
union_ 					table1 ⋃ table2 		SELECT * FROM table1 UNION SELECT * FROM table2
intersection 			table1 ⋂ table2 		SELECT * FROM table1 INTERSECT SELECT * FROM table2
moins 					table1 ∖ table2 		SELECT * FROM table1 EXCEPT SELECT * FROM table2
produit cartésien 		table1 ⨯ table2 		SELECT * FROM table1 , table2
jointure				t1 ⋈{t1.a1=t2.a1} t2	SELECT * FROM t1 JOIN t2 ON t1.a1=t2.a2			
division relationnelle	table1 ÷ table2			SELECT

II REQUÊTE DE CONSULTATION 

SELECT a1 , c(a2) AS x , DISTINCT a3
FROM t1 , t2 JOIN t3 ON t2.a1 = t3.a1 
WHERE t1.a1 = v1.1 AND t2.a1 != valeur2.1
GROUP BY a1
HAVING e1(x)
ORDER BY e2(a3) , a1 DESC
LIMIT 7 OFFSET 3 
UNION/INTERSECT/EXCEPT
SELECT ...

III AGRÉGATION

fonction d agrégation 	COUNT SUM MIN MAX AVG

regroupement			{a1}γ{f1(a2)}(table1)					SELECT f1(a2) FROM table1 GROUP BY a1
restriction de groupe	σ{x=v}({a1}γ{f1(a2) -> x}(table1))	 	SELECT f1(a2) AS x FROM table1 GROUP BY a1 HAVING b=v 

IV SOUS-REQUÊTE

