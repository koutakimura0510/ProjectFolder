CC 		= /usr/bin/gcc-10
CFLAG 	= -std=c11 -Wall
SRC 	= ./src/*.c
LIBS 	= -l bcm2835
DFLAG 	= 

all:
	make build
	make run

build:
	$(CC) $(CFLAG) -o program $(SRC) $(LIBS) $(DFLAG)

run:
	./program

clean:
	rm program
