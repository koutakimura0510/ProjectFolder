# TOP 
# -s Top module の名前 / ファイル名
#
SIM		= iverilog
TB		= -s CountTest
NAME    = -o sim.out
TOP 	= ./src/sim/CountTest.v
SRC 	= ./src/*.v
LIBS 	= 
DFLAG 	= 
VPP		= vvp sim.out
RUN 	= gtkwave sim.vcd

all:
	make sim
	make run

sim:
	$(SIM) $(TB) $(NAME) $(TOP) $(SRC) $(LIBS) $(DFLAG)
	$(VPP)
run:
	$(RUN)