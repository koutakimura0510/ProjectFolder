set moduleName Block_entry_proc_proc3
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
set C_modelName {Block_entry_proc_proc3}
set C_modelType { void 0 }
set C_modelArgList {
	{ ram int 32 regular {axi_master 0}  }
	{ ramadr int 64 regular {fifo 0}  }
	{ sdata int 32 regular {pointer 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "ram", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "ramadr", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "sdata", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 57
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ m_axi_ram_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_ram_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_ram_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_ram_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_ram_AWLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_ram_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_ram_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_ram_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_ram_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_ram_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_ram_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_ram_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_ram_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_ram_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_ram_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_ram_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_ram_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_ram_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_ram_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_ram_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_ram_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_ram_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_ram_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_ram_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_ram_ARLEN sc_out sc_lv 32 signal 0 } 
	{ m_axi_ram_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_ram_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_ram_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_ram_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_ram_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_ram_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_ram_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_ram_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_ram_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_ram_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_ram_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_ram_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_ram_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_ram_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_ram_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_ram_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_ram_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_ram_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_ram_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_ram_BUSER sc_in sc_lv 1 signal 0 } 
	{ ramadr_dout sc_in sc_lv 64 signal 1 } 
	{ ramadr_empty_n sc_in sc_logic 1 signal 1 } 
	{ ramadr_read sc_out sc_logic 1 signal 1 } 
	{ sdata sc_out sc_lv 32 signal 2 } 
	{ sdata_ap_vld sc_out sc_logic 1 outvld 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
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
 	{ "name": "ramadr_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "ramadr", "role": "dout" }} , 
 	{ "name": "ramadr_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ramadr", "role": "empty_n" }} , 
 	{ "name": "ramadr_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "ramadr", "role": "read" }} , 
 	{ "name": "sdata", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "sdata", "role": "default" }} , 
 	{ "name": "sdata_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "sdata", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "",
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
			{"Name" : "ramadr", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "0", "DependentChan" : "0", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ramadr_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "sdata", "Type" : "Vld", "Direction" : "O"}]}]}


set ArgLastReadFirstWriteLatency {
	Block_entry_proc_proc3 {
		ram {Type I LastRead 8 FirstWrite -1}
		ramadr {Type I LastRead 0 FirstWrite -1}
		sdata {Type O LastRead -1 FirstWrite 8}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "8", "Max" : "8"}
	, {"Name" : "Interval", "Min" : "8", "Max" : "8"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	ram { m_axi {  { m_axi_ram_AWVALID VALID 1 1 }  { m_axi_ram_AWREADY READY 0 1 }  { m_axi_ram_AWADDR ADDR 1 64 }  { m_axi_ram_AWID ID 1 1 }  { m_axi_ram_AWLEN LEN 1 32 }  { m_axi_ram_AWSIZE SIZE 1 3 }  { m_axi_ram_AWBURST BURST 1 2 }  { m_axi_ram_AWLOCK LOCK 1 2 }  { m_axi_ram_AWCACHE CACHE 1 4 }  { m_axi_ram_AWPROT PROT 1 3 }  { m_axi_ram_AWQOS QOS 1 4 }  { m_axi_ram_AWREGION REGION 1 4 }  { m_axi_ram_AWUSER USER 1 1 }  { m_axi_ram_WVALID VALID 1 1 }  { m_axi_ram_WREADY READY 0 1 }  { m_axi_ram_WDATA DATA 1 32 }  { m_axi_ram_WSTRB STRB 1 4 }  { m_axi_ram_WLAST LAST 1 1 }  { m_axi_ram_WID ID 1 1 }  { m_axi_ram_WUSER USER 1 1 }  { m_axi_ram_ARVALID VALID 1 1 }  { m_axi_ram_ARREADY READY 0 1 }  { m_axi_ram_ARADDR ADDR 1 64 }  { m_axi_ram_ARID ID 1 1 }  { m_axi_ram_ARLEN LEN 1 32 }  { m_axi_ram_ARSIZE SIZE 1 3 }  { m_axi_ram_ARBURST BURST 1 2 }  { m_axi_ram_ARLOCK LOCK 1 2 }  { m_axi_ram_ARCACHE CACHE 1 4 }  { m_axi_ram_ARPROT PROT 1 3 }  { m_axi_ram_ARQOS QOS 1 4 }  { m_axi_ram_ARREGION REGION 1 4 }  { m_axi_ram_ARUSER USER 1 1 }  { m_axi_ram_RVALID VALID 0 1 }  { m_axi_ram_RREADY READY 1 1 }  { m_axi_ram_RDATA DATA 0 32 }  { m_axi_ram_RLAST LAST 0 1 }  { m_axi_ram_RID ID 0 1 }  { m_axi_ram_RUSER USER 0 1 }  { m_axi_ram_RRESP RESP 0 2 }  { m_axi_ram_BVALID VALID 0 1 }  { m_axi_ram_BREADY READY 1 1 }  { m_axi_ram_BRESP RESP 0 2 }  { m_axi_ram_BID ID 0 1 }  { m_axi_ram_BUSER USER 0 1 } } }
	ramadr { ap_fifo {  { ramadr_dout fifo_data 0 64 }  { ramadr_empty_n fifo_status 0 1 }  { ramadr_read fifo_update 1 1 } } }
	sdata { ap_vld {  { sdata out_data 1 32 }  { sdata_ap_vld out_vld 1 1 } } }
}
