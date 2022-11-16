	list	 p=16f84A
	include <P16F84A.INC>

	__CONFIG  _CP_OFF  & _WDT_OFF  & _PWRTE_ON  & _XT_OSC
 
; dando nombre a los registros de propósito general
	CBLOCK 0x0C
	dato_1 
	dato_2 
	resultado 
	ENDC

   ORG 0
goto CONFIGURACION

CONFIGURACION
 	
			BANKSEL  TRISA ; selección del BANK1 para configurar TRISA y TRISB
			MOVLW 0XFF     
    		MOVWF TRISA	   ; PORTA como entradas
			CLRF TRISB     ;  PORTB  como salida
			BANKSEL PORTA  ; Volviendo al BANK0 	
INICIO
  	 		CLRF resultado   ; Se limpia el resultado 
		

        	MOVF PORTA,w     ;  
    		MOVWF dato_1     ; leer dato en el PUERTO A y almacenarlo 
			MOVLW 0X03		 ; enmascarando A1 y A0 >> "000000xx"
			ANDWF dato_1,f   ; dato_1 -> A1:A0
LOOP
			MOVF PORTA,W        ; asignar los datos del puerto A 
    		MOVWF dato_2	    ; al registro desigando
			MOVLW 0X0C			; enmascarando A3 y A2  "0000yy00"
			ANDWF dato_2,f      ; 
			RRF dato_2,f       
			RRF dato_2,f		; "0000yy00" > > "000000yy"
			MOVLW 0x03			;  enmascarando dato_2 >> "000000xx" 
			ANDWF dato_2,f		; dato_2 -> A3:A2
			
			MOVF dato_2,w			; 
			ADDWF resultado,f       ; resultado = resultado + dato_2

			DECFSZ dato_1 			; dato_1 - 1, dato_1 = 0 ?
			goto LOOP				; no
    		
			MOVF resultado,W		; si 
			MOVWF PORTB				; mostrar en salida (PORTB)
			goto INICIO				; 


END
