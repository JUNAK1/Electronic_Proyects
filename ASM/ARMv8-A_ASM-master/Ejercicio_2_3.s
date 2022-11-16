       ;Nombres: Codigo:
       ;       Juan Camilo Serrano Correa 201621366
       ;       Nelson Eduardo Torres Rivera 201521881

       ;mov    R1, #0x12AD-- Almacenamiento imposible de ejecutar, valor imposible de guardar por
       ;       limitantes del software

       mov     R1, #0xAD ;R1<-0xAD
       mov     R2, #0x05 ;R2<-0x01

START  ;Etiqueta

       CMPS    R2 ,#0x04 ;R2-0x01
       BHS     Des_s ;if(R2==1) {Des_s}
       B       Des_p ;else if {Des_p}

Des_s  ;Etiqueta
       ;       Desplazamiento logico a la dercha de 1 bit
       MOV     R1,R1,ASR #1 ;R1<- (R1>>1)
       MOV     R2,#0x05 ;R2<- 0x05
       B       START ; Salto a la direccion de memoria que enuncia la etiqueta "START"


Des_p  ;Etiqueta

       ;       Desplzamiento Logico a la derecha de 5 y 15 bits.

       MOV     R1,R1,ASR R2 ;R1<- (R1>>R2)
       ADD     R2,R2,R2 ;R2<- R2+R2
       ADD     R2,R2,R2 ;R2<- R2+R2
       CMPS    R2,#0x50 ;R2-0x50
       BEQ     STOP ;if(R2==0x50) {STOP}
       B       START ;else if {START}

STOP   ;Etiqueta
       END     ;Fin de ejecucion del programa