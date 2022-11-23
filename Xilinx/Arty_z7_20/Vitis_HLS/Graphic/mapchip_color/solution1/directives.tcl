############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode s_axilite "mapchip_color"
set_directive_top -name mapchip_color.cpp "mapchip_color.cpp"
set_directive_top -name mapchip_color "mapchip_color"
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle src -num_read_outstanding 16 -max_read_burst_length 32 "mapchip_color" srcin
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_read_outstanding 16 -max_read_burst_length 32 "mapchip_color" dstin
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_write_outstanding 16 -max_write_burst_length 32 "mapchip_color" dstout
set_directive_interface -mode s_axilite "mapchip_color" mapchip_maxwidth
set_directive_interface -mode s_axilite "mapchip_color" mapchip_maxheight
set_directive_interface -mode s_axilite "mapchip_color" mapchip_draw_xsize
set_directive_interface -mode s_axilite "mapchip_color" mapchip_draw_ysize
set_directive_interface -mode s_axilite "mapchip_color" xstart_pos
set_directive_interface -mode s_axilite "mapchip_color" ystart_pos
set_directive_interface -mode s_axilite "mapchip_color" frame_size
set_directive_interface -mode s_axilite "mapchip_color" com
set_directive_interface -mode s_axilite "mapchip_color" fill
set_directive_interface -mode s_axilite "mapchip_color" alpha
set_directive_interface -mode s_axilite "mapchip_color" id
set_directive_loop_tripcount -min 1 -max 480 -avg 240 "mapchip_color/height_loop"
set_directive_dataflow "mapchip_color/height_loop"
set_directive_pipeline "mapchip_color/src_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip_color/src_loop"
set_directive_pipeline "mapchip_color/dstin_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip_color/dstin_loop"
set_directive_pipeline "mapchip_color/dstout_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip_color/dstout_loop"
