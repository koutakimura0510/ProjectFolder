#
# makeを実行して ./programを行う
#
# iverilog -o [出力ファイル名] -s [トップモジュール名] [トップモジュールファイル] [.vファイルの羅列]
# -oオプションを省略すると出力ファイルはa.outになる。-sオプションは省略可能だが、省略せずにトップモジュールを明示したほうが良さげである

# Sim 出力ファイル名
TBOUT    = tbwave.out

# Tb Top Module名
# TBTOP 	 = AudioRomRead_tb
TBTOP 	 = AudioTxBlock_tb

# Tb Top Module.v
# TBTOPRTL = AudioRomRead_tb.v
TBTOPRTL = AudioTxBlock_tb.v

# Tb Instance.v
TBRTL 	 = ../*.v
COMMON	= ../../common/pulse/*.v ../../common/fifo/*.v ../../SPIBlock/SpiFlashRom.v
LIB		= /tools/efinity/2023.1/sim_models/verilog/*.v

sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(TBRTL) $(COMMON) $(LIB) $(TBTOPRTL)
	vvp -n $(TBOUT)