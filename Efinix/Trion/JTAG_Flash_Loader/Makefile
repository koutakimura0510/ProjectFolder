#
# makeを実行して ./programを行う
#
# iverilog -o [出力ファイル名] -s [トップモジュール名] [トップモジュールファイル] [.vファイルの羅列]
# -oオプションを省略すると出力ファイルはa.outになる。-sオプションは省略可能だが、省略せずにトップモジュールを明示したほうが良さげである

# Sim 出力ファイル名
TBOUT    = tbwave.out

# Tb Top Module名
TBTOP 	 = ddr_reset_sequencer_tb

# Tb Top Module.v
TBTOPRTL = ./src/ddr_reset_sequencer_tb.v

# Tb Instance.v
TBRTL 	 = ./src/ddr_reset_sequencer.v

# シンボリックリンクで実行可能
FILE = efx_run.py
PROJECT = ./JTAG_Flash_Loader.xml
# BIT = ./outflow/K5Stack10_MIDI.bit
# HEX = ./outflow/K5Stack10_MIDI.hex

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

# 2022.2 で JTAGコマンド書き込みのバグにバッチが当てられためコメントアウト
# convert:
# 	cp $(BIT) $(HEX)

jtag:
	$(FILE) $(PROJECT) --flow program --pgm_opts mode=jtag

flash:
	$(FILE) $(PROJECT) --flow program --pgm_opts mode=jtag
# $(FILE) $(PROJECT) --flow program --pgm_opts mode=jtag_bridge
sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(TBRTL) $(TBTOPRTL)
	vvp -n $(TBOUT)

py:
	python3 python/InfoLog.py