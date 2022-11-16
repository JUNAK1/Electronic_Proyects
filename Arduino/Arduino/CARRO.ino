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
volatile float VEL = 0;
volatile float XX = 0;
volatile int g = 30;
volatile int h = 150;
void setup() {
  attachInterrupt(digitalPinToInterrupt(2), sensor, RISING); //probar otras opciones
  //LOW,CHANGE,FALLING,RISING
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
  s.attach(6);
}

void loop() {

  static unsigned long delayy = 0;
  unsigned long tiempo = millis();
  if (tiempo - delayy >= 1000) {//r=3.5cm , C= 11cm
    // Serial.print("RPS: ");
    //Serial.println(CONTADOR);
    XX = CONTADOR / 4;
    VEL =  (XX * 11) / 100;
    lcd.print("V: ");
    lcd.print(VEL);
    lcd.print("m/S");
    lcd.print("         ");

    /*if (CONTADOR < 10) {
      V++;
      }
      else {
      V--;
      }*/
    CONTADOR = 0; // RESET CONTADOR
    delayy = tiempo;
  }

  servox();
  if (millis() >= pingTimer) {
    pingTimer += pingSpeed;
    sonar.ping_timer(echoCheck);
  }
  if ((sonar.ping_result / US_ROUNDTRIP_CM) > 18) {
    //  digitalWrite(LED_BUILTIN, HIGH);
    // Adelante();
    digitalWrite(ENA, HIGH);
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, LOW);

    digitalWrite(ENO, HIGH);
    digitalWrite(IN3, HIGH);
    digitalWrite(IN4, LOW);
  }
  else if ((sonar.ping_result / US_ROUNDTRIP_CM) < 18 and (sonar.ping_result / US_ROUNDTRIP_CM) > 16) {
    digitalWrite(ENA, LOW);
    digitalWrite(ENO, LOW);
  }
  else {
    digitalWrite(ENA, HIGH);
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, HIGH);

    digitalWrite(ENO, HIGH);
    digitalWrite(IN4, HIGH);
    digitalWrite(IN3, LOW);
    //digitalWrite(LED_BUILTIN, LOW);
  }
}

void echoCheck() {
  if (sonar.check_timer()) {
    // Serial.print("Ping: ");
    // Serial.print(sonar.ping_result / US_ROUNDTRIP_CM);
    //Serial.println("cm");                                     //imprimir distacia del ultrasonico al obstaculo
  }
}
/*
  void servox() {

  static unsigned long delayy = 0;
  if (pingTimer - delayy > 100) {

    s.write(g);
    g += 3;
    if (g >= 151) {
      g = 60;
    }
    delayy = pingTimer;
  }
  }*/
void Adelante() {
  digitalWrite(ENA, HIGH);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
}
void sensor() {
  CONTADOR++;
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
