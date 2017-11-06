/*
 *		Pour les énoncés suivants, donner le protoype ainsi que la définition de la fonctionc (avec le code fonctionnel).
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*		Soit une structure représentant les coordonnés d'un point dans un repère cartésien. La structure 
 *	comprend deux champs pour x et y sous forme de flottant. 
 *		Écrire une fonction recevant deux variables structurées de ce type et devant calculer et retourner la
 *	distance entre ces deux points. La formule utilisée est : AB = sqrt[(Xb-Xa)²+(Yb-Ya)²]
 */
typedef struct {
	float x;
	float y;
}coord;

float distance(coord p1, coord p2) {
	float dx, dy, d;
	
	dx = powf((p2.x - p1.x), 2);
	printf("(%.0f - %.0f)^2 = %.0f \n", p2.x, p1.x, dx);
	
	dy = powf((p2.y - p1.y), 2);
	printf("(%.0f - %.0f)^2 = %.0f \n\n", p2.y, p1.y, dy);
	return sqrtf(dx + dy);	
}

/*		Écrire une fonction permettant de compter le nombre d'échecs parmi des points présents dans un
 *	tableau à deux dimensions passé en argument. La première dimension du tableau correspond au point
 *	tandis que la deuxième dimension au total sur lequel porte le point. La valeur est retournée par la fonction.
 */
int nombreEchecs(float tab[2][5]) {
	int nbr = 0;
	int n = sizeof(tab[0]) / sizeof(tab[0][0]);
	printf("number of entries : %d \n", n);
	for (int i = 0; i < n; i++) {
		if (tab[0][i] < tab[1][i] / 2)
			nbr++;
	}
	return nbr;
}




/*		Écrire une fonction permettant de fournir au programme appelant le plus petit et le plus grand des
 *	entiers présents dans un tableau passé en argument. L'utilisation de variables globales n'est pas autorisé.
 */
typedef struct grape {
	int grand;
	int petit;
}grape_t;

struct grape funct(int tab[6]) {
	grape_t result;

	int pt = tab[0], gr = tab[0];

	for (int i = 1; i < 6; i++) {
		if (pt < tab[i])
			pt = tab[i];
		if (gr > tab[i])
			gr = tab[i];
	}
	
	result.grand = gr;
	result.petit = pt;
	printf("%d, %d\n", gr, pt);

	return result;
}

/*		Écrire une fonction permettant de convertir une coordonnée polaire en coordonnée cartésienne.
 *	Votre fonction recevra les coordonnées polaires (r et teta) sous forme de flottant et devra fournir les
 *  les coordonnées cartésiennes à la fonction appelante en utilisant les formules suivants :
 *			x = r * cos(teta)		y = r * sin(teta)
 */
typedef struct carte {
	float x;
	float y;
}carte_t;

struct carte pol2cart(float r, float teta) {
	 carte_t result;

	 result.x = r * cosf(teta);
	 result.y = r * sinf(teta);

	return result;
}

/************************************************************************************************************************
 *															TEST														*
 ************************************************************************************************************************/

void mainExam1() {

// ------------------- EXO 1 -------------------
	coord pt[4];
	pt[0].x = 1;
	pt[0].y = 1;

	pt[1].x = 2;
	pt[1].y = 2;

	pt[2].x = 1;
	pt[2].y = 3;

	pt[3].x = 3;
	pt[3].y = 1;
	
	float a = distance(pt[0], pt[1]);
	float b = distance(pt[0], pt[2]);
	float c = distance(pt[0], pt[3]);
	
	printf(" %.3f\n %.1f\n %.1f\n", a, b, c);
	printf("\n---------------------\n");

// ------------------- EXO 2 -------------------
	int echecs;

	float arr[2][5] = { { 8,12,15,4 }, { 20,30,20,10 } };
	echecs = nombreEchecs(arr);
	printf("%d \n", echecs);
	printf("\n---------------------\n");

// ------------------- EXO 3 -------------------
	int kek[6] = { 2,8,43,4,6,7 };
	grape test = funct(kek);

	/* < void getNumber(int numberArray[]) > is equivalent to < void getNumber(int* numberArray) >
	 *	 So either pass the length as parameter : void getNumber(int* numberArray, int len)
	 *	 or arrange for the array to end with a known sentinel value (-1, \0) and you do a while != sentinel value with a len++
	 */
	printf("%d, %d", test.grand, test.petit);
	printf("\n---------------------\n");
	
// ------------------- EXO 4 -------------------
	
	carte point = pol2cart(1, 2);
	printf("%.2f, %.2f", point.x, point.y);


	printf("\n---------------------\n");
	system("pause");
}
