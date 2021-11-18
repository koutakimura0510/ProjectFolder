#include <Arduino.h>
#include <Wire.h>
#include "SSD1306.h"
// 
SSD1306 display(0x3c, 21, 22);
int led = 1;

void setup() {
  // put your setup code here, to run once:
  pinMode(4, OUTPUT);
  display.init();
  display.setFont(ArialMT_Plain_16);
  display.drawString(0, 0, "Hello World");
  display.display();
}

void loop() {
  digitalWrite(4, led);
  led ^= 1;
  delay(1000);
}