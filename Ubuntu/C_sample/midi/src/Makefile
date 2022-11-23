# data_midi_printf.c --- ./program .midのファイルパス >> 出力先のファイルパス.txt
# get_midi_musical.c  --- ./program midファイルを解析したデータが記載されているtxtファイルのパス


CC 	  = gcc
CFLAG = -std=c11 -Wall
SRC   = get_midi_musical.c
SRC2  = get_Midi_Program_Change.c
SRC3  = data_midi_printf.c
SRC4  = sin.c

all: build

build:
	$(CC) $(CFLAG) -o musical $(SRC)

build2:
	$(CC) $(CFLAG) -o program_change $(SRC2)

build3:
	$(CC) $(CFLAG) -o output_mididata $(SRC3)

build4:
	$(CC) $(CFLAG) -o program $(SRC4) -lm

run:
	./program ../filebgm/fan.txt

clean:
	rm ../filebgm/*.txt
