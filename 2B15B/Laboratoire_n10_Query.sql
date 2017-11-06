-- 1.	créer une vue qui reprend le nom du village, la longitude et le nom du département.
--		Afficher la vue

create view Wvide(nomvi, long, nomdep) 
--as select village.nom, village.[coord.Y], departement.nom from village inner join 
as select distinct village.nom, village.[coord.Y], departement.nom from village, departement, situer where situer.codeV = village.code and situer.codeD = departement.code

select * from Wvide
drop view Wvide


-- 2.	créer la même vue avec un autre nom qu'au point 1 en mettant l'option d'encryption.

create view Wvide2(nomVillage, longitude, nomDepartement) with encryption
as select distinct village.nom, village.[coord.Y], departement.nom from village, departement, situer where situer.codeV = village.code and situer.codeD = departement.code

select * from Wvide2


-- 3.	créer une vue qui est basée sur la vue créée en 1 en n'affichant que le nom du département et le nombre de villages par département.
create view Wvide3(nomDepartement, nomVillage)
ss select distinct departement.nom, village.nom from village, departement, situer where situer.codeV = village.code and situer.codeD = departement.code

select * from Wvide3


-- 4.	changer la vue créée en 3 pour qu'elle n'affiche que les noms de département qui commence par la lettre 'A'.
create view Wvide31(nomDepartement, nomVillage)
as select * FROM Wvide3 where nomDepartement like 'A%'

select * from Wvide31

-- 5.	changer le nom de la vue créée en 3.
Exec sp_rename 'Wvide3','Wkek'


-- 6.	supprimer la vue créée en 3 et renommée en 5.
drop view Wkek