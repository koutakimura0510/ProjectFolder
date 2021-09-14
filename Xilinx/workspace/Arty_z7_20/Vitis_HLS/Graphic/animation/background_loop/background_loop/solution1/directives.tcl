############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle copy -num_read_outstanding 16 -max_read_burst_length 32 "background_loop" ddr_copy
set_directive_interface -mode m_axi -depth 307200 -offset slave -bundle update -num_write_outstanding 16 -max_write_burst_length 32 "background_loop" ddr_update
set_directive_interface -mode s_axilite "background_loop" width
set_directive_interface -mode s_axilite "background_loop" height
set_directive_interface -mode s_axilite "background_loop" frame_size
set_directive_interface -mode s_axilite "background_loop" direction
set_directive_top -name background_loop "background_loop"
set_directive_dataflow "background_loop/right_y_loop"
set_directive_loop_tripcount -min 1 -max 480 -avg 480 "background_loop/right_y_loop"
set_directive_dataflow "background_loop/right_height_loop"
set_directive_loop_tripcount -min 1 -max 480 -avg 480 "background_loop/right_height_loop"
set_directive_pipeline "background_loop/right_width_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 640 "background_loop/right_width_loop"
set_directive_pipeline "background_loop/right_copy_loop"
set_directive_loop_tripcount -min 1 -max 640 -avg 640 "background_loop/right_copy_loop"
set_directive_dataflow "background_loop/copy"
set_directive_loop_tripcount -min 1 -max 480 -avg 480 "background_loop/copy"
set_directive_dataflow "background_loop/copy2"
set_directive_loop_tripcount -min 1 -max 480 -avg 480 "background_loop/copy2"
