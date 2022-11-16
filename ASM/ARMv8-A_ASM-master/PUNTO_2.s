       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881
       MOV     R1,#0x12
LOOP   
       LSR     R2,R1,#0X1
       LSR     R2,R1,#0X3
       LSR     R2,R1,#0X12

       B       LOOP
       END