;* Projet : Examen 02                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 18/12/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : K2000 splitté (K2001?)                                 *
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
    tempo1,tempo2,tempo3,gauche,droite  ; variables
    endc


;*************************************************************************
;* Programme principal *
;*************************************************************************
    ORG 0x000 ; vecteur reset
START
    CLRF STATUS          ; INIT
    BSF STATUS,5         ; BANK 1
    CLRF TRISA           ; PORTA en output
    BSF STATUS,6         ; BANK 3
    CLRF ANSEL           ; SIGNAL DIGITAL
    CLRF STATUS          ; BANK 0
    CLRF PORTA           ; INIT LES LEDS
    MOVLW b'00000001'    ; on met 1 dans le registre w
    MOVWF gauche         ; ensuite dans gauche
    MOVLW b'10000000'    ; on met 128 dans le registre w
    MOVWF droite         ; ensuìte dans droite

LOOP1
    BCF STATUS,0    ; on delete le carry
    RLF gauche,1    ; on rotate vers la gauche
    RRF droite,1    ; on rotate vers la droite

    CALL AFFICHER

    BTFSS gauche,7  ; si on est pas a la fin
    GOTO LOOP1      ;  > on boucle

LOOP2
    BCF STATUS,0    ; on delete le carry
    RRF gauche,1    ; on rotate vers la droite
    RLF droite,1    ; on rotate vers la gauche

    CALL AFFICHER

    BTFSS gauche,0  ; si on est pas au début
    GOTO LOOP2      ;   > on  boucle
    GOTO LOOP1      ;   > sinon : on change de boucle

AFFICHER
    MOVF gauche,0   ; on met gauche dans W
    ADDWF droite,0  ; on additionne gauche et droite
    MOVWF PORTA     ; on affiche les deux en même temps
    CALL TEMPO2     ; on attend 0.5 sec
    RETURN

TEMPO2
    MOVLW .7
    MOVWF tempo3
    CALL TEMPO
    DECFSZ tempo3,f
    GOTO $-2
    RETURN

TEMPO
    movlw .250
    movwf tempo2
    movlw .250
    movwf tempo1
    decfsz tempo1,f
    goto $-1
    decfsz tempo2,f
    goto $-5
    RETURN
END