;* Projet : Examen 06                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 18/12/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : réaliser une calculatrice                              *
;*                                                                      *
;************************************************************************
    list p=16F887, f=INHX8M ; directive pour definir le processeur
    list c=90, n=60 ; directives pour le listing
    #include <p16F887.inc> ; incorporation variables spécifiques
    errorlevel -302 ; pas d'avertissements de bank
    errorlevel -305 ; pas d'avertissements de fdest


    __CONFIG _CONFIG1, _LVP_OFF & _WDT_OFF & _INTOSCIO
    __CONFIG _CONFIG2, _IESO_OFF & _FCMEN_OFF


;*************************************************************************
;* Définitions et Variables *
;*************************************************************************
    cblock 0x020
    tempo1,tempo2,tempo3,gauche,flag,var1,var2  ; variables
    endc


;*************************************************************************
;* Programme principal *
;*************************************************************************
    ORG 0x000 ; vecteur reset
;
;flag
; 7   6   5   4   3   2   1   0
;--------------------------------
;   |   |   |   |   | 0 | 0 | 1 |
;--------------------------------
;                    +-   #   sym



START
    CLRF STATUS     ; Bank 0
    BSF STATUS,5    ; Bank 1
    CLRF TRISA      ; tout en ouput
    MOVLW 0xf0      ; colonne en output, lignes en input
    MOVWF TRISD     ; pour digipad
    CLRF STATUS     ; Bank 0
    CLRF flag       ; init flag
    BSF flag,0      ; on commence par un chiffre

MAINLOOP
    ;CALL TEMPO
    BSF PORTD,0 ; colonne 1
    BTFSS PORTD,4   ; ligne 1
    CALL PRS1
    BTFSS PORTD,5   ; ligne 2
    CALL PRS4
    BTFSS PORTD,6   ; ligne 3
    CALL PRS7
    BTFSS PORTD,7   ; ligne 4
    CALL STAR

    BSF PORTD,1 ; colonne 2
    BTFSS PORTD,4   ; ligne 1
    CALL PRS2
    BTFSS PORTD,5   ; ligne 2
    CALL PRS5
    BTFSS PORTD,6   ; ligne 3
    CALL PRS8
    BTFSS PORTD,7   ; ligne 4
    CALL PRS0

    BSF PORTD,2 ; colonne 3
    BTFSS PORTD,4   ; ligne 1
    CALL PRS3
    BTFSS PORTD,5   ; ligne 2
    CALL PRS6
    BTFSS PORTD,6   ; ligne 3
    CALL PRS9
    BTFSS PORTD,7   ; ligne 4
    CALL CROIS

    BSF PORTD,3 ; colonne 4
    BTFSS PORTD,4   ; ligne 1
    CALL PRSA
    BTFSS PORTD,5   ; ligne 2
    CALL PRSB
    BTFSS PORTD,6   ; ligne 3
    CALL PRSC
    BTFSS PORTD,7   ; ligne 4
    CALL PRSD

PRS1
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x01      ; W = 1
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2

    BCF flag,0           ; on veut + - ou =

    CALL TEMPO
    RETURN

PRS2
        BTFSS flag,0         ;flage,0 = 0 si pas chiffre; flage,0 = 1 si chiffre
        GOTO ERREUR

        MOVLW 0x02          ;W = 2
      BTFSS flag,1           ;flage,1 = 0 si premier chiffre; = si deuxième chiffre
    MOVWF var1
    MOVWF var2

    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN
PRS3
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x03      ; W = 3
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN

PRS4
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x04      ; W = 4
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN
PRS5
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x05      ; W = 5
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN
PRS6
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x06      ; W = 6
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN
PRS7
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x07      ; W = 7
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN
PRS8
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x08      ; W = 8
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN
PRS9
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x09      ; W = 9
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN

PRS0
    BTFSS flag,0     ;flag,0 = 0 si pas chiffre; flag,0 = 1 si chiffre
    GOTO ERREUR

    MOVLW 0x00      ; W = 0
    BTFSS flag,1     ;flag,1 = 0 si premier chiffre; = 1 si deuxieme chiffre
    MOVWF var1
    MOVWF var2
    BCF flag,0               ; on veut + - ou =

    CALL TEMPO
    RETURN

PRSA        ; +
    BTFSC flag,0     ; doit etre a zero
    GOTO ERREUR

    BTFSC flag,1     ; si apres var2
    GOTO ERREUR

    BSF flag,1           ; prochain entree = chiffre 2
    BSF flag,2           ; flag,2 set pour +
    RETURN

PRSB        ; +
    BTFSC flag,0     ; doit etre a zero
    GOTO ERREUR

    BTFSC flag,1     ; si apres var2
    GOTO ERREUR

    BSF flag,1           ; prochain entree = chiffre 2
    BSF flag,2       ; flag,2 set pour +

PRSC        ; -
    BTFSC flag,0     ; doit etre a zero
    GOTO ERREUR

    BTFSC flag,1     ; si apres var2
    GOTO ERREUR

    BSF flag,1           ; prochain entree = chiffre 2
    BCF flag,2       ; flag,2 clr pour -
PRSD        ;   -
    BTFSC flag,0     ; doit etre a zero
    GOTO ERREUR

    BTFSC flag,1     ; si apres var2
    GOTO ERREUR

    BSF flag,1           ; prochain entree = chiffre 2
    BCF flag,2       ; flag,2 clr pour -

STAR        ; =
    BTFSC flag,0     ; doit etre a zero
    GOTO ERREUR

    BTFSS flag,1     ; si avant var2
    GOTO ERREUR

    MOVF var2,0     ; W = var2
    BTFSC flag,2     ; si addition
    ADDWF var1,0    ; W = var1 + W(=var2)
    SUBWF var1,0  ; W = var1 - W(=var2)

    MOVWF PORTA     ; afficher resultat
    CALL TEMPO

    BSF flag,0           ; prochain = chiffre
    BCF flag,1           ; prochain = chiffre 1

    RETURN

CROIS       ; =
    BTFSC flag,0     ; doit etre a zero
    GOTO ERREUR

    BTFSS flag,1     ; si avant var2
    GOTO ERREUR

    MOVF var2,0     ; W = var2
    BTFSC flag,2     ; si addition
    ADDWF var1,0    ; W = var1 + W(=var2)
    SUBWF var1,0  ; W = var1 - W(=var2)

    MOVWF PORTA     ; afficher resultat
    CALL TEMPO

    BSF flag,0           ; prochain = chiffre
    BCF flag,1           ; prochain = chiffre 1

    RETURN

ERREUR
        MOVLW b'01111010'
;cout << "erreur" << endl;
        MOVWF PORTA         ; afficher A
        CALL WAIT
            GOTO MAINLOOP

WAIT
        MOVLW 0X03
    MOVWF tempo3
    CALL TEMPO
    DECFSZ tempo3,1
    GOTO $-2
    RETURN

TEMPO
    MOVLW 0xff
    MOVWF tempo2
    MOVLW 0xff
    MOVWF tempo1
    DECFSZ tempo1,1
    GOTO $-1
    DECFSZ tempo2,1
    GOTO $-5
    RETURN