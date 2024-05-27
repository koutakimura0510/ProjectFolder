#
# makeを実行して ./programを行う
#

CC = gcc
CFLAG = -std=c11 -Wall
SRC = png32bit.c
PNG32BIT = png32bit.c
MAPBMP   = png_worldmap.c
WRITE	 = typedef_file.c
READ	 = typedef_read_file.c
LIBS = `sdl2-config --cflags --libs`
DFLAG = -lSDL2_image -lSDL2 -lSDL2_ttf
SJIS  = -fexec-charset=CP932
all: build

build:
	$(CC) $(CFLAG) -o program $(SRC) $(LIBS) $(DFLAG)

png32:
	$(CC) $(CFLAG) -o program $(PNG32BIT) $(DFLAG)

map:
	$(CC) $(CFLAG) -o program $(MAPBMP) $(DFLAG)

write:
	$(CC) $(CFLAG) -o program $(WRITE) $(SJIS)

read:
	$(CC) $(CFLAG) -o program $(READ) $(SJIS)

install:
	sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-mixer-dev libsdl2-net-dev libgl1-mesa-dev xorg-dev

run:
	./program

clean:
	rm program
