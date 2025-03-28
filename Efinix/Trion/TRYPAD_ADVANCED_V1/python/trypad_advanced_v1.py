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
from time import sleep, time
# special lib
from pyftdi.ftdi import Ftdi
# my lib
from fpga_reg_map import FPGAREG
from spi_util import SPI
from video_util import VIDEO

#-------------------------------------------------------------------------------
# instance
#-------------------------------------------------------------------------------
spi = SPI()
reg = FPGAREG()
video = VIDEO()



#-------------------------------------------------------------------------------
# main
#-------------------------------------------------------------------------------
def main():
	spi.write(reg.GPIO_REG_ALTNATE, 0xff)
	spi.write(reg.VIDEO_REG_BLOCK_RST, 1)
	video.st7789_init()
	video.rect_draw(1, top=0, under=240, left=0, right=320, color=0x00FFFFFF)
	video.rect_draw(2, top=0, under=64, left=0, right=32, color=0x20FFFF)
	video.rect_draw(3, top=0, under=64, left=16, right=48, color=0x200000)

	# start = time()
	# for i in range(10000):
	# 	spi.write(reg.VIDEO_REG_DOT_SQUARE_COLOR1, i)
	# 	if i != spi.read(reg.VIDEO_REG_DOT_SQUARE_COLOR1):
	# 		print("break")
	# 		break
	# end = time()
	# print(end-start)

if __name__ == "__main__":
	Ftdi.show_devices() # 接続されているデバイスのリストを表示
	main()