#include "Source.h"
#include <stdio.h>
#include <stdlib.h>


int maximum(int a, int b, int c, int d){
	int m1, m2;
	if (a >= b)
		m1 = a;
	else
		m1 = b;
	if (c >= d)
		m2 = c;
	else
		m2 = d;
	if (m1 >= m2)
		return m1;
	else
		return m2;
}
char maximum(char a, char b, char c, char d) {
	char m1, m2;
	if (a >= b)
		m1 = a;
	else
		m1 = b;
	if (c >= d)
		m2 = c;
	else
		m2 = d;
	if (m1 >= m2)
		return m1;
	else
		return m2;
}
string maximum(string a, string b, string c, string d) {
	string m1, m2;
	if (a.length() >= b.length())
		m1 = a;
	else
		m1 = b;
	if (c.length() >= d.length())
		m2 = c;
	else
		m2 = d;
	if (m1.length() >= m2.length())
		return m1;
	else
		return m2;
}
