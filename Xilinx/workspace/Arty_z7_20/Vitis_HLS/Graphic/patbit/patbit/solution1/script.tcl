############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project patbit
set_top patbit
add_files patbit/patbit.cpp
add_files -tb patbit/patbit_tb.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xc7z020-clg400-1}
create_clock -period 10 -name default
config_export -format ip_catalog -rtl verilog
source "./patbit/solution1/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level port
export_design -rtl verilog -format ip_catalog
