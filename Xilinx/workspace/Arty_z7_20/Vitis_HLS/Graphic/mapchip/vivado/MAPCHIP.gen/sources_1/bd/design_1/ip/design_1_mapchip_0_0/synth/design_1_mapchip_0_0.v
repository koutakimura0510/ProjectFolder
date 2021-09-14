// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:mapchip:1.0
// IP Revision: 2105081502

(* X_CORE_INFO = "mapchip,Vivado 2020.2" *)
(* CHECK_LICENSE_TYPE = "design_1_mapchip_0_0,mapchip,{}" *)
(* CORE_GENERATION_INFO = "design_1_mapchip_0_0,mapchip,{x_ipProduct=Vivado 2020.2,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=mapchip,x_ipVersion=1.0,x_ipCoreRevision=2105081502,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_S_AXI_CONTROL_ADDR_WIDTH=6,C_S_AXI_CONTROL_DATA_WIDTH=32,C_M_AXI_SRC_ID_WIDTH=1,C_M_AXI_SRC_ADDR_WIDTH=64,C_M_AXI_SRC_DATA_WIDTH=32,C_M_AXI_SRC_AWUSER_WIDTH=1,C_M_AXI_SRC_ARUSER_WIDTH=1,C_M_AXI_SRC_WUSER_WIDTH=1,C_M_AXI_SRC_RUSER_WIDTH=1,C_M_AXI_SRC_BUSER_WIDTH=1,C_M_AXI_SRC_USER_VALUE=0x00000000,C_\
M_AXI_SRC_PROT_VALUE=000,C_M_AXI_SRC_CACHE_VALUE=0011,C_M_AXI_DST_ID_WIDTH=1,C_M_AXI_DST_ADDR_WIDTH=64,C_M_AXI_DST_DATA_WIDTH=32,C_M_AXI_DST_AWUSER_WIDTH=1,C_M_AXI_DST_ARUSER_WIDTH=1,C_M_AXI_DST_WUSER_WIDTH=1,C_M_AXI_DST_RUSER_WIDTH=1,C_M_AXI_DST_BUSER_WIDTH=1,C_M_AXI_DST_USER_VALUE=0x00000000,C_M_AXI_DST_PROT_VALUE=000,C_M_AXI_DST_CACHE_VALUE=0011}" *)
(* IP_DEFINITION_SOURCE = "HLS" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_mapchip_0_0 (
  s_axi_control_AWADDR,
  s_axi_control_AWVALID,
  s_axi_control_AWREADY,
  s_axi_control_WDATA,
  s_axi_control_WSTRB,
  s_axi_control_WVALID,
  s_axi_control_WREADY,
  s_axi_control_BRESP,
  s_axi_control_BVALID,
  s_axi_control_BREADY,
  s_axi_control_ARADDR,
  s_axi_control_ARVALID,
  s_axi_control_ARREADY,
  s_axi_control_RDATA,
  s_axi_control_RRESP,
  s_axi_control_RVALID,
  s_axi_control_RREADY,
  ap_clk,
  ap_rst_n,
  interrupt,
  m_axi_src_AWADDR,
  m_axi_src_AWLEN,
  m_axi_src_AWSIZE,
  m_axi_src_AWBURST,
  m_axi_src_AWLOCK,
  m_axi_src_AWREGION,
  m_axi_src_AWCACHE,
  m_axi_src_AWPROT,
  m_axi_src_AWQOS,
  m_axi_src_AWVALID,
  m_axi_src_AWREADY,
  m_axi_src_WDATA,
  m_axi_src_WSTRB,
  m_axi_src_WLAST,
  m_axi_src_WVALID,
  m_axi_src_WREADY,
  m_axi_src_BRESP,
  m_axi_src_BVALID,
  m_axi_src_BREADY,
  m_axi_src_ARADDR,
  m_axi_src_ARLEN,
  m_axi_src_ARSIZE,
  m_axi_src_ARBURST,
  m_axi_src_ARLOCK,
  m_axi_src_ARREGION,
  m_axi_src_ARCACHE,
  m_axi_src_ARPROT,
  m_axi_src_ARQOS,
  m_axi_src_ARVALID,
  m_axi_src_ARREADY,
  m_axi_src_RDATA,
  m_axi_src_RRESP,
  m_axi_src_RLAST,
  m_axi_src_RVALID,
  m_axi_src_RREADY,
  m_axi_dst_AWADDR,
  m_axi_dst_AWLEN,
  m_axi_dst_AWSIZE,
  m_axi_dst_AWBURST,
  m_axi_dst_AWLOCK,
  m_axi_dst_AWREGION,
  m_axi_dst_AWCACHE,
  m_axi_dst_AWPROT,
  m_axi_dst_AWQOS,
  m_axi_dst_AWVALID,
  m_axi_dst_AWREADY,
  m_axi_dst_WDATA,
  m_axi_dst_WSTRB,
  m_axi_dst_WLAST,
  m_axi_dst_WVALID,
  m_axi_dst_WREADY,
  m_axi_dst_BRESP,
  m_axi_dst_BVALID,
  m_axi_dst_BREADY,
  m_axi_dst_ARADDR,
  m_axi_dst_ARLEN,
  m_axi_dst_ARSIZE,
  m_axi_dst_ARBURST,
  m_axi_dst_ARLOCK,
  m_axi_dst_ARREGION,
  m_axi_dst_ARCACHE,
  m_axi_dst_ARPROT,
  m_axi_dst_ARQOS,
  m_axi_dst_ARVALID,
  m_axi_dst_ARREADY,
  m_axi_dst_RDATA,
  m_axi_dst_RRESP,
  m_axi_dst_RLAST,
  m_axi_dst_RVALID,
  m_axi_dst_RREADY
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR" *)
input wire [5 : 0] s_axi_control_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID" *)
input wire s_axi_control_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY" *)
output wire s_axi_control_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WDATA" *)
input wire [31 : 0] s_axi_control_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB" *)
input wire [3 : 0] s_axi_control_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WVALID" *)
input wire s_axi_control_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WREADY" *)
output wire s_axi_control_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BRESP" *)
output wire [1 : 0] s_axi_control_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BVALID" *)
output wire s_axi_control_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BREADY" *)
input wire s_axi_control_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR" *)
input wire [5 : 0] s_axi_control_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID" *)
input wire s_axi_control_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY" *)
output wire s_axi_control_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RDATA" *)
output wire [31 : 0] s_axi_control_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RRESP" *)
output wire [1 : 0] s_axi_control_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RVALID" *)
output wire s_axi_control_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ\
_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RREADY" *)
input wire s_axi_control_RREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:m_axi_src:m_axi_dst, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *)
output wire interrupt;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWADDR" *)
output wire [63 : 0] m_axi_src_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWLEN" *)
output wire [7 : 0] m_axi_src_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWSIZE" *)
output wire [2 : 0] m_axi_src_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWBURST" *)
output wire [1 : 0] m_axi_src_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWLOCK" *)
output wire [1 : 0] m_axi_src_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWREGION" *)
output wire [3 : 0] m_axi_src_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWCACHE" *)
output wire [3 : 0] m_axi_src_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWPROT" *)
output wire [2 : 0] m_axi_src_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWQOS" *)
output wire [3 : 0] m_axi_src_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWVALID" *)
output wire m_axi_src_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src AWREADY" *)
input wire m_axi_src_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src WDATA" *)
output wire [31 : 0] m_axi_src_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src WSTRB" *)
output wire [3 : 0] m_axi_src_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src WLAST" *)
output wire m_axi_src_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src WVALID" *)
output wire m_axi_src_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src WREADY" *)
input wire m_axi_src_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src BRESP" *)
input wire [1 : 0] m_axi_src_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src BVALID" *)
input wire m_axi_src_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src BREADY" *)
output wire m_axi_src_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARADDR" *)
output wire [63 : 0] m_axi_src_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARLEN" *)
output wire [7 : 0] m_axi_src_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARSIZE" *)
output wire [2 : 0] m_axi_src_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARBURST" *)
output wire [1 : 0] m_axi_src_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARLOCK" *)
output wire [1 : 0] m_axi_src_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARREGION" *)
output wire [3 : 0] m_axi_src_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARCACHE" *)
output wire [3 : 0] m_axi_src_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARPROT" *)
output wire [2 : 0] m_axi_src_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARQOS" *)
output wire [3 : 0] m_axi_src_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARVALID" *)
output wire m_axi_src_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src ARREADY" *)
input wire m_axi_src_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src RDATA" *)
input wire [31 : 0] m_axi_src_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src RRESP" *)
input wire [1 : 0] m_axi_src_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src RLAST" *)
input wire m_axi_src_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src RVALID" *)
input wire m_axi_src_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_src, ADDR_WIDTH 64, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 32, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN d\
esign_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_src RREADY" *)
output wire m_axi_src_RREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWADDR" *)
output wire [63 : 0] m_axi_dst_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWLEN" *)
output wire [7 : 0] m_axi_dst_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWSIZE" *)
output wire [2 : 0] m_axi_dst_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWBURST" *)
output wire [1 : 0] m_axi_dst_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWLOCK" *)
output wire [1 : 0] m_axi_dst_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWREGION" *)
output wire [3 : 0] m_axi_dst_AWREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWCACHE" *)
output wire [3 : 0] m_axi_dst_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWPROT" *)
output wire [2 : 0] m_axi_dst_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWQOS" *)
output wire [3 : 0] m_axi_dst_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWVALID" *)
output wire m_axi_dst_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst AWREADY" *)
input wire m_axi_dst_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst WDATA" *)
output wire [31 : 0] m_axi_dst_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst WSTRB" *)
output wire [3 : 0] m_axi_dst_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst WLAST" *)
output wire m_axi_dst_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst WVALID" *)
output wire m_axi_dst_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst WREADY" *)
input wire m_axi_dst_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst BRESP" *)
input wire [1 : 0] m_axi_dst_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst BVALID" *)
input wire m_axi_dst_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst BREADY" *)
output wire m_axi_dst_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARADDR" *)
output wire [63 : 0] m_axi_dst_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARLEN" *)
output wire [7 : 0] m_axi_dst_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARSIZE" *)
output wire [2 : 0] m_axi_dst_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARBURST" *)
output wire [1 : 0] m_axi_dst_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARLOCK" *)
output wire [1 : 0] m_axi_dst_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARREGION" *)
output wire [3 : 0] m_axi_dst_ARREGION;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARCACHE" *)
output wire [3 : 0] m_axi_dst_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARPROT" *)
output wire [2 : 0] m_axi_dst_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARQOS" *)
output wire [3 : 0] m_axi_dst_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARVALID" *)
output wire m_axi_dst_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst ARREADY" *)
input wire m_axi_dst_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst RDATA" *)
input wire [31 : 0] m_axi_dst_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst RRESP" *)
input wire [1 : 0] m_axi_dst_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst RLAST" *)
input wire m_axi_dst_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst RVALID" *)
input wire m_axi_dst_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_dst, ADDR_WIDTH 64, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 16, MAX_WRITE_BURST_LENGTH 32, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN d\
esign_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_dst RREADY" *)
output wire m_axi_dst_RREADY;

(* SDX_KERNEL = "true" *)
(* SDX_KERNEL_TYPE = "hls" *)
(* SDX_KERNEL_SYNTH_INST = "inst" *)
  mapchip #(
    .C_S_AXI_CONTROL_ADDR_WIDTH(6),
    .C_S_AXI_CONTROL_DATA_WIDTH(32),
    .C_M_AXI_SRC_ID_WIDTH(1),
    .C_M_AXI_SRC_ADDR_WIDTH(64),
    .C_M_AXI_SRC_DATA_WIDTH(32),
    .C_M_AXI_SRC_AWUSER_WIDTH(1),
    .C_M_AXI_SRC_ARUSER_WIDTH(1),
    .C_M_AXI_SRC_WUSER_WIDTH(1),
    .C_M_AXI_SRC_RUSER_WIDTH(1),
    .C_M_AXI_SRC_BUSER_WIDTH(1),
    .C_M_AXI_SRC_USER_VALUE(32'H00000000),
    .C_M_AXI_SRC_PROT_VALUE(3'B000),
    .C_M_AXI_SRC_CACHE_VALUE(4'B0011),
    .C_M_AXI_DST_ID_WIDTH(1),
    .C_M_AXI_DST_ADDR_WIDTH(64),
    .C_M_AXI_DST_DATA_WIDTH(32),
    .C_M_AXI_DST_AWUSER_WIDTH(1),
    .C_M_AXI_DST_ARUSER_WIDTH(1),
    .C_M_AXI_DST_WUSER_WIDTH(1),
    .C_M_AXI_DST_RUSER_WIDTH(1),
    .C_M_AXI_DST_BUSER_WIDTH(1),
    .C_M_AXI_DST_USER_VALUE(32'H00000000),
    .C_M_AXI_DST_PROT_VALUE(3'B000),
    .C_M_AXI_DST_CACHE_VALUE(4'B0011)
  ) inst (
    .s_axi_control_AWADDR(s_axi_control_AWADDR),
    .s_axi_control_AWVALID(s_axi_control_AWVALID),
    .s_axi_control_AWREADY(s_axi_control_AWREADY),
    .s_axi_control_WDATA(s_axi_control_WDATA),
    .s_axi_control_WSTRB(s_axi_control_WSTRB),
    .s_axi_control_WVALID(s_axi_control_WVALID),
    .s_axi_control_WREADY(s_axi_control_WREADY),
    .s_axi_control_BRESP(s_axi_control_BRESP),
    .s_axi_control_BVALID(s_axi_control_BVALID),
    .s_axi_control_BREADY(s_axi_control_BREADY),
    .s_axi_control_ARADDR(s_axi_control_ARADDR),
    .s_axi_control_ARVALID(s_axi_control_ARVALID),
    .s_axi_control_ARREADY(s_axi_control_ARREADY),
    .s_axi_control_RDATA(s_axi_control_RDATA),
    .s_axi_control_RRESP(s_axi_control_RRESP),
    .s_axi_control_RVALID(s_axi_control_RVALID),
    .s_axi_control_RREADY(s_axi_control_RREADY),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .interrupt(interrupt),
    .m_axi_src_AWID(),
    .m_axi_src_AWADDR(m_axi_src_AWADDR),
    .m_axi_src_AWLEN(m_axi_src_AWLEN),
    .m_axi_src_AWSIZE(m_axi_src_AWSIZE),
    .m_axi_src_AWBURST(m_axi_src_AWBURST),
    .m_axi_src_AWLOCK(m_axi_src_AWLOCK),
    .m_axi_src_AWREGION(m_axi_src_AWREGION),
    .m_axi_src_AWCACHE(m_axi_src_AWCACHE),
    .m_axi_src_AWPROT(m_axi_src_AWPROT),
    .m_axi_src_AWQOS(m_axi_src_AWQOS),
    .m_axi_src_AWUSER(),
    .m_axi_src_AWVALID(m_axi_src_AWVALID),
    .m_axi_src_AWREADY(m_axi_src_AWREADY),
    .m_axi_src_WID(),
    .m_axi_src_WDATA(m_axi_src_WDATA),
    .m_axi_src_WSTRB(m_axi_src_WSTRB),
    .m_axi_src_WLAST(m_axi_src_WLAST),
    .m_axi_src_WUSER(),
    .m_axi_src_WVALID(m_axi_src_WVALID),
    .m_axi_src_WREADY(m_axi_src_WREADY),
    .m_axi_src_BID(1'B0),
    .m_axi_src_BRESP(m_axi_src_BRESP),
    .m_axi_src_BUSER(1'B0),
    .m_axi_src_BVALID(m_axi_src_BVALID),
    .m_axi_src_BREADY(m_axi_src_BREADY),
    .m_axi_src_ARID(),
    .m_axi_src_ARADDR(m_axi_src_ARADDR),
    .m_axi_src_ARLEN(m_axi_src_ARLEN),
    .m_axi_src_ARSIZE(m_axi_src_ARSIZE),
    .m_axi_src_ARBURST(m_axi_src_ARBURST),
    .m_axi_src_ARLOCK(m_axi_src_ARLOCK),
    .m_axi_src_ARREGION(m_axi_src_ARREGION),
    .m_axi_src_ARCACHE(m_axi_src_ARCACHE),
    .m_axi_src_ARPROT(m_axi_src_ARPROT),
    .m_axi_src_ARQOS(m_axi_src_ARQOS),
    .m_axi_src_ARUSER(),
    .m_axi_src_ARVALID(m_axi_src_ARVALID),
    .m_axi_src_ARREADY(m_axi_src_ARREADY),
    .m_axi_src_RID(1'B0),
    .m_axi_src_RDATA(m_axi_src_RDATA),
    .m_axi_src_RRESP(m_axi_src_RRESP),
    .m_axi_src_RLAST(m_axi_src_RLAST),
    .m_axi_src_RUSER(1'B0),
    .m_axi_src_RVALID(m_axi_src_RVALID),
    .m_axi_src_RREADY(m_axi_src_RREADY),
    .m_axi_dst_AWID(),
    .m_axi_dst_AWADDR(m_axi_dst_AWADDR),
    .m_axi_dst_AWLEN(m_axi_dst_AWLEN),
    .m_axi_dst_AWSIZE(m_axi_dst_AWSIZE),
    .m_axi_dst_AWBURST(m_axi_dst_AWBURST),
    .m_axi_dst_AWLOCK(m_axi_dst_AWLOCK),
    .m_axi_dst_AWREGION(m_axi_dst_AWREGION),
    .m_axi_dst_AWCACHE(m_axi_dst_AWCACHE),
    .m_axi_dst_AWPROT(m_axi_dst_AWPROT),
    .m_axi_dst_AWQOS(m_axi_dst_AWQOS),
    .m_axi_dst_AWUSER(),
    .m_axi_dst_AWVALID(m_axi_dst_AWVALID),
    .m_axi_dst_AWREADY(m_axi_dst_AWREADY),
    .m_axi_dst_WID(),
    .m_axi_dst_WDATA(m_axi_dst_WDATA),
    .m_axi_dst_WSTRB(m_axi_dst_WSTRB),
    .m_axi_dst_WLAST(m_axi_dst_WLAST),
    .m_axi_dst_WUSER(),
    .m_axi_dst_WVALID(m_axi_dst_WVALID),
    .m_axi_dst_WREADY(m_axi_dst_WREADY),
    .m_axi_dst_BID(1'B0),
    .m_axi_dst_BRESP(m_axi_dst_BRESP),
    .m_axi_dst_BUSER(1'B0),
    .m_axi_dst_BVALID(m_axi_dst_BVALID),
    .m_axi_dst_BREADY(m_axi_dst_BREADY),
    .m_axi_dst_ARID(),
    .m_axi_dst_ARADDR(m_axi_dst_ARADDR),
    .m_axi_dst_ARLEN(m_axi_dst_ARLEN),
    .m_axi_dst_ARSIZE(m_axi_dst_ARSIZE),
    .m_axi_dst_ARBURST(m_axi_dst_ARBURST),
    .m_axi_dst_ARLOCK(m_axi_dst_ARLOCK),
    .m_axi_dst_ARREGION(m_axi_dst_ARREGION),
    .m_axi_dst_ARCACHE(m_axi_dst_ARCACHE),
    .m_axi_dst_ARPROT(m_axi_dst_ARPROT),
    .m_axi_dst_ARQOS(m_axi_dst_ARQOS),
    .m_axi_dst_ARUSER(),
    .m_axi_dst_ARVALID(m_axi_dst_ARVALID),
    .m_axi_dst_ARREADY(m_axi_dst_ARREADY),
    .m_axi_dst_RID(1'B0),
    .m_axi_dst_RDATA(m_axi_dst_RDATA),
    .m_axi_dst_RRESP(m_axi_dst_RRESP),
    .m_axi_dst_RLAST(m_axi_dst_RLAST),
    .m_axi_dst_RUSER(1'B0),
    .m_axi_dst_RVALID(m_axi_dst_RVALID),
    .m_axi_dst_RREADY(m_axi_dst_RREADY)
  );
endmodule
