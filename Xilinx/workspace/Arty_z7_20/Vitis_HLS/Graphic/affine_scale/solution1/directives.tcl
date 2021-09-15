############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_top -name affine_scale.cpp "affine_scale.cpp"
set_directive_top -name affine_scale "affine_scale"
set_directive_interface -mode s_axilite "affine_scale"
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle src -num_read_outstanding 16 -max_read_burst_length 32 "affine_scale" srcin
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_read_outstanding 16 -max_read_burst_length 32 "affine_scale" dstin
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle dst -num_write_outstanding 16 -max_write_burst_length 32 "affine_scale" dstout
set_directive_interface -mode s_axilite "affine_scale" mapchip_maxwidth
set_directive_interface -mode s_axilite "affine_scale" mapchip_maxheight
set_directive_interface -mode s_axilite "affine_scale" mapchip_draw_xsize
set_directive_interface -mode s_axilite "affine_scale" mapchip_draw_ysize
set_directive_interface -mode s_axilite "affine_scale" xstart_pos
set_directive_interface -mode s_axilite "affine_scale" ystart_pos
set_directive_interface -mode s_axilite "affine_scale" frame_size
set_directive_interface -mode s_axilite "affine_scale" alpha
set_directive_interface -mode s_axilite "affine_scale" id
set_directive_interface -mode s_axilite "affine_scale" a
set_directive_interface -mode s_axilite "affine_scale" b
set_directive_interface -mode s_axilite "affine_scale" c
set_directive_interface -mode s_axilite "affine_scale" d
set_directive_interface -mode s_axilite "affine_scale" m
set_directive_interface -mode s_axilite "affine_scale" n
set_directive_loop_tripcount -min 1 -max 480 -avg 240 "affine_scale/height_loop"
set_directive_dataflow "affine_scale/height_loop"
set_directive_pipeline "affine_scale/src_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "affine_scale/src_loop"
set_directive_pipeline "affine_scale/dstin_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "affine_scale/dstin_loop"
set_directive_pipeline "affine_scale/dstout_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 240 "affine_scale/dstout_loop"
