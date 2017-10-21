--affiche tout sur les villages
SELECT * FROM village
--affiche pop sans doublon
SELECT distinct(population) from village

--affiche info sur les villages dont nom commence par A
select * from village where nom like 'A%'

--afficher info sur villages dont lont > 3.5
select * from village where long > 3.5

--afficher infos sur les villages dont latitude [2;49]
select * from village where lat > 2 and lat <49

--afficher la pop et le nombre de villages qui ont cette pop (nombre de fois qu' elle apparait dans la table)
select population, count(code) as compteur from village group by population

--affiche pop + nombre de fois que pop apparait dont la repetition est sup a 1
select population, count(code) as compteur from village group by population having count(code) > 1

--affiche plus petite et plus grande pop
select MAX(population) as MaxPop, MIN(population) as MinPop from village

--afficher les villages par ordre decroissant de pop'
select * from village order by population desc

-- afficher la plus grande lat facon 1
select MAX(lat) as Maxlat from village

-->> facon 2
SELECT top 1 lat from village order by lat desc

--afficher 50% des ifnos sur les villages
select top 50 percent * from village

--afficher les villages avec une pop de 110, 332 et 620
select * from village where population = 300 or population = 250 or population = 620