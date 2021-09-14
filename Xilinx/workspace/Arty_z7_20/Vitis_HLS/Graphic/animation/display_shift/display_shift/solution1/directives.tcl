############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_top -name display_shift "display_shift"
set_directive_interface -mode s_axilite "display_shift"
set_directive_interface -mode s_axilite "display_shift" width
set_directive_interface -mode s_axilite "display_shift" height
set_directive_interface -mode s_axilite "display_shift" xstart
set_directive_interface -mode s_axilite "display_shift" xend
set_directive_interface -mode s_axilite "display_shift" ystart
set_directive_interface -mode s_axilite "display_shift" yend
set_directive_interface -mode s_axilite "display_shift" frame_size
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle copy -num_read_outstanding 16 -max_read_burst_length 32 "display_shift" ddr_copy
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle update -num_write_outstanding 16 -max_write_burst_length 32 "display_shift" ddr_update
set_directive_dataflow "display_shift/display_shift_label0"
set_directive_loop_tripcount -min 1 -max 480 -avg 480 "display_shift/display_shift_label0"
set_directive_pipeline "display_shift/display_shift_label1"
set_directive_loop_tripcount -min 1 -max 640 -avg 640 "display_shift/display_shift_label1"
set_directive_pipeline "display_shift/display_shift_label2"
set_directive_loop_tripcount -min 1 -max 640 -avg 640 "display_shift/display_shift_label2"
set_directive_dataflow "display_shift/display_shift_label3"
