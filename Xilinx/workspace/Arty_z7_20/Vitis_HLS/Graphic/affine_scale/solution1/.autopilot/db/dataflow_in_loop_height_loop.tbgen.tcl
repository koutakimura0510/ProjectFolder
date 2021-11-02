set moduleName dataflow_in_loop_height_loop
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type dataflow
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {dataflow_in_loop_height_loop}
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
	{ src int 32 regular {axi_master 0}  }
	{ frame_size int 32 regular  }
	{ dstin int 64 regular  }
	{ dst int 32 regular {axi_master 2}  }
	{ alpha int 8 regular  }
	{ dstout int 64 regular  }
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
 	{ "Name" : "src", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "frame_size", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "dstin", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "dst", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READWRITE"} , 
 	{ "Name" : "alpha", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "dstout", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 133
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
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
	{ m_axi_src_AWVALID sc_out sc_logic 1 signal 14 } 
	{ m_axi_src_AWREADY sc_in sc_logic 1 signal 14 } 
	{ m_axi_src_AWADDR sc_out sc_lv 64 signal 14 } 
	{ m_axi_src_AWID sc_out sc_lv 1 signal 14 } 
	{ m_axi_src_AWLEN sc_out sc_lv 32 signal 14 } 
	{ m_axi_src_AWSIZE sc_out sc_lv 3 signal 14 } 
	{ m_axi_src_AWBURST sc_out sc_lv 2 signal 14 } 
	{ m_axi_src_AWLOCK sc_out sc_lv 2 signal 14 } 
	{ m_axi_src_AWCACHE sc_out sc_lv 4 signal 14 } 
	{ m_axi_src_AWPROT sc_out sc_lv 3 signal 14 } 
	{ m_axi_src_AWQOS sc_out sc_lv 4 signal 14 } 
	{ m_axi_src_AWREGION sc_out sc_lv 4 signal 14 } 
	{ m_axi_src_AWUSER sc_out sc_lv 1 signal 14 } 
	{ m_axi_src_WVALID sc_out sc_logic 1 signal 14 } 
	{ m_axi_src_WREADY sc_in sc_logic 1 signal 14 } 
	{ m_axi_src_WDATA sc_out sc_lv 32 signal 14 } 
	{ m_axi_src_WSTRB sc_out sc_lv 4 signal 14 } 
	{ m_axi_src_WLAST sc_out sc_logic 1 signal 14 } 
	{ m_axi_src_WID sc_out sc_lv 1 signal 14 } 
	{ m_axi_src_WUSER sc_out sc_lv 1 signal 14 } 
	{ m_axi_src_ARVALID sc_out sc_logic 1 signal 14 } 
	{ m_axi_src_ARREADY sc_in sc_logic 1 signal 14 } 
	{ m_axi_src_ARADDR sc_out sc_lv 64 signal 14 } 
	{ m_axi_src_ARID sc_out sc_lv 1 signal 14 } 
	{ m_axi_src_ARLEN sc_out sc_lv 32 signal 14 } 
	{ m_axi_src_ARSIZE sc_out sc_lv 3 signal 14 } 
	{ m_axi_src_ARBURST sc_out sc_lv 2 signal 14 } 
	{ m_axi_src_ARLOCK sc_out sc_lv 2 signal 14 } 
	{ m_axi_src_ARCACHE sc_out sc_lv 4 signal 14 } 
	{ m_axi_src_ARPROT sc_out sc_lv 3 signal 14 } 
	{ m_axi_src_ARQOS sc_out sc_lv 4 signal 14 } 
	{ m_axi_src_ARREGION sc_out sc_lv 4 signal 14 } 
	{ m_axi_src_ARUSER sc_out sc_lv 1 signal 14 } 
	{ m_axi_src_RVALID sc_in sc_logic 1 signal 14 } 
	{ m_axi_src_RREADY sc_out sc_logic 1 signal 14 } 
	{ m_axi_src_RDATA sc_in sc_lv 32 signal 14 } 
	{ m_axi_src_RLAST sc_in sc_logic 1 signal 14 } 
	{ m_axi_src_RID sc_in sc_lv 1 signal 14 } 
	{ m_axi_src_RUSER sc_in sc_lv 1 signal 14 } 
	{ m_axi_src_RRESP sc_in sc_lv 2 signal 14 } 
	{ m_axi_src_BVALID sc_in sc_logic 1 signal 14 } 
	{ m_axi_src_BREADY sc_out sc_logic 1 signal 14 } 
	{ m_axi_src_BRESP sc_in sc_lv 2 signal 14 } 
	{ m_axi_src_BID sc_in sc_lv 1 signal 14 } 
	{ m_axi_src_BUSER sc_in sc_lv 1 signal 14 } 
	{ frame_size sc_in sc_lv 32 signal 15 } 
	{ dstin sc_in sc_lv 64 signal 16 } 
	{ m_axi_dst_AWVALID sc_out sc_logic 1 signal 17 } 
	{ m_axi_dst_AWREADY sc_in sc_logic 1 signal 17 } 
	{ m_axi_dst_AWADDR sc_out sc_lv 64 signal 17 } 
	{ m_axi_dst_AWID sc_out sc_lv 1 signal 17 } 
	{ m_axi_dst_AWLEN sc_out sc_lv 32 signal 17 } 
	{ m_axi_dst_AWSIZE sc_out sc_lv 3 signal 17 } 
	{ m_axi_dst_AWBURST sc_out sc_lv 2 signal 17 } 
	{ m_axi_dst_AWLOCK sc_out sc_lv 2 signal 17 } 
	{ m_axi_dst_AWCACHE sc_out sc_lv 4 signal 17 } 
	{ m_axi_dst_AWPROT sc_out sc_lv 3 signal 17 } 
	{ m_axi_dst_AWQOS sc_out sc_lv 4 signal 17 } 
	{ m_axi_dst_AWREGION sc_out sc_lv 4 signal 17 } 
	{ m_axi_dst_AWUSER sc_out sc_lv 1 signal 17 } 
	{ m_axi_dst_WVALID sc_out sc_logic 1 signal 17 } 
	{ m_axi_dst_WREADY sc_in sc_logic 1 signal 17 } 
	{ m_axi_dst_WDATA sc_out sc_lv 32 signal 17 } 
	{ m_axi_dst_WSTRB sc_out sc_lv 4 signal 17 } 
	{ m_axi_dst_WLAST sc_out sc_logic 1 signal 17 } 
	{ m_axi_dst_WID sc_out sc_lv 1 signal 17 } 
	{ m_axi_dst_WUSER sc_out sc_lv 1 signal 17 } 
	{ m_axi_dst_ARVALID sc_out sc_logic 1 signal 17 } 
	{ m_axi_dst_ARREADY sc_in sc_logic 1 signal 17 } 
	{ m_axi_dst_ARADDR sc_out sc_lv 64 signal 17 } 
	{ m_axi_dst_ARID sc_out sc_lv 1 signal 17 } 
	{ m_axi_dst_ARLEN sc_out sc_lv 32 signal 17 } 
	{ m_axi_dst_ARSIZE sc_out sc_lv 3 signal 17 } 
	{ m_axi_dst_ARBURST sc_out sc_lv 2 signal 17 } 
	{ m_axi_dst_ARLOCK sc_out sc_lv 2 signal 17 } 
	{ m_axi_dst_ARCACHE sc_out sc_lv 4 signal 17 } 
	{ m_axi_dst_ARPROT sc_out sc_lv 3 signal 17 } 
	{ m_axi_dst_ARQOS sc_out sc_lv 4 signal 17 } 
	{ m_axi_dst_ARREGION sc_out sc_lv 4 signal 17 } 
	{ m_axi_dst_ARUSER sc_out sc_lv 1 signal 17 } 
	{ m_axi_dst_RVALID sc_in sc_logic 1 signal 17 } 
	{ m_axi_dst_RREADY sc_out sc_logic 1 signal 17 } 
	{ m_axi_dst_RDATA sc_in sc_lv 32 signal 17 } 
	{ m_axi_dst_RLAST sc_in sc_logic 1 signal 17 } 
	{ m_axi_dst_RID sc_in sc_lv 1 signal 17 } 
	{ m_axi_dst_RUSER sc_in sc_lv 1 signal 17 } 
	{ m_axi_dst_RRESP sc_in sc_lv 2 signal 17 } 
	{ m_axi_dst_BVALID sc_in sc_logic 1 signal 17 } 
	{ m_axi_dst_BREADY sc_out sc_logic 1 signal 17 } 
	{ m_axi_dst_BRESP sc_in sc_lv 2 signal 17 } 
	{ m_axi_dst_BID sc_in sc_lv 1 signal 17 } 
	{ m_axi_dst_BUSER sc_in sc_lv 1 signal 17 } 
	{ alpha sc_in sc_lv 8 signal 18 } 
	{ dstout sc_in sc_lv 64 signal 19 } 
	{ mapchip_draw_xsize_ap_vld sc_in sc_logic 1 invld 0 } 
	{ mapchip_maxwidth_ap_vld sc_in sc_logic 1 invld 1 } 
	{ d_ap_vld sc_in sc_logic 1 invld 2 } 
	{ a_ap_vld sc_in sc_logic 1 invld 3 } 
	{ c_ap_vld sc_in sc_logic 1 invld 4 } 
	{ b_ap_vld sc_in sc_logic 1 invld 5 } 
	{ m_ap_vld sc_in sc_logic 1 invld 6 } 
	{ trunc_ln1345_ap_vld sc_in sc_logic 1 invld 7 } 
	{ mapchip_maxheight_ap_vld sc_in sc_logic 1 invld 8 } 
	{ n_ap_vld sc_in sc_logic 1 invld 9 } 
	{ id_ap_vld sc_in sc_logic 1 invld 10 } 
	{ ystart_pos_ap_vld sc_in sc_logic 1 invld 11 } 
	{ xstart_pos_ap_vld sc_in sc_logic 1 invld 12 } 
	{ srcin_ap_vld sc_in sc_logic 1 invld 13 } 
	{ frame_size_ap_vld sc_in sc_logic 1 invld 15 } 
	{ dstin_ap_vld sc_in sc_logic 1 invld 16 } 
	{ alpha_ap_vld sc_in sc_logic 1 invld 18 } 
	{ dstout_ap_vld sc_in sc_logic 1 invld 19 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
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
 	{ "name": "frame_size", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size", "role": "default" }} , 
 	{ "name": "dstin", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstin", "role": "default" }} , 
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
 	{ "name": "m_axi_dst_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "BUSER" }} , 
 	{ "name": "alpha", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "alpha", "role": "default" }} , 
 	{ "name": "dstout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dstout", "role": "default" }} , 
 	{ "name": "mapchip_draw_xsize_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "mapchip_draw_xsize", "role": "ap_vld" }} , 
 	{ "name": "mapchip_maxwidth_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "mapchip_maxwidth", "role": "ap_vld" }} , 
 	{ "name": "d_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "d", "role": "ap_vld" }} , 
 	{ "name": "a_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "a", "role": "ap_vld" }} , 
 	{ "name": "c_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "c", "role": "ap_vld" }} , 
 	{ "name": "b_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "b", "role": "ap_vld" }} , 
 	{ "name": "m_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "m", "role": "ap_vld" }} , 
 	{ "name": "trunc_ln1345_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "trunc_ln1345", "role": "ap_vld" }} , 
 	{ "name": "mapchip_maxheight_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "mapchip_maxheight", "role": "ap_vld" }} , 
 	{ "name": "n_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "n", "role": "ap_vld" }} , 
 	{ "name": "id_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "id", "role": "ap_vld" }} , 
 	{ "name": "ystart_pos_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "ystart_pos", "role": "ap_vld" }} , 
 	{ "name": "xstart_pos_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "xstart_pos", "role": "ap_vld" }} , 
 	{ "name": "srcin_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "srcin", "role": "ap_vld" }} , 
 	{ "name": "frame_size_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "frame_size", "role": "ap_vld" }} , 
 	{ "name": "dstin_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "dstin", "role": "ap_vld" }} , 
 	{ "name": "alpha_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "alpha", "role": "ap_vld" }} , 
 	{ "name": "dstout_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "dstout", "role": "ap_vld" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "24", "26", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65"],
		"CDFG" : "dataflow_in_loop_height_loop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "89", "EstimateLatencyMax" : "1367",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "3", "Name" : "dataflow_in_loop_height_loop_entry6_U0"},
			{"ID" : "4", "Name" : "src_loop_proc_U0"},
			{"ID" : "24", "Name" : "dstin_loop_proc_U0"}],
		"OutputProcess" : [
			{"ID" : "26", "Name" : "dstout_loop_proc_U0"}],
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
			{"Name" : "src", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "src_loop_proc_U0", "Port" : "src"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstin", "Type" : "None", "Direction" : "I"},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "24", "SubInstance" : "dstin_loop_proc_U0", "Port" : "dst"},
					{"ID" : "26", "SubInstance" : "dstout_loop_proc_U0", "Port" : "dst"}]},
			{"Name" : "alpha", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstout", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.src_V_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dst_V_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_entry6_U0", "Parent" : "0",
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
			{"Name" : "mapchip_draw_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "43", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_draw_xsize_out1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "24", "DependentChan" : "44", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxwidth_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "45", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxwidth_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "d_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "46", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "d_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "a_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "47", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "a_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "c_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "48", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "c_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "b_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "49", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "b_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "m_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "50", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "m_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "51", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345_out2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "24", "DependentChan" : "52", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_out2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxheight_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "53", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxheight_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "n_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "54", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "n_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "id_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "55", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "id_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ystart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "56", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ystart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xstart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "57", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xstart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "srcin_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "58", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "srcin_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "24", "DependentChan" : "59", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "26", "DependentChan" : "60", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstin_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "24", "DependentChan" : "61", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstin_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "alpha_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "26", "DependentChan" : "62", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "alpha_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstout_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "26", "DependentChan" : "63", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstout_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0", "Parent" : "0", "Child" : ["5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"],
		"CDFG" : "src_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "63", "EstimateLatencyMax" : "702",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mapchip_draw_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "43", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxwidth", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "45", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxwidth_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "d", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "46", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "d_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "a", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "47", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "a_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "c", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "48", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "c_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "b", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "49", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "b_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "m", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "50", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "m_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "51", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxheight", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "53", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxheight_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "n", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "54", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "n_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "O", "DependentProc" : "26", "DependentChan" : "1"},
			{"Name" : "id", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "55", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "id_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ystart_pos", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "56", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ystart_pos_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xstart_pos", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "57", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xstart_pos_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "srcin", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "58", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "srcin_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "src_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "src_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_draw_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "26", "DependentChan" : "64", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "26", "DependentChan" : "65", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_34ns_65_2_1_U40", "Parent" : "4"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_34ns_65_2_1_U41", "Parent" : "4"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_34ns_65_2_1_U42", "Parent" : "4"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_34ns_65_2_1_U43", "Parent" : "4"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_32s_32_2_1_U44", "Parent" : "4"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_28s_28s_44_3_1_U45", "Parent" : "4"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_28s_28s_44_3_1_U46", "Parent" : "4"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_32s_32_2_1_U47", "Parent" : "4"},
	{"ID" : "13", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.sdiv_32ns_32s_32_36_seq_1_U48", "Parent" : "4"},
	{"ID" : "14", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.sdiv_33ns_32s_32_37_seq_1_U49", "Parent" : "4"},
	{"ID" : "15", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.sdiv_33ns_32s_32_37_seq_1_U50", "Parent" : "4"},
	{"ID" : "16", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.sdiv_32ns_32s_32_36_seq_1_U51", "Parent" : "4"},
	{"ID" : "17", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_32s_32_2_1_U52", "Parent" : "4"},
	{"ID" : "18", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_32s_32_2_1_U53", "Parent" : "4"},
	{"ID" : "19", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_32s_32_2_1_U54", "Parent" : "4"},
	{"ID" : "20", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_32s_32_2_1_U55", "Parent" : "4"},
	{"ID" : "21", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_33s_32s_44_2_1_U56", "Parent" : "4"},
	{"ID" : "22", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_33s_32s_44_2_1_U57", "Parent" : "4"},
	{"ID" : "23", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.src_loop_proc_U0.mul_32s_32ns_62_2_1_U58", "Parent" : "4"},
	{"ID" : "24", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dstin_loop_proc_U0", "Parent" : "0", "Child" : ["25"],
		"CDFG" : "dstin_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "14", "EstimateLatencyMax" : "653",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mapchip_draw_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "44", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "52", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "59", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstin", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "61", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstin_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "dst_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "dst_V2", "Type" : "Memory", "Direction" : "O", "DependentProc" : "26", "DependentChan" : "2"}]},
	{"ID" : "25", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstin_loop_proc_U0.mul_32ns_32s_62_2_1_U84", "Parent" : "24"},
	{"ID" : "26", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0", "Parent" : "0", "Child" : ["27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42"],
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
			{"Name" : "mapchip_draw_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "4", "DependentChan" : "64", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "4", "DependentChan" : "1"},
			{"Name" : "dst_V2", "Type" : "Memory", "Direction" : "I", "DependentProc" : "24", "DependentChan" : "2"},
			{"Name" : "alpha", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "62", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "alpha_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "trunc_ln1345", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "4", "DependentChan" : "65", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "trunc_ln1345_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "60", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstout", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "63", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstout_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "dst_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "27", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_32ns_32s_62_2_1_U92", "Parent" : "26"},
	{"ID" : "28", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_8ns_8ns_16_1_1_U93", "Parent" : "26"},
	{"ID" : "29", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_8ns_8ns_16_1_1_U94", "Parent" : "26"},
	{"ID" : "30", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_8ns_8ns_16_1_1_U95", "Parent" : "26"},
	{"ID" : "31", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mac_muladd_8ns_8ns_16ns_17_4_1_U96", "Parent" : "26"},
	{"ID" : "32", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mac_muladd_8ns_8ns_16ns_17_4_1_U97", "Parent" : "26"},
	{"ID" : "33", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mac_muladd_8ns_8ns_16ns_17_4_1_U98", "Parent" : "26"},
	{"ID" : "34", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U99", "Parent" : "26"},
	{"ID" : "35", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U100", "Parent" : "26"},
	{"ID" : "36", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U101", "Parent" : "26"},
	{"ID" : "37", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_10ns_8ns_17_4_1_U102", "Parent" : "26"},
	{"ID" : "38", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_10ns_8ns_17_4_1_U103", "Parent" : "26"},
	{"ID" : "39", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_10ns_8ns_17_4_1_U104", "Parent" : "26"},
	{"ID" : "40", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U105", "Parent" : "26"},
	{"ID" : "41", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U106", "Parent" : "26"},
	{"ID" : "42", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U107", "Parent" : "26"},
	{"ID" : "43", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mapchip_draw_xsize_c_U", "Parent" : "0"},
	{"ID" : "44", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mapchip_draw_xsize_c1_U", "Parent" : "0"},
	{"ID" : "45", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mapchip_maxwidth_c_U", "Parent" : "0"},
	{"ID" : "46", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.d_c_U", "Parent" : "0"},
	{"ID" : "47", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.a_c_U", "Parent" : "0"},
	{"ID" : "48", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.c_c_U", "Parent" : "0"},
	{"ID" : "49", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.b_c_U", "Parent" : "0"},
	{"ID" : "50", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.m_c_U", "Parent" : "0"},
	{"ID" : "51", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.trunc_ln1345_c_U", "Parent" : "0"},
	{"ID" : "52", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.trunc_ln1345_c2_U", "Parent" : "0"},
	{"ID" : "53", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mapchip_maxheight_c_U", "Parent" : "0"},
	{"ID" : "54", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.n_c_U", "Parent" : "0"},
	{"ID" : "55", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.id_c_U", "Parent" : "0"},
	{"ID" : "56", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.ystart_pos_c_U", "Parent" : "0"},
	{"ID" : "57", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.xstart_pos_c_U", "Parent" : "0"},
	{"ID" : "58", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.srcin_c_U", "Parent" : "0"},
	{"ID" : "59", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.frame_size_c_U", "Parent" : "0"},
	{"ID" : "60", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.frame_size_c3_U", "Parent" : "0"},
	{"ID" : "61", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dstin_c_U", "Parent" : "0"},
	{"ID" : "62", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.alpha_c_U", "Parent" : "0"},
	{"ID" : "63", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dstout_c_U", "Parent" : "0"},
	{"ID" : "64", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mapchip_draw_xsize_c4_U", "Parent" : "0"},
	{"ID" : "65", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.trunc_ln1345_c5_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	dataflow_in_loop_height_loop {
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
		src {Type I LastRead 61 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		dst {Type IO LastRead 12 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}}
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
		dstout_out {Type O LastRead -1 FirstWrite 0}}
	src_loop_proc {
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
		src_V1 {Type O LastRead -1 FirstWrite 62}
		id {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		src {Type I LastRead 61 FirstWrite -1}
		mapchip_draw_xsize_out {Type O LastRead -1 FirstWrite 0}
		trunc_ln1345_out {Type O LastRead -1 FirstWrite 0}}
	dstin_loop_proc {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		trunc_ln1345 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		dst {Type I LastRead 12 FirstWrite -1}
		dst_V2 {Type O LastRead -1 FirstWrite 13}}
	dstout_loop_proc {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		src_V1 {Type I LastRead 5 FirstWrite -1}
		dst_V2 {Type I LastRead 6 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		trunc_ln1345 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}
		dst {Type O LastRead 6 FirstWrite 19}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "89", "Max" : "1367"}
	, {"Name" : "Interval", "Min" : "64", "Max" : "703"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	mapchip_draw_xsize { ap_none {  { mapchip_draw_xsize in_data 0 32 }  { mapchip_draw_xsize_ap_vld in_vld 0 1 } } }
	mapchip_maxwidth { ap_none {  { mapchip_maxwidth in_data 0 32 }  { mapchip_maxwidth_ap_vld in_vld 0 1 } } }
	d { ap_none {  { d in_data 0 20 }  { d_ap_vld in_vld 0 1 } } }
	a { ap_none {  { a in_data 0 20 }  { a_ap_vld in_vld 0 1 } } }
	c { ap_none {  { c in_data 0 20 }  { c_ap_vld in_vld 0 1 } } }
	b { ap_none {  { b in_data 0 20 }  { b_ap_vld in_vld 0 1 } } }
	m { ap_none {  { m in_data 0 32 }  { m_ap_vld in_vld 0 1 } } }
	trunc_ln1345 { ap_none {  { trunc_ln1345 in_data 0 32 }  { trunc_ln1345_ap_vld in_vld 0 1 } } }
	mapchip_maxheight { ap_none {  { mapchip_maxheight in_data 0 32 }  { mapchip_maxheight_ap_vld in_vld 0 1 } } }
	n { ap_none {  { n in_data 0 32 }  { n_ap_vld in_vld 0 1 } } }
	id { ap_none {  { id in_data 0 32 }  { id_ap_vld in_vld 0 1 } } }
	ystart_pos { ap_none {  { ystart_pos in_data 0 32 }  { ystart_pos_ap_vld in_vld 0 1 } } }
	xstart_pos { ap_none {  { xstart_pos in_data 0 32 }  { xstart_pos_ap_vld in_vld 0 1 } } }
	srcin { ap_none {  { srcin in_data 0 64 }  { srcin_ap_vld in_vld 0 1 } } }
	src { m_axi {  { m_axi_src_AWVALID VALID 1 1 }  { m_axi_src_AWREADY READY 0 1 }  { m_axi_src_AWADDR ADDR 1 64 }  { m_axi_src_AWID ID 1 1 }  { m_axi_src_AWLEN LEN 1 32 }  { m_axi_src_AWSIZE SIZE 1 3 }  { m_axi_src_AWBURST BURST 1 2 }  { m_axi_src_AWLOCK LOCK 1 2 }  { m_axi_src_AWCACHE CACHE 1 4 }  { m_axi_src_AWPROT PROT 1 3 }  { m_axi_src_AWQOS QOS 1 4 }  { m_axi_src_AWREGION REGION 1 4 }  { m_axi_src_AWUSER USER 1 1 }  { m_axi_src_WVALID VALID 1 1 }  { m_axi_src_WREADY READY 0 1 }  { m_axi_src_WDATA DATA 1 32 }  { m_axi_src_WSTRB STRB 1 4 }  { m_axi_src_WLAST LAST 1 1 }  { m_axi_src_WID ID 1 1 }  { m_axi_src_WUSER USER 1 1 }  { m_axi_src_ARVALID VALID 1 1 }  { m_axi_src_ARREADY READY 0 1 }  { m_axi_src_ARADDR ADDR 1 64 }  { m_axi_src_ARID ID 1 1 }  { m_axi_src_ARLEN LEN 1 32 }  { m_axi_src_ARSIZE SIZE 1 3 }  { m_axi_src_ARBURST BURST 1 2 }  { m_axi_src_ARLOCK LOCK 1 2 }  { m_axi_src_ARCACHE CACHE 1 4 }  { m_axi_src_ARPROT PROT 1 3 }  { m_axi_src_ARQOS QOS 1 4 }  { m_axi_src_ARREGION REGION 1 4 }  { m_axi_src_ARUSER USER 1 1 }  { m_axi_src_RVALID VALID 0 1 }  { m_axi_src_RREADY READY 1 1 }  { m_axi_src_RDATA DATA 0 32 }  { m_axi_src_RLAST LAST 0 1 }  { m_axi_src_RID ID 0 1 }  { m_axi_src_RUSER USER 0 1 }  { m_axi_src_RRESP RESP 0 2 }  { m_axi_src_BVALID VALID 0 1 }  { m_axi_src_BREADY READY 1 1 }  { m_axi_src_BRESP RESP 0 2 }  { m_axi_src_BID ID 0 1 }  { m_axi_src_BUSER USER 0 1 } } }
	frame_size { ap_none {  { frame_size in_data 0 32 }  { frame_size_ap_vld in_vld 0 1 } } }
	dstin { ap_none {  { dstin in_data 0 64 }  { dstin_ap_vld in_vld 0 1 } } }
	dst { m_axi {  { m_axi_dst_AWVALID VALID 1 1 }  { m_axi_dst_AWREADY READY 0 1 }  { m_axi_dst_AWADDR ADDR 1 64 }  { m_axi_dst_AWID ID 1 1 }  { m_axi_dst_AWLEN LEN 1 32 }  { m_axi_dst_AWSIZE SIZE 1 3 }  { m_axi_dst_AWBURST BURST 1 2 }  { m_axi_dst_AWLOCK LOCK 1 2 }  { m_axi_dst_AWCACHE CACHE 1 4 }  { m_axi_dst_AWPROT PROT 1 3 }  { m_axi_dst_AWQOS QOS 1 4 }  { m_axi_dst_AWREGION REGION 1 4 }  { m_axi_dst_AWUSER USER 1 1 }  { m_axi_dst_WVALID VALID 1 1 }  { m_axi_dst_WREADY READY 0 1 }  { m_axi_dst_WDATA DATA 1 32 }  { m_axi_dst_WSTRB STRB 1 4 }  { m_axi_dst_WLAST LAST 1 1 }  { m_axi_dst_WID ID 1 1 }  { m_axi_dst_WUSER USER 1 1 }  { m_axi_dst_ARVALID VALID 1 1 }  { m_axi_dst_ARREADY READY 0 1 }  { m_axi_dst_ARADDR ADDR 1 64 }  { m_axi_dst_ARID ID 1 1 }  { m_axi_dst_ARLEN LEN 1 32 }  { m_axi_dst_ARSIZE SIZE 1 3 }  { m_axi_dst_ARBURST BURST 1 2 }  { m_axi_dst_ARLOCK LOCK 1 2 }  { m_axi_dst_ARCACHE CACHE 1 4 }  { m_axi_dst_ARPROT PROT 1 3 }  { m_axi_dst_ARQOS QOS 1 4 }  { m_axi_dst_ARREGION REGION 1 4 }  { m_axi_dst_ARUSER USER 1 1 }  { m_axi_dst_RVALID VALID 0 1 }  { m_axi_dst_RREADY READY 1 1 }  { m_axi_dst_RDATA DATA 0 32 }  { m_axi_dst_RLAST LAST 0 1 }  { m_axi_dst_RID ID 0 1 }  { m_axi_dst_RUSER USER 0 1 }  { m_axi_dst_RRESP RESP 0 2 }  { m_axi_dst_BVALID VALID 0 1 }  { m_axi_dst_BREADY READY 1 1 }  { m_axi_dst_BRESP RESP 0 2 }  { m_axi_dst_BID ID 0 1 }  { m_axi_dst_BUSER USER 0 1 } } }
	alpha { ap_none {  { alpha in_data 0 8 }  { alpha_ap_vld in_vld 0 1 } } }
	dstout { ap_none {  { dstout in_data 0 64 }  { dstout_ap_vld in_vld 0 1 } } }
}
