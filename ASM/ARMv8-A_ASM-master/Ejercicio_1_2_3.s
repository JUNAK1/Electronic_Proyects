       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881

       mov     R7, #0xC ;Alamcenamiento del dato hexadecimal 0xC al registro R7
       mov     R0, #-0x281 ;Alamcenamiento del dato hexadecimal -0x281 al registro R0
       ;mov    R2, #0x25C3 --El dato hexadecimal 0x25C3 es imposible de almacenar en el registro R2
       ;       Por limitantes del software
       mov     R2, #0x25

       ;mov    R4, #0x593C --Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;       limitantes del software
       mov     R4, #0x59 ;R4<-0x59

       ;mov    R4, #0xA377--Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;       limitantes del software
       mov     R4, #0xA3 ;R4<-0xA3 el valor previamente almacenado es desechado

STOP   ;Etiqueta que hace referencia a la dirección de memoria en la que se coloca la línea
       lsl     R1, R0, #3 ;Dezplazamiento logico a la izquierda de 3 bits del valor almacenado en el registro
       ;       R0, Valor final se almacenara en el registro R1
       lsl     R3, R2, R7 ;Desplazamiento logico a la izquierda, cuya cantidad de bits a desplazar esta almacenado
       ;       en el registro R7, el valor a desplazar R2, el valor final se almacenara en el registro R3
       lsl     R5, R4, #10 ;Desplazamiento logico a la izquierda de 10 bits del valor almacenado en el registro
       ;       R4, Valor final se almacenara en el registro R5
       lsls    R6, R4, #10 ;Desplazamiento logico a la izquierda de 10 bits del valor almacenado en el reistro R4
       ;       el valor final sera almacenado en registro R6
       ;       El valor de banderas son cambiados en este caso sera C
       B       STOP ;Salto a la direccion de memoria que enuncia la etiqueta "STOP"
       END     ;Finalizacion del codigo ASM