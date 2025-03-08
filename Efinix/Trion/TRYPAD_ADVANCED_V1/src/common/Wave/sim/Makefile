#
# makeを実行して ./programを行う
#
# iverilog -o [出力ファイル名] -s [トップモジュール名] [トップモジュールファイル] [.vファイルの羅列]
# -oオプションを省略すると出力ファイルはa.outになる。-sオプションは省略可能だが、省略せずにトップモジュールを明示したほうが良さげである

# Sim 出力ファイル名
TBOUT    = tbwave.out

# Tb Top Module名
TBTOP 	 = SinGenDsp_tb

# Tb Top Module.v
TBTOPRTL = SinGenDsp_tb.v

# Tb Instance.v
TBRTL 	 = ../SinGenDsp.v
COMMON   = /tools/efinity/2022.2/sim_models/maplib/efinix_maplib.v

sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(TBRTL) $(TBTOPRTL) $(COMMON)
	vvp -n $(TBOUT)