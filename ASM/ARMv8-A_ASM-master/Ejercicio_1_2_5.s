       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881

       ;mov    R3, #0xD129-- Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;       limitantes del software
       mov     R3,#0xD1 ;Almacenamiento del valor numerico oxD1 en el registro R3

       ;mov    R3, #0xF29A-- Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;       limitantes del software
       mov     R3,#0x7F ;R3<-0xF2 el valor almacenado previamente se desecha
       rrx     R4, R3
STOP   ;Etiqueta que hace referencia a la dirección de memoria en la que se coloca la línea

       ;Rotacion a la derecha un bit el valor almacenado en el registro R3, cuyo valor
       ;       se almacenara en el registro R4

       rrxs    R4, R4;Rotaccion a la derecha un bit el valor almacenado en el registro R3, cuyo valor
       ;       se almacenara en el registro R2, el dato que sera despreciado se almacena en la bandera "C"

       B       STOP ;Salto a la direccion de memoria que enuncia la etiqueta "STOP"

       END     ;Finalizacion del codigo ASM