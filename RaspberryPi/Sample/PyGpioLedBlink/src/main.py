import RPi.GPIO as GPIO
import time

GPIO_OUT_22 = 22

GPIO.setmode(GPIO.BCM)
GPIO.setup(GPIO_OUT_22, GPIO.OUT)

for i in range(8):
    GPIO.output(GPIO_OUT_22, GPIO.HIGH) # 点灯
    time.sleep(0.4)
    GPIO.output(GPIO_OUT_22, GPIO.LOW) # 消灯
    time.sleep(0.4)

GPIO.cleanup()