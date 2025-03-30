# ------------------------------------------------------------------------------
# Python 3.9.13
# Wineows USB Drivers liusb-win32
#
# FPGA Hard Reset
#
# 25-03-30 : v1.00 new relaese
# ------------------------------------------------------------------------------
# coding: UTF-8

#-------------------------------------------------------------------------------
# import 
#-------------------------------------------------------------------------------
# common lib
from time import sleep
# special lib
from pyftdi.ftdi import Ftdi
# my lib

class GPIO:
	def __init__(self, url="ftdi://ftdi:2232:0:1/1"):
		"""
		ADBUS4 Output に設定
		"""
		self.ftdi = Ftdi()
		self.ftdi.open_from_url(url)
		self.ftdi.set_bitmode(0b00010000, Ftdi.BitMode.BITBANG)

	def toggle_adbus4(self):
		"""
		一定間隔で FPGA に対して RST 発行
		"""
		self.ftdi.write_data(bytes([0b00010000]))  # H (ADBUS4 = 1)
		sleep(0.1)
		self.ftdi.write_data(bytes([0b00000000]))  # L (ADBUS4 = 0)
		sleep(0.1)
		self.ftdi.write_data(bytes([0b00010000]))  # H (ADBUS4 = 1)

# モジュールが直接実行されたときのテスト用
if __name__ == "__main__":
    gpio = GPIO()
    print("GPIO initialized.")
    gpio.toggle_adbus4()
    print("ADBUS4 toggled.")