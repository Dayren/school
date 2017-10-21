--1. Cr�er une proc�dure stock�e qui affiche toutes les informations sur les villages. L�ex�cuter.
CREATE PROCEDURE displayVillage
AS
BEGIN
	SELECT * FROM village
END
GO
EXEC displayVillage;

--2. Modifier la proc�dure cr��e en 1 pour qu'elle affiche le nom et la population des villages. L�ex�cuter.
ALTER PROCEDURE displayVillage
AS 
BEGIN 
	SELECT nom,population from village
END 
GO

--EXEC displayVillage;

--3. Cr�er une proc�dure stock�e qui affiche le nom des villages qui commencent par la lettre A et dont 
--   la population est sup�rieure � 200. La lettre et le chiffre sont pass�s en param�tres. L�ex�cuter.
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


--4. Modifier la proc�dure stock�e cr��e en 3 pour qu'elle mette des valeurs par d�faut aux param�tres. 
--   Donner les diff�rentes instructions qui permettent de l'ex�cuter.
ALTER PROCEDURE displayVillageA
	@pop1 int = 100,
	@let1 nvarchar(50) ='r'
as
begin
	select * from village where (population > @pop1 and nom like @let1+'%')
end
go

--exec displayVillageA @let1='A'

--5. Cr�er une proc�dure stock�e qui retourne le nombre de villages. Donner les commandes pour l'ex�cuter.
create procedure numberVillage
as
begin
	select (count code)

--6. Cr�er une proc�dure stock�e qui permet de s�lectionner tous les villages, qui modifie la population
--   en 150 du village dont le nom est pass� en param�tre. Donner l'instruction qui permet de l'ex�cuter.


--7. Supprimer la proc�dure stock�e cr��e en 6.

--drop proc displayVillage