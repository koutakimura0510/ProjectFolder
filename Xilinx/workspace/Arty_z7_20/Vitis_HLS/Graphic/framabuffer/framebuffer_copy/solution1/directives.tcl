############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_top -name framebuffer_copy "framebuffer_copy"
set_directive_interface -mode s_axilite "framebuffer_copy"
set_directive_interface -mode m_axi -depth 399360 -offset slave -bundle cp -num_read_outstanding 16 -max_read_burst_length 32 "framebuffer_copy" copy
set_directive_interface -mode m_axi -depth 399360 -offset slave -bundle up -num_write_outstanding 16 -max_write_burst_length 32 "framebuffer_copy" update
set_directive_dataflow "framebuffer_copy/height_loop"
set_directive_loop_tripcount -min 1 -max 480 -avg 480 "framebuffer_copy/height_loop"
set_directive_pipeline "framebuffer_copy/width_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 128 "framebuffer_copy/width_loop"
set_directive_pipeline "framebuffer_copy/copy_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 128 "framebuffer_copy/copy_loop"
set_directive_interface -mode s_axilite "framebuffer_copy" width
set_directive_interface -mode s_axilite "framebuffer_copy" height
set_directive_interface -mode s_axilite "framebuffer_copy" display_xsize
