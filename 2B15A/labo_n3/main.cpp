#pragma once
#include "Source.h"


int main() {
	char a;
	Airport a1("De Gaulle", 40, 3, "rue du gen. de Gaulle", 77123, "Paris");
	a1.display();

	//cin >> a;
	cout << endl;

	Piste p1(100, 32, 1);
	p1.display();
	Piste p2(120, 31, 2);
	p2.display();
	Piste p3(95, 27, 3);
	p3.display();
	Piste p4(p3);
	p4.display();

	//cin >> a;
	cout << endl;

	a1.add(p1); a1.add(p2); a1.add(p3); a1.add(p4);
	a1.displayP();

	//cin >> a;
	cout << endl;

	cout << "p1 & p2 -" << a1.pistecmp(0, 1) << endl;
	cout << "p1 & p2 verif -" << a1.pistecmp(p1, p2) << endl;
	cout << "p3 & p4 -" << a1.pistecmp(2, 3) << endl;
	cout << "p3 & p4 verif-" << a1.pistecmp(p3, p4) << endl;

	//cin >> a;
	cout << endl;

	cout << "nombre de pistes : " << a1.getNbrP() << endl;
	system("pause");
	return 0;
}