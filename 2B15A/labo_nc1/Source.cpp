#include "Source.h"


/***********************	DATE	***********************/
//---	CONSTRUCTEURS
Date::Date(int j, int m, int a) {
	jour = j;
	mois = m;
	annee = a;
}
Date::~Date() { cout << "destructeur Date!" << endl; }

//---	METHODES
void Date::afficher() {
	cout << jour << "/" << mois << "/" << annee << endl;
}

/***********************	CIRCULATION    ***********************/
//---	CONSTRUCTEURS
Circulation::Circulation(string v, int j, int m, int a) {
	ville = v;
	date = new Date(j, m, a);
}
Circulation::~Circulation() { cout << "Destructeur Circulation!" << endl; }

//---	METHODES
void Circulation::afficher() {
	cout << ville << " - ";
	date->afficher();
}

	// ajouter un véhicule
void Circulation::addVehicule(Automobile *autom) {
	int i = 0;
	while (exist[i])
		i++;
	vehicules[i] = autom;
	exist[i] = true;
}
void Circulation::addVehicule(Velo * vel) {
	int i = 0;
	while (exist[i])
		i++;
	vehicules[i] = vel;
	exist[i] = true;
}
void Circulation::addVehicule(Camion * cam) {
	int i = 0;
	while (exist[i])
		i++;
	vehicules[i] = cam;
	exist[i] = true;
}

	// afficher les véhicules
void Circulation::afficherVehicules() {
	for (int i = 0; i < 50; i++) {
		if (exist[i]) {
			if (i < 10)
				cout << "0" << i+1 << ". ";
			else
				cout << i << ". ";

			vehicules[i]->afficher();
		}
	}
}

/***********************	VEHICULE	***********************/
//---	CONSTRUCTEURS
Vehicule::Vehicule() { nbt++; }
Vehicule::~Vehicule() { cout << "Destruction Vehicule!" << endl; nbt--; }

//---	STATIQUE
int Vehicule::nbt = 0;
int Vehicule::getNbt() { return nbt; }

//---	METHODES
void Vehicule::afficher() {
	cout << "    nombre de roues : " << nbRoues << ",      vitesse max : " << vmax << "km/h"<< endl;
}			


/***********************	VELO	***********************/
//---	CONSTRUCTEURS
Velo::Velo(string t) {
	nbRoues = 2;
	vmax = 20;
	type = t;
	nbv++;
}
Velo::~Velo() { cout << "Destruction Velo!" << endl; nbv--; }
//---	STATIQUE
int Velo::nbv = 0;
int Velo::getNbv() { return nbv;  }

//---	METHODES
void Velo::afficher() {
	cout << "Velo (" << type <<") " << endl;
	Vehicule::afficher();
}

bool Velo::comparer(Velo *v1, Velo *v2) {
	if (v1->type.compare(v2->type) == 0)
		return true;
	else
		return false;
}


/***********************	AUTOMOBILE	***********************/
//---	CONSTRUCTEURS
Automobile::Automobile(string m, int r) {
	nbRoues = 4;
	vmax = 180;
	marque = m;
	reservoir = r;
	nba++;
}
Automobile::~Automobile() { cout << "Destruction Automobile!" << endl; nba--; }

//---	STATIQUE
int Automobile::nba = 0;
int Automobile::getNba() { return nba; }

//---	METHODES
void Automobile::afficher() {
	cout << "Voiture (" << marque << ")     reservoir : " << reservoir << endl;
	Vehicule::afficher();
}


/***********************	CAMION	***********************/
//---	CONSTRUCTEURS
Camion::Camion(int p, string m, int r) : Automobile(m, r) {
	nbRoues = 6;
	vmax = 100;
	poid = p;
	nbc++;
}
Camion::~Camion() { cout << "Destruction Camion!" << endl; nbc--; }

//---	STATIQUE
int Camion::nbc = 0;
int Camion::getNbc() { return nbc; }

//---	METHODES

void Camion::afficher() {
	cout << "Camion (" << marque << ")     reservoir : " << reservoir << "L, ";
	cout << "poid " << poid << "Kg" << endl;
	Vehicule::afficher();
}
