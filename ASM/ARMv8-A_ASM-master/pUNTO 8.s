       ;       Nombres:------------------- -------Codigo:
       ;       Juan Camilo Serrano Correa---------- 201621366
       ;       Nelson Eduardo Torres Rivera --------201521881

N1     DCD     1
N2     DCD     1
       MOV     R14,#0X00

       MOV     R0, #0X01
       LDR     R5,=N1

LOOP   ;SE     REPITE 50 VECES
       ;AQUI   SE LLENAN LOS 50 DATOS EN LA MEMORIA
       CMP     R14,#0X31

       STR     R0,[R5]
       ;LDR    R5, [R5,#04] ;Almacena el contenido de R1 e
       ADD     R5,R5,#04
       ADD     R0,R0,#01

       ADD     R14,R14,#0X1;SIMILAR A FOR(I=0;I++;I>50){}
       BHS     NEXT;SE ACABA EL FOR
       B       LOOP
       ;-      - - - - - - - - - - - - - - - - - - - - - - -

NEXT   
       LDR     R1, =N1 ;Se carga la direccion de mem
       LDR     R2, =N2 ;Se carga la direccion de mem
START  
       LDR     R7, [R1];Carga el data de la direccion de mem
       LDR     R8, [R2];Carga el data de la direccion de mem

       ;       Bubble sort
       CMP     R8,R7
       BHS     R8R7 ;if(R2>R1)
       B       R7R8 ;else(R1<R2)

R8R7   
       MOV     R3,R7
       MOV     R7,R8
       MOV     R8,R3
       STR     R8,[R2]
       STR     R7,[R1]
       ADD     R1,R1,#4
       ADD     R2,R2,#4
       B       START
R7R8   
       LDR     R1, =N1 ;Se carga la direccion de mem
       LDR     R2, =N2 ;Se carga la direccion de mem
       B       START
STOP   
       END