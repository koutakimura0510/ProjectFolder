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
# VIDEO Class
#-------------------------------------------------------------------------------
class VIDEO:
	TFT_DISPLAY_WIDTH = (240) # 最大横幅
	TFT_DISPLAY_HEIGHT = (320) # 最大縦幅
	TFT_DISPLAY_WIDTH_DATA = (TFT_DISPLAY_WIDTH-1)
	TFT_DISPLAY_HEIGHT_DATA = (TFT_DISPLAY_HEIGHT-1)
	TFT_DISPLAY_HTOTAL_SIZE = ((TFT_DISPLAY_WIDTH * TFT_DISPLAY_HEIGHT) - 1)

	# // Mode Setting
	MODE_8BIT = (0x01)
	MODE_16BIT = (0x00)
	MODE_BITWIDTH = (MODE_16BIT)

	# // インターフェース設定
	MCU_INTERFACE = (0x00)
	RGB_INTERFACE = (0x06)		# 0x08 = VSYNC Inteface
	RGB_16bit_MODE = (0x55)
	RGB_18bit_MODE = (0x66)		# DPI[6:4] / DBI[2:0]
	RGB_SELECT = (0x40)			# RCM[1:0] "11" Ext Sync Mode / "10" DE Mode
	DRAW_INTERFACE = (RGB_INTERFACE)
	RGB_BIT_WIDTH = (RGB_16bit_MODE)
	SYNC_MODE_SEL = (RGB_SELECT)

	# ST7789 レジスタマップ
	SOFTWARE_RESET = 0x01
	SLEEP_MODE_OFF = 0x11
	TFT_DISPLAY_OFF = 0x28
	TFT_DISPLAY_ON = 0x29
	PIXEL_FORMAT_SET = 0x3A
	MEMORY_ACCESS_CONTROL = 0x36
	GAMMA_SET = 0x26
	POSITIVE_GAMMA = 0xE0
	NEGATIVE_GAMMA = 0xE1
	DISPLAY_INVER_ON = 0x21
	COLUMN_ADDRESS_SET = 0x2A
	PAGE_ADDRESS_SET = 0x2B
	MEMORY_WRITE = 0x2C
	RGB_INTERFACE_CONTROL = 0xB1
	TFT_CMD_BYTE = 0x00
	TFT_DATA_BYTE = 0x01

	"""

	"""
	def __init__(self):
		pass

	"""
	st7789 init 関数
	"""
	def st7789_init(self):
		tft_init_buff = [
			[self.TFT_CMD_BYTE,  self.SOFTWARE_RESET],
			# [TFT_CMD_BYTE,  SOFTWARE_RESET],
			[self.TFT_CMD_BYTE,  self.SLEEP_MODE_OFF],
			# [TFT_CMD_BYTE,  DISPLAY_MODE_ON],
			[self.TFT_CMD_BYTE,  self.TFT_DISPLAY_OFF],
			# [TFT_CMD_BYTE,  TFT_DISPLAY_ON}]
			[self.TFT_CMD_BYTE,  self.PIXEL_FORMAT_SET],
			[self.TFT_DATA_BYTE, self.RGB_BIT_WIDTH],
			[self.TFT_CMD_BYTE,  self.MEMORY_ACCESS_CONTROL],
			[self.TFT_DATA_BYTE, 0xA0],
			[self.TFT_CMD_BYTE,  self.GAMMA_SET],
			[self.TFT_DATA_BYTE, 0x01],
			[self.TFT_CMD_BYTE,  self.POSITIVE_GAMMA],
			[self.TFT_DATA_BYTE, 0x0f],
			[self.TFT_DATA_BYTE, 0x31],
			[self.TFT_DATA_BYTE, 0x2b],
			[self.TFT_DATA_BYTE, 0x0c],
			[self.TFT_DATA_BYTE, 0x0e],
			[self.TFT_DATA_BYTE, 0x10],
			[self.TFT_DATA_BYTE, 0x03],
			[self.TFT_DATA_BYTE, 0x0e],
			[self.TFT_DATA_BYTE, 0x09],
			[self.TFT_DATA_BYTE, 0x00],
			[self.TFT_CMD_BYTE,  self.NEGATIVE_GAMMA],
			[self.TFT_DATA_BYTE, 0x00],
			[self.TFT_DATA_BYTE, 0x0e],
			[self.TFT_DATA_BYTE, 0x14],
			[self.TFT_DATA_BYTE, 0x03],
			[self.TFT_DATA_BYTE, 0x11],
			[self.TFT_DATA_BYTE, 0x0f],
			[self.TFT_DATA_BYTE, 0x0c],
			[self.TFT_DATA_BYTE, 0x31],
			[self.TFT_DATA_BYTE, 0x36],
			[self.TFT_DATA_BYTE, 0x0f],
			[self.TFT_CMD_BYTE,  self.RGB_INTERFACE_CONTROL],
			[self.TFT_DATA_BYTE, 0x00],	# 0x40??
			[self.TFT_CMD_BYTE,  self.COLUMN_ADDRESS_SET],
			[self.TFT_DATA_BYTE, 0x00],
			[self.TFT_DATA_BYTE, 0x00],
			[self.TFT_DATA_BYTE, self.TFT_DISPLAY_HEIGHT_DATA >> 8],		# Display の描画向きによって、Height と Width の設定を切り替える。
			[self.TFT_DATA_BYTE, self.TFT_DISPLAY_HEIGHT_DATA & 0xff],	# 今回は、240x320 を 320x240 の向きに変更するため、COL ADRS に Height を設定。
			[self.TFT_CMD_BYTE,  self.PAGE_ADDRESS_SET],
			[self.TFT_DATA_BYTE, 0x00],
			[self.TFT_DATA_BYTE, 0x00],
			[self.TFT_DATA_BYTE, self.TFT_DISPLAY_WIDTH_DATA >> 8],
			[self.TFT_DATA_BYTE, self.TFT_DISPLAY_WIDTH_DATA & 0xff],
			[self.TFT_CMD_BYTE,	self.DISPLAY_INVER_ON],					# 何故か描画色が反転してしまうため、色反転設定
			[self.TFT_CMD_BYTE,  self.TFT_DISPLAY_ON],
			[self.TFT_CMD_BYTE,  self.MEMORY_WRITE],
		]

		spi.write(reg.VIDEO_REG_TFT_IM, self.MODE_BITWIDTH)
		spi.write(reg.VIDEO_REG_TFT_GATE, 0x01)
		spi.write(reg.VIDEO_REG_TFT_RD, 0x01)
		spi.write(reg.VIDEO_REG_TFT_WR, 0x01)

		#  Hardware RST
		spi.write(reg.VIDEO_REG_TFT_RST, 0x01)
		spi.write(reg.VIDEO_REG_TFT_RST, 0x00)
		sleep(0.05)
		spi.write(reg.VIDEO_REG_TFT_RST, 0x01)
		sleep(0.12)
			
		for i in range(len(tft_init_buff)):
			if self.TFT_CMD_BYTE == tft_init_buff[i][0]:
				spi.write(reg.VIDEO_REG_TFT_DCX, 0x00)
			else:
				spi.write(reg.VIDEO_REG_TFT_DCX, 0x01)
			
			if self.TFT_CMD_BYTE == tft_init_buff[i][0]:
				spi.write(reg.VIDEO_REG_TFT_CS, 0x01)
				# sleep(0.001)
				spi.write(reg.VIDEO_REG_TFT_CS, 0x00)

			spi.write(reg.VIDEO_REG_TFT_DATA, tft_init_buff[i][1])
			spi.write(reg.VIDEO_REG_TFT_WR, 0x00)
			# sleep(0.001)
			spi.write(reg.VIDEO_REG_TFT_WR, 0x01)
			# sleep(0.001)

		spi.write(reg.VIDEO_REG_TFT_DCX, 0x01)
		spi.write(reg.VIDEO_REG_TFT_CS, 0x00)
		spi.write(reg.VIDEO_REG_TFT_GATE, 0x00)
		spi.write(reg.VIDEO_REG_VSG_RST, 0x00)
		spi.write(reg.VIDEO_REG_VTU_CONVERTER_RST, 0)

	def rect_draw(self, index, top, under, left, right, color):
		"""
		指定した矩形番号の描画設定を行う

		Parameters:
			index (int): 設定する矩形の番号 (1, 2, 3...).
			top (int): 矩形の上端座標.
			under (int): 矩形の下端座標.
			left (int): 矩形の左端座標.
			right (int): 矩形の右端座標.
			color (int): 矩形の色 (RGB565 形式など).
		"""
		settings = {
			getattr(reg, f"VIDEO_REG_DOT_SQUARE_TOP{index}"): top,
			getattr(reg, f"VIDEO_REG_DOT_SQUARE_UNDER{index}"): under,
			getattr(reg, f"VIDEO_REG_DOT_SQUARE_LEFT{index}"): left,
			getattr(reg, f"VIDEO_REG_DOT_SQUARE_RIGHT{index}"): right,
			getattr(reg, f"VIDEO_REG_DOT_SQUARE_COLOR{index}"): color,
		}

		for address, value in settings.items():
			spi.write(address, value)

#-------------------------------------------------------------------------------
# main
#-------------------------------------------------------------------------------
if __name__ == "__main__":
	print("VIDEO initialized.")