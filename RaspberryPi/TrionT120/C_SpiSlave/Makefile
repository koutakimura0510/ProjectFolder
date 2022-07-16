# -Wall		警告オプションを全てオンにする
# -g3 		gdb でデバッグを行うために使用する
# -O, -O1 	最適化する
# -o 		生成ファイルの名前指定
#
CC 		= /usr/bin/gcc-10
CFLAG 	= -std=c11 -Wall -g3
SRC 	= ./src/*.c
NAME    = -o main
LIBS 	= -l bcm2835
DFLAG 	= 

all:
	make build
	make run

build:
	$(CC) $(CFLAG) $(NAME) $(SRC) $(LIBS) $(DFLAG)

run:
	./main