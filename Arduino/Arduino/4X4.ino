#include <Wire.h>
#include <LCD.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd (0x27, 2, 1, 0, 4, 5, 6, 7); // DIR, E, RW, RS, D4, D5, D6, D7

int INC = 8;
int IND = 7;
int ENO = 6;
int INA = 10;
int INB = 9;
int ENA = 11;

int V = 30 ; //0-255
int V1 = 30 ; //0-255
volatile int CONTADOR = 0;
volatile int CONTADOR1 = 0;

int minv = 50;
int maxv = 55;
int tines = 1000;

void control();
void times();

void setup() {
  Serial.begin(9600);
  attachInterrupt(digitalPinToInterrupt(2), sensor, RISING);
  attachInterrupt(digitalPinToInterrupt(3), sensor1, RISING);
  lcd.setBacklightPin(3, POSITIVE);
  lcd.setBacklight(HIGH);
  lcd.begin(16, 2);
  lcd.clear();

  pinMode(INA, OUTPUT);
  pinMode(INB, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(INC, OUTPUT);
  pinMode(IND, OUTPUT);
  pinMode(ENO, OUTPUT);

  digitalWrite(INC, LOW);
  digitalWrite(IND, HIGH);
  digitalWrite(INA, LOW);
  digitalWrite(INB, HIGH);
  analogWrite(ENA, 255);//velocidad pico, arranque
  analogWrite(ENO, 255);
  delay(10);
}
void loop() {
  if (V <= 34) {//velocidad min para mover motor. ajustar cuando varie la carga
    analogWrite(ENA, 34);
  } if (V1 <= 34) {//velocidad min para mover motor. ajustar cuando varie la carga
    analogWrite(ENO, 34);
  }
  control();
  times();
}
void times() {
  static unsigned long delayy = 0;
  unsigned long tiempo = millis();
  if (tiempo - delayy >= tines) {
    Serial.print("Total               ");
    Serial.println(CONTADOR);
    lcd.setCursor(0, 0);
    lcd.print("T:  ");
    lcd.print(CONTADOR);
    lcd.setCursor(7, 0);
    lcd.print("T1: ");
    lcd.print(CONTADOR1);
    CONTADOR = 0; // RESET CONTADOR
    CONTADOR1 = 0;
    delayy = tiempo;
  }
}
void control() {
  static unsigned long delayy = 0;
  unsigned long tiempo = millis();
  if (tiempo - delayy >= tines) {
    while (CONTADOR <= minv) {//velocidad min
      V = min(254, max(0, V));//ajustar velocidad max;
      V++;
      analogWrite(ENA, V);
      Serial.print("RPS+:        ");
      Serial.println(CONTADOR);
      Serial.print("vel+: ");
      Serial.println(V);
      lcd.setCursor(0, 1);
      lcd.print("V+:");
      lcd.println(V);
      break;
    }
    while (CONTADOR1 <= minv) {//velocidad min
      V1 = min(254, max(0, V1));//ajustar velocidad max;
      V1++;
      analogWrite(ENO, V1);
      Serial.print("RPS+:        ");
      Serial.println(CONTADOR);
      Serial.print("vel+: ");
      Serial.println(V);
      lcd.setCursor(7, 1);
      lcd.print("V1+:");
      lcd.println(V1);
      break;
    }

    delayy = tiempo;
    while ((CONTADOR<maxv and CONTADOR>minv) or (CONTADOR1<maxv and CONTADOR1>minv)) {//margen de velcidad
      Serial.print("RPS:         ");
      Serial.println(CONTADOR);
      Serial.print("vel: ");
      Serial.println(V);
      lcd.setCursor(0, 1);
      lcd.print("V :");
      lcd.print(V);
      lcd.setCursor(7, 1);
      lcd.print("V1 :");
      lcd.print(V1);
      break;
    }
    delayy = tiempo;
    while (CONTADOR >= maxv) {//velocidad max
      V = min(254, max(1, V));//ajustar velocidad max; no tome valores inferiores a 0 ni superiores a 255
      V -= 2;
      analogWrite(ENA, V);
      Serial.print("RPS-:        ");
      Serial.println(CONTADOR);
      Serial.print("vel-: ");
      Serial.println(V);
      lcd.setCursor(0, 1);
      lcd.print("V-:");
      lcd.println(V);
      break;
    }
    while (CONTADOR1 >= maxv) {//velocidad max
      V1 = min(254, max(1, V1));//ajustar velocidad max; no tome valores inferiores a 0 ni superiores a 255
      V1 -= 2;
      analogWrite(ENO, V1);
      Serial.print("RPS-:        ");
      Serial.println(CONTADOR);
      Serial.print("vel-: ");
      Serial.println(V);
      lcd.setCursor(7, 1);
      lcd.print("V1-:");
      lcd.println(V1);
      break;
    }
    delayy = tiempo;
  }
}
void sensor() {
  CONTADOR++;//numero de aspas del motor
}
void sensor1() {
  CONTADOR1++;//numero de aspas del motor
}
