create TABLE Club (
		nomClub NVARCHAR(50) PRIMARY KEY )
drop table club

create TABLE Gerant (
		ID int PRIMARY KEY,
		nomGerant nvarchar(50) UNIQUE,
		sexe char(1) DEFAULT 'M',
		anneeCrea int check (anneeCrea between 30 and 60),
		ville nvarchar(50) check (ville is NOT NULL),
		nomClub nvarchar(50) FOREIGN KEY (nomClub) REFERENCES Club
)

alter table Gerant
add anciennete int
drop column anciennete

exec sp_rename 'Gerant', 'Gerant2'

truncate table Gerant2
