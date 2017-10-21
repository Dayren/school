#include <source.h>
#include <string>
#include<iostream>

using namespace std;

AgenceImmo::AgenceImmo(string nom_, string prenom_, string tel_) {
    nom = nom_;
    prenom = prenom_;
    tel = tel_;
}

Bien::Bien(){
    cout<<"constructor"<<endl;
}
Bien::afficher(){
    cout<<"taille : "<<taille<<endl;
}

Maison::Maison(){
    cout<<"constructor"<<endl;
}
Maison::afficher(){
    Bien::afficher();
    cout<<"mitoyenne : "<< mito <<endl;
}

Appart::Appart(){
    cout<<"constructor"<<endl;
}
Appart::Appart(){
    Bien::afficher();
    cout<<"etage : "<< etage <<endl;
}

Personne::Personne(){
    cout<<"constructor"<<endl;
}
Personne::afficher(){
    cout<< nom <<", "<< prenom <<endl;
}

Employe::Employe(){
    cout<<"constructor"<<endl;
}
Employe::afficher(){
    Personne::afficher();
    cout<<"heures prestées : "<< heure <<endl;
}

Client::Client(){
    cout<<"constructor"<<endl;
}
Client::afficher(){
    Personne::afficher();
    cout<<"numéro de téléphone : "<< tel <<endl;
    cout<<"#"<< num <<endl;
}

Locataire::Locataire() {
    cout<<"constructor"<<endl;
}
Locataire::afficher(){
    Client::afficher();
    cout<<"salaire : "<< salaire <<endl;
}

Proprio::Proprio() { 
    cout<<"constructor"<<endl;
}
Proprio::afficher() {
    Client::afficher();
    cout<<"type : "<< type <<endl;
}

Locaprio::Locaprio() {
    cout<<"constructor"<<endl;
}
Locaprio::afficher(){
    Client::afficher();
    cout<<" salaire : "<< salaire <<endl;
    cout<<" type : "<< type <<endl;
}