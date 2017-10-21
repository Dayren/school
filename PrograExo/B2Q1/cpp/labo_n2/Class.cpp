#include "Class.h"

Usager::Usager(string nom_, bool abonne_) {
	nom = nom_;
	abonne = abonne_;
}
void Usager::affiche() {
	cout << nom << " - " << abonne << endl;
}


Bus::Bus(int immatriculation_, int annee_, int poid_) {
	immatriculation = immatriculation_;
	annee = annee_;
	poid = poid_;
}
void Bus::afficher() {
	cout << "immatriculation : " << immatriculation << "  -   "
		<< "annee : " << annee << "  -   "
		<< "masse : " << poid << "kg" << endl;
}
int Bus::augementerPoids(int poid_){
	poid += poid_;
	return poid;
}
bool Bus::comparer(Bus b1, Bus b2) {
	if (b1.immatriculation != b2.immatriculation)
		return false;
	else if (b1.poid != b2.poid)
		return false;
	else if (b1.annee != b2.annee)
		return false;
	else
		return true;
}
Bus Bus::etrePlusLourd(Bus b1, Bus b2) {
	if (b1.poid >= b2.poid)
		return b1;
	else
		return b2;
}
void Bus::addUser(Usager user1) {
	int j = -1;
	for (int i = 0; i < 50; i++) {
		if (user[i].exist)
			j = i;
	}
	user[j + 1] = user1;
	user[j + 1].exist = true;
}
void Bus::displayUsers() {
	if (!user[0].exist)
		cout << "pas d'usager" << endl;
	int i = 0;
	while (user[i].exist) {
		cout << i << ". ";
		user[i].affiche();
		i++;
	}
}