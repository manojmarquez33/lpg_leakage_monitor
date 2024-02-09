#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#include <Servo.h>

// Firebase settings
#define FIREBASE_HOST "lpg-gas-847fb-default-rtdb.firebaseio.com/" // Replace with your Firebase project URL
#define FIREBASE_AUTH "uKiPRxZGq4HBqIGGJNCY8XJAt3sNW5G4ts4AehLP" // Replace with your Firebase auth token

#define SERVO_PIN D8 // Digital pin for servo motor on NodeMCU (GPIO 15)
#define BUZZER_PIN D1 // Digital pin for Buzzer on NodeMCU (GPIO 4)
#define LPG_SENSOR_ANALOG A0 // Analog pin for LPG sensor on NodeMCU (MQ-6 SENSOR)

int LPG_detected;

Servo servoMotor;

void setup() {
  Serial.begin(9600);
  pinMode(BUZZER_PIN, OUTPUT);
  servoMotor.attach(SERVO_PIN);

  // Connect to Wi-Fi
  WiFi.begin("yourSSID", "yourPassword"); // Replace with your SSID and password
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connected to Wi-Fi");

  // Firebase setup
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {
  LPG_detected = analogRead(LPG_SENSOR_ANALOG);
  Serial.println(LPG_detected);
  
  if (LPG_detected > 
  400) {
    Serial.println("LPG detected...");
    digitalWrite(BUZZER_PIN, HIGH);
    servoMotor.write(180); // Move servo to a position indicating gas detected
    delay(5000);
  } else {
    Serial.println("No LPG detected");
    digitalWrite(BUZZER_PIN, LOW);
    //servoMotor.write(0); // Move servo to a position indicating no gas detected
    delay(5000);
  }
  
  // Post MQ sensor reading to Firebase
  Firebase.setInt("MQ_reading", LPG_detected);

  // Update Firebase every 30 seconds
  delay(30000);
}