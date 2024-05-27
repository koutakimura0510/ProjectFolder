# 
# 実行手順
# 1. sudo apt install build-essential
# 2. make install
# 3. make
# 4. ./program res/chip_xxx_png
# 現状 前回のキーデータを覚えているおり起動直後に終了してしまうため、プログラム実行時は Left キーを長押ししておく。

CC = gcc
# CC = x86_64-w64-mingw32-gcc
CFLAG = -std=c11 -Wall
# SRC = ./src/main.c ./src/mapchip.c ./src/terminal.c ./src/key.c ./src/file.c
SRC = ./src/*.c
LIBS = `sdl2-config --cflags --libs`
DFLAG = -lSDL2 -lSDL2_image -lSDL2_ttf

all: build

build:
	$(CC) $(CFLAG) -o program $(SRC) $(LIBS) $(DFLAG)

install:
	sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-mixer-dev libsdl2-net-dev

run:
	./program

clean:
	rm program
