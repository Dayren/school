initialtion

LOOP
    convertir : BSF ADCON0,0            ; commencer conversion
                        BTFSC ADCON0,0      ; check si la conversion
              GOTO $-1

              BTFSS ADRESH,bit
              GOTO allumerbit
                                                            OGC (tourner la tête vers la gauche)
allumerbit
    BSF PORTA,bit
  MOVLW b'00001000
  GOTO LOOP

1,2,4,8,16,32,64,128,256

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

W= ADRESH
W - Seuil ( SUBLW) => 224,192,160,etc.
C = 0 ? allumer
C = 1 ? test prochain seuil

x > 224 : PORTA,7
x > 192 : PORTA,6
x > 160 : PORTA,5
x > 128 : PORTA,4
x > 96  : PORTA,3
x > 64  : PORTA,2
x > 32  : PORTA,1
x > 0       : PORTA,0

            MOVF ADRESH,0   ;   W = ADRESH                                  MOVLW .224
      SUBLW 0xf0            ; W = W - val(224,192,etc.)     SUBWF ADRESH,0          ; W = W = ADRESH
      BTFSS STATUS,0    ; W > valeur ?                              BTFSC STATUS,0          ; W < ADRESH ?
      GOTO allumer      ; oui                                               GOTO allumer                ; oui

  status,0  = 0 SI W > f
  status,0  = 1 SI W <= f

  120               175
  250 < ?           100 < ?
  200 < ?           150 < ?
  150 < ?           200 < ?
  100 < ?           250 < ?


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------


BSF ADCON0,GO          ; Convertit
BTFSC ADCON0,GO     ; Check si la conversion est fini
GOTO $-1
BTFSS ADRESH, X           ; Si le bit x est a 1..
allumage
MOVWF PORTA             ; On bouge la valeur du registre W dans PORTA
