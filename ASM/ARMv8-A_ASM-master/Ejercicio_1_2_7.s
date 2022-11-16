       ;       Nombres:------------------- -------Codigo:
       ;       Juan Camilo Serrano Correa---------- 201621366
       ;       Nelson Eduardo Torres Rivera --------201521881

Result DCD     4; 4 bytes reservados para la variable resultado

START  ;       etiqueta del incio del programa

       LDR     R1,=0x458C3; Cargar el valor 0x458C3 en R1 que esta fuera del rango de la instruccion mov
       LDR     R2,=0xA8261;Cargar el valor 0xA8261 en R2 que esta fuera del rango de la instruccion mov
       LDR     R4,=Result; Cargar la direccion de la variable result en R4
       MOV     R0,#0; R0<-#0
       ;       MUL R3,R1,R2;--Instruccion imposible ejecutar por el software
       ADD     R3,R1,R2 ;R3<-(R1+R2)
       ;       LSRS R3, #9;-- En el codigo original falta el registro de destino
       LSRS    R3, R3, #9; R3<-(R3>>3)
       STR     R3,[R4]; Almacena el contenido de R3 en la ubicacion de memoria de R4
       B       STOP; Salto a la direccion de memmoria que enuncia la etiqueta Stop
STOP   ;       etiqueta

       END;    Fin del programa