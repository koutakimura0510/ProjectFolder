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
from timer_util import TimerManager
from player_util import Player
from object_util import GameObjectManager, GameObject, CircleMovingObject

#-------------------------------------------------------------------------------
# instance
#-------------------------------------------------------------------------------
spi = SPI()
reg = FPGAREG()
video = VIDEO()
player = Player()
game_maneger = GameObjectManager()

#-------------------------------------------------------------------------------
# BRAM Write
#-------------------------------------------------------------------------------
def write_rgb_bram(filename, base_address, spi, reg):
	try:
		with open(filename, "rb") as f:
			data = f.read()
	except Exception as e:
		print ("File Open Error", e)
		return

	num_pixels = len(data) // 3
	payload = bytearray()
	reg_bram_adrs = reg.VIDEO_REG_BRAM_ADRS | reg.USI_WRITE_CMD
	reg_bram_wd = reg.VIDEO_REG_BRAM_WD | reg.USI_WRITE_CMD

	for i in range(num_pixels):
		color = data[i * 3] << 16 | data[1 + i * 3] << 8 | data[2 + i * 3]
		bram_adrs = base_address + i + ((i<<14) & 0x0f00_0000)
		payload += (
			reg_bram_adrs.to_bytes(4, 'big') +
			bram_adrs.to_bytes(4, 'big') +
			reg_bram_wd.to_bytes(4, 'big') +
			color.to_bytes(4, 'big')
		)

		if (i + 1) % 16 == 0:
			spi.spi.write(payload)
			payload.clear()

	if payload:
		spi.spi.write(payload)

#-------------------------------------------------------------------------------
# BRAM Byte Write
#-------------------------------------------------------------------------------
def write_byte_bram(filename, base_address, spi, reg):
	try:
		with open(filename, "rb") as f:
			data = f.read()
	except Exception as e:
		print ("File Open Error", e)
		return

	payload = bytearray()
	reg_bram_adrs = reg.VIDEO_REG_BRAM_ADRS | reg.USI_WRITE_CMD
	reg_bram_wd = reg.VIDEO_REG_BRAM_WD | reg.USI_WRITE_CMD

	for i in range(len(data)):
		bram_adrs = base_address + i + ((i<<14) & 0x0f00_0000)
		value = data[i]
		payload += (
			reg_bram_adrs.to_bytes(4, 'big') +
			bram_adrs.to_bytes(4, 'big') +
			reg_bram_wd.to_bytes(4, 'big') +
			value.to_bytes(4, 'big')
		)

		if (i + 1) % 2 == 0:
			spi.spi.write(payload)
			payload.clear()

	if payload:
		spi.spi.write(payload)


#-------------------------------------------------------------------------------
# main
#-------------------------------------------------------------------------------
def main():
	spi.write(reg.GPIO_REG_ALTNATE, 0x7f)
	spi.write(reg.VIDEO_REG_BLOCK_RST, 1)

	start = time()
	write_rgb_bram("res/charachip.bin", 0x0100_0000, spi, reg)
	write_rgb_bram("res/minigame.bin", 0x0800_0000, spi, reg)
	write_rgb_bram("res/field1.bin", 0x0A00_0000, spi, reg)
	write_rgb_bram("res/block.bin", 0x1000_0000, spi, reg)
	write_byte_bram("res/output.bin", 0x0900_0000, spi, reg)
	spi.write(reg.VIDEO_REG_BRAM_ADRS, 0x0000_0000)
	end = time()
	print(end-start)

	"""
	LCD の設定が、まだ FIX しておらず画面が明るすぎるので、
	画面全体に薄い黒画像を描画して明るさ調整を行っている。
	"""
	video.rect_draw(1, top=0, under=240, left=0, right=320, color=0x00800000)
	# video.rect_draw(2, top=240-32, under=240, left=32, right=320, color=0xFF00FF)
	# video.rect_draw(3, top=0, under=64, left=16, right=48, color=0x200000)
	spi.write(reg.VIDEO_REG_PLAYER_POS_INIT, 1)
	spi.write(reg.VIDEO_REG_PLAYER_POS_XPOS, 128)
	spi.write(reg.VIDEO_REG_PLAYER_POS_YPOS, 240-48)
	spi.write(reg.VIDEO_REG_PLAYER_POS_INIT, 0)
	spi.write(reg.VIDEO_REG_TFT_BL_EN, 0)
	spi.write(reg.VIDEO_REG_OBJECT_ANIME_FRAME_NUM1, 0x10141820)
	spi.write(reg.VIDEO_REG_OBJECT_ANIME_FRAME_NUM2, 0x24283403)
	spi.write(reg.VIDEO_REG_PLAYER_DRAW_SEL, 1)
	# spi.readf(reg.VIDEO_REG_ANIME_FRAME_NUM1)
	# spi.readf(reg.VIDEO_REG_ANIME_XPOS1)
	# spi.readf(reg.VIDEO_REG_ANIME_YPOS1)

	obj0 = GameObject(x=0*32, y=0*32)
	obj1 = GameObject(x=1*32, y=1*32)
	obj2 = GameObject(x=2*32, y=2*32)
	obj3 = GameObject(x=3*32, y=3*32)
	obj4 = GameObject(x=4*32, y=4*32)
	obj5 = GameObject(x=5*32, y=5*32)
	obj6 = GameObject(x=6*32, y=6*32)
	obj7 = GameObject(x=7*32, y=0*32)
	obj8 = GameObject(x=8*32, y=1*32)
	obj9 = GameObject(x=9*32, y=2*32)
	# circle_obj = CircleMovingObject(x=80, y=60, radius=4, speed=0.1)
	game_maneger.add_object(obj0, 0)
	game_maneger.add_object(obj1, 1)
	game_maneger.add_object(obj2, 2)
	game_maneger.add_object(obj3, 3)
	game_maneger.add_object(obj4, 4)
	game_maneger.add_object(obj5, 5)
	game_maneger.add_object(obj6, 6)
	game_maneger.add_object(obj7, 7)
	game_maneger.add_object(obj8, 8)
	game_maneger.add_object(obj9, 9)

	# game_maneger.remove_object(obj3)
	game_maneger.update_objects()
	game_maneger.draw_objects()
	# spi.write(reg.VIDEO_REG_OBJECT_ENABLE, 0x01)
	tmr = TimerManager()
	tmr.add_timer("obj1")

	"""
	レジスタ設定完了後、モニタの設定を行う
	"""
	spi.write(reg.VIDEO_REG_BLOCK_RST, 0)
	video.st7789_init()

	while True:
		sw = ~spi.read(reg.GPIO_REG_PUSH_SW) & 0xfff
		player.update_position(sw, 0.0166)
		# if True == tmr.compare_time("obj1", 0.0166):
		# 	game_maneger.update_objects()
		# 	game_maneger.draw_objects()

if __name__ == "__main__":
	Ftdi.show_devices() # 接続されているデバイスのリストを表示
	main()
	print("python end")