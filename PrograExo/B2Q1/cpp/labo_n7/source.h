#pragma once
#include <iostream>
#include <string>
#include <vector>

using namespace std;

//class Address;
//class Goods;
//class House;
//class Appart;
//class people;
//class employee;
//class client;
//class locat;
//class proprio;
//class proloc;

class Address {
private:
	int nbr;
	string strt, post, town;

public:
	Address(int nb, string s, string p, string t);
	Address() {}
	~Address();

	void display();
};


class Goods {
protected:
	int size;
public:
	Goods(int s);
	~Goods();

	virtual void display();
};

class House : public Goods {
private:
	bool mito;

public:
	House(bool m, int s);
	~House();

	virtual void display();
};

class Appart : public Goods {
private:
	int level;

public:
	Appart(int l, int s);
	~Appart();

	virtual void display();
};

class People {
protected:
	string name;
	string fname;

public:
	People(string n, string fn);
	~People();

	virtual void display()=0;
};

class Employee : public People {
private:
	int hour;

public:
	Employee(int h, string n, string fn);
	~Employee();

	void display();
};

class Client : public People {
protected:
	int nbr;
	string tel;

public:
	Client(int nb, string tl, string n, string fn);
	~Client();
	void display();
};

class Locat : public virtual Client {
protected:
	int wage;

public:
	Locat(int w, int nb, string tl, string n, string fn);
	~Locat();

	void display();
};

class Proprio : public virtual Client {
protected:
	string type;

	vector<Goods*> vguds;

public:
	Proprio(string t, int nb, string tl, string n, string fn);
	~Proprio();
	void display();

	void addGoods(Goods * g);
};


class Proloc : public Proprio, public Locat {
public:
Proloc(int w, string t, int nb, string tl, string n, string fn);
~Proloc();

void display();
};
/**/

class Agence {
private:
	string num;
	string tel;

	Address adr;

	vector<Goods*> vguds;
	vector<People*> vppl;


	//association biens et personnes
	vector<Goods*> assg;
	vector<People*> assp;

public:
	Agence(string n, string t, Address a);
	~Agence();

	void display();

	void addGoods(Goods *g);
	void addPeople(People *p);

	void associate(Goods *g, People *p);
	void displayAss();
};
