#include <Arduino.h>

#include <WiFi.h>
#include <WiFiMulti.h>

#include <HTTPClient.h>

#include <ArduinoJson.h>

#include <SoftwareSerial.h>
#include <MHZ19.h>

#define RX_PIN 33
#define TX_PIN 32

// TODO Certificate
static const char* NODE_MAC = "5FC7FB523F1C";

WiFiMulti wifiMulti;

MHZ19 co2Sensor;
SoftwareSerial co2SensorSerial(RX_PIN, TX_PIN);

void setup() {
    Serial.begin(115200);

    co2SensorSerial.begin(9600);
    co2Sensor.begin(co2SensorSerial); 
    co2Sensor.autoCalibration(); 

    wifiMulti.addAP("Eliane", "xxx redacted xxx");
}

void loop() {
    if (wifiMulti.run() == WL_CONNECTED) {
        HTTPClient http;

        http.begin("192.168.2.103:8080/api/v1/reports");

        http.addHeader("Content-Type", "application/json");

        int ppm = co2Sensor.getCO2();

        StaticJsonBuffer<256> requestBuffer;
        JsonObject& requestJson = requestBuffer.createObject();
        requestJson["nodeMac"] = NODE_MAC;
        requestJson["ppm"] = ppm;

        String requestData;
        requestJson.printTo(requestData);
        
        int responseCode = http.POST(requestData);

        const char* errorMessage;
        
        if (responseCode == HTTP_CODE_OK) {
            String responseBody = http.getString();
            StaticJsonBuffer<1024> responseBuffer;
            JsonObject& response = responseBuffer.parseObject(responseBody);

            if (!response.success()) {
               errorMessage = "Could not parse response!";
            } else if (response["status"] == "ERROR") {
                errorMessage = response["message"];
            } else {
                errorMessage = { 0 };
            }
        } else {
            errorMessage = http.errorToString(responseCode).c_str();
        }

        if (errorMessage) {
            Serial.printf("Could not send report succesfully! Response: %s\n",
                errorMessage);
        }

        http.end();

        delay(10000);
    }
}
