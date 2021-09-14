set moduleName mapchip_png
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
set C_modelName {mapchip_png}
set C_modelType { void 0 }
set C_modelArgList {
	{ src int 32 regular {axi_master 0}  }
	{ dst int 32 regular {axi_master 2}  }
	{ srcin int 64 regular {axi_slave 0}  }
	{ dstin int 64 regular {axi_slave 0}  }
	{ dstout int 64 regular {axi_slave 0}  }
	{ mapchip_maxwidth int 32 regular {axi_slave 0}  }
	{ mapchip_maxheight int 32 regular {axi_slave 0}  }
	{ mapchip_draw_xsize int 32 regular {axi_slave 0}  }
	{ mapchip_draw_ysize int 32 regular {axi_slave 0}  }
	{ xstart_pos int 32 regular {axi_slave 0}  }
	{ ystart_pos int 32 regular {axi_slave 0}  }
	{ frame_size int 32 regular {axi_slave 0}  }
	{ alpha int 8 regular {axi_slave 0}  }
	{ id int 32 regular {axi_slave 0}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "src", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "srcin","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "srcin","bundle": "control"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "dst", "interface" : "axi_master", "bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "dstin","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "dstin","bundle": "control"},"direction": "READONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]},{"cName": "dstout","cData": "int","bit_use": { "low": 0,"up": 0},"offset": { "type": "dynamic","port_name": "dstout","bundle": "control"},"direction": "WRITEONLY","cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "srcin", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":16}, "offset_end" : {"in":27}} , 
 	{ "Name" : "dstin", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":28}, "offset_end" : {"in":39}} , 
 	{ "Name" : "dstout", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 64, "direction" : "READONLY", "offset" : {"in":40}, "offset_end" : {"in":51}} , 
 	{ "Name" : "mapchip_maxwidth", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "mapchip_maxwidth","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":52}, "offset_end" : {"in":59}} , 
 	{ "Name" : "mapchip_maxheight", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "mapchip_maxheight","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":60}, "offset_end" : {"in":67}} , 
 	{ "Name" : "mapchip_draw_xsize", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "mapchip_draw_xsize","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":68}, "offset_end" : {"in":75}} , 
 	{ "Name" : "mapchip_draw_ysize", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "mapchip_draw_ysize","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":76}, "offset_end" : {"in":83}} , 
 	{ "Name" : "xstart_pos", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "xstart_pos","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":84}, "offset_end" : {"in":91}} , 
 	{ "Name" : "ystart_pos", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "ystart_pos","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":92}, "offset_end" : {"in":99}} , 
 	{ "Name" : "frame_size", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "frame_size","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":100}, "offset_end" : {"in":107}} , 
 	{ "Name" : "alpha", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 8, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "alpha","cData": "char","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":108}, "offset_end" : {"in":115}} , 
 	{ "Name" : "id", "interface" : "axi_slave", "bundle":"control","type":"ap_none","bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "id","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}], "offset" : {"in":116}, "offset_end" : {"in":123}} ]}
# RTL Port declarations: 
set portNum 110
set portList { 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 7 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 7 signal -1 } 
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
	{ m_axi_src_AWVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_src_AWREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_src_AWADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_src_AWID sc_out sc_lv 1 signal 0 } 
	{ m_axi_src_AWLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_src_AWSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_src_AWBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_src_AWLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_src_AWCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_src_AWPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_src_AWQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_src_AWREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_src_AWUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_src_WVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_src_WREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_src_WDATA sc_out sc_lv 32 signal 0 } 
	{ m_axi_src_WSTRB sc_out sc_lv 4 signal 0 } 
	{ m_axi_src_WLAST sc_out sc_logic 1 signal 0 } 
	{ m_axi_src_WID sc_out sc_lv 1 signal 0 } 
	{ m_axi_src_WUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_src_ARVALID sc_out sc_logic 1 signal 0 } 
	{ m_axi_src_ARREADY sc_in sc_logic 1 signal 0 } 
	{ m_axi_src_ARADDR sc_out sc_lv 64 signal 0 } 
	{ m_axi_src_ARID sc_out sc_lv 1 signal 0 } 
	{ m_axi_src_ARLEN sc_out sc_lv 8 signal 0 } 
	{ m_axi_src_ARSIZE sc_out sc_lv 3 signal 0 } 
	{ m_axi_src_ARBURST sc_out sc_lv 2 signal 0 } 
	{ m_axi_src_ARLOCK sc_out sc_lv 2 signal 0 } 
	{ m_axi_src_ARCACHE sc_out sc_lv 4 signal 0 } 
	{ m_axi_src_ARPROT sc_out sc_lv 3 signal 0 } 
	{ m_axi_src_ARQOS sc_out sc_lv 4 signal 0 } 
	{ m_axi_src_ARREGION sc_out sc_lv 4 signal 0 } 
	{ m_axi_src_ARUSER sc_out sc_lv 1 signal 0 } 
	{ m_axi_src_RVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_src_RREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_src_RDATA sc_in sc_lv 32 signal 0 } 
	{ m_axi_src_RLAST sc_in sc_logic 1 signal 0 } 
	{ m_axi_src_RID sc_in sc_lv 1 signal 0 } 
	{ m_axi_src_RUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_src_RRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_src_BVALID sc_in sc_logic 1 signal 0 } 
	{ m_axi_src_BREADY sc_out sc_logic 1 signal 0 } 
	{ m_axi_src_BRESP sc_in sc_lv 2 signal 0 } 
	{ m_axi_src_BID sc_in sc_lv 1 signal 0 } 
	{ m_axi_src_BUSER sc_in sc_lv 1 signal 0 } 
	{ m_axi_dst_AWVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_dst_AWREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_dst_AWADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_dst_AWID sc_out sc_lv 1 signal 1 } 
	{ m_axi_dst_AWLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_dst_AWSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_dst_AWBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_dst_AWLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_dst_AWCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_dst_AWPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_dst_AWQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_dst_AWREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_dst_AWUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_dst_WVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_dst_WREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_dst_WDATA sc_out sc_lv 32 signal 1 } 
	{ m_axi_dst_WSTRB sc_out sc_lv 4 signal 1 } 
	{ m_axi_dst_WLAST sc_out sc_logic 1 signal 1 } 
	{ m_axi_dst_WID sc_out sc_lv 1 signal 1 } 
	{ m_axi_dst_WUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_dst_ARVALID sc_out sc_logic 1 signal 1 } 
	{ m_axi_dst_ARREADY sc_in sc_logic 1 signal 1 } 
	{ m_axi_dst_ARADDR sc_out sc_lv 64 signal 1 } 
	{ m_axi_dst_ARID sc_out sc_lv 1 signal 1 } 
	{ m_axi_dst_ARLEN sc_out sc_lv 8 signal 1 } 
	{ m_axi_dst_ARSIZE sc_out sc_lv 3 signal 1 } 
	{ m_axi_dst_ARBURST sc_out sc_lv 2 signal 1 } 
	{ m_axi_dst_ARLOCK sc_out sc_lv 2 signal 1 } 
	{ m_axi_dst_ARCACHE sc_out sc_lv 4 signal 1 } 
	{ m_axi_dst_ARPROT sc_out sc_lv 3 signal 1 } 
	{ m_axi_dst_ARQOS sc_out sc_lv 4 signal 1 } 
	{ m_axi_dst_ARREGION sc_out sc_lv 4 signal 1 } 
	{ m_axi_dst_ARUSER sc_out sc_lv 1 signal 1 } 
	{ m_axi_dst_RVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_dst_RREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_dst_RDATA sc_in sc_lv 32 signal 1 } 
	{ m_axi_dst_RLAST sc_in sc_logic 1 signal 1 } 
	{ m_axi_dst_RID sc_in sc_lv 1 signal 1 } 
	{ m_axi_dst_RUSER sc_in sc_lv 1 signal 1 } 
	{ m_axi_dst_RRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_dst_BVALID sc_in sc_logic 1 signal 1 } 
	{ m_axi_dst_BREADY sc_out sc_logic 1 signal 1 } 
	{ m_axi_dst_BRESP sc_in sc_lv 2 signal 1 } 
	{ m_axi_dst_BID sc_in sc_lv 1 signal 1 } 
	{ m_axi_dst_BUSER sc_in sc_lv 1 signal 1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"mapchip_png","role":"start","value":"0","valid_bit":"0"},{"name":"mapchip_png","role":"continue","value":"0","valid_bit":"4"},{"name":"mapchip_png","role":"auto_start","value":"0","valid_bit":"7"},{"name":"srcin","role":"data","value":"16"},{"name":"dstin","role":"data","value":"28"},{"name":"dstout","role":"data","value":"40"},{"name":"mapchip_maxwidth","role":"data","value":"52"},{"name":"mapchip_maxheight","role":"data","value":"60"},{"name":"mapchip_draw_xsize","role":"data","value":"68"},{"name":"mapchip_draw_ysize","role":"data","value":"76"},{"name":"xstart_pos","role":"data","value":"84"},{"name":"ystart_pos","role":"data","value":"92"},{"name":"frame_size","role":"data","value":"100"},{"name":"alpha","role":"data","value":"108"},{"name":"id","role":"data","value":"116"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"mapchip_png","role":"start","value":"0","valid_bit":"0"},{"name":"mapchip_png","role":"done","value":"0","valid_bit":"1"},{"name":"mapchip_png","role":"idle","value":"0","valid_bit":"2"},{"name":"mapchip_png","role":"ready","value":"0","valid_bit":"3"},{"name":"mapchip_png","role":"auto_start","value":"0","valid_bit":"7"}] },
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
 	{ "name": "m_axi_src_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "AWVALID" }} , 
 	{ "name": "m_axi_src_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "AWREADY" }} , 
 	{ "name": "m_axi_src_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "src", "role": "AWADDR" }} , 
 	{ "name": "m_axi_src_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "src", "role": "AWID" }} , 
 	{ "name": "m_axi_src_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "src", "role": "AWLEN" }} , 
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
 	{ "name": "m_axi_src_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "src", "role": "ARLEN" }} , 
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
 	{ "name": "m_axi_dst_AWVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "AWVALID" }} , 
 	{ "name": "m_axi_dst_AWREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "AWREADY" }} , 
 	{ "name": "m_axi_dst_AWADDR", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "dst", "role": "AWADDR" }} , 
 	{ "name": "m_axi_dst_AWID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "AWID" }} , 
 	{ "name": "m_axi_dst_AWLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dst", "role": "AWLEN" }} , 
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
 	{ "name": "m_axi_dst_ARLEN", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "dst", "role": "ARLEN" }} , 
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
 	{ "name": "m_axi_dst_BUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "dst", "role": "BUSER" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4"],
		"CDFG" : "mapchip_png",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "43", "EstimateLatencyMax" : "317940",
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
			{"Name" : "src", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "dataflow_in_loop_height_loop_U0", "Port" : "src"}]},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "dataflow_in_loop_height_loop_U0", "Port" : "dst"}]},
			{"Name" : "srcin", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstin", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstout", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxwidth", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxheight", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_draw_xsize", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_draw_ysize", "Type" : "None", "Direction" : "I"},
			{"Name" : "xstart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "ystart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "alpha", "Type" : "None", "Direction" : "I"},
			{"Name" : "id", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.control_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.src_m_axi_U", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dst_m_axi_U", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0", "Parent" : "0", "Child" : ["5", "6", "7", "8", "12", "14", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47"],
		"CDFG" : "dataflow_in_loop_height_loop",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "41", "EstimateLatencyMax" : "1319",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "7", "Name" : "dataflow_in_loop_height_loop_entry6_U0"},
			{"ID" : "8", "Name" : "src_loop_proc_U0"},
			{"ID" : "12", "Name" : "dstin_loop_proc_U0"}],
		"OutputProcess" : [
			{"ID" : "14", "Name" : "dstout_loop_proc_U0"}],
		"Port" : [
			{"Name" : "mapchip_draw_xsize", "Type" : "None", "Direction" : "I"},
			{"Name" : "id", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxheight", "Type" : "None", "Direction" : "I"},
			{"Name" : "ystart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxwidth", "Type" : "None", "Direction" : "I"},
			{"Name" : "xstart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "y", "Type" : "None", "Direction" : "I"},
			{"Name" : "srcin", "Type" : "None", "Direction" : "I"},
			{"Name" : "src", "Type" : "MAXI", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "8", "SubInstance" : "src_loop_proc_U0", "Port" : "src"}]},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstin", "Type" : "None", "Direction" : "I"},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "IO",
				"SubConnect" : [
					{"ID" : "12", "SubInstance" : "dstin_loop_proc_U0", "Port" : "dst"},
					{"ID" : "14", "SubInstance" : "dstout_loop_proc_U0", "Port" : "dst"}]},
			{"Name" : "alpha", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstout", "Type" : "None", "Direction" : "I"}]},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.src_V_U", "Parent" : "4"},
	{"ID" : "6", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dst_V_U", "Parent" : "4"},
	{"ID" : "7", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dataflow_in_loop_height_loop_entry6_U0", "Parent" : "4",
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
			{"Name" : "id", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxheight", "Type" : "None", "Direction" : "I"},
			{"Name" : "ystart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_maxwidth", "Type" : "None", "Direction" : "I"},
			{"Name" : "xstart_pos", "Type" : "None", "Direction" : "I"},
			{"Name" : "y", "Type" : "None", "Direction" : "I"},
			{"Name" : "srcin", "Type" : "None", "Direction" : "I"},
			{"Name" : "frame_size", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstin", "Type" : "None", "Direction" : "I"},
			{"Name" : "alpha", "Type" : "None", "Direction" : "I"},
			{"Name" : "dstout", "Type" : "None", "Direction" : "I"},
			{"Name" : "mapchip_draw_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "31", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_draw_xsize_out1", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "12", "DependentChan" : "32", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out1_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "id_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "33", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "id_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxheight_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "34", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxheight_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ystart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "35", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ystart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxwidth_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "36", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxwidth_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xstart_pos_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "37", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xstart_pos_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "38", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out2", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "12", "DependentChan" : "39", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out2_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "srcin_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "8", "DependentChan" : "40", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "srcin_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "12", "DependentChan" : "41", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size_out3", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "14", "DependentChan" : "42", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_out3_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstin_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "12", "DependentChan" : "43", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstin_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "alpha_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "14", "DependentChan" : "44", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "alpha_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstout_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "14", "DependentChan" : "45", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstout_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "8", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.src_loop_proc_U0", "Parent" : "4", "Child" : ["9", "10", "11"],
		"CDFG" : "src_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "18", "EstimateLatencyMax" : "657",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mapchip_draw_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "31", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "id", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "33", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "id_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxheight", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "34", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxheight_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "ystart_pos", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "35", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "ystart_pos_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "mapchip_maxwidth", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "36", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_maxwidth_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "xstart_pos", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "37", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "xstart_pos_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "38", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "srcin", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "40", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "srcin_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "src_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "src_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "O", "DependentProc" : "14", "DependentChan" : "5"},
			{"Name" : "mapchip_draw_xsize_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "14", "DependentChan" : "46", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_out_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y_out", "Type" : "Fifo", "Direction" : "O", "DependentProc" : "14", "DependentChan" : "47", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_out_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "9", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.src_loop_proc_U0.mul_32s_32s_32_2_1_U28", "Parent" : "8"},
	{"ID" : "10", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.src_loop_proc_U0.mul_32s_32s_32_2_1_U29", "Parent" : "8"},
	{"ID" : "11", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.src_loop_proc_U0.mul_32ns_32ns_62_2_1_U30", "Parent" : "8"},
	{"ID" : "12", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstin_loop_proc_U0", "Parent" : "4", "Child" : ["13"],
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
			{"Name" : "mapchip_draw_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "32", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "39", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "41", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstin", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "43", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstin_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "dst_blk_n_AR", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_R", "Type" : "RtlSignal"}]},
			{"Name" : "dst_V2", "Type" : "Memory", "Direction" : "O", "DependentProc" : "14", "DependentChan" : "6"}]},
	{"ID" : "13", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstin_loop_proc_U0.mul_32ns_32ns_62_2_1_U45", "Parent" : "12"},
	{"ID" : "14", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0", "Parent" : "4", "Child" : ["15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"],
		"CDFG" : "dstout_loop_proc",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "21", "EstimateLatencyMax" : "660",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "mapchip_draw_xsize", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "46", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "mapchip_draw_xsize_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "src_V1", "Type" : "Memory", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "5"},
			{"Name" : "dst_V2", "Type" : "Memory", "Direction" : "I", "DependentProc" : "12", "DependentChan" : "6"},
			{"Name" : "alpha", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "44", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "alpha_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "y", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "8", "DependentChan" : "47", "DependentChanDepth" : "2", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "y_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "frame_size", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "42", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "frame_size_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dstout", "Type" : "Fifo", "Direction" : "I", "DependentProc" : "7", "DependentChan" : "45", "DependentChanDepth" : "3", "DependentChanType" : "2",
				"BlockSignal" : [
					{"Name" : "dstout_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "dst", "Type" : "MAXI", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "dst_blk_n_AW", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_W", "Type" : "RtlSignal"},
					{"Name" : "dst_blk_n_B", "Type" : "RtlSignal"}]}]},
	{"ID" : "15", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_32ns_32ns_62_2_1_U52", "Parent" : "14"},
	{"ID" : "16", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_8ns_8ns_16_1_1_U53", "Parent" : "14"},
	{"ID" : "17", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_8ns_8ns_16_1_1_U54", "Parent" : "14"},
	{"ID" : "18", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_8ns_8ns_16_1_1_U55", "Parent" : "14"},
	{"ID" : "19", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_9ns_8ns_16_1_1_U56", "Parent" : "14"},
	{"ID" : "20", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_9ns_8ns_16_1_1_U57", "Parent" : "14"},
	{"ID" : "21", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_9ns_8ns_16_1_1_U58", "Parent" : "14"},
	{"ID" : "22", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_mul_16ns_18ns_33_4_1_U59", "Parent" : "14"},
	{"ID" : "23", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_mul_16ns_18ns_33_4_1_U60", "Parent" : "14"},
	{"ID" : "24", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_mul_16ns_18ns_33_4_1_U61", "Parent" : "14"},
	{"ID" : "25", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mac_muladd_8ns_8ns_16ns_17_4_1_U62", "Parent" : "14"},
	{"ID" : "26", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mac_muladd_8ns_8ns_16ns_17_4_1_U63", "Parent" : "14"},
	{"ID" : "27", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mac_muladd_8ns_8ns_16ns_17_4_1_U64", "Parent" : "14"},
	{"ID" : "28", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U65", "Parent" : "14"},
	{"ID" : "29", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U66", "Parent" : "14"},
	{"ID" : "30", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_loop_proc_U0.mul_mul_17ns_19ns_35_4_1_U67", "Parent" : "14"},
	{"ID" : "31", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.mapchip_draw_xsize_c_U", "Parent" : "4"},
	{"ID" : "32", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.mapchip_draw_xsize_c1_U", "Parent" : "4"},
	{"ID" : "33", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.id_c_U", "Parent" : "4"},
	{"ID" : "34", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.mapchip_maxheight_c_U", "Parent" : "4"},
	{"ID" : "35", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.ystart_pos_c_U", "Parent" : "4"},
	{"ID" : "36", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.mapchip_maxwidth_c_U", "Parent" : "4"},
	{"ID" : "37", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.xstart_pos_c_U", "Parent" : "4"},
	{"ID" : "38", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.y_c_U", "Parent" : "4"},
	{"ID" : "39", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.y_c2_U", "Parent" : "4"},
	{"ID" : "40", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.srcin_c_U", "Parent" : "4"},
	{"ID" : "41", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.frame_size_c_U", "Parent" : "4"},
	{"ID" : "42", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.frame_size_c3_U", "Parent" : "4"},
	{"ID" : "43", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstin_c_U", "Parent" : "4"},
	{"ID" : "44", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.alpha_c_U", "Parent" : "4"},
	{"ID" : "45", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.dstout_c_U", "Parent" : "4"},
	{"ID" : "46", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.mapchip_draw_xsize_c4_U", "Parent" : "4"},
	{"ID" : "47", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.dataflow_in_loop_height_loop_U0.y_c5_U", "Parent" : "4"}]}


set ArgLastReadFirstWriteLatency {
	mapchip_png {
		src {Type I LastRead 16 FirstWrite -1}
		dst {Type IO LastRead 12 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}
		mapchip_maxwidth {Type I LastRead 0 FirstWrite -1}
		mapchip_maxheight {Type I LastRead 0 FirstWrite -1}
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		mapchip_draw_ysize {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		id {Type I LastRead 0 FirstWrite -1}}
	dataflow_in_loop_height_loop {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		id {Type I LastRead 0 FirstWrite -1}
		mapchip_maxheight {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		mapchip_maxwidth {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		src {Type I LastRead 16 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		dst {Type IO LastRead 12 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}}
	dataflow_in_loop_height_loop_entry6 {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		id {Type I LastRead 0 FirstWrite -1}
		mapchip_maxheight {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		mapchip_maxwidth {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}
		mapchip_draw_xsize_out {Type O LastRead -1 FirstWrite 0}
		mapchip_draw_xsize_out1 {Type O LastRead -1 FirstWrite 0}
		id_out {Type O LastRead -1 FirstWrite 0}
		mapchip_maxheight_out {Type O LastRead -1 FirstWrite 0}
		ystart_pos_out {Type O LastRead -1 FirstWrite 0}
		mapchip_maxwidth_out {Type O LastRead -1 FirstWrite 0}
		xstart_pos_out {Type O LastRead -1 FirstWrite 0}
		y_out {Type O LastRead -1 FirstWrite 0}
		y_out2 {Type O LastRead -1 FirstWrite 0}
		srcin_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out {Type O LastRead -1 FirstWrite 0}
		frame_size_out3 {Type O LastRead -1 FirstWrite 0}
		dstin_out {Type O LastRead -1 FirstWrite 0}
		alpha_out {Type O LastRead -1 FirstWrite 0}
		dstout_out {Type O LastRead -1 FirstWrite 0}}
	src_loop_proc {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		id {Type I LastRead 0 FirstWrite -1}
		mapchip_maxheight {Type I LastRead 0 FirstWrite -1}
		ystart_pos {Type I LastRead 0 FirstWrite -1}
		mapchip_maxwidth {Type I LastRead 0 FirstWrite -1}
		xstart_pos {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		srcin {Type I LastRead 0 FirstWrite -1}
		src {Type I LastRead 16 FirstWrite -1}
		src_V1 {Type O LastRead -1 FirstWrite 17}
		mapchip_draw_xsize_out {Type O LastRead -1 FirstWrite 0}
		y_out {Type O LastRead -1 FirstWrite 0}}
	dstin_loop_proc {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstin {Type I LastRead 0 FirstWrite -1}
		dst {Type I LastRead 12 FirstWrite -1}
		dst_V2 {Type O LastRead -1 FirstWrite 13}}
	dstout_loop_proc {
		mapchip_draw_xsize {Type I LastRead 0 FirstWrite -1}
		src_V1 {Type I LastRead 5 FirstWrite -1}
		dst_V2 {Type I LastRead 8 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		y {Type I LastRead 0 FirstWrite -1}
		frame_size {Type I LastRead 0 FirstWrite -1}
		dstout {Type I LastRead 0 FirstWrite -1}
		dst {Type O LastRead 6 FirstWrite 16}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "43", "Max" : "317940"}
	, {"Name" : "Interval", "Min" : "44", "Max" : "317941"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	src { m_axi {  { m_axi_src_AWVALID VALID 1 1 }  { m_axi_src_AWREADY READY 0 1 }  { m_axi_src_AWADDR ADDR 1 64 }  { m_axi_src_AWID ID 1 1 }  { m_axi_src_AWLEN LEN 1 8 }  { m_axi_src_AWSIZE SIZE 1 3 }  { m_axi_src_AWBURST BURST 1 2 }  { m_axi_src_AWLOCK LOCK 1 2 }  { m_axi_src_AWCACHE CACHE 1 4 }  { m_axi_src_AWPROT PROT 1 3 }  { m_axi_src_AWQOS QOS 1 4 }  { m_axi_src_AWREGION REGION 1 4 }  { m_axi_src_AWUSER USER 1 1 }  { m_axi_src_WVALID VALID 1 1 }  { m_axi_src_WREADY READY 0 1 }  { m_axi_src_WDATA DATA 1 32 }  { m_axi_src_WSTRB STRB 1 4 }  { m_axi_src_WLAST LAST 1 1 }  { m_axi_src_WID ID 1 1 }  { m_axi_src_WUSER USER 1 1 }  { m_axi_src_ARVALID VALID 1 1 }  { m_axi_src_ARREADY READY 0 1 }  { m_axi_src_ARADDR ADDR 1 64 }  { m_axi_src_ARID ID 1 1 }  { m_axi_src_ARLEN LEN 1 8 }  { m_axi_src_ARSIZE SIZE 1 3 }  { m_axi_src_ARBURST BURST 1 2 }  { m_axi_src_ARLOCK LOCK 1 2 }  { m_axi_src_ARCACHE CACHE 1 4 }  { m_axi_src_ARPROT PROT 1 3 }  { m_axi_src_ARQOS QOS 1 4 }  { m_axi_src_ARREGION REGION 1 4 }  { m_axi_src_ARUSER USER 1 1 }  { m_axi_src_RVALID VALID 0 1 }  { m_axi_src_RREADY READY 1 1 }  { m_axi_src_RDATA DATA 0 32 }  { m_axi_src_RLAST LAST 0 1 }  { m_axi_src_RID ID 0 1 }  { m_axi_src_RUSER USER 0 1 }  { m_axi_src_RRESP RESP 0 2 }  { m_axi_src_BVALID VALID 0 1 }  { m_axi_src_BREADY READY 1 1 }  { m_axi_src_BRESP RESP 0 2 }  { m_axi_src_BID ID 0 1 }  { m_axi_src_BUSER USER 0 1 } } }
	dst { m_axi {  { m_axi_dst_AWVALID VALID 1 1 }  { m_axi_dst_AWREADY READY 0 1 }  { m_axi_dst_AWADDR ADDR 1 64 }  { m_axi_dst_AWID ID 1 1 }  { m_axi_dst_AWLEN LEN 1 8 }  { m_axi_dst_AWSIZE SIZE 1 3 }  { m_axi_dst_AWBURST BURST 1 2 }  { m_axi_dst_AWLOCK LOCK 1 2 }  { m_axi_dst_AWCACHE CACHE 1 4 }  { m_axi_dst_AWPROT PROT 1 3 }  { m_axi_dst_AWQOS QOS 1 4 }  { m_axi_dst_AWREGION REGION 1 4 }  { m_axi_dst_AWUSER USER 1 1 }  { m_axi_dst_WVALID VALID 1 1 }  { m_axi_dst_WREADY READY 0 1 }  { m_axi_dst_WDATA DATA 1 32 }  { m_axi_dst_WSTRB STRB 1 4 }  { m_axi_dst_WLAST LAST 1 1 }  { m_axi_dst_WID ID 1 1 }  { m_axi_dst_WUSER USER 1 1 }  { m_axi_dst_ARVALID VALID 1 1 }  { m_axi_dst_ARREADY READY 0 1 }  { m_axi_dst_ARADDR ADDR 1 64 }  { m_axi_dst_ARID ID 1 1 }  { m_axi_dst_ARLEN LEN 1 8 }  { m_axi_dst_ARSIZE SIZE 1 3 }  { m_axi_dst_ARBURST BURST 1 2 }  { m_axi_dst_ARLOCK LOCK 1 2 }  { m_axi_dst_ARCACHE CACHE 1 4 }  { m_axi_dst_ARPROT PROT 1 3 }  { m_axi_dst_ARQOS QOS 1 4 }  { m_axi_dst_ARREGION REGION 1 4 }  { m_axi_dst_ARUSER USER 1 1 }  { m_axi_dst_RVALID VALID 0 1 }  { m_axi_dst_RREADY READY 1 1 }  { m_axi_dst_RDATA DATA 0 32 }  { m_axi_dst_RLAST LAST 0 1 }  { m_axi_dst_RID ID 0 1 }  { m_axi_dst_RUSER USER 0 1 }  { m_axi_dst_RRESP RESP 0 2 }  { m_axi_dst_BVALID VALID 0 1 }  { m_axi_dst_BREADY READY 1 1 }  { m_axi_dst_BRESP RESP 0 2 }  { m_axi_dst_BID ID 0 1 }  { m_axi_dst_BUSER USER 0 1 } } }
}

set busDeadlockParameterList { 
	{ src { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 32 MAX_WRITE_BURST_LENGTH 16 } } \
	{ dst { NUM_READ_OUTSTANDING 16 NUM_WRITE_OUTSTANDING 16 MAX_READ_BURST_LENGTH 32 MAX_WRITE_BURST_LENGTH 32 } } \
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
	{ src 1 }
	{ dst 1 }
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
	{ src 1 }
	{ dst 1 }
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
