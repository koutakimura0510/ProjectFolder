set moduleName dataflow_parent_loop_proc4
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
set C_modelName {dataflow_parent_loop_proc4}
set C_modelType { void 0 }
set C_modelArgList {
	{ height int 32 regular  }
	{ ycopy_V int 32 regular {array 640 { 1 3 } 1 1 }  }
	{ update int 32 regular {axi_master 1}  }
	{ frame_size int 32 regular  }
	{ ddr_update int 64 regular  }
}
set C_modelArgMapList {[ 
	{ "Name" : "height", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ycopy_V", "interface" : "memory", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "update", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "frame_size", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ddr_update", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 67
set portList { 
	{ height sc_in sc_lv 32 signal 0 } 
	{ ycopy_V_address0 sc_out sc_lv 10 signal 1 } 
	{ ycopy_V_ce0 sc_out sc_logic 1 signal 1 } 
	{ ycopy_V_d0 sc_out sc_lv 32 signal 1 } 
	{ ycopy_V_q0 sc_in sc_lv 32 signal 1 } 
	{ ycopy_V_we0 sc_out sc_logic 1 signal 1 } 
	{ ycopy_V_address1 sc_out sc_lv 10 signal 1 } 
	{ ycopy_V_ce1 sc_out sc_logic 1 signal 1 } 
	{ ycopy_V_d1 sc_out sc_lv 32 signal 1 } 
	{ ycopy_V_q1 sc_in sc_lv 32 signal 1 } 
	{ ycopy_V_we1 sc_out sc_logic 1 signal 1 } 
	{ m_axi_update_AWVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_update_AWREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_update_AWADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_update_AWID sc_out sc_lv 1 signal 2 } 
	{ m_axi_update_AWLEN sc_out sc_lv 32 signal 2 } 
	{ m_axi_update_AWSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_update_AWBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_update_AWLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_update_AWCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_update_AWPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_update_AWQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_update_AWREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_update_AWUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_update_WVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_update_WREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_update_WDATA sc_out sc_lv 32 signal 2 } 
	{ m_axi_update_WSTRB sc_out sc_lv 4 signal 2 } 
	{ m_axi_update_WLAST sc_out sc_logic 1 signal 2 } 
	{ m_axi_update_WID sc_out sc_lv 1 signal 2 } 
	{ m_axi_update_WUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_update_ARVALID sc_out sc_logic 1 signal 2 } 
	{ m_axi_update_ARREADY sc_in sc_logic 1 signal 2 } 
	{ m_axi_update_ARADDR sc_out sc_lv 64 signal 2 } 
	{ m_axi_update_ARID sc_out sc_lv 1 signal 2 } 
	{ m_axi_update_ARLEN sc_out sc_lv 32 signal 2 } 
	{ m_axi_update_ARSIZE sc_out sc_lv 3 signal 2 } 
	{ m_axi_update_ARBURST sc_out sc_lv 2 signal 2 } 
	{ m_axi_update_ARLOCK sc_out sc_lv 2 signal 2 } 
	{ m_axi_update_ARCACHE sc_out sc_lv 4 signal 2 } 
	{ m_axi_update_ARPROT sc_out sc_lv 3 signal 2 } 
	{ m_axi_update_ARQOS sc_out sc_lv 4 signal 2 } 
	{ m_axi_update_ARREGION sc_out sc_lv 4 signal 2 } 
	{ m_axi_update_ARUSER sc_out sc_lv 1 signal 2 } 
	{ m_axi_update_RVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_update_RREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_update_RDATA sc_in sc_lv 32 signal 2 } 
	{ m_axi_update_RLAST sc_in sc_logic 1 signal 2 } 
	{ m_axi_update_RID sc_in sc_lv 1 signal 2 } 
	{ m_axi_update_RUSER sc_in sc_lv 1 signal 2 } 
	{ m_axi_update_RRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_update_BVALID sc_in sc_logic 1 signal 2 } 
	{ m_axi_update_BREADY sc_out sc_logic 1 signal 2 } 
	{ m_axi_update_BRESP sc_in sc_lv 2 signal 2 } 
	{ m_axi_update_BID sc_in sc_lv 1 signal 2 } 
	{ m_axi_update_BUSER sc_in sc_lv 1 signal 2 } 
	{ frame_size sc_in sc_lv 32 signal 3 } 
	{ ddr_update sc_in sc_lv 64 signal 4 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ frame_size_ap_vld sc_in sc_logic 1 invld 3 } 
	{ ddr_update_ap_vld sc_in sc_logic 1 invld 4 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
}
set NewPortList {[ 
	{ "name": "height", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "height", "role": "default" }} , 
 	{ "name": "ycopy_V_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "ycopy_V", "role": "address0" }} , 
 	{ "name": "ycopy_V_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ycopy_V", "role": "ce0" }} , 
 	{ "name": "ycopy_V_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ycopy_V", "role": "d0" }} , 
 	{ "name": "ycopy_V_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ycopy_V", "role": "q0" }} , 
 	{ "name": "ycopy_V_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ycopy_V", "role": "we0" }} , 
 	{ "name": "ycopy_V_address1", "direction": "out", "datatype": "sc_lv", "bitwidth":10, "type": "signal", "bundle":{"name": "ycopy_V", "role": "address1" }} , 
 	{ "name": "ycopy_V_ce1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ycopy_V", "role": "ce1" }} , 
 	{ "name": "ycopy_V_d1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ycopy_V", "role": "d1" }} , 
 	{ "name": "ycopy_V_q1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ycopy_V", "role": "q1" }} , 
 	{ "name": "ycopy_V_we1", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ycopy_V", "role": "we1" }} , 
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
 	{ "name": "frame_size", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "frame_size", "role": "default" }} , 
 	{ "name": "ddr_update", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ddr_update", "role": "default" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "frame_size_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "frame_size", "role": "ap_vld" }} , 
 	{ "name": "ddr_update_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "ddr_update", "role": "ap_vld" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "dataflow_parent_loop_proc4",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "12", "EstimateLatencyMax" : "4802",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "1", "Name" : "dataflow_in_loop_copy2_U0"}],
		"OutputProcess" : [
			{"ID" : "1", "Name" : "dataflow_in_loop_copy2_U0"}],
		"Port" : [
			{"Name" : "height", "Type" : "None", "Direction" : "I"},
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "dataflow_in_loop_copy2_U0", "Port" : "ycopy_V"}]},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "dataflow_in_loop_copy2_U0", "Port" : "update"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_copy2_U0", "Parent" : "0", "Child" : ["2"],
		"CDFG" : "dataflow_in_loop_copy2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "9", "EstimateLatencyMax" : "9",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "2", "Name" : "Block_entry_proc_proc7_U0"}],
		"OutputProcess" : [
			{"ID" : "2", "Name" : "Block_entry_proc_proc7_U0"}],
		"Port" : [
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_entry_proc_proc7_U0", "Port" : "ycopy_V"}]},
			{"Name" : "trunc_ln329", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "Block_entry_proc_proc7_U0", "Port" : "update"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_copy2_U0.Block_entry_proc_proc7_U0", "Parent" : "1", "Child" : ["3"],
		"CDFG" : "Block_entry_proc_proc7",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "9", "EstimateLatencyMax" : "9",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "ycopy_V", "Type" : "Memory", "Direction" : "I"},
			{"Name" : "trunc_ln329", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "update_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "update_blk_n_B", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "ddr_update", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "3", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_copy2_U0.Block_entry_proc_proc7_U0.mul_32ns_32ns_62_2_1_U59", "Parent" : "2"}]}


set ArgLastReadFirstWriteLatency {
	dataflow_parent_loop_proc4 {
		height {Type I LastRead 0 FirstWrite -1}
		ycopy_V {Type I LastRead 2 FirstWrite -1}
		update {Type O LastRead 5 FirstWrite 4}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}}
	dataflow_in_loop_copy2 {
		ycopy_V {Type I LastRead 2 FirstWrite -1}
		trunc_ln329 {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 5 FirstWrite 4}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_update {Type I LastRead 0 FirstWrite -1}}
	Block_entry_proc_proc7 {
		ycopy_V {Type I LastRead 2 FirstWrite -1}
		trunc_ln329 {Type I LastRead 0 FirstWrite -1}
		update {Type O LastRead 5 FirstWrite 4}
		frame_size {Type I LastRead 0 FirstWrite -1}
		ddr_update {Type I LastRead 2 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "12", "Max" : "4802"}
	, {"Name" : "Interval", "Min" : "12", "Max" : "4802"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	height { ap_none {  { height in_data 0 32 } } }
	ycopy_V { ap_memory {  { ycopy_V_address0 mem_address 1 10 }  { ycopy_V_ce0 mem_ce 1 1 }  { ycopy_V_d0 mem_din 1 32 }  { ycopy_V_q0 mem_dout 0 32 }  { ycopy_V_we0 mem_we 1 1 }  { ycopy_V_address1 mem_address 1 10 }  { ycopy_V_ce1 mem_ce 1 1 }  { ycopy_V_d1 mem_din 1 32 }  { ycopy_V_q1 mem_dout 0 32 }  { ycopy_V_we1 mem_we 1 1 } } }
	update { m_axi {  { m_axi_update_AWVALID VALID 1 1 }  { m_axi_update_AWREADY READY 0 1 }  { m_axi_update_AWADDR ADDR 1 64 }  { m_axi_update_AWID ID 1 1 }  { m_axi_update_AWLEN LEN 1 32 }  { m_axi_update_AWSIZE SIZE 1 3 }  { m_axi_update_AWBURST BURST 1 2 }  { m_axi_update_AWLOCK LOCK 1 2 }  { m_axi_update_AWCACHE CACHE 1 4 }  { m_axi_update_AWPROT PROT 1 3 }  { m_axi_update_AWQOS QOS 1 4 }  { m_axi_update_AWREGION REGION 1 4 }  { m_axi_update_AWUSER USER 1 1 }  { m_axi_update_WVALID VALID 1 1 }  { m_axi_update_WREADY READY 0 1 }  { m_axi_update_WDATA DATA 1 32 }  { m_axi_update_WSTRB STRB 1 4 }  { m_axi_update_WLAST LAST 1 1 }  { m_axi_update_WID ID 1 1 }  { m_axi_update_WUSER USER 1 1 }  { m_axi_update_ARVALID VALID 1 1 }  { m_axi_update_ARREADY READY 0 1 }  { m_axi_update_ARADDR ADDR 1 64 }  { m_axi_update_ARID ID 1 1 }  { m_axi_update_ARLEN LEN 1 32 }  { m_axi_update_ARSIZE SIZE 1 3 }  { m_axi_update_ARBURST BURST 1 2 }  { m_axi_update_ARLOCK LOCK 1 2 }  { m_axi_update_ARCACHE CACHE 1 4 }  { m_axi_update_ARPROT PROT 1 3 }  { m_axi_update_ARQOS QOS 1 4 }  { m_axi_update_ARREGION REGION 1 4 }  { m_axi_update_ARUSER USER 1 1 }  { m_axi_update_RVALID VALID 0 1 }  { m_axi_update_RREADY READY 1 1 }  { m_axi_update_RDATA DATA 0 32 }  { m_axi_update_RLAST LAST 0 1 }  { m_axi_update_RID ID 0 1 }  { m_axi_update_RUSER USER 0 1 }  { m_axi_update_RRESP RESP 0 2 }  { m_axi_update_BVALID VALID 0 1 }  { m_axi_update_BREADY READY 1 1 }  { m_axi_update_BRESP RESP 0 2 }  { m_axi_update_BID ID 0 1 }  { m_axi_update_BUSER USER 0 1 } } }
	frame_size { ap_none {  { frame_size in_data 0 32 }  { frame_size_ap_vld in_vld 0 1 } } }
	ddr_update { ap_none {  { ddr_update in_data 0 64 }  { ddr_update_ap_vld in_vld 0 1 } } }
}
