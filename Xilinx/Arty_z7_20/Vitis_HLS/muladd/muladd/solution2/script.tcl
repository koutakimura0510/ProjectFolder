############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project muladd
set_top muladd
add_files muladd.c
add_files -tb muladd_tb.c
open_solution "solution2" -flow_target vivado
set_part {xc7z020clg400-1}
create_clock -period 10 -name default
source "./muladd/solution2/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level port
export_design -format ip_catalog
