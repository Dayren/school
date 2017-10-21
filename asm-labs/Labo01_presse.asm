;* Projet : Labo 01                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 6/10/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : LED0 allumé seulement quand enfoncé                    *
;*               LED3 s'allume ou s'éteint à chaque pression du bouton  *
;************************************************************************
    list p=16F883, f=INHX8M ;	directive pour definir le processeur
    list c=90, n=60 ;		directives pour le listing
    #include <p16F883.inc> ;	incorporation variables spécifiques
    errorlevel -302 ;		pas d'avertissements de bank
    errorlevel -305 ;		pas d'avertissements de fdest

    __CONFIG _CONFIG1, _LVP_OFF & _WDT_OFF & _INTOSCIO
    __CONFIG _CONFIG2, _IESO_OFF & _FCMEN_OFF

;*************************************************************************
;* Définitions et Variables *
;*************************************************************************
    cblock 0x020
tmp,tempo2,decla1,switch ;ici vous pouvez faire vos déclarations de variables
    endc

;*************************************************************************
;* Programme principal *
;*************************************************************************
    ORG 0x000 ; vecteur reset

START
    CLRF STATUS	    ; INIT
    BSF STATUS,5    ; BANK 1
    CLRF TRISA	    ; PORTA en output
    CLRF TRISC	    ; PORTC en 0 pour ...
    COMF TRISC	    ; PORTC en input

    BSF STATUS,6    ; BANK 3
    CLRF ANSEL	    ; SIGNAL DIGITAL
    CLRF STATUS	    ; BANK 0
    CLRF PORTA	    ; INIT LES LEDS

LOOPOFF
    BTFSS PORTC,3   ; TEST BOUTON 3 : enfoncé ?
    GOTO TOGGLEON3  ; (0)   OUI > c'est tipar pour l'allumer
    BTFSS PORTC,0   ; TEST BOUTON 0 : enfoncé ?
    CALL TOGGLE0    ; (0)   OUI > on commence le test de la LED
    GOTO LOOPOFF    ; (11)  NON > on loop et re-monitor

LOOPON
    BTFSS PORTC,3   ; TEST BOUTON 3 : enfoncé ?
    GOTO TOGGLEOFF3 ; (0)   OUI > et c'est reparti pour l'éteindre
    BTFSS PORTC,0   ; TEST BOUTON 0 : enfoncé ?
    CALL TOGGLE0    ; (0)   OUI > on commence le test de la LED
    GOTO LOOPON	    ; (11)   NON > on loop et re-monitor

TOGGLE0
    BTFSS PORTA,0   ; TEST LED 0 : éteinte ?
    CALL TOGGLEON0  ; (0)   OUI > On va allumer la LED
    CALL TOGGLEOFF0 ; (1)   NON > On va éteindre la LED
    RETURN

TOGGLEOFF3
    BCF PORTA,3	    ; ÉTEINDRE LED 3
    CALL WAIT	    ; On commence l'attente ( le bouton n'est pas parfait,
    ;		          il rebondit, on doit mettre en place un timer )
    BTFSS PORTC,3   ; TEST BOUTON : enfoncé ?
    GOTO $-2	    ; (0)   OUI > On recommence l'attente
    GOTO LOOPOFF    ; (1)   NON > On peut de retourner montirorer le bouton : la LED est allumé

TOGGLEON3
    BSF PORTA,3	    ; ALLUMER LED 3
    CALL WAIT	    ; On commence l'attente
    BTFSS PORTC,3   ; TEST BOUTON : enfoncé ?
    GOTO $-2	    ; (0)   OUI > On recommence l'attente
    GOTO LOOPON     ; (1)   NON > On peut de retourner montirorer le bouton : la LED est allumé

TOGGLEOFF0
    BCF PORTA,0	    ; ETEINDRE LED 0
    BTFSS PORTC,0   ; TEST BOUTON : enfoncé ?
    GOTO $-2	    ; (0)   OUI > On recommence l'attente
    RETURN	        ; (1)   NON > On retourne en arrière
    ;				> Boucle correspondante à LED 3 + monitor BPs

TOGGLEON0
    BsF PORTA,0	    ; ALLUMER LED 0
    BTFSS PORTC,0   ; TEST BOUTON : enfoncé ?
    GOTO $-2	    ; (0)   OUI > On recommence l'attente
    RETURN	        ; (1)   NON > On retourne en arrière
    ;				> Boucle correspondante à LED 3 + monitor BPs

WAIT
    MOVLW 0xFF	    ; REGISTRE TRAVAIL (W) = 255
    MOVWF tmp	    ; tmp = W ( 255 )
    DECFSZ tmp,1    ; tmp-- (décrémenté de 1) & TEST tmp : est égale à 0
    GOTO $-1        ;	    OUI > On recomence donc 255 fois
    RETURN          ;	    NON > 256*200ns*2 = 0.1024s [ car 2 opérations ]
    END


_______________________________________________________________________________________________________

    #define C0 PORTD,0
    #define C1 PORTD,1
    #define C2 PORTD,2
    ...
    cblock 0x20

table addwf PCL
    retlw b'01100111' ;C4L4 : D     index = 0
    retlw b'01111000' ;C4L3 : C     1


rlf result
skpnc
goto affich (tableau)
incf index
return

(la fonction est appellé 4fois) puis si toujours rien, on incrémente pour un changement de colonne et on recommence.