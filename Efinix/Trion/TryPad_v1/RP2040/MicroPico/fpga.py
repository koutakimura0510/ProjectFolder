from machine import Pin, SoftSPI
from timer import TimerClass

TRION_CDONE		= Pin(27, Pin.IN)			# Trion Config Done Pin, Ext Pull Up
TRION_CFGRST	= Pin(0, Pin.OUT, value=0)
TRION_PICO_IO0	= Pin(28, Pin.OUT, value=0) # USI Bus Sel
TRION_PICO_IO1	= Pin(29, Pin.OUT, value=0) # FPGA Sys RST
TRION_PICO_IO2	= Pin(6, Pin.OUT, value=0)
TRION_PICO_CS	= Pin(1, Pin.OUT, value=1)
SOFT_SPI		= SoftSPI(baudrate=1000000, sck=Pin(2), mosi=Pin(3), miso=Pin(4))

# ------------------------------------------------------------------------------
# FPGA Class
# ------------------------------------------------------------------------------
class FpgaClass:
	def __init__(self) -> None:
		pass

	def config(self):
		tmr = TimerClass()
		TRION_CFGRST.value(1)
		tmr.wait(2)
		delta = tmr.get_ms() + 3000
		while (0 == TRION_CDONE.value()):
			try:
				if (True == tmr.compare(delta)):
					print("FPGA Init Not Done")
					break
			except TimeoutError as e:
				print(e)

		tmr.wait(2)
		print("FPGA CDONE = ", TRION_CDONE.value())
		TRION_PICO_IO1.value(1)
		tmr.wait(2)
		
	def usi_write(self, adrs, wd):
		adrs |= 0x40000000
		wbuf = bytearray(8)
		wbuf[0] = (adrs >> 24) & 0xff
		wbuf[1] = (adrs >> 16) & 0xff
		wbuf[2] = (adrs >> 8) & 0xff
		wbuf[3] = adrs & 0xff
		wbuf[4] = (wd >> 24) & 0xff
		wbuf[5] = (wd >> 16) & 0xff
		wbuf[6] = (wd >> 8) & 0xff
		wbuf[7] = wd & 0xff
		TRION_PICO_CS.value(0)
		SOFT_SPI.write(wbuf)
		TRION_PICO_CS.value(1)

	def usi_read(self, adrs):
		wbuf = bytearray(4)
		rbuf = bytearray(4)
		wbuf[0] = (adrs >> 24) & 0x00
		wbuf[1] = (adrs >> 16) & 0xff
		wbuf[2] = (adrs >> 8) & 0xff
		wbuf[3] = adrs & 0xff
		TRION_PICO_CS.value(0)
		SOFT_SPI.write_readinto(wbuf,rbuf)
		TRION_PICO_CS.value(1)
		rd = (rbuf[0] << 24) | (rbuf[1] << 16) | (rbuf[2] << 8) | rbuf[3]

		return rd