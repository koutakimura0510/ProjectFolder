# # Sim 出力ファイル名
# TBOUT    = tbwave.out

# # Tb Top Module名
# TBTOP 	 = VideoPixelGenUnit_tb

# # Tb Top Module.v
# TBTOPRTL = VideoPixelGenUnit_tb.v

# # Tb Instance.v
# TBRTL 	= ../../VideoTxCsr.v ../VideoPixelGenUnit.v ../PlayerDraw/PlayerDraw.v ../common/*.v ./BmpFileSaver.v
# COMMON	= ../../../common/pulse/*.v ../../../common/fifo/*.v ../../../common/mult/AlphaBlend.v
# LIB		= C:/Efinity/2023.1/sim_models/verilog/*.v
# INCLUDE = -I ./include

# sim:
# 	iverilog -o $(TBOUT) -s $(TBTOP) $(INCLUDE) $(TBRTL) $(COMMON) $(LIB) $(TBTOPRTL)
# 	vvp -n $(TBOUT)


#
# Makefile: Verilog シミュレーション用
# 
# `make sim` を実行すると、iverilog でコンパイルし、vvp で実行する。
# 
# iverilog -o [出力ファイル名] -s [トップモジュール名] [オプション] [Verilog ソースファイル]
#   -o オプション: 出力ファイル名 (省略時は a.out)
#   -s オプション: トップモジュールの指定 (省略可能だが、指定推奨)
# 
# Created 2025-03-22
# 2025-03-22 : v1.00

# 出力ファイル名
TBOUT    = tbwave.out

# テストベンチのトップモジュール名
TBTOP    = VideoPixelGenUnit_tb

# テストベンチのトップモジュールファイル
TBTOPRTL = VideoPixelGenUnit_tb.v

# テストベンチ内で使用するモジュール
TBRTL    = ../../VideoTxCsr.v \
           ../VideoPixelGenUnit.v \
           ../PlayerDraw/PlayerDraw.v \
           ../common/*.v \
           ./BmpFileSaver.v

# 共通ライブラリファイル
COMMON   = ../../../common/pulse/*.v \
           ../../../common/fifo/*.v \
           ../../../common/mult/AlphaBlend.v

# シミュレーションライブラリ (Efinity)
LIB      = C:/Efinity/2023.1/sim_models/verilog/*.v

# ヘッダファイルのディレクトリ指定
INCLUDE  = -I ./include

# シミュレーション実行
sim:
	iverilog -o $(TBOUT) -s $(TBTOP) $(INCLUDE) $(TBRTL) $(COMMON) $(LIB) $(TBTOPRTL)
	vvp -n $(TBOUT)