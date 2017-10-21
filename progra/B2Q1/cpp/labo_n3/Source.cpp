#include "Source.h"



Piste::Piste(int len_, int compo_, int num_) {
	len = len_;
	compo = compo_;
	num = num_;
}
Piste::Piste(Piste &pi) {
	len = pi.len;
	compo = pi.compo;
	num = pi.num;
}

Piste::~Piste() {
	cout << "Destructeur Piste" << endl;
}

bool Piste::lencmp(Piste p1, Piste p2) {
	return p1.len == p2.len;
}
bool Piste::compocmp(Piste p1, Piste p2) {
	return p1.compo == p2.compo;
}
bool Piste::numcmp(Piste p1, Piste p2) {
	return p1.num == p2.num;
}

void Piste::display() {
	cout << "Piste #" << num << endl;
	cout << "C0x" << compo << "\t" << len << "m" << endl;
	cout << endl;
}

// -----------------------------------------------------


Adresse::Adresse(int num_, string rue_, int code_, string ville_) {
	num = num_;
	rue = rue_;
	code = code_;
	ville = ville_;
}
Adresse::~Adresse() {
	cout << "Destructeur Adresse" << endl;
}

void Adresse::display() {
	cout << num << " " << rue << "," << endl;
	cout << code << "  " << ville << endl;
}

// -----------------------------------------------------
Airport::Airport(string nom_, int taille_, int num_, string rue_, int code_, string ville_) {
	nom = nom_;
	taille = taille_;
	addr.num = num_;
	addr.rue = rue_;
	addr.code = code_;
	addr.ville = ville_;
}
Airport::~Airport() {
	cout << "Destructeur Airport" << endl;
}

void Airport::add(Piste p1) {
	pst[nbrP] = p1;
	nbrP++;
}
bool Airport::pistecmp(Piste p1, Piste p2) {
	if (!(p1.compocmp(p1, p2)))
		return false;
	else if (!(p1.lencmp(p1, p2)))
		return false;
	else if (!(p1.numcmp(p1, p2)))
		return false;
	else
		return true;
}
bool Airport::pistecmp(int a, int b) {
	if (!(pst[a].compocmp(pst[a], pst[b])))
		return false;
	else if (!(pst[a].lencmp(pst[a], pst[b])))
		return false;
	else if (!(pst[a].numcmp(pst[a], pst[b])))
		return false;
	else
		return true;
}
void Airport::displayP() {
	for (int i = 0; i < nbrP; i++)
		pst[i].display();
}

void Airport::display() {
	cout << "Aeroport " << nom << ", " << taille << "km" << endl;
	addr.display();
	cout << endl;
}
int Airport::getNbrP() {
	return nbrP;
}

