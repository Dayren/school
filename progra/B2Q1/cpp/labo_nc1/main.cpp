#include "Source.h"

int main() {
	/*Circulation circulation("Tournai", 27, 10, 2016);

	Velo *v1 = new Velo("vtt");
	Velo *v2 = new Velo("route");
	Automobile *a1 = new Automobile("Ford", 60);
	Camion *c1 = new Camion(1000, "Mercedes", 200);
	Camion *c2 = new Camion(1000, "Mercedes", 200);
	Camion *c3 = new Camion(1000, "Mercedes", 200);

	circulation.addVehicule(v1);
	circulation.addVehicule(a1);
	circulation.addVehicule(c1);
	circulation.addVehicule(v2);

	cout << "affiche les infos de la circulation : " << endl;
	circulation.afficher();
	cout << endl;

	cout << "affiche tous les véhicules de la circulation : " << endl;
	circulation.afficherVehicules();
	cout << endl;

	cout << "affiche nombre de camions créés :" << endl;
	cout << Camion::getNbc() << endl;
	cout << endl;

	cout << "compare deux vélos (vtt & route)" << endl;
	if (v1->comparer(v1, v2))
		cout << "identique" << endl;
	else
		cout << "différent" << endl;
	cout << endl;
	*/
	Velo v1("vtt");
	Vehicule v2();
	
	
	v1.afficher();
	

	system("pause");
	return 0;
}