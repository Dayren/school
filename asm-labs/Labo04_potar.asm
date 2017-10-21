;* Projet : Labo 04                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 20/10/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : afficheur (8LEDs) du potentiomètre                     *
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
;*                                                                      *
;* Description : Aperçu visuel(8LEDs) de l'état d'un potentiomètre      *
;*                                                                      *
;*************************************************************************
#DEFINE AD0 b'01111101' ; configuration du PORTA afficheur digital sur 0
#DEFINE AD1 b'00000101' ; configuration du PORTA afficheur digital sur 1
#DEFINE AD2 b'01101011' ; configuration du PORTA afficheur digital sur 2
#DEFINE AD3 b'00101111' ; configuration du PORTA afficheur digital sur 3
#DEFINE AD4 b'00010111' ; configuration du PORTA afficheur digital sur 4
#DEFINE AD5 b'00111110' ; configuration du PORTA afficheur digital sur 5
#DEFINE AD6 b'01111110' ; configuration du PORTA afficheur digital sur 6
#DEFINE AD7 b'00001101' ; configuration du PORTA afficheur digital sur 7
#DEFINE AD8 b'01111111' ; configuration du PORTA afficheur digital sur 8
#DEFINE AD9 b'00111111' ; configuration du PORTA afficheur digital sur 9
#DEFINE ADE b'01011110' ; configuration du PORTA afficheur digital sur E pour erreur
    cblock 0x020
;*************************************************************************
;* Variables                                                             *
;*************************************************************************
tempo1,tempo2,jumper,result;ici vous pouvez faire vos déclarations de variables
    ; tempo1 = variable pour faire de la temporisation
    ; jumper = définit l'état du jumper
    ;       0 = jumper configuré sur LED
    ;       1 = jumper configuré sur affichage digital
    endc

;*************************************************************************
;* Programme principal                                                   *
;*************************************************************************
    ORG 0x000 ; vecteur reset


START
    BANKSEL TRISA       ; Selectione la banque ou TRISA se trouve
    CLRF TRISA          ; mettre le port A en OUTPUT
    BSF TRISC,0         ; On met le bouton 3 ( celui de gauche ) en INPUT
    BANKSEL ANSEL       ; select bank 4
    BSF ANSEL,1         ; mettre en analog
    MOVLW B'00000001'   ; on met 0 dans W
    MOVWF jumper        ; init Jumper sur afficheur digital
    ;GOTO CONFDIGITAL

CONFDIGITAL
    BANKSEL ADCON1 ; selectionne la banque d'ADCON1
    ;****************************
    ;* JUSTIFIER DANS LE RAPPORT*
    ;****************************
    MOVLW B'00000000'   ;Left justify
    ;****************************
    ;* JUSTIFIER DANS LE RAPPORT*
    ;****************************
    MOVWF ADCON1        ;Vdd and Vss comme tension de référence
    BANKSEL TRISB       ; sélectionne le banque du TRISB
    BSF TRISB,1         ;RB1 ( bouton potentiometrique ) en INPUT
    BANKSEL ANSEL       ;On selectionne la banque ANSEL
    BSF ANSEL,0         ;On met RA0 en analog
    ;****************************
    ;* JUSTIFIER DANS LE RAPPORT*
    ;****************************
    BANKSEL ADCON0      ; selectionne la banque d'ADCON0
    MOVLW B'11101001'   ;ADC Frc clock,
    MOVWF ADCON0        ;on mets W dans ADCON0
    CALL DELAY          ; Tempo d'attente
    CLRF jumper

    ;BSF jumper,0
    ;****************************
    ;* JUSTIFIER DANS LE RAPPORT*
    ;****************************


GETANAL
    BSF ADCON0,1    ; SET GO -> Start conversion
    BTFSC ADCON0,1  ; Is conversion done ?
    GOTO $-1        ;   NO > test again
    MOVF ADRESH,0   ; Lecture de la valeur en analogique
    MOVWF result    ; Stock la valeur dans une variable && AUTISME KHAIM

    CALL JUMP       ; On vérifie d'abord si un bouton est pressé
    CLRF PORTA      ; éteindres le LEDS
    BTFSS jumper,0  ; si le bouton a été pressé
    GOTO SHOWBIT    ;    > soit (dépend de # pression) affichage cascade
    GOTO TESTFORDIGITAL ;> soit (dépend de # pression) affichage 7seg



; **************************** CODE KHAIM ****************************
; on a 8 LEDS, on doit donc diviser la tranche en 8
; => les 3 bits de poids forts sont les seuls qui nous intéresse

SHOWBIT
    BTFSC result,7  ; 1XX ? ()
    GOTO SHOWBIT1XX ;   OUI

    BTFSC result,6  ; 01X ?
    GOTO SHOWBIT01X ;   OUI

    BTFSC result,5  ; 001 ?
    GOTO $+4        ;   OUI XX-- ----

    BTFSC result,4  ; 0001 ?
    BSF PORTA,7     ;   OUI X--- ----
                    ; SINON ---- ----

    GOTO GETANAL    ; retour loop principal

    MOVLW 0xc0      ; XX-- ---
    MOVWF PORTA     ; affiche la valeur dans les LEDs
    GOTO GETANAL    ; retour loop principal

SHOWBIT01X
    BTFSC result,5  ; 011 ?
    GOTO $+4        ;   OUI

                    ; sinon
    MOVLW 0xe0      ; 010 : XXX- ----
    MOVWF PORTA     ; affichage
    GOTO GETANAL

    MOVLW 0xf0      ; 011 : XXXX ----
    MOVWF PORTA     ; affichage
    GOTO GETANAL

SHOWBIT1XX
    BTFSC result,6  ; 11X ?
    GOTO SHOWBIT11X ;   OUI

    BTFSC result,5  ; 101 ?
    GOTO $+4        ;   OUI

                    ; sinon
    MOVLW 0xf8      ;   100 : XXXX X---
    MOVWF PORTA     ; affichage
    GOTO GETANAL

    MOVLW 0xfc      ;   101 : XXXX XX--
    MOVWF PORTA     ; affichage
    GOTO GETANAL

SHOWBIT11X
    BTFSC result,5  ; 111?
    GOTO $+4        ;   OUI

                    ; sinon
    MOVLW 0xfe      ;   110 : XXXX XXX-
    MOVWF PORTA     ; affichage
    GOTO GETANAL

    MOVLW 0xff      ;   111 : XXXX XXXX
    MOVWF PORTA     ; affichage
    GOTO GETANAL
; **************************** FIN KHAIM ****************************

; **************************** CODE BRUNO ****************************
TESTFORDIGITAL
    ;BSF ADCON0,1    ; On commence la conversion
    ;BTFSC ADCON0,1  ; La convertion est-elle faite ?
    ;GOTO $-1        ; conversion pas fini, on attends
    ;****************************
    ;* JUSTIFIER DANS LE RAPPORT*
    ;****************************

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'11100000'   ; W - 225 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT9        ; volume = 9

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'11001001'   ; W - 200 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT8        ; volume = 8

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'10101110'   ; W - 175 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT7        ; volume = 7

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'10010111'   ; W - 150 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT6        ; volume = 6

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'01111100'   ; W - 125 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT5        ; volume = 5

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'01100101'   ; W - 100 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT4        ; volume = 4

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'01001010'   ; W - 75 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT3        ; volume = 3

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'00110011'   ; W - 50 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT2        ; volume = 2

    MOVF ADRESH,0       ; Envoi l'état analogique du potentiometre dans W
    SUBLW B'00011000'   ; W - 25 => STATUS,0 contiend 0 si W > L et 1 si W <= L
    BTFSS STATUS,0      ; si W > L on skip
    GOTO RESULT         ; volume = 1

    MOVLW AD0           ; par défaut, volume = 0
    GOTO AFFICHER       ; go afficher

RESULT
    MOVLW AD1
    GOTO AFFICHER
RESULT2
    MOVLW AD2
    GOTO AFFICHER
RESULT3
    MOVLW AD3
    GOTO AFFICHER
RESULT4
    MOVLW AD4
    GOTO AFFICHER
RESULT5
    MOVLW AD5
    GOTO AFFICHER
RESULT6
    MOVLW AD6
    GOTO AFFICHER
RESULT7
    MOVLW AD7
    GOTO AFFICHER
RESULT8
    MOVLW AD8
    GOTO AFFICHER
RESULT9
    MOVLW AD9
    GOTO AFFICHER

AFFICHER
    BANKSEL PORTA   ; selection bank PORTA
    CLRF PORTA      ; on s'assure que tout est éteind
    MOVWF PORTA     ; on allume ce qu'il faut
    GOTO GETANAL    ; retour boucle principale

; **************************** FIN BRUNO ****************************

JUMP
    BTFSC PORTC,0   ; Si bouton PAS enfoncé
    RETURN          ; on fait RIEN

    CALL TOGGLE     ; SINON -> toggle f(jumper,0)
    CALL DELAY      ; attente relachement du bouton
    BTFSS PORTC,0   ; test si le bouton a été relaché
    GOTO $-2        ;   NON : on rattend + test
    RETURN          ;   OUI : retour mainloop

TOGGLE
    MOVF jumper,0   ; on prend le contenu de jumper (.1 ou .0) dans W
    XORLW 0xFF      ; on fait l'inverse (.1 -> .0  || .0 -> .1)
    MOVWF jumper    ; on écrase par jumper,0 par sa nouvelle valeur inversé
    RETURN

DELAY
    MOVLW 0xFF      ; stock 1111 1111 dans le registre de travail
    MOVWF tempo1    ; envoi le W dans la variable tempo1
    DECFSZ tempo1,1 ; décremente tempo1 et stock dans tempo1, skip la ligne suivante si 0
    GOTO $-1        ; reviens à la ligne précédente soit 256*4*200ns = 0.000204800 s soit 0.2ms
    RETURN          ; retourne et continue après le call qui t'as envoyé ici


    END         ; FIN PROGRAMME
