# ------------------------------------------------------------------------------
# Create 2025-03-28
# Python 3.9.13
#
# 25-03-28 : v1.00 new relaese
# ------------------------------------------------------------------------------
# coding: UTF-8


#-------------------------------------------------------------------------------
# import 
#-------------------------------------------------------------------------------
# common lib
from time import sleep
# special lib
# my lib
from fpga_reg_map import FPGAREG
from spi_util import SPI

#-------------------------------------------------------------------------------
# instance
#-------------------------------------------------------------------------------
spi = SPI()
reg = FPGAREG()

#-------------------------------------------------------------------------------
# LED Class
#-------------------------------------------------------------------------------
class LED:
	def __init__(self):
		spi.write(reg.GPIO_REG_ALTNATE, 0xff) # default normal mode
		pass

	def led_mode_settings(self, altnate_mode):
		"""
		bit 0 = altnate mode (FW による led 操作)
		bit 1 = normal mode (FPGA による led 操作)
		bit 単位で led mode を設定尾する場合に使用します
		"""
		spi.write(reg.GPIO_REG_ALTNATE, altnate_mode)

	def led_altnate_mode(self):
		"""
		led mode を altnate mode に設定します
		"""
		spi.write(reg.GPIO_REG_ALTNATE, 0xff)

	def led_normal_mode(self):
		"""
		led mode を normal mode に設定します
		"""
		spi.write(reg.GPIO_REG_ALTNATE, 0x00)

	def led_flash(self, flash_bit):
		"""
		この関数を使用する場合、altnate mode を有効にしてください
		"""
		spi.write(reg.GPIO_REG_OUT_CTRL, flash_bit)

	def led_blink(self, time):
		"""
		この関数を使用する場合、altnate mode を有効にしてください
		time 10ms 間隔の点滅の場合 0.01 にします
		"""
		spi.write(reg.GPIO_REG_OUT_CTRL, 0x00)
		sleep(time)
		spi.write(reg.GPIO_REG_OUT_CTRL, 0xff)
		sleep(time)
		spi.write(reg.GPIO_REG_OUT_CTRL, 0x00)