############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode s_axilite "mapchip_png"
set_directive_top -name mapchip_png.cpp "mapchip_png.cpp"
set_directive_top -name mapchip_png "mapchip_png"
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle src -num_read_outstanding 16 -max_read_burst_length 32 "mapchip_png" srcin
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_read_outstanding 16 -max_read_burst_length 32 "mapchip_png" dstin
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_write_outstanding 16 -max_write_burst_length 32 "mapchip_png" dstout
set_directive_interface -mode s_axilite "mapchip_png" mapchip_maxwidth
set_directive_interface -mode s_axilite "mapchip_png" mapchip_maxheight
set_directive_interface -mode s_axilite "mapchip_png" mapchip_draw_xsize
set_directive_interface -mode s_axilite "mapchip_png" mapchip_draw_ysize
set_directive_interface -mode s_axilite "mapchip_png" xstart_pos
set_directive_interface -mode s_axilite "mapchip_png" ystart_pos
set_directive_interface -mode s_axilite "mapchip_png" frame_size
set_directive_interface -mode s_axilite "mapchip_png" alpha
set_directive_interface -mode s_axilite "mapchip_png" id
set_directive_loop_tripcount -min 1 -max 480 -avg 240 "mapchip_png/height_loop"
set_directive_dataflow "mapchip_png/height_loop"
set_directive_pipeline "mapchip_png/src_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip_png/src_loop"
set_directive_pipeline "mapchip_png/dstin_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip_png/dstin_loop"
set_directive_pipeline "mapchip_png/dstout_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "mapchip_png/dstout_loop"
