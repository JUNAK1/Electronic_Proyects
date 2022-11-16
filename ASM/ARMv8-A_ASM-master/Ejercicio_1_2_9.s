       ;       Nombres:------------------- -------Codigo:
       ;       Juan Camilo Serrano Correa---------- 201621366
       ;       Nelson Eduardo Torres Rivera --------201521881

data   DCD     4; 4 bytes reservados para la variable data
START  
       ;MOV    R0, #0X4A8 ;--Comandos de ejcucion no soportados por el software
       MOV     R0, #0X4A ;R0<-0x4A
       ;       MOV R1, #0X761 ;--Comandos de ejecucion no soportados por el software
       MOV     R1, #0X76 ;R1<-0x76
       MOV     R4, #0X8D ;R4<-0x8D
       MOV     R3, #0X0C ;R3<-0x0C
       SUB     R1,R1,R0 ;
       LDR     R2,=data
       STR     R1,[R2] ;Almacena el contenido de R1 en la direccion de memoria del contenido de R2
       STR     R1,[R2,#4];Almacena el contenido de R1 en la ubicacion de memoria de R2 + 4
       STR     R1,[R2,R3];Almacena el contenido de R1 en la ubicacion de memoria de R2 + R3
       STR     R1,[R2,R3,LSL #2];
       LDR     R2,=data
       STR     R1,[R2],#12 ;Post-index: Save from the unmodified address in R2 first, then update R2 (to R2 + #12)
       STR     R4,[R2],#24 ;Post-index: Save from the unmodified address in R2 first, then update R2 (to R2 + #24)
       LDR     R2,=data
       STR     R1,[R2,#32]!;Pre-index: Update R2 first (to R2 + #32), then Save from the new address
       B       STOP; Salto a la etiqueta Stop

STOP   
       END