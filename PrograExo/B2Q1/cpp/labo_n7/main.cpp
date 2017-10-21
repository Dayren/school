#include "source.h"
#include <typeinfo>


int main() {
	Address adr(10, "boulevard des Allies", "7500", "Tournai");
	Agence AI("Leclercq", "069/889966", adr);

	House *g1 = new House(true, 17);
	Appart *g2 = new Appart(2, 6);
	Appart *g3 = new Appart(2, 6);

	Goods *pg1 = g1;
	Goods *pg2 = g2;
	Goods *pg3 = g3;

	cout << typeid(pg1).name();
	cout << endl;
	cout << endl;

	Employee *e1 = new Employee(35, "Durant", "Marcel");
	Locat *l1 = new Locat(2000, 1, "069/754545", "Zoro", "Louis");
	Locat *l2 = new Locat(1500, 4, "069/212121", "Pierre", "Jean");
	Proprio *p1 = new Proprio("rentier", 2, "069/556644", "Wilfart", "Emmanuel");
	Proloc *pl = new Proloc(3000, "gros", 3, "069/886622", "Sardou", "Michel");

	AI.addGoods(g1);
	AI.addGoods(g2);
	p1->addGoods(g1);
	p1->addGoods(g2);

	system("pause");
	system("cls");

	AI.addPeople(e1);
	AI.addPeople(l1);
	AI.addPeople(l1);
	AI.addPeople(p1);
	AI.addPeople(pl);
	system("pause");


	system("cls");
	AI.display();
	system("pause");

	system("cls");
	
	AI.associate(g1, pl);
	AI.associate(g1, p1);
	AI.associate(g2, l1);
	AI.associate(g2, p1);
	AI.associate(g3, l2);
	AI.associate(g3, pl);
	AI.displayAss();
	system("pause");

	return 0;
}