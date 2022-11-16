       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881
       MOV     R1,#-0x80
LOOP   
       LSR     R2,R1,#0X2;SHIFT RIGHT DIV 2.
       ASR     R3,R1,#0X2;SHIFT LEFT MUL 2.
       B       LOOP
       END