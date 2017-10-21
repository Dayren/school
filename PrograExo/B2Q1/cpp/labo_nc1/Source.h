#include <iostream>
#include <string>

using namespace std;


class Vehicule {		// statique pour nombre vehicule au total?
protected:		// nombres roues, vitesse max (dépend de la sous-classe)
	int nbRoues;
	int vmax;

	static int nbt;

public:			// virtual afficher + get statique

	virtual void afficher();

	static int getNbt();


	Vehicule();
	~Vehicule();
};

class Velo : public Vehicule {
private:		// type (string)
	string type;

	static int nbv;

public:			// afficher + comparer (même type)
	virtual void afficher();

	bool comparer(Velo *v1, Velo *v2);

	// nombre d'instances
	static int getNbv();

	// Constructeur
	Velo(string t);
	~Velo();
};

class Automobile : public Vehicule {
protected:		// marque, capacité du résevoir
	string marque;
	int reservoir;

	static int nba;

public:			// afficher
	virtual void afficher();

	// nombre d'instances
	static int getNba();

	// Constructeur
	Automobile(string m, int r);
	~Automobile();
};

class Camion : public Automobile {
private:		// poid
	int poid;

	static int nbc;

public:			// afficher
	virtual void afficher();

	// nombre d'instances
	static int getNbc();

	// Constructeur
	Camion(int p, string m, int r);
	~Camion();
};

class Date {
private:
	int jour;
	int mois;
	int annee;

public:
	void afficher();

	Date(int j, int m, int a);
	~Date();
};

class Circulation {
private:
	// ville
	string ville;

	// date
	Date *date;

	// tableau de véhicules
	Vehicule *vehicules[50];
	bool exist[50];				// 0 : inexistant, 1: existe

public:
	// afficher caractéristique Ville + Date
	void afficher();

	// ajout véhicules (tableau? surcharge ?)
	void addVehicule(Automobile *autom);
	void addVehicule(Velo * vel);
	void addVehicule(Camion * cam);

	// afficher véhicules
	void afficherVehicules();

	// Constructeur
	Circulation(string v, int j, int m, int a);
	~Circulation();
};

