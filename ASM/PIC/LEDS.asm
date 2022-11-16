;Juan Camilo Serrano Correa
; 1/08/2021
;Juego de luces led
#include "p16f887.inc"
 __CONFIG _CONFIG1, _FOSC_INTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
    
D1  EQU	0X20
D2  EQU	0X21
D3  EQU	0X22
D11  EQU	0X23
D22  EQU	0X24
DD1  EQU	0X25
DD2  EQU	0X26
DD3  EQU	0X27
COUNTER1      EQU	0X28
COUNTER2      EQU	0X29
AUX	  EQU	0X2A
 ORG	0
 GOTO	INICIO
 ORG	10
 INICIO
;PASOS PARA CONFIGURAR PORTB COMO i/o INPUT;;;;;;;;;
BSF STATUS,5
BSF STATUS,6  ;11
CLRF ANSEL;CLEAR todos los bits; EN 0 LOS PINES SON DE SALIDA
CLRF ANSELH
CLRF TRISB ;out
COMF TRISB ;inb  
BSF OPTION_REG,7; DESABILITA RESISTENCIA PULLUP
BSF INTCON,7; DESABILITA INTERRUPCIONES
;PUERTO D OUTPUT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BCF STATUS,6 ;01
CLRF TRISC
CLRF TRISD
CLRF TRISA
COMF TRISA
BCF STATUS,5;00
CLRF PORTC
CLRF PORTD
CLRF PORTA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BCF STATUS,0
 
CLRF AUX
MOVLW .1
MOVWF AUX      ;AUX=1
MOVWF COUNTER2 ;COUNTER=1
MOVLW .0
MOVWF COUNTER1 ;COUNTER=0

MOVLW	0x1F
MOVWF	D1   ;D1=0X1F
MOVLW	0x4F
MOVWF	D2   ;D2=0X4F
 
LOOP
BTFSC PORTA,4
CALL DELAY_UP ; Aumenta en 10ms la velocidad de la secuencia led
BTFSC PORTA,5
CALL DELAY_DN;Disminuye en 10ms la velocidad de la secuencia led
;Si se presiona el boton envia un nivel alto al puerto B,  se ejecuta un retardo
;en las funciones  LOAD_DATA2 Y DELAY2 para filtrar ruido del boton despues del
;filtrado se procede a ejecutar la FUN_X que contiene una secuencia led
BTFSS PORTB,0
GOTO  $+6
NOP
NOP
BTFSS PORTB,0
GOTO  $+2
CALL	FUN_0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
BTFSS PORTB,1
GOTO  $+6
NOP
NOP
BTFSS PORTB,1
GOTO  $+2
CALL	FUN_1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BTFSS PORTB,2
GOTO  $+6
NOP
NOP
BTFSS PORTB,2
GOTO  $+2
CALL	FUN_2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BTFSS PORTB,3
GOTO  $+6
NOP
NOP
BTFSS PORTB,3
GOTO  $+2
CALL	FUN_3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BTFSS PORTB,4
GOTO  $+6
NOP
NOP
BTFSS PORTB,4
GOTO  $+2
CALL	FUN_4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BTFSS PORTB,5
GOTO  $+6
NOP
NOP
BTFSS PORTB,5
GOTO  $+2
CALL	FUN_5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BTFSS PORTB,6
GOTO  $+6
NOP
NOP
BTFSS PORTB,6
GOTO  $+2
CALL	FUN_6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BTFSS PORTB,7 
GOTO  $+6
NOP
NOP 
BTFSS PORTB,7
GOTO  $+2
CALL	FUN_7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GOTO LOOP
 
FUN_0;BLINK, los led invierten el valor actual que tienen
MOVLW .0
CALL DISPLAY
MOVWF PORTC
COMF PORTD
CALL LOAD_DATA
CALL DELAY
RETURN
FUN_1;SHIFT LEFT, los leds se desplazan a la izquierda
MOVLW .1
CALL DISPLAY
MOVWF PORTC
RLF PORTD,F
CALL LOAD_DATA
CALL DELAY
RETURN 
FUN_2;SHIFT RIGHT, los leds se desplazan a la derecha
MOVLW .2
CALL DISPLAY
MOVWF PORTC
RRF PORTD,F
CALL LOAD_DATA
CALL DELAY
RETURN
FUN_3;UP COUNTER, los leds realizan un conteo acendente ++
MOVLW .3
CALL DISPLAY
MOVWF PORTC
INCF PORTD
CALL LOAD_DATA
CALL DELAY
RETURN
FUN_4;DOWN COUNTER, los leds realizan un conteo descendente ++
MOVLW .4
CALL DISPLAY
MOVWF PORTC
DECF PORTD
CALL LOAD_DATA
CALL DELAY
RETURN
FUN_5;FIBO COUNTER, los leds realizan la secuencia de Fibonachi, inspirado en el punto de entrenamiento 
MOVLW .5
CALL DISPLAY
MOVWF PORTC
MOVFW COUNTER2	    
MOVWF COUNTER1	    ;C1=C2
MOVFW AUX
MOVWF COUNTER2	    ;C2=AUX

MOVFW COUNTER2
ADDWF COUNTER1,W    ;W=C1+C2
MOVWF PORTD
MOVWF AUX 
CALL LOAD_DATA
CALL DELAY
RETURN
FUN_6; los leds muestran la tabla del 2 en binario
MOVLW .6
CALL DISPLAY
MOVWF PORTC
MOVLW .2
ADDWF D3,F
MOVFW D3
MOVWF PORTD
CALL LOAD_DATA
CALL DELAY
RETURN
FUN_7;; los leds muestran la tabla del 3 en binario
MOVLW .7
CALL DISPLAY
MOVWF PORTC
MOVLW .3
ADDWF D3,F
MOVFW D3
MOVWF PORTD
CALL LOAD_DATA
CALL DELAY
RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY_UP;+Xms
MOVLW 0X1F
ADDWF D11,F
MOVLW 0X20
ADDWF D22,F
RETURN
DELAY_DN;Xms
MOVLW 0X1F
SUBWF D11,F
MOVLW 0X20
SUBWF D22,F
RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY;20ms --Este es un retardo variable
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY
nop
RETURN
LOAD_DATA
MOVLW	0x3F
MOVWF	D1
MOVFW   D11
ADDWF   D1,F 
MOVLW	0x20
MOVWF	D2
MOVFW   D22
ADDWF	D2,F
RETURN
 DISPLAY
    ADDWF PCL,F
    DT 0X3F,0X06,0X5B,0X4F,0X66,0X6D,0X7D,0X07
RETURN
END