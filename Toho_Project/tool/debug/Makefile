CC = gcc
CFLAG = -std=c11 -Wall
SRC = id.c
PNG24BIT = png24bit.c
PNG32BIT = png32bit.c
LIBS = `sdl2-config --cflags --libs`
DFLAG = -lSDL2_image -lSDL2 -lSDL2_ttf

all: build

build:
	$(CC) $(CFLAG) -o program $(SRC) $(LIBS) $(DFLAG)

png24:
	$(CC) $(CFLAG) -o program $(PNG24BIT) $(DFLAG)

png32:
	$(CC) $(CFLAG) -o program $(PNG32BIT) $(DFLAG)

install:
	sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-mixer-dev libsdl2-net-dev

run:
	./program

clean:
	rm program
