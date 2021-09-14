set moduleName framebuffer_copy
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {framebuffer_copy}
set C_modelType { void 0 }
set C_modelArgList {
	{ cp int 32 regular {axi_master 0}  }
	{ up int 32 regular {axi_master 1}  }
	{ copy int 64 regular {axi_slave 0}  }
	{ update int 64 regular {axi_slave 0}  }
	{ width int 32 regular {axi_slave 0}  }
	{ height int 32 regular {axi_slave 0}  }
	{ display_xsize int 32 regular {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "cp", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "copy","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "copy","bundle": "control"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "up", "interface" : "axi_master", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "update","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "update","bundle": "control"},"direction": "WRITEONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "copy", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "update", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "width", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "width","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":40}, "offset_end" : {"in":47}} , 
 	{ "Name" : "height", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "height","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":48}, "offset_end" : {"in":55}} , 
 	{ "Name" : "display_xsize", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "display_xsize","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":56}, "offset_end" : {"in":63}} ]}
# RTL Port declarations: 
set portNum 110
set portList { 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 6 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
	{ m_axi_cp_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_cp_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_cp_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_cp_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_cp_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_cp_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_cp_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_cp_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_cp_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_cp_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_cp_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_cp_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_cp_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_cp_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_cp_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_cp_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_cp_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_cp_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_cp_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_cp_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_cp_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_cp_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_cp_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_cp_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_cp_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_cp_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_cp_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_cp_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_cp_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_cp_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_cp_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_cp_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_cp_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_cp_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_cp_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_cp_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_cp_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_cp_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_cp_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_cp_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_cp_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_cp_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_cp_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_cp_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_cp_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_up_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_up_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_up_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_up_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_up_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_up_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_up_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_up_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_up_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_up_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_up_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_up_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_up_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_up_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_up_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_up_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_up_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_up_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_up_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_up_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_up_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_up_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_up_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_up_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_up_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_up_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_up_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_up_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_up_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_up_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_up_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_up_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_up_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_up_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_up_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_up_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_up_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_up_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_up_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_up_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_up_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_up_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_up_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_up_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_up_BUSER sc_in sc_lv 1 signal 1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"framebuffer_copy","role":"start","value":"0","valid_bit":"0"},{"name":"framebuffer_copy","role":"continue","value":"0","valid_bit":"4"},{"name":"framebuffer_copy","role":"auto_start","value":"0","valid_bit":"7"},{"name":"copy","role":"data","value":"16"},{"name":"update","role":"data","value":"28"},{"name":"width","role":"data","value":"40"},{"name":"height","role":"data","value":"48"},{"name":"display_xsize","role":"data","value":"56"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"framebuffer_copy","role":"start","value":"0","valid_bit":"0"},{"name":"framebuffer_copy","role":"done","value":"0","valid_bit":"1"},{"name":"framebuffer_copy","role":"idle","value":"0","valid_bit":"2"},{"name":"framebuffer_copy","role":"ready","value":"0","valid_bit":"3"},{"name":"framebuffer_copy","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "m_axi_cp_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "AWVALID" }} , 
 	{ "name": "m_axi_cp_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "AWREADY" }} , 
 	{ "name": "m_axi_cp_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "cp", "role": "AWADDR" }} , 
 	{ "name": "m_axi_cp_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cp", "role": "AWID" }} , 
 	{ "name": "m_axi_cp_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "cp", "role": "AWLEN" }} , 
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
 	{ "name": "m_axi_cp_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "cp", "role": "ARLEN" }} , 
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
 	{ "name": "m_axi_up_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "AWVALID" }} , 
 	{ "name": "m_axi_up_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "AWREADY" }} , 
 	{ "name": "m_axi_up_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "up", "role": "AWADDR" }} , 
 	{ "name": "m_axi_up_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "up", "role": "AWID" }} , 
 	{ "name": "m_axi_up_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "up", "role": "AWLEN" }} , 
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
 	{ "name": "m_axi_up_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "up", "role": "ARLEN" }} , 
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
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4"],
		"CDFG" : "framebuffer_copy",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
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
			{"ID" : "4", "Name" : "dataflow_in_loop_height_loop_U0"}],
		"OutputProcess" : [
			{"ID" : "4", "Name" : "dataflow_in_loop_height_loop_U0"}],
		"Port" : [
			{"Name" : "cp", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "dataflow_in_loop_height_loop_U0", "Port" : "cp"}]},
			{"Name" : "up", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "dataflow_in_loop_height_loop_U0", "Port" : "up"}]},
			{"Name" : "copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "update", "Type" : "None", "Direction" : "I"},
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "height", "Type" : "None", "Direction" : "I"},
			{"Name" : "display_xsize", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.cp_m_axi_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.up_m_axi_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0", "Parent" : "0", "Child" : ["5", "6", "8", "10", "11", "12", "13"],
		"CDFG" : "dataflow_in_loop_height_loop",
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
			{"ID" : "6", "Name" : "width_loop_proc5_U0"}],
		"OutputProcess" : [
			{"ID" : "8", "Name" : "copy_loop_proc_U0"}],
		"Port" : [
			{"Name" : "width", "Type" : "None", "Direction" : "I"},
			{"Name" : "y", "Type" : "None", "Direction" : "I"},
			{"Name" : "display_xsize", "Type" : "None", "Direction" : "I"},
			{"Name" : "copy", "Type" : "None", "Direction" : "I"},
			{"Name" : "cp", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "6", "SubInstance" : "width_loop_proc5_U0", "Port" : "cp"}]},
			{"Name" : "update", "Type" : "None", "Direction" : "I"},
			{"Name" : "up", "Type" : "MAXI", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "copy_loop_proc_U0", "Port" : "up"}]}]},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.src_V_U", "Parent" : "4"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.width_loop_proc5_U0", "Parent" : "4", "Child" : ["7"],
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
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "5"},
			{"Name" : "update", "Type" : "None", "Direction" : "I"},
			{"Name" : "width_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "10", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "11", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "display_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "12", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "display_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "update_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "13", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "update_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "7", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.width_loop_proc5_U0.mul_32ns_32ns_62_2_1_U1", "Parent" : "6"},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.copy_loop_proc_U0", "Parent" : "4", "Child" : ["9"],
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
			{"Name" : "width", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "6", "DependentChan" : "10", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "width_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "6", "DependentChan" : "11", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "display_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "6", "DependentChan" : "12", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "display_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "6", "DependentChan" : "5"},
			{"Name" : "update", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "6", "DependentChan" : "13", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "update_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "up", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "up_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "up_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "up_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "9", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.copy_loop_proc_U0.mul_32ns_32ns_62_2_1_U14", "Parent" : "8"},
	{"ID" : "10", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.width_c_U", "Parent" : "4"},
	{"ID" : "11", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.y_c_U", "Parent" : "4"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.display_xsize_c_U", "Parent" : "4"},
	{"ID" : "13", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.update_c_U", "Parent" : "4"}]}


set ArgLastReadFirstWriteLatency {
	framebuffer_copy {
		cp {Type I LastRead 11 FirstWrite -1}
		up {Type O LastRead 6 FirstWrite 7}
		copy {Type I LastRead 0 FirstWrite -1}
		update {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		height {Type I LastRead 0 FirstWrite -1}
		display_xsize {Type I LastRead 0 FirstWrite -1}}
	dataflow_in_loop_height_loop {
		width {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		display_xsize {Type I LastRead 0 FirstWrite -1}
		copy {Type I LastRead 0 FirstWrite -1}
		cp {Type I LastRead 11 FirstWrite -1}
		update {Type I LastRead 0 FirstWrite -1}
		up {Type O LastRead 6 FirstWrite 7}}
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
		update_out {Type O LastRead -1 FirstWrite 0}}
	copy_loop_proc {
		width {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		display_xsize {Type I LastRead 0 FirstWrite -1}
		src_V1 {Type I LastRead 5 FirstWrite -1}
		update {Type I LastRead 0 FirstWrite -1}
		up {Type O LastRead 6 FirstWrite 7}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "29", "Max" : "314094"}
	, {"Name" : "Interval", "Min" : "30", "Max" : "314095"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	cp { m_axi {  { m_axi_cp_AWVALID VALID 1 1 }  { m_axi_cp_AWREADY READY 0 1 }  { m_axi_cp_AWADDR ADDR 1 64 }  { m_axi_cp_AWID ID 1 1 }  { m_axi_cp_AWLEN LEN 1 8 }  { m_axi_cp_AWSIZE SIZE 1 3 }  { m_axi_cp_AWBURST BURST 1 2 }  { m_axi_cp_AWLOCK LOCK 1 2 }  { m_axi_cp_AWCACHE CACHE 1 4 }  { m_axi_cp_AWPROT PROT 1 3 }  { m_axi_cp_AWQOS QOS 1 4 }  { m_axi_cp_AWREGION REGION 1 4 }  { m_axi_cp_AWUSER USER 1 1 }  { m_axi_cp_WVALID VALID 1 1 }  { m_axi_cp_WREADY READY 0 1 }  { m_axi_cp_WDATA DATA 1 32 }  { m_axi_cp_WSTRB STRB 1 4 }  { m_axi_cp_WLAST LAST 1 1 }  { m_axi_cp_WID ID 1 1 }  { m_axi_cp_WUSER USER 1 1 }  { m_axi_cp_ARVALID VALID 1 1 }  { m_axi_cp_ARREADY READY 0 1 }  { m_axi_cp_ARADDR ADDR 1 64 }  { m_axi_cp_ARID ID 1 1 }  { m_axi_cp_ARLEN LEN 1 8 }  { m_axi_cp_ARSIZE SIZE 1 3 }  { m_axi_cp_ARBURST BURST 1 2 }  { m_axi_cp_ARLOCK LOCK 1 2 }  { m_axi_cp_ARCACHE CACHE 1 4 }  { m_axi_cp_ARPROT PROT 1 3 }  { m_axi_cp_ARQOS QOS 1 4 }  { m_axi_cp_ARREGION REGION 1 4 }  { m_axi_cp_ARUSER USER 1 1 }  { m_axi_cp_RVALID VALID 0 1 }  { m_axi_cp_RREADY READY 1 1 }  { m_axi_cp_RDATA DATA 0 32 }  { m_axi_cp_RLAST LAST 0 1 }  { m_axi_cp_RID ID 0 1 }  { m_axi_cp_RUSER USER 0 1 }  { m_axi_cp_RRESP RESP 0 2 }  { m_axi_cp_BVALID VALID 0 1 }  { m_axi_cp_BREADY READY 1 1 }  { m_axi_cp_BRESP RESP 0 2 }  { m_axi_cp_BID ID 0 1 }  { m_axi_cp_BUSER USER 0 1 } } }
	up { m_axi {  { m_axi_up_AWVALID VALID 1 1 }  { m_axi_up_AWREADY READY 0 1 }  { m_axi_up_AWADDR ADDR 1 64 }  { m_axi_up_AWID ID 1 1 }  { m_axi_up_AWLEN LEN 1 8 }  { m_axi_up_AWSIZE SIZE 1 3 }  { m_axi_up_AWBURST BURST 1 2 }  { m_axi_up_AWLOCK LOCK 1 2 }  { m_axi_up_AWCACHE CACHE 1 4 }  { m_axi_up_AWPROT PROT 1 3 }  { m_axi_up_AWQOS QOS 1 4 }  { m_axi_up_AWREGION REGION 1 4 }  { m_axi_up_AWUSER USER 1 1 }  { m_axi_up_WVALID VALID 1 1 }  { m_axi_up_WREADY READY 0 1 }  { m_axi_up_WDATA DATA 1 32 }  { m_axi_up_WSTRB STRB 1 4 }  { m_axi_up_WLAST LAST 1 1 }  { m_axi_up_WID ID 1 1 }  { m_axi_up_WUSER USER 1 1 }  { m_axi_up_ARVALID VALID 1 1 }  { m_axi_up_ARREADY READY 0 1 }  { m_axi_up_ARADDR ADDR 1 64 }  { m_axi_up_ARID ID 1 1 }  { m_axi_up_ARLEN LEN 1 8 }  { m_axi_up_ARSIZE SIZE 1 3 }  { m_axi_up_ARBURST BURST 1 2 }  { m_axi_up_ARLOCK LOCK 1 2 }  { m_axi_up_ARCACHE CACHE 1 4 }  { m_axi_up_ARPROT PROT 1 3 }  { m_axi_up_ARQOS QOS 1 4 }  { m_axi_up_ARREGION REGION 1 4 }  { m_axi_up_ARUSER USER 1 1 }  { m_axi_up_RVALID VALID 0 1 }  { m_axi_up_RREADY READY 1 1 }  { m_axi_up_RDATA DATA 0 32 }  { m_axi_up_RLAST LAST 0 1 }  { m_axi_up_RID ID 0 1 }  { m_axi_up_RUSER USER 0 1 }  { m_axi_up_RRESP RESP 0 2 }  { m_axi_up_BVALID VALID 0 1 }  { m_axi_up_BREADY READY 1 1 }  { m_axi_up_BRESP RESP 0 2 }  { m_axi_up_BID ID 0 1 }  { m_axi_up_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ cp { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 32 MAX_WRITE_BURST_LENGTH 16 } } \
	{ up { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 16 MAX_WRITE_BURST_LENGTH 32 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ cp 1 }
	{ up 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ cp 1 }
	{ up 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
