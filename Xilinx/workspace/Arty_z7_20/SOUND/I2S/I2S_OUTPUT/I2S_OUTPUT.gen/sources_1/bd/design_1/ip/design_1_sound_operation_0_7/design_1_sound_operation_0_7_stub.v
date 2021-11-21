// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue May 11 08:55:58 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.gen/sources_1/bd/design_1/ip/design_1_sound_operation_0_7/design_1_sound_operation_0_7_stub.v
// Design      : design_1_sound_operation_0_7
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "sound_operation,Vivado 2020.2" *)
module design_1_sound_operation_0_7(s_axi_control_AWADDR, 
  s_axi_control_AWVALID, s_axi_control_AWREADY, s_axi_control_WDATA, s_axi_control_WSTRB, 
  s_axi_control_WVALID, s_axi_control_WREADY, s_axi_control_BRESP, s_axi_control_BVALID, 
  s_axi_control_BREADY, s_axi_control_ARADDR, s_axi_control_ARVALID, 
  s_axi_control_ARREADY, s_axi_control_RDATA, s_axi_control_RRESP, s_axi_control_RVALID, 
  s_axi_control_RREADY, ap_clk, ap_rst_n, m_axi_ram_AWADDR, m_axi_ram_AWLEN, 
  m_axi_ram_AWSIZE, m_axi_ram_AWBURST, m_axi_ram_AWLOCK, m_axi_ram_AWREGION, 
  m_axi_ram_AWCACHE, m_axi_ram_AWPROT, m_axi_ram_AWQOS, m_axi_ram_AWVALID, 
  m_axi_ram_AWREADY, m_axi_ram_WDATA, m_axi_ram_WSTRB, m_axi_ram_WLAST, m_axi_ram_WVALID, 
  m_axi_ram_WREADY, m_axi_ram_BRESP, m_axi_ram_BVALID, m_axi_ram_BREADY, m_axi_ram_ARADDR, 
  m_axi_ram_ARLEN, m_axi_ram_ARSIZE, m_axi_ram_ARBURST, m_axi_ram_ARLOCK, 
  m_axi_ram_ARREGION, m_axi_ram_ARCACHE, m_axi_ram_ARPROT, m_axi_ram_ARQOS, 
  m_axi_ram_ARVALID, m_axi_ram_ARREADY, m_axi_ram_RDATA, m_axi_ram_RRESP, m_axi_ram_RLAST, 
  m_axi_ram_RVALID, m_axi_ram_RREADY, sdata, opeout, count)
/* synthesis syn_black_box black_box_pad_pin="s_axi_control_AWADDR[5:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[5:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,m_axi_ram_AWADDR[63:0],m_axi_ram_AWLEN[7:0],m_axi_ram_AWSIZE[2:0],m_axi_ram_AWBURST[1:0],m_axi_ram_AWLOCK[1:0],m_axi_ram_AWREGION[3:0],m_axi_ram_AWCACHE[3:0],m_axi_ram_AWPROT[2:0],m_axi_ram_AWQOS[3:0],m_axi_ram_AWVALID,m_axi_ram_AWREADY,m_axi_ram_WDATA[31:0],m_axi_ram_WSTRB[3:0],m_axi_ram_WLAST,m_axi_ram_WVALID,m_axi_ram_WREADY,m_axi_ram_BRESP[1:0],m_axi_ram_BVALID,m_axi_ram_BREADY,m_axi_ram_ARADDR[63:0],m_axi_ram_ARLEN[7:0],m_axi_ram_ARSIZE[2:0],m_axi_ram_ARBURST[1:0],m_axi_ram_ARLOCK[1:0],m_axi_ram_ARREGION[3:0],m_axi_ram_ARCACHE[3:0],m_axi_ram_ARPROT[2:0],m_axi_ram_ARQOS[3:0],m_axi_ram_ARVALID,m_axi_ram_ARREADY,m_axi_ram_RDATA[31:0],m_axi_ram_RRESP[1:0],m_axi_ram_RLAST,m_axi_ram_RVALID,m_axi_ram_RREADY,sdata[31:0],opeout[31:0],count[31:0]" */;
  input [5:0]s_axi_control_AWADDR;
  input s_axi_control_AWVALID;
  output s_axi_control_AWREADY;
  input [31:0]s_axi_control_WDATA;
  input [3:0]s_axi_control_WSTRB;
  input s_axi_control_WVALID;
  output s_axi_control_WREADY;
  output [1:0]s_axi_control_BRESP;
  output s_axi_control_BVALID;
  input s_axi_control_BREADY;
  input [5:0]s_axi_control_ARADDR;
  input s_axi_control_ARVALID;
  output s_axi_control_ARREADY;
  output [31:0]s_axi_control_RDATA;
  output [1:0]s_axi_control_RRESP;
  output s_axi_control_RVALID;
  input s_axi_control_RREADY;
  input ap_clk;
  input ap_rst_n;
  output [63:0]m_axi_ram_AWADDR;
  output [7:0]m_axi_ram_AWLEN;
  output [2:0]m_axi_ram_AWSIZE;
  output [1:0]m_axi_ram_AWBURST;
  output [1:0]m_axi_ram_AWLOCK;
  output [3:0]m_axi_ram_AWREGION;
  output [3:0]m_axi_ram_AWCACHE;
  output [2:0]m_axi_ram_AWPROT;
  output [3:0]m_axi_ram_AWQOS;
  output m_axi_ram_AWVALID;
  input m_axi_ram_AWREADY;
  output [31:0]m_axi_ram_WDATA;
  output [3:0]m_axi_ram_WSTRB;
  output m_axi_ram_WLAST;
  output m_axi_ram_WVALID;
  input m_axi_ram_WREADY;
  input [1:0]m_axi_ram_BRESP;
  input m_axi_ram_BVALID;
  output m_axi_ram_BREADY;
  output [63:0]m_axi_ram_ARADDR;
  output [7:0]m_axi_ram_ARLEN;
  output [2:0]m_axi_ram_ARSIZE;
  output [1:0]m_axi_ram_ARBURST;
  output [1:0]m_axi_ram_ARLOCK;
  output [3:0]m_axi_ram_ARREGION;
  output [3:0]m_axi_ram_ARCACHE;
  output [2:0]m_axi_ram_ARPROT;
  output [3:0]m_axi_ram_ARQOS;
  output m_axi_ram_ARVALID;
  input m_axi_ram_ARREADY;
  input [31:0]m_axi_ram_RDATA;
  input [1:0]m_axi_ram_RRESP;
  input m_axi_ram_RLAST;
  input m_axi_ram_RVALID;
  output m_axi_ram_RREADY;
  output [31:0]sdata;
  output [31:0]opeout;
  input [31:0]count;
endmodule
