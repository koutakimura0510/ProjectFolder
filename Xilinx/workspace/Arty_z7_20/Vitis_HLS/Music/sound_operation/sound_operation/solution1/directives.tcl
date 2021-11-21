############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_top -name sound_operation "sound_operation"
set_directive_interface -mode ap_none -register "sound_operation" sdata
set_directive_interface -mode ap_ctrl_none "sound_operation"
set_directive_interface -mode m_axi -offset slave -bundle ram -num_read_outstanding 16 -max_read_burst_length 32 "sound_operation" ramadr
set_directive_interface -mode ap_none -register "sound_operation" opeout
set_directive_interface -mode ap_none -register "sound_operation" cnt
set_directive_interface -mode s_axilite "sound_operation" ope
set_directive_pipeline -rewind "sound_operation/sound_operation_label0"
set_directive_dataflow "sound_operation/sound_operation_label1"
