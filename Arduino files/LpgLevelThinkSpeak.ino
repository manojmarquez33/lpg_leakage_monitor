#include <ESP8266WiFi.h> // Include the ESP8266 Wi-Fi library
#include <Servo.h>
#include <ThingSpeak.h>

Servo myservo;
int pos = 20; 
int BUZZER = 4; // Digital pin for Buzzer on NodeMCU (GPIO 4)
int LPG_sensor_analog = A0; // Analog pin for LPG sensor on NodeMCU (MQ-6 SENSOR)
int LPG_detected;

// ThingSpeak Configuration
const char *ssid = "Redmi note 10 pro"; // Change to your WiFi SSID
const char *password = "*******"; // Change to your WiFi password
unsigned long channelID = 2328482; // Change to your ThingSpeak channel ID
const char *writeAPIKey = "*****************"; // Change to your ThingSpeak write API key

WiFiClient client; // Declare the WiFi client object

void setup() {
  Serial.begin(9600); // Start serial debugging
  ThingSpeak.begin(client); // Initialize ThingSpeak client
  
  myservo.attach(15); // Attach servo to GPIO 15 pin (D8 on NodeMCU)
  pinMode(BUZZER, OUTPUT);
  myservo.write(pos);

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
  Serial.println("Connected to WiFi");
}

void loop() {
  LPG_detected = analogRead(LPG_sensor_analog); // Read analog value from sensor
  Serial.println(LPG_detected);
  if (LPG_detected > 400) { // Adjust threshold as per your sensor's sensitivity
    Serial.println("LPG detected...");
    digitalWrite(BUZZER, HIGH);
    myservo.write(pos - 160);
    delay(500);
    // Update ThingSpeak with LPG detection
    ThingSpeak.setField(1, "LPG detected");
    ThingSpeak.writeFields(channelID, writeAPIKey);
  } else {
    Serial.println("No LPG detected");
    digitalWrite(BUZZER, LOW);
    myservo.write(pos);
    delay(500);
    // Update ThingSpeak with no LPG detection
    ThingSpeak.setField(1, "No LPG detected");
    ThingSpeak.writeFields(channelID, writeAPIKey);
  }
  delay(2000); // Delay for 20 seconds before next update
}