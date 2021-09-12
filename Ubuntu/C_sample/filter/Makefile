# intg.c % white 10000 | imul 100 | intg | fftw | gp_fftl > wtintg.png


CC 	  = gcc
CFLAG = -std=c11 -Wall
SRC   = intg.c

all: build

build:
	$(CC) $(CFLAG) -o intg $(SRC) -lm

intg_run:
	white 10000 | imul 100 | intg | fftw | gp_fftl > wtintg.png

clean:
	rm *.txt *.png
