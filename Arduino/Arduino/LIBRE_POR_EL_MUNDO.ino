#include <Wire.h>
#include <LCD.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd (0x27, 2, 1, 0, 4, 5, 6, 7); // DIR, E, RW, RS, D4, D5, D6, D7
bool lux;
#include <Servo.h>
#include <NewPing.h>
Servo s;

#define TRIGGER_PIN  2
#define ECHO_PIN  3
#define MAX_DISTANCE 500 //maximum sensor distance is rated at 400-500cm.

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

unsigned int pingSpeed = 50;
unsigned long pingTimer;

int t = 1000;

int IN1 = 10;
int IN2 = 9;
int ENA = 11;
int IN3 = 8;
int IN4 = 7;
int ENO = 6;

void servox();
void Adelante();

volatile int CONTADOR = 0;
volatile float XX = 0;
volatile int g1 = 0;
volatile int g = 0;
volatile int XI;
volatile float L;

void setup() {
  lcd.setBacklightPin(3, POSITIVE);
  lcd.setBacklight(HIGH);
  lcd.begin(16, 2);
  lcd.clear();

  Serial.begin(9600);
  pingTimer = millis();
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(ENO, OUTPUT);
  s.attach(6);
}
void loop() {
  if (millis() >= pingTimer) {
    pingTimer += pingSpeed;
    sonar.ping_timer(echoCheck);
  }
  if ((sonar.ping_result / US_ROUNDTRIP_CM) > 18) {
    Adelante();
  }
  else {
    digitalWrite(ENA, 0);
    digitalWrite(ENO, 0);
    servox();
    if (g1 >= 90) {//DERECHA
      while (XX > L) {
        attachInterrupt(digitalPinToInterrupt(2), sensor, RISING);
        DERECHA();
      }
    }
    if (g1 <= 90) { //IZQUIERDA
      while (XX > L) {
        attachInterrupt(digitalPinToInterrupt(2), sensor, RISING);
        IZQUIERDA();
      }
    }
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
  CONTADOR++;
  XX = (CONTADOR * 6.6 * 3.14) / 20;// CONVERSION A DISCTANCIA RECORIDA                          **
}
void servox() {
  for (g; g < 180; g++) {
    int n;
    lux != lux;
    lcd.setBacklight(lux);
    s.write(g);
    g += 3;     //                      ** +1
    //XI = max(g, XI); //  agulo
    n = XI;
    XI = max((sonar.ping_result / US_ROUNDTRIP_CM), XI);//mal
    if(XI > n){
     g1 = g;
      }
    Serial.print('g');
    Serial.println(g);
    Serial.println(sonar.ping_result / US_ROUNDTRIP_CM);
    delay(110);
  }
  L = ((3.14 * 6.6 * g1) / 360); //(PI*D*Ø)/360 ; longitud de arco 
  Serial.print('x');
  Serial.println(g1);
  Serial.print('L');
  Serial.println(L);
}
void Adelante() {
  analogWrite(ENA, 150);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);

  analogWrite(ENO, 150);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);
}
void IZQUIERDA() {
  digitalWrite(ENA, 0);

  analogWrite(ENO, 150);
  digitalWrite(IN3, HIGH);
  digitalWrite(IN4, LOW);
}
void DERECHA() {
  analogWrite(ENA, 150);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);

  digitalWrite(ENO, 0);
}
