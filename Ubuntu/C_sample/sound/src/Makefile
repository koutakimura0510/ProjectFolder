S     = saw.c
CC    = gcc
CFLAG = -std=c11 -Wall
CMD   = -lm

all:
	$(CC) $(CFLAG) -o program ${S} -lsndfile -lm
	

#build:
#	$(CC) $(CFLAG) -o program $(SRC) -lm

#triangle:
#	$(CC) $(CFLAG) -o program $(TRIANGLE) -lm

#saw:
#	$(CC) $(CFLAG) -o program $(SAW) -lm

run:
	./program

clean:
	rm *.o
