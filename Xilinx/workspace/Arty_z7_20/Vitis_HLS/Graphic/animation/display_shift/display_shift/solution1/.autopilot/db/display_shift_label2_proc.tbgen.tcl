set moduleName display_shift_label2_proc
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
set C_modelName {display_shift_label2_proc}
set C_modelType { void 0 }
set C_modelArgList {
	{ width int 32 regular {fifo 0}  }
	{ xend int 32 regular {fifo 0}  }
	{ y_2 int 32 regular {fifo 0}  }
	{ yend int 32 regular {fifo 0}  }
	{ frame_size int 32 regular {fifo 0}  }
	{ copy_V1 int 32 regular {array 640 { 1 3 } 1 1 }  }
	{ ddr_update int 64 regular {fifo 0}  }
	{ update int 32 regular {axi_master 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "width", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "xend", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y_2", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "yend", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "frame_size", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "copy_V1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ddr_update", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "update", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
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
	{ width_dout sc_in sc_lv 32 signal 0 } 
	{ width_empty_n sc_in sc_logic 1 signal 0 } 
	{ width_read sc_out sc_logic 1 signal 0 } 
	{ xend_dout sc_in sc_lv 32 signal 1 } 
	{ xend_empty_n sc_in sc_logic 1 signal 1 } 
	{ xend_read sc_out sc_logic 1 signal 1 } 
	{ y_2_dout sc_in sc_lv 32 signal 2 } 
	{ y_2_empty_n sc_in sc_logic 1 signal 2 } 
	{ y_2_read sc_out sc_logic 1 signal 2 } 
	{ yend_dout sc_in sc_lv 32 signal 3 } 
	{ yend_empty_n sc_in sc_logic 1 signal 3 } 
	{ yend_read sc_out sc_logic 1 signal 3 } 
	{ frame_size_dout sc_in sc_lv 32 signal 4 } 
	{ frame_size_empty_n sc_in sc_logic 1 signal 4 } 
	{ frame_size_read sc_out sc_logic 1 signal 4 } 
	{ copy_V1_address0 sc_out sc_lv 10 signal 5 } 
	{ copy_V1_ce0 sc_out sc_logic 1 signal 5 } 
	{ copy_V1_q0 sc_in sc_lv 32 signal 5 } 
	{ ddr_update_dout sc_in sc_lv 64 signal 6 } 
	{ ddr_update_empty_n sc_in sc_logic 1 signal 6 } 
	{ ddr_update_read sc_out sc_logic 1 signal 6 } 
	{ m_axi_update_AWVALID sc_out sc_logic 1 signal 7 } 
	{ m_axi_update_AWREADY sc_in sc_logic 1 signal 7 } 
	{ m_axi_update_AWADDR sc_out sc_lv 64 signal 7 } 
	{ m_axi_update_AWID sc_out sc_lv 1 signal 7 } 
	{ m_axi_update_AWLEN sc_out sc_lv 32 signal 7 } 
	{ m_axi_update_AWSIZE sc_out sc_lv 3 signal 7 } 
	{ m_axi_update_AWBURST sc_out sc_lv 2 signal 7 } 
	{ m_axi_update_AWLOCK sc_out sc_lv 2 signal 7 } 
	{ m_axi_update_AWCACHE sc_out sc_lv 4 signal 7 } 
	{ m_axi_update_AWPROT sc_out sc_lv 3 signal 7 } 
	{ m_axi_update_AWQOS sc_out sc_lv 4 signal 7 } 
	{ m_axi_update_AWREGION sc_out sc_lv 4 signal 7 } 
	{ m_axi_update_AWUSER sc_out sc_lv 1 signal 7 } 
	{ m_axi_update_WVALID sc_out sc_logic 1 signal 7 } 
	{ m_axi_update_WREADY sc_in sc_logic 1 signal 7 } 
	{ m_axi_update_WDATA sc_out sc_lv 32 signal 7 } 
	{ m_axi_update_WSTRB sc_out sc_lv 4 signal 7 } 
	{ m_axi_update_WLAST sc_out sc_logic 1 signal 7 } 
	{ m_axi_update_WID sc_out sc_lv 1 signal 7 } 
	{ m_axi_update_WUSER sc_out sc_lv 1 signal 7 } 
	{ m_axi_update_ARVALID sc_out sc_logic 1 signal 7 } 
	{ m_axi_update_ARREADY sc_in sc_logic 1 signal 7 } 
	{ m_axi_update_ARADDR sc_out sc_lv 64 signal 7 } 
	{ m_axi_update_ARID sc_out sc_lv 1 signal 7 } 
	{ m_axi_update_ARLEN sc_out sc_lv 32 signal 7 } 
	{ m_axi_update_ARSIZE sc_out sc_lv 3 signal 7 } 
	{ m_axi_update_ARBURST sc_out sc_lv 2 signal 7 } 
	{ m_axi_update_ARLOCK sc_out sc_lv 2 signal 7 } 
	{ m_axi_update_ARCACHE sc_out sc_lv 4 signal 7 } 
	{ m_axi_update_ARPROT sc_out sc_lv 3 signal 7 } 
	{ m_axi_update_ARQOS sc_out sc_lv 4 signal 7 } 
	{ m_axi_update_ARREGION sc_out sc_lv 4 signal 7 } 
	{ m_axi_update_ARUSER sc_out sc_lv 1 signal 7 } 
	{ m_axi_update_RVALID sc_in sc_logic 1 signal 7 } 
	{ m_axi_update_RREADY sc_out sc_logic 1 signal 7 } 
	{ m_axi_update_RDATA sc_in sc_lv 32 signal 7 } 
	{ m_axi_update_RLAST sc_in sc_logic 1 signal 7 } 
	{ m_axi_update_RID sc_in sc_lv 1 signal 7 } 
	{ m_axi_update_RUSER sc_in sc_lv 1 signal 7 } 
	{ m_axi_update_RRESP sc_in sc_lv 2 signal 7 } 
	{ m_axi_update_BVALID sc_in sc_logic 1 signal 7 } 
	{ m_axi_update_BREADY sc_out sc_logic 1 signal 7 } 
	{ m_axi_update_BRESP sc_in sc_lv 2 signal 7 } 
	{ m_axi_update_BID sc_in sc_lv 1 signal 7 } 
	{ m_axi_update_BUSER sc_in sc_lv 1 signal 7 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "width_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "width", "role": "dout" }} , 
 	{ "name": "width_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "width", "role": "empty_n" }} , 
 	{ "name": "width_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "width", "role": "read" }} , 
 	{ "name": "xend_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "xend", "role": "dout" }} , 
 	{ "name": "xend_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xend", "role": "empty_n" }} , 
 	{ "name": "xend_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "xend", "role": "read" }} , 
 	{ "name": "y_2_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y_2", "role": "dout" }} , 
 	{ "name": "y_2_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_2", "role": "empty_n" }} , 
 	{ "name": "y_2_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y_2", "role": "read" }} , 
 	{ "name": "yend_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "yend", "role": "dout" }} , 
 	{ "name": "yend_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "yend", "role": "empty_n" }} , 
 	{ "name": "yend_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "yend", "role": "read" }} , 
 	{ "name": "frame_size_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size", "role": "dout" }} , 
 	{ "name": "frame_size_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size", "role": "empty_n" }} , 
 	{ "name": "frame_size_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "frame_size", "role": "read" }} , 
 	{ "name": "copy_V1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "copy_V1", "role": "address0" }} , 
 	{ "name": "copy_V1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "copy_V1", "role": "ce0" }} , 
 	{ "name": "copy_V1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "copy_V1", "role": "q0" }} , 
 	{ "name": "ddr_update_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ddr_update", "role": "dout" }} , 
 	{ "name": "ddr_update_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ddr_update", "role": "empty_n" }} , 
 	{ "name": "ddr_update_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ddr_update", "role": "read" }} , 
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
 	{ "name": "m_axi_update_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "display_shift_label2_proc",
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
			{"Name" : "width", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xend", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xend_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_2", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "yend", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "yend_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "copy_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0"},
			{"Name" : "ddr_update", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ddr_update_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "update_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_34s_32ns_62_2_1_U20", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	display_shift_label2_proc {
		width {Type I LastRead 0 FirstWrite -1}
		xend {Type I LastRead 0 FirstWrite -1}
		y_2 {Type I LastRead 0 FirstWrite -1}
		yend {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		copy_V1 {Type I LastRead 5 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 6 FirstWrite 7}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "12", "Max" : "651"}
	, {"Name" : "Interval", "Min" : "12", "Max" : "651"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	width { ap_fifo {  { width_dout fifo_data 0 32 }  { width_empty_n fifo_status 0 1 }  { width_read fifo_update 1 1 } } }
	xend { ap_fifo {  { xend_dout fifo_data 0 32 }  { xend_empty_n fifo_status 0 1 }  { xend_read fifo_update 1 1 } } }
	y_2 { ap_fifo {  { y_2_dout fifo_data 0 32 }  { y_2_empty_n fifo_status 0 1 }  { y_2_read fifo_update 1 1 } } }
	yend { ap_fifo {  { yend_dout fifo_data 0 32 }  { yend_empty_n fifo_status 0 1 }  { yend_read fifo_update 1 1 } } }
	frame_size { ap_fifo {  { frame_size_dout fifo_data 0 32 }  { frame_size_empty_n fifo_status 0 1 }  { frame_size_read fifo_update 1 1 } } }
	copy_V1 { ap_memory {  { copy_V1_address0 mem_address 1 10 }  { copy_V1_ce0 mem_ce 1 1 }  { copy_V1_q0 mem_dout 0 32 } } }
	ddr_update { ap_fifo {  { ddr_update_dout fifo_data 0 64 }  { ddr_update_empty_n fifo_status 0 1 }  { ddr_update_read fifo_update 1 1 } } }
	update { m_axi {  { m_axi_update_AWVALID VALID 1 1 }  { m_axi_update_AWREADY READY 0 1 }  { m_axi_update_AWADDR ADDR 1 64 }  { m_axi_update_AWID ID 1 1 }  { m_axi_update_AWLEN LEN 1 32 }  { m_axi_update_AWSIZE SIZE 1 3 }  { m_axi_update_AWBURST BURST 1 2 }  { m_axi_update_AWLOCK LOCK 1 2 }  { m_axi_update_AWCACHE CACHE 1 4 }  { m_axi_update_AWPROT PROT 1 3 }  { m_axi_update_AWQOS QOS 1 4 }  { m_axi_update_AWREGION REGION 1 4 }  { m_axi_update_AWUSER USER 1 1 }  { m_axi_update_WVALID VALID 1 1 }  { m_axi_update_WREADY READY 0 1 }  { m_axi_update_WDATA DATA 1 32 }  { m_axi_update_WSTRB STRB 1 4 }  { m_axi_update_WLAST LAST 1 1 }  { m_axi_update_WID ID 1 1 }  { m_axi_update_WUSER USER 1 1 }  { m_axi_update_ARVALID VALID 1 1 }  { m_axi_update_ARREADY READY 0 1 }  { m_axi_update_ARADDR ADDR 1 64 }  { m_axi_update_ARID ID 1 1 }  { m_axi_update_ARLEN LEN 1 32 }  { m_axi_update_ARSIZE SIZE 1 3 }  { m_axi_update_ARBURST BURST 1 2 }  { m_axi_update_ARLOCK LOCK 1 2 }  { m_axi_update_ARCACHE CACHE 1 4 }  { m_axi_update_ARPROT PROT 1 3 }  { m_axi_update_ARQOS QOS 1 4 }  { m_axi_update_ARREGION REGION 1 4 }  { m_axi_update_ARUSER USER 1 1 }  { m_axi_update_RVALID VALID 0 1 }  { m_axi_update_RREADY READY 1 1 }  { m_axi_update_RDATA DATA 0 32 }  { m_axi_update_RLAST LAST 0 1 }  { m_axi_update_RID ID 0 1 }  { m_axi_update_RUSER USER 0 1 }  { m_axi_update_RRESP RESP 0 2 }  { m_axi_update_BVALID VALID 0 1 }  { m_axi_update_BREADY READY 1 1 }  { m_axi_update_BRESP RESP 0 2 }  { m_axi_update_BID ID 0 1 }  { m_axi_update_BUSER USER 0 1 } } }
}
