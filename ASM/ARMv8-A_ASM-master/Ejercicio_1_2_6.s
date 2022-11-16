       ;       Nombres:------------------- -------Codigo:
       ;       Juan Camilo Serrano Correa---------- 201621366
       ;       Nelson Eduardo Torres Rivera --------201521881

       ;x      DCD 2; --- x no es valido como instruccion y un carecter de etiqueta no esta disponible
data   DCD     2 ; 2 bytes para la variable data son reservados
data_1 DCD     2; 2 Bytes para la variable data_1 son reservados
       START;Etiqueta de inicio
       MOV     R0,#0X2D;Almacenamiento del valor numerico 0x20 en el registro R0
       MOV     R1,#0X40;Almacenamiento del valor numerico 0x40 en el registro R1
       LDR     R2, =data_1;Cargar la direccion de la variable dato_1 en R2
       ADD     R0,R0,R1; Sumar el contenido de R0 con R1 y el resultado guardarlo en R0
       ;DCB    mode word
       STR     R0,[R2]; Almacena el contenido de R0 en la ubicacion de memoria de R2
       B       STOP

STOP   

ALIGN  
       END