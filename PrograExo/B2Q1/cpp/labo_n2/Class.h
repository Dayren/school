#include <iostream>
#include <string>
using namespace std;

class Usager {
private:
	string nom;
	bool abonne;
public:
	bool exist=false;
	Usager(string nom_="", bool abonne_=false);
	void affiche();
};

class Bus {
private:
	int immatriculation;
	int annee;
	int poid;
	Usager user[50];
public:
	Bus(int immatriculation_=0, int annee_=0, int poid_=0);
	void afficher();
	int augementerPoids(int poid_=1000);
	bool comparer(Bus b1, Bus b2);
	Bus etrePlusLourd(Bus b1, Bus b2);
	void addUser(Usager user1);
	void displayUsers();
};