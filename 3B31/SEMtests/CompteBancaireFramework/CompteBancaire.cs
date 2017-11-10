using System;
using System.Collections.Generic;
using System.Text;

namespace CompteBancaireFramework
{
    public class CompteBancaire
    {
        public string Nom { get; set; }
        public double Solde { get; set; }
        public bool Bloque { get; set; }

        public CompteBancaire(string nom, double solde) {
            Nom = nom;
            Solde = solde;
            Bloque = false;
        }

        public void Debiter(double montant) {
            if (Bloque) throw new Exception("Compte bloqué");
            if (montant > Solde) throw new ArgumentOutOfRangeException("montant", "montant plus grand que solde");
            if (montant < 0) throw new ArgumentOutOfRangeException("montant", "montant plus petit que zéro");
            Solde -= montant;
        }
        public void Crediter(double montant) {
            if (Bloque) throw new Exception("Compte bloqué");
            if (montant < 0) throw new ArgumentOutOfRangeException("montant", "montant plus petit que zéro");
            Solde += montant;
        }

        public void BloquerCompte() {
            Bloque = true;
        }
        public void DebloquerCompte() {
            Bloque = false;
        }
 
    }

    public interface IDAL
    {
        CompteBancaire RetournerCompteBancaire(string nom);
    }

    public class DAL : IDAL
    {
        public CompteBancaire RetournerCompteBancaire(string nom) {
            return new CompteBancaire(nom, 20);
        }
    }
}
