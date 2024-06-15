from machine import Timer



# ------------------------------------------------------------------------------
# グローバル変数
# ------------------------------------------------------------------------------
gl_timer_cnt = 0

# ------------------------------------------------------------------------------
# ハードウェア インターバルタイマ 割り込み関数
# ------------------------------------------------------------------------------
def tmr_cnt_callback(tmr):
	global gl_timer_cnt
	gl_timer_cnt = gl_timer_cnt + 1

tmr = Timer()	# ハードタイマーインスタンス

# ------------------------------------------------------------------------------
# Timer Class
# ------------------------------------------------------------------------------
class TimerClass:
	def __init__(self) -> None:
		tmr.init(period=1, callback=tmr_cnt_callback)
		pass
	
	def get_ms(self):
		return gl_timer_cnt
	
	def compare(self, delta):
		if (delta < gl_timer_cnt):
			return True
		else:
			return False
	
	def wait(self, ms_wait_time):
		delta = gl_timer_cnt + ms_wait_time
		while (delta < gl_timer_cnt):
			pass

	def deinit(self):
		tmr.deinit()