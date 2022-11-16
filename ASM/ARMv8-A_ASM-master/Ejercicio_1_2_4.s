       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881

       mov     R0, #0x9 ;Alamcenar el dato hexadecimal 0x9 al registro R0

       ;mov    R1, #0x25C3 --Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;limitantes del software
       mov     R1, #0x25;R1<-0x25

       ;mov    R3, #0x73A2 --Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;limitantes del software
       mov     R3, #0x73;R3<-0x73

       ;mov    R3, #0x5D81 --Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;limitantes del software
       mov     R3, #0x5D;R3<-0x5D El valor previamente almacendo es despreciado

STOP   ;Etiqueta que hace referencia a la dirección de memoria en la que se coloca la línea
       ror     R2, R1, #24 ;Rotacion a la derecha de los 24 bist mas significativos del dato almacenado en el registro R1
       ;       el valor final sera almacenado en el registro R2
       ror     R7, R3, R0 ;Rotacion a la derecha, cantidad de bits a rotar a la derecha es el valor almacenado
       ;       en el registro R3, el valor final sera almacenado en el registro R7
       ror     R4, R3, #10 ;Rotacion a la derecha de 10 bits del valor almacenado en el registro R3,
       ;       Valor final se almacenara en el registro R4
       rors    R5, R3, #10 ;Rotacion a la derecha de 10 bits del valor almacendao en el registro R3,
       ;       el valor final sera almacenado en el registro R3
       ;       los valores de bandera seran almacenados, en este caso la bandera "C"

       B       STOP ;Salto a la direccion de memoria que enuncia la etiqueta "STOP"
       END     ;Finalizacion del codigo ASM