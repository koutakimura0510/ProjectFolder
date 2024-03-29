set moduleName dataflow_parent_loop_proc3
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {dataflow_parent_loop_proc3}
set C_modelType { void 0 }
set C_modelArgList {
	{ height int 32 regular  }
	{ width int 32 regular  }
	{ frame_size int 32 regular  }
	{ ddr_copy int 64 regular  }
	{ copy int 32 regular {axi_master 0}  }
	{ ddr_update int 64 regular  }
	{ update int 32 regular {axi_master 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "height", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "width", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "frame_size", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ddr_copy", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "copy", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ddr_update", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "update", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 106
set portList { 
	{ height sc_in sc_lv 32 signal 0 } 
	{ width sc_in sc_lv 32 signal 1 } 
	{ frame_size sc_in sc_lv 32 signal 2 } 
	{ ddr_copy sc_in sc_lv 64 signal 3 } 
	{ m_axi_copy_AWVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_copy_AWREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_copy_AWADDR sc_out sc_lv 64 signal 4 } 
	{ m_axi_copy_AWID sc_out sc_lv 1 signal 4 } 
	{ m_axi_copy_AWLEN sc_out sc_lv 32 signal 4 } 
	{ m_axi_copy_AWSIZE sc_out sc_lv 3 signal 4 } 
	{ m_axi_copy_AWBURST sc_out sc_lv 2 signal 4 } 
	{ m_axi_copy_AWLOCK sc_out sc_lv 2 signal 4 } 
	{ m_axi_copy_AWCACHE sc_out sc_lv 4 signal 4 } 
	{ m_axi_copy_AWPROT sc_out sc_lv 3 signal 4 } 
	{ m_axi_copy_AWQOS sc_out sc_lv 4 signal 4 } 
	{ m_axi_copy_AWREGION sc_out sc_lv 4 signal 4 } 
	{ m_axi_copy_AWUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_copy_WVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_copy_WREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_copy_WDATA sc_out sc_lv 32 signal 4 } 
	{ m_axi_copy_WSTRB sc_out sc_lv 4 signal 4 } 
	{ m_axi_copy_WLAST sc_out sc_logic 1 signal 4 } 
	{ m_axi_copy_WID sc_out sc_lv 1 signal 4 } 
	{ m_axi_copy_WUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_copy_ARVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_copy_ARREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_copy_ARADDR sc_out sc_lv 64 signal 4 } 
	{ m_axi_copy_ARID sc_out sc_lv 1 signal 4 } 
	{ m_axi_copy_ARLEN sc_out sc_lv 32 signal 4 } 
	{ m_axi_copy_ARSIZE sc_out sc_lv 3 signal 4 } 
	{ m_axi_copy_ARBURST sc_out sc_lv 2 signal 4 } 
	{ m_axi_copy_ARLOCK sc_out sc_lv 2 signal 4 } 
	{ m_axi_copy_ARCACHE sc_out sc_lv 4 signal 4 } 
	{ m_axi_copy_ARPROT sc_out sc_lv 3 signal 4 } 
	{ m_axi_copy_ARQOS sc_out sc_lv 4 signal 4 } 
	{ m_axi_copy_ARREGION sc_out sc_lv 4 signal 4 } 
	{ m_axi_copy_ARUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_copy_RVALID sc_in sc_logic 1 signal 4 } 
	{ m_axi_copy_RREADY sc_out sc_logic 1 signal 4 } 
	{ m_axi_copy_RDATA sc_in sc_lv 32 signal 4 } 
	{ m_axi_copy_RLAST sc_in sc_logic 1 signal 4 } 
	{ m_axi_copy_RID sc_in sc_lv 1 signal 4 } 
	{ m_axi_copy_RUSER sc_in sc_lv 1 signal 4 } 
	{ m_axi_copy_RRESP sc_in sc_lv 2 signal 4 } 
	{ m_axi_copy_BVALID sc_in sc_logic 1 signal 4 } 
	{ m_axi_copy_BREADY sc_out sc_logic 1 signal 4 } 
	{ m_axi_copy_BRESP sc_in sc_lv 2 signal 4 } 
	{ m_axi_copy_BID sc_in sc_lv 1 signal 4 } 
	{ m_axi_copy_BUSER sc_in sc_lv 1 signal 4 } 
	{ ddr_update sc_in sc_lv 64 signal 5 } 
	{ m_axi_update_AWVALID sc_out sc_logic 1 signal 6 } 
	{ m_axi_update_AWREADY sc_in sc_logic 1 signal 6 } 
	{ m_axi_update_AWADDR sc_out sc_lv 64 signal 6 } 
	{ m_axi_update_AWID sc_out sc_lv 1 signal 6 } 
	{ m_axi_update_AWLEN sc_out sc_lv 32 signal 6 } 
	{ m_axi_update_AWSIZE sc_out sc_lv 3 signal 6 } 
	{ m_axi_update_AWBURST sc_out sc_lv 2 signal 6 } 
	{ m_axi_update_AWLOCK sc_out sc_lv 2 signal 6 } 
	{ m_axi_update_AWCACHE sc_out sc_lv 4 signal 6 } 
	{ m_axi_update_AWPROT sc_out sc_lv 3 signal 6 } 
	{ m_axi_update_AWQOS sc_out sc_lv 4 signal 6 } 
	{ m_axi_update_AWREGION sc_out sc_lv 4 signal 6 } 
	{ m_axi_update_AWUSER sc_out sc_lv 1 signal 6 } 
	{ m_axi_update_WVALID sc_out sc_logic 1 signal 6 } 
	{ m_axi_update_WREADY sc_in sc_logic 1 signal 6 } 
	{ m_axi_update_WDATA sc_out sc_lv 32 signal 6 } 
	{ m_axi_update_WSTRB sc_out sc_lv 4 signal 6 } 
	{ m_axi_update_WLAST sc_out sc_logic 1 signal 6 } 
	{ m_axi_update_WID sc_out sc_lv 1 signal 6 } 
	{ m_axi_update_WUSER sc_out sc_lv 1 signal 6 } 
	{ m_axi_update_ARVALID sc_out sc_logic 1 signal 6 } 
	{ m_axi_update_ARREADY sc_in sc_logic 1 signal 6 } 
	{ m_axi_update_ARADDR sc_out sc_lv 64 signal 6 } 
	{ m_axi_update_ARID sc_out sc_lv 1 signal 6 } 
	{ m_axi_update_ARLEN sc_out sc_lv 32 signal 6 } 
	{ m_axi_update_ARSIZE sc_out sc_lv 3 signal 6 } 
	{ m_axi_update_ARBURST sc_out sc_lv 2 signal 6 } 
	{ m_axi_update_ARLOCK sc_out sc_lv 2 signal 6 } 
	{ m_axi_update_ARCACHE sc_out sc_lv 4 signal 6 } 
	{ m_axi_update_ARPROT sc_out sc_lv 3 signal 6 } 
	{ m_axi_update_ARQOS sc_out sc_lv 4 signal 6 } 
	{ m_axi_update_ARREGION sc_out sc_lv 4 signal 6 } 
	{ m_axi_update_ARUSER sc_out sc_lv 1 signal 6 } 
	{ m_axi_update_RVALID sc_in sc_logic 1 signal 6 } 
	{ m_axi_update_RREADY sc_out sc_logic 1 signal 6 } 
	{ m_axi_update_RDATA sc_in sc_lv 32 signal 6 } 
	{ m_axi_update_RLAST sc_in sc_logic 1 signal 6 } 
	{ m_axi_update_RID sc_in sc_lv 1 signal 6 } 
	{ m_axi_update_RUSER sc_in sc_lv 1 signal 6 } 
	{ m_axi_update_RRESP sc_in sc_lv 2 signal 6 } 
	{ m_axi_update_BVALID sc_in sc_logic 1 signal 6 } 
	{ m_axi_update_BREADY sc_out sc_logic 1 signal 6 } 
	{ m_axi_update_BRESP sc_in sc_lv 2 signal 6 } 
	{ m_axi_update_BID sc_in sc_lv 1 signal 6 } 
	{ m_axi_update_BUSER sc_in sc_lv 1 signal 6 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ width_ap_vld sc_in sc_logic 1 invld 1 } 
	{ frame_size_ap_vld sc_in sc_logic 1 invld 2 } 
	{ ddr_copy_ap_vld sc_in sc_logic 1 invld 3 } 
	{ ddr_update_ap_vld sc_in sc_logic 1 invld 5 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
}
set NewPortList {[ 
	{ "name": "height", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "height", "role": "default" }} , 
 	{ "name": "width", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "width", "role": "default" }} , 
 	{ "name": "frame_size", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size", "role": "default" }} , 
 	{ "name": "ddr_copy", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ddr_copy", "role": "default" }} , 
 	{ "name": "m_axi_copy_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWVALID" }} , 
 	{ "name": "m_axi_copy_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWREADY" }} , 
 	{ "name": "m_axi_copy_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "copy", "role": "AWADDR" }} , 
 	{ "name": "m_axi_copy_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWID" }} , 
 	{ "name": "m_axi_copy_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "copy", "role": "AWLEN" }} , 
 	{ "name": "m_axi_copy_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_copy_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "AWBURST" }} , 
 	{ "name": "m_axi_copy_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_copy_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_copy_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "AWPROT" }} , 
 	{ "name": "m_axi_copy_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "AWQOS" }} , 
 	{ "name": "m_axi_copy_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "AWREGION" }} , 
 	{ "name": "m_axi_copy_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "AWUSER" }} , 
 	{ "name": "m_axi_copy_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WVALID" }} , 
 	{ "name": "m_axi_copy_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WREADY" }} , 
 	{ "name": "m_axi_copy_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "copy", "role": "WDATA" }} , 
 	{ "name": "m_axi_copy_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "WSTRB" }} , 
 	{ "name": "m_axi_copy_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WLAST" }} , 
 	{ "name": "m_axi_copy_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WID" }} , 
 	{ "name": "m_axi_copy_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "WUSER" }} , 
 	{ "name": "m_axi_copy_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARVALID" }} , 
 	{ "name": "m_axi_copy_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARREADY" }} , 
 	{ "name": "m_axi_copy_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "copy", "role": "ARADDR" }} , 
 	{ "name": "m_axi_copy_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARID" }} , 
 	{ "name": "m_axi_copy_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "copy", "role": "ARLEN" }} , 
 	{ "name": "m_axi_copy_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_copy_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "ARBURST" }} , 
 	{ "name": "m_axi_copy_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_copy_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_copy_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "copy", "role": "ARPROT" }} , 
 	{ "name": "m_axi_copy_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "ARQOS" }} , 
 	{ "name": "m_axi_copy_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "copy", "role": "ARREGION" }} , 
 	{ "name": "m_axi_copy_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "ARUSER" }} , 
 	{ "name": "m_axi_copy_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RVALID" }} , 
 	{ "name": "m_axi_copy_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RREADY" }} , 
 	{ "name": "m_axi_copy_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "copy", "role": "RDATA" }} , 
 	{ "name": "m_axi_copy_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RLAST" }} , 
 	{ "name": "m_axi_copy_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RID" }} , 
 	{ "name": "m_axi_copy_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "RUSER" }} , 
 	{ "name": "m_axi_copy_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "RRESP" }} , 
 	{ "name": "m_axi_copy_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BVALID" }} , 
 	{ "name": "m_axi_copy_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BREADY" }} , 
 	{ "name": "m_axi_copy_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "copy", "role": "BRESP" }} , 
 	{ "name": "m_axi_copy_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BID" }} , 
 	{ "name": "m_axi_copy_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "copy", "role": "BUSER" }} , 
 	{ "name": "ddr_update", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ddr_update", "role": "default" }} , 
 	{ "name": "m_axi_update_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWVALID" }} , 
 	{ "name": "m_axi_update_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWREADY" }} , 
 	{ "name": "m_axi_update_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "update", "role": "AWADDR" }} , 
 	{ "name": "m_axi_update_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWID" }} , 
 	{ "name": "m_axi_update_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "update", "role": "AWLEN" }} , 
 	{ "name": "m_axi_update_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_update_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "AWBURST" }} , 
 	{ "name": "m_axi_update_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_update_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_update_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "AWPROT" }} , 
 	{ "name": "m_axi_update_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "AWQOS" }} , 
 	{ "name": "m_axi_update_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "AWREGION" }} , 
 	{ "name": "m_axi_update_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "AWUSER" }} , 
 	{ "name": "m_axi_update_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WVALID" }} , 
 	{ "name": "m_axi_update_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WREADY" }} , 
 	{ "name": "m_axi_update_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "update", "role": "WDATA" }} , 
 	{ "name": "m_axi_update_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "WSTRB" }} , 
 	{ "name": "m_axi_update_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WLAST" }} , 
 	{ "name": "m_axi_update_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WID" }} , 
 	{ "name": "m_axi_update_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "WUSER" }} , 
 	{ "name": "m_axi_update_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARVALID" }} , 
 	{ "name": "m_axi_update_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARREADY" }} , 
 	{ "name": "m_axi_update_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "update", "role": "ARADDR" }} , 
 	{ "name": "m_axi_update_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARID" }} , 
 	{ "name": "m_axi_update_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "update", "role": "ARLEN" }} , 
 	{ "name": "m_axi_update_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_update_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "ARBURST" }} , 
 	{ "name": "m_axi_update_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_update_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_update_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "update", "role": "ARPROT" }} , 
 	{ "name": "m_axi_update_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "ARQOS" }} , 
 	{ "name": "m_axi_update_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "update", "role": "ARREGION" }} , 
 	{ "name": "m_axi_update_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "ARUSER" }} , 
 	{ "name": "m_axi_update_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RVALID" }} , 
 	{ "name": "m_axi_update_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RREADY" }} , 
 	{ "name": "m_axi_update_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "update", "role": "RDATA" }} , 
 	{ "name": "m_axi_update_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RLAST" }} , 
 	{ "name": "m_axi_update_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RID" }} , 
 	{ "name": "m_axi_update_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "RUSER" }} , 
 	{ "name": "m_axi_update_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "RRESP" }} , 
 	{ "name": "m_axi_update_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BVALID" }} , 
 	{ "name": "m_axi_update_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BREADY" }} , 
 	{ "name": "m_axi_update_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "update", "role": "BRESP" }} , 
 	{ "name": "m_axi_update_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BID" }} , 
 	{ "name": "m_axi_update_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BUSER" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "width_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "width", "role": "ap_vld" }} , 
 	{ "name": "frame_size_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "frame_size", "role": "ap_vld" }} , 
 	{ "name": "ddr_copy_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "ddr_copy", "role": "ap_vld" }} , 
 	{ "name": "ddr_update_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "ddr_update", "role": "ap_vld" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "dataflow_parent_loop_proc3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "29", "EstimateLatencyMax" : "314094",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "1", "Name" : "dataflow_in_loop_right_height_loop_U0"}],
		"OutputProcess" : [
			{"ID" : "1", "Name" : "dataflow_in_loop_right_height_loop_U0"}],
		"Port" : [
			{"Name" : "height", "Type" : "None", "Direction" : "I"},
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "dataflow_in_loop_right_height_loop_U0", "Port" : "copy"}]},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "dataflow_in_loop_right_height_loop_U0", "Port" : "update"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0", "Parent" : "0", "Child" : ["2", "3", "5", "7", "8", "9", "10"],
		"CDFG" : "dataflow_in_loop_right_height_loop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "26", "EstimateLatencyMax" : "1304",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "3", "Name" : "right_width_loop_proc8_U0"}],
		"OutputProcess" : [
			{"ID" : "5", "Name" : "right_copy_loop_proc_U0"}],
		"Port" : [
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "right_width_loop_proc8_U0", "Port" : "copy"}]},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "right_copy_loop_proc_U0", "Port" : "update"}]}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.xcopy_V_U", "Parent" : "1"},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.right_width_loop_proc8_U0", "Parent" : "1", "Child" : ["4"],
		"CDFG" : "right_width_loop_proc8",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "13", "EstimateLatencyMax" : "652",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "y_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "copy_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "copy_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "xcopy_V1", "Type" : "Memory", "Direction" : "O", "DependentProc" : "5", "DependentChan" : "2"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"},
			{"Name" : "width_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "5", "DependentChan" : "7", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_1_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "5", "DependentChan" : "8", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_1_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "5", "DependentChan" : "9", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ddr_update_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "5", "DependentChan" : "10", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ddr_update_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "4", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.right_width_loop_proc8_U0.mul_32ns_32ns_62_2_1_U21", "Parent" : "3"},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.right_copy_loop_proc_U0", "Parent" : "1", "Child" : ["6"],
		"CDFG" : "right_copy_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "12", "EstimateLatencyMax" : "651",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "width", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "7", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_1", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "8", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "9", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xcopy_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "2"},
			{"Name" : "ddr_update", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "3", "DependentChan" : "10", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ddr_update_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "update_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "6", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.right_copy_loop_proc_U0.mul_32ns_32ns_62_2_1_U33", "Parent" : "5"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.width_c_U", "Parent" : "1"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.y_1_c_U", "Parent" : "1"},
	{"ID" : "9", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.frame_size_c_U", "Parent" : "1"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_right_height_loop_U0.ddr_update_c_U", "Parent" : "1"}]}


set ArgLastReadFirstWriteLatency {
	dataflow_parent_loop_proc3 {
		height {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 0 FirstWrite -1}
		copy {Type I LastRead 11 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 7}}
	dataflow_in_loop_right_height_loop {
		width {Type I LastRead 0 FirstWrite -1}
		y_1 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 0 FirstWrite -1}
		copy {Type I LastRead 11 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 7}}
	right_width_loop_proc8 {
		width {Type I LastRead 0 FirstWrite -1}
		y_1 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_copy {Type I LastRead 2 FirstWrite -1}
		copy {Type I LastRead 11 FirstWrite -1}
		xcopy_V1 {Type O LastRead -1 FirstWrite 12}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		width_out {Type O LastRead -1 FirstWrite 0}
		y_1_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out {Type O LastRead -1 FirstWrite 0}
		ddr_update_out {Type O LastRead -1 FirstWrite 0}}
	right_copy_loop_proc {
		width {Type I LastRead 0 FirstWrite -1}
		y_1 {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		xcopy_V1 {Type I LastRead 5 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 7}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "29", "Max" : "314094"}
	, {"Name" : "Interval", "Min" : "29", "Max" : "314094"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	height { ap_none {  { height in_data 0 32 } } }
	width { ap_none {  { width in_data 0 32 }  { width_ap_vld in_vld 0 1 } } }
	frame_size { ap_none {  { frame_size in_data 0 32 }  { frame_size_ap_vld in_vld 0 1 } } }
	ddr_copy { ap_none {  { ddr_copy in_data 0 64 }  { ddr_copy_ap_vld in_vld 0 1 } } }
	copy { m_axi {  { m_axi_copy_AWVALID VALID 1 1 }  { m_axi_copy_AWREADY READY 0 1 }  { m_axi_copy_AWADDR ADDR 1 64 }  { m_axi_copy_AWID ID 1 1 }  { m_axi_copy_AWLEN LEN 1 32 }  { m_axi_copy_AWSIZE SIZE 1 3 }  { m_axi_copy_AWBURST BURST 1 2 }  { m_axi_copy_AWLOCK LOCK 1 2 }  { m_axi_copy_AWCACHE CACHE 1 4 }  { m_axi_copy_AWPROT PROT 1 3 }  { m_axi_copy_AWQOS QOS 1 4 }  { m_axi_copy_AWREGION REGION 1 4 }  { m_axi_copy_AWUSER USER 1 1 }  { m_axi_copy_WVALID VALID 1 1 }  { m_axi_copy_WREADY READY 0 1 }  { m_axi_copy_WDATA DATA 1 32 }  { m_axi_copy_WSTRB STRB 1 4 }  { m_axi_copy_WLAST LAST 1 1 }  { m_axi_copy_WID ID 1 1 }  { m_axi_copy_WUSER USER 1 1 }  { m_axi_copy_ARVALID VALID 1 1 }  { m_axi_copy_ARREADY READY 0 1 }  { m_axi_copy_ARADDR ADDR 1 64 }  { m_axi_copy_ARID ID 1 1 }  { m_axi_copy_ARLEN LEN 1 32 }  { m_axi_copy_ARSIZE SIZE 1 3 }  { m_axi_copy_ARBURST BURST 1 2 }  { m_axi_copy_ARLOCK LOCK 1 2 }  { m_axi_copy_ARCACHE CACHE 1 4 }  { m_axi_copy_ARPROT PROT 1 3 }  { m_axi_copy_ARQOS QOS 1 4 }  { m_axi_copy_ARREGION REGION 1 4 }  { m_axi_copy_ARUSER USER 1 1 }  { m_axi_copy_RVALID VALID 0 1 }  { m_axi_copy_RREADY READY 1 1 }  { m_axi_copy_RDATA DATA 0 32 }  { m_axi_copy_RLAST LAST 0 1 }  { m_axi_copy_RID ID 0 1 }  { m_axi_copy_RUSER USER 0 1 }  { m_axi_copy_RRESP RESP 0 2 }  { m_axi_copy_BVALID VALID 0 1 }  { m_axi_copy_BREADY READY 1 1 }  { m_axi_copy_BRESP RESP 0 2 }  { m_axi_copy_BID ID 0 1 }  { m_axi_copy_BUSER USER 0 1 } } }
	ddr_update { ap_none {  { ddr_update in_data 0 64 }  { ddr_update_ap_vld in_vld 0 1 } } }
	update { m_axi {  { m_axi_update_AWVALID VALID 1 1 }  { m_axi_update_AWREADY READY 0 1 }  { m_axi_update_AWADDR ADDR 1 64 }  { m_axi_update_AWID ID 1 1 }  { m_axi_update_AWLEN LEN 1 32 }  { m_axi_update_AWSIZE SIZE 1 3 }  { m_axi_update_AWBURST BURST 1 2 }  { m_axi_update_AWLOCK LOCK 1 2 }  { m_axi_update_AWCACHE CACHE 1 4 }  { m_axi_update_AWPROT PROT 1 3 }  { m_axi_update_AWQOS QOS 1 4 }  { m_axi_update_AWREGION REGION 1 4 }  { m_axi_update_AWUSER USER 1 1 }  { m_axi_update_WVALID VALID 1 1 }  { m_axi_update_WREADY READY 0 1 }  { m_axi_update_WDATA DATA 1 32 }  { m_axi_update_WSTRB STRB 1 4 }  { m_axi_update_WLAST LAST 1 1 }  { m_axi_update_WID ID 1 1 }  { m_axi_update_WUSER USER 1 1 }  { m_axi_update_ARVALID VALID 1 1 }  { m_axi_update_ARREADY READY 0 1 }  { m_axi_update_ARADDR ADDR 1 64 }  { m_axi_update_ARID ID 1 1 }  { m_axi_update_ARLEN LEN 1 32 }  { m_axi_update_ARSIZE SIZE 1 3 }  { m_axi_update_ARBURST BURST 1 2 }  { m_axi_update_ARLOCK LOCK 1 2 }  { m_axi_update_ARCACHE CACHE 1 4 }  { m_axi_update_ARPROT PROT 1 3 }  { m_axi_update_ARQOS QOS 1 4 }  { m_axi_update_ARREGION REGION 1 4 }  { m_axi_update_ARUSER USER 1 1 }  { m_axi_update_RVALID VALID 0 1 }  { m_axi_update_RREADY READY 1 1 }  { m_axi_update_RDATA DATA 0 32 }  { m_axi_update_RLAST LAST 0 1 }  { m_axi_update_RID ID 0 1 }  { m_axi_update_RUSER USER 0 1 }  { m_axi_update_RRESP RESP 0 2 }  { m_axi_update_BVALID VALID 0 1 }  { m_axi_update_BREADY READY 1 1 }  { m_axi_update_BRESP RESP 0 2 }  { m_axi_update_BID ID 0 1 }  { m_axi_update_BUSER USER 0 1 } } }
}
