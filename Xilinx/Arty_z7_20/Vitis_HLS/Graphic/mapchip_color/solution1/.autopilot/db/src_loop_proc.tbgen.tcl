set moduleName src_loop_proc
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {src_loop_proc}
set C_modelType { void 0 }
set C_modelArgList {
	{ mapchip_draw_xsize int 32 regular {fifo 0}  }
	{ id int 32 regular {fifo 0}  }
	{ mapchip_maxheight int 32 regular {fifo 0}  }
	{ ystart_pos int 32 regular {fifo 0}  }
	{ mapchip_maxwidth int 32 regular {fifo 0}  }
	{ xstart_pos int 32 regular {fifo 0}  }
	{ y int 32 regular {fifo 0}  }
	{ srcin int 64 regular {fifo 0}  }
	{ src int 32 regular {axi_master 0}  }
	{ src_V1 int 32 regular {array 640 { 0 3 } 0 1 }  }
	{ mapchip_draw_xsize_out int 32 regular {fifo 1}  }
	{ y_out int 32 regular {fifo 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "mapchip_draw_xsize", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "id", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_maxheight", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ystart_pos", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mapchip_maxwidth", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "xstart_pos", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "srcin", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "src", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "src_V1", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mapchip_draw_xsize_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "y_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 86
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ mapchip_draw_xsize_dout sc_in sc_lv 32 signal 0 } 
	{ mapchip_draw_xsize_empty_n sc_in sc_logic 1 signal 0 } 
	{ mapchip_draw_xsize_read sc_out sc_logic 1 signal 0 } 
	{ id_dout sc_in sc_lv 32 signal 1 } 
	{ id_empty_n sc_in sc_logic 1 signal 1 } 
	{ id_read sc_out sc_logic 1 signal 1 } 
	{ mapchip_maxheight_dout sc_in sc_lv 32 signal 2 } 
	{ mapchip_maxheight_empty_n sc_in sc_logic 1 signal 2 } 
	{ mapchip_maxheight_read sc_out sc_logic 1 signal 2 } 
	{ ystart_pos_dout sc_in sc_lv 32 signal 3 } 
	{ ystart_pos_empty_n sc_in sc_logic 1 signal 3 } 
	{ ystart_pos_read sc_out sc_logic 1 signal 3 } 
	{ mapchip_maxwidth_dout sc_in sc_lv 32 signal 4 } 
	{ mapchip_maxwidth_empty_n sc_in sc_logic 1 signal 4 } 
	{ mapchip_maxwidth_read sc_out sc_logic 1 signal 4 } 
	{ xstart_pos_dout sc_in sc_lv 32 signal 5 } 
	{ xstart_pos_empty_n sc_in sc_logic 1 signal 5 } 
	{ xstart_pos_read sc_out sc_logic 1 signal 5 } 
	{ y_dout sc_in sc_lv 32 signal 6 } 
	{ y_empty_n sc_in sc_logic 1 signal 6 } 
	{ y_read sc_out sc_logic 1 signal 6 } 
	{ srcin_dout sc_in sc_lv 64 signal 7 } 
	{ srcin_empty_n sc_in sc_logic 1 signal 7 } 
	{ srcin_read sc_out sc_logic 1 signal 7 } 
	{ m_axi_src_AWVALID sc_out sc_logic 1 signal 8 } 
	{ m_axi_src_AWREADY sc_in sc_logic 1 signal 8 } 
	{ m_axi_src_AWADDR sc_out sc_lv 64 signal 8 } 
	{ m_axi_src_AWID sc_out sc_lv 1 signal 8 } 
	{ m_axi_src_AWLEN sc_out sc_lv 32 signal 8 } 
	{ m_axi_src_AWSIZE sc_out sc_lv 3 signal 8 } 
	{ m_axi_src_AWBURST sc_out sc_lv 2 signal 8 } 
	{ m_axi_src_AWLOCK sc_out sc_lv 2 signal 8 } 
	{ m_axi_src_AWCACHE sc_out sc_lv 4 signal 8 } 
	{ m_axi_src_AWPROT sc_out sc_lv 3 signal 8 } 
	{ m_axi_src_AWQOS sc_out sc_lv 4 signal 8 } 
	{ m_axi_src_AWREGION sc_out sc_lv 4 signal 8 } 
	{ m_axi_src_AWUSER sc_out sc_lv 1 signal 8 } 
	{ m_axi_src_WVALID sc_out sc_logic 1 signal 8 } 
	{ m_axi_src_WREADY sc_in sc_logic 1 signal 8 } 
	{ m_axi_src_WDATA sc_out sc_lv 32 signal 8 } 
	{ m_axi_src_WSTRB sc_out sc_lv 4 signal 8 } 
	{ m_axi_src_WLAST sc_out sc_logic 1 signal 8 } 
	{ m_axi_src_WID sc_out sc_lv 1 signal 8 } 
	{ m_axi_src_WUSER sc_out sc_lv 1 signal 8 } 
	{ m_axi_src_ARVALID sc_out sc_logic 1 signal 8 } 
	{ m_axi_src_ARREADY sc_in sc_logic 1 signal 8 } 
	{ m_axi_src_ARADDR sc_out sc_lv 64 signal 8 } 
	{ m_axi_src_ARID sc_out sc_lv 1 signal 8 } 
	{ m_axi_src_ARLEN sc_out sc_lv 32 signal 8 } 
	{ m_axi_src_ARSIZE sc_out sc_lv 3 signal 8 } 
	{ m_axi_src_ARBURST sc_out sc_lv 2 signal 8 } 
	{ m_axi_src_ARLOCK sc_out sc_lv 2 signal 8 } 
	{ m_axi_src_ARCACHE sc_out sc_lv 4 signal 8 } 
	{ m_axi_src_ARPROT sc_out sc_lv 3 signal 8 } 
	{ m_axi_src_ARQOS sc_out sc_lv 4 signal 8 } 
	{ m_axi_src_ARREGION sc_out sc_lv 4 signal 8 } 
	{ m_axi_src_ARUSER sc_out sc_lv 1 signal 8 } 
	{ m_axi_src_RVALID sc_in sc_logic 1 signal 8 } 
	{ m_axi_src_RREADY sc_out sc_logic 1 signal 8 } 
	{ m_axi_src_RDATA sc_in sc_lv 32 signal 8 } 
	{ m_axi_src_RLAST sc_in sc_logic 1 signal 8 } 
	{ m_axi_src_RID sc_in sc_lv 1 signal 8 } 
	{ m_axi_src_RUSER sc_in sc_lv 1 signal 8 } 
	{ m_axi_src_RRESP sc_in sc_lv 2 signal 8 } 
	{ m_axi_src_BVALID sc_in sc_logic 1 signal 8 } 
	{ m_axi_src_BREADY sc_out sc_logic 1 signal 8 } 
	{ m_axi_src_BRESP sc_in sc_lv 2 signal 8 } 
	{ m_axi_src_BID sc_in sc_lv 1 signal 8 } 
	{ m_axi_src_BUSER sc_in sc_lv 1 signal 8 } 
	{ src_V1_address0 sc_out sc_lv 10 signal 9 } 
	{ src_V1_ce0 sc_out sc_logic 1 signal 9 } 
	{ src_V1_we0 sc_out sc_logic 1 signal 9 } 
	{ src_V1_d0 sc_out sc_lv 32 signal 9 } 
	{ mapchip_draw_xsize_out_din sc_out sc_lv 32 signal 10 } 
	{ mapchip_draw_xsize_out_full_n sc_in sc_logic 1 signal 10 } 
	{ mapchip_draw_xsize_out_write sc_out sc_logic 1 signal 10 } 
	{ y_out_din sc_out sc_lv 32 signal 11 } 
	{ y_out_full_n sc_in sc_logic 1 signal 11 } 
	{ y_out_write sc_out sc_logic 1 signal 11 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "mapchip_draw_xsize_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_draw_xsize", "role": "dout" }} , 
 	{ "name": "mapchip_draw_xsize_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize", "role": "empty_n" }} , 
 	{ "name": "mapchip_draw_xsize_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize", "role": "read" }} , 
 	{ "name": "id_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "id", "role": "dout" }} , 
 	{ "name": "id_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "id", "role": "empty_n" }} , 
 	{ "name": "id_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "id", "role": "read" }} , 
 	{ "name": "mapchip_maxheight_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxheight", "role": "dout" }} , 
 	{ "name": "mapchip_maxheight_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxheight", "role": "empty_n" }} , 
 	{ "name": "mapchip_maxheight_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxheight", "role": "read" }} , 
 	{ "name": "ystart_pos_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ystart_pos", "role": "dout" }} , 
 	{ "name": "ystart_pos_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ystart_pos", "role": "empty_n" }} , 
 	{ "name": "ystart_pos_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ystart_pos", "role": "read" }} , 
 	{ "name": "mapchip_maxwidth_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_maxwidth", "role": "dout" }} , 
 	{ "name": "mapchip_maxwidth_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxwidth", "role": "empty_n" }} , 
 	{ "name": "mapchip_maxwidth_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_maxwidth", "role": "read" }} , 
 	{ "name": "xstart_pos_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "xstart_pos", "role": "dout" }} , 
 	{ "name": "xstart_pos_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xstart_pos", "role": "empty_n" }} , 
 	{ "name": "xstart_pos_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xstart_pos", "role": "read" }} , 
 	{ "name": "y_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y", "role": "dout" }} , 
 	{ "name": "y_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y", "role": "empty_n" }} , 
 	{ "name": "y_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y", "role": "read" }} , 
 	{ "name": "srcin_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "srcin", "role": "dout" }} , 
 	{ "name": "srcin_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcin", "role": "empty_n" }} , 
 	{ "name": "srcin_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcin", "role": "read" }} , 
 	{ "name": "m_axi_src_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "AWVALID" }} , 
 	{ "name": "m_axi_src_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "AWREADY" }} , 
 	{ "name": "m_axi_src_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "src", "role": "AWADDR" }} , 
 	{ "name": "m_axi_src_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "AWID" }} , 
 	{ "name": "m_axi_src_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src", "role": "AWLEN" }} , 
 	{ "name": "m_axi_src_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "src", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_src_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "src", "role": "AWBURST" }} , 
 	{ "name": "m_axi_src_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "src", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_src_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "src", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_src_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "src", "role": "AWPROT" }} , 
 	{ "name": "m_axi_src_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "src", "role": "AWQOS" }} , 
 	{ "name": "m_axi_src_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "src", "role": "AWREGION" }} , 
 	{ "name": "m_axi_src_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "AWUSER" }} , 
 	{ "name": "m_axi_src_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "WVALID" }} , 
 	{ "name": "m_axi_src_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "WREADY" }} , 
 	{ "name": "m_axi_src_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src", "role": "WDATA" }} , 
 	{ "name": "m_axi_src_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "src", "role": "WSTRB" }} , 
 	{ "name": "m_axi_src_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "WLAST" }} , 
 	{ "name": "m_axi_src_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "WID" }} , 
 	{ "name": "m_axi_src_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "WUSER" }} , 
 	{ "name": "m_axi_src_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "ARVALID" }} , 
 	{ "name": "m_axi_src_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "ARREADY" }} , 
 	{ "name": "m_axi_src_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "src", "role": "ARADDR" }} , 
 	{ "name": "m_axi_src_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "ARID" }} , 
 	{ "name": "m_axi_src_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src", "role": "ARLEN" }} , 
 	{ "name": "m_axi_src_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "src", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_src_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "src", "role": "ARBURST" }} , 
 	{ "name": "m_axi_src_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "src", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_src_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "src", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_src_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "src", "role": "ARPROT" }} , 
 	{ "name": "m_axi_src_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "src", "role": "ARQOS" }} , 
 	{ "name": "m_axi_src_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "src", "role": "ARREGION" }} , 
 	{ "name": "m_axi_src_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "ARUSER" }} , 
 	{ "name": "m_axi_src_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "RVALID" }} , 
 	{ "name": "m_axi_src_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "RREADY" }} , 
 	{ "name": "m_axi_src_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src", "role": "RDATA" }} , 
 	{ "name": "m_axi_src_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "RLAST" }} , 
 	{ "name": "m_axi_src_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "RID" }} , 
 	{ "name": "m_axi_src_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "RUSER" }} , 
 	{ "name": "m_axi_src_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "src", "role": "RRESP" }} , 
 	{ "name": "m_axi_src_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "BVALID" }} , 
 	{ "name": "m_axi_src_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "BREADY" }} , 
 	{ "name": "m_axi_src_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "src", "role": "BRESP" }} , 
 	{ "name": "m_axi_src_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "BID" }} , 
 	{ "name": "m_axi_src_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "BUSER" }} , 
 	{ "name": "src_V1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "src_V1", "role": "address0" }} , 
 	{ "name": "src_V1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src_V1", "role": "ce0" }} , 
 	{ "name": "src_V1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src_V1", "role": "we0" }} , 
 	{ "name": "src_V1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src_V1", "role": "d0" }} , 
 	{ "name": "mapchip_draw_xsize_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "din" }} , 
 	{ "name": "mapchip_draw_xsize_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "full_n" }} , 
 	{ "name": "mapchip_draw_xsize_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mapchip_draw_xsize_out", "role": "write" }} , 
 	{ "name": "y_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_out", "role": "din" }} , 
 	{ "name": "y_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out", "role": "full_n" }} , 
 	{ "name": "y_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3"],
		"CDFG" : "src_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "18", "EstimateLatencyMax" : "657",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mapchip_draw_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "id", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "id_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxheight", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxheight_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ystart_pos", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ystart_pos_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxwidth", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxwidth_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xstart_pos", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xstart_pos_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "srcin", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "srcin_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "src_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "src_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0"},
			{"Name" : "mapchip_draw_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_32s_32_2_1_U32", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_32s_32_2_1_U33", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32ns_32ns_62_2_1_U34", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	src_loop_proc {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		id {Type I LastRead 0 FirstWrite -1}
		mapchip_maxheight {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		mapchip_maxwidth {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		src {Type I LastRead 16 FirstWrite -1}
		src_V1 {Type O LastRead -1 FirstWrite 17}
		mapchip_draw_xsize_out {Type O LastRead -1 FirstWrite 0}
		y_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "18", "Max" : "657"}
	, {"Name" : "Interval", "Min" : "18", "Max" : "657"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	mapchip_draw_xsize { ap_fifo {  { mapchip_draw_xsize_dout fifo_data 0 32 }  { mapchip_draw_xsize_empty_n fifo_status 0 1 }  { mapchip_draw_xsize_read fifo_update 1 1 } } }
	id { ap_fifo {  { id_dout fifo_data 0 32 }  { id_empty_n fifo_status 0 1 }  { id_read fifo_update 1 1 } } }
	mapchip_maxheight { ap_fifo {  { mapchip_maxheight_dout fifo_data 0 32 }  { mapchip_maxheight_empty_n fifo_status 0 1 }  { mapchip_maxheight_read fifo_update 1 1 } } }
	ystart_pos { ap_fifo {  { ystart_pos_dout fifo_data 0 32 }  { ystart_pos_empty_n fifo_status 0 1 }  { ystart_pos_read fifo_update 1 1 } } }
	mapchip_maxwidth { ap_fifo {  { mapchip_maxwidth_dout fifo_data 0 32 }  { mapchip_maxwidth_empty_n fifo_status 0 1 }  { mapchip_maxwidth_read fifo_update 1 1 } } }
	xstart_pos { ap_fifo {  { xstart_pos_dout fifo_data 0 32 }  { xstart_pos_empty_n fifo_status 0 1 }  { xstart_pos_read fifo_update 1 1 } } }
	y { ap_fifo {  { y_dout fifo_data 0 32 }  { y_empty_n fifo_status 0 1 }  { y_read fifo_update 1 1 } } }
	srcin { ap_fifo {  { srcin_dout fifo_data 0 64 }  { srcin_empty_n fifo_status 0 1 }  { srcin_read fifo_update 1 1 } } }
	src { m_axi {  { m_axi_src_AWVALID VALID 1 1 }  { m_axi_src_AWREADY READY 0 1 }  { m_axi_src_AWADDR ADDR 1 64 }  { m_axi_src_AWID ID 1 1 }  { m_axi_src_AWLEN LEN 1 32 }  { m_axi_src_AWSIZE SIZE 1 3 }  { m_axi_src_AWBURST BURST 1 2 }  { m_axi_src_AWLOCK LOCK 1 2 }  { m_axi_src_AWCACHE CACHE 1 4 }  { m_axi_src_AWPROT PROT 1 3 }  { m_axi_src_AWQOS QOS 1 4 }  { m_axi_src_AWREGION REGION 1 4 }  { m_axi_src_AWUSER USER 1 1 }  { m_axi_src_WVALID VALID 1 1 }  { m_axi_src_WREADY READY 0 1 }  { m_axi_src_WDATA DATA 1 32 }  { m_axi_src_WSTRB STRB 1 4 }  { m_axi_src_WLAST LAST 1 1 }  { m_axi_src_WID ID 1 1 }  { m_axi_src_WUSER USER 1 1 }  { m_axi_src_ARVALID VALID 1 1 }  { m_axi_src_ARREADY READY 0 1 }  { m_axi_src_ARADDR ADDR 1 64 }  { m_axi_src_ARID ID 1 1 }  { m_axi_src_ARLEN LEN 1 32 }  { m_axi_src_ARSIZE SIZE 1 3 }  { m_axi_src_ARBURST BURST 1 2 }  { m_axi_src_ARLOCK LOCK 1 2 }  { m_axi_src_ARCACHE CACHE 1 4 }  { m_axi_src_ARPROT PROT 1 3 }  { m_axi_src_ARQOS QOS 1 4 }  { m_axi_src_ARREGION REGION 1 4 }  { m_axi_src_ARUSER USER 1 1 }  { m_axi_src_RVALID VALID 0 1 }  { m_axi_src_RREADY READY 1 1 }  { m_axi_src_RDATA DATA 0 32 }  { m_axi_src_RLAST LAST 0 1 }  { m_axi_src_RID ID 0 1 }  { m_axi_src_RUSER USER 0 1 }  { m_axi_src_RRESP RESP 0 2 }  { m_axi_src_BVALID VALID 0 1 }  { m_axi_src_BREADY READY 1 1 }  { m_axi_src_BRESP RESP 0 2 }  { m_axi_src_BID ID 0 1 }  { m_axi_src_BUSER USER 0 1 } } }
	src_V1 { ap_memory {  { src_V1_address0 mem_address 1 10 }  { src_V1_ce0 mem_ce 1 1 }  { src_V1_we0 mem_we 1 1 }  { src_V1_d0 mem_din 1 32 } } }
	mapchip_draw_xsize_out { ap_fifo {  { mapchip_draw_xsize_out_din fifo_data 1 32 }  { mapchip_draw_xsize_out_full_n fifo_status 0 1 }  { mapchip_draw_xsize_out_write fifo_update 1 1 } } }
	y_out { ap_fifo {  { y_out_din fifo_data 1 32 }  { y_out_full_n fifo_status 0 1 }  { y_out_write fifo_update 1 1 } } }
}
