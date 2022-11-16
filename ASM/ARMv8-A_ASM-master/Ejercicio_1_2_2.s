       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881

       mov     R0, #0x07 ;Alamcenamiento del dato hexadecimal 0x06 en el registro R0

       ;mov    R3, #-0x669 -- Instruccion imposible de ejecutar el dato a almacenar
       ;       en los registros es demasido grande para el software
       mov     R3, #-0x66 ;Almacenamiento del dato hexadecimal 0x-66 en el registro R3
       ;En     formato complemento a 2

       ;mov    R5, #0xD634-- Instruccion imposible de ejecutar el dato a almacenar
       ;       en los registros es demasiado grande para el software
       mov     R5, #0xD6 ;Almacenamiento del dato hexadecimal 0xD6 en el registro R5

       ;movt   R5, #0xFFB1-- Instruccion imposible ejecutar ya que no cuenta
       ;       como una de la instrucciones que el software puede ejecutar
       ;       ademas la cantidad 0xFFB1 no es posible ser almacenada en memoria
       mov     R5, #0xFF ;Almacenamiento del dato hexadecimal 0xFF en el registro R5
       ;       ademas se borra el dato previamente almacenado 0xD6


STOP   ;Etiqueta que hace referencia a la dirección de memoria en la que se coloca la línea

       asr     R4, R3, #5 ;Desplazamiento aritmetico a la derecha desplazazando 5 bits
       ;       Respetando el signo del valor ingresado
       ;       el valor final sera almacendao en el registro R4
       asr     R2, R3, R0 ;Desplazamiento aritmetico a la derecha desplaza la cantidad de bits almacenada
       ;       en el registro R0 el valor final sera almacenado en el registro R2
       asr    R6, R5, #5;Desplazamiento aritmetico a la derecha 5 bits respetando el signo del valor almacenado
       ;       el valor final sera almacenado en el registro R6

       asrs    R6, R5, #5;Desplazamiento aritmetico a la derecha de 5 bits respetando el signo del valor almacenado
       ;       el valor final sera almacenado en el registro R6
       ;       los valores de bandera seran almacenados, en este caso la bandera "C"

       B       STOP ;Salto a la direccion de memoria que enuncia la etiqueta "STOP"
       END     ;Finalizacion del codigo ASM