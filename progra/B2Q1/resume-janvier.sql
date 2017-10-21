--1 Afficher toutes les infos de la table
select * from [table]

--2 Afficher [champ] d'une [table] sans doublon
select distinct([champ]) from [table]

--3 Afficher infos sur la [table] pour les [champs] qui commencent par lettre A
select * from table where table like '%A'

--5 Afficher infos sur la [table] dont le [champ] est compris entre 3.5 et 49
select  * from table where table > 3.5 and table < 49

--6 Afficher [champ] et nombre de fois que [champ] apparait dans [table]
select champ, count([prim key]) as occurrences from table group by champ

--7 Afficher [champ] et nbre de fois que [champ] apparait dans table dont champ > 1
select champ, count(*) as occurences from Table group by champ having count(*) > 1

--8 Afficher plus petit et plus grand [champ] des [table]
select MAX(champ) as maximum, MIN(champ) as minimum from table

--9 Afficher [Table] par ordre déc de leur [champ]
select * from Table order by champ desc

--10 Afficher la plus grande [champ] de 2 façons différentes
select MAX(champ) from Table
select top 1 champ from Table order by champ desc

--11 Afficher 50% des infos sur village
select top 50 percent * from village

--12 Afficher les [Table] qui on ont un [champ] de 110,332,620
select * from Table where champ = 110 or champ = 332 or champ = 620

-----------------------------------------------------------------------------------

-- 1. produit carthésien :
select * from Table1 CROSS JOIN Table2

-- 2. afficher toutes les infos sur Table1 et sur dép.
select * from Table1 inner join Table2 on Table1.code=Table2.code
select * from Table1 left  join Table2 on Table1.code=Table2.code
select * from Table1,Table2 where Table1.code=Table2.code

-- 3. afficher nom table1.ch dont le table2.ch st Avergne
select table1.ch from table1 inner join Table2 on Table1.code=Table2.code where Table2.ch = "Auvergne"

-- 4. afficher par nom de province le nombre de département
select province.nom, count(departement.*) from table1, table2 where province.code=departement.codeProvince group by province.nom

-- 5. Afficher toutes provnces, 2 façons


-- 6. Afficher le nom des écoles ainsi que le nom, la latitude et la longitude des villages où les écoles se situent
select village.nom, village.[coord.X], village.[coord.Y], departement.nom from departement inner join situer on departement.code=situer.codeD inner join village on village.code=situer.codeV order by departement.nom

-- 7. Afficher le nom de l'école et le nombre de villages (écoliers du village) qui fréquentent l'école.
select ecole.nom, count(village.nom) from ecole, village, frequente where ecole.code=frequente.codeE and village.code=frequente.codeV group by ecole.nom

-- 8. Afficher le nom de l'école qui a le plus d'écoliers de villages différents
select ecole.nom, MAX(count(village.nom)) as nbr from ecole, village, frequente where ecole.code=frequente.codeE and village.code=frequente.codeV group by ecole.nom

--------------------------------------------------------------------------