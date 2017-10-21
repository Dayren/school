;* Projet : Examen 05                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 18/12/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : dimmer une LED avec boutons                            *
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
    tempo2,tempo1,tempo3,chgt    ; variables
    endc


;*************************************************************************
;* Programme principal *
;*************************************************************************
    ORG 0x000 ; vecteur reset

START
    CLRF STATUS     ;
    BSF STATUS, 5
    CLRF TRISA
    MOVLW b'00001111'
    MOVWF TRISC
    MOVLW 0x01
    MOVLW chgt

CONFIG
    MOVLW b'11111010'   ; 0xfa
    MOVWF PR2           ; période de la modulation (reset = TMR2)

    BCF STATUS,5    ; BANK 0
    MOVLW b'00001100'   ; 0x0c
    MOVWF CCP1CON       ; <7:6> single output P1A; <5:4> LSbs du duty cycle; <3:0> PWM active low
                        ; P1A = RC2 ?????
    MOVLW 0x00
    MOVWF CCPR1L        ; duty cycle (période du haut)

    BCF PIR1,1          ; bit interrupt de timer2

    MOVLW b'00011101'   ; 0x1d
    MOVWF T2CON         ; postscaler 1/4, timer2 ON, prescaler 4

MAINLOOP
    CALL TEMPO
    BTFSS PORTC,0
    CALL INCR       ; augmenter
    BTFSS PORTC,1
    CALL DECR       ; diminuer
    BTFSS PORTC,3
    CLRF CCPR1L     ; éteindre LED
    GOTO MAINLOOP

INCR
    MOVLW 0xFF
    SUBWF CCPR1L,0  ; W = CCPR1L - W
    BTFSC STATUS,2  ; W = 0 ?
    RETURN          ; oui > MAINLOOP

    MOVF chgt,0     ; var d'incr dans W
    ADDWF CCPR1L,1  ; CCPR1L = CCPR1L + W
    BCF STATUS,0    ; on efface le carry
    RLF chgt,1      ; on fait chgt * 2

    RETURN

DECR
    MOVLW 0x00
    SUBWF CCPR1L,0  ; W = CCPR1L - W
    BTFSC STATUS,2  ; W = 0 ?
    RETURN          ; oui > MAINLOOP

    MOVF chgt,0     ; var decr dans W
    SUBWF CCPR1L,1  ; CCPR1L = CCPR1L - W
    BCF STATUS,0    ; on efface le carry
    RRF chgt,1      ; on fait chgt/2

    RETURN

;TEMPO2
;    MOVLW .7
;    MOVWF tempo3
;    CALL TEMPO
;    DECFSZ tempo3,f
;    GOTO $-2
;    RETURN

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