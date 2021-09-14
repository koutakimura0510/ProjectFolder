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
	{ id int 32 regular  }
	{ mapchip_maxheight int 32 regular  }
	{ ystart_pos int 32 regular  }
	{ mapchip_maxwidth int 32 regular  }
	{ xstart_pos int 32 regular  }
	{ y int 32 regular  }
	{ srcin int 64 regular  }
	{ frame_size int 32 regular  }
	{ dstin int 64 regular  }
	{ dstout int 64 regular  }
	{ crip int 24 regular  }
	{ alpha int 8 regular  }
	{ mapchip_draw_xsize_out int 32 regular {fifo 1}  }
	{ mapchip_draw_xsize_out1 int 32 regular {fifo 1}  }
	{ id_out int 32 regular {fifo 1}  }
	{ mapchip_maxheight_out int 32 regular {fifo 1}  }
	{ ystart_pos_out int 32 regular {fifo 1}  }
	{ mapchip_maxwidth_out int 32 regular {fifo 1}  }
	{ xstart_pos_out int 32 regular {fifo 1}  }
	{ y_out int 32 regular {fifo 1}  }
	{ y_out2 int 32 regular {fifo 1}  }
	{ srcin_out int 64 regular {fifo 1}  }
	{ frame_size_out int 32 regular {fifo 1}  }
	{ frame_size_out3 int 32 regular {fifo 1}  }
	{ dstin_out int 64 regular {fifo 1}  }
	{ dstout_out int 64 regular {fifo 1}  }
	{ crip_out int 24 regular {fifo 1}  }
	{ alpha_out int 8 regular {fifo 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "mapchip_draw_xsize", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "id", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_maxheight", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ystart_pos", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_maxwidth", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "xstart_pos", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "srcin", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "frame_size", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "dstin", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "dstout", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "crip", "interface" : "wire", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "alpha", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_draw_xsize_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mapchip_draw_xsize_out1", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "id_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mapchip_maxheight_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ystart_pos_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mapchip_maxwidth_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "xstart_pos_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "y_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "y_out2", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "srcin_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "frame_size_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "frame_size_out3", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dstin_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "dstout_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "crip_out", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} , 
 	{ "Name" : "alpha_out", "interface" : "fifo", "bitwidth" : 8, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 68
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ mapchip_draw_xsize sc_in sc_lv 32 signal 0 } 
	{ id sc_in sc_lv 32 signal 1 } 
	{ mapchip_maxheight sc_in sc_lv 32 signal 2 } 
	{ ystart_pos sc_in sc_lv 32 signal 3 } 
	{ mapchip_maxwidth sc_in sc_lv 32 signal 4 } 
	{ xstart_pos sc_in sc_lv 32 signal 5 } 
	{ y sc_in sc_lv 32 signal 6 } 
	{ srcin sc_in sc_lv 64 signal 7 } 
	{ frame_size sc_in sc_lv 32 signal 8 } 
	{ dstin sc_in sc_lv 64 signal 9 } 
	{ dstout sc_in sc_lv 64 signal 10 } 
	{ crip sc_in sc_lv 24 signal 11 } 
	{ alpha sc_in sc_lv 8 signal 12 } 
	{ mapchip_draw_xsize_out_din sc_out sc_lv 32 signal 13 } 
	{ mapchip_draw_xsize_out_full_n sc_in sc_logic 1 signal 13 } 
	{ mapchip_draw_xsize_out_write sc_out sc_logic 1 signal 13 } 
	{ mapchip_draw_xsize_out1_din sc_out sc_lv 32 signal 14 } 
	{ mapchip_draw_xsize_out1_full_n sc_in sc_logic 1 signal 14 } 
	{ mapchip_draw_xsize_out1_write sc_out sc_logic 1 signal 14 } 
	{ id_out_din sc_out sc_lv 32 signal 15 } 
	{ id_out_full_n sc_in sc_logic 1 signal 15 } 
	{ id_out_write sc_out sc_logic 1 signal 15 } 
	{ mapchip_maxheight_out_din sc_out sc_lv 32 signal 16 } 
	{ mapchip_maxheight_out_full_n sc_in sc_logic 1 signal 16 } 
	{ mapchip_maxheight_out_write sc_out sc_logic 1 signal 16 } 
	{ ystart_pos_out_din sc_out sc_lv 32 signal 17 } 
	{ ystart_pos_out_full_n sc_in sc_logic 1 signal 17 } 
	{ ystart_pos_out_write sc_out sc_logic 1 signal 17 } 
	{ mapchip_maxwidth_out_din sc_out sc_lv 32 signal 18 } 
	{ mapchip_maxwidth_out_full_n sc_in sc_logic 1 signal 18 } 
	{ mapchip_maxwidth_out_write sc_out sc_logic 1 signal 18 } 
	{ xstart_pos_out_din sc_out sc_lv 32 signal 19 } 
	{ xstart_pos_out_full_n sc_in sc_logic 1 signal 19 } 
	{ xstart_pos_out_write sc_out sc_logic 1 signal 19 } 
	{ y_out_din sc_out sc_lv 32 signal 20 } 
	{ y_out_full_n sc_in sc_logic 1 signal 20 } 
	{ y_out_write sc_out sc_logic 1 signal 20 } 
	{ y_out2_din sc_out sc_lv 32 signal 21 } 
	{ y_out2_full_n sc_in sc_logic 1 signal 21 } 
	{ y_out2_write sc_out sc_logic 1 signal 21 } 
	{ srcin_out_din sc_out sc_lv 64 signal 22 } 
	{ srcin_out_full_n sc_in sc_logic 1 signal 22 } 
	{ srcin_out_write sc_out sc_logic 1 signal 22 } 
	{ frame_size_out_din sc_out sc_lv 32 signal 23 } 
	{ frame_size_out_full_n sc_in sc_logic 1 signal 23 } 
	{ frame_size_out_write sc_out sc_logic 1 signal 23 } 
	{ frame_size_out3_din sc_out sc_lv 32 signal 24 } 
	{ frame_size_out3_full_n sc_in sc_logic 1 signal 24 } 
	{ frame_size_out3_write sc_out sc_logic 1 signal 24 } 
	{ dstin_out_din sc_out sc_lv 64 signal 25 } 
	{ dstin_out_full_n sc_in sc_logic 1 signal 25 } 
	{ dstin_out_write sc_out sc_logic 1 signal 25 } 
	{ dstout_out_din sc_out sc_lv 64 signal 26 } 
	{ dstout_out_full_n sc_in sc_logic 1 signal 26 } 
	{ dstout_out_write sc_out sc_logic 1 signal 26 } 
	{ crip_out_din sc_out sc_lv 24 signal 27 } 
	{ crip_out_full_n sc_in sc_logic 1 signal 27 } 
	{ crip_out_write sc_out sc_logic 1 signal 27 } 
	{ alpha_out_din sc_out sc_lv 8 signal 28 } 
	{ alpha_out_full_n sc_in sc_logic 1 signal 28 } 
	{ alpha_out_write sc_out sc_logic 1 signal 28 } 
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
 	{ "name": "id", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "id", "role": "default" }} , 
 	{ "name": "mapchip_maxheight", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxheight", "role": "default" }} , 
 	{ "name": "ystart_pos", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ystart_pos", "role": "default" }} , 
 	{ "name": "mapchip_maxwidth", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxwidth", "role": "default" }} , 
 	{ "name": "xstart_pos", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "xstart_pos", "role": "default" }} , 
 	{ "name": "y", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y", "role": "default" }} , 
 	{ "name": "srcin", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "srcin", "role": "default" }} , 
 	{ "name": "frame_size", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size", "role": "default" }} , 
 	{ "name": "dstin", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstin", "role": "default" }} , 
 	{ "name": "dstout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstout", "role": "default" }} , 
 	{ "name": "crip", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "crip", "role": "default" }} , 
 	{ "name": "alpha", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "alpha", "role": "default" }} , 
 	{ "name": "mapchip_draw_xsize_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "din" }} , 
 	{ "name": "mapchip_draw_xsize_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "full_n" }} , 
 	{ "name": "mapchip_draw_xsize_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "write" }} , 
 	{ "name": "mapchip_draw_xsize_out1_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out1", "role": "din" }} , 
 	{ "name": "mapchip_draw_xsize_out1_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out1", "role": "full_n" }} , 
 	{ "name": "mapchip_draw_xsize_out1_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out1", "role": "write" }} , 
 	{ "name": "id_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "id_out", "role": "din" }} , 
 	{ "name": "id_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "id_out", "role": "full_n" }} , 
 	{ "name": "id_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "id_out", "role": "write" }} , 
 	{ "name": "mapchip_maxheight_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxheight_out", "role": "din" }} , 
 	{ "name": "mapchip_maxheight_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxheight_out", "role": "full_n" }} , 
 	{ "name": "mapchip_maxheight_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxheight_out", "role": "write" }} , 
 	{ "name": "ystart_pos_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ystart_pos_out", "role": "din" }} , 
 	{ "name": "ystart_pos_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ystart_pos_out", "role": "full_n" }} , 
 	{ "name": "ystart_pos_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ystart_pos_out", "role": "write" }} , 
 	{ "name": "mapchip_maxwidth_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxwidth_out", "role": "din" }} , 
 	{ "name": "mapchip_maxwidth_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxwidth_out", "role": "full_n" }} , 
 	{ "name": "mapchip_maxwidth_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxwidth_out", "role": "write" }} , 
 	{ "name": "xstart_pos_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "xstart_pos_out", "role": "din" }} , 
 	{ "name": "xstart_pos_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xstart_pos_out", "role": "full_n" }} , 
 	{ "name": "xstart_pos_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xstart_pos_out", "role": "write" }} , 
 	{ "name": "y_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_out", "role": "din" }} , 
 	{ "name": "y_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out", "role": "full_n" }} , 
 	{ "name": "y_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out", "role": "write" }} , 
 	{ "name": "y_out2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_out2", "role": "din" }} , 
 	{ "name": "y_out2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out2", "role": "full_n" }} , 
 	{ "name": "y_out2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out2", "role": "write" }} , 
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
 	{ "name": "dstout_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstout_out", "role": "din" }} , 
 	{ "name": "dstout_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstout_out", "role": "full_n" }} , 
 	{ "name": "dstout_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstout_out", "role": "write" }} , 
 	{ "name": "crip_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "crip_out", "role": "din" }} , 
 	{ "name": "crip_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "crip_out", "role": "full_n" }} , 
 	{ "name": "crip_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "crip_out", "role": "write" }} , 
 	{ "name": "alpha_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "alpha_out", "role": "din" }} , 
 	{ "name": "alpha_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha_out", "role": "full_n" }} , 
 	{ "name": "alpha_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha_out", "role": "write" }}  ]}

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
			{"Name" : "id", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxheight", "Type" : "None", "Direction" : "I"},
			{"Name" : "ystart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxwidth", "Type" : "None", "Direction" : "I"},
			{"Name" : "xstart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "y", "Type" : "None", "Direction" : "I"},
			{"Name" : "srcin", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstin", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstout", "Type" : "None", "Direction" : "I"},
			{"Name" : "crip", "Type" : "None", "Direction" : "I"},
			{"Name" : "alpha", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_draw_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_draw_xsize_out1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "id_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "id_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxheight_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxheight_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ystart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ystart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxwidth_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxwidth_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xstart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xstart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out2_blk_n", "Type" : "RtlSignal"}]},
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
			{"Name" : "dstout_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstout_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "crip_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "crip_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "alpha_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "alpha_out_blk_n", "Type" : "RtlSignal"}]}]}]}


set ArgLastReadFirstWriteLatency {
	dataflow_in_loop_height_loop_entry6 {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		id {Type I LastRead 0 FirstWrite -1}
		mapchip_maxheight {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		mapchip_maxwidth {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}
		crip {Type I LastRead 0 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		mapchip_draw_xsize_out {Type O LastRead -1 FirstWrite 0}
		mapchip_draw_xsize_out1 {Type O LastRead -1 FirstWrite 0}
		id_out {Type O LastRead -1 FirstWrite 0}
		mapchip_maxheight_out {Type O LastRead -1 FirstWrite 0}
		ystart_pos_out {Type O LastRead -1 FirstWrite 0}
		mapchip_maxwidth_out {Type O LastRead -1 FirstWrite 0}
		xstart_pos_out {Type O LastRead -1 FirstWrite 0}
		y_out {Type O LastRead -1 FirstWrite 0}
		y_out2 {Type O LastRead -1 FirstWrite 0}
		srcin_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out3 {Type O LastRead -1 FirstWrite 0}
		dstin_out {Type O LastRead -1 FirstWrite 0}
		dstout_out {Type O LastRead -1 FirstWrite 0}
		crip_out {Type O LastRead -1 FirstWrite 0}
		alpha_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "0", "Max" : "0"}
	, {"Name" : "Interval", "Min" : "0", "Max" : "0"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	mapchip_draw_xsize { ap_none {  { mapchip_draw_xsize in_data 0 32 } } }
	id { ap_none {  { id in_data 0 32 } } }
	mapchip_maxheight { ap_none {  { mapchip_maxheight in_data 0 32 } } }
	ystart_pos { ap_none {  { ystart_pos in_data 0 32 } } }
	mapchip_maxwidth { ap_none {  { mapchip_maxwidth in_data 0 32 } } }
	xstart_pos { ap_none {  { xstart_pos in_data 0 32 } } }
	y { ap_none {  { y in_data 0 32 } } }
	srcin { ap_none {  { srcin in_data 0 64 } } }
	frame_size { ap_none {  { frame_size in_data 0 32 } } }
	dstin { ap_none {  { dstin in_data 0 64 } } }
	dstout { ap_none {  { dstout in_data 0 64 } } }
	crip { ap_none {  { crip in_data 0 24 } } }
	alpha { ap_none {  { alpha in_data 0 8 } } }
	mapchip_draw_xsize_out { ap_fifo {  { mapchip_draw_xsize_out_din fifo_data 1 32 }  { mapchip_draw_xsize_out_full_n fifo_status 0 1 }  { mapchip_draw_xsize_out_write fifo_update 1 1 } } }
	mapchip_draw_xsize_out1 { ap_fifo {  { mapchip_draw_xsize_out1_din fifo_data 1 32 }  { mapchip_draw_xsize_out1_full_n fifo_status 0 1 }  { mapchip_draw_xsize_out1_write fifo_update 1 1 } } }
	id_out { ap_fifo {  { id_out_din fifo_data 1 32 }  { id_out_full_n fifo_status 0 1 }  { id_out_write fifo_update 1 1 } } }
	mapchip_maxheight_out { ap_fifo {  { mapchip_maxheight_out_din fifo_data 1 32 }  { mapchip_maxheight_out_full_n fifo_status 0 1 }  { mapchip_maxheight_out_write fifo_update 1 1 } } }
	ystart_pos_out { ap_fifo {  { ystart_pos_out_din fifo_data 1 32 }  { ystart_pos_out_full_n fifo_status 0 1 }  { ystart_pos_out_write fifo_update 1 1 } } }
	mapchip_maxwidth_out { ap_fifo {  { mapchip_maxwidth_out_din fifo_data 1 32 }  { mapchip_maxwidth_out_full_n fifo_status 0 1 }  { mapchip_maxwidth_out_write fifo_update 1 1 } } }
	xstart_pos_out { ap_fifo {  { xstart_pos_out_din fifo_data 1 32 }  { xstart_pos_out_full_n fifo_status 0 1 }  { xstart_pos_out_write fifo_update 1 1 } } }
	y_out { ap_fifo {  { y_out_din fifo_data 1 32 }  { y_out_full_n fifo_status 0 1 }  { y_out_write fifo_update 1 1 } } }
	y_out2 { ap_fifo {  { y_out2_din fifo_data 1 32 }  { y_out2_full_n fifo_status 0 1 }  { y_out2_write fifo_update 1 1 } } }
	srcin_out { ap_fifo {  { srcin_out_din fifo_data 1 64 }  { srcin_out_full_n fifo_status 0 1 }  { srcin_out_write fifo_update 1 1 } } }
	frame_size_out { ap_fifo {  { frame_size_out_din fifo_data 1 32 }  { frame_size_out_full_n fifo_status 0 1 }  { frame_size_out_write fifo_update 1 1 } } }
	frame_size_out3 { ap_fifo {  { frame_size_out3_din fifo_data 1 32 }  { frame_size_out3_full_n fifo_status 0 1 }  { frame_size_out3_write fifo_update 1 1 } } }
	dstin_out { ap_fifo {  { dstin_out_din fifo_data 1 64 }  { dstin_out_full_n fifo_status 0 1 }  { dstin_out_write fifo_update 1 1 } } }
	dstout_out { ap_fifo {  { dstout_out_din fifo_data 1 64 }  { dstout_out_full_n fifo_status 0 1 }  { dstout_out_write fifo_update 1 1 } } }
	crip_out { ap_fifo {  { crip_out_din fifo_data 1 24 }  { crip_out_full_n fifo_status 0 1 }  { crip_out_write fifo_update 1 1 } } }
	alpha_out { ap_fifo {  { alpha_out_din fifo_data 1 8 }  { alpha_out_full_n fifo_status 0 1 }  { alpha_out_write fifo_update 1 1 } } }
}
