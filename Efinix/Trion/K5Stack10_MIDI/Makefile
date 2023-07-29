# ------------------------------------------------------------------------------
# 2023-07-22
# Author Kouta Kimura
# Efinity Compile Makefile
# ------------------------------------------------------------------------------

FILE = efx_run.py
PROJECT = ./K5Stack10_MIDI.xml
JTAG_PROJECT = ../JTAG_Flash_Loader
# SIM_PROJECT = ./src/common/fifo/sim
SIM_PROJECT = ./src/UltraFastInterfaceBus/sim

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

sim:
	make -C $(SIM_PROJECT) sim

py:
	python3 python/InfoLog.py