# 2023-09-23
# RaspberryPi Pico FW v1.20
#
#   U        A
# L   R    B   C
#   D        D

from machine import I2C, Pin
import utime

led = Pin(25, Pin.OUT)
SW_A = Pin(4, Pin.IN)
SW_B = Pin(6, Pin.IN)
SW_C = Pin(5, Pin.IN)
SW_D = Pin(7, Pin.IN)
SW_UP = Pin(21, Pin.IN)
SW_LEFT = Pin(20, Pin.IN)
SW_RIGHT = Pin(19, Pin.IN)
SW_DOWN = Pin(18, Pin.IN)
i2c = I2C(0, scl=Pin(1), sda=Pin(0), freq=100000)

# CTRL1 Reg, PD Default, Z,X,Y Enable
i2c.writeto_mem(0x6A, 0x20, bytearray([0x0B]))
i2c.writeto_mem(0x6A, 0x23, bytearray([0x20]))

while True:
    led.value(1)
    
    if 0 == SW_A.value():
        print("SW_A")

    if 0 == SW_B.value():
        print("SW_B")

    if 0 == SW_C.value():
        print("SW_C")

    if 0 == SW_D.value():
        print("SW_D")

    if 0 == SW_UP.value():
        print("SW_UP")

    if 0 == SW_LEFT.value():
        print("SW_LEFT")

    if 0 == SW_RIGHT.value():
        print("SW_RIGHT")

    if 0 == SW_DOWN.value():
        print("SW_DOWN")    

    # Msb | Lsb 
    x = (i2c.readfrom_mem(0x6A, 0x29, 1)[0] << 8) | i2c.readfrom_mem(0x6A, 0x28, 1)[0]
    y = (i2c.readfrom_mem(0x6A, 0x2B, 1)[0] << 8) | i2c.readfrom_mem(0x6A, 0x2A, 1)[0]
    z = (i2c.readfrom_mem(0x6A, 0x2D, 1)[0] << 8) | i2c.readfrom_mem(0x6A, 0x2C, 1)[0]

    if x >= 32768:
        x -= 65536
    if y >= 32768:
        y -= 65536
    if z >= 32768:
        z -= 65536
    
    x = x * 0.07
    y = y * 0.07
    z = z * 0.07

    print("X:%(x)5d, Y:%(y)5d, Z:%(z)5d" %{'x': x,'y': y,'z': z})
    utime.sleep(0.1)

    # utime.sleep(0.5)
    # led.value(0)
    # utime.sleep(0.5)