############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project led_blink
set_top led_blink
add_files led_blink.cpp
add_files -tb led_blink_tb.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7z020clg400-1}
create_clock -period 10 -name default
source "./led_blink/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
