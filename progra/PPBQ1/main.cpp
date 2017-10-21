#include <iostream>
#include <iomanip>
#include <consoleapi.h>
using namespace std;

void mainMenu(int a) {
	/*cout << setw(71) << setfill('+') << ""<< endl;
	cout << "++"<< setw((71-5)/2) << setfill('-')<<  "ZOO" << setfill((71-3)/2) << "++" << endl;
	
	cout << setw(15) << setfill('+') << "" << endl;*/
	// 1-5-3-5-1
	// 1-8-6;

	
	// 55-3-55 is okay;
	int b = a * 2 + 3;
	cout << setw(b) << setfill('+') << "" << endl;
	cout << setiosflags(ios::left);
	cout << setw(a) << setfill('-') << "+" << resetiosflags(ios::left);
	cout << "ZOO";
	cout << setiosflags(ios::right);
	cout << setw(a) << setfill('-') << "+" << endl << resetiosflags(ios::right);
	cout << setw(b) << setfill('+') << "" << endl;
	cout <<"\n"<< endl;


}

int main() {
	for (int i = 30; i < 90; i += 5) {
		cout << i << endl;
		mainMenu(i);
	}
	string str;
	
	system("pause");
	
}
