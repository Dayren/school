--1. Créer une procédure stockée qui affiche toutes les informations sur les villages. L’exécuter.
CREATE PROCEDURE displayVillage
AS
BEGIN
	SELECT * FROM village
END
GO
EXEC displayVillage;

--2. Modifier la procédure créée en 1 pour qu'elle affiche le nom et la population des villages. L’exécuter.
ALTER PROCEDURE displayVillage
AS 
BEGIN 
	SELECT nom,population from village
END 
GO

--EXEC displayVillage;

--3. Créer une procédure stockée qui affiche le nom des villages qui commencent par la lettre A et dont 
--   la population est supérieure à 200. La lettre et le chiffre sont passés en paramètres. L’exécuter.
--drop proc displayVillageA
CREATE PROCEDURE displayVillageA
	@pop1 int,
	@let1 nvarchar(50)
as 
begin
	SELECT * from village where (population > @pop1 and nom like @let1+'%')
end
GO

--exec displayVillageA @pop1=200, @let1='A'


--4. Modifier la procédure stockée créée en 3 pour qu'elle mette des valeurs par défaut aux paramètres. 
--   Donner les différentes instructions qui permettent de l'exécuter.
ALTER PROCEDURE displayVillageA
	@pop1 int = 100,
	@let1 nvarchar(50) ='r'
as
begin
	select * from village where (population > @pop1 and nom like @let1+'%')
end
go

--exec displayVillageA @let1='A'

--5. Créer une procédure stockée qui retourne le nombre de villages. Donner les commandes pour l'exécuter.
create procedure numberVillage
as
begin
	select (count code)

--6. Créer une procédure stockée qui permet de sélectionner tous les villages, qui modifie la population
--   en 150 du village dont le nom est passé en paramètre. Donner l'instruction qui permet de l'exécuter.


--7. Supprimer la procédure stockée créée en 6.

--drop proc displayVillage