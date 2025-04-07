# ------------------------------------------------------------------------------
# 25-04-07 : v1.00 new relaese
# ------------------------------------------------------------------------------
# coding: UTF-8


#-------------------------------------------------------------------------------
# import 
#-------------------------------------------------------------------------------
# common lib
# special lib
# my lib
from fpga_reg_map import FPGAREG
from spi_util import SPI
from timer_util import TimerManager

#-------------------------------------------------------------------------------
# Instance
#-------------------------------------------------------------------------------
spi = SPI()
reg = FPGAREG()

#-------------------------------------------------------------------------------
# Player class
#-------------------------------------------------------------------------------
class Player:
	GRAVITY = 1			# 重力加速度
	JUMP_VELOCITY = -12	# ジャンプ初速
	DASH_VELOCITY = 5	# ダッシュ時の移動速度
	NORMAL_VELOCITY = 2	# ダッシュ時の移動速度
	DASH_DURATION = 0.5	# ダッシュの持続時間

	def __init__(self, x=128, y=240-48):
		self.x = x
		self.y = y
		self.max_x = 320 - 32
		self.max_y = 240 - 48 	# プレイヤーの高さ＋床の高さ
		self.vel_y = 0			# 縦方向加速度
		self.on_ground = True	# 地面にいるかどうか
		self.dash_timer = 0.0	# ダッシュ用タイマー
		self.is_dashing = False
		self.delta = self.NORMAL_VELOCITY # 初期の移動速度
		self.timer_manager = TimerManager()
		self.timer_manager.add_timer("move")

	def init_position(self, x=0, y=0, max_x = 320 - 32, max_y = 240 - 48):
		self.x = x
		self.y = y
		self.max_x = max_x
		self.max_y = max_y

	def init_delta(self, delta=1):
		self.delta = delta

	def update_position(self, sw, move_anime_time: float):
		"""
		スイッチの入力をもとにプレイヤーの座標を更新し、
		一定時間経過ごとに移動処理を行う。
		"""
		if not self.timer_manager.compare_time("move", move_anime_time):
			return
		
		# Aボタンでダッシュ開始
		if sw & reg.SW_A:
			if not self.is_dashing:
				self.is_dashing = True
				self.delta = self.DASH_VELOCITY  # ダッシュ速度に切り替え
				self.dash_timer = 0  # ダッシュタイマーをリセット

		if self.is_dashing:
			self.dash_timer += move_anime_time
			if self.dash_timer > self.DASH_DURATION:
				self.is_dashing = False
				self.delta = self.NORMAL_VELOCITY

		if sw & reg.SW_RIGHT:
			self.x = min(self.x + self.delta, self.max_x)
			spi.write(reg.VIDEO_REG_PLAYER_POS_XPOS, self.x)
			spi.write(reg.VIDEO_REG_PLAYER_DRAW_SEL, 4)
		elif sw & reg.SW_LEFT:
			self.x = max(self.x - self.delta, 0)
			spi.write(reg.VIDEO_REG_PLAYER_POS_XPOS, self.x)
			spi.write(reg.VIDEO_REG_PLAYER_DRAW_SEL, 1)

		if sw & reg.SW_B and self.on_ground:
			self.vel_y = self.JUMP_VELOCITY
			self.on_ground = False
		
		# 重力適用
		self.vel_y += self.GRAVITY
		self.y += self.vel_y

		# 着地処理
		if self.y >= self.max_y:
			self.y = self.max_y
			self.vel_y = 0
			self.on_ground = True

		# 上限チェック
		if self.y < 0:
			self.y = 0
			self.vel_y  = 0

		spi.write(reg.VIDEO_REG_PLAYER_POS_YPOS, self.y)

	def get_position(self):
		"""現在のプレイヤー座標を (x, y) タプルで返す"""
		return self.x, self.y

# main
if __name__ == "__main__":
	player = Player()

	print("initialized.")