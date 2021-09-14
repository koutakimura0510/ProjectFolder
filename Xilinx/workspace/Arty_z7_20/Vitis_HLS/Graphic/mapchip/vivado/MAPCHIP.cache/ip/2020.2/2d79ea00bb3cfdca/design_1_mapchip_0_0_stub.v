// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sat May  8 15:18:15 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_mapchip_0_0_stub.v
// Design      : design_1_mapchip_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "mapchip,Vivado 2020.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_control_AWADDR, 
  s_axi_control_AWVALID, s_axi_control_AWREADY, s_axi_control_WDATA, s_axi_control_WSTRB, 
  s_axi_control_WVALID, s_axi_control_WREADY, s_axi_control_BRESP, s_axi_control_BVALID, 
  s_axi_control_BREADY, s_axi_control_ARADDR, s_axi_control_ARVALID, 
  s_axi_control_ARREADY, s_axi_control_RDATA, s_axi_control_RRESP, s_axi_control_RVALID, 
  s_axi_control_RREADY, ap_clk, ap_rst_n, interrupt, m_axi_src_AWADDR, m_axi_src_AWLEN, 
  m_axi_src_AWSIZE, m_axi_src_AWBURST, m_axi_src_AWLOCK, m_axi_src_AWREGION, 
  m_axi_src_AWCACHE, m_axi_src_AWPROT, m_axi_src_AWQOS, m_axi_src_AWVALID, 
  m_axi_src_AWREADY, m_axi_src_WDATA, m_axi_src_WSTRB, m_axi_src_WLAST, m_axi_src_WVALID, 
  m_axi_src_WREADY, m_axi_src_BRESP, m_axi_src_BVALID, m_axi_src_BREADY, m_axi_src_ARADDR, 
  m_axi_src_ARLEN, m_axi_src_ARSIZE, m_axi_src_ARBURST, m_axi_src_ARLOCK, 
  m_axi_src_ARREGION, m_axi_src_ARCACHE, m_axi_src_ARPROT, m_axi_src_ARQOS, 
  m_axi_src_ARVALID, m_axi_src_ARREADY, m_axi_src_RDATA, m_axi_src_RRESP, m_axi_src_RLAST, 
  m_axi_src_RVALID, m_axi_src_RREADY, m_axi_dst_AWADDR, m_axi_dst_AWLEN, m_axi_dst_AWSIZE, 
  m_axi_dst_AWBURST, m_axi_dst_AWLOCK, m_axi_dst_AWREGION, m_axi_dst_AWCACHE, 
  m_axi_dst_AWPROT, m_axi_dst_AWQOS, m_axi_dst_AWVALID, m_axi_dst_AWREADY, m_axi_dst_WDATA, 
  m_axi_dst_WSTRB, m_axi_dst_WLAST, m_axi_dst_WVALID, m_axi_dst_WREADY, m_axi_dst_BRESP, 
  m_axi_dst_BVALID, m_axi_dst_BREADY, m_axi_dst_ARADDR, m_axi_dst_ARLEN, m_axi_dst_ARSIZE, 
  m_axi_dst_ARBURST, m_axi_dst_ARLOCK, m_axi_dst_ARREGION, m_axi_dst_ARCACHE, 
  m_axi_dst_ARPROT, m_axi_dst_ARQOS, m_axi_dst_ARVALID, m_axi_dst_ARREADY, m_axi_dst_RDATA, 
  m_axi_dst_RRESP, m_axi_dst_RLAST, m_axi_dst_RVALID, m_axi_dst_RREADY)
/* synthesis syn_black_box black_box_pad_pin="s_axi_control_AWADDR[5:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[5:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,interrupt,m_axi_src_AWADDR[63:0],m_axi_src_AWLEN[7:0],m_axi_src_AWSIZE[2:0],m_axi_src_AWBURST[1:0],m_axi_src_AWLOCK[1:0],m_axi_src_AWREGION[3:0],m_axi_src_AWCACHE[3:0],m_axi_src_AWPROT[2:0],m_axi_src_AWQOS[3:0],m_axi_src_AWVALID,m_axi_src_AWREADY,m_axi_src_WDATA[31:0],m_axi_src_WSTRB[3:0],m_axi_src_WLAST,m_axi_src_WVALID,m_axi_src_WREADY,m_axi_src_BRESP[1:0],m_axi_src_BVALID,m_axi_src_BREADY,m_axi_src_ARADDR[63:0],m_axi_src_ARLEN[7:0],m_axi_src_ARSIZE[2:0],m_axi_src_ARBURST[1:0],m_axi_src_ARLOCK[1:0],m_axi_src_ARREGION[3:0],m_axi_src_ARCACHE[3:0],m_axi_src_ARPROT[2:0],m_axi_src_ARQOS[3:0],m_axi_src_ARVALID,m_axi_src_ARREADY,m_axi_src_RDATA[31:0],m_axi_src_RRESP[1:0],m_axi_src_RLAST,m_axi_src_RVALID,m_axi_src_RREADY,m_axi_dst_AWADDR[63:0],m_axi_dst_AWLEN[7:0],m_axi_dst_AWSIZE[2:0],m_axi_dst_AWBURST[1:0],m_axi_dst_AWLOCK[1:0],m_axi_dst_AWREGION[3:0],m_axi_dst_AWCACHE[3:0],m_axi_dst_AWPROT[2:0],m_axi_dst_AWQOS[3:0],m_axi_dst_AWVALID,m_axi_dst_AWREADY,m_axi_dst_WDATA[31:0],m_axi_dst_WSTRB[3:0],m_axi_dst_WLAST,m_axi_dst_WVALID,m_axi_dst_WREADY,m_axi_dst_BRESP[1:0],m_axi_dst_BVALID,m_axi_dst_BREADY,m_axi_dst_ARADDR[63:0],m_axi_dst_ARLEN[7:0],m_axi_dst_ARSIZE[2:0],m_axi_dst_ARBURST[1:0],m_axi_dst_ARLOCK[1:0],m_axi_dst_ARREGION[3:0],m_axi_dst_ARCACHE[3:0],m_axi_dst_ARPROT[2:0],m_axi_dst_ARQOS[3:0],m_axi_dst_ARVALID,m_axi_dst_ARREADY,m_axi_dst_RDATA[31:0],m_axi_dst_RRESP[1:0],m_axi_dst_RLAST,m_axi_dst_RVALID,m_axi_dst_RREADY" */;
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
  output interrupt;
  output [63:0]m_axi_src_AWADDR;
  output [7:0]m_axi_src_AWLEN;
  output [2:0]m_axi_src_AWSIZE;
  output [1:0]m_axi_src_AWBURST;
  output [1:0]m_axi_src_AWLOCK;
  output [3:0]m_axi_src_AWREGION;
  output [3:0]m_axi_src_AWCACHE;
  output [2:0]m_axi_src_AWPROT;
  output [3:0]m_axi_src_AWQOS;
  output m_axi_src_AWVALID;
  input m_axi_src_AWREADY;
  output [31:0]m_axi_src_WDATA;
  output [3:0]m_axi_src_WSTRB;
  output m_axi_src_WLAST;
  output m_axi_src_WVALID;
  input m_axi_src_WREADY;
  input [1:0]m_axi_src_BRESP;
  input m_axi_src_BVALID;
  output m_axi_src_BREADY;
  output [63:0]m_axi_src_ARADDR;
  output [7:0]m_axi_src_ARLEN;
  output [2:0]m_axi_src_ARSIZE;
  output [1:0]m_axi_src_ARBURST;
  output [1:0]m_axi_src_ARLOCK;
  output [3:0]m_axi_src_ARREGION;
  output [3:0]m_axi_src_ARCACHE;
  output [2:0]m_axi_src_ARPROT;
  output [3:0]m_axi_src_ARQOS;
  output m_axi_src_ARVALID;
  input m_axi_src_ARREADY;
  input [31:0]m_axi_src_RDATA;
  input [1:0]m_axi_src_RRESP;
  input m_axi_src_RLAST;
  input m_axi_src_RVALID;
  output m_axi_src_RREADY;
  output [63:0]m_axi_dst_AWADDR;
  output [7:0]m_axi_dst_AWLEN;
  output [2:0]m_axi_dst_AWSIZE;
  output [1:0]m_axi_dst_AWBURST;
  output [1:0]m_axi_dst_AWLOCK;
  output [3:0]m_axi_dst_AWREGION;
  output [3:0]m_axi_dst_AWCACHE;
  output [2:0]m_axi_dst_AWPROT;
  output [3:0]m_axi_dst_AWQOS;
  output m_axi_dst_AWVALID;
  input m_axi_dst_AWREADY;
  output [31:0]m_axi_dst_WDATA;
  output [3:0]m_axi_dst_WSTRB;
  output m_axi_dst_WLAST;
  output m_axi_dst_WVALID;
  input m_axi_dst_WREADY;
  input [1:0]m_axi_dst_BRESP;
  input m_axi_dst_BVALID;
  output m_axi_dst_BREADY;
  output [63:0]m_axi_dst_ARADDR;
  output [7:0]m_axi_dst_ARLEN;
  output [2:0]m_axi_dst_ARSIZE;
  output [1:0]m_axi_dst_ARBURST;
  output [1:0]m_axi_dst_ARLOCK;
  output [3:0]m_axi_dst_ARREGION;
  output [3:0]m_axi_dst_ARCACHE;
  output [2:0]m_axi_dst_ARPROT;
  output [3:0]m_axi_dst_ARQOS;
  output m_axi_dst_ARVALID;
  input m_axi_dst_ARREADY;
  input [31:0]m_axi_dst_RDATA;
  input [1:0]m_axi_dst_RRESP;
  input m_axi_dst_RLAST;
  input m_axi_dst_RVALID;
  output m_axi_dst_RREADY;
endmodule
