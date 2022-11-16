        ;       Nombres:------------------- -------Codigo:
        ;       Juan Camilo Serrano Correa---------- 201621366
        ;       Nelson Eduardo Torres Rivera --------201521881


High    DCB     0,0,0,0; 4 byte reservados para la variable High
Low     DCB     0,0,0,0; 4 byte reservados para la variable Low
Result  DCB     0,0,0,0; 4 byte reservados para la variable Result
Result1 DCD     0 ; 4 bytes reservados para la variable Result1
        START;  Etiqueta
        LDR     R0,=High;R0=
        LDR     R1,=Low;R1=
        LDR     R2,=Result;R2=
        LDR     R5,=Result1;R5=
        MOV     R3, #0x5;R3<- 0x5
        MOV     R4, #0x8;R4<-0x8
        ;LSL    R3, #4--CODIGO ORIGINAL FALTA REGISTRO DE DESTINO
        LSL     R3,R3,#4;R3<-(R3<<4)
        STRB    R3,[R0];Almacena el contenido de R3 en la ubicacion de memoria de R0
        ;       el tamaño debe ser de 8 bits
        STRB    R4,[R1];Almacena el contenido de R4 en la ubicacion de memoria de R1
        ;       el tamaño debe ser de 8 bits
        ORR     R3,R3,R4;Establezca los cuatro bits inferiores de R3 iguales a
        ;       los cuatro bits inferiores de R4
        STRB    R3,[R2];Almacena el contenido de R3 en la ubicacion de memoria de R2
        ;       el tamaño debe ser de 8 bits
        STR     R3,[R5];Almacena el contenido de R3 en la ubicacion de memoria de R5
        ;       el tamaño debe ser de 64 bits
ALIGN   

        B       STOP
        STOP;   Etiqueta
        END;    Fin del programa