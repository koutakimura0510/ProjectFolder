CC = gcc
CFLAG = -std=c11 -Wall
SRC = file.c


all: clean build run win

build:
	$(CC) $(CFLAG) -o program $(SRC)

win:
	x86_64-w64-mingw32-gcc-win32 $(CFLAG) -o win.exe $(SRC) -fexec-charset=CP932

install:
	sudo apt install gcc-mingw-w64-x86-64

run:
	./program

clean:
	rm program
