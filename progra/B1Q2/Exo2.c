/*
 *	Soit un fichier au format CSV reprenant les fiches signalétiques des étudiants. Chaque enregistrement
 *	dans ce fichier aura la structure suivante :
 *	Matricule, Nom, Prénom, Sexe
 *	Le Matricule, le nom et le prénom sous forme d'une chaîne de caractère et le sexe sous la forme d'un
 *	seul caractère (M: masculin, F: féminin). Le séparateur de champ est une virgule et le séparateur
 *	d'enregistrement le caractère '\n'
 *	Ex: HELHA101,Dubard,Jean,M
 *
 *	Ecrire un programme recevant en argument lors de son exécution le chemin complet du fichier CSV
 *		Votre programme devra:
 *	-Récupérer l'argument. Afficher un msg d'erreur en cas d'absence de l'argument et sortir du programme
 *	-Vérifier l'existence du fichier et dans le cas ou le fichier n'existep pas, afficher un message d'erreur et sortir du programme
 *	-Votre programme devra créer deux fichiers. Si votre fichier de base fourni en argument s'appelle Student.txt
 *		(il peut posséder n'importe quel nom), les deux fichiers StudentM.txt et StudentF.txt devront être créés
 *	-L'ensemble des étudiants de sexe masculin trouvés dans le fichier Student.txt seront copiés dans le fichier StudentM.txt
 *		et les étudiants de sexe féminin seront copiés dans le fichier StudentF.txt
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int mainExam2(int argc,char * argv[]) {
	FILE * fichier;
	FILE * fichierF;
	FILE * fichierM;

//	char chemin[] = "D:\\home\\Nami-Touko\\Desktop\\Student.txt";
	char *path;
	path = new char[strlen(argv[1])+1];
	strcpy(path, argv[1]);


/**/printf("%s\n", path);

	char *pathF, *pathM;
	pathF = new char[strlen(path) + 2]; pathM = new char[strlen(path) + 2];
	strcpy(pathF, path);				strcpy(pathM, path);
/**/printf("%s\n", pathF);				printf("%s\n", pathM);

	pathF[strlen(path)+1] = '\0'; 		pathM[strlen(path) + 1] = '\0';
	pathF[strlen(path)] = 't';			pathM[strlen(path)] = 't';
	pathF[strlen(path) - 1] = 'x';		pathM[strlen(path) - 1] = 'x';
	pathF[strlen(path) - 2] = 't';		pathM[strlen(path) - 2] = 't';
	pathF[strlen(path) - 3] = '.';		pathM[strlen(path) - 3] = '.';
	pathF[strlen(path) - 4] = 'F';		pathM[strlen(path) - 4] = 'M';
/**/printf("%s\n", pathF );				printf("%s\n", pathM);




	//printf("%s\n", chemin);

	if (argc != 2) {
		printf("nombre d'arguments invalides\n");
		system("pause");
		return 1;
	}

	fichier = fopen(path, "r");
	if (fichier == NULL){
		printf("le fichier specifie est introuvable ou ne peut pas etre accede \n");
		system("pause");
		return 2;
	}

	fichierF = fopen(pathF, "w");
	fichierM = fopen(pathM, "w");
	if (fichierF == NULL || fichierM == NULL) {
		printf("le ou les fichiers n'ont pas pu etre cree\n");
		system("pause");
		return 3;
	}
	
	char matricule[10], nom[25], prenom[25], sexe;

	while (!feof(fichier)) {
		// HELHA101,Dubard,Jean,M
		fscanf(fichier, "%[^,],%[^,],%[^,],%c\n", matricule, nom, prenom, &sexe);
		if (sexe == 'M')
			fprintf(fichierM, "%s,%s,%s,%c\n", matricule, nom, prenom, sexe);
		else
			fprintf(fichierF, "%s,%s,%s,%c\n", matricule, nom, prenom, sexe);
	}


	delete[](pathM);
	delete[](pathF);
	delete[](path);
	_fcloseall();
	system("pause");
	return 0;
}
