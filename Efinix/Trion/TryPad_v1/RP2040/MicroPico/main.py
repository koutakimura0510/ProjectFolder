from machine import Pin, ADC
from neopixel import NeoPixel
from fpga import FpgaClass
from timer import TimerClass
from usb import UsbClass

# ------------------------------------------------------------------------------
# Local GPIO
# ------------------------------------------------------------------------------
PICO_ADC	= ADC(26)
RGB_LED_R 	= Pin(17, Pin.OUT, value=0)
RGB_LED_G 	= Pin(16, Pin.OUT, value=0)
RGB_LED_B 	= Pin(25, Pin.OUT, value=0)
NEO_PWR 	= Pin(11, Pin.OUT, value=1)
NEO_PIX		= NeoPixel(Pin(12), 1)

# ------------------------------------------------------------------------------
# System Init
# ------------------------------------------------------------------------------
def system_init(self):
	# fpga = FpgaClass()
	# fpga.usi_write(0x0, TIMER_REG_ENABLE)
	# fpga.usi_write(999999, TIMER_REG_DIV1)
	# fpga.usi_write(99999, TIMER_REG_DIV2)
	# fpga.usi_write(99, TIMER_REG_DIV3)
	# fpga.usi_write(0x7, TIMER_REG_ENABLE)
	pass

def core0():
	print("main started...")
	fpga = FpgaClass()
	# usb = UsbClass()
	fpga.config()
	tmr = TimerClass()
	sw = 0
	delta = tmr.get_ms()
	print("FPGA System Ver = ", fpga.usi_read(0x000500F0))
	print("FPGA Custom Code = ", fpga.usi_read(0x000500F4))

	try:
		while True:
			if (True == tmr.compare(delta)):
				val = PICO_ADC.read_u16()
				print(val)
				sw = fpga.usi_read(0x00000041)
				print("sw = ", sw)
				delta = tmr.get_ms() + 1000
				
			NEO_PIX[0] = (sw & 0x01, sw & 0x02, sw & 0x04)
			NEO_PIX.write()
			RGB_LED_R.value(sw & 0x08)
			RGB_LED_G.value(sw & 0x10)
			RGB_LED_B.value(sw & 0x20)
	except KeyboardInterrupt:
		pass

	print("Finished.")

# def core1():
# 	global thread_done
# 	usb = UsbClass()
# 	while True:
# 		try:
# 			s = usb.bulkin()
# 			print(s)
# 		except:
# 			pass
		
# 		if (thread_done == 1):
# 			break
	
# 	_thread.exit()

# ------------------------------------------------------------------------------
# Function
# ------------------------------------------------------------------------------
def main():
	# _thread.start_new_thread(core1, ())
	core0()

if __name__ == "__main__":
	main()