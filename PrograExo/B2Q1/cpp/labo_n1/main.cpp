#include "Source.h"
#include <string>
#include <iostream>

using namespace std;

int main(int argc, char * argv[]) {
	bool leave = false;
	int choice;
	char plus;

	int ent;
	char car;
	string chain;
	string arg2(argv[2]);
	string arg3(argv[3]);
	string arg4(argv[4]);

	if (argc != 5) {
		cout << "not enough arguments, please retry" << endl;
		system("pause");
		return -1;
	}

	while (!leave) {
		system("cls");
		cout << "************************************" << endl;
		cout << "* Pour le max des entiers, tapez 1 *" << endl;
		cout << "* Pour le max des chars,   tapez 2 *" << endl;
		cout << "* Pour le max des strings, tapez 3 *" << endl;
		cout << "*               ***                *" << endl;
		cout << "*      Pour sortir, tapez 0        *" << endl;
		cout << "************************************" << endl;
		cin >> choice;
		if (choice == 0) {
			return 0;
		}
		system("cls");
		cout << "************************************" << endl;
		cout << "*Ajouter un argument en plus? (y/n)*" << endl;
		cout << "************************************" << endl;
		cin >> plus;
		cout << endl;

		if (plus == 'y') {
			switch (choice) {
			case 1:
				cout << "nombre à ajouter : ";
				cin >> ent;
				cout << "************************************" << endl;
				cout << "le max est : " << maximum(atoi(arg2.c_str()), atoi(arg3.c_str()), atoi(arg4.c_str()), ent) << endl;
				break;

			case 2:
				cout << "caractère à ajouter : ";
				cin >> car;
				cout << "************************************" << endl;
				cout << "le max est : " << maximum(argv[2][0], argv[3][0], argv[4][0], car) << endl;
				break;

			case 3:
				cout << "chaine à ajouter : ";
				cin >> chain;
				cout << "************************************" << endl;
				cout << "le max est : " << maximum(arg2, arg3, arg4, chain) << endl;
				break;

			default:
				break;
			}
		}
		else {
			switch (choice) {
			case 1:
				cout << "************************************" << endl;
				cout << "le max est : " << maximum(stoi(arg2), stoi(arg3), stoi(arg4)) << endl;
				break;

			case 2:
				cout << "************************************" << endl;
				cout << "le max est : " << maximum(argv[2][0], argv[3][0], argv[4][0]) << endl;
				break;

			case 3:
				cout << "************************************" << endl;
				cout << "le max est : " << maximum(arg2, arg3, arg4) << endl;
				break;

			default:
				break;
			}
		}
		system("pause");
	// end of while
	}
}