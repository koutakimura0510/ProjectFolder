set moduleName led_blink
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_none
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {led_blink}
set C_modelType { void 0 }
set C_modelArgList {
	{ onoff int 8 regular {axi_master 0}  }
	{ onoff_offset int 64 regular {axi_slave 0}  }
	{ led int 4 regular {pointer 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "onoff", "interface" : "axi_master", "bitwidth" : 8, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "onoff","cData": "char","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "onoff_offset","bundle": "control"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "onoff_offset", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "led", "interface" : "wire", "bitwidth" : 4, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "led","cData": "int4","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} ]}
# RTL Port declarations: 
set portNum 65
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ m_axi_onoff_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_onoff_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_onoff_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_onoff_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_onoff_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_onoff_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_onoff_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_onoff_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_onoff_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_onoff_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_onoff_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_onoff_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_onoff_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_onoff_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_onoff_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_onoff_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_onoff_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_onoff_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_onoff_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_onoff_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_onoff_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_onoff_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_onoff_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_onoff_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_onoff_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_onoff_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_onoff_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_onoff_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_onoff_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_onoff_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_onoff_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_onoff_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_onoff_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_onoff_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_onoff_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_onoff_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_onoff_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_onoff_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_onoff_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_onoff_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_onoff_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_onoff_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_onoff_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_onoff_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_onoff_BUSER sc_in sc_lv 1 signal 0 } 
	{ led sc_out sc_lv 4 signal 2 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 5 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"led_blink","role":"start","value":"0","valid_bit":"0"},{"name":"led_blink","role":"continue","value":"0","valid_bit":"4"},{"name":"led_blink","role":"auto_start","value":"0","valid_bit":"7"},{"name":"onoff_offset","role":"data","value":"16"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"led_blink","role":"start","value":"0","valid_bit":"0"},{"name":"led_blink","role":"done","value":"0","valid_bit":"1"},{"name":"led_blink","role":"idle","value":"0","valid_bit":"2"},{"name":"led_blink","role":"ready","value":"0","valid_bit":"3"},{"name":"led_blink","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_onoff_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "AWVALID" }} , 
 	{ "name": "m_axi_onoff_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "AWREADY" }} , 
 	{ "name": "m_axi_onoff_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "onoff", "role": "AWADDR" }} , 
 	{ "name": "m_axi_onoff_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "AWID" }} , 
 	{ "name": "m_axi_onoff_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "onoff", "role": "AWLEN" }} , 
 	{ "name": "m_axi_onoff_AWSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "onoff", "role": "AWSIZE" }} , 
 	{ "name": "m_axi_onoff_AWBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "onoff", "role": "AWBURST" }} , 
 	{ "name": "m_axi_onoff_AWLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "onoff", "role": "AWLOCK" }} , 
 	{ "name": "m_axi_onoff_AWCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "onoff", "role": "AWCACHE" }} , 
 	{ "name": "m_axi_onoff_AWPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "onoff", "role": "AWPROT" }} , 
 	{ "name": "m_axi_onoff_AWQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "onoff", "role": "AWQOS" }} , 
 	{ "name": "m_axi_onoff_AWREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "onoff", "role": "AWREGION" }} , 
 	{ "name": "m_axi_onoff_AWUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "AWUSER" }} , 
 	{ "name": "m_axi_onoff_WVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "WVALID" }} , 
 	{ "name": "m_axi_onoff_WREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "WREADY" }} , 
 	{ "name": "m_axi_onoff_WDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "onoff", "role": "WDATA" }} , 
 	{ "name": "m_axi_onoff_WSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "onoff", "role": "WSTRB" }} , 
 	{ "name": "m_axi_onoff_WLAST", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "WLAST" }} , 
 	{ "name": "m_axi_onoff_WID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "WID" }} , 
 	{ "name": "m_axi_onoff_WUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "WUSER" }} , 
 	{ "name": "m_axi_onoff_ARVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "ARVALID" }} , 
 	{ "name": "m_axi_onoff_ARREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "ARREADY" }} , 
 	{ "name": "m_axi_onoff_ARADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "onoff", "role": "ARADDR" }} , 
 	{ "name": "m_axi_onoff_ARID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "ARID" }} , 
 	{ "name": "m_axi_onoff_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "onoff", "role": "ARLEN" }} , 
 	{ "name": "m_axi_onoff_ARSIZE", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "onoff", "role": "ARSIZE" }} , 
 	{ "name": "m_axi_onoff_ARBURST", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "onoff", "role": "ARBURST" }} , 
 	{ "name": "m_axi_onoff_ARLOCK", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "onoff", "role": "ARLOCK" }} , 
 	{ "name": "m_axi_onoff_ARCACHE", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "onoff", "role": "ARCACHE" }} , 
 	{ "name": "m_axi_onoff_ARPROT", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "onoff", "role": "ARPROT" }} , 
 	{ "name": "m_axi_onoff_ARQOS", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "onoff", "role": "ARQOS" }} , 
 	{ "name": "m_axi_onoff_ARREGION", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "onoff", "role": "ARREGION" }} , 
 	{ "name": "m_axi_onoff_ARUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "ARUSER" }} , 
 	{ "name": "m_axi_onoff_RVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "RVALID" }} , 
 	{ "name": "m_axi_onoff_RREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "RREADY" }} , 
 	{ "name": "m_axi_onoff_RDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "onoff", "role": "RDATA" }} , 
 	{ "name": "m_axi_onoff_RLAST", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "RLAST" }} , 
 	{ "name": "m_axi_onoff_RID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "RID" }} , 
 	{ "name": "m_axi_onoff_RUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "RUSER" }} , 
 	{ "name": "m_axi_onoff_RRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "onoff", "role": "RRESP" }} , 
 	{ "name": "m_axi_onoff_BVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "BVALID" }} , 
 	{ "name": "m_axi_onoff_BREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "BREADY" }} , 
 	{ "name": "m_axi_onoff_BRESP", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "onoff", "role": "BRESP" }} , 
 	{ "name": "m_axi_onoff_BID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "BID" }} , 
 	{ "name": "m_axi_onoff_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "onoff", "role": "BUSER" }} , 
 	{ "name": "led", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "led", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
		"CDFG" : "led_blink",
		"Protocol" : "ap_ctrl_none",
		"ControlExist" : "0", "ap_start" : "0", "ap_ready" : "0", "ap_done" : "0", "ap_continue" : "0", "ap_idle" : "0", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "8", "EstimateLatencyMax" : "8",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "onoff", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "onoff_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "onoff_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "onoff_offset", "Type" : "None", "Direction" : "I"},
			{"Name" : "led", "Type" : "None", "Direction" : "O"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.onoff_m_axi_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	led_blink {
		onoff {Type I LastRead 8 FirstWrite -1}
		onoff_offset {Type I LastRead 0 FirstWrite -1}
		led {Type O LastRead -1 FirstWrite 8}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "8", "Max" : "8"}
	, {"Name" : "Interval", "Min" : "9", "Max" : "9"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	onoff { m_axi {  { m_axi_onoff_AWVALID VALID 1 1 }  { m_axi_onoff_AWREADY READY 0 1 }  { m_axi_onoff_AWADDR ADDR 1 64 }  { m_axi_onoff_AWID ID 1 1 }  { m_axi_onoff_AWLEN LEN 1 8 }  { m_axi_onoff_AWSIZE SIZE 1 3 }  { m_axi_onoff_AWBURST BURST 1 2 }  { m_axi_onoff_AWLOCK LOCK 1 2 }  { m_axi_onoff_AWCACHE CACHE 1 4 }  { m_axi_onoff_AWPROT PROT 1 3 }  { m_axi_onoff_AWQOS QOS 1 4 }  { m_axi_onoff_AWREGION REGION 1 4 }  { m_axi_onoff_AWUSER USER 1 1 }  { m_axi_onoff_WVALID VALID 1 1 }  { m_axi_onoff_WREADY READY 0 1 }  { m_axi_onoff_WDATA DATA 1 32 }  { m_axi_onoff_WSTRB STRB 1 4 }  { m_axi_onoff_WLAST LAST 1 1 }  { m_axi_onoff_WID ID 1 1 }  { m_axi_onoff_WUSER USER 1 1 }  { m_axi_onoff_ARVALID VALID 1 1 }  { m_axi_onoff_ARREADY READY 0 1 }  { m_axi_onoff_ARADDR ADDR 1 64 }  { m_axi_onoff_ARID ID 1 1 }  { m_axi_onoff_ARLEN LEN 1 8 }  { m_axi_onoff_ARSIZE SIZE 1 3 }  { m_axi_onoff_ARBURST BURST 1 2 }  { m_axi_onoff_ARLOCK LOCK 1 2 }  { m_axi_onoff_ARCACHE CACHE 1 4 }  { m_axi_onoff_ARPROT PROT 1 3 }  { m_axi_onoff_ARQOS QOS 1 4 }  { m_axi_onoff_ARREGION REGION 1 4 }  { m_axi_onoff_ARUSER USER 1 1 }  { m_axi_onoff_RVALID VALID 0 1 }  { m_axi_onoff_RREADY READY 1 1 }  { m_axi_onoff_RDATA DATA 0 32 }  { m_axi_onoff_RLAST LAST 0 1 }  { m_axi_onoff_RID ID 0 1 }  { m_axi_onoff_RUSER USER 0 1 }  { m_axi_onoff_RRESP RESP 0 2 }  { m_axi_onoff_BVALID VALID 0 1 }  { m_axi_onoff_BREADY READY 1 1 }  { m_axi_onoff_BRESP RESP 0 2 }  { m_axi_onoff_BID ID 0 1 }  { m_axi_onoff_BUSER USER 0 1 } } }
	led { ap_none {  { led out_data 1 4 } } }
}

set busDeadlockParameterList { 
	{ onoff { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 16 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ onoff 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ onoff 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
