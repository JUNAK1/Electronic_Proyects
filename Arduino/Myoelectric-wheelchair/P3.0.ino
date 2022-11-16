#include <Wire.h>
#include <LCD.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd (0x27, 2, 1, 0, 4, 5, 6, 7); // DIR, E, RW, RS, D4, D5, D6, D7

#include <Servo.h>
#include <NewPing.h>
Servo s;

#define TRIGGER_PIN   2
#define ECHO_PIN      3
#define MAX_DISTANCE 500 //maximum sensor distance is rated at 400-500cm.
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.
unsigned int pingSpeed = 50;
unsigned long pingTimer;
//volatile int CONTADOR = 0;
volatile float VEL = 0;
volatile float XX = 0;
volatile int g = 30;
volatile int h = 150;
int ti = 1000;

int INC = 8;
int IND = 7;
int ENO = 6;
int INA = 10;
int INB = 9;
int ENA = 11;

volatile int CONTADOR = 0;
int i, cont;

float V = 20 ; //0-255
int minv = 10;
int maxv = 14;

volatile  int t = 0;

void control();
void times();
void diez();
void servox();
void Adelante();

void setup() {
  Serial.begin(9600);
  attachInterrupt(digitalPinToInterrupt(2), sensor, RISING);

  lcd.setBacklightPin(3, POSITIVE);
  lcd.setBacklight(HIGH);
  lcd.begin(16, 2);
  lcd.clear();
  pingTimer = millis();
  s.attach(6);
  pinMode(INA, OUTPUT);
  pinMode(INB, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(INC, OUTPUT);
  pinMode(IND, OUTPUT);
  pinMode(ENO, OUTPUT);

  /*digitalWrite(INC, LOW);
    digitalWrite(IND, HIGH);
    digitalWrite(INA, LOW);
    digitalWrite(INB, HIGH);*/
  //analogWrite(ENA, 255);//velocidad pico, arranque
  // analogWrite(ENO, 255);
  //delay(10);

  lcd.setCursor(0, 0);
  lcd.print("INICIANDO EN 3");
  delay(750);
  lcd.setCursor(0, 0);
  lcd.print("INICIANDO EN 2");
  delay(750);
  lcd.setCursor(0, 0);
  lcd.print("INICIANDO EN 1");
  delay(700);
  lcd.setCursor(0, 1);
  lcd.print("GO!!!");
  delay(300);
  lcd.clear();
}
void loop() {
  servox();
  times();
  diez();
  control();
  if (t == 2) {//                     ADELANTE
    digitalWrite(INC, LOW);
    digitalWrite(IND, HIGH);
    digitalWrite(INA, LOW);
    digitalWrite(INB, HIGH);
    t = 0;
  }
  else if (t == 3) {//                ATRAS
    digitalWrite(IND, LOW);
    digitalWrite(INC, HIGH);
    digitalWrite(INB, LOW);
    digitalWrite(INA, HIGH);
    t = 0;
  }
  else if ((t == 0 or t > 3) or ((sonar.ping_result / US_ROUNDTRIP_CM) < 18)) { // STOP
    digitalWrite(INC, LOW);
    digitalWrite(IND, 0);
    digitalWrite(INA, LOW);
    digitalWrite(INB, 0);
    t = 0;
  }
  if (millis() >= pingTimer) {
    pingTimer += pingSpeed;
    sonar.ping_timer(echoCheck);
  }
}
void control() {
  static unsigned long delayy = 0;
  unsigned long tiempo = millis();
  digitalWrite(INC, LOW);
  digitalWrite(IND, HIGH);
  digitalWrite(INA, LOW);
  digitalWrite(INB, HIGH);
  if (tiempo - delayy >= 200) {
    while (CONTADOR <= minv) {//velocidad min
      V = min(254, max(0, V));//ajustar velocidad max;
      V++;
      analogWrite(ENA, V);
      analogWrite(ENO, V);
      Serial.print("RPS+:        ");
      Serial.println(CONTADOR);
      Serial.print("vel+: ");
      Serial.println(V);
      lcd.setCursor(0, 1);
      lcd.print("VEL+:");
      lcd.println(V);
      break;
    }
    delayy = tiempo;
    while (CONTADOR<maxv and CONTADOR>minv) {//margen de velcidad
      Serial.print("RPS:         ");
      Serial.println(CONTADOR);
      Serial.print("vel: ");
      Serial.println(V);
      lcd.setCursor(0, 1);
      lcd.print("VEL:");
      lcd.print(V);
      break;
    }
    delayy = tiempo;
    while (CONTADOR >= maxv) {//velocidad max
      V = min(254, max(2, V));//ajustar velocidad max; no tome valores inferiores a 0 ni superiores a 255
      V -= 2;
      analogWrite(ENA, V);
      analogWrite(ENO, V);
      Serial.print("RPS-:        ");
      Serial.println(CONTADOR);
      Serial.print("vel-: ");
      Serial.println(V);
      lcd.setCursor(0, 1);
      lcd.print("VEL-:");
      lcd.println(V);
      break;
    }
    cont += CONTADOR;
    i ++;
    if (i == 10) {
      lcd.setCursor(0, 0);
      lcd.print("TOTAL:       ");
      lcd.print(cont);
      cont = 0;
      i = 0;
    }
    CONTADOR = 0; // RESET CONTADOR
    delayy = tiempo;
  }
  t = 0;
}
void times() {//ejm-digital-State change detection
  static unsigned long delayy = 0;
  unsigned long tiempo = millis();
  if (tiempo - delayy >= 170) {
    if (analogRead(A0) >= 560) {
      t++;
      lcd.setCursor(0, 0);
      lcd.print("PULSO NUMERO: ");
      lcd.print(t);
      delayy = tiempo;
      digitalWrite(13, HIGH );
    } else {
      digitalWrite(13, LOW);
    }
  }
}
void diez() {
  static unsigned long delayy = 0;
  unsigned long tiempo = millis();
  if (tiempo - delayy >= 3000) {
    lcd.setCursor(0, 1);//                         **
    lcd.print("TOTAL PULSOS: ");
    lcd.print(t);
    delayy = tiempo;
  }
}
void servox() {
  static unsigned long delayy = 0;
  if (pingTimer - delayy > 100) {
    s.write(g);
    g += 3;
    Serial.print('g');
    Serial.println(g);
    if (g >= 151) {
      if (pingTimer - delayy > 100) {
        s.write(h);
        h -= 3;
        Serial.print('h');
        Serial.println(h);
        if (h < 32) {
          h = 150;//**
          g = 30;
        }
        delayy = pingTimer;
      }
    }
    delayy = pingTimer;
  }
}
void echoCheck() {
  if (sonar.check_timer()) {
    // Serial.print("Ping: ");
    // Serial.print(sonar.ping_result / US_ROUNDTRIP_CM);
    //Serial.println("cm");                                     //imprimir distacia del ultrasonico al obstaculo
  }
}
void sensor() {
  CONTADOR++;//numero de aspas del motor
}
