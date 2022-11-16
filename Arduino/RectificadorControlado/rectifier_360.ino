//Juan Camilo Serrano Correa
int c = 0;
bool Toggle = false;
int Angle = 8333;//2500*x/27
int OverAngle = 0;
//int Angle = map(90,30,150,2778,13886);//
float Courrent = 0;
float Courrent1 = 0;
void setup()
{
  Serial.begin(9600);
  Serial.println(Angle);
  Serial.print("");
  DDRB = B00100111;//PORTB D8-D10 OUTPUT
  // Configuracion de TIMER1
  TCCR1A = 0;                // limpia registro
  TCCR1B = 0;                //limpia registro
  TCNT1  = 0;                //Inicializa el temporizador --------------
  OCR1A = 4000;            // carga el registrador de comparación: (16MHz/1024*1Hz) -1 = 15624 = 0X3D08
  TCCR1B |= (1 << WGM12) | (1 << CS11) | (0 << CS10) | (0 << CS12); // modo CTC, prescaler de 8: CS12 = 1 e CS10 = 1
  TIMSK1 |= (1 << OCIE1A);  // habilita interrupción por igualdade de comparación
  attachInterrupt(digitalPinToInterrupt(2), ZeroCross, RISING);
}
void loop()
{
  if (Serial.available() != 0) {
    //Angle = Serial.parseInt();
    Angle = Serial.parseInt();
    Serial.println(Angle);
  }
  if (Angle <= 11000) {
    if (c == 0) {
      PORTB = B00000000;
      OCR1A = Angle;
      //Angle=map(analogRead(A2), 0, 1023, 2778, 13886);
    } else if (c == 1) {
      PORTB = B00100001; //R
      OCR1A = 40;
    } else if (c == 2) {
      PORTB = B00000000;
      OCR1A = 11052;
    } else if (c == 3) {
      PORTB = B00100010; //S
      OCR1A = 40;
    } else if (c == 4) {
      PORTB = B00000000;
      OCR1A = 11052;//
    } else if (c == 5) {
      PORTB = B00100100; //T
      OCR1A = 40;
    } else if (c == 6) {
      PORTB = B00000000;
      //Courrent = analogRead(A0);
      //Courrent1 = analogRead(A1);
      OCR1A = 600;
    }
  } else {
    OverAngle = Angle - 11000;
    if (c == 0) {
      PORTB = B00000000;
      OCR1A = OverAngle;
      //Angle=map(analogRead(A2), 0, 1023, 2778, 13886);
    } else if (c == 1) {
      PORTB = B00100100; //T
      OCR1A = 40;
    } else if (c == 2) {
      PORTB = B00000000;
      OCR1A = 11052;
    } else if (c == 3) {
      PORTB = B00100001; //R
      OCR1A = 40;
    } else if (c == 4) {
      PORTB = B00000000;
      OCR1A = 11052;//
    } else if (c == 5) {
      PORTB = B00100010; //S
      OCR1A = 40;
    } else if (c == 6) {
      PORTB = B00000000;
      //Courrent = analogRead(A0);
      //Courrent1 = analogRead(A1);
      OCR1A = 600;
    }
  }
}
ISR(TIMER1_COMPA_vect)          // interrupción por igualdade de comparación en TIMER1
{
  c++;//Address
}
void ZeroCross() {
  if (Toggle) {//Reset when 360 cero crossing
    TCNT1  = 0;//Reset timer
    c = 0;    //Reset counter
  }
  Toggle = not Toggle;//To ignore 180 cero crossing
}
// Angle = map(analogRead(A2), 0, 1023, 2778, 13886);//30-150
//PORTB = B00000001; //63ns
//digitalWrite(R, HIGH); //4us
