#include <vector>
#include <iostream>
#include <string>
#include <iomanip>

using namespace std;


class Address {
public:
	Address(int n, string c, string r, string v);
	~Address();

	void afficher();

private:
	int num;
	string code;
	string rue;
	string ville;
};

//////////////////////////////////

class Zoo {
public:
	Zoo(string n, string t, Address a);
	~Zoo();

	void afficherAnimaux();
	void afficherClients();
	void afficherEmployes();
	void afficherInfos();

	void ajouterAnimal();
	void ajouterClient();
	void ajouterEmploye();

private:
	Address adr;
	string tel;
	string nom;
	vector<Animal*> lAnimals;
	vector<Client*> lClients;
	vector<Employe*> lEmploye;
};

/****************************************************************************************************************************************/
/******		 ANIMAUX			*********************************************************************************************************/
/****************************************************************************************************************************************/
class Animal {
public:
	Animal();
	~Animal();

	void afficherSoins();
	void ajouterSoins();
	void afficherInfo();

protected:
	int code;
	int age;
	bool sexe;
	string nom;
	string alim;

	vector<Soins> lsoins;
};

//////////////////////////////////////////

class Mammal : public Animal {
public:
	Mammal();
	~Mammal();

	void setAlpha();
	void setMoisGestation();

private:
	bool alpha;
	int gestation;
};

////////////////////////////////////////

class Reptile : public Animal {
public:
	Reptile();
	~Reptile();

	void afficherInfo();

	void setPond();

private:
	int pondaison;
};

/****************************************************************************************************************************************/
/******		 PERSONNES			*********************************************************************************************************/
/****************************************************************************************************************************************/

class Personne {
public:
	Personne();
	~Personne();

	void afficherInfo();

protected:
	string nom;
	string prenom;
};

////////////////////////////////////////

class Client : public Personne {
public:
	Client();
	~Client();
	
	void afficherInfo();

	bool abonnement();
	void ajouterVisite();

private:
	bool abonnement;
	int numClient;

	vector<string> lVisites;
};

//////////////////////////////////////////

class Employe : public Personne {
public:
	Employe();
	~Employe();

	void ajouterHeures();
	void afficherInfois();

protected:
	int heures;
	int salaire;
};

//////////////////////////////////////////

class Animateur : public Employe {

};

/****************************************************************************************************************************************/
/******		 SOIGNANTS			*********************************************************************************************************/
/****************************************************************************************************************************************/

class Veto : public Employe {

};

// Aide soignant : anime et aide les vétérinaires à soigner les animaux
class Aide : public Animateur, public Veto {

};

//////////////////////////////////////////

class Soins {

};


/****************************************************************************************************************************************/
/******		 AFFICHAGE			*********************************************************************************************************/
/****************************************************************************************************************************************/

class Ui {

};