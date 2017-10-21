select * from Province, departements where Province.code=departements.[code.province] order by Province.nom
			--afficher produit Carhésien
select * from departements left join Province on departements.[code.province]=Province.code order by Province.nom
			--même chose
select Province.nom,departements.code,departements.nom from Province inner join departements on Province.code=departements.[code.province] order by Province.nom
			--même chose lol

-- 3 : afficher nom département qui appartiennent à Auvergne-Rhone-Alpes
	select departements.nom from Province inner join departements on Province.code=departements.[code.province]  where Province.nom='Auvergne-Rhone-Alpes'

-- 4 : Afficher par nom de Province le nombre de départements
	select Province.nom,count(Province.code) as compteur from Province inner join departements on Province.code=departements.[code.province] group by Province.nom

-- 5. Afficher toutes les provinces mêmes celles qui ne sont pas reprises dans la table département ( de 2 façons différentes).

-- 6. Afficher le nom des écoles ainsi que le nom, la latitude et la longitude des villages où les écoles se situent
	Select ecole.nom, village.nom, village.lat, village.long from ecole, village, frequente where ecole.code=frequente.[code.ecole] and village.code=[code.village]

-- 7. Afficher le nom de l'école et le nombre de villages (écoliers du village) qui fréquentent l'école.
	select ecole.nom,count(ecole.code) as nbr from ecole, frequente, village where ecole.code=frequente.[code.ecole] and village.code=frequente.[code.village] group by ecole.nom

-- 8. Afficher le nom de l'école qui a le plus d'écoliers de villages différents
	select top 1 ecole.nom,count(ecole.code) as nbr from ecole, frequente, village where ecole.code=frequente.[code.ecole] and village.code=frequente.[code.village] group by ecole.nom order by nbr DESC