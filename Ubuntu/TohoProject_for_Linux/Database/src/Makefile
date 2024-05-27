CC = gcc
CFLAG = -std=c11 -Wall
SRC   = DatabaseBin.c
SJIS  = -fexec-charset=CP932
all: build

build:
	$(CC) $(CFLAG) -o program $(SRC) $(SJIS)

run:
	./program

add:
	git add .

clean:
	rm program
