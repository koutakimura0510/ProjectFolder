############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_top -name patbit "patbit"
set_directive_interface -mode s_axilite "patbit"
set_directive_interface -mode m_axi -depth 307200 -offset slave -num_write_outstanding 16 -max_write_burst_length 16 "patbit" dstout
set_directive_interface -mode s_axilite "patbit" ypos
set_directive_interface -mode s_axilite "patbit" height
set_directive_interface -mode s_axilite "patbit" width
set_directive_interface -mode s_axilite "patbit" color
set_directive_interface -mode s_axilite "patbit" xpos
set_directive_loop_tripcount -min 1 -max 480 -avg 240 "patbit/height_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 320 "patbit/width_loop"
