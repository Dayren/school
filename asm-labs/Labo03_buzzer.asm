;* Projet : Labo 03                                                     *
;************************************************************************
;* Auteur : (namigyj)                                                   *
;*                                                                      *
;* Date : 20/10/2016                                                    *
;************************************************************************
;* Fichiers nécessaires: aucun                                          *
;************************************************************************
;*                                                                      *
;* Description : émettre 4 sons différents depuis le buzzer             *
;*               (version sans PWM)                                     *
;************************************************************************
    list p=16F887, f=INHX8M ; directive pour definir le processeur
    list c=90, n=60 ; directives pour le listing
    #include <p16F887.inc> ; incorporation variables spécifiques
    errorlevel -302 ; pas d'avertissements de bank
    errorlevel -305 ; pas d'avertissements de fdest

    __CONFIG _CONFIG1, _LVP_OFF & _WDT_OFF & _INTOSCIO
    __CONFIG _CONFIG2, _IESO_OFF & _FCMEN_OFF

;*************************************************************************
;* Définitions                                                           *
;*************************************************************************
#DEFINE ETAT0 0x29 ; son 1
#DEFINE ETAT1 0x49 ; son 2
#DEFINE ETAT2 0x69 ; son 3
#DEFINE ETAT3 0xc0 ; son 4

    cblock 0x020
;*************************************************************************
;* Variables                                                             *
;*************************************************************************
tempo,delay,delay2,tmpdelay,numero;ici vous pouvez faire vos déclarations de variables
    ; delay = variable pour faire de la temporisation VARIABLE
    ; tempo  = variable pour faire de la temporisation FIXE
    ; tmpdelay = variable à transférer vers delay
    endc

;*************************************************************************
;* Programme principal                                                   *
;*************************************************************************
    ORG 0x000 ; vecteur reset


START
    BANKSEL TRISA   ; Selectione la banque ou TRISA se trouve
    CLRF TRISA      ; mettre le port A en OUTPUT
    CLRF TRISC      ; TRISC = 0
    MOVLW B'00001111' ; input <3:0> & output <4:7>
    MOVWF TRISC     ; pour PORTC

;************* A JUSTIFIER **************************
    BANKSEL ANSEL   ; select bank 4                 *
    BSF ANSEL,1     ; mettre en analog              *
;************* A JUSTIFIER **************************

    CLRF STATUS     ; BANK 0
    BCF PORTC,5     ; INIT BUZZ
    CLRF PORTA      ; INIT LEDS

BUTTON0
    BTFSC PORTC,0   ; si le bouton 0 est PAS enfoncé, on regarde bouton suivant
    GOTO BUTTON1E:/home/nanami/Pictures/Capture2.PNG
    MOVLW ETAT0     ; envoi ETAT0 (0x29) dans W
    MOVWF tmpdelay  ; envoi W dans tmpdelay
    CALL SON0       ; musique + wait relache bouton
    BTFSS PORTC,0   ; bouton 0 enfoncé
;    GOTO BUTTON1

BUTTON1
    BTFSC PORTC,1   ; si le bouton 0 est PAS enfoncé, bouton suivant
    GOTO BUTTON2
    MOVLW ETAT1     ; envoi ETAT1 (0x49) dans W
    MOVWF tmpdelay  ; envoi W dans tmpdelay
    CALL SON1       ; musique + wait relache bouton
    BTFSS PORTC,1   ; bouton 0 enfoncé
    GOTO $-2        ; retour en arrière
;    GOTO BUTTON2

BUTTON2
    BTFSC PORTC,2   ; si le bouton 0 est PAS enfoncé, bouton suivant
    GOTO BUTTON3
    MOVLW ETAT2     ; envoi ETAT2 (0x69) dans W
    MOVWF tmpdelay  ; envoi W dans tmpdelay
    CALL SON2       ; musique + wait relache bouton
    BTFSS PORTC,2   ; bouton 0 enfoncé
    GOTO $-2        ; retour en arrière
;    GOTO BUTTON3

BUTTON3
    BTFSC PORTC,3   ; si le bouton 0 est PAS enfoncé, bouton suivant
    GOTO BUTTON0
    MOVLW ETAT3     ; envoi ETAT3 (0xC0) dans W
    MOVWF tmpdelay  ; envoi W dans tmpdelay
    CALL SON3       ; musique + wait relache bouton
    BTFSS PORTC,3   ; bouton 0 enfoncé
    GOTO $-2        ; retour en arrière
    GOTO BUTTON0    ;

ALLUMESON
    BSF PORTC,5     ; Allume le son
    BSF PORTA,0     ; Allume la led 0 pour vérification
    CALL DELAY      ; appelle la sous routine delay
    BCF PORTC,5     ; coupe le son
    BCF PORTA,0     ; eteind la led 0 pour vérification
    CALL DELAY      ; cree un timer de delayrisation
    RETURN

DELAY
    MOVFW tmpdelay  ; nécessaire pour si l'on RESTE appuyer
    MOVWF delay     ; envoi le W dans la variable delay
    DECFSZ delay,1  ; décremente delay et stock dans delay, skip la ligne suivante si 0
    GOTO $-1        ; reviens à la ligne précédente (255 fois )
    RETURN


; 2 instructions + tmpdelay + 2instructions + tmpdelay
; 400ns + tmpdelay + 400ns + tmpdelay
; tmpdelay = 1 + 1 + (2 + 2)*delay + 1 = 4*delay*200ns + 3
; 800ns + 2(d*800ns+600ns) = 800ns+ 1200ns + 1600ns*delay = 2µs + 16delay µs

; e1:0x29   -> 41  * 16 =  656µs +2µs ->  658µs*2 + 800ns = 1317µs
; e2:0x49   -> 73  * 16 = 1168µs +2µs -> 1170µs*2 + 800ns = 2341µs
; e3:0x69   -> 89  * 16 = 1424µs +2µs -> 1426µs*2 + 800ns = 2853µs
; e4:0xc0   -> 192 * 16 = 3072µs +2µs -> 3072µs*2 + 800ns = 6145µs

; t1 = 256 * 1317µs = 337_152µs
; t2 = 144 * 2341µs = 337ms
; t3 = 118 * 2853µs = 337ms
; t4 = 55  * 6145µs = 337ms
; 144 (0x90) > 118 (0x76) > 55  (0x37)

; TEMPO
;     MOVLW 0xFF      ; assigne 255 dans le registre de travail
;     MOVWF tempo     ; envoie le W dans la variable tempo
;     CALL ALLUMESON  ; sous routine de fréquence du son
;     DECFSZ tempo,1  ; décremente delay et stock dans delay, skip la ligne suivante si 0
;     GOTO $-2        ; reviens à la ligne précédente soit 256*4*200ns = 0.000204800 s soit 0.2ms
;     RETURN          ; retourne et continue après le call qui t'as envoyé ici


SON0
    MOVLW 0xff
    MOVWF tempo     ; envoi le W dans la variable tempo
    CALL ALLUMESON  ; sous routine de fréquence du son
    DECFSZ tempo,1  ; décremente tempo et stock dans tempo, skip la ligne suivante si 0
    GOTO $-2        ; reviens à la ligne précédente soit 256*4*200ns = 0.000204800 s soit 0.2ms
    RETURN          ; retourne et continue après le call qui t'as envoyé ici
SON1
    MOVLW 0x90
    MOVWF tempo     ; envoi le W dans la variable tempo
    CALL ALLUMESON  ; sous routine de fréquence du son
    DECFSZ tempo,1  ; décremente tempo et stock dans tempo, skip la ligne suivante si 0
    GOTO $-2        ; reviens à la ligne précédente soit 256*4*200ns = 0.000204800 s soit 0.2ms
    RETURN          ; retourne et continue après le call qui t'as envoyé ici
SON2
    MOVLW 0x76
    MOVWF tempo     ; envoi le W dans la variable tempo
    CALL ALLUMESON  ; sous routine de fréquence du son
    DECFSZ tempo,1  ; décremente tempo et stock dans tempo, skip la ligne suivante si 0
    GOTO $-2        ; reviens à la ligne précédente soit 256*4*200ns = 0.000204800 s soit 0.2ms
    RETURN          ; retourne et continue après le call qui t'as envoyé ici
SON3
    MOVLW 0x37
    MOVWF tempo     ; envoi le W dans la variable tempo
    CALL ALLUMESON  ; sous routine de fréquence du son
    DECFSZ tempo,1  ; décremente tempo et stock dans tempo, skip la ligne suivante si 0
    GOTO $-2        ; reviens à la ligne précédente soit 256*4*200ns = 0.000204800 s soit 0.2ms
    RETURN          ; retourne et continue après le call qui t'as envoyé ici

    END         ; FIN PROGRAMME
