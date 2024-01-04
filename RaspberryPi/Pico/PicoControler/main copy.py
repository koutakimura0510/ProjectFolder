"""
2023-09-23
FW MicroPython v1.20
Board RaspberryPi Pico

Pico MicroPython を使用する場合の注意点
.py ファイルを分けて import で使用する場合は、
Borad SPI-ROM に import する自作ファイルを書き込んだ状態でなければ、main.py を実行できない。

utime とか書き込まなくても実行できるので、対策できそうだが方法は見つけられていない。

ファイル実行手順
.Upload project to Pico
.Reset -> Hard
.Run cuurent file on Pico

又は
.Upload project to Pico
電源切 -> 自動起動

"""

import _thread
from machine import I2C, Pin, Timer, mem32
import PicoSw
import L3GD20H
import utime
from I2cSlave import i2c_slave


# ------------------------------------------------------------------------------
# define
# ------------------------------------------------------------------------------
LED_BLINK_TIME = 300


# ------------------------------------------------------------------------------
# グローバル変数
# ------------------------------------------------------------------------------
interval_timer_count = 0


# ------------------------------------------------------------------------------
# 割り込みタイマーの設定
# ------------------------------------------------------------------------------
# def timer_handler(timer):
#     global interval_timer_count
#     interval_timer_count += 1

# ------------------------------------------------------------------------------
# main 関数
# ------------------------------------------------------------------------------
def main():
    print("start")
    # Timer(freq=1000, mode=Timer.PERIODIC, callback=timer_handler)

    _thread.start_new_thread(core1, ())
    core0()

# ------------------------------------------------------------------------------
# main 処理
# ------------------------------------------------------------------------------
def core1():
    s_i2c = i2c_slave(1,sda=14,scl=15,slaveAddress=0x41)
    s_i2c.intr_reg_read()
    counter = 1

    try:
        while True:
            try:
                # if s_i2c.any():
                    # s_i2c.get()
                if s_i2c.anyRead():
                    counter = counter + 1
                    s_i2c.put(counter & 0xff)
            except:
                pass
    except KeyboardInterrupt:
        pass
        
def core0():
    led = Pin(25, Pin.OUT)
    i2c = I2C(0, scl=Pin(1), sda=Pin(0), freq=400000)
    # L3GD20H.device_init(i2c)
    led_blink_timer = 0
    sw_cap_timer = 0
    old_sw = 0

    try:
        while True:
            # if led_blink_timer <= interval_timer_count:
            #     led_blink_timer = interval_timer_count + LED_BLINK_TIME
            #     led.toggle()

            # if sw_cap_timer <= interval_timer_count:
            sw_cap_timer = interval_timer_count + 1
            sw = PicoSw.get_sw()
            # x, y, z = L3GD20H.get_xyz_acceleration(i2c)
            # print("\r"+"X:{}, Y:{}, Z:{}".format(x,y,z),end="")
            # if old_sw != sw:
                # print("%h\r",sw)
            try:
                # if s_i2c.anyRead():
                i2c.readfrom_mem(0x41, 0x29, 1)
                # print("%d",(i2c.readfrom_mem(0x41, 0x29, 1)))
                # i2c.writeto_mem(0x41, 0x21, bytearray([sw]))
                # i2c.writeto_mem(0x23, bytearray([0x00]))
                # i2c.writeto_mem(0x23, 0x12, 0x45)
            except:
                pass
                
                # old_sw = sw

    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()