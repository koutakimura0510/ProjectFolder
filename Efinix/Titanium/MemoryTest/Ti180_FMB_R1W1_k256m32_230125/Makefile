#
# makeを実行して ./programを行う
#

PROJECT = ./Ti180_FMB_R1W1_k256m32_230125.xml
BIT = ./outflow/Ti180_FMB_R1W1_k256m32_230125.bit
HEX = ./outflow/Ti180_FMB_R1W1_k256m32_230125.hex
FILE = efx_run.py

all:
	compile convert

cokmpile:
	$(FILE) $(PROJECT) --flow compile

synthesis:
	$(FILE) $(PROJECT) --flow map

debugger:
	$(FILE) $(PROJECT) --flow dbg_auto

interface:
	$(FILE) $(PROJECT) --flow interface

place:
	$(FILE) $(PROJECT) --flow pnr

pgm:
	$(FILE) $(PROJECT) --flow pgm

convert:
	cp $(BIT) $(HEX)

jtag:
	$(FILE) $(PROJECT) --flow program --pgm_opts mode=jtag