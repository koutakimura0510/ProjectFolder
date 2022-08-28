# -Wall		警告オプションを全てオンにする
# -g3 		gdb でデバッグを行うために使用する
# -O, -O1 	最適化する
# -o 		生成ファイルの名前指定
#
# コンパイラ指定
CC 		= /usr/bin/gcc-10

# C言語バージョン指定、警告を有効、gdb デバッグ有効
CFLAG 	= -std=c11 -Wall -g3

# ソースコード指定
SRC1 	= ./src/*.c
SRC2 	= ./src/gpio/*.c
COMPILE = $(SRC1) $(SRC2)

# 小部是y区とファイル一体化 生成ファイル名
NAME    = -o main

# ライブラリ
LIBS 	= -l bcm2835
INCLUDE = -I ./src/include/
DFLAG 	=

all:
	make build
	make run

build:
	$(CC) $(CFLAG) $(NAME) $(INCLUDE) $(COMPILE) $(LIBS) $(DFLAG)

run:
	sudo ./main