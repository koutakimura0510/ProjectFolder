#
# makeを実行して ./programを行う
#
# iverilog -o [出力ファイル名] -s [トップモジュール名] [トップモジュールファイル] [.vファイルの羅列]
# -oオプションを省略すると出力ファイルはa.outになる。-sオプションは省略可能だが、省略せずにトップモジュールを明示したほうが良さげである

# Sim 出力ファイル名
TBOUT    = VtbUnit.out

# Tb Top Module名
TBTOP 	 = VTUnit_tb

# Tb Top Module.v
TBTOPRTL = ./src/ddr_reset_sequencer_tb.v

# Tb Instance.v
TBRTL 	 = ./src/ddr_reset_sequencer.v

sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(TBRTL) $(TBTOPRTL)
	vvp -n $(TBOUT)