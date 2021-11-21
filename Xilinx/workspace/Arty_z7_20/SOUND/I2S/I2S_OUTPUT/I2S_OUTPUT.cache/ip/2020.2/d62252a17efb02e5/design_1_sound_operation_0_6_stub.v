// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Mon May 10 19:52:53 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_sound_operation_0_6_stub.v
// Design      : design_1_sound_operation_0_6
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "sound_operation,Vivado 2020.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_control_AWADDR, 
  s_axi_control_AWVALID, s_axi_control_AWREADY, s_axi_control_WDATA, s_axi_control_WSTRB, 
  s_axi_control_WVALID, s_axi_control_WREADY, s_axi_control_BRESP, s_axi_control_BVALID, 
  s_axi_control_BREADY, s_axi_control_ARADDR, s_axi_control_ARVALID, 
  s_axi_control_ARREADY, s_axi_control_RDATA, s_axi_control_RRESP, s_axi_control_RVALID, 
  s_axi_control_RREADY, ap_clk, ap_rst_n, ap_start, ap_done, ap_idle, ap_ready, 
  m_axi_sound_AWADDR, m_axi_sound_AWLEN, m_axi_sound_AWSIZE, m_axi_sound_AWBURST, 
  m_axi_sound_AWLOCK, m_axi_sound_AWREGION, m_axi_sound_AWCACHE, m_axi_sound_AWPROT, 
  m_axi_sound_AWQOS, m_axi_sound_AWVALID, m_axi_sound_AWREADY, m_axi_sound_WDATA, 
  m_axi_sound_WSTRB, m_axi_sound_WLAST, m_axi_sound_WVALID, m_axi_sound_WREADY, 
  m_axi_sound_BRESP, m_axi_sound_BVALID, m_axi_sound_BREADY, m_axi_sound_ARADDR, 
  m_axi_sound_ARLEN, m_axi_sound_ARSIZE, m_axi_sound_ARBURST, m_axi_sound_ARLOCK, 
  m_axi_sound_ARREGION, m_axi_sound_ARCACHE, m_axi_sound_ARPROT, m_axi_sound_ARQOS, 
  m_axi_sound_ARVALID, m_axi_sound_ARREADY, m_axi_sound_RDATA, m_axi_sound_RRESP, 
  m_axi_sound_RLAST, m_axi_sound_RVALID, m_axi_sound_RREADY, outdata, status, response)
/* synthesis syn_black_box black_box_pad_pin="s_axi_control_AWADDR[5:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[5:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,ap_start,ap_done,ap_idle,ap_ready,m_axi_sound_AWADDR[63:0],m_axi_sound_AWLEN[7:0],m_axi_sound_AWSIZE[2:0],m_axi_sound_AWBURST[1:0],m_axi_sound_AWLOCK[1:0],m_axi_sound_AWREGION[3:0],m_axi_sound_AWCACHE[3:0],m_axi_sound_AWPROT[2:0],m_axi_sound_AWQOS[3:0],m_axi_sound_AWVALID,m_axi_sound_AWREADY,m_axi_sound_WDATA[31:0],m_axi_sound_WSTRB[3:0],m_axi_sound_WLAST,m_axi_sound_WVALID,m_axi_sound_WREADY,m_axi_sound_BRESP[1:0],m_axi_sound_BVALID,m_axi_sound_BREADY,m_axi_sound_ARADDR[63:0],m_axi_sound_ARLEN[7:0],m_axi_sound_ARSIZE[2:0],m_axi_sound_ARBURST[1:0],m_axi_sound_ARLOCK[1:0],m_axi_sound_ARREGION[3:0],m_axi_sound_ARCACHE[3:0],m_axi_sound_ARPROT[2:0],m_axi_sound_ARQOS[3:0],m_axi_sound_ARVALID,m_axi_sound_ARREADY,m_axi_sound_RDATA[31:0],m_axi_sound_RRESP[1:0],m_axi_sound_RLAST,m_axi_sound_RVALID,m_axi_sound_RREADY,outdata[31:0],status[31:0],response[31:0]" */;
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
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [63:0]m_axi_sound_AWADDR;
  output [7:0]m_axi_sound_AWLEN;
  output [2:0]m_axi_sound_AWSIZE;
  output [1:0]m_axi_sound_AWBURST;
  output [1:0]m_axi_sound_AWLOCK;
  output [3:0]m_axi_sound_AWREGION;
  output [3:0]m_axi_sound_AWCACHE;
  output [2:0]m_axi_sound_AWPROT;
  output [3:0]m_axi_sound_AWQOS;
  output m_axi_sound_AWVALID;
  input m_axi_sound_AWREADY;
  output [31:0]m_axi_sound_WDATA;
  output [3:0]m_axi_sound_WSTRB;
  output m_axi_sound_WLAST;
  output m_axi_sound_WVALID;
  input m_axi_sound_WREADY;
  input [1:0]m_axi_sound_BRESP;
  input m_axi_sound_BVALID;
  output m_axi_sound_BREADY;
  output [63:0]m_axi_sound_ARADDR;
  output [7:0]m_axi_sound_ARLEN;
  output [2:0]m_axi_sound_ARSIZE;
  output [1:0]m_axi_sound_ARBURST;
  output [1:0]m_axi_sound_ARLOCK;
  output [3:0]m_axi_sound_ARREGION;
  output [3:0]m_axi_sound_ARCACHE;
  output [2:0]m_axi_sound_ARPROT;
  output [3:0]m_axi_sound_ARQOS;
  output m_axi_sound_ARVALID;
  input m_axi_sound_ARREADY;
  input [31:0]m_axi_sound_RDATA;
  input [1:0]m_axi_sound_RRESP;
  input m_axi_sound_RLAST;
  input m_axi_sound_RVALID;
  output m_axi_sound_RREADY;
  input [31:0]outdata;
  input [31:0]status;
  input [31:0]response;
endmodule
