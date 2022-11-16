       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881
       MOV     R1,#0x100
LOOP   
       LSL     R2,R1,#0X1;SHIFT LEFT MUL 2.
       LSL     R2,R2,#0X1;SHIFT LEFT MUL 2.
       LSR     R2,R2,#0X1;SHIFT RIGHT DIV 2.
       LSR     R2,R2,#0X1;SHIFT RIGHT DIV 2.

       B       LOOP
       END