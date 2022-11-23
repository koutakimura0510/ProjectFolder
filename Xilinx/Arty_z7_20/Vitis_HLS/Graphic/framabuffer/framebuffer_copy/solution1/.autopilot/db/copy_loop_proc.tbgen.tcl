set moduleName copy_loop_proc
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
set C_modelName {copy_loop_proc}
set C_modelType { void 0 }
set C_modelArgList {
	{ width int 32 regular {fifo 0}  }
	{ y int 32 regular {fifo 0}  }
	{ display_xsize int 32 regular {fifo 0}  }
	{ src_V1 int 32 regular {array 640 { 1 3 } 1 1 }  }
	{ update int 64 regular {fifo 0}  }
	{ up int 32 regular {axi_master 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "width", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "y", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "display_xsize", "interface" : "fifo", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "src_V1", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "update", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "up", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 67
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
	{ y_dout sc_in sc_lv 32 signal 1 } 
	{ y_empty_n sc_in sc_logic 1 signal 1 } 
	{ y_read sc_out sc_logic 1 signal 1 } 
	{ display_xsize_dout sc_in sc_lv 32 signal 2 } 
	{ display_xsize_empty_n sc_in sc_logic 1 signal 2 } 
	{ display_xsize_read sc_out sc_logic 1 signal 2 } 
	{ src_V1_address0 sc_out sc_lv 10 signal 3 } 
	{ src_V1_ce0 sc_out sc_logic 1 signal 3 } 
	{ src_V1_q0 sc_in sc_lv 32 signal 3 } 
	{ update_dout sc_in sc_lv 64 signal 4 } 
	{ update_empty_n sc_in sc_logic 1 signal 4 } 
	{ update_read sc_out sc_logic 1 signal 4 } 
	{ m_axi_up_AWVALID sc_out sc_logic 1 signal 5 } 
	{ m_axi_up_AWREADY sc_in sc_logic 1 signal 5 } 
	{ m_axi_up_AWADDR sc_out sc_lv 64 signal 5 } 
	{ m_axi_up_AWID sc_out sc_lv 1 signal 5 } 
	{ m_axi_up_AWLEN sc_out sc_lv 32 signal 5 } 
	{ m_axi_up_AWSIZE sc_out sc_lv 3 signal 5 } 
	{ m_axi_up_AWBURST sc_out sc_lv 2 signal 5 } 
	{ m_axi_up_AWLOCK sc_out sc_lv 2 signal 5 } 
	{ m_axi_up_AWCACHE sc_out sc_lv 4 signal 5 } 
	{ m_axi_up_AWPROT sc_out sc_lv 3 signal 5 } 
	{ m_axi_up_AWQOS sc_out sc_lv 4 signal 5 } 
	{ m_axi_up_AWREGION sc_out sc_lv 4 signal 5 } 
	{ m_axi_up_AWUSER sc_out sc_lv 1 signal 5 } 
	{ m_axi_up_WVALID sc_out sc_logic 1 signal 5 } 
	{ m_axi_up_WREADY sc_in sc_logic 1 signal 5 } 
	{ m_axi_up_WDATA sc_out sc_lv 32 signal 5 } 
	{ m_axi_up_WSTRB sc_out sc_lv 4 signal 5 } 
	{ m_axi_up_WLAST sc_out sc_logic 1 signal 5 } 
	{ m_axi_up_WID sc_out sc_lv 1 signal 5 } 
	{ m_axi_up_WUSER sc_out sc_lv 1 signal 5 } 
	{ m_axi_up_ARVALID sc_out sc_logic 1 signal 5 } 
	{ m_axi_up_ARREADY sc_in sc_logic 1 signal 5 } 
	{ m_axi_up_ARADDR sc_out sc_lv 64 signal 5 } 
	{ m_axi_up_ARID sc_out sc_lv 1 signal 5 } 
	{ m_axi_up_ARLEN sc_out sc_lv 32 signal 5 } 
	{ m_axi_up_ARSIZE sc_out sc_lv 3 signal 5 } 
	{ m_axi_up_ARBURST sc_out sc_lv 2 signal 5 } 
	{ m_axi_up_ARLOCK sc_out sc_lv 2 signal 5 } 
	{ m_axi_up_ARCACHE sc_out sc_lv 4 signal 5 } 
	{ m_axi_up_ARPROT sc_out sc_lv 3 signal 5 } 
	{ m_axi_up_ARQOS sc_out sc_lv 4 signal 5 } 
	{ m_axi_up_ARREGION sc_out sc_lv 4 signal 5 } 
	{ m_axi_up_ARUSER sc_out sc_lv 1 signal 5 } 
	{ m_axi_up_RVALID sc_in sc_logic 1 signal 5 } 
	{ m_axi_up_RREADY sc_out sc_logic 1 signal 5 } 
	{ m_axi_up_RDATA sc_in sc_lv 32 signal 5 } 
	{ m_axi_up_RLAST sc_in sc_logic 1 signal 5 } 
	{ m_axi_up_RID sc_in sc_lv 1 signal 5 } 
	{ m_axi_up_RUSER sc_in sc_lv 1 signal 5 } 
	{ m_axi_up_RRESP sc_in sc_lv 2 signal 5 } 
	{ m_axi_up_BVALID sc_in sc_logic 1 signal 5 } 
	{ m_axi_up_BREADY sc_out sc_logic 1 signal 5 } 
	{ m_axi_up_BRESP sc_in sc_lv 2 signal 5 } 
	{ m_axi_up_BID sc_in sc_lv 1 signal 5 } 
	{ m_axi_up_BUSER sc_in sc_lv 1 signal 5 } 
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
 	{ "name": "y_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "y", "role": "dout" }} , 
 	{ "name": "y_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y", "role": "empty_n" }} , 
 	{ "name": "y_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "y", "role": "read" }} , 
 	{ "name": "display_xsize_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "display_xsize", "role": "dout" }} , 
 	{ "name": "display_xsize_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "display_xsize", "role": "empty_n" }} , 
 	{ "name": "display_xsize_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "display_xsize", "role": "read" }} , 
 	{ "name": "src_V1_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "src_V1", "role": "address0" }} , 
 	{ "name": "src_V1_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src_V1", "role": "ce0" }} , 
 	{ "name": "src_V1_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "src_V1", "role": "q0" }} , 
 	{ "name": "update_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "update", "role": "dout" }} , 
 	{ "name": "update_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "empty_n" }} , 
 	{ "name": "update_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "update", "role": "read" }} , 
 	{ "name": "m_axi_up_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "AWVALID" }} , 
 	{ "name": "m_axi_up_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "AWREADY" }} , 
 	{ "name": "m_axi_up_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "up", "role": "AWADDR" }} , 
 	{ "name": "m_axi_up_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "AWID" }} , 
 	{ "name": "m_axi_up_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "up", "role": "AWLEN" }} , 
 	{ "name": "m_axi_up_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "up", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_up_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "up", "role": "AWBURST" }} , 
 	{ "name": "m_axi_up_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "up", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_up_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "up", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_up_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "up", "role": "AWPROT" }} , 
 	{ "name": "m_axi_up_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "up", "role": "AWQOS" }} , 
 	{ "name": "m_axi_up_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "up", "role": "AWREGION" }} , 
 	{ "name": "m_axi_up_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "AWUSER" }} , 
 	{ "name": "m_axi_up_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "WVALID" }} , 
 	{ "name": "m_axi_up_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "WREADY" }} , 
 	{ "name": "m_axi_up_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "up", "role": "WDATA" }} , 
 	{ "name": "m_axi_up_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "up", "role": "WSTRB" }} , 
 	{ "name": "m_axi_up_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "WLAST" }} , 
 	{ "name": "m_axi_up_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "WID" }} , 
 	{ "name": "m_axi_up_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "WUSER" }} , 
 	{ "name": "m_axi_up_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "ARVALID" }} , 
 	{ "name": "m_axi_up_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "ARREADY" }} , 
 	{ "name": "m_axi_up_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "up", "role": "ARADDR" }} , 
 	{ "name": "m_axi_up_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "ARID" }} , 
 	{ "name": "m_axi_up_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "up", "role": "ARLEN" }} , 
 	{ "name": "m_axi_up_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "up", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_up_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "up", "role": "ARBURST" }} , 
 	{ "name": "m_axi_up_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "up", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_up_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "up", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_up_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "up", "role": "ARPROT" }} , 
 	{ "name": "m_axi_up_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "up", "role": "ARQOS" }} , 
 	{ "name": "m_axi_up_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "up", "role": "ARREGION" }} , 
 	{ "name": "m_axi_up_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "ARUSER" }} , 
 	{ "name": "m_axi_up_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "RVALID" }} , 
 	{ "name": "m_axi_up_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "RREADY" }} , 
 	{ "name": "m_axi_up_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "up", "role": "RDATA" }} , 
 	{ "name": "m_axi_up_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "RLAST" }} , 
 	{ "name": "m_axi_up_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "RID" }} , 
 	{ "name": "m_axi_up_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "RUSER" }} , 
 	{ "name": "m_axi_up_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "up", "role": "RRESP" }} , 
 	{ "name": "m_axi_up_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "BVALID" }} , 
 	{ "name": "m_axi_up_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "BREADY" }} , 
 	{ "name": "m_axi_up_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "up", "role": "BRESP" }} , 
 	{ "name": "m_axi_up_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "BID" }} , 
 	{ "name": "m_axi_up_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "copy_loop_proc",
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
			{"Name" : "y", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "display_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "display_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0"},
			{"Name" : "update", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "update_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "up", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "up_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "up_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "up_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32ns_32ns_62_2_1_U14", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	copy_loop_proc {
		width {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		display_xsize {Type I LastRead 0 FirstWrite -1}
		src_V1 {Type I LastRead 5 FirstWrite -1}
		update {Type I LastRead 0 FirstWrite -1}
		up {Type O LastRead 6 FirstWrite 7}}}

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
	y { ap_fifo {  { y_dout fifo_data 0 32 }  { y_empty_n fifo_status 0 1 }  { y_read fifo_update 1 1 } } }
	display_xsize { ap_fifo {  { display_xsize_dout fifo_data 0 32 }  { display_xsize_empty_n fifo_status 0 1 }  { display_xsize_read fifo_update 1 1 } } }
	src_V1 { ap_memory {  { src_V1_address0 mem_address 1 10 }  { src_V1_ce0 mem_ce 1 1 }  { src_V1_q0 mem_dout 0 32 } } }
	update { ap_fifo {  { update_dout fifo_data 0 64 }  { update_empty_n fifo_status 0 1 }  { update_read fifo_update 1 1 } } }
	up { m_axi {  { m_axi_up_AWVALID VALID 1 1 }  { m_axi_up_AWREADY READY 0 1 }  { m_axi_up_AWADDR ADDR 1 64 }  { m_axi_up_AWID ID 1 1 }  { m_axi_up_AWLEN LEN 1 32 }  { m_axi_up_AWSIZE SIZE 1 3 }  { m_axi_up_AWBURST BURST 1 2 }  { m_axi_up_AWLOCK LOCK 1 2 }  { m_axi_up_AWCACHE CACHE 1 4 }  { m_axi_up_AWPROT PROT 1 3 }  { m_axi_up_AWQOS QOS 1 4 }  { m_axi_up_AWREGION REGION 1 4 }  { m_axi_up_AWUSER USER 1 1 }  { m_axi_up_WVALID VALID 1 1 }  { m_axi_up_WREADY READY 0 1 }  { m_axi_up_WDATA DATA 1 32 }  { m_axi_up_WSTRB STRB 1 4 }  { m_axi_up_WLAST LAST 1 1 }  { m_axi_up_WID ID 1 1 }  { m_axi_up_WUSER USER 1 1 }  { m_axi_up_ARVALID VALID 1 1 }  { m_axi_up_ARREADY READY 0 1 }  { m_axi_up_ARADDR ADDR 1 64 }  { m_axi_up_ARID ID 1 1 }  { m_axi_up_ARLEN LEN 1 32 }  { m_axi_up_ARSIZE SIZE 1 3 }  { m_axi_up_ARBURST BURST 1 2 }  { m_axi_up_ARLOCK LOCK 1 2 }  { m_axi_up_ARCACHE CACHE 1 4 }  { m_axi_up_ARPROT PROT 1 3 }  { m_axi_up_ARQOS QOS 1 4 }  { m_axi_up_ARREGION REGION 1 4 }  { m_axi_up_ARUSER USER 1 1 }  { m_axi_up_RVALID VALID 0 1 }  { m_axi_up_RREADY READY 1 1 }  { m_axi_up_RDATA DATA 0 32 }  { m_axi_up_RLAST LAST 0 1 }  { m_axi_up_RID ID 0 1 }  { m_axi_up_RUSER USER 0 1 }  { m_axi_up_RRESP RESP 0 2 }  { m_axi_up_BVALID VALID 0 1 }  { m_axi_up_BREADY READY 1 1 }  { m_axi_up_BRESP RESP 0 2 }  { m_axi_up_BID ID 0 1 }  { m_axi_up_BUSER USER 0 1 } } }
}
