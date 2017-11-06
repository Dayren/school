/*	Soit un fichier texte possédant l'extension .c et correspondant à l'un de vos programmes.
 *	Ce fichier comprend des commentaires qui pour rappel sont:
 *	-toute ligne commençant par les caractères //
 *	-tout bloc de lignes dont les premiers caractères du bloc sont /* et les derniers */
/*	
 *	Ecrire un programme permettant sur base du fichier d'origine de créer un nouveau fichier dont les
 *	commentaires auront été supprimés.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.>

void mainExam3(){
	FILE * file;
	FILE * filenew;

	char path[] = "D:\\home\\Nami-Touko\\Desktop\\old.c";
	char pathnew[] = "D:\\home\\Nami-Touko\\Desktop\\new.c";
	char c, d;
	char useless[255];

	file = fopen(path, "r");
	if (file == NULL ) {
		printf("fichier introuvable\n");
		system("pause");
		return;
	}

	filenew = fopen(pathnew, "w");
	if (filenew == NULL) {
		printf("le ou les fichiers n'ont pas pu être créé\n");
		system("pause");
		return;
	}
	
	do {
		c = getc(file);
		if (c != '/')
			fprintf(filenew, "%c", c);
		else {
			d = getc(file);
			
			if (d == '/')
				fscanf(file, "%[^\n]\n", useless);
			
			else if (d == '*')
				fscanf(file, "%[^*/]*/", useless);

			else
				fprintf(filenew, "%c%c", c, d);			
		}
	} while (c != EOF);

	
	system("pause");
	_fcloseall();
	return;
}
