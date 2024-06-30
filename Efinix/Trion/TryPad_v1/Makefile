# ------------------------------------------------------------------------------
# 2023-07-22
# Author Kouta Kimura
# Efinity Compile Makefile
# ------------------------------------------------------------------------------

FILE = C:\Efinity\2023.1\bin\efx_run.bat
PROJECT = TryPad_v1.xml
JTAG_PROJECT = ../JTAG_Flash_Loader
# SIM_PROJECT = ./src/common/fifo/sim
# SIM_PROJECT = ./src/UltraFastInterfaceBus/sim
# SIM_PROJECT = ./src/SynthesizerBlock/sim
# SIM_PROJECT = ./src/VideoTxBlock/VideoPixelGenUnit/sim
# SIM_PROJECT = ./src/AudioTxBlock/sim
# SIM_PROJECT = ./src/VideoTxBlock/sim
SIM_PROJECT = ./src/RamBlock/sim
# SIM_PROJECT = ./src/I2cBlock/I2cSlave

all: synthesis interface place pgm jtag

compile:
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

jtag:
	$(FILE) $(PROJECT) --flow program --pgm_opts mode=jtag

flash:
	make -C $(JTAG_PROJECT) jtag
	$(FILE) $(PROJECT) --flow program --pgm_opts mode=jtag_bridge

Update:
	make -C $(JTAG_PROJECT) jtag

sim:
	make -C $(SIM_PROJECT) sim

py:
	python3 python/InfoLog.py