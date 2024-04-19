#include <Arduino.h>
#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>

// Provide the token generation process info.
#include "addons/TokenHelper.h"
// Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"
#include <DHT.h>

// Insert your network credentials
#define WIFI_SSID "2N4s1eqregrr12323"
#define WIFI_PASSWORD "vcsE23q@t2e"

// Insert Firebase project API Key
#define API_KEY "AIzaSyBTPJMMtn-vvk7rvexM-kDk_eDDT0aSfQY"

// Insert RTDB URLefine the RTDB URL */
#define DATABASE_URL "https://greenstack-fc700-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define soil_moisture_pin 35
#define relay1 33
#define relay2 25


// Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int count = 0;
bool signupOK = false;
DHT dht(26, DHT11);
int ldrPin = 27;
int ledPin = 2;

void setup() {
  pinMode(ldrPin, INPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(relay1,OUTPUT);
  pinMode(relay2,OUTPUT);
  dht.begin();
  delay(2000);
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("ok");
    signupOK = true;
  } else {
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback;  // see addons/TokenHelper.h

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop() {
  Serial.println(analogRead(soil_moisture_pin));
  if (analogRead(soil_moisture_pin) > 3000) {
    digitalWrite(relay1, HIGH);  // Writing value "HIGH" to the pin
    delay(1000);
  } else {
    digitalWrite(relay1, LOW);  // Writing value "LOW" to the pin
    delay(1000);
  }
  delay(500);
  float temp = dht.readTemperature();
  float humidity = dht.readHumidity();
  int val = digitalRead(ldrPin);
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 1500 || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();
    // Write an Int number on the database path test/int
    if (Firebase.RTDB.setInt(&fbdo, "test/int", count)) {
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    } else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    count++;

    if (Firebase.RTDB.setInt(&fbdo, "test/soil", analogRead(soil_moisture_pin))) {
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    } else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
    // Write an Float number on the database path test/float
    if (Firebase.RTDB.setFloat(&fbdo, "test/temperature", temp)) {
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    } else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (Firebase.RTDB.setFloat(&fbdo, "test/Humidity", humidity)) {
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    } else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }

    if (val == HIGH) {
      digitalWrite(ledPin, HIGH);
      digitalWrite(relay2, HIGH);
      Serial.println("LED ON");

      if (Firebase.RTDB.setString(&fbdo, "test/light", val)) {
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    } else {
      digitalWrite(ledPin, LOW);
      digitalWrite(relay2, LOW);
      Serial.println("LED OFF");

      if (Firebase.RTDB.setString(&fbdo, "test/light", val)) {
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());
      } else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }
  }
}