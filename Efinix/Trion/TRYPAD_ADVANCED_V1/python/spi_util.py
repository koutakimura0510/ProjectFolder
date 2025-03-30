# ------------------------------------------------------------------------------
# Create 2025-03-08
# Python 3.9.13
# Wineows USB Drivers liusb-win32
#
#  pyftdi ライブラリを使用した GUI アプリケーション
#
# 25-03-08 : v1.00 new relaese
# ------------------------------------------------------------------------------
# coding: UTF-8


#-------------------------------------------------------------------------------
# import 
#-------------------------------------------------------------------------------
# common lib
# special lib
from pyftdi.spi import SpiController
# my lib
from fpga_reg_map import FPGAREG

class SPI:
	def __init__(self, url="ftdi://ftdi:2232:0:1/1"):
		self.ctrl = SpiController(cs_count=4)
		self.ctrl.configure(url)
		self.spi = self.ctrl.get_port(cs=3, freq=20E6, mode=0)

	def read(self, adrs):
		adrs |= FPGAREG.USI_READ_CMD
		adrs_bytes = adrs.to_bytes(4, 'big')
		rx_data = self.spi.exchange(adrs_bytes, 4)
		return int.from_bytes(rx_data, 'big')

	def write(self, adrs, data):
		adrs |= FPGAREG.USI_WRITE_CMD
		adrs_bytes = adrs.to_bytes(4, 'big')
		wd_bytes = data.to_bytes(4, 'big')
		self.spi.write(adrs_bytes + wd_bytes)

	def readf(self, adrs):
		adrs |= FPGAREG.USI_READ_CMD
		adrs_bytes = adrs.to_bytes(4, 'big')
		rx_data = self.spi.exchange(adrs_bytes, 4)
		print(f"{adrs:02X}, {rx_data.hex()}")

# モジュールが直接実行されたときのテスト用
if __name__ == "__main__":
	spi = SPI()
	print("SPI initialized.")