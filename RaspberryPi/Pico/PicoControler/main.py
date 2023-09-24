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

from machine import I2C, Pin, Timer
import PicoSw
import L3GD20H
import utime


# ------------------------------------------------------------------------------
# define
# ------------------------------------------------------------------------------
LED_BLINK_TIME = 500


# ------------------------------------------------------------------------------
# グローバル変数
# ------------------------------------------------------------------------------
interval_timer_count = 0


# ------------------------------------------------------------------------------
# 割り込みタイマーの設定
# ------------------------------------------------------------------------------
def timer_handler(timer):
    global interval_timer_count
    interval_timer_count += 1

# ------------------------------------------------------------------------------
# main 関数
# ------------------------------------------------------------------------------
def main():
    led = Pin(25, Pin.OUT)
    i2c = I2C(0, scl=Pin(1), sda=Pin(0), freq=100000)
    Timer(freq=1000, mode=Timer.PERIODIC, callback=timer_handler)
    #
    L3GD20H.device_init(i2c)
    led_blink_timer = 0
    sw_cap_timer = 0

    try:
        while True:

            if led_blink_timer <= interval_timer_count:
                led_blink_timer = interval_timer_count + LED_BLINK_TIME
                led.toggle()

            if sw_cap_timer <= interval_timer_count:
                sw_cap_timer = interval_timer_count + 1
                sw = PicoSw.get_sw()
                # x, y, z = L3GD20H.get_xyz_acceleration(i2c)
                # print("\r"+"X:{}, Y:{}, Z:{}".format(x,y,z),end="")

                try:
                    i2c.writeto_mem(0x10, 0x20, bytearray([sw]))
                except:
                    pass

    except KeyboardInterrupt:
        print("exception KeyboardInterrupt")

# ------------------------------------------------------------------------------
# main 処理
# ------------------------------------------------------------------------------
if __name__ == "__main__":
    main()