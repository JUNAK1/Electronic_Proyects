#INCLUDE <16F873.H>
#FUSES   XT,NOWDT
#USE  DELAY(CLOCK=4000000)
#USE  RS232(BAUD=9600,XMIT=PIN_C6,RCV=PIN_C7,BITS=8)
#INCLUDE <FLEXLCD.H>


INT VALOR;

#INT_RDA
RDA_ISR(){
VALOR=GETC();
}

VOID MAIN(){
LCD_INIT();
ENABLE_INTERRUPTS(INT_RDA);
ENABLE_INTERRUPTS(GLOBAL);

FOR(;;){
LCD_GOTOXY(1,1);
PRINTF(LCD_PUTC,"Recibiendo= %1d",VALOR);
}
}