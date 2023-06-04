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

# 2023 04-15:
# 現状 efx_run.py synthesis のときに、ソースコードが反映されず正常に map を生成しないので、python ファイルを直接実行している。
# プロジェクト変更時は下記変数を一括変換する
# EFX_PROJECT, EFX_TOP
EFX_DEVICE = "T20Q144"
EFX_FAMILY = "Trion"
EFX_PROJECT = "PrimitiveTest"
EFX_TOP = "PrimitiveTestTop"
EFX_MAP_PATH = /tools/efinity/2022.2/bin/efx_map

# シンボリックリンクで実行可能
PROJECT = ./PrimitiveTest.xml
FILE = efx_run.py
# BIT = ./outflow/PrimitiveTest.bit
# HEX = ./outflow/PrimitiveTest.hex

all: synthesis interface place pgm jtag

# compile:
# 	$(FILE) $(PROJECT) --flow compile

synthesis:
	$(EFX_MAP_PATH) --project $(EFX_PROJECT) --root $(EFX_TOP) --write-efx-verilog "/home/kimura/workspace/ProjectFolder/Efinix/Trion/PrimitiveTest/outflow/PrimitiveTest.map.v" --write-premap-module "/home/kimura/workspace/ProjectFolder/Efinix/Trion/PrimitiveTest/outflow/PrimitiveTest.elab.vdb" --binary-db "/home/kimura/workspace/ProjectFolder/Efinix/Trion/PrimitiveTest/PrimitiveTest.vdb" --device $(EFX_DEVICE) --family $(EFX_FAMILY) --mode "speed" --max_ram "-1" --max_mult "-1" --infer-clk-enable "3" --infer-sync-set-reset "1" --min-sr-fanout "0" --min-ce-fanout "0" --fanout-limit "0" --bram_output_regs_packing "1" --retiming "1" --seq_opt "1" --blast_const_operand_adders "1" --operator-sharing "0" --optimize-adder-tree "0" --seq-opt-sync-only "0" --blackbox-error "1" --allow-const-ram-index "0" --hdl-compile-unit "1" --create-onehot-fsms "0" --mult_input_regs_packing "1" --mult_output_regs_packing "1" --veri_option "verilog_mode=verilog_2k,vhdl_mode=vhdl_2008" --work-dir "/home/kimura/workspace/ProjectFolder/Efinix/Trion/PrimitiveTest/work_syn" --output-dir "/home/kimura/workspace/ProjectFolder/Efinix/Trion/PrimitiveTest/outflow" --project-xml "/home/kimura/workspace/ProjectFolder/Efinix/Trion/PrimitiveTest/PrimitiveTest.xml" --I "/home/kimura/workspace/ProjectFolder/Efinix/Trion/PrimitiveTest"
# $(FILE) $(PROJECT) --flow map

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

sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(TBRTL) $(TBTOPRTL)
	vvp -n $(TBOUT)