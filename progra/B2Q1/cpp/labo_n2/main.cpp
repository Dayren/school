#include "Class.h"

int main() {
	Usager us1("kek", true);
	us1.affiche();
	Usager us2("kok", true);
	us2.affiche();
	Usager us3("succ", false);
	us3.affiche();
	Usager us4("cum");
	us4.affiche();
	cout << endl;
	Bus b1(23, 2016, 14000);
	b1.afficher();
	Bus b2(23, 2016, 13000);
	b2.afficher();
	Bus b3(23, 2016, 15000);
	b3.afficher();
	cout << endl;

	if (b1.comparer(b1, b2)) cout << "b1 et b2 identique"<<endl;
	else cout << "b1 et b2 différent"<<endl;
	b2.augementerPoids();
	cout << endl;
	if (b1.comparer(b1, b2)) cout << "b1 et b2 identique" << endl;
	else cout << "b1 et b2 différent" << endl;
	if (b1.comparer(b1, b3)) cout << "b1 et b3 identique" << endl;
	else cout << "b1 et b3 différent" << endl;
	cout << endl;
	Bus b4 = b1.etrePlusLourd(b2, b3);
	cout << "le plus lourd :" << endl << "\t";
	b4.afficher();
	cout << endl;
	cout << endl;

	b1.displayUsers();
	b1.addUser(us1);
	b1.displayUsers();
	b1.addUser(us2);
	b1.addUser(us3);
	b1.addUser(us4);
	b1.displayUsers();


	system("pause");
	return 0;
}