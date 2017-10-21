;* Projet : Examen 03                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 18/12/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : jeu pong                                               *
;*                                                                      *
;************************************************************************
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

MAINLOOP
    BTFSC PORTC,1           ; 0 = appuyer
    GOTO LOOP1              ; si appuyé
    GOTO MAINLOOP           ; pas appuyé on attend

LOOP1
    BCF STATUS,0    ; on delete le carry
    RLF PORTA,1     ; on rotate vers la gauche
    CALL TEMPO2     ; on attend 0.5 sec
    BTFSS PORTA,7   ; si on est pas a la fin
    GOTO LOOP1      ;  > on boucle
    GOTO PRESSG         ; bouton

LOOP2
    BCF STATUS,0    ; on delete le carry
    RRF PORTA,1     ; on rotate vers la droite
    CALL TEMPO2     ; on attend 0.5 sec
    BTFSS PORTA,0   ; si on est pas au début
    GOTO LOOP2      ;   > on  boucle
    GOTO LOOP1      ;   > sinon : on change de boucle

PRESSG
    BTFSS PORTC,3       ; bouton gauche enfoncé ?
    GOTO LOOP2          ; "pong!"
    GOTO PERDU

PRESSD
    BTFSS PORTC,0       ; bouton droite enfoncé ?
    GOTO LOOP1          ; "pong!"
    GOTO PERDU

PERDU
        CLRF PORTA      ; 0
    COMF PORTA      ; 1
    CALL TEMPO2
    CLRF PORTA      ; 0
    CALL TEMPO2
        CLRF PORTA      ; 0
    COMF PORTA      ; 1
    CALL TEMPO2
    CLRF PORTA      ; 0
    GOTO MAINLOOP

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