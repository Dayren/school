/*	Soit un fichier texte.
 *
 *	Ecrire un programme permettant sur base de tout fichier texte de créer un nouveau fichier dans lequel
 *	toutes les lignes auront été préfixées du numéro de ligne correspondant.
 *	A vous de choisir la façon dont l'utilisateur entrera le nom du fichier ainsi que la vérification de son existence.
 *	La première ligne sera préfixée du numéro 1
 *	La première ligne sera préfixée du numéro 2...
 */

#include <stdio.h>
#include <stdlib.h>

int main() {
	FILE * fwithout;
	FILE * fwith;
	char line[500];

	fwithout = fopen("D:\\home\\Nami-Touko\\Desktop\\without.txt", "r");
	if (fwithout == NULL) { 
		printf("fichier introuvable ou inaccessible\n");
		system("pause");
		return 1;
	}

	fwith = fopen("D:\\home\\Nami-Touko\\Desktop\\with.txt", "w");
	if (fwith == NULL) {
		printf("le nouveau fichier n'a pas pu etre cree\n");
		system("pause");
		return 2;
	}
	
	int i = 1;
	while (!feof(fwithout)) {
		fscanf(fwithout, "%[^\n]\n", line);
		fprintf(fwith, "%d. %s\n", i, &line);
		i++;
	}

	system("pause");
	return 0;
}
