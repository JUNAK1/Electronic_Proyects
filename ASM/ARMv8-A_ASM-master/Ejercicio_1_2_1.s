       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881

       mov     R0, #0x06 ;Alamcenamiento del dato hexadecimal 0x06 al registro R0
       mov     R3, #0x200 ;Alamcenamiento del dato hexadecimal 0x200 al registro R3

       ;mov    R5, #0x9B1D--Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;limitantes del software
       mov     R5, #0x9B ; R5 <- 0x9B

STOP   ;Etiqueta que hace referencia a la dirección de memoria en la que se coloca la línea
       lsr     R4, R3, #6 ;Desplazamiento logico hacia la derecha de 6 bits del numero
       ;       almacenado en el registro R3, cuyo desplazamiento sera almacenado
       ;       en el registo R4
       lsr     R2, R3, R0 ;Desplazamiento logico a la derecha cuya cantidad de bits ha dezplazar
       ;       esta almacenada en el registro R0, cuyo valor de desplazamiento sera
       ;       almacenado en el registro R2
       lsr     R6, R5, #5 ;Desplazamiento logico a la derecha de 5 bits del numero que esta almacenado
       ;       en registro R5, cuyo valor se almacenara en el registro R6
       lsrs    R7, R5, #5 ;Desplazamiento logico a la derecha de 5 bits del valor almacenado
       ;       en el registro R5, ademas de la escritura de las banderas "C=1" ultimo valor en ser despreciado
       B       STOP ;Salto a la direccion de memoria que enuncia la etiqueta "STOP"

       END     ;Finalizacion del codigo ASM