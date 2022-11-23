set moduleName dataflow_in_loop_height_loop_entry6
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 1
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {dataflow_in_loop_height_loop.entry6}
set C_modelType { void 0 }
set C_modelArgList {
	{ mapchip_draw_xsize int 32 regular  }
	{ mapchip_maxwidth int 32 regular  }
	{ d int 20 regular  }
	{ a int 20 regular  }
	{ c int 20 regular  }
	{ b int 20 regular  }
	{ m int 32 regular  }
	{ trunc_ln1345 int 32 regular  }
	{ mapchip_maxheight int 32 regular  }
	{ n int 32 regular  }
	{ id int 32 regular  }
	{ ystart_pos int 32 regular  }
	{ xstart_pos int 32 regular  }
	{ srcin int 64 regular  }
	{ frame_size int 32 regular  }
	{ dstin int 64 regular  }
	{ alpha int 8 regular  }
	{ dstout int 64 regular  }
	{ mapchip_draw_xsize_out int 32 regular {fifo 1}  }
	{ mapchip_draw_xsize_out1 int 32 regular {fifo 1}  }
	{ mapchip_maxwidth_out int 32 regular {fifo 1}  }
	{ d_out int 20 regular {fifo 1}  }
	{ a_out int 20 regular {fifo 1}  }
	{ c_out int 20 regular {fifo 1}  }
	{ b_out int 20 regular {fifo 1}  }
	{ m_out int 32 regular {fifo 1}  }
	{ trunc_ln1345_out int 32 regular {fifo 1}  }
	{ trunc_ln1345_out2 int 32 regular {fifo 1}  }
	{ mapchip_maxheight_out int 32 regular {fifo 1}  }
	{ n_out int 32 regular {fifo 1}  }
	{ id_out int 32 regular {fifo 1}  }
	{ ystart_pos_out int 32 regular {fifo 1}  }
	{ xstart_pos_out int 32 regular {fifo 1}  }
	{ srcin_out int 64 regular {fifo 1}  }
	{ frame_size_out int 32 regular {fifo 1}  }
	{ frame_size_out3 int 32 regular {fifo 1}  }
	{ dstin_out int 64 regular {fifo 1}  }
	{ alpha_out int 8 regular {fifo 1}  }
	{ dstout_out int 64 regular {fifo 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "mapchip_draw_xsize", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_maxwidth", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "d", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "a", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "c", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "b", "interface" : "wire", "bitwidth" : 20, "direction" : "READONLY"} , 
 	{ "Name" : "m", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "trunc_ln1345", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_maxheight", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "n", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "id", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ystart_pos", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "xstart_pos", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "srcin", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "frame_size", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "dstin", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "alpha", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "dstout", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_draw_xsize_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mapchip_draw_xsize_out1", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mapchip_maxwidth_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "d_out", "interface" : "fifo", "bitwidth" : 20, "direction" : "WRITEONLY"} , 
 	{ "Name" : "a_out", "interface" : "fifo", "bitwidth" : 20, "direction" : "WRITEONLY"} , 
 	{ "Name" : "c_out", "interface" : "fifo", "bitwidth" : 20, "direction" : "WRITEONLY"} , 
 	{ "Name" : "b_out", "interface" : "fifo", "bitwidth" : 20, "direction" : "WRITEONLY"} , 
 	{ "Name" : "m_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "trunc_ln1345_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "trunc_ln1345_out2", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mapchip_maxheight_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "n_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "id_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ystart_pos_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "xstart_pos_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "srcin_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "frame_size_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "frame_size_out3", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dstin_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "alpha_out", "interface" : "fifo", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dstout_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 88
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ mapchip_draw_xsize sc_in sc_lv 32 signal 0 } 
	{ mapchip_maxwidth sc_in sc_lv 32 signal 1 } 
	{ d sc_in sc_lv 20 signal 2 } 
	{ a sc_in sc_lv 20 signal 3 } 
	{ c sc_in sc_lv 20 signal 4 } 
	{ b sc_in sc_lv 20 signal 5 } 
	{ m sc_in sc_lv 32 signal 6 } 
	{ trunc_ln1345 sc_in sc_lv 32 signal 7 } 
	{ mapchip_maxheight sc_in sc_lv 32 signal 8 } 
	{ n sc_in sc_lv 32 signal 9 } 
	{ id sc_in sc_lv 32 signal 10 } 
	{ ystart_pos sc_in sc_lv 32 signal 11 } 
	{ xstart_pos sc_in sc_lv 32 signal 12 } 
	{ srcin sc_in sc_lv 64 signal 13 } 
	{ frame_size sc_in sc_lv 32 signal 14 } 
	{ dstin sc_in sc_lv 64 signal 15 } 
	{ alpha sc_in sc_lv 8 signal 16 } 
	{ dstout sc_in sc_lv 64 signal 17 } 
	{ mapchip_draw_xsize_out_din sc_out sc_lv 32 signal 18 } 
	{ mapchip_draw_xsize_out_full_n sc_in sc_logic 1 signal 18 } 
	{ mapchip_draw_xsize_out_write sc_out sc_logic 1 signal 18 } 
	{ mapchip_draw_xsize_out1_din sc_out sc_lv 32 signal 19 } 
	{ mapchip_draw_xsize_out1_full_n sc_in sc_logic 1 signal 19 } 
	{ mapchip_draw_xsize_out1_write sc_out sc_logic 1 signal 19 } 
	{ mapchip_maxwidth_out_din sc_out sc_lv 32 signal 20 } 
	{ mapchip_maxwidth_out_full_n sc_in sc_logic 1 signal 20 } 
	{ mapchip_maxwidth_out_write sc_out sc_logic 1 signal 20 } 
	{ d_out_din sc_out sc_lv 20 signal 21 } 
	{ d_out_full_n sc_in sc_logic 1 signal 21 } 
	{ d_out_write sc_out sc_logic 1 signal 21 } 
	{ a_out_din sc_out sc_lv 20 signal 22 } 
	{ a_out_full_n sc_in sc_logic 1 signal 22 } 
	{ a_out_write sc_out sc_logic 1 signal 22 } 
	{ c_out_din sc_out sc_lv 20 signal 23 } 
	{ c_out_full_n sc_in sc_logic 1 signal 23 } 
	{ c_out_write sc_out sc_logic 1 signal 23 } 
	{ b_out_din sc_out sc_lv 20 signal 24 } 
	{ b_out_full_n sc_in sc_logic 1 signal 24 } 
	{ b_out_write sc_out sc_logic 1 signal 24 } 
	{ m_out_din sc_out sc_lv 32 signal 25 } 
	{ m_out_full_n sc_in sc_logic 1 signal 25 } 
	{ m_out_write sc_out sc_logic 1 signal 25 } 
	{ trunc_ln1345_out_din sc_out sc_lv 32 signal 26 } 
	{ trunc_ln1345_out_full_n sc_in sc_logic 1 signal 26 } 
	{ trunc_ln1345_out_write sc_out sc_logic 1 signal 26 } 
	{ trunc_ln1345_out2_din sc_out sc_lv 32 signal 27 } 
	{ trunc_ln1345_out2_full_n sc_in sc_logic 1 signal 27 } 
	{ trunc_ln1345_out2_write sc_out sc_logic 1 signal 27 } 
	{ mapchip_maxheight_out_din sc_out sc_lv 32 signal 28 } 
	{ mapchip_maxheight_out_full_n sc_in sc_logic 1 signal 28 } 
	{ mapchip_maxheight_out_write sc_out sc_logic 1 signal 28 } 
	{ n_out_din sc_out sc_lv 32 signal 29 } 
	{ n_out_full_n sc_in sc_logic 1 signal 29 } 
	{ n_out_write sc_out sc_logic 1 signal 29 } 
	{ id_out_din sc_out sc_lv 32 signal 30 } 
	{ id_out_full_n sc_in sc_logic 1 signal 30 } 
	{ id_out_write sc_out sc_logic 1 signal 30 } 
	{ ystart_pos_out_din sc_out sc_lv 32 signal 31 } 
	{ ystart_pos_out_full_n sc_in sc_logic 1 signal 31 } 
	{ ystart_pos_out_write sc_out sc_logic 1 signal 31 } 
	{ xstart_pos_out_din sc_out sc_lv 32 signal 32 } 
	{ xstart_pos_out_full_n sc_in sc_logic 1 signal 32 } 
	{ xstart_pos_out_write sc_out sc_logic 1 signal 32 } 
	{ srcin_out_din sc_out sc_lv 64 signal 33 } 
	{ srcin_out_full_n sc_in sc_logic 1 signal 33 } 
	{ srcin_out_write sc_out sc_logic 1 signal 33 } 
	{ frame_size_out_din sc_out sc_lv 32 signal 34 } 
	{ frame_size_out_full_n sc_in sc_logic 1 signal 34 } 
	{ frame_size_out_write sc_out sc_logic 1 signal 34 } 
	{ frame_size_out3_din sc_out sc_lv 32 signal 35 } 
	{ frame_size_out3_full_n sc_in sc_logic 1 signal 35 } 
	{ frame_size_out3_write sc_out sc_logic 1 signal 35 } 
	{ dstin_out_din sc_out sc_lv 64 signal 36 } 
	{ dstin_out_full_n sc_in sc_logic 1 signal 36 } 
	{ dstin_out_write sc_out sc_logic 1 signal 36 } 
	{ alpha_out_din sc_out sc_lv 8 signal 37 } 
	{ alpha_out_full_n sc_in sc_logic 1 signal 37 } 
	{ alpha_out_write sc_out sc_logic 1 signal 37 } 
	{ dstout_out_din sc_out sc_lv 64 signal 38 } 
	{ dstout_out_full_n sc_in sc_logic 1 signal 38 } 
	{ dstout_out_write sc_out sc_logic 1 signal 38 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "mapchip_draw_xsize", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_draw_xsize", "role": "default" }} , 
 	{ "name": "mapchip_maxwidth", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxwidth", "role": "default" }} , 
 	{ "name": "d", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "d", "role": "default" }} , 
 	{ "name": "a", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "a", "role": "default" }} , 
 	{ "name": "c", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "c", "role": "default" }} , 
 	{ "name": "b", "direction": "in", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "b", "role": "default" }} , 
 	{ "name": "m", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "m", "role": "default" }} , 
 	{ "name": "trunc_ln1345", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "trunc_ln1345", "role": "default" }} , 
 	{ "name": "mapchip_maxheight", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxheight", "role": "default" }} , 
 	{ "name": "n", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "n", "role": "default" }} , 
 	{ "name": "id", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "id", "role": "default" }} , 
 	{ "name": "ystart_pos", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ystart_pos", "role": "default" }} , 
 	{ "name": "xstart_pos", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "xstart_pos", "role": "default" }} , 
 	{ "name": "srcin", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "srcin", "role": "default" }} , 
 	{ "name": "frame_size", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size", "role": "default" }} , 
 	{ "name": "dstin", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstin", "role": "default" }} , 
 	{ "name": "alpha", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "alpha", "role": "default" }} , 
 	{ "name": "dstout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstout", "role": "default" }} , 
 	{ "name": "mapchip_draw_xsize_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "din" }} , 
 	{ "name": "mapchip_draw_xsize_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "full_n" }} , 
 	{ "name": "mapchip_draw_xsize_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "write" }} , 
 	{ "name": "mapchip_draw_xsize_out1_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out1", "role": "din" }} , 
 	{ "name": "mapchip_draw_xsize_out1_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out1", "role": "full_n" }} , 
 	{ "name": "mapchip_draw_xsize_out1_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out1", "role": "write" }} , 
 	{ "name": "mapchip_maxwidth_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxwidth_out", "role": "din" }} , 
 	{ "name": "mapchip_maxwidth_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxwidth_out", "role": "full_n" }} , 
 	{ "name": "mapchip_maxwidth_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxwidth_out", "role": "write" }} , 
 	{ "name": "d_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "d_out", "role": "din" }} , 
 	{ "name": "d_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_out", "role": "full_n" }} , 
 	{ "name": "d_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "d_out", "role": "write" }} , 
 	{ "name": "a_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "a_out", "role": "din" }} , 
 	{ "name": "a_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_out", "role": "full_n" }} , 
 	{ "name": "a_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "a_out", "role": "write" }} , 
 	{ "name": "c_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "c_out", "role": "din" }} , 
 	{ "name": "c_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_out", "role": "full_n" }} , 
 	{ "name": "c_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "c_out", "role": "write" }} , 
 	{ "name": "b_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":20, "type": "signal", "bundle":{"name": "b_out", "role": "din" }} , 
 	{ "name": "b_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_out", "role": "full_n" }} , 
 	{ "name": "b_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "b_out", "role": "write" }} , 
 	{ "name": "m_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "m_out", "role": "din" }} , 
 	{ "name": "m_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "m_out", "role": "full_n" }} , 
 	{ "name": "m_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "m_out", "role": "write" }} , 
 	{ "name": "trunc_ln1345_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "trunc_ln1345_out", "role": "din" }} , 
 	{ "name": "trunc_ln1345_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "trunc_ln1345_out", "role": "full_n" }} , 
 	{ "name": "trunc_ln1345_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "trunc_ln1345_out", "role": "write" }} , 
 	{ "name": "trunc_ln1345_out2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "trunc_ln1345_out2", "role": "din" }} , 
 	{ "name": "trunc_ln1345_out2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "trunc_ln1345_out2", "role": "full_n" }} , 
 	{ "name": "trunc_ln1345_out2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "trunc_ln1345_out2", "role": "write" }} , 
 	{ "name": "mapchip_maxheight_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxheight_out", "role": "din" }} , 
 	{ "name": "mapchip_maxheight_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxheight_out", "role": "full_n" }} , 
 	{ "name": "mapchip_maxheight_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxheight_out", "role": "write" }} , 
 	{ "name": "n_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "n_out", "role": "din" }} , 
 	{ "name": "n_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "n_out", "role": "full_n" }} , 
 	{ "name": "n_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "n_out", "role": "write" }} , 
 	{ "name": "id_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "id_out", "role": "din" }} , 
 	{ "name": "id_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "id_out", "role": "full_n" }} , 
 	{ "name": "id_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "id_out", "role": "write" }} , 
 	{ "name": "ystart_pos_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ystart_pos_out", "role": "din" }} , 
 	{ "name": "ystart_pos_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ystart_pos_out", "role": "full_n" }} , 
 	{ "name": "ystart_pos_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ystart_pos_out", "role": "write" }} , 
 	{ "name": "xstart_pos_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "xstart_pos_out", "role": "din" }} , 
 	{ "name": "xstart_pos_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xstart_pos_out", "role": "full_n" }} , 
 	{ "name": "xstart_pos_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xstart_pos_out", "role": "write" }} , 
 	{ "name": "srcin_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "srcin_out", "role": "din" }} , 
 	{ "name": "srcin_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcin_out", "role": "full_n" }} , 
 	{ "name": "srcin_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcin_out", "role": "write" }} , 
 	{ "name": "frame_size_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size_out", "role": "din" }} , 
 	{ "name": "frame_size_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size_out", "role": "full_n" }} , 
 	{ "name": "frame_size_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size_out", "role": "write" }} , 
 	{ "name": "frame_size_out3_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size_out3", "role": "din" }} , 
 	{ "name": "frame_size_out3_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size_out3", "role": "full_n" }} , 
 	{ "name": "frame_size_out3_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size_out3", "role": "write" }} , 
 	{ "name": "dstin_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstin_out", "role": "din" }} , 
 	{ "name": "dstin_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstin_out", "role": "full_n" }} , 
 	{ "name": "dstin_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstin_out", "role": "write" }} , 
 	{ "name": "alpha_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "alpha_out", "role": "din" }} , 
 	{ "name": "alpha_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha_out", "role": "full_n" }} , 
 	{ "name": "alpha_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha_out", "role": "write" }} , 
 	{ "name": "dstout_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstout_out", "role": "din" }} , 
 	{ "name": "dstout_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstout_out", "role": "full_n" }} , 
 	{ "name": "dstout_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstout_out", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
		"CDFG" : "dataflow_in_loop_height_loop_entry6",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "0", "EstimateLatencyMin" : "0", "EstimateLatencyMax" : "0",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mapchip_draw_xsize", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxwidth", "Type" : "None", "Direction" : "I"},
			{"Name" : "d", "Type" : "None", "Direction" : "I"},
			{"Name" : "a", "Type" : "None", "Direction" : "I"},
			{"Name" : "c", "Type" : "None", "Direction" : "I"},
			{"Name" : "b", "Type" : "None", "Direction" : "I"},
			{"Name" : "m", "Type" : "None", "Direction" : "I"},
			{"Name" : "trunc_ln1345", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxheight", "Type" : "None", "Direction" : "I"},
			{"Name" : "n", "Type" : "None", "Direction" : "I"},
			{"Name" : "id", "Type" : "None", "Direction" : "I"},
			{"Name" : "ystart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "xstart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "srcin", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstin", "Type" : "None", "Direction" : "I"},
			{"Name" : "alpha", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstout", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_draw_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_draw_xsize_out1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxwidth_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxwidth_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "d_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "d_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "a_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "a_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "c_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "c_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "b_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "b_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "m_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "m_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345_out2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_out2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxheight_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxheight_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "n_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "n_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "id_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "id_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ystart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ystart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xstart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xstart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "srcin_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "srcin_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstin_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstin_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "alpha_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "alpha_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstout_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstout_out_blk_n", "Type" : "RtlSignal"}]}]}]}


set ArgLastReadFirstWriteLatency {
	dataflow_in_loop_height_loop_entry6 {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		mapchip_maxwidth {Type I LastRead 0 FirstWrite -1}
		d {Type I LastRead 0 FirstWrite -1}
		a {Type I LastRead 0 FirstWrite -1}
		c {Type I LastRead 0 FirstWrite -1}
		b {Type I LastRead 0 FirstWrite -1}
		m {Type I LastRead 0 FirstWrite -1}
		trunc_ln1345 {Type I LastRead 0 FirstWrite -1}
		mapchip_maxheight {Type I LastRead 0 FirstWrite -1}
		n {Type I LastRead 0 FirstWrite -1}
		id {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}
		mapchip_draw_xsize_out {Type O LastRead -1 FirstWrite 0}
		mapchip_draw_xsize_out1 {Type O LastRead -1 FirstWrite 0}
		mapchip_maxwidth_out {Type O LastRead -1 FirstWrite 0}
		d_out {Type O LastRead -1 FirstWrite 0}
		a_out {Type O LastRead -1 FirstWrite 0}
		c_out {Type O LastRead -1 FirstWrite 0}
		b_out {Type O LastRead -1 FirstWrite 0}
		m_out {Type O LastRead -1 FirstWrite 0}
		trunc_ln1345_out {Type O LastRead -1 FirstWrite 0}
		trunc_ln1345_out2 {Type O LastRead -1 FirstWrite 0}
		mapchip_maxheight_out {Type O LastRead -1 FirstWrite 0}
		n_out {Type O LastRead -1 FirstWrite 0}
		id_out {Type O LastRead -1 FirstWrite 0}
		ystart_pos_out {Type O LastRead -1 FirstWrite 0}
		xstart_pos_out {Type O LastRead -1 FirstWrite 0}
		srcin_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out3 {Type O LastRead -1 FirstWrite 0}
		dstin_out {Type O LastRead -1 FirstWrite 0}
		alpha_out {Type O LastRead -1 FirstWrite 0}
		dstout_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	mapchip_draw_xsize { ap_none {  { mapchip_draw_xsize in_data 0 32 } } }
	mapchip_maxwidth { ap_none {  { mapchip_maxwidth in_data 0 32 } } }
	d { ap_none {  { d in_data 0 20 } } }
	a { ap_none {  { a in_data 0 20 } } }
	c { ap_none {  { c in_data 0 20 } } }
	b { ap_none {  { b in_data 0 20 } } }
	m { ap_none {  { m in_data 0 32 } } }
	trunc_ln1345 { ap_none {  { trunc_ln1345 in_data 0 32 } } }
	mapchip_maxheight { ap_none {  { mapchip_maxheight in_data 0 32 } } }
	n { ap_none {  { n in_data 0 32 } } }
	id { ap_none {  { id in_data 0 32 } } }
	ystart_pos { ap_none {  { ystart_pos in_data 0 32 } } }
	xstart_pos { ap_none {  { xstart_pos in_data 0 32 } } }
	srcin { ap_none {  { srcin in_data 0 64 } } }
	frame_size { ap_none {  { frame_size in_data 0 32 } } }
	dstin { ap_none {  { dstin in_data 0 64 } } }
	alpha { ap_none {  { alpha in_data 0 8 } } }
	dstout { ap_none {  { dstout in_data 0 64 } } }
	mapchip_draw_xsize_out { ap_fifo {  { mapchip_draw_xsize_out_din fifo_data 1 32 }  { mapchip_draw_xsize_out_full_n fifo_status 0 1 }  { mapchip_draw_xsize_out_write fifo_update 1 1 } } }
	mapchip_draw_xsize_out1 { ap_fifo {  { mapchip_draw_xsize_out1_din fifo_data 1 32 }  { mapchip_draw_xsize_out1_full_n fifo_status 0 1 }  { mapchip_draw_xsize_out1_write fifo_update 1 1 } } }
	mapchip_maxwidth_out { ap_fifo {  { mapchip_maxwidth_out_din fifo_data 1 32 }  { mapchip_maxwidth_out_full_n fifo_status 0 1 }  { mapchip_maxwidth_out_write fifo_update 1 1 } } }
	d_out { ap_fifo {  { d_out_din fifo_data 1 20 }  { d_out_full_n fifo_status 0 1 }  { d_out_write fifo_update 1 1 } } }
	a_out { ap_fifo {  { a_out_din fifo_data 1 20 }  { a_out_full_n fifo_status 0 1 }  { a_out_write fifo_update 1 1 } } }
	c_out { ap_fifo {  { c_out_din fifo_data 1 20 }  { c_out_full_n fifo_status 0 1 }  { c_out_write fifo_update 1 1 } } }
	b_out { ap_fifo {  { b_out_din fifo_data 1 20 }  { b_out_full_n fifo_status 0 1 }  { b_out_write fifo_update 1 1 } } }
	m_out { ap_fifo {  { m_out_din fifo_data 1 32 }  { m_out_full_n fifo_status 0 1 }  { m_out_write fifo_update 1 1 } } }
	trunc_ln1345_out { ap_fifo {  { trunc_ln1345_out_din fifo_data 1 32 }  { trunc_ln1345_out_full_n fifo_status 0 1 }  { trunc_ln1345_out_write fifo_update 1 1 } } }
	trunc_ln1345_out2 { ap_fifo {  { trunc_ln1345_out2_din fifo_data 1 32 }  { trunc_ln1345_out2_full_n fifo_status 0 1 }  { trunc_ln1345_out2_write fifo_update 1 1 } } }
	mapchip_maxheight_out { ap_fifo {  { mapchip_maxheight_out_din fifo_data 1 32 }  { mapchip_maxheight_out_full_n fifo_status 0 1 }  { mapchip_maxheight_out_write fifo_update 1 1 } } }
	n_out { ap_fifo {  { n_out_din fifo_data 1 32 }  { n_out_full_n fifo_status 0 1 }  { n_out_write fifo_update 1 1 } } }
	id_out { ap_fifo {  { id_out_din fifo_data 1 32 }  { id_out_full_n fifo_status 0 1 }  { id_out_write fifo_update 1 1 } } }
	ystart_pos_out { ap_fifo {  { ystart_pos_out_din fifo_data 1 32 }  { ystart_pos_out_full_n fifo_status 0 1 }  { ystart_pos_out_write fifo_update 1 1 } } }
	xstart_pos_out { ap_fifo {  { xstart_pos_out_din fifo_data 1 32 }  { xstart_pos_out_full_n fifo_status 0 1 }  { xstart_pos_out_write fifo_update 1 1 } } }
	srcin_out { ap_fifo {  { srcin_out_din fifo_data 1 64 }  { srcin_out_full_n fifo_status 0 1 }  { srcin_out_write fifo_update 1 1 } } }
	frame_size_out { ap_fifo {  { frame_size_out_din fifo_data 1 32 }  { frame_size_out_full_n fifo_status 0 1 }  { frame_size_out_write fifo_update 1 1 } } }
	frame_size_out3 { ap_fifo {  { frame_size_out3_din fifo_data 1 32 }  { frame_size_out3_full_n fifo_status 0 1 }  { frame_size_out3_write fifo_update 1 1 } } }
	dstin_out { ap_fifo {  { dstin_out_din fifo_data 1 64 }  { dstin_out_full_n fifo_status 0 1 }  { dstin_out_write fifo_update 1 1 } } }
	alpha_out { ap_fifo {  { alpha_out_din fifo_data 1 8 }  { alpha_out_full_n fifo_status 0 1 }  { alpha_out_write fifo_update 1 1 } } }
	dstout_out { ap_fifo {  { dstout_out_din fifo_data 1 64 }  { dstout_out_full_n fifo_status 0 1 }  { dstout_out_write fifo_update 1 1 } } }
}
