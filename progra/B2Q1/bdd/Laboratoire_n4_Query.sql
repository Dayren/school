select * from Province, departements where Province.code=departements.[code.province] order by Province.nom
			--afficher produit Carh�sien
select * from departements left join Province on departements.[code.province]=Province.code order by Province.nom
			--m�me chose
select Province.nom,departements.code,departements.nom from Province inner join departements on Province.code=departements.[code.province] order by Province.nom
			--m�me chose lol

-- 3 : afficher nom d�partement qui appartiennent � Auvergne-Rhone-Alpes
	select departements.nom from Province inner join departements on Province.code=departements.[code.province]  where Province.nom='Auvergne-Rhone-Alpes'

-- 4 : Afficher par nom de Province le nombre de d�partements
	select Province.nom,count(Province.code) as compteur from Province inner join departements on Province.code=departements.[code.province] group by Province.nom

-- 5. Afficher toutes les provinces m�mes celles qui ne sont pas reprises dans la table d�partement ( de 2 fa�ons diff�rentes).

-- 6. Afficher le nom des �coles ainsi que le nom, la latitude et la longitude des villages o� les �coles se situent
	Select ecole.nom, village.nom, village.lat, village.long from ecole, village, frequente where ecole.code=frequente.[code.ecole] and village.code=[code.village]

-- 7. Afficher le nom de l'�cole et le nombre de villages (�coliers du village) qui fr�quentent l'�cole.
	select ecole.nom,count(ecole.code) as nbr from ecole, frequente, village where ecole.code=frequente.[code.ecole] and village.code=frequente.[code.village] group by ecole.nom

-- 8. Afficher le nom de l'�cole qui a le plus d'�coliers de villages diff�rents
	select top 1 ecole.nom,count(ecole.code) as nbr from ecole, frequente, village where ecole.code=frequente.[code.ecole] and village.code=frequente.[code.village] group by ecole.nom order by nbr DESC