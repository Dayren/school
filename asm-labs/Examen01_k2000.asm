;* Projet : Examen 01                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 18/12/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : K2000                                                  *
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
    tempo2,RESULTHI,VAR,tempo1, tempo3
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
    MOVWF PORTA          ; ensuite dans PORTA

LOOP1
    BCF STATUS,0    ; on delete le carry
    RLF PORTA,1     ; on rotate vers la gauche
    CALL TEMPO2     ; on attend 0.5 sec
    BTFSS PORTA,7   ; si on est pas a la fin
    GOTO LOOP1      ;  > on boucle

LOOP2
    BCF STATUS,0    ; on delete le carry
    RRF PORTA,1     ; on rotate vers la droite
    CALL TEMPO2     ; on attend 0.5 sec
    BTFSS PORTA,0   ; si on est pas au début
    GOTO LOOP2      ;   > on  boucle
    GOTO LOOP1      ;   > sinon : on change de boucle

TEMPO2
    MOVLW .10
    MOVWF tempo3
    CALL TEMPO
    DECFSZ tempo3,f
    GOTO $-2
    RETURN

TEMPO
    movlw 0xFF
    movwf tempo2
    movlw 0xFF
    movwf tempo1
    decfsz tempo1,f
    goto $-1
    decfsz tempo2,f
    goto $-5
    RETURN
END