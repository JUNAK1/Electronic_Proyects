;Juan Camilo Serrano Correa
;Piano electrico
; 24/08/2021
#include "p16f887.inc"
 __CONFIG _CONFIG1, _FOSC_INTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
 
 CBLOCK	0X21
 CONT
 D1
 D2
 D3
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
BSF INTCON,7; DESABILITA INTERRUPCIONES
;PUERTO D OUTPUT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BCF STATUS,6 ;01
CLRF TRISC
CLRF TRISE
CLRF TRISD
CLRF TRISA
COMF TRISA
 BSF OSCCON,0
 BSF OSCCON,6;INTERNAL OSCILLATOR 8MHz
BSF OSCCON,5
BSF OSCCON,4
BCF STATUS,5;00
CLRF PORTC
CLRF PORTD
CLRF PORTA
CLRF PORTE
;CLRWDT
LOOP
;Si se presiona el boton envia un nivel alto al puerto B,  se ejecuta un retardo
;en las funciones  LOAD_DATA_nota Y DELAY_nota para filtrar ruido del boton despues del
;filtrado se procede a ejecutar la respectiva frecuencia de onda cuadrada que representa
;la nota musical
 BTFSS PORTB,0
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_DO ;Antirebote__  XD	
 CALL	DELAY_DO
 BTFSC PORTB,0
 GOTO	$-4

 BTFSS PORTB,1
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_RE ;Antirebote__  XD	
 CALL	DELAY_RE
 BTFSC PORTB,1
 GOTO	$-4
 
 BTFSS PORTB,2
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_MI ;Antirebote__  XD	
 CALL	DELAY_MI
 BTFSC PORTB,2
 GOTO	$-4
 
 BTFSS PORTB,3
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_FA ;Antirebote__  XD	
 CALL	DELAY_FA
 BTFSC PORTB,3
 GOTO	$-4
 
 BTFSS PORTB,4
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_SOL ;Antirebote__  XD	
 CALL	DELAY_SOL
 BTFSC PORTB,4
 GOTO	$-4
 
 BTFSS PORTB,5
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_LA ;Antirebote__  XD	
 CALL	DELAY_LA
 BTFSC PORTB,5
 GOTO	$-4
 
 BTFSS PORTB,6
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_SI ;Antirebote__  XD	
 CALL	DELAY_SI
 BTFSC PORTB,6
 GOTO	$-4
 
 BTFSS PORTB,7
 GOTO	$+6
 COMF PORTE,F
 CALL	LOAD_DATA_DOO ;Antirebote__  XD	
 CALL	DELAY_DOO
 BTFSC PORTB,7
 GOTO	$-4
 
 CLRF PORTE; se limpia siempre este puerto porque la onda cuadrada puede quedar en alto, 
 ;haciendo un ruido molesto sin que ninguna tecla este presionada, esta linea lo soluciona  
 
 GOTO LOOP
 ; Cada nota musical tiene una frecuencia diferente
 ; como se requieren dos llamados del retardo para completar un periodo de la se�al
 ;la frecuencia a la que se dise�a el retardo se divide en dos
 ;se disminuye una octava 
DELAY_DO;523.251HZ/2-261.6HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_DO
nop
RETURN
LOAD_DATA_DO
MOVLW	0xFB
MOVWF	D1
MOVLW	0x03
MOVWF	D2 
 RETURN
DELAY_RE;587.335HZ/2-HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_RE
nop
RETURN
LOAD_DATA_RE
MOVLW	0xA8
MOVWF	D1
MOVLW	0x03
MOVWF	D2 
RETURN

DELAY_MI;659.255HZ/2-HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_MI
nop
RETURN
LOAD_DATA_MI
MOVLW	0x5E
MOVWF	D1
MOVLW	0x03
MOVWF	D2 
RETURN
DELAY_FA;698.456HZ/2-HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_FA
nop
RETURN
LOAD_DATA_FA
MOVLW	0x3C
MOVWF	D1
MOVLW	0x03
MOVWF	D2 
RETURN
DELAY_SOL;783.991HZ/2-HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_SOL
nop
RETURN
LOAD_DATA_SOL
MOVLW	0xFD
MOVWF	D1
MOVLW	0x02
MOVWF	D2 
RETURN
DELAY_LA;880HZ/2-HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_LA
nop
RETURN
LOAD_DATA_LA
MOVLW	0xC6
MOVWF	D1
MOVLW	0x02
MOVWF	D2 
RETURN
DELAY_SI;987.767HZ/2-HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_SI
nop
RETURN
LOAD_DATA_SI
MOVLW	0x94
MOVWF	D1
MOVLW	0x02
MOVWF	D2 
RETURN
DELAY_DOO;1046.5HZ/2-HZ
DECFSZ	D1, F
GOTO	$+2
DECFSZ	D2, F
GOTO	DELAY_DOO
nop
RETURN
LOAD_DATA_DOO
MOVLW	0x7D
MOVWF	D1
MOVLW	0x02
MOVWF	D2 
RETURN
END