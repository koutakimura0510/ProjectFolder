#include <Arduino.h>
#include <stdint.h>
#include <Wire.h>
#include "ssd1306.h"
#include "myled.h"

#define LED_PIN	(25)

void setup() {
	pinMode(LED_PIN, OUTPUT);
	digitalWrite(LED_PIN, HIGH);
	// Serial.begin(115200);
	// Serial.println("start0");
	Wire.begin();
	Wire.setClock(400000);
	// ssd1306_init();
}

void loop() {
	static uint8_t data = 0;

	delay(1000);
	i2c_write(WR_BYTE, data);
	led_blink(1000, LED_PIN)
	data++;
	data &= 0xff;
}