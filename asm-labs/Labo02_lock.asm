;* Projet : Labo 02                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 13/10/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : Serrure électronique                                   *
;*                                                                      *
;************************************************************************
    list p=16F887, f=INHX8M ;   directive pour definir le processeur
    list c=90, n=60 ;       directives pour le listing
    #include <p16F887.inc> ;    incorporation variables spécifiques
    errorlevel -302 ;       pas d'avertissements de bank
    errorlevel -305 ;       pas d'avertissements de fdest

    __CONFIG _CONFIG1, _LVP_OFF & _WDT_OFF & _INTOSCIO
    __CONFIG _CONFIG2, _IESO_OFF & _FCMEN_OFF

;*************************************************************************
;* Définitions et Variables *
;*************************************************************************
    cblock 0x020
tmp,tmp2,tmp3,state,pass1, pass2, pass3, pass, buffer
;ici vous pouvez faire vos déclarations de variables
    endc

;*************************************************************************
;* Programme principal *
;*************************************************************************
    ORG 0x000 ; vecteur reset

START
    CLRF STATUS     ; INIT
    BSF STATUS,5    ; BANK 1
    CLRF TRISA      ; PORTA en output
    CLRF TRISD      ; PORTD en 0 pour ...
    BSF TRISD,4     ; INPUT
    BSF TRISD,5     ; INPUT
    BSF TRISD,6     ; INPUT
    BSF TRISD,7     ; INPUT

    BSF STATUS,6    ; BANK 3
    CLRF ANSEL      ; SIGNAL DIGITAL

    CLRF STATUS     ; BANK 0
    CLRF PORTA      ; INIT LES LEDS
    CLRF PORTD      ; INIT PORT

    CLRF pass       ; INIT pass
    CLRF state      ; INIT state

LOOP
    BSF PORTD,0     ; TEST COLONNE 1
    BTFSC PORTD,4   ; TEST LIGNE 1 : 1 enfoncé ?
    CALL T1     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,5   ; TEST LIGNE 2 : 4 enfoncé ?
    CALL T4     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,6   ; TEST LIGNE 3 : 7 enfoncé ?
    CALL T7     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,7   ; TEST LIGNE 4 : * enfoncé ?
    CALL TSTAR      ; (0)   OUI > appel fonction responsable du bouton
    BCF PORTD,0     ; STOP TEST COLONNE 1

    BSF PORTD,1     ; TEST COLONNE 2
    BTFSC PORTD,4   ; TEST LIGNE 1 : 2 enfoncé ?
    CALL T2     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,5   ; TEST LIGNE 2 : 5 enfoncé ?
    CALL T5     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,6   ; TEST LIGNE 3 : 8 enfoncé ?
    CALL T8     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,7   ; TEST LIGNE 4 : 0 enfoncé ?
    CALL T0     ; (0)   OUI > appel fonction responsable du bouton
    BCF PORTD,1     ; STOP TEST COLONNE 2

    BSF PORTD,2     ; TEST COLONNE 3
    BTFSC PORTD,4   ; TEST LIGNE 1 : 3 enfoncé ?
    CALL T3     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,5   ; TEST LIGNE 2 : 6 enfoncé ?
    CALL T6     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,6   ; TEST LIGNE 3 : 9 enfoncé ?
    CALL T9     ; (0)   OUI > appel fonction responsable du bouton
    BTFSC PORTD,7   ; TEST LIGNE 4 : # enfoncé ?
    CALL THASH      ; (0)   OUI > appel fonction responsable du bouton
    BCF PORTD,2     ; STOP TEST COLONNE 3

    GOTO LOOP       ; on boucle

T0
    CLRF PORTA
    MOVLW b'01111101' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,7   ; TEST LIGNE 4 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X00      ; W = 0

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T1
    CLRF PORTA
    MOVLW b'00000101' ; 0
    MOVWF PORTA     ; affiche 1
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,4   ; TEST LIGNE 1 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X01      ; W = 1
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T2
    CLRF PORTA
    MOVLW b'01101011' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,4   ; TEST LIGNE 1 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X02      ; W = 2
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T3
    CLRF PORTA
    MOVLW b'00101111' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,4   ; TEST LIGNE 1 : enfoncé ?
    GOTO $-2        ; (0)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X03      ; W = 3
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T4
    CLRF PORTA
    MOVLW b'00010111' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,5   ; TEST LIGNE 2 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X04      ; W = 4
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T5
    CLRF PORTA
    MOVLW b'00111110' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,5   ; TEST LIGNE 2 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X05      ; W = 5
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T6
    CLRF PORTA
    MOVLW b'01111110' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,5   ; TEST LIGNE 2 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X06      ; W = 6
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T7
    CLRF PORTA
    MOVLW b'00001101' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,6   ; TEST LIGNE 3 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X07      ; W = 7
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T8
    CLRF PORTA
    MOVLW b'01111111' ; 0
    MOVWF PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,6   ; TEST LIGNE 3 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0X08      ; W = 8
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale

T9
    MOVLW b'00111111' ; 0
    MOVWF PORTA     ; afficher PORTA
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,6   ; TEST LIGNE 3 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On recommence l'attente
    CLRF PORTA      ; efface le 7segment avant

    MOVLW 0x09      ; W = 9
    MOVWF buffer    ; buffer = W

    BTFSC state,0   ; mode serrure
    GOTO VERIFY     ; vérifie la valeur avec le chiffre correspondant
    BTFSC state,1   ; mode sauvegarde ?
    GOTO SAVE       ; sauvegarde la valeur pour le chiffre correspondant

    RETURN      ; retour boucle principale


TSTAR
    CALL WAITSHORT  ; laisse le temps à l'utilisateur de retirer son doigt
    BTFSC PORTD,7   ; TEST LIGNE 4 : enfoncé ?
    GOTO $-2        ; (1)   OUI > On revérifie

    BTFSC state,0   ; si serrure activé, afin d'éviter de réécrire le pass
    GOTO ERREUR     ; afin d'éviter de recréer un mot de passe.
    CALL CIRCLE     ; affiche une petite animation
    CALL MAKEPASS   ; appelle la fonction sauvegarde
    RETURN      ; retour boucle principale

THASH
    CALL WAITSHORT
    BTFSC PORTD,7   ; TEST LIGNE 4 : toujours enfoncé ?
    GOTO $-2        ; (1)   OUI > On revérifie
    BTFSC state,0   ; vérifie si on est en mode serrure
    GOTO ERREUR     ; (1)  oui > affiche Erreur et GOTO LOOP
    BTFSS state,2   ; vérifie si un pass a déjà été introduit
    GOTO ERREUR     ; (0)  NON > affiche Erreur et GOTO LOOP
    BSF state,0     ; (1)  OUI > active serrure avec pass précédent
    CLRF pass       ; on revérifie depuis le premier chiffre
            ; efface donc ce que l'utilisateur a rentrée
    CALL CIRCLE
    RETURN      ; retour boucle principale


;state,0 : serrure activé (1) ou pas encore (0) ?
;state,1 : mode sauvegarde (1) ou simple lecture (0)
;state,2 : un mdp est déjà sauvegardé (1) ou non (0)

;pass,4 : mauvais mot de pass (1), sinon on laisse à 0

;pass,1 ,2 ,3 : dans l'ordre : pass1, pass2, pass3 concerné.

MAKEPASS
    BSF state,1     ; state,1 = 1 -> mode sauvegarde
    BSF pass,1      ; pass,1 = 1 : pass1
    GOTO LOOP       ; utilisateur rentre chiffre 1
    BCF STATUS,0    ; on efface le Carry
    RLF pass        ; pass,2 = 1 : pass2
    GOTO LOOP       ; utilisateur rentre chiffre 2
    BCF STATUS,0
    RLF pass        ; pass,3 = 1 : pass3
    GOTO LOOP       ; utilisateur rentre chiffre 3
    CLRF pass       ; vérification des chiffres depuis le début
    RRF state       ; state,1 = 0 -> state,0 = 1 : serrure activé
    BSF state,2     ; on active le flag indiquant qu'un password existe

    CALL CIRCLE

    RETURN

SAVE
    MOVF buffer,0
    BTFSC pass,1    ; chiffre 1?
    GOTO $+5        ;   OUI > GOTO "MOVWF pass1"
    BTFSC pass,2    ; chiffre 2?
    GOTO $+5        ;   OUI > GOTO "MOVWF pass2"
    BTFSC pass,3    ; chiffre 3?
    GOTO $+5        ;   OUI > GOTO "MOVWF pass3"

    MOVWF pass1     ; sauvegarde chiffre dans pass1
    GOTO MAKEPASS+3 ; retourne après le premier GOTO LOOP
    MOVWF pass2     ; sauvegarde chiffre dans pass2
    GOTO MAKEPASS+6 ; retourne après le deuxième GOTO LOOP
    MOVWF pass3     ; sauvegarde chiffre dans pass3
    GOTO MAKEPASS+9 ; retourne après le dernier GOTO LOOP de MAKE PASS

VERIFY

    BTFSC pass,2    ; chiffre 2 à vérifier ?
    GOTO VERIFY2    ; oui
    BTFSC pass,3    ; chiffre 3 à vérifier ?
    GOTO VERIFY3    ; oui

            ; On vérifie donc le chiffre 1
    MOVF buffer,0
    SUBWF pass1,0   ; W = pass1 - W (valeur BP)
    BTFSS STATUS,2  ; w == f ?
    BSF pass,4      ; NON > flag mdp erronée activé

    BSF pass,2      ; prochaine entrée à vérifier est le 2ème chiffre
    GOTO LOOP       ; retour boucle principale pour prochains chiffres

VERIFY2

    MOVF buffer,0
    SUBWF pass2,0   ; W = pass2 - W (valeur BP)
    BTFSS STATUS,2  ; W == f ?
    BSF pass,4      ; NON > flag mdp erronée activé

    BCF pass,2
    BSF pass,3
    GOTO LOOP       ; retour boucle principale pour prochaines chifres


VERIFY3

    MOVF buffer,0
    SUBWF pass3,0   ; W = pass3 - W (valeur BP)
    BTFSS STATUS,2  ; W == F ?
    BSF pass,4      ; NON > ERREUR

    BTFSC pass,4    ; déjà trompé plus tôt ?
    GOTO ERREUR     ; OUI > ERREUR

    GOTO SUCCESS    ; SINON > mot de passe correcte.

CIRCLE
    CLRF PORTA      ; on s'assure que tout est éteint    _
    BSF PORTA,0     ; on allume led 0           | x
    CALL WAITMID    ; pendant 0.5 secondes      |_|

    BCF PORTA,0     ; on éteint la LED0      _
    BSF PORTA,2     ; on allume la LED2     | |
    CALL WAITMID    ; pendant 0.5 secondes  |_x

    BCF PORTA,2     ;  _
    BSF PORTA,5     ; | |
    CALL WAITMID    ; |x|

    BCF PORTA,5     ;  _
    BSF PORTA,6     ; | |
    CALL WAITMID    ; x_|

    BCF PORTA,6     ;  _
    BSF PORTA,4     ; x |
    CALL WAITMID    ; |_|

    BCF PORTA,4     ;  x
    BSF PORTA,3     ; | |
    CALL WAITMID    ; |_|
    BCF PORTA,3

    RETURN

SUCCESS
    MOVLW b'01011111'   ; A
    MOVWF PORTA     ; affiche A
    CALL WAITMID    ;
    CLRF PORTA
    CALL WAITSHORT
    MOVLW b'01011111'   ; A
    MOVWF PORTA     ; affiche A
    CALL WAITSHORT
    CLRF PORTA
    CALL WAITSHORT
    MOVLW b'01011111'   ; A
    MOVWF PORTA     ; affiche A
    CALL WAITSHORT
    CLRF PORTA

    CLRF pass       ; pass,3 = 0
    BCF state,0     ; mode serrure désactivé

    GOTO LOOP       ; retour boucle principale


ERREUR
    MOVLW b'01111010'   ; E
    MOVWF PORTA     ; affiche E
    CALL WAITSHORT    ; attendre 80ms
    CLRF PORTA      ; affiche RIEN
    CALL WAITSHORT    ;
    MOVLW b'01111010'
    MOVWF PORTA     ; affiche E
    CALL WAITSHORT    ;
    CLRF PORTA      ; affiche RIEN
    CALL WAITSHORT    ;
    MOVLW b'01111010'
    MOVWF PORTA     ; affiche E
    CALL WAITSHORT
    CLRF PORTA      ; affiche RIEN

    CLRF pass       ; efface entrées utilisateur
    BCF state,1     ; on quitte le mode sauvegarde
            ; si on était en mode serrure = rien ne change
            ; sinon l'utilisateur devra ré-appuyer sur *

    GOTO LOOP

WAITSHORT
    MOVLW 0xe0      ; W = 5
    MOVWF tmp2      ; tmp2 = 5;
    MOVLW 0xFF      ; REGISTRE TRAVAIL (W) = 255
    MOVWF tmp       ; tmp = W ( 255 )
    DECFSZ tmp,1    ; tmp -- && tmp == 0 ?
    GOTO $-1        ;       NON > On recomence donc 255 fois (260µs environ)
    DECFSZ tmp2,1   ;       OUI > tmp2-- et TEST : est égale à 0
    GOTO $-5        ;       NON > on recommence encore 4 fois le tout.
    RETURN          ;       OUI > 5*200µs = 1,1ms environ

WAITMID
    MOVLW 0x02      ; W = 75
    MOVWF tmp3      ; tmp2 = W (75)
    CALL WAITSHORT  ; attendre 1ms
    DECFSZ tmp3,1   ; tmp2-- &&     tmp2 == 0 ?
    GOTO $-2        ;       OUI > On attend 1,1ms encore 74 fois
    RETURN      ;       NON > temps total : 75*1,1ms = 80ms

END