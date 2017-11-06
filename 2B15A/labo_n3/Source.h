#pragma once
#include <iostream>
#include <string>

using namespace std;


class Piste {
private:
	int len;
	int compo;
	int num;

public:
	Piste(int len_ = 0, int compo_ = 0, int num_ = 0);
	Piste(Piste &pi);
	~Piste();

	bool lencmp(Piste p1, Piste p2);
	bool compocmp(Piste p1, Piste p2);
	bool numcmp(Piste p1, Piste p2);

	void display();
};

class Adresse {
public:
	int num;
	string rue;
	int code;
	string ville;

	Adresse(int num_ = 0, string rue_ = "", int code_ = 0, string ville_ = "");
	~Adresse();

	void display();
};

class Airport {
private:
	string nom;
	int taille;
	Adresse addr;
	Piste pst[50];

	int nbrP = 0;
public:
	Airport(string nom_ = "", int taille = 0, int num_ = 0, string rue_ = "", int code_ = 0, string ville_ = "");
	~Airport();

	void add(Piste p1);
	bool pistecmp(Piste p1, Piste p2);
	bool pistecmp(int a, int b);
	void displayP();

	void display();
	int getNbrP();
};