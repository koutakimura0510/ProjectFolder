#MAKEFILE_DIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST)))) #Makefileの親ディレクトリの絶対パスを取得
#SRC := ${CURDIR} #現在のディレクトリまでの絶対パスを取得
#PATH := /home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/
SRC = TFT_DOTCLK

all: build

build:
	quartus_sh --flow compile $(SRC)

sim:
	vsim

run:
	quartus_pgm -c USB-Blaster[1-6.1] -m jtag -o "p;output_files/$(SRC).sof@1"