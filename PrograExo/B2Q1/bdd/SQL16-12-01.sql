-- select * from Vue1
create View WMeRe(Nom, Prenom, dateReservation, HeureDebut, heureFin)
as select Membre.nom, Membre.prenom [...] from Membre inner join
select * from WMeRe

---
create View WMere2(Nom, Prenom, dateReservation, HeureDebut, heureFin) with encryption
as select Membre.nom, Membre.prenom, Reserver.dateR,Reserver.heureDebut, Reserver.heureFin from Membre inner join

---
create View WMere3(Nom, Prenom, dateReservation, HeureDebut, heureFin) with schemabinding
as select Membre.nom, Membre.prenom, Reserver.dateR,Reserver.heureDebut, Reserver.heureFin from dbo.Membre inner join

--- une vue qui dépend d'une autre vue
create view VdepMeRe(Nom,Prenom,dateReservation)
as select * from WMeRe where nom like 'D%'

----
select * from WMeRe