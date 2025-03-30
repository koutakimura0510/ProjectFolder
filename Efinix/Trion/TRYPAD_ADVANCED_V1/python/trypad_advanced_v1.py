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

# 
player_xpos = 128
player_ypos = 240-48
player_delta = 2

def player_position():
	global player_xpos, player_ypos
	global player_delta
	max_xpos = 320 - 32
	max_ypos = 240 - 48  #プレイヤーの高さ + 1ブロック床サイズ
	sw = ~spi.read(reg.GPIO_REG_PUSH_SW) & 0xfff

	if (sw & reg.SW_A):
		delta = 4
	else:
		delta = 1
	# print("SW",hex(sw)) # SW の bit 位置表示

	if (sw & reg.SW_RIGHT):
		player_xpos = min(player_xpos + delta, max_xpos)
		spi.write(reg.VIDEO_REG_ANIME_XPOS1, player_xpos)
	elif (sw & reg.SW_LEFT):
		player_xpos = max(player_xpos - delta, 0)
		spi.write(reg.VIDEO_REG_ANIME_XPOS1, player_xpos)

	if (sw & reg.SW_UP):
		player_ypos = max(player_ypos - delta, 0)
		spi.write(reg.VIDEO_REG_PLAYER_POS_YPOS, player_ypos)
	elif (sw & reg.SW_DOWN):
		player_ypos = min(player_ypos + delta, max_ypos)
		spi.write(reg.VIDEO_REG_PLAYER_POS_YPOS, player_ypos)


#-------------------------------------------------------------------------------
# main
#-------------------------------------------------------------------------------
def main():
	spi.write(reg.GPIO_REG_ALTNATE, 0x7f)
	spi.write(reg.VIDEO_REG_BLOCK_RST, 1)

	start = time()

	####
	with open("res/minoriko.bin", "rb") as f:
		data = f.read()

	for i in range(1024):
		color = data[i * 3] << 16 | data[1 + i * 3] << 8 | data[2 + i * 3]
		# print(f"index {i}: {color:#06x}")
		spi.write(reg.VIDEO_REG_BRAM_ADRS, 0x0100_0000 + i)
		spi.write(reg.VIDEO_REG_BRAM_WD, color)

	####
	with open("res/minigame.bin", "rb") as f:
		data = f.read()

	for i in range(1024):
		color = data[i * 3] << 16 | data[1 + i * 3] << 8 | data[2 + i * 3]
		spi.write(reg.VIDEO_REG_BRAM_ADRS, 0x0800_0000 + i)
		spi.write(reg.VIDEO_REG_BRAM_WD, color)

	####
	with open("res/output.bin", "rb") as f:
		data = f.read()

	for i in range(80):
		spi.write(reg.VIDEO_REG_BRAM_ADRS, 0x0900_0000 + i)
		spi.write(reg.VIDEO_REG_BRAM_WD, data[i])

	####
	with open("res/field1.bin", "rb") as f:
		data = f.read()

	for i in range(1024):
		color = data[i * 3] << 16 | data[1 + i * 3] << 8 | data[2 + i * 3]
		spi.write(reg.VIDEO_REG_BRAM_ADRS, 0x0A00_0000 + i)
		spi.write(reg.VIDEO_REG_BRAM_WD, color)

	####
	with open("res/block.bin", "rb") as f:
		data = f.read()

	for i in range(1024*3):
		color = data[i * 3] << 16 | data[1 + i * 3] << 8 | data[2 + i * 3]
		# color = 0
		adrs = 0x1000_0000 + i + ((i<<14) & 0xf000000)
		spi.write(reg.VIDEO_REG_BRAM_ADRS, adrs)
		spi.write(reg.VIDEO_REG_BRAM_WD, color)


	spi.write(reg.VIDEO_REG_BRAM_ADRS, 0x0000_0000)
	end = time()
	print(end-start)

	"""
	LCD の設定が、まだ FIX しておらず画面が明るすぎるので、
	画面全体に黒画像を描画して、α値によって明るさ調整を行っている。
	"""
	video.rect_draw(1, top=0, under=240, left=0, right=320, color=0x00800000)
	# video.rect_draw(2, top=240-32, under=240, left=32, right=320, color=0xFF00FF)
	# video.rect_draw(3, top=0, under=64, left=16, right=48, color=0x200000)
	spi.write(reg.VIDEO_REG_PLAYER_POS_INIT, 1)
	spi.write(reg.VIDEO_REG_PLAYER_POS_XPOS, 128)
	spi.write(reg.VIDEO_REG_PLAYER_POS_YPOS, 240-48)
	spi.write(reg.VIDEO_REG_PLAYER_POS_INIT, 0)
	spi.write(reg.VIDEO_REG_TFT_BL_EN, 0)

	spi.write(reg.VIDEO_REG_ANIME_FRAME_NUM1, 0x10101010)
	spi.write(reg.VIDEO_REG_ANIME_XPOS1, 0x00000010)
	spi.write(reg.VIDEO_REG_ANIME_YPOS1, 0x00000010)
	spi.readf(reg.VIDEO_REG_ANIME_FRAME_NUM1)
	spi.readf(reg.VIDEO_REG_ANIME_XPOS1)
	spi.readf(reg.VIDEO_REG_ANIME_YPOS1)

	"""
	レジスタ設定完了後、モニタの設定を行う
	"""
	spi.write(reg.VIDEO_REG_BLOCK_RST, 0)
	video.st7789_init()

	while True:
		sleep(0.01)
		player_position()

if __name__ == "__main__":
	Ftdi.show_devices() # 接続されているデバイスのリストを表示
	main()
	print("python end")