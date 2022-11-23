set moduleName dataflow_in_loop_sound_operation_label1
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
set C_modelName {dataflow_in_loop_sound_operation_label1}
set C_modelType { void 0 }
set C_modelArgList {
	{ opeout int 32 regular {pointer 1}  }
	{ ram int 32 regular {axi_master 0}  }
	{ ramadr int 64 regular  }
	{ sdata int 32 regular {pointer 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "opeout", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "ram", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ramadr", "interface" : "wire", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "sdata", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 58
set portList { 
	{ opeout sc_out sc_lv 32 signal 0 } 
	{ m_axi_ram_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_ram_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_ram_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_ram_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_ram_AWLEN sc_out sc_lv 32 signal 1 } 
	{ m_axi_ram_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_ram_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_ram_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_ram_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_ram_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_ram_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_ram_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_ram_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_ram_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_ram_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_ram_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_ram_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_ram_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_ram_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_ram_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_ram_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_ram_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_ram_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_ram_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_ram_ARLEN sc_out sc_lv 32 signal 1 } 
	{ m_axi_ram_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_ram_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_ram_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_ram_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_ram_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_ram_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_ram_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_ram_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_ram_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_ram_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_ram_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_ram_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_ram_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_ram_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_ram_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_ram_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_ram_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_ram_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_ram_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_ram_BUSER sc_in sc_lv 1 signal 1 } 
	{ ramadr sc_in sc_lv 64 signal 2 } 
	{ sdata sc_out sc_lv 32 signal 3 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ramadr_ap_vld sc_in sc_logic 1 invld 2 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ opeout_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ sdata_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
}
set NewPortList {[ 
	{ "name": "opeout", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "opeout", "role": "default" }} , 
 	{ "name": "m_axi_ram_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "AWVALID" }} , 
 	{ "name": "m_axi_ram_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "AWREADY" }} , 
 	{ "name": "m_axi_ram_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ram", "role": "AWADDR" }} , 
 	{ "name": "m_axi_ram_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "AWID" }} , 
 	{ "name": "m_axi_ram_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ram", "role": "AWLEN" }} , 
 	{ "name": "m_axi_ram_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "ram", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_ram_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ram", "role": "AWBURST" }} , 
 	{ "name": "m_axi_ram_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ram", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_ram_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ram", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_ram_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "ram", "role": "AWPROT" }} , 
 	{ "name": "m_axi_ram_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ram", "role": "AWQOS" }} , 
 	{ "name": "m_axi_ram_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ram", "role": "AWREGION" }} , 
 	{ "name": "m_axi_ram_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "AWUSER" }} , 
 	{ "name": "m_axi_ram_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "WVALID" }} , 
 	{ "name": "m_axi_ram_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "WREADY" }} , 
 	{ "name": "m_axi_ram_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ram", "role": "WDATA" }} , 
 	{ "name": "m_axi_ram_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ram", "role": "WSTRB" }} , 
 	{ "name": "m_axi_ram_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "WLAST" }} , 
 	{ "name": "m_axi_ram_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "WID" }} , 
 	{ "name": "m_axi_ram_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "WUSER" }} , 
 	{ "name": "m_axi_ram_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "ARVALID" }} , 
 	{ "name": "m_axi_ram_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "ARREADY" }} , 
 	{ "name": "m_axi_ram_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ram", "role": "ARADDR" }} , 
 	{ "name": "m_axi_ram_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "ARID" }} , 
 	{ "name": "m_axi_ram_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ram", "role": "ARLEN" }} , 
 	{ "name": "m_axi_ram_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "ram", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_ram_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ram", "role": "ARBURST" }} , 
 	{ "name": "m_axi_ram_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ram", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_ram_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ram", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_ram_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "ram", "role": "ARPROT" }} , 
 	{ "name": "m_axi_ram_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ram", "role": "ARQOS" }} , 
 	{ "name": "m_axi_ram_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "ram", "role": "ARREGION" }} , 
 	{ "name": "m_axi_ram_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "ARUSER" }} , 
 	{ "name": "m_axi_ram_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "RVALID" }} , 
 	{ "name": "m_axi_ram_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "RREADY" }} , 
 	{ "name": "m_axi_ram_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ram", "role": "RDATA" }} , 
 	{ "name": "m_axi_ram_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "RLAST" }} , 
 	{ "name": "m_axi_ram_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "RID" }} , 
 	{ "name": "m_axi_ram_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "RUSER" }} , 
 	{ "name": "m_axi_ram_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ram", "role": "RRESP" }} , 
 	{ "name": "m_axi_ram_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "BVALID" }} , 
 	{ "name": "m_axi_ram_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "BREADY" }} , 
 	{ "name": "m_axi_ram_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "ram", "role": "BRESP" }} , 
 	{ "name": "m_axi_ram_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "BID" }} , 
 	{ "name": "m_axi_ram_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "ram", "role": "BUSER" }} , 
 	{ "name": "ramadr", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ramadr", "role": "default" }} , 
 	{ "name": "sdata", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "sdata", "role": "default" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ramadr_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "ramadr", "role": "ap_vld" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "opeout_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "opeout", "role": "ap_vld" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "sdata_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "sdata", "role": "ap_vld" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7"],
		"CDFG" : "dataflow_in_loop_sound_operation_label1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "10", "EstimateLatencyMax" : "10",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "1", "Name" : "dataflow_in_loop_sound_operation_label1_entry3_U0"},
			{"ID" : "3", "Name" : "Block_entry_proc_proc_U0"},
			{"ID" : "4", "Name" : "Block_entry_proc_proc3_U0"}],
		"OutputProcess" : [
			{"ID" : "3", "Name" : "Block_entry_proc_proc_U0"},
			{"ID" : "4", "Name" : "Block_entry_proc_proc3_U0"}],
		"Port" : [
			{"Name" : "opeout", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "3", "SubInstance" : "Block_entry_proc_proc_U0", "Port" : "opeout"}]},
			{"Name" : "ram", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "Block_entry_proc_proc3_U0", "Port" : "ram"}]},
			{"Name" : "ramadr", "Type" : "None", "Direction" : "I"},
			{"Name" : "sdata", "Type" : "Vld", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "Block_entry_proc_proc3_U0", "Port" : "sdata"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_sound_operation_label1_entry3_U0", "Parent" : "0",
		"CDFG" : "dataflow_in_loop_sound_operation_label1_entry3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "1",
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
			{"Name" : "ramadr", "Type" : "None", "Direction" : "I"},
			{"Name" : "ramadr_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "2", "DependentChan" : "5", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ramadr_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_sound_operation_label1_entry4_U0", "Parent" : "0",
		"CDFG" : "dataflow_in_loop_sound_operation_label1_entry4",
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
		"StartSource" : "1",
		"StartFifo" : "start_for_dataflow_in_loop_sound_operation_label1_entry4_U0_U",
		"Port" : [
			{"Name" : "ramadr", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "1", "DependentChan" : "5", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ramadr_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ramadr_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "4", "DependentChan" : "6", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ramadr_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Block_entry_proc_proc_U0", "Parent" : "0",
		"CDFG" : "Block_entry_proc_proc",
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
			{"Name" : "opeout", "Type" : "Vld", "Direction" : "O"}]},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Block_entry_proc_proc3_U0", "Parent" : "0",
		"CDFG" : "Block_entry_proc_proc3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "8", "EstimateLatencyMax" : "8",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "ram", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "ram_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "ram_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "ramadr", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "2", "DependentChan" : "6", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ramadr_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "sdata", "Type" : "Vld", "Direction" : "O"}]},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.ramadr_c1_U", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.ramadr_c_U", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.start_for_dataflow_in_loop_sound_operation_label1_entry4_U0_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	dataflow_in_loop_sound_operation_label1 {
		opeout {Type O LastRead -1 FirstWrite 0}
		ram {Type I LastRead 8 FirstWrite -1}
		ramadr {Type I LastRead 0 FirstWrite -1}
		sdata {Type O LastRead -1 FirstWrite 8}}
	dataflow_in_loop_sound_operation_label1_entry3 {
		ramadr {Type I LastRead 0 FirstWrite -1}
		ramadr_out {Type O LastRead -1 FirstWrite 0}}
	dataflow_in_loop_sound_operation_label1_entry4 {
		ramadr {Type I LastRead 0 FirstWrite -1}
		ramadr_out {Type O LastRead -1 FirstWrite 0}}
	Block_entry_proc_proc {
		opeout {Type O LastRead -1 FirstWrite 0}}
	Block_entry_proc_proc3 {
		ram {Type I LastRead 8 FirstWrite -1}
		ramadr {Type I LastRead 0 FirstWrite -1}
		sdata {Type O LastRead -1 FirstWrite 8}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "10", "Max" : "10"}
	, {"Name" : "Interval", "Min" : "9", "Max" : "9"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	opeout { ap_vld {  { opeout out_data 1 32 }  { opeout_ap_vld out_vld 1 1 } } }
	ram { m_axi {  { m_axi_ram_AWVALID VALID 1 1 }  { m_axi_ram_AWREADY READY 0 1 }  { m_axi_ram_AWADDR ADDR 1 64 }  { m_axi_ram_AWID ID 1 1 }  { m_axi_ram_AWLEN LEN 1 32 }  { m_axi_ram_AWSIZE SIZE 1 3 }  { m_axi_ram_AWBURST BURST 1 2 }  { m_axi_ram_AWLOCK LOCK 1 2 }  { m_axi_ram_AWCACHE CACHE 1 4 }  { m_axi_ram_AWPROT PROT 1 3 }  { m_axi_ram_AWQOS QOS 1 4 }  { m_axi_ram_AWREGION REGION 1 4 }  { m_axi_ram_AWUSER USER 1 1 }  { m_axi_ram_WVALID VALID 1 1 }  { m_axi_ram_WREADY READY 0 1 }  { m_axi_ram_WDATA DATA 1 32 }  { m_axi_ram_WSTRB STRB 1 4 }  { m_axi_ram_WLAST LAST 1 1 }  { m_axi_ram_WID ID 1 1 }  { m_axi_ram_WUSER USER 1 1 }  { m_axi_ram_ARVALID VALID 1 1 }  { m_axi_ram_ARREADY READY 0 1 }  { m_axi_ram_ARADDR ADDR 1 64 }  { m_axi_ram_ARID ID 1 1 }  { m_axi_ram_ARLEN LEN 1 32 }  { m_axi_ram_ARSIZE SIZE 1 3 }  { m_axi_ram_ARBURST BURST 1 2 }  { m_axi_ram_ARLOCK LOCK 1 2 }  { m_axi_ram_ARCACHE CACHE 1 4 }  { m_axi_ram_ARPROT PROT 1 3 }  { m_axi_ram_ARQOS QOS 1 4 }  { m_axi_ram_ARREGION REGION 1 4 }  { m_axi_ram_ARUSER USER 1 1 }  { m_axi_ram_RVALID VALID 0 1 }  { m_axi_ram_RREADY READY 1 1 }  { m_axi_ram_RDATA DATA 0 32 }  { m_axi_ram_RLAST LAST 0 1 }  { m_axi_ram_RID ID 0 1 }  { m_axi_ram_RUSER USER 0 1 }  { m_axi_ram_RRESP RESP 0 2 }  { m_axi_ram_BVALID VALID 0 1 }  { m_axi_ram_BREADY READY 1 1 }  { m_axi_ram_BRESP RESP 0 2 }  { m_axi_ram_BID ID 0 1 }  { m_axi_ram_BUSER USER 0 1 } } }
	ramadr { ap_none {  { ramadr in_data 0 64 }  { ramadr_ap_vld in_vld 0 1 } } }
	sdata { ap_vld {  { sdata out_data 1 32 }  { sdata_ap_vld out_vld 1 1 } } }
}
