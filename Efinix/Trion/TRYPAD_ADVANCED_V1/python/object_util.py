# ------------------------------------------------------------------------------
# 25-04-07 : v1.00 new relaese
# ------------------------------------------------------------------------------
# coding: UTF-8


#-------------------------------------------------------------------------------
# import 
#-------------------------------------------------------------------------------
# common lib
import math
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
# GameObject class
#-------------------------------------------------------------------------------
class GameObject:
	def __init__(self, x, y, width=32, height=32):
		"""
		ゲームオブジェクトの初期化
		:param x: オブジェクトの初期x座標
		:param y: オブジェクトの初期y座標
		:param width: オブジェクトの幅
		:param height: オブジェクトの高さ
		"""
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.vel_x = 0  # 横方向の速度
		self.vel_y = 0  # 縦方向の速度

	def update(self):
		"""
		オブジェクトの位置を更新（移動）
		現在は速度に基づいて位置を更新するだけ
		"""
		self.x += self.vel_x
		self.y += self.vel_y

	def add(self, adrs, id):
		rd = spi.read(adrs)
		rd = rd | (0x01 << id)
		spi.write(adrs, rd)
		print("draw en = ", hex(rd))

	def remove(self, id):
		rd = spi.read(reg.VIDEO_REG_OBJECT_ENABLE)
		rd = rd & ~(0x01 << id)
		spi.write(reg.VIDEO_REG_OBJECT_ENABLE, rd)
		print("draw disable = ", hex(rd))

	def draw(self, obj_id):
		"""
		オブジェクトを描画するための仮関数
		実際にはグラフィックライブラリを使用して描画します
		"""
		add_adrs = obj_id >> 1 # 32bit adrs 内に 16bit幅の座標レジスタ2つある
		rx = spi.read(reg.VIDEO_REG_OBJECT_ANIME_XPOS1 + add_adrs)
		ry = spi.read(reg.VIDEO_REG_OBJECT_ANIME_YPOS1 + add_adrs)

		if obj_id & 0x01:
			rx &= 0x0000_ffff
			ry &= 0x0000_ffff
			x = int(self.x) << 16 | rx
			y = int(self.y) << 16 | ry
		else:
			rx &= 0xffff_0000
			ry &= 0xffff_0000
			x = int(self.x) | rx
			y = int(self.y) | ry
			
		print("id:", obj_id, hex(x))
		spi.write(reg.VIDEO_REG_OBJECT_ANIME_XPOS1 + add_adrs, x)
		spi.write(reg.VIDEO_REG_OBJECT_ANIME_YPOS1 + add_adrs, y)

	def get_position(self):
		"""
		オブジェクトの現在の座標を返す
		"""
		return self.x, self.y

	def set_velocity(self, vel_x, vel_y):
		"""
		オブジェクトの速度を設定
		:param vel_x: 横方向の速度
		:param vel_y: 縦方向の速度
		"""
		self.vel_x = vel_x
		self.vel_y = vel_y

#-------------------------------------------------------------------------------
# CircleMovingObject class
#-------------------------------------------------------------------------------
class CircleMovingObject(GameObject):
	def __init__(self, x, y, radius, speed):
		"""
		円周上を移動するオブジェクトを作成
		:param x: 初期x座標
		:param y: 初期y座標
		:param radius: 円の半径
		:param speed: 角度の更新速度（ラジアン/秒）
		"""
		super().__init__(x, y)
		self.radius = radius  # 円の半径
		self.speed = speed    # 角度更新速度
		self.angle = 0        # 現在の角度（ラジアン）

	def update(self):
		"""
		オブジェクトを円周上で移動させる
		"""
		self.angle += self.speed  # 角度を増加させる
		if self.angle >= 2 * math.pi:  # 角度が一周したらリセット
			self.angle -= 2 * math.pi

		# 円周上の位置を計算
		self.x = self.x + self.radius * math.cos(self.angle)
		self.y = self.y + self.radius * math.sin(self.angle)

	def draw(self):
		"""
		オブジェクトを描画するための仮関数
		実際にはグラフィックライブラリを使用して描画します
		"""
		x = max(0, int(self.x))
		y = max(0, int(self.y))
		spi.write(reg.VIDEO_REG_OBJECT_ANIME_XPOS1, x)
		spi.write(reg.VIDEO_REG_OBJECT_ANIME_YPOS1, y)

#-------------------------------------------------------------------------------
# GameObjectManager class
#-------------------------------------------------------------------------------
class GameObjectManager:
	def __init__(self):
		self.objects = []	# ゲームオブジェクトのリスト
		self.objects_id = []	# ゲームオブジェクトのリスト

	def add_object(self, obj, id):
		"""
		ゲームオブジェクトを追加
		:param obj: GameObjectインスタンス
		"""
		self.objects.append(obj)
		self.objects_id.append(id)
		obj.add(reg.VIDEO_REG_OBJECT_ENABLE, id)
		print("add",id)

	def remove_object(self, obj):
		"""
		ゲームオブジェクトを削除
		:param obj: GameObjectインスタンス
		"""
		if obj in self.objects:
			index = self.objects.index(obj)
			id = self.objects_id[index]
			print("remove", id)
			obj.remove(id)
			del self.objects[index]
			del self.objects_id[index]

	def update_objects(self):
		"""
		すべてのオブジェクトの位置を更新
		"""
		for obj in self.objects:
			obj.update()

	def draw_objects(self):
		"""
		すべてのオブジェクトを描画
		"""
		for obj in self.objects:
			index = self.objects.index(obj)
			id = self.objects_id[index]
			obj.draw(id)


# main
if __name__ == "__main__":
	game_manager = GameObjectManager()

	obj1 = GameObject(x=100, y=150)
	obj2 = GameObject(x=200, y=100)

	game_manager.add_object(obj1, 0)
	game_manager.add_object(obj2, 1)

	# ゲームループ内でオブジェクトの更新と描画を実行
	game_manager.update_objects()
	game_manager.draw_objects()

	print("initialized.")