#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <ESPAsyncWebServer.h>

#define MQ2pin 35

#define WIFI_SSID ""
#define WIFI_PASSWORD ""

#define API_KEY ""
#define DATABASE_URL "" 

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

AsyncWebServer server(80);

bool signupOK = false;
float sensorValue; 
int IRSensor = 2;

void setup() {
  Serial.begin(115200);
  Serial.println("Serial Working");

  pinMode(IRSensor, INPUT);
  Serial.println("MQ2 warming up!");
  delay(20000); 
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request) {
    int sensorStatus = digitalRead(IRSensor);
    if (sensorStatus == 1) {
      request->send(200, "text/plain", "unlocked");
    } else {
      request->send(200, "text/plain", "locked");
    }
  });

  server.on("/sensor", HTTP_GET, [](AsyncWebServerRequest *request){
    float sensorValue = analogRead(MQ2pin);
    request->send(200, "text/plain", String(sensorValue));
  });

  server.begin();
  
}

void loop() {
  sensorValue = analogRead(MQ2pin);
  Serial.println("Raw Sensor Value: ");
  Serial.println(sensorValue);

  int sensorStatus = digitalRead(IRSensor);

  if (Firebase.ready() && signupOK){

  if (sensorStatus == 1)
  {
    Serial.println("Door Opened!");
    Firebase.RTDB.setString(&fbdo, "IRSENSOR/Door", "OPEN");
  }
  else  {
    Serial.println("Door Closed!");
    Firebase.RTDB.setString(&fbdo, "IRSENSOR/Door", "CLOSE");
  }

    if (Firebase.RTDB.setFloat(&fbdo, "MQ2/Sensor-value", sensorValue)){
      Serial.println("PASSED");
      Serial.println("PATH: " + fbdo.dataPath());
      Serial.println("TYPE: " + fbdo.dataType());
    }
    else {
      Serial.println("FAILED");
      Serial.println("REASON: " + fbdo.errorReason());
    }
  }

  Serial.println("-----------------------");
  delay(1500); // wait 2s for next reading
}