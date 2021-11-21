############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode ap_ctrl_none "led_blink"
set_directive_interface -mode ap_none "led_blink" led
set_directive_top -name led_blink "led_blink"
set_directive_interface -mode s_axilite "led_blink"
set_directive_interface -mode m_axi -bundle onoff -offset slave "led_blink" onoff
