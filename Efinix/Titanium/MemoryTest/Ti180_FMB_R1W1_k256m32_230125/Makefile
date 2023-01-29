#
# makeを実行して ./programを行う
#
# iverilog -o [出力ファイル名] -s [TB トップモジュール名] [TB.v トップモジュール] [.vファイルの羅列]
# -oオプションを省略すると出力ファイルはa.outになる。-sオプションは省略可能だが、省略せずにトップモジュールを明示したほうが良さげである

# Sim 出力ファイル名
TBOUT    = tbwave.out

# Tb Top Module名
TBTOP 	 = ddr_reset_sequencer_tb

# Tb Top Module.v
TBTOPRTL = ./src/ddr_reset_sequencer_tb.v

# Tb Instance.v
TBRTL 	 = ./src/ddr_reset_sequencer.v

#
PROJECT = ./Ti180_FMB_R1W1_k256m32_230125.xml
BIT = ./outflow/Ti180_FMB_R1W1_k256m32_230125.bit
HEX = ./outflow/Ti180_FMB_R1W1_k256m32_230125.hex
FILE = efx_run.py

all: compile convert jtag

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

convert:
	cp $(BIT) $(HEX)

jtag:
	$(FILE) $(PROJECT) --flow program --pgm_opts mode=jtag

sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(TBRTL) $(TBTOPRTL)
	vvp -n $(TBOUT)