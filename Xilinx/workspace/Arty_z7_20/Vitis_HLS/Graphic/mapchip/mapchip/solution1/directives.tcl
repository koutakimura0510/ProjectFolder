############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode s_axilite "mapchip"
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_write_outstanding 16 -max_write_burst_length 32 "mapchip" dstout
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle src -num_read_outstanding 16 -max_read_burst_length 32 "mapchip" srcin
set_directive_interface -mode s_axilite "mapchip" alpha
set_directive_top -name mapchip.cpp "mapchip.cpp"
set_directive_pipeline "mapchip/src_loop"
set_directive_pipeline "mapchip/dstout_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip/src_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip/dstout_loop"
set_directive_loop_tripcount -min 1 -max 480 -avg 240 "mapchip/height_loop"
set_directive_top -name mapchip "mapchip"
set_directive_dataflow "mapchip/height_loop"
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_write_outstanding 16 -max_write_burst_length 32 "mapchip" dstin
set_directive_pipeline "mapchip/dstin_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip/dstin_loop"
set_directive_interface -mode s_axilite "mapchip" id
set_directive_interface -mode s_axilite "mapchip" frame_size
set_directive_interface -mode s_axilite "mapchip" mapchip_maxwidth
set_directive_interface -mode s_axilite "mapchip" mapchip_maxheight
set_directive_interface -mode s_axilite "mapchip" mapchip_draw_xsize
set_directive_interface -mode s_axilite "mapchip" mapchip_draw_ysize
set_directive_interface -mode s_axilite "mapchip" crip
set_directive_interface -mode s_axilite "mapchip" xstart_pos
set_directive_interface -mode s_axilite "mapchip" ystart_pos
