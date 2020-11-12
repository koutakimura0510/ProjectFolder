CC = gcc
CFLAG = -std=c11 -Wall
SRC = png.c
SDL = sdl.c
LIBS = `sdl2-config --cflags --libs`
DFLAG = -lSDL2_image -lSDL2 -lSDL2_ttf

all: build

build:
	$(CC) $(CFLAG) -o program $(SRC) $(LIBS) $(DFLAG)

sdl:
	$(CC) $(CFLAG) -o program $(SDL) $(DFLAG)

install:
	sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-mixer-dev libsdl2-net-dev

run:
	./program

clean:
	rm program
