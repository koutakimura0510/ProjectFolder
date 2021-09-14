set moduleName width_loop_proc5
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
set C_modelName {width_loop_proc5}
set C_modelType { void 0 }
set C_modelArgList {
	{ width int 32 regular  }
	{ y int 32 regular  }
	{ display_xsize int 32 regular  }
	{ copy int 64 regular  }
	{ cp int 32 regular {axi_master 0}  }
	{ src_V1 int 32 regular {array 640 { 0 3 } 0 1 }  }
	{ update int 64 regular  }
	{ width_out int 32 regular {fifo 1}  }
	{ y_out int 32 regular {fifo 1}  }
	{ display_xsize_out int 32 regular {fifo 1}  }
	{ update_out int 64 regular {fifo 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "width", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "display_xsize", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "copy", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "cp", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "src_V1", "interface" : "memory", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "update", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "width_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "y_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "display_xsize_out", "interface" : "fifo", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "update_out", "interface" : "fifo", "bitwidth" : 64, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 73
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ width sc_in sc_lv 32 signal 0 } 
	{ y sc_in sc_lv 32 signal 1 } 
	{ display_xsize sc_in sc_lv 32 signal 2 } 
	{ copy sc_in sc_lv 64 signal 3 } 
	{ m_axi_cp_AWVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_cp_AWREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_cp_AWADDR sc_out sc_lv 64 signal 4 } 
	{ m_axi_cp_AWID sc_out sc_lv 1 signal 4 } 
	{ m_axi_cp_AWLEN sc_out sc_lv 32 signal 4 } 
	{ m_axi_cp_AWSIZE sc_out sc_lv 3 signal 4 } 
	{ m_axi_cp_AWBURST sc_out sc_lv 2 signal 4 } 
	{ m_axi_cp_AWLOCK sc_out sc_lv 2 signal 4 } 
	{ m_axi_cp_AWCACHE sc_out sc_lv 4 signal 4 } 
	{ m_axi_cp_AWPROT sc_out sc_lv 3 signal 4 } 
	{ m_axi_cp_AWQOS sc_out sc_lv 4 signal 4 } 
	{ m_axi_cp_AWREGION sc_out sc_lv 4 signal 4 } 
	{ m_axi_cp_AWUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_cp_WVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_cp_WREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_cp_WDATA sc_out sc_lv 32 signal 4 } 
	{ m_axi_cp_WSTRB sc_out sc_lv 4 signal 4 } 
	{ m_axi_cp_WLAST sc_out sc_logic 1 signal 4 } 
	{ m_axi_cp_WID sc_out sc_lv 1 signal 4 } 
	{ m_axi_cp_WUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_cp_ARVALID sc_out sc_logic 1 signal 4 } 
	{ m_axi_cp_ARREADY sc_in sc_logic 1 signal 4 } 
	{ m_axi_cp_ARADDR sc_out sc_lv 64 signal 4 } 
	{ m_axi_cp_ARID sc_out sc_lv 1 signal 4 } 
	{ m_axi_cp_ARLEN sc_out sc_lv 32 signal 4 } 
	{ m_axi_cp_ARSIZE sc_out sc_lv 3 signal 4 } 
	{ m_axi_cp_ARBURST sc_out sc_lv 2 signal 4 } 
	{ m_axi_cp_ARLOCK sc_out sc_lv 2 signal 4 } 
	{ m_axi_cp_ARCACHE sc_out sc_lv 4 signal 4 } 
	{ m_axi_cp_ARPROT sc_out sc_lv 3 signal 4 } 
	{ m_axi_cp_ARQOS sc_out sc_lv 4 signal 4 } 
	{ m_axi_cp_ARREGION sc_out sc_lv 4 signal 4 } 
	{ m_axi_cp_ARUSER sc_out sc_lv 1 signal 4 } 
	{ m_axi_cp_RVALID sc_in sc_logic 1 signal 4 } 
	{ m_axi_cp_RREADY sc_out sc_logic 1 signal 4 } 
	{ m_axi_cp_RDATA sc_in sc_lv 32 signal 4 } 
	{ m_axi_cp_RLAST sc_in sc_logic 1 signal 4 } 
	{ m_axi_cp_RID sc_in sc_lv 1 signal 4 } 
	{ m_axi_cp_RUSER sc_in sc_lv 1 signal 4 } 
	{ m_axi_cp_RRESP sc_in sc_lv 2 signal 4 } 
	{ m_axi_cp_BVALID sc_in sc_logic 1 signal 4 } 
	{ m_axi_cp_BREADY sc_out sc_logic 1 signal 4 } 
	{ m_axi_cp_BRESP sc_in sc_lv 2 signal 4 } 
	{ m_axi_cp_BID sc_in sc_lv 1 signal 4 } 
	{ m_axi_cp_BUSER sc_in sc_lv 1 signal 4 } 
	{ src_V1_address0 sc_out sc_lv 10 signal 5 } 
	{ src_V1_ce0 sc_out sc_logic 1 signal 5 } 
	{ src_V1_we0 sc_out sc_logic 1 signal 5 } 
	{ src_V1_d0 sc_out sc_lv 32 signal 5 } 
	{ update sc_in sc_lv 64 signal 6 } 
	{ width_out_din sc_out sc_lv 32 signal 7 } 
	{ width_out_full_n sc_in sc_logic 1 signal 7 } 
	{ width_out_write sc_out sc_logic 1 signal 7 } 
	{ y_out_din sc_out sc_lv 32 signal 8 } 
	{ y_out_full_n sc_in sc_logic 1 signal 8 } 
	{ y_out_write sc_out sc_logic 1 signal 8 } 
	{ display_xsize_out_din sc_out sc_lv 32 signal 9 } 
	{ display_xsize_out_full_n sc_in sc_logic 1 signal 9 } 
	{ display_xsize_out_write sc_out sc_logic 1 signal 9 } 
	{ update_out_din sc_out sc_lv 64 signal 10 } 
	{ update_out_full_n sc_in sc_logic 1 signal 10 } 
	{ update_out_write sc_out sc_logic 1 signal 10 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "width", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "width", "role": "default" }} , 
 	{ "name": "y", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y", "role": "default" }} , 
 	{ "name": "display_xsize", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "display_xsize", "role": "default" }} , 
 	{ "name": "copy", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "copy", "role": "default" }} , 
 	{ "name": "m_axi_cp_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "AWVALID" }} , 
 	{ "name": "m_axi_cp_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "AWREADY" }} , 
 	{ "name": "m_axi_cp_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "cp", "role": "AWADDR" }} , 
 	{ "name": "m_axi_cp_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "AWID" }} , 
 	{ "name": "m_axi_cp_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cp", "role": "AWLEN" }} , 
 	{ "name": "m_axi_cp_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cp", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_cp_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "cp", "role": "AWBURST" }} , 
 	{ "name": "m_axi_cp_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "cp", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_cp_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "cp", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_cp_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cp", "role": "AWPROT" }} , 
 	{ "name": "m_axi_cp_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "cp", "role": "AWQOS" }} , 
 	{ "name": "m_axi_cp_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "cp", "role": "AWREGION" }} , 
 	{ "name": "m_axi_cp_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "AWUSER" }} , 
 	{ "name": "m_axi_cp_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "WVALID" }} , 
 	{ "name": "m_axi_cp_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "WREADY" }} , 
 	{ "name": "m_axi_cp_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cp", "role": "WDATA" }} , 
 	{ "name": "m_axi_cp_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "cp", "role": "WSTRB" }} , 
 	{ "name": "m_axi_cp_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "WLAST" }} , 
 	{ "name": "m_axi_cp_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "WID" }} , 
 	{ "name": "m_axi_cp_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "WUSER" }} , 
 	{ "name": "m_axi_cp_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "ARVALID" }} , 
 	{ "name": "m_axi_cp_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "ARREADY" }} , 
 	{ "name": "m_axi_cp_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "cp", "role": "ARADDR" }} , 
 	{ "name": "m_axi_cp_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "ARID" }} , 
 	{ "name": "m_axi_cp_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cp", "role": "ARLEN" }} , 
 	{ "name": "m_axi_cp_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cp", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_cp_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "cp", "role": "ARBURST" }} , 
 	{ "name": "m_axi_cp_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "cp", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_cp_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "cp", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_cp_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "cp", "role": "ARPROT" }} , 
 	{ "name": "m_axi_cp_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "cp", "role": "ARQOS" }} , 
 	{ "name": "m_axi_cp_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "cp", "role": "ARREGION" }} , 
 	{ "name": "m_axi_cp_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "ARUSER" }} , 
 	{ "name": "m_axi_cp_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "RVALID" }} , 
 	{ "name": "m_axi_cp_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "RREADY" }} , 
 	{ "name": "m_axi_cp_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "cp", "role": "RDATA" }} , 
 	{ "name": "m_axi_cp_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "RLAST" }} , 
 	{ "name": "m_axi_cp_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "RID" }} , 
 	{ "name": "m_axi_cp_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "RUSER" }} , 
 	{ "name": "m_axi_cp_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "cp", "role": "RRESP" }} , 
 	{ "name": "m_axi_cp_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "BVALID" }} , 
 	{ "name": "m_axi_cp_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "BREADY" }} , 
 	{ "name": "m_axi_cp_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "cp", "role": "BRESP" }} , 
 	{ "name": "m_axi_cp_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "BID" }} , 
 	{ "name": "m_axi_cp_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "BUSER" }} , 
 	{ "name": "src_V1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "src_V1", "role": "address0" }} , 
 	{ "name": "src_V1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src_V1", "role": "ce0" }} , 
 	{ "name": "src_V1_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src_V1", "role": "we0" }} , 
 	{ "name": "src_V1_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src_V1", "role": "d0" }} , 
 	{ "name": "update", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "update", "role": "default" }} , 
 	{ "name": "width_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "width_out", "role": "din" }} , 
 	{ "name": "width_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "width_out", "role": "full_n" }} , 
 	{ "name": "width_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "width_out", "role": "write" }} , 
 	{ "name": "y_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_out", "role": "din" }} , 
 	{ "name": "y_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out", "role": "full_n" }} , 
 	{ "name": "y_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_out", "role": "write" }} , 
 	{ "name": "display_xsize_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "display_xsize_out", "role": "din" }} , 
 	{ "name": "display_xsize_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "display_xsize_out", "role": "full_n" }} , 
 	{ "name": "display_xsize_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "display_xsize_out", "role": "write" }} , 
 	{ "name": "update_out_din", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "update_out", "role": "din" }} , 
 	{ "name": "update_out_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update_out", "role": "full_n" }} , 
 	{ "name": "update_out_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update_out", "role": "write" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "width_loop_proc5",
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
			{"Name" : "y", "Type" : "None", "Direction" : "I"},
			{"Name" : "display_xsize", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "cp", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "cp_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "cp_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0"},
			{"Name" : "update", "Type" : "None", "Direction" : "I"},
			{"Name" : "width_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "display_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "display_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "update_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "update_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32ns_32ns_62_2_1_U1", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	width_loop_proc5 {
		width {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		display_xsize {Type I LastRead 0 FirstWrite -1}
		copy {Type I LastRead 2 FirstWrite -1}
		cp {Type I LastRead 11 FirstWrite -1}
		src_V1 {Type O LastRead -1 FirstWrite 12}
		update {Type I LastRead 0 FirstWrite -1}
		width_out {Type O LastRead -1 FirstWrite 0}
		y_out {Type O LastRead -1 FirstWrite 0}
		display_xsize_out {Type O LastRead -1 FirstWrite 0}
		update_out {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "13", "Max" : "652"}
	, {"Name" : "Interval", "Min" : "13", "Max" : "652"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	width { ap_none {  { width in_data 0 32 } } }
	y { ap_none {  { y in_data 0 32 } } }
	display_xsize { ap_none {  { display_xsize in_data 0 32 } } }
	copy { ap_none {  { copy in_data 0 64 } } }
	cp { m_axi {  { m_axi_cp_AWVALID VALID 1 1 }  { m_axi_cp_AWREADY READY 0 1 }  { m_axi_cp_AWADDR ADDR 1 64 }  { m_axi_cp_AWID ID 1 1 }  { m_axi_cp_AWLEN LEN 1 32 }  { m_axi_cp_AWSIZE SIZE 1 3 }  { m_axi_cp_AWBURST BURST 1 2 }  { m_axi_cp_AWLOCK LOCK 1 2 }  { m_axi_cp_AWCACHE CACHE 1 4 }  { m_axi_cp_AWPROT PROT 1 3 }  { m_axi_cp_AWQOS QOS 1 4 }  { m_axi_cp_AWREGION REGION 1 4 }  { m_axi_cp_AWUSER USER 1 1 }  { m_axi_cp_WVALID VALID 1 1 }  { m_axi_cp_WREADY READY 0 1 }  { m_axi_cp_WDATA DATA 1 32 }  { m_axi_cp_WSTRB STRB 1 4 }  { m_axi_cp_WLAST LAST 1 1 }  { m_axi_cp_WID ID 1 1 }  { m_axi_cp_WUSER USER 1 1 }  { m_axi_cp_ARVALID VALID 1 1 }  { m_axi_cp_ARREADY READY 0 1 }  { m_axi_cp_ARADDR ADDR 1 64 }  { m_axi_cp_ARID ID 1 1 }  { m_axi_cp_ARLEN LEN 1 32 }  { m_axi_cp_ARSIZE SIZE 1 3 }  { m_axi_cp_ARBURST BURST 1 2 }  { m_axi_cp_ARLOCK LOCK 1 2 }  { m_axi_cp_ARCACHE CACHE 1 4 }  { m_axi_cp_ARPROT PROT 1 3 }  { m_axi_cp_ARQOS QOS 1 4 }  { m_axi_cp_ARREGION REGION 1 4 }  { m_axi_cp_ARUSER USER 1 1 }  { m_axi_cp_RVALID VALID 0 1 }  { m_axi_cp_RREADY READY 1 1 }  { m_axi_cp_RDATA DATA 0 32 }  { m_axi_cp_RLAST LAST 0 1 }  { m_axi_cp_RID ID 0 1 }  { m_axi_cp_RUSER USER 0 1 }  { m_axi_cp_RRESP RESP 0 2 }  { m_axi_cp_BVALID VALID 0 1 }  { m_axi_cp_BREADY READY 1 1 }  { m_axi_cp_BRESP RESP 0 2 }  { m_axi_cp_BID ID 0 1 }  { m_axi_cp_BUSER USER 0 1 } } }
	src_V1 { ap_memory {  { src_V1_address0 mem_address 1 10 }  { src_V1_ce0 mem_ce 1 1 }  { src_V1_we0 mem_we 1 1 }  { src_V1_d0 mem_din 1 32 } } }
	update { ap_none {  { update in_data 0 64 } } }
	width_out { ap_fifo {  { width_out_din fifo_data 1 32 }  { width_out_full_n fifo_status 0 1 }  { width_out_write fifo_update 1 1 } } }
	y_out { ap_fifo {  { y_out_din fifo_data 1 32 }  { y_out_full_n fifo_status 0 1 }  { y_out_write fifo_update 1 1 } } }
	display_xsize_out { ap_fifo {  { display_xsize_out_din fifo_data 1 32 }  { display_xsize_out_full_n fifo_status 0 1 }  { display_xsize_out_write fifo_update 1 1 } } }
	update_out { ap_fifo {  { update_out_din fifo_data 1 64 }  { update_out_full_n fifo_status 0 1 }  { update_out_write fifo_update 1 1 } } }
}
