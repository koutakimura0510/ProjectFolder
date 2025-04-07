# ------------------------------------------------------------------------------
# 25-04-07 : v1.00 new relaese
# ------------------------------------------------------------------------------
# coding: UTF-8


#-------------------------------------------------------------------------------
# import 
#-------------------------------------------------------------------------------
# common lib
import datetime
# special lib
# my lib

#-------------------------------------------------------------------------------
# TIMER class
#-------------------------------------------------------------------------------
class TIMER:
	def __init__(self):
		self.start_time = datetime.datetime.now()	# 計測開始時刻
		self._paused = False	# 停止状態フラグ
		self._pause_time = datetime.datetime.now()	# 停止開始時刻
		self._paused_duration = datetime.timedelta(0)  # 累積の停止時間

	def reset(self):
		""" タイマーをリセット """
		self.start_time = datetime.datetime.now()
		self._paused = False
		self._pause_time = None
		self._paused_duration = datetime.timedelta(0)

	def pause(self):
		""" タイマーを一時停止 """
		if not self._paused:
			self._pause_time = datetime.datetime.now()
			self._paused = True

	def resume(self):
		""" 一時停止から再開し、累積停止時刻を更新 """
		if self._paused and self._pause_time is not None:
			paused_interval = datetime.datetime.now() - self._pause_time
			self._paused_duration += paused_interval
			self._paused = False
			self._pause_time = None

	def is_paused(self):
		""" 一時停止中かどうかを返す """
		return self._paused

	def elapsed(self):
		""" 経過時間を返す（停止中は停止時点まで）"""
		if self._paused  and self._pause_time is not None:
			return self._pause_time - self.start_time - self._paused_duration
		return datetime.datetime.now() - self.start_time - self._paused_duration

	def get_time(self):
		return self.start_time
	
	def compare_time(self, interval_sec: float) -> bool:
		"""
		指定秒数 interval_sec が経過していたら True を返し、
		start_time を現在時刻に更新する。
		※一時停止中は常に False を返す。
		"""
		if self._paused:
			return False

		now = datetime.datetime.now()
		target_time = self.start_time + datetime.timedelta(seconds=interval_sec)
		
		if now >= target_time:
			self.start_time = now
			self._paused_duration = datetime.timedelta(0)
			return True
		return False

# ------------------------------------------------------------------------------
# TimerManager クラス：複数の TIMER をラベル付きで管理する
# ------------------------------------------------------------------------------
class TimerManager:
	def __init__(self):
		self.timers = {}	# ラベル -> TIMER の辞書

	def add_timer(self, label: str):
		self.timers[label] = TIMER()

	def remove_timer(self, label: str):
		if label in self.timers:
			del self.timers[label]	

	def compare_time(self, label: str, sec: float) -> bool:
		if label in self.timers:
			return self.timers[label].compare_time(sec)
		raise ValueError(f"Timer '{label}' does not exist.")

	def reset_timer(self, label: str):
		if label in self.timers:
			self.timers[label].reset()

	def pause_timer(self, label: str):
		if label in self.timers:
			self.timers[label].pause()

	def resume_timer(self, label: str):
		if label in self.timers:
			self.timers[label].resume()

	def elapsed(self, label: str) -> datetime.timedelta: # 経過時間を取得
		if label in self.timers:
			return self.timers[label].elapsed()
		raise ValueError(f"Timer '{label}' does not exist.")

	def get_labels(self):
		return list(self.timers.keys())

# main
if __name__ == "__main__":
	tmr = TimerManager()
	tmr.add_timer("Timer1")
	tmr.add_timer("Timer2")

	if False == tmr.compare_time("Timer1", 1.0):
		print("Timer1")

	if False == tmr.compare_time("Timer2", 1.0):
		print("Timer2")

	print("TIMER initialized.")