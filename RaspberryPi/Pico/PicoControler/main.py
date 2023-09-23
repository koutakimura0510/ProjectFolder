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

なお、自動起動中に USB を差し込み MicroPico で認識させると、例外処理が発生し止まる。
gtkterm などでは発生しない。

"""

from machine import I2C, Pin
import PicoSw
import L3GD20H

import utime

# ------------------------------------------------------------------------------
# main 関数
# ------------------------------------------------------------------------------
def main():
    led = Pin(25, Pin.OUT)
    i2c = I2C(0, scl=Pin(1), sda=Pin(0), freq=100000)

    L3GD20H.device_init(i2c)

    try:
        while True:
            led.value(1)
            utime.sleep(1)
            led.value(0)
            utime.sleep(1)
            print(PicoSw.get_sw())

            x, y, z = L3GD20H.get_xyz_acceleration(i2c)
            # print("X:{}, Y:{}, Z:{}".format(x,y,z))

            try:
                q = i2c.readfrom_mem(0xaa, 0x2D, 1)
                print(q)
            except:
                pass

            utime.sleep(0.1)

    except KeyboardInterrupt:
        print("exception KeyboardInterrupt")

# ------------------------------------------------------------------------------
# main 処理
# ------------------------------------------------------------------------------
if __name__ == "__main__":
    main()