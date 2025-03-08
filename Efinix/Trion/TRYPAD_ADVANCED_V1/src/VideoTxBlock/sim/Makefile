#
# makeを実行して ./programを行う
#
# iverilog -o [出力ファイル名] -s [トップモジュール名] [トップモジュールファイル] [.vファイルの羅列]
# -oオプションを省略すると出力ファイルはa.outになる。-sオプションは省略可能だが、省略せずにトップモジュールを明示したほうが良さげである

# Sim 出力ファイル名
TBOUT    = tbwave.out

# Tb Top Module名
TBTOP 	 = TbTopVideoTftUnit

# Tb Top Module.v
TBTOPRTL = TbTopVideoTftUnit.v

# Tb Instance.v
TBRTL 	= ../*.v ./BmpFileSaver.v
COMMON	= ../../common/pulse/*.v ../../common/fifo/*.v
LIB		= C:/Efinity/2023.1/sim_models/verilog/*.v

sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(TBRTL) $(COMMON) $(LIB) $(TBTOPRTL)
	vvp -n $(TBOUT)