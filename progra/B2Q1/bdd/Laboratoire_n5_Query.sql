--	1. Afficher les �coles qui sont supervis�es et dont le nom commenc epar L (de 3 fa�ons diff�rentes)
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

--	2. Afficher les �coles qui sont supervis�es et dont le nom nen commpence pas par L ( de 3 fa�ons diff�rentes )
	-- SAME 1.	JUST ADD � NOT LIKE �
		select ecole.* from ecole where ecole.nom NOT LIKE 'g%' and ecole.code IN (select [code.ecole] from inspect)

--	3. Afficher les num�ros des �coles qui n'ont pas �t� supervis�es (de 3 fa�ons diff�rentes).
--  1.1
		select ecole.nom  from ecole where ecole.code not in (select [code.ecole] from inspect)
--	1.2
		select ecole.nom from ecole left join inspect on (ecole.code = inspect.[code.ecole]) where inspect.[code.ecole] is null
--	1.3
		select ecole.nom from ecole where ecole.code <> all(select [code.ecole] from inspect)
		select ecole.nom from ecole where not exists(select inspect.[code.ecole] from inspect where inspect.[code.ecole]= ecole.code)
--	4. Afficher les num�ros des �tudians qui ont �t� supervis�es (de 3 fa�ons diff�rentes)
		select frequente.code from frequente where frequente.[code.ecole] in (select ecole.* from ecole where ecole.code IN (select [code.ecole] from inspect))