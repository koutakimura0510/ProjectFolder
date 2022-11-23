set moduleName dstout_loop_proc
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
set C_modelName {dstout_loop_proc}
set C_modelType { void 0 }
set C_modelArgList {
	{ mapchip_draw_xsize int 32 regular {fifo 0}  }
	{ src_V1 int 32 regular {array 640 { 1 3 } 1 1 }  }
	{ dst_V2 int 24 regular {array 640 { 1 3 } 1 1 }  }
	{ com int 24 regular {fifo 0}  }
	{ fill int 24 regular {fifo 0}  }
	{ alpha int 8 regular {fifo 0}  }
	{ y int 32 regular {fifo 0}  }
	{ frame_size int 32 regular {fifo 0}  }
	{ dstout int 64 regular {fifo 0}  }
	{ dst int 32 regular {axi_master 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "mapchip_draw_xsize", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "src_V1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "dst_V2", "interface" : "memory", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "com", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "fill", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "alpha", "interface" : "fifo", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "y", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "frame_size", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "dstout", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "dst", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 79
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
	{ src_V1_address0 sc_out sc_lv 10 signal 1 } 
	{ src_V1_ce0 sc_out sc_logic 1 signal 1 } 
	{ src_V1_q0 sc_in sc_lv 32 signal 1 } 
	{ dst_V2_address0 sc_out sc_lv 10 signal 2 } 
	{ dst_V2_ce0 sc_out sc_logic 1 signal 2 } 
	{ dst_V2_q0 sc_in sc_lv 24 signal 2 } 
	{ com_dout sc_in sc_lv 24 signal 3 } 
	{ com_empty_n sc_in sc_logic 1 signal 3 } 
	{ com_read sc_out sc_logic 1 signal 3 } 
	{ fill_dout sc_in sc_lv 24 signal 4 } 
	{ fill_empty_n sc_in sc_logic 1 signal 4 } 
	{ fill_read sc_out sc_logic 1 signal 4 } 
	{ alpha_dout sc_in sc_lv 8 signal 5 } 
	{ alpha_empty_n sc_in sc_logic 1 signal 5 } 
	{ alpha_read sc_out sc_logic 1 signal 5 } 
	{ y_dout sc_in sc_lv 32 signal 6 } 
	{ y_empty_n sc_in sc_logic 1 signal 6 } 
	{ y_read sc_out sc_logic 1 signal 6 } 
	{ frame_size_dout sc_in sc_lv 32 signal 7 } 
	{ frame_size_empty_n sc_in sc_logic 1 signal 7 } 
	{ frame_size_read sc_out sc_logic 1 signal 7 } 
	{ dstout_dout sc_in sc_lv 64 signal 8 } 
	{ dstout_empty_n sc_in sc_logic 1 signal 8 } 
	{ dstout_read sc_out sc_logic 1 signal 8 } 
	{ m_axi_dst_AWVALID sc_out sc_logic 1 signal 9 } 
	{ m_axi_dst_AWREADY sc_in sc_logic 1 signal 9 } 
	{ m_axi_dst_AWADDR sc_out sc_lv 64 signal 9 } 
	{ m_axi_dst_AWID sc_out sc_lv 1 signal 9 } 
	{ m_axi_dst_AWLEN sc_out sc_lv 32 signal 9 } 
	{ m_axi_dst_AWSIZE sc_out sc_lv 3 signal 9 } 
	{ m_axi_dst_AWBURST sc_out sc_lv 2 signal 9 } 
	{ m_axi_dst_AWLOCK sc_out sc_lv 2 signal 9 } 
	{ m_axi_dst_AWCACHE sc_out sc_lv 4 signal 9 } 
	{ m_axi_dst_AWPROT sc_out sc_lv 3 signal 9 } 
	{ m_axi_dst_AWQOS sc_out sc_lv 4 signal 9 } 
	{ m_axi_dst_AWREGION sc_out sc_lv 4 signal 9 } 
	{ m_axi_dst_AWUSER sc_out sc_lv 1 signal 9 } 
	{ m_axi_dst_WVALID sc_out sc_logic 1 signal 9 } 
	{ m_axi_dst_WREADY sc_in sc_logic 1 signal 9 } 
	{ m_axi_dst_WDATA sc_out sc_lv 32 signal 9 } 
	{ m_axi_dst_WSTRB sc_out sc_lv 4 signal 9 } 
	{ m_axi_dst_WLAST sc_out sc_logic 1 signal 9 } 
	{ m_axi_dst_WID sc_out sc_lv 1 signal 9 } 
	{ m_axi_dst_WUSER sc_out sc_lv 1 signal 9 } 
	{ m_axi_dst_ARVALID sc_out sc_logic 1 signal 9 } 
	{ m_axi_dst_ARREADY sc_in sc_logic 1 signal 9 } 
	{ m_axi_dst_ARADDR sc_out sc_lv 64 signal 9 } 
	{ m_axi_dst_ARID sc_out sc_lv 1 signal 9 } 
	{ m_axi_dst_ARLEN sc_out sc_lv 32 signal 9 } 
	{ m_axi_dst_ARSIZE sc_out sc_lv 3 signal 9 } 
	{ m_axi_dst_ARBURST sc_out sc_lv 2 signal 9 } 
	{ m_axi_dst_ARLOCK sc_out sc_lv 2 signal 9 } 
	{ m_axi_dst_ARCACHE sc_out sc_lv 4 signal 9 } 
	{ m_axi_dst_ARPROT sc_out sc_lv 3 signal 9 } 
	{ m_axi_dst_ARQOS sc_out sc_lv 4 signal 9 } 
	{ m_axi_dst_ARREGION sc_out sc_lv 4 signal 9 } 
	{ m_axi_dst_ARUSER sc_out sc_lv 1 signal 9 } 
	{ m_axi_dst_RVALID sc_in sc_logic 1 signal 9 } 
	{ m_axi_dst_RREADY sc_out sc_logic 1 signal 9 } 
	{ m_axi_dst_RDATA sc_in sc_lv 32 signal 9 } 
	{ m_axi_dst_RLAST sc_in sc_logic 1 signal 9 } 
	{ m_axi_dst_RID sc_in sc_lv 1 signal 9 } 
	{ m_axi_dst_RUSER sc_in sc_lv 1 signal 9 } 
	{ m_axi_dst_RRESP sc_in sc_lv 2 signal 9 } 
	{ m_axi_dst_BVALID sc_in sc_logic 1 signal 9 } 
	{ m_axi_dst_BREADY sc_out sc_logic 1 signal 9 } 
	{ m_axi_dst_BRESP sc_in sc_lv 2 signal 9 } 
	{ m_axi_dst_BID sc_in sc_lv 1 signal 9 } 
	{ m_axi_dst_BUSER sc_in sc_lv 1 signal 9 } 
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
 	{ "name": "src_V1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "src_V1", "role": "address0" }} , 
 	{ "name": "src_V1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src_V1", "role": "ce0" }} , 
 	{ "name": "src_V1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src_V1", "role": "q0" }} , 
 	{ "name": "dst_V2_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "dst_V2", "role": "address0" }} , 
 	{ "name": "dst_V2_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst_V2", "role": "ce0" }} , 
 	{ "name": "dst_V2_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "dst_V2", "role": "q0" }} , 
 	{ "name": "com_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "com", "role": "dout" }} , 
 	{ "name": "com_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "com", "role": "empty_n" }} , 
 	{ "name": "com_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "com", "role": "read" }} , 
 	{ "name": "fill_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "fill", "role": "dout" }} , 
 	{ "name": "fill_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "fill", "role": "empty_n" }} , 
 	{ "name": "fill_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "fill", "role": "read" }} , 
 	{ "name": "alpha_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "alpha", "role": "dout" }} , 
 	{ "name": "alpha_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha", "role": "empty_n" }} , 
 	{ "name": "alpha_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha", "role": "read" }} , 
 	{ "name": "y_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y", "role": "dout" }} , 
 	{ "name": "y_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y", "role": "empty_n" }} , 
 	{ "name": "y_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y", "role": "read" }} , 
 	{ "name": "frame_size_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size", "role": "dout" }} , 
 	{ "name": "frame_size_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size", "role": "empty_n" }} , 
 	{ "name": "frame_size_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size", "role": "read" }} , 
 	{ "name": "dstout_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstout", "role": "dout" }} , 
 	{ "name": "dstout_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstout", "role": "empty_n" }} , 
 	{ "name": "dstout_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dstout", "role": "read" }} , 
 	{ "name": "m_axi_dst_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "AWVALID" }} , 
 	{ "name": "m_axi_dst_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "AWREADY" }} , 
 	{ "name": "m_axi_dst_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dst", "role": "AWADDR" }} , 
 	{ "name": "m_axi_dst_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "AWID" }} , 
 	{ "name": "m_axi_dst_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dst", "role": "AWLEN" }} , 
 	{ "name": "m_axi_dst_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "dst", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_dst_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "dst", "role": "AWBURST" }} , 
 	{ "name": "m_axi_dst_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "dst", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_dst_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "dst", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_dst_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "dst", "role": "AWPROT" }} , 
 	{ "name": "m_axi_dst_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "dst", "role": "AWQOS" }} , 
 	{ "name": "m_axi_dst_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "dst", "role": "AWREGION" }} , 
 	{ "name": "m_axi_dst_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "AWUSER" }} , 
 	{ "name": "m_axi_dst_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "WVALID" }} , 
 	{ "name": "m_axi_dst_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "WREADY" }} , 
 	{ "name": "m_axi_dst_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dst", "role": "WDATA" }} , 
 	{ "name": "m_axi_dst_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "dst", "role": "WSTRB" }} , 
 	{ "name": "m_axi_dst_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "WLAST" }} , 
 	{ "name": "m_axi_dst_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "WID" }} , 
 	{ "name": "m_axi_dst_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "WUSER" }} , 
 	{ "name": "m_axi_dst_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "ARVALID" }} , 
 	{ "name": "m_axi_dst_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "ARREADY" }} , 
 	{ "name": "m_axi_dst_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dst", "role": "ARADDR" }} , 
 	{ "name": "m_axi_dst_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "ARID" }} , 
 	{ "name": "m_axi_dst_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dst", "role": "ARLEN" }} , 
 	{ "name": "m_axi_dst_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "dst", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_dst_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "dst", "role": "ARBURST" }} , 
 	{ "name": "m_axi_dst_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "dst", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_dst_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "dst", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_dst_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "dst", "role": "ARPROT" }} , 
 	{ "name": "m_axi_dst_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "dst", "role": "ARQOS" }} , 
 	{ "name": "m_axi_dst_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "dst", "role": "ARREGION" }} , 
 	{ "name": "m_axi_dst_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "ARUSER" }} , 
 	{ "name": "m_axi_dst_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "RVALID" }} , 
 	{ "name": "m_axi_dst_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "RREADY" }} , 
 	{ "name": "m_axi_dst_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "dst", "role": "RDATA" }} , 
 	{ "name": "m_axi_dst_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "RLAST" }} , 
 	{ "name": "m_axi_dst_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "RID" }} , 
 	{ "name": "m_axi_dst_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "RUSER" }} , 
 	{ "name": "m_axi_dst_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "dst", "role": "RRESP" }} , 
 	{ "name": "m_axi_dst_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "BVALID" }} , 
 	{ "name": "m_axi_dst_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "BREADY" }} , 
 	{ "name": "m_axi_dst_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "dst", "role": "BRESP" }} , 
 	{ "name": "m_axi_dst_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "BID" }} , 
 	{ "name": "m_axi_dst_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"],
		"CDFG" : "dstout_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "24", "EstimateLatencyMax" : "663",
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
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0"},
			{"Name" : "dst_V2", "Type" : "Memory", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0"},
			{"Name" : "com", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "com_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "fill", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "fill_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "alpha", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "alpha_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstout", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstout_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "dst_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32ns_32ns_62_2_1_U56", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_8ns_8ns_16_1_1_U57", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_8ns_8ns_16_1_1_U58", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_8ns_8ns_16_1_1_U59", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mac_muladd_8ns_8ns_16ns_17_4_1_U60", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mac_muladd_8ns_8ns_16ns_17_4_1_U61", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mac_muladd_8ns_8ns_16ns_17_4_1_U62", "Parent" : "0"},
	{"ID" : "8", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_17ns_19ns_35_4_1_U63", "Parent" : "0"},
	{"ID" : "9", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_17ns_19ns_35_4_1_U64", "Parent" : "0"},
	{"ID" : "10", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_17ns_19ns_35_4_1_U65", "Parent" : "0"},
	{"ID" : "11", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_10ns_8ns_17_4_1_U66", "Parent" : "0"},
	{"ID" : "12", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_10ns_8ns_17_4_1_U67", "Parent" : "0"},
	{"ID" : "13", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_10ns_8ns_17_4_1_U68", "Parent" : "0"},
	{"ID" : "14", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_17ns_19ns_35_4_1_U69", "Parent" : "0"},
	{"ID" : "15", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_17ns_19ns_35_4_1_U70", "Parent" : "0"},
	{"ID" : "16", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_mul_17ns_19ns_35_4_1_U71", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	dstout_loop_proc {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		src_V1 {Type I LastRead 5 FirstWrite -1}
		dst_V2 {Type I LastRead 5 FirstWrite -1}
		com {Type I LastRead 0 FirstWrite -1}
		fill {Type I LastRead 0 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}
		dst {Type O LastRead 6 FirstWrite 19}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "24", "Max" : "663"}
	, {"Name" : "Interval", "Min" : "24", "Max" : "663"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	mapchip_draw_xsize { ap_fifo {  { mapchip_draw_xsize_dout fifo_data 0 32 }  { mapchip_draw_xsize_empty_n fifo_status 0 1 }  { mapchip_draw_xsize_read fifo_update 1 1 } } }
	src_V1 { ap_memory {  { src_V1_address0 mem_address 1 10 }  { src_V1_ce0 mem_ce 1 1 }  { src_V1_q0 mem_dout 0 32 } } }
	dst_V2 { ap_memory {  { dst_V2_address0 mem_address 1 10 }  { dst_V2_ce0 mem_ce 1 1 }  { dst_V2_q0 mem_dout 0 24 } } }
	com { ap_fifo {  { com_dout fifo_data 0 24 }  { com_empty_n fifo_status 0 1 }  { com_read fifo_update 1 1 } } }
	fill { ap_fifo {  { fill_dout fifo_data 0 24 }  { fill_empty_n fifo_status 0 1 }  { fill_read fifo_update 1 1 } } }
	alpha { ap_fifo {  { alpha_dout fifo_data 0 8 }  { alpha_empty_n fifo_status 0 1 }  { alpha_read fifo_update 1 1 } } }
	y { ap_fifo {  { y_dout fifo_data 0 32 }  { y_empty_n fifo_status 0 1 }  { y_read fifo_update 1 1 } } }
	frame_size { ap_fifo {  { frame_size_dout fifo_data 0 32 }  { frame_size_empty_n fifo_status 0 1 }  { frame_size_read fifo_update 1 1 } } }
	dstout { ap_fifo {  { dstout_dout fifo_data 0 64 }  { dstout_empty_n fifo_status 0 1 }  { dstout_read fifo_update 1 1 } } }
	dst { m_axi {  { m_axi_dst_AWVALID VALID 1 1 }  { m_axi_dst_AWREADY READY 0 1 }  { m_axi_dst_AWADDR ADDR 1 64 }  { m_axi_dst_AWID ID 1 1 }  { m_axi_dst_AWLEN LEN 1 32 }  { m_axi_dst_AWSIZE SIZE 1 3 }  { m_axi_dst_AWBURST BURST 1 2 }  { m_axi_dst_AWLOCK LOCK 1 2 }  { m_axi_dst_AWCACHE CACHE 1 4 }  { m_axi_dst_AWPROT PROT 1 3 }  { m_axi_dst_AWQOS QOS 1 4 }  { m_axi_dst_AWREGION REGION 1 4 }  { m_axi_dst_AWUSER USER 1 1 }  { m_axi_dst_WVALID VALID 1 1 }  { m_axi_dst_WREADY READY 0 1 }  { m_axi_dst_WDATA DATA 1 32 }  { m_axi_dst_WSTRB STRB 1 4 }  { m_axi_dst_WLAST LAST 1 1 }  { m_axi_dst_WID ID 1 1 }  { m_axi_dst_WUSER USER 1 1 }  { m_axi_dst_ARVALID VALID 1 1 }  { m_axi_dst_ARREADY READY 0 1 }  { m_axi_dst_ARADDR ADDR 1 64 }  { m_axi_dst_ARID ID 1 1 }  { m_axi_dst_ARLEN LEN 1 32 }  { m_axi_dst_ARSIZE SIZE 1 3 }  { m_axi_dst_ARBURST BURST 1 2 }  { m_axi_dst_ARLOCK LOCK 1 2 }  { m_axi_dst_ARCACHE CACHE 1 4 }  { m_axi_dst_ARPROT PROT 1 3 }  { m_axi_dst_ARQOS QOS 1 4 }  { m_axi_dst_ARREGION REGION 1 4 }  { m_axi_dst_ARUSER USER 1 1 }  { m_axi_dst_RVALID VALID 0 1 }  { m_axi_dst_RREADY READY 1 1 }  { m_axi_dst_RDATA DATA 0 32 }  { m_axi_dst_RLAST LAST 0 1 }  { m_axi_dst_RID ID 0 1 }  { m_axi_dst_RUSER USER 0 1 }  { m_axi_dst_RRESP RESP 0 2 }  { m_axi_dst_BVALID VALID 0 1 }  { m_axi_dst_BREADY READY 1 1 }  { m_axi_dst_BRESP RESP 0 2 }  { m_axi_dst_BID ID 0 1 }  { m_axi_dst_BUSER USER 0 1 } } }
}
