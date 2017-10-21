--	1. Afficher les écoles qui sont supervisées et dont le nom commenc epar L (de 3 façons différentes)
--	1.1
		select distinct ecole.* from ecole, inspect where inspect.[code.ecole] = ecole.code and ecole.nom LIKE 'g%'
	-- OU
		select distinct ecole.* from ecole
			inner join inspect on ecole.code = inspect.[code.ecole]
			where ecole.nom like 'g%'
--  1.2
		select ecole.* from ecole where ecole.nom LIKE 'g%' and ecole.code IN (select [code.ecole] from inspect)
--	1.3
		select ecole.* from ecole where ecole.nom LIKE 'g%' and ecole.code = any(select [code.ecole] from inspect)

--	2. Afficher les écoles qui sont supervisées et dont le nom nen commpence pas par L ( de 3 façons différentes )
	-- SAME 1.	JUST ADD « NOT LIKE »
		select ecole.* from ecole where ecole.nom NOT LIKE 'g%' and ecole.code IN (select [code.ecole] from inspect)

--	3. Afficher les numéros des écoles qui n'ont pas été supervisées (de 3 façons différentes).
--  1.1
		select ecole.nom  from ecole where ecole.code not in (select [code.ecole] from inspect)
--	1.2
		select ecole.nom from ecole left join inspect on (ecole.code = inspect.[code.ecole]) where inspect.[code.ecole] is null
--	1.3
		select ecole.nom from ecole where ecole.code <> all(select [code.ecole] from inspect)
		select ecole.nom from ecole where not exists(select inspect.[code.ecole] from inspect where inspect.[code.ecole]= ecole.code)
--	4. Afficher les numéros des étudians qui ont été supervisées (de 3 façons différentes)
		select frequente.code from frequente where frequente.[code.ecole] in (select ecole.* from ecole where ecole.code IN (select [code.ecole] from inspect))