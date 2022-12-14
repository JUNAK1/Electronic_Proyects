;Juan Camilo Serrano Correa
;Motor paso a paso con WDT
; 1/08/2021
#include "p16f887.inc"
 __CONFIG _CONFIG1, _FOSC_INTRC_NOCLKOUT & _WDTE_ON & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
 CBLOCK 0X22
 STEP1
 STEP2
 STEP3
 STEP4
 STEP5
 STEP6
 STEP7
 STEP8
 PAP_CONT
 CONT
 D1
 D2
 C64
 ENDC
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
COMF TRISB ;in
BSF OPTION_REG,7; DESABILITA RESISTENCIA PULLUP
 
BCF OPTION_REG,2; Prescaler WDT
BSF OPTION_REG,1; 001 = 1:4
BCF OPTION_REG,0
 
BSF INTCON,7; DESABILITA INTERRUPCIONES
;PUERTO D OUTPUT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BCF STATUS,6 ;01
CLRF TRISC
CLRF TRISD
CLRF TRISA
BSF OSCCON,6;INTERNAL OSCILLATOR 8MHz
BSF OSCCON,5
BSF OSCCON,4
;---------------------------------------
 BANKSEL WDTCON;10
 BSF WDTCON,0;ACTIVE WDT IF _WDTE_OFF
 
BCF WDTCON,1	;OTRO PRESCALER WDT
BCF WDTCON,2	; 0100= 1:512
BSF WDTCON,3	; CONTEO TATAL = (1/31K)*512*2 = 66ms
BCF WDTCON,4
;--------------------------------------- 
BCF STATUS,5;00
BCF STATUS,6 
CLRF PORTC
CLRF PORTD
CLRF PORTA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
MOVLW B'1000'; secuencia de medio pasos, 8 pasos del motor PAP
MOVWF STEP1
MOVLW B'1100'
MOVWF STEP2
MOVLW B'0100'
MOVWF STEP3
MOVLW B'0110'
MOVWF STEP4
MOVLW B'0010'
MOVWF STEP5
MOVLW B'0011'
MOVWF STEP6
MOVLW B'0001'
MOVWF STEP7
MOVLW B'1001'
MOVWF STEP8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOOP
BTFSC PORTB,1; Si el boton se presiona go infinite loop
CALL INFINITE 
 
BTFSC PAP_CONT,6 ;SI EL BIT(6)=1 => HEX=PAP_CONT=64 = 1vuelta
CALL  SHOW     ;Mostrar en display 7 seg
BTFSC PORTB,0	;Bit Test f, Skip if Set  

GOTO RR
CALL NPAP ; Sentido antihorario
GOTO LOOP
RR
CALL PAP; Sentido horario
GOTO LOOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PAP; Sentido horario
 MOVFW STEP1
 MOVWF PORTA;se carga el primer paso del motor pap
 CALL	LOAD_DATA; se encargan los datos para ejecutar el delay
 CALL DELAY	 ;se ejecuta el delay
 CLRWDT
 MOVFW STEP2
 MOVWF PORTA;se carga el segundo paso del motor pap
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP3
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP4
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP5
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP6
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP7
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP8
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 INCF PAP_CONT
 RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NPAP; sentido antiorario
 MOVFW STEP8
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP7
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP6
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP5
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP4
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP3
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP2
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 MOVFW STEP1
 MOVWF PORTA
 CALL	LOAD_DATA
 CALL DELAY
 CLRWDT
 INCF PAP_CONT
 RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DELAY;20ms
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY
nop
RETURN
LOAD_DATA
MOVLW	0x1F
MOVWF	D1
MOVLW	0x4F
MOVWF	D2
 RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DISPLAY
    ADDWF PCL,F
    DT 0X3F,0X06,0X5B,0X4F,0X66,0X6D,0X7D,0X07,0X7F,0X67,0X77,0X7C,0X39,0X5E,0X79,0X71;conteo de 0 to F
RETURN
SHOW
 INCF	CONT
 MOVF   CONT,W
 ANDLW	B'00001111';mascara, valores mayores a 15 no sirven
 CALL DISPLAY
 MOVWF	PORTC
 CLRF	PAP_CONT
 RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INFINITE; error pro
GOTO INFINITE ;LA UNICA FORMA DE SALIR ES MEDIANTE RESET, EN ESTE CASO EL WDT 
 RETURN
END