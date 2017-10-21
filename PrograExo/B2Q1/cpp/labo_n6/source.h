
// Agence Immo
// nom, address et un numéro de tél
// doit ajouter des biens, ajouter personne, afficher biens et afficher personnes et associer personne




// bien = taille
// maison = bien + mitoyenneté
// appartament = bien + numéro d'étage 
#include<string>

class AgenceImmo {
 private: 
    string nom;
    string prenom;
    string tel;
 public:
    AgenceImmo(string nom, string prenom, string tel);
    
};
class Bien {
 protected:
    int taille;
 public:
    Bien();
    void afficher();
};

class Maison : Bien {
 protected:
    bool mito;
 public:
    Maison();
    void afficher();
};

class Appart : Bien {
 protected:   
    int etage;
 public: 
    Appart();
    void afficher();
};



// personne = nom + prénom
// employé = personne + heures (int)
// client = personne + numéro (string)

class Personne {
 protected:
    string nom;
    string prenom;
 public:     
    Personne();
    void afficher();
};

class Employe : Personne {
 protected:
    int heure;
 public:
    Employe();
    void afficher();
};

class Client : Personne {
 protected:
    int num;
    string tel;
 public:    
    Client();
    void afficher();
};
    

// locataire = client + salaire ( double )
// proprio = client + type (string) + possède bien(s)
    //      > permettre d'ajouter biens + display
// locataire/proprio = locataire + proprio
class Locataire : Client {
 protected:
    int salaire;
 public:    
    Locataire();
    void afficher();
};

class Proprio : Client {
  protected:
    string type;
  public:
    Proprio();
    void afficher();
      
};

class Locaprio : Locataire, Proprio {
  public:
    Locaprio();
    void afficher();
     
};