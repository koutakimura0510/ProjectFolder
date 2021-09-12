CC = gcc
CFLAG = -std=c11 -Wall

all: program

program:
	$(CC) $(CFLAG) -o program ncurses.c

run:
	./program

install:
	sudo apt install libncurses5-dev

clean:
	rm program
