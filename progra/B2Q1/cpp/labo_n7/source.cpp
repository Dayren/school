#include "source.h"

/************************************************************************/
/*								AGENCE									*/
/************************************************************************/

Agence::Agence(string n, string t, Address a) {
	adr = a;
	num = n;
	tel = t;
}
Agence::~Agence() { cout << "Destroying Agence" << endl; }

void Agence::display() {
	int i = 0;
	adr.display();
	cout << "numero: " << num << "\t" << tel << endl;
	cout << "------------ GOODS ------------" << endl;
	for each (Goods *g in vguds) {
		cout << i << ". ";
		g->display();
		i++;
	}
	cout << "------------ PEOPLE ------------" << endl;
	i = 0;
	for each (People *p in vppl) {
		cout << i << ". ";
		p->display();
		i++;
	}
}


void Agence::addGoods(Goods *g) {
	cout << "---- Adding Goods to Agence ----" << endl;
	vguds.push_back(g);
	g->display();
	cout << "               --" << endl;
}
void Agence::addPeople(People *p) {
	cout << "---- Adding People to Agence ----" << endl;
	vppl.push_back(p);
	p->display();
	cout << "               --" << endl;
}

void Agence::associate(Goods *g, People *p) {
	cout << "---- Associating ----" << endl;
	assg.push_back(g);
	assp.push_back(p);
}

void Agence::displayAss() {
	int max = assg.size();
	int i;

	for (i = 0; i < max; i++) {
		cout << "-------------------------" << endl;
		assg[i]->display();		//	vector<Goods*>
		assp[i]->display();		//  vector<Goods*>
		cout << endl;

	}
}
/************************************************************************/
/*								ADDRESS									*/
/************************************************************************/
Address::Address(int nb, string s, string p, string t) {
	nbr = nb;
	strt = s;
	post = p;
	town = t;
}
Address::~Address() { cout << "Destroying Address" << endl; }

void Address::display() {
	cout << strt << ", " << nbr << endl;
	cout << post << "\t" << town << endl;
}

/************************************************************************/
/*								GOODS									*/
/************************************************************************/
Goods::Goods(int s) {
	size = s;
}
Goods::~Goods() { cout << "Destroying Goods" << endl; }

void Goods::display() {
	string s = typeid(this).name();
	cout << "GOODS:" << endl;
	cout << "\tsize: " << size << endl;
}

/************************************************************************/
/*								HOUSE									*/
/************************************************************************/
House::House(bool m, int s):Goods(s) {
	mito = m;
}
House::~House() { cout << "Destroying House" << endl; }

void House::display() {
	cout << "HOUSE:" << endl;
	cout << "\tsize: " << size << endl;
	if (mito)
		cout << "\tadjoined" << endl;
	else
		cout << "\tstandalone" << endl;
}


/************************************************************************/
/*								APPARRT									*/
/************************************************************************/
Appart::Appart(int l, int s) : Goods(s) {
	level = l;
}
Appart::~Appart() { cout << "Destroying Appart" << endl; }

void Appart::display() {
	cout << "Appart:" << endl;
	cout << "\tsize: " << size << endl;
	cout << "\tlevel: " << level << endl;
}
/************************************************************************/
/*								PEOPLE									*/
/************************************************************************/
People::People(string n, string fn) {
	name = n;
	fname = fn;
}
People::~People() { cout << "Destroying People" << endl; }

/************************************************************************/
/*								EMPLOYEE								*/
/************************************************************************/
Employee::Employee(int h, string n, string fn) :People(n, fn) {
	hour = h;
}
Employee::~Employee() { cout << "Destroying Employee" << endl; }

void Employee::display() {
	cout << "Employee:" << endl;
	cout << "\tname: " << name << " " << fname << endl;
	cout << "\thours worked: " << hour << endl;
}

/************************************************************************/
/*								CLIENT									*/
/************************************************************************/
Client::Client(int nb, string tl, string n, string fn) :People(n, fn) {
	nbr = nb;
	tel = tl;
}
Client::~Client() { cout << "Destroying Client" << endl; }

void Client::display() {
	cout << "Client:" << endl;
	cout << "\tName: " << name << " " << fname << endl;
	cout << "\tClient number: " << nbr << "  - tel: " << tel << endl;
}

/************************************************************************/
/*								LOCAT									*/
/************************************************************************/
Locat::Locat(int w, int nb, string tl, string n, string fn) :Client(nb, tl, n, fn) {
	wage = w;
}
Locat::~Locat() { cout << "Destroying Locat" << endl; }

void Locat::display() {
	cout << "Locat:" << endl;
	cout << "\tName: " << name << " " << fname << endl;
	cout << "\tClient number: " << nbr << "  - tel: " << tel << endl;
	cout << "\twage: " << wage << endl;
}

/************************************************************************/
/*								PROPRIO									*/
/************************************************************************/
Proprio::Proprio(string t, int nb, string tl, string n, string fn) :Client(nb, tl, n, fn) {
	type = t;
}
Proprio::~Proprio() { cout << "Destroying Proprio" << endl; }

void Proprio::display() {
	int i = 0;
	cout << "Proprio:" << endl;
	cout << "\tName: " << name << " " << fname << endl;
	cout << "\tClient number: " << nbr << "  - tel: " << tel << endl;
	cout << "\ttype: " << type << endl;
	cout << "    goods :" << endl;
	for each(Goods* g in vguds) {
		cout << "\t" << i << ". ";
		g->display();
		i++;
	}
}

void Proprio::addGoods(Goods *g) {
	cout << "---- Adding Goods to Proprio ----" << endl;
	vguds.push_back(g);
	g->display();
	cout << "               --" << endl;

}

/************************************************************************/
/*								PROLOC									*/
/************************************************************************/

Proloc::Proloc(int w, string t, int nb, string tl, string n, string fn) :Proprio(t, nb, tl, n, fn), Locat(w, nb, tl, n, fn), Client(nb,tl,n,fn) {
	
}
Proloc::~Proloc() { cout << "Destructing Proloc" << endl; }
void Proloc::display() {
	int i = 0;
	cout << "Proprio:" << endl;
	cout << "\tName: " << name << " " << fname << endl;
	cout << "\tClient number: " << nbr << "  - tel: " << tel << endl;
	cout << "\ttype: " << type << endl;
	cout << "\twage: " << wage << endl;
	cout << "    goods :" << endl;
	for each(Goods* g in vguds) {
		cout << "\t" << i << ". ";
		g->display();
		i++;
	}
}
/**/