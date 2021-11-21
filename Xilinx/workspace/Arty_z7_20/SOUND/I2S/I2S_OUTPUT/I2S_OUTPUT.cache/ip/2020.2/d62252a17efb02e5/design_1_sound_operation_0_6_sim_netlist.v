// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Mon May 10 19:52:53 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_sound_operation_0_6_sim_netlist.v
// Design      : design_1_sound_operation_0_6
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_sound_operation_0_6,sound_operation,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "HLS" *) 
(* X_CORE_INFO = "sound_operation,Vivado 2020.2" *) (* hls_module = "yes" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (s_axi_control_AWADDR,
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
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    m_axi_sound_AWADDR,
    m_axi_sound_AWLEN,
    m_axi_sound_AWSIZE,
    m_axi_sound_AWBURST,
    m_axi_sound_AWLOCK,
    m_axi_sound_AWREGION,
    m_axi_sound_AWCACHE,
    m_axi_sound_AWPROT,
    m_axi_sound_AWQOS,
    m_axi_sound_AWVALID,
    m_axi_sound_AWREADY,
    m_axi_sound_WDATA,
    m_axi_sound_WSTRB,
    m_axi_sound_WLAST,
    m_axi_sound_WVALID,
    m_axi_sound_WREADY,
    m_axi_sound_BRESP,
    m_axi_sound_BVALID,
    m_axi_sound_BREADY,
    m_axi_sound_ARADDR,
    m_axi_sound_ARLEN,
    m_axi_sound_ARSIZE,
    m_axi_sound_ARBURST,
    m_axi_sound_ARLOCK,
    m_axi_sound_ARREGION,
    m_axi_sound_ARCACHE,
    m_axi_sound_ARPROT,
    m_axi_sound_ARQOS,
    m_axi_sound_ARVALID,
    m_axi_sound_ARREADY,
    m_axi_sound_RDATA,
    m_axi_sound_RRESP,
    m_axi_sound_RLAST,
    m_axi_sound_RVALID,
    m_axi_sound_RREADY,
    outdata,
    status,
    response);
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR" *) input [5:0]s_axi_control_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID" *) input s_axi_control_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY" *) output s_axi_control_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WDATA" *) input [31:0]s_axi_control_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB" *) input [3:0]s_axi_control_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WVALID" *) input s_axi_control_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WREADY" *) output s_axi_control_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BRESP" *) output [1:0]s_axi_control_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BVALID" *) output s_axi_control_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BREADY" *) input s_axi_control_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR" *) input [5:0]s_axi_control_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID" *) input s_axi_control_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY" *) output s_axi_control_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RDATA" *) output [31:0]s_axi_control_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RRESP" *) output [1:0]s_axi_control_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RVALID" *) output s_axi_control_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s_axi_control_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:m_axi_sound, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start" *) input ap_start;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done" *) output ap_done;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle" *) output ap_idle;
  (* X_INTERFACE_INFO = "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready" *) output ap_ready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWADDR" *) output [63:0]m_axi_sound_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWLEN" *) output [7:0]m_axi_sound_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWSIZE" *) output [2:0]m_axi_sound_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWBURST" *) output [1:0]m_axi_sound_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWLOCK" *) output [1:0]m_axi_sound_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWREGION" *) output [3:0]m_axi_sound_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWCACHE" *) output [3:0]m_axi_sound_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWPROT" *) output [2:0]m_axi_sound_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWQOS" *) output [3:0]m_axi_sound_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWVALID" *) output m_axi_sound_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound AWREADY" *) input m_axi_sound_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound WDATA" *) output [31:0]m_axi_sound_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound WSTRB" *) output [3:0]m_axi_sound_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound WLAST" *) output m_axi_sound_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound WVALID" *) output m_axi_sound_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound WREADY" *) input m_axi_sound_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound BRESP" *) input [1:0]m_axi_sound_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound BVALID" *) input m_axi_sound_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound BREADY" *) output m_axi_sound_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARADDR" *) output [63:0]m_axi_sound_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARLEN" *) output [7:0]m_axi_sound_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARSIZE" *) output [2:0]m_axi_sound_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARBURST" *) output [1:0]m_axi_sound_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARLOCK" *) output [1:0]m_axi_sound_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARREGION" *) output [3:0]m_axi_sound_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARCACHE" *) output [3:0]m_axi_sound_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARPROT" *) output [2:0]m_axi_sound_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARQOS" *) output [3:0]m_axi_sound_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARVALID" *) output m_axi_sound_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound ARREADY" *) input m_axi_sound_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound RDATA" *) input [31:0]m_axi_sound_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound RRESP" *) input [1:0]m_axi_sound_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound RLAST" *) input m_axi_sound_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound RVALID" *) input m_axi_sound_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_sound RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_sound, ADDR_WIDTH 64, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 32, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output m_axi_sound_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 outdata DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME outdata, LAYERED_METADATA undef" *) input [31:0]outdata;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 status DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME status, LAYERED_METADATA undef" *) input [31:0]status;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 response DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME response, LAYERED_METADATA undef" *) input [31:0]response;

  wire \<const0> ;
  wire ap_clk;
  wire ap_idle;
  wire ap_rst_n;
  wire ap_start;
  wire [5:0]s_axi_control_ARADDR;
  wire s_axi_control_ARREADY;
  wire s_axi_control_ARVALID;
  wire [5:0]s_axi_control_AWADDR;
  wire s_axi_control_AWREADY;
  wire s_axi_control_AWVALID;
  wire s_axi_control_BREADY;
  wire s_axi_control_BVALID;
  wire [31:0]s_axi_control_RDATA;
  wire s_axi_control_RREADY;
  wire s_axi_control_RVALID;
  wire [31:0]s_axi_control_WDATA;
  wire s_axi_control_WREADY;
  wire [3:0]s_axi_control_WSTRB;
  wire s_axi_control_WVALID;
  wire NLW_inst_ap_done_UNCONNECTED;
  wire NLW_inst_ap_ready_UNCONNECTED;
  wire NLW_inst_m_axi_sound_ARVALID_UNCONNECTED;
  wire NLW_inst_m_axi_sound_AWVALID_UNCONNECTED;
  wire NLW_inst_m_axi_sound_BREADY_UNCONNECTED;
  wire NLW_inst_m_axi_sound_RREADY_UNCONNECTED;
  wire NLW_inst_m_axi_sound_WLAST_UNCONNECTED;
  wire NLW_inst_m_axi_sound_WVALID_UNCONNECTED;
  wire [63:0]NLW_inst_m_axi_sound_ARADDR_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_sound_ARBURST_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_sound_ARCACHE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_sound_ARID_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_sound_ARLEN_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_sound_ARLOCK_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_sound_ARPROT_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_sound_ARQOS_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_sound_ARREGION_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_sound_ARSIZE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_sound_ARUSER_UNCONNECTED;
  wire [63:0]NLW_inst_m_axi_sound_AWADDR_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_sound_AWBURST_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_sound_AWCACHE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_sound_AWID_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_sound_AWLEN_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_sound_AWLOCK_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_sound_AWPROT_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_sound_AWQOS_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_sound_AWREGION_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_sound_AWSIZE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_sound_AWUSER_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_sound_WDATA_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_sound_WID_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_sound_WSTRB_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_sound_WUSER_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_control_BRESP_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_control_RRESP_UNCONNECTED;

  assign ap_done = \<const0> ;
  assign ap_ready = \<const0> ;
  assign m_axi_sound_ARADDR[63] = \<const0> ;
  assign m_axi_sound_ARADDR[62] = \<const0> ;
  assign m_axi_sound_ARADDR[61] = \<const0> ;
  assign m_axi_sound_ARADDR[60] = \<const0> ;
  assign m_axi_sound_ARADDR[59] = \<const0> ;
  assign m_axi_sound_ARADDR[58] = \<const0> ;
  assign m_axi_sound_ARADDR[57] = \<const0> ;
  assign m_axi_sound_ARADDR[56] = \<const0> ;
  assign m_axi_sound_ARADDR[55] = \<const0> ;
  assign m_axi_sound_ARADDR[54] = \<const0> ;
  assign m_axi_sound_ARADDR[53] = \<const0> ;
  assign m_axi_sound_ARADDR[52] = \<const0> ;
  assign m_axi_sound_ARADDR[51] = \<const0> ;
  assign m_axi_sound_ARADDR[50] = \<const0> ;
  assign m_axi_sound_ARADDR[49] = \<const0> ;
  assign m_axi_sound_ARADDR[48] = \<const0> ;
  assign m_axi_sound_ARADDR[47] = \<const0> ;
  assign m_axi_sound_ARADDR[46] = \<const0> ;
  assign m_axi_sound_ARADDR[45] = \<const0> ;
  assign m_axi_sound_ARADDR[44] = \<const0> ;
  assign m_axi_sound_ARADDR[43] = \<const0> ;
  assign m_axi_sound_ARADDR[42] = \<const0> ;
  assign m_axi_sound_ARADDR[41] = \<const0> ;
  assign m_axi_sound_ARADDR[40] = \<const0> ;
  assign m_axi_sound_ARADDR[39] = \<const0> ;
  assign m_axi_sound_ARADDR[38] = \<const0> ;
  assign m_axi_sound_ARADDR[37] = \<const0> ;
  assign m_axi_sound_ARADDR[36] = \<const0> ;
  assign m_axi_sound_ARADDR[35] = \<const0> ;
  assign m_axi_sound_ARADDR[34] = \<const0> ;
  assign m_axi_sound_ARADDR[33] = \<const0> ;
  assign m_axi_sound_ARADDR[32] = \<const0> ;
  assign m_axi_sound_ARADDR[31] = \<const0> ;
  assign m_axi_sound_ARADDR[30] = \<const0> ;
  assign m_axi_sound_ARADDR[29] = \<const0> ;
  assign m_axi_sound_ARADDR[28] = \<const0> ;
  assign m_axi_sound_ARADDR[27] = \<const0> ;
  assign m_axi_sound_ARADDR[26] = \<const0> ;
  assign m_axi_sound_ARADDR[25] = \<const0> ;
  assign m_axi_sound_ARADDR[24] = \<const0> ;
  assign m_axi_sound_ARADDR[23] = \<const0> ;
  assign m_axi_sound_ARADDR[22] = \<const0> ;
  assign m_axi_sound_ARADDR[21] = \<const0> ;
  assign m_axi_sound_ARADDR[20] = \<const0> ;
  assign m_axi_sound_ARADDR[19] = \<const0> ;
  assign m_axi_sound_ARADDR[18] = \<const0> ;
  assign m_axi_sound_ARADDR[17] = \<const0> ;
  assign m_axi_sound_ARADDR[16] = \<const0> ;
  assign m_axi_sound_ARADDR[15] = \<const0> ;
  assign m_axi_sound_ARADDR[14] = \<const0> ;
  assign m_axi_sound_ARADDR[13] = \<const0> ;
  assign m_axi_sound_ARADDR[12] = \<const0> ;
  assign m_axi_sound_ARADDR[11] = \<const0> ;
  assign m_axi_sound_ARADDR[10] = \<const0> ;
  assign m_axi_sound_ARADDR[9] = \<const0> ;
  assign m_axi_sound_ARADDR[8] = \<const0> ;
  assign m_axi_sound_ARADDR[7] = \<const0> ;
  assign m_axi_sound_ARADDR[6] = \<const0> ;
  assign m_axi_sound_ARADDR[5] = \<const0> ;
  assign m_axi_sound_ARADDR[4] = \<const0> ;
  assign m_axi_sound_ARADDR[3] = \<const0> ;
  assign m_axi_sound_ARADDR[2] = \<const0> ;
  assign m_axi_sound_ARADDR[1] = \<const0> ;
  assign m_axi_sound_ARADDR[0] = \<const0> ;
  assign m_axi_sound_ARBURST[1] = \<const0> ;
  assign m_axi_sound_ARBURST[0] = \<const0> ;
  assign m_axi_sound_ARCACHE[3] = \<const0> ;
  assign m_axi_sound_ARCACHE[2] = \<const0> ;
  assign m_axi_sound_ARCACHE[1] = \<const0> ;
  assign m_axi_sound_ARCACHE[0] = \<const0> ;
  assign m_axi_sound_ARLEN[7] = \<const0> ;
  assign m_axi_sound_ARLEN[6] = \<const0> ;
  assign m_axi_sound_ARLEN[5] = \<const0> ;
  assign m_axi_sound_ARLEN[4] = \<const0> ;
  assign m_axi_sound_ARLEN[3] = \<const0> ;
  assign m_axi_sound_ARLEN[2] = \<const0> ;
  assign m_axi_sound_ARLEN[1] = \<const0> ;
  assign m_axi_sound_ARLEN[0] = \<const0> ;
  assign m_axi_sound_ARLOCK[1] = \<const0> ;
  assign m_axi_sound_ARLOCK[0] = \<const0> ;
  assign m_axi_sound_ARPROT[2] = \<const0> ;
  assign m_axi_sound_ARPROT[1] = \<const0> ;
  assign m_axi_sound_ARPROT[0] = \<const0> ;
  assign m_axi_sound_ARQOS[3] = \<const0> ;
  assign m_axi_sound_ARQOS[2] = \<const0> ;
  assign m_axi_sound_ARQOS[1] = \<const0> ;
  assign m_axi_sound_ARQOS[0] = \<const0> ;
  assign m_axi_sound_ARREGION[3] = \<const0> ;
  assign m_axi_sound_ARREGION[2] = \<const0> ;
  assign m_axi_sound_ARREGION[1] = \<const0> ;
  assign m_axi_sound_ARREGION[0] = \<const0> ;
  assign m_axi_sound_ARSIZE[2] = \<const0> ;
  assign m_axi_sound_ARSIZE[1] = \<const0> ;
  assign m_axi_sound_ARSIZE[0] = \<const0> ;
  assign m_axi_sound_ARVALID = \<const0> ;
  assign m_axi_sound_AWADDR[63] = \<const0> ;
  assign m_axi_sound_AWADDR[62] = \<const0> ;
  assign m_axi_sound_AWADDR[61] = \<const0> ;
  assign m_axi_sound_AWADDR[60] = \<const0> ;
  assign m_axi_sound_AWADDR[59] = \<const0> ;
  assign m_axi_sound_AWADDR[58] = \<const0> ;
  assign m_axi_sound_AWADDR[57] = \<const0> ;
  assign m_axi_sound_AWADDR[56] = \<const0> ;
  assign m_axi_sound_AWADDR[55] = \<const0> ;
  assign m_axi_sound_AWADDR[54] = \<const0> ;
  assign m_axi_sound_AWADDR[53] = \<const0> ;
  assign m_axi_sound_AWADDR[52] = \<const0> ;
  assign m_axi_sound_AWADDR[51] = \<const0> ;
  assign m_axi_sound_AWADDR[50] = \<const0> ;
  assign m_axi_sound_AWADDR[49] = \<const0> ;
  assign m_axi_sound_AWADDR[48] = \<const0> ;
  assign m_axi_sound_AWADDR[47] = \<const0> ;
  assign m_axi_sound_AWADDR[46] = \<const0> ;
  assign m_axi_sound_AWADDR[45] = \<const0> ;
  assign m_axi_sound_AWADDR[44] = \<const0> ;
  assign m_axi_sound_AWADDR[43] = \<const0> ;
  assign m_axi_sound_AWADDR[42] = \<const0> ;
  assign m_axi_sound_AWADDR[41] = \<const0> ;
  assign m_axi_sound_AWADDR[40] = \<const0> ;
  assign m_axi_sound_AWADDR[39] = \<const0> ;
  assign m_axi_sound_AWADDR[38] = \<const0> ;
  assign m_axi_sound_AWADDR[37] = \<const0> ;
  assign m_axi_sound_AWADDR[36] = \<const0> ;
  assign m_axi_sound_AWADDR[35] = \<const0> ;
  assign m_axi_sound_AWADDR[34] = \<const0> ;
  assign m_axi_sound_AWADDR[33] = \<const0> ;
  assign m_axi_sound_AWADDR[32] = \<const0> ;
  assign m_axi_sound_AWADDR[31] = \<const0> ;
  assign m_axi_sound_AWADDR[30] = \<const0> ;
  assign m_axi_sound_AWADDR[29] = \<const0> ;
  assign m_axi_sound_AWADDR[28] = \<const0> ;
  assign m_axi_sound_AWADDR[27] = \<const0> ;
  assign m_axi_sound_AWADDR[26] = \<const0> ;
  assign m_axi_sound_AWADDR[25] = \<const0> ;
  assign m_axi_sound_AWADDR[24] = \<const0> ;
  assign m_axi_sound_AWADDR[23] = \<const0> ;
  assign m_axi_sound_AWADDR[22] = \<const0> ;
  assign m_axi_sound_AWADDR[21] = \<const0> ;
  assign m_axi_sound_AWADDR[20] = \<const0> ;
  assign m_axi_sound_AWADDR[19] = \<const0> ;
  assign m_axi_sound_AWADDR[18] = \<const0> ;
  assign m_axi_sound_AWADDR[17] = \<const0> ;
  assign m_axi_sound_AWADDR[16] = \<const0> ;
  assign m_axi_sound_AWADDR[15] = \<const0> ;
  assign m_axi_sound_AWADDR[14] = \<const0> ;
  assign m_axi_sound_AWADDR[13] = \<const0> ;
  assign m_axi_sound_AWADDR[12] = \<const0> ;
  assign m_axi_sound_AWADDR[11] = \<const0> ;
  assign m_axi_sound_AWADDR[10] = \<const0> ;
  assign m_axi_sound_AWADDR[9] = \<const0> ;
  assign m_axi_sound_AWADDR[8] = \<const0> ;
  assign m_axi_sound_AWADDR[7] = \<const0> ;
  assign m_axi_sound_AWADDR[6] = \<const0> ;
  assign m_axi_sound_AWADDR[5] = \<const0> ;
  assign m_axi_sound_AWADDR[4] = \<const0> ;
  assign m_axi_sound_AWADDR[3] = \<const0> ;
  assign m_axi_sound_AWADDR[2] = \<const0> ;
  assign m_axi_sound_AWADDR[1] = \<const0> ;
  assign m_axi_sound_AWADDR[0] = \<const0> ;
  assign m_axi_sound_AWBURST[1] = \<const0> ;
  assign m_axi_sound_AWBURST[0] = \<const0> ;
  assign m_axi_sound_AWCACHE[3] = \<const0> ;
  assign m_axi_sound_AWCACHE[2] = \<const0> ;
  assign m_axi_sound_AWCACHE[1] = \<const0> ;
  assign m_axi_sound_AWCACHE[0] = \<const0> ;
  assign m_axi_sound_AWLEN[7] = \<const0> ;
  assign m_axi_sound_AWLEN[6] = \<const0> ;
  assign m_axi_sound_AWLEN[5] = \<const0> ;
  assign m_axi_sound_AWLEN[4] = \<const0> ;
  assign m_axi_sound_AWLEN[3] = \<const0> ;
  assign m_axi_sound_AWLEN[2] = \<const0> ;
  assign m_axi_sound_AWLEN[1] = \<const0> ;
  assign m_axi_sound_AWLEN[0] = \<const0> ;
  assign m_axi_sound_AWLOCK[1] = \<const0> ;
  assign m_axi_sound_AWLOCK[0] = \<const0> ;
  assign m_axi_sound_AWPROT[2] = \<const0> ;
  assign m_axi_sound_AWPROT[1] = \<const0> ;
  assign m_axi_sound_AWPROT[0] = \<const0> ;
  assign m_axi_sound_AWQOS[3] = \<const0> ;
  assign m_axi_sound_AWQOS[2] = \<const0> ;
  assign m_axi_sound_AWQOS[1] = \<const0> ;
  assign m_axi_sound_AWQOS[0] = \<const0> ;
  assign m_axi_sound_AWREGION[3] = \<const0> ;
  assign m_axi_sound_AWREGION[2] = \<const0> ;
  assign m_axi_sound_AWREGION[1] = \<const0> ;
  assign m_axi_sound_AWREGION[0] = \<const0> ;
  assign m_axi_sound_AWSIZE[2] = \<const0> ;
  assign m_axi_sound_AWSIZE[1] = \<const0> ;
  assign m_axi_sound_AWSIZE[0] = \<const0> ;
  assign m_axi_sound_AWVALID = \<const0> ;
  assign m_axi_sound_BREADY = \<const0> ;
  assign m_axi_sound_RREADY = \<const0> ;
  assign m_axi_sound_WDATA[31] = \<const0> ;
  assign m_axi_sound_WDATA[30] = \<const0> ;
  assign m_axi_sound_WDATA[29] = \<const0> ;
  assign m_axi_sound_WDATA[28] = \<const0> ;
  assign m_axi_sound_WDATA[27] = \<const0> ;
  assign m_axi_sound_WDATA[26] = \<const0> ;
  assign m_axi_sound_WDATA[25] = \<const0> ;
  assign m_axi_sound_WDATA[24] = \<const0> ;
  assign m_axi_sound_WDATA[23] = \<const0> ;
  assign m_axi_sound_WDATA[22] = \<const0> ;
  assign m_axi_sound_WDATA[21] = \<const0> ;
  assign m_axi_sound_WDATA[20] = \<const0> ;
  assign m_axi_sound_WDATA[19] = \<const0> ;
  assign m_axi_sound_WDATA[18] = \<const0> ;
  assign m_axi_sound_WDATA[17] = \<const0> ;
  assign m_axi_sound_WDATA[16] = \<const0> ;
  assign m_axi_sound_WDATA[15] = \<const0> ;
  assign m_axi_sound_WDATA[14] = \<const0> ;
  assign m_axi_sound_WDATA[13] = \<const0> ;
  assign m_axi_sound_WDATA[12] = \<const0> ;
  assign m_axi_sound_WDATA[11] = \<const0> ;
  assign m_axi_sound_WDATA[10] = \<const0> ;
  assign m_axi_sound_WDATA[9] = \<const0> ;
  assign m_axi_sound_WDATA[8] = \<const0> ;
  assign m_axi_sound_WDATA[7] = \<const0> ;
  assign m_axi_sound_WDATA[6] = \<const0> ;
  assign m_axi_sound_WDATA[5] = \<const0> ;
  assign m_axi_sound_WDATA[4] = \<const0> ;
  assign m_axi_sound_WDATA[3] = \<const0> ;
  assign m_axi_sound_WDATA[2] = \<const0> ;
  assign m_axi_sound_WDATA[1] = \<const0> ;
  assign m_axi_sound_WDATA[0] = \<const0> ;
  assign m_axi_sound_WLAST = \<const0> ;
  assign m_axi_sound_WSTRB[3] = \<const0> ;
  assign m_axi_sound_WSTRB[2] = \<const0> ;
  assign m_axi_sound_WSTRB[1] = \<const0> ;
  assign m_axi_sound_WSTRB[0] = \<const0> ;
  assign m_axi_sound_WVALID = \<const0> ;
  assign s_axi_control_BRESP[1] = \<const0> ;
  assign s_axi_control_BRESP[0] = \<const0> ;
  assign s_axi_control_RRESP[1] = \<const0> ;
  assign s_axi_control_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_M_AXI_SOUND_ADDR_WIDTH = "64" *) 
  (* C_M_AXI_SOUND_ARUSER_WIDTH = "1" *) 
  (* C_M_AXI_SOUND_AWUSER_WIDTH = "1" *) 
  (* C_M_AXI_SOUND_BUSER_WIDTH = "1" *) 
  (* C_M_AXI_SOUND_CACHE_VALUE = "4'b0011" *) 
  (* C_M_AXI_SOUND_DATA_WIDTH = "32" *) 
  (* C_M_AXI_SOUND_ID_WIDTH = "1" *) 
  (* C_M_AXI_SOUND_PROT_VALUE = "3'b000" *) 
  (* C_M_AXI_SOUND_RUSER_WIDTH = "1" *) 
  (* C_M_AXI_SOUND_USER_VALUE = "0" *) 
  (* C_M_AXI_SOUND_WSTRB_WIDTH = "4" *) 
  (* C_M_AXI_SOUND_WUSER_WIDTH = "1" *) 
  (* C_S_AXI_CONTROL_ADDR_WIDTH = "6" *) 
  (* C_S_AXI_CONTROL_DATA_WIDTH = "32" *) 
  (* C_S_AXI_CONTROL_WSTRB_WIDTH = "4" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_WSTRB_WIDTH = "4" *) 
  (* SDX_KERNEL = "true" *) 
  (* SDX_KERNEL_SYNTH_INST = "inst" *) 
  (* SDX_KERNEL_TYPE = "hls" *) 
  (* ap_ST_fsm_state1 = "2'b01" *) 
  (* ap_ST_fsm_state2 = "2'b10" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation inst
       (.ap_clk(ap_clk),
        .ap_done(NLW_inst_ap_done_UNCONNECTED),
        .ap_idle(ap_idle),
        .ap_ready(NLW_inst_ap_ready_UNCONNECTED),
        .ap_rst_n(ap_rst_n),
        .ap_start(ap_start),
        .m_axi_sound_ARADDR(NLW_inst_m_axi_sound_ARADDR_UNCONNECTED[63:0]),
        .m_axi_sound_ARBURST(NLW_inst_m_axi_sound_ARBURST_UNCONNECTED[1:0]),
        .m_axi_sound_ARCACHE(NLW_inst_m_axi_sound_ARCACHE_UNCONNECTED[3:0]),
        .m_axi_sound_ARID(NLW_inst_m_axi_sound_ARID_UNCONNECTED[0]),
        .m_axi_sound_ARLEN(NLW_inst_m_axi_sound_ARLEN_UNCONNECTED[7:0]),
        .m_axi_sound_ARLOCK(NLW_inst_m_axi_sound_ARLOCK_UNCONNECTED[1:0]),
        .m_axi_sound_ARPROT(NLW_inst_m_axi_sound_ARPROT_UNCONNECTED[2:0]),
        .m_axi_sound_ARQOS(NLW_inst_m_axi_sound_ARQOS_UNCONNECTED[3:0]),
        .m_axi_sound_ARREADY(1'b0),
        .m_axi_sound_ARREGION(NLW_inst_m_axi_sound_ARREGION_UNCONNECTED[3:0]),
        .m_axi_sound_ARSIZE(NLW_inst_m_axi_sound_ARSIZE_UNCONNECTED[2:0]),
        .m_axi_sound_ARUSER(NLW_inst_m_axi_sound_ARUSER_UNCONNECTED[0]),
        .m_axi_sound_ARVALID(NLW_inst_m_axi_sound_ARVALID_UNCONNECTED),
        .m_axi_sound_AWADDR(NLW_inst_m_axi_sound_AWADDR_UNCONNECTED[63:0]),
        .m_axi_sound_AWBURST(NLW_inst_m_axi_sound_AWBURST_UNCONNECTED[1:0]),
        .m_axi_sound_AWCACHE(NLW_inst_m_axi_sound_AWCACHE_UNCONNECTED[3:0]),
        .m_axi_sound_AWID(NLW_inst_m_axi_sound_AWID_UNCONNECTED[0]),
        .m_axi_sound_AWLEN(NLW_inst_m_axi_sound_AWLEN_UNCONNECTED[7:0]),
        .m_axi_sound_AWLOCK(NLW_inst_m_axi_sound_AWLOCK_UNCONNECTED[1:0]),
        .m_axi_sound_AWPROT(NLW_inst_m_axi_sound_AWPROT_UNCONNECTED[2:0]),
        .m_axi_sound_AWQOS(NLW_inst_m_axi_sound_AWQOS_UNCONNECTED[3:0]),
        .m_axi_sound_AWREADY(1'b0),
        .m_axi_sound_AWREGION(NLW_inst_m_axi_sound_AWREGION_UNCONNECTED[3:0]),
        .m_axi_sound_AWSIZE(NLW_inst_m_axi_sound_AWSIZE_UNCONNECTED[2:0]),
        .m_axi_sound_AWUSER(NLW_inst_m_axi_sound_AWUSER_UNCONNECTED[0]),
        .m_axi_sound_AWVALID(NLW_inst_m_axi_sound_AWVALID_UNCONNECTED),
        .m_axi_sound_BID(1'b0),
        .m_axi_sound_BREADY(NLW_inst_m_axi_sound_BREADY_UNCONNECTED),
        .m_axi_sound_BRESP({1'b0,1'b0}),
        .m_axi_sound_BUSER(1'b0),
        .m_axi_sound_BVALID(1'b0),
        .m_axi_sound_RDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .m_axi_sound_RID(1'b0),
        .m_axi_sound_RLAST(1'b0),
        .m_axi_sound_RREADY(NLW_inst_m_axi_sound_RREADY_UNCONNECTED),
        .m_axi_sound_RRESP({1'b0,1'b0}),
        .m_axi_sound_RUSER(1'b0),
        .m_axi_sound_RVALID(1'b0),
        .m_axi_sound_WDATA(NLW_inst_m_axi_sound_WDATA_UNCONNECTED[31:0]),
        .m_axi_sound_WID(NLW_inst_m_axi_sound_WID_UNCONNECTED[0]),
        .m_axi_sound_WLAST(NLW_inst_m_axi_sound_WLAST_UNCONNECTED),
        .m_axi_sound_WREADY(1'b0),
        .m_axi_sound_WSTRB(NLW_inst_m_axi_sound_WSTRB_UNCONNECTED[3:0]),
        .m_axi_sound_WUSER(NLW_inst_m_axi_sound_WUSER_UNCONNECTED[0]),
        .m_axi_sound_WVALID(NLW_inst_m_axi_sound_WVALID_UNCONNECTED),
        .outdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .response({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_control_ARADDR(s_axi_control_ARADDR),
        .s_axi_control_ARREADY(s_axi_control_ARREADY),
        .s_axi_control_ARVALID(s_axi_control_ARVALID),
        .s_axi_control_AWADDR(s_axi_control_AWADDR),
        .s_axi_control_AWREADY(s_axi_control_AWREADY),
        .s_axi_control_AWVALID(s_axi_control_AWVALID),
        .s_axi_control_BREADY(s_axi_control_BREADY),
        .s_axi_control_BRESP(NLW_inst_s_axi_control_BRESP_UNCONNECTED[1:0]),
        .s_axi_control_BVALID(s_axi_control_BVALID),
        .s_axi_control_RDATA(s_axi_control_RDATA),
        .s_axi_control_RREADY(s_axi_control_RREADY),
        .s_axi_control_RRESP(NLW_inst_s_axi_control_RRESP_UNCONNECTED[1:0]),
        .s_axi_control_RVALID(s_axi_control_RVALID),
        .s_axi_control_WDATA(s_axi_control_WDATA),
        .s_axi_control_WREADY(s_axi_control_WREADY),
        .s_axi_control_WSTRB(s_axi_control_WSTRB),
        .s_axi_control_WVALID(s_axi_control_WVALID),
        .status({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* C_M_AXI_SOUND_ADDR_WIDTH = "64" *) (* C_M_AXI_SOUND_ARUSER_WIDTH = "1" *) (* C_M_AXI_SOUND_AWUSER_WIDTH = "1" *) 
(* C_M_AXI_SOUND_BUSER_WIDTH = "1" *) (* C_M_AXI_SOUND_CACHE_VALUE = "4'b0011" *) (* C_M_AXI_SOUND_DATA_WIDTH = "32" *) 
(* C_M_AXI_SOUND_ID_WIDTH = "1" *) (* C_M_AXI_SOUND_PROT_VALUE = "3'b000" *) (* C_M_AXI_SOUND_RUSER_WIDTH = "1" *) 
(* C_M_AXI_SOUND_USER_VALUE = "0" *) (* C_M_AXI_SOUND_WSTRB_WIDTH = "4" *) (* C_M_AXI_SOUND_WUSER_WIDTH = "1" *) 
(* C_S_AXI_CONTROL_ADDR_WIDTH = "6" *) (* C_S_AXI_CONTROL_DATA_WIDTH = "32" *) (* C_S_AXI_CONTROL_WSTRB_WIDTH = "4" *) 
(* C_S_AXI_DATA_WIDTH = "32" *) (* C_S_AXI_WSTRB_WIDTH = "4" *) (* ap_ST_fsm_state1 = "2'b01" *) 
(* ap_ST_fsm_state2 = "2'b10" *) (* hls_module = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation
   (ap_clk,
    ap_rst_n,
    ap_start,
    ap_done,
    ap_idle,
    ap_ready,
    m_axi_sound_AWVALID,
    m_axi_sound_AWREADY,
    m_axi_sound_AWADDR,
    m_axi_sound_AWID,
    m_axi_sound_AWLEN,
    m_axi_sound_AWSIZE,
    m_axi_sound_AWBURST,
    m_axi_sound_AWLOCK,
    m_axi_sound_AWCACHE,
    m_axi_sound_AWPROT,
    m_axi_sound_AWQOS,
    m_axi_sound_AWREGION,
    m_axi_sound_AWUSER,
    m_axi_sound_WVALID,
    m_axi_sound_WREADY,
    m_axi_sound_WDATA,
    m_axi_sound_WSTRB,
    m_axi_sound_WLAST,
    m_axi_sound_WID,
    m_axi_sound_WUSER,
    m_axi_sound_ARVALID,
    m_axi_sound_ARREADY,
    m_axi_sound_ARADDR,
    m_axi_sound_ARID,
    m_axi_sound_ARLEN,
    m_axi_sound_ARSIZE,
    m_axi_sound_ARBURST,
    m_axi_sound_ARLOCK,
    m_axi_sound_ARCACHE,
    m_axi_sound_ARPROT,
    m_axi_sound_ARQOS,
    m_axi_sound_ARREGION,
    m_axi_sound_ARUSER,
    m_axi_sound_RVALID,
    m_axi_sound_RREADY,
    m_axi_sound_RDATA,
    m_axi_sound_RLAST,
    m_axi_sound_RID,
    m_axi_sound_RUSER,
    m_axi_sound_RRESP,
    m_axi_sound_BVALID,
    m_axi_sound_BREADY,
    m_axi_sound_BRESP,
    m_axi_sound_BID,
    m_axi_sound_BUSER,
    outdata,
    status,
    response,
    s_axi_control_AWVALID,
    s_axi_control_AWREADY,
    s_axi_control_AWADDR,
    s_axi_control_WVALID,
    s_axi_control_WREADY,
    s_axi_control_WDATA,
    s_axi_control_WSTRB,
    s_axi_control_ARVALID,
    s_axi_control_ARREADY,
    s_axi_control_ARADDR,
    s_axi_control_RVALID,
    s_axi_control_RREADY,
    s_axi_control_RDATA,
    s_axi_control_RRESP,
    s_axi_control_BVALID,
    s_axi_control_BREADY,
    s_axi_control_BRESP);
  input ap_clk;
  input ap_rst_n;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output m_axi_sound_AWVALID;
  input m_axi_sound_AWREADY;
  output [63:0]m_axi_sound_AWADDR;
  output [0:0]m_axi_sound_AWID;
  output [7:0]m_axi_sound_AWLEN;
  output [2:0]m_axi_sound_AWSIZE;
  output [1:0]m_axi_sound_AWBURST;
  output [1:0]m_axi_sound_AWLOCK;
  output [3:0]m_axi_sound_AWCACHE;
  output [2:0]m_axi_sound_AWPROT;
  output [3:0]m_axi_sound_AWQOS;
  output [3:0]m_axi_sound_AWREGION;
  output [0:0]m_axi_sound_AWUSER;
  output m_axi_sound_WVALID;
  input m_axi_sound_WREADY;
  output [31:0]m_axi_sound_WDATA;
  output [3:0]m_axi_sound_WSTRB;
  output m_axi_sound_WLAST;
  output [0:0]m_axi_sound_WID;
  output [0:0]m_axi_sound_WUSER;
  output m_axi_sound_ARVALID;
  input m_axi_sound_ARREADY;
  output [63:0]m_axi_sound_ARADDR;
  output [0:0]m_axi_sound_ARID;
  output [7:0]m_axi_sound_ARLEN;
  output [2:0]m_axi_sound_ARSIZE;
  output [1:0]m_axi_sound_ARBURST;
  output [1:0]m_axi_sound_ARLOCK;
  output [3:0]m_axi_sound_ARCACHE;
  output [2:0]m_axi_sound_ARPROT;
  output [3:0]m_axi_sound_ARQOS;
  output [3:0]m_axi_sound_ARREGION;
  output [0:0]m_axi_sound_ARUSER;
  input m_axi_sound_RVALID;
  output m_axi_sound_RREADY;
  input [31:0]m_axi_sound_RDATA;
  input m_axi_sound_RLAST;
  input [0:0]m_axi_sound_RID;
  input [0:0]m_axi_sound_RUSER;
  input [1:0]m_axi_sound_RRESP;
  input m_axi_sound_BVALID;
  output m_axi_sound_BREADY;
  input [1:0]m_axi_sound_BRESP;
  input [0:0]m_axi_sound_BID;
  input [0:0]m_axi_sound_BUSER;
  input [31:0]outdata;
  input [31:0]status;
  input [31:0]response;
  input s_axi_control_AWVALID;
  output s_axi_control_AWREADY;
  input [5:0]s_axi_control_AWADDR;
  input s_axi_control_WVALID;
  output s_axi_control_WREADY;
  input [31:0]s_axi_control_WDATA;
  input [3:0]s_axi_control_WSTRB;
  input s_axi_control_ARVALID;
  output s_axi_control_ARREADY;
  input [5:0]s_axi_control_ARADDR;
  output s_axi_control_RVALID;
  input s_axi_control_RREADY;
  output [31:0]s_axi_control_RDATA;
  output [1:0]s_axi_control_RRESP;
  output s_axi_control_BVALID;
  input s_axi_control_BREADY;
  output [1:0]s_axi_control_BRESP;

  wire \<const0> ;
  wire \ap_CS_fsm[1]_i_1_n_0 ;
  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire \ap_CS_fsm_reg_n_0_[1] ;
  wire [0:0]ap_NS_fsm;
  wire ap_clk;
  wire ap_idle;
  wire ap_rst_n;
  wire ap_rst_n_inv;
  wire ap_start;
  wire [5:0]s_axi_control_ARADDR;
  wire s_axi_control_ARREADY;
  wire s_axi_control_ARVALID;
  wire [5:0]s_axi_control_AWADDR;
  wire s_axi_control_AWREADY;
  wire s_axi_control_AWVALID;
  wire s_axi_control_BREADY;
  wire s_axi_control_BVALID;
  wire [31:0]s_axi_control_RDATA;
  wire s_axi_control_RREADY;
  wire s_axi_control_RVALID;
  wire [31:0]s_axi_control_WDATA;
  wire s_axi_control_WREADY;
  wire [3:0]s_axi_control_WSTRB;
  wire s_axi_control_WVALID;

  assign ap_done = \<const0> ;
  assign ap_ready = \<const0> ;
  assign m_axi_sound_ARADDR[63] = \<const0> ;
  assign m_axi_sound_ARADDR[62] = \<const0> ;
  assign m_axi_sound_ARADDR[61] = \<const0> ;
  assign m_axi_sound_ARADDR[60] = \<const0> ;
  assign m_axi_sound_ARADDR[59] = \<const0> ;
  assign m_axi_sound_ARADDR[58] = \<const0> ;
  assign m_axi_sound_ARADDR[57] = \<const0> ;
  assign m_axi_sound_ARADDR[56] = \<const0> ;
  assign m_axi_sound_ARADDR[55] = \<const0> ;
  assign m_axi_sound_ARADDR[54] = \<const0> ;
  assign m_axi_sound_ARADDR[53] = \<const0> ;
  assign m_axi_sound_ARADDR[52] = \<const0> ;
  assign m_axi_sound_ARADDR[51] = \<const0> ;
  assign m_axi_sound_ARADDR[50] = \<const0> ;
  assign m_axi_sound_ARADDR[49] = \<const0> ;
  assign m_axi_sound_ARADDR[48] = \<const0> ;
  assign m_axi_sound_ARADDR[47] = \<const0> ;
  assign m_axi_sound_ARADDR[46] = \<const0> ;
  assign m_axi_sound_ARADDR[45] = \<const0> ;
  assign m_axi_sound_ARADDR[44] = \<const0> ;
  assign m_axi_sound_ARADDR[43] = \<const0> ;
  assign m_axi_sound_ARADDR[42] = \<const0> ;
  assign m_axi_sound_ARADDR[41] = \<const0> ;
  assign m_axi_sound_ARADDR[40] = \<const0> ;
  assign m_axi_sound_ARADDR[39] = \<const0> ;
  assign m_axi_sound_ARADDR[38] = \<const0> ;
  assign m_axi_sound_ARADDR[37] = \<const0> ;
  assign m_axi_sound_ARADDR[36] = \<const0> ;
  assign m_axi_sound_ARADDR[35] = \<const0> ;
  assign m_axi_sound_ARADDR[34] = \<const0> ;
  assign m_axi_sound_ARADDR[33] = \<const0> ;
  assign m_axi_sound_ARADDR[32] = \<const0> ;
  assign m_axi_sound_ARADDR[31] = \<const0> ;
  assign m_axi_sound_ARADDR[30] = \<const0> ;
  assign m_axi_sound_ARADDR[29] = \<const0> ;
  assign m_axi_sound_ARADDR[28] = \<const0> ;
  assign m_axi_sound_ARADDR[27] = \<const0> ;
  assign m_axi_sound_ARADDR[26] = \<const0> ;
  assign m_axi_sound_ARADDR[25] = \<const0> ;
  assign m_axi_sound_ARADDR[24] = \<const0> ;
  assign m_axi_sound_ARADDR[23] = \<const0> ;
  assign m_axi_sound_ARADDR[22] = \<const0> ;
  assign m_axi_sound_ARADDR[21] = \<const0> ;
  assign m_axi_sound_ARADDR[20] = \<const0> ;
  assign m_axi_sound_ARADDR[19] = \<const0> ;
  assign m_axi_sound_ARADDR[18] = \<const0> ;
  assign m_axi_sound_ARADDR[17] = \<const0> ;
  assign m_axi_sound_ARADDR[16] = \<const0> ;
  assign m_axi_sound_ARADDR[15] = \<const0> ;
  assign m_axi_sound_ARADDR[14] = \<const0> ;
  assign m_axi_sound_ARADDR[13] = \<const0> ;
  assign m_axi_sound_ARADDR[12] = \<const0> ;
  assign m_axi_sound_ARADDR[11] = \<const0> ;
  assign m_axi_sound_ARADDR[10] = \<const0> ;
  assign m_axi_sound_ARADDR[9] = \<const0> ;
  assign m_axi_sound_ARADDR[8] = \<const0> ;
  assign m_axi_sound_ARADDR[7] = \<const0> ;
  assign m_axi_sound_ARADDR[6] = \<const0> ;
  assign m_axi_sound_ARADDR[5] = \<const0> ;
  assign m_axi_sound_ARADDR[4] = \<const0> ;
  assign m_axi_sound_ARADDR[3] = \<const0> ;
  assign m_axi_sound_ARADDR[2] = \<const0> ;
  assign m_axi_sound_ARADDR[1] = \<const0> ;
  assign m_axi_sound_ARADDR[0] = \<const0> ;
  assign m_axi_sound_ARBURST[1] = \<const0> ;
  assign m_axi_sound_ARBURST[0] = \<const0> ;
  assign m_axi_sound_ARCACHE[3] = \<const0> ;
  assign m_axi_sound_ARCACHE[2] = \<const0> ;
  assign m_axi_sound_ARCACHE[1] = \<const0> ;
  assign m_axi_sound_ARCACHE[0] = \<const0> ;
  assign m_axi_sound_ARID[0] = \<const0> ;
  assign m_axi_sound_ARLEN[7] = \<const0> ;
  assign m_axi_sound_ARLEN[6] = \<const0> ;
  assign m_axi_sound_ARLEN[5] = \<const0> ;
  assign m_axi_sound_ARLEN[4] = \<const0> ;
  assign m_axi_sound_ARLEN[3] = \<const0> ;
  assign m_axi_sound_ARLEN[2] = \<const0> ;
  assign m_axi_sound_ARLEN[1] = \<const0> ;
  assign m_axi_sound_ARLEN[0] = \<const0> ;
  assign m_axi_sound_ARLOCK[1] = \<const0> ;
  assign m_axi_sound_ARLOCK[0] = \<const0> ;
  assign m_axi_sound_ARPROT[2] = \<const0> ;
  assign m_axi_sound_ARPROT[1] = \<const0> ;
  assign m_axi_sound_ARPROT[0] = \<const0> ;
  assign m_axi_sound_ARQOS[3] = \<const0> ;
  assign m_axi_sound_ARQOS[2] = \<const0> ;
  assign m_axi_sound_ARQOS[1] = \<const0> ;
  assign m_axi_sound_ARQOS[0] = \<const0> ;
  assign m_axi_sound_ARREGION[3] = \<const0> ;
  assign m_axi_sound_ARREGION[2] = \<const0> ;
  assign m_axi_sound_ARREGION[1] = \<const0> ;
  assign m_axi_sound_ARREGION[0] = \<const0> ;
  assign m_axi_sound_ARSIZE[2] = \<const0> ;
  assign m_axi_sound_ARSIZE[1] = \<const0> ;
  assign m_axi_sound_ARSIZE[0] = \<const0> ;
  assign m_axi_sound_ARUSER[0] = \<const0> ;
  assign m_axi_sound_ARVALID = \<const0> ;
  assign m_axi_sound_AWADDR[63] = \<const0> ;
  assign m_axi_sound_AWADDR[62] = \<const0> ;
  assign m_axi_sound_AWADDR[61] = \<const0> ;
  assign m_axi_sound_AWADDR[60] = \<const0> ;
  assign m_axi_sound_AWADDR[59] = \<const0> ;
  assign m_axi_sound_AWADDR[58] = \<const0> ;
  assign m_axi_sound_AWADDR[57] = \<const0> ;
  assign m_axi_sound_AWADDR[56] = \<const0> ;
  assign m_axi_sound_AWADDR[55] = \<const0> ;
  assign m_axi_sound_AWADDR[54] = \<const0> ;
  assign m_axi_sound_AWADDR[53] = \<const0> ;
  assign m_axi_sound_AWADDR[52] = \<const0> ;
  assign m_axi_sound_AWADDR[51] = \<const0> ;
  assign m_axi_sound_AWADDR[50] = \<const0> ;
  assign m_axi_sound_AWADDR[49] = \<const0> ;
  assign m_axi_sound_AWADDR[48] = \<const0> ;
  assign m_axi_sound_AWADDR[47] = \<const0> ;
  assign m_axi_sound_AWADDR[46] = \<const0> ;
  assign m_axi_sound_AWADDR[45] = \<const0> ;
  assign m_axi_sound_AWADDR[44] = \<const0> ;
  assign m_axi_sound_AWADDR[43] = \<const0> ;
  assign m_axi_sound_AWADDR[42] = \<const0> ;
  assign m_axi_sound_AWADDR[41] = \<const0> ;
  assign m_axi_sound_AWADDR[40] = \<const0> ;
  assign m_axi_sound_AWADDR[39] = \<const0> ;
  assign m_axi_sound_AWADDR[38] = \<const0> ;
  assign m_axi_sound_AWADDR[37] = \<const0> ;
  assign m_axi_sound_AWADDR[36] = \<const0> ;
  assign m_axi_sound_AWADDR[35] = \<const0> ;
  assign m_axi_sound_AWADDR[34] = \<const0> ;
  assign m_axi_sound_AWADDR[33] = \<const0> ;
  assign m_axi_sound_AWADDR[32] = \<const0> ;
  assign m_axi_sound_AWADDR[31] = \<const0> ;
  assign m_axi_sound_AWADDR[30] = \<const0> ;
  assign m_axi_sound_AWADDR[29] = \<const0> ;
  assign m_axi_sound_AWADDR[28] = \<const0> ;
  assign m_axi_sound_AWADDR[27] = \<const0> ;
  assign m_axi_sound_AWADDR[26] = \<const0> ;
  assign m_axi_sound_AWADDR[25] = \<const0> ;
  assign m_axi_sound_AWADDR[24] = \<const0> ;
  assign m_axi_sound_AWADDR[23] = \<const0> ;
  assign m_axi_sound_AWADDR[22] = \<const0> ;
  assign m_axi_sound_AWADDR[21] = \<const0> ;
  assign m_axi_sound_AWADDR[20] = \<const0> ;
  assign m_axi_sound_AWADDR[19] = \<const0> ;
  assign m_axi_sound_AWADDR[18] = \<const0> ;
  assign m_axi_sound_AWADDR[17] = \<const0> ;
  assign m_axi_sound_AWADDR[16] = \<const0> ;
  assign m_axi_sound_AWADDR[15] = \<const0> ;
  assign m_axi_sound_AWADDR[14] = \<const0> ;
  assign m_axi_sound_AWADDR[13] = \<const0> ;
  assign m_axi_sound_AWADDR[12] = \<const0> ;
  assign m_axi_sound_AWADDR[11] = \<const0> ;
  assign m_axi_sound_AWADDR[10] = \<const0> ;
  assign m_axi_sound_AWADDR[9] = \<const0> ;
  assign m_axi_sound_AWADDR[8] = \<const0> ;
  assign m_axi_sound_AWADDR[7] = \<const0> ;
  assign m_axi_sound_AWADDR[6] = \<const0> ;
  assign m_axi_sound_AWADDR[5] = \<const0> ;
  assign m_axi_sound_AWADDR[4] = \<const0> ;
  assign m_axi_sound_AWADDR[3] = \<const0> ;
  assign m_axi_sound_AWADDR[2] = \<const0> ;
  assign m_axi_sound_AWADDR[1] = \<const0> ;
  assign m_axi_sound_AWADDR[0] = \<const0> ;
  assign m_axi_sound_AWBURST[1] = \<const0> ;
  assign m_axi_sound_AWBURST[0] = \<const0> ;
  assign m_axi_sound_AWCACHE[3] = \<const0> ;
  assign m_axi_sound_AWCACHE[2] = \<const0> ;
  assign m_axi_sound_AWCACHE[1] = \<const0> ;
  assign m_axi_sound_AWCACHE[0] = \<const0> ;
  assign m_axi_sound_AWID[0] = \<const0> ;
  assign m_axi_sound_AWLEN[7] = \<const0> ;
  assign m_axi_sound_AWLEN[6] = \<const0> ;
  assign m_axi_sound_AWLEN[5] = \<const0> ;
  assign m_axi_sound_AWLEN[4] = \<const0> ;
  assign m_axi_sound_AWLEN[3] = \<const0> ;
  assign m_axi_sound_AWLEN[2] = \<const0> ;
  assign m_axi_sound_AWLEN[1] = \<const0> ;
  assign m_axi_sound_AWLEN[0] = \<const0> ;
  assign m_axi_sound_AWLOCK[1] = \<const0> ;
  assign m_axi_sound_AWLOCK[0] = \<const0> ;
  assign m_axi_sound_AWPROT[2] = \<const0> ;
  assign m_axi_sound_AWPROT[1] = \<const0> ;
  assign m_axi_sound_AWPROT[0] = \<const0> ;
  assign m_axi_sound_AWQOS[3] = \<const0> ;
  assign m_axi_sound_AWQOS[2] = \<const0> ;
  assign m_axi_sound_AWQOS[1] = \<const0> ;
  assign m_axi_sound_AWQOS[0] = \<const0> ;
  assign m_axi_sound_AWREGION[3] = \<const0> ;
  assign m_axi_sound_AWREGION[2] = \<const0> ;
  assign m_axi_sound_AWREGION[1] = \<const0> ;
  assign m_axi_sound_AWREGION[0] = \<const0> ;
  assign m_axi_sound_AWSIZE[2] = \<const0> ;
  assign m_axi_sound_AWSIZE[1] = \<const0> ;
  assign m_axi_sound_AWSIZE[0] = \<const0> ;
  assign m_axi_sound_AWUSER[0] = \<const0> ;
  assign m_axi_sound_AWVALID = \<const0> ;
  assign m_axi_sound_BREADY = \<const0> ;
  assign m_axi_sound_RREADY = \<const0> ;
  assign m_axi_sound_WDATA[31] = \<const0> ;
  assign m_axi_sound_WDATA[30] = \<const0> ;
  assign m_axi_sound_WDATA[29] = \<const0> ;
  assign m_axi_sound_WDATA[28] = \<const0> ;
  assign m_axi_sound_WDATA[27] = \<const0> ;
  assign m_axi_sound_WDATA[26] = \<const0> ;
  assign m_axi_sound_WDATA[25] = \<const0> ;
  assign m_axi_sound_WDATA[24] = \<const0> ;
  assign m_axi_sound_WDATA[23] = \<const0> ;
  assign m_axi_sound_WDATA[22] = \<const0> ;
  assign m_axi_sound_WDATA[21] = \<const0> ;
  assign m_axi_sound_WDATA[20] = \<const0> ;
  assign m_axi_sound_WDATA[19] = \<const0> ;
  assign m_axi_sound_WDATA[18] = \<const0> ;
  assign m_axi_sound_WDATA[17] = \<const0> ;
  assign m_axi_sound_WDATA[16] = \<const0> ;
  assign m_axi_sound_WDATA[15] = \<const0> ;
  assign m_axi_sound_WDATA[14] = \<const0> ;
  assign m_axi_sound_WDATA[13] = \<const0> ;
  assign m_axi_sound_WDATA[12] = \<const0> ;
  assign m_axi_sound_WDATA[11] = \<const0> ;
  assign m_axi_sound_WDATA[10] = \<const0> ;
  assign m_axi_sound_WDATA[9] = \<const0> ;
  assign m_axi_sound_WDATA[8] = \<const0> ;
  assign m_axi_sound_WDATA[7] = \<const0> ;
  assign m_axi_sound_WDATA[6] = \<const0> ;
  assign m_axi_sound_WDATA[5] = \<const0> ;
  assign m_axi_sound_WDATA[4] = \<const0> ;
  assign m_axi_sound_WDATA[3] = \<const0> ;
  assign m_axi_sound_WDATA[2] = \<const0> ;
  assign m_axi_sound_WDATA[1] = \<const0> ;
  assign m_axi_sound_WDATA[0] = \<const0> ;
  assign m_axi_sound_WID[0] = \<const0> ;
  assign m_axi_sound_WLAST = \<const0> ;
  assign m_axi_sound_WSTRB[3] = \<const0> ;
  assign m_axi_sound_WSTRB[2] = \<const0> ;
  assign m_axi_sound_WSTRB[1] = \<const0> ;
  assign m_axi_sound_WSTRB[0] = \<const0> ;
  assign m_axi_sound_WUSER[0] = \<const0> ;
  assign m_axi_sound_WVALID = \<const0> ;
  assign s_axi_control_BRESP[1] = \<const0> ;
  assign s_axi_control_BRESP[0] = \<const0> ;
  assign s_axi_control_RRESP[1] = \<const0> ;
  assign s_axi_control_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'h07)) 
    \ap_CS_fsm[0]_i_1 
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .I2(\ap_CS_fsm_reg_n_0_[1] ),
        .O(ap_NS_fsm));
  LUT2 #(
    .INIT(4'hB)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(ap_start),
        .I1(\ap_CS_fsm_reg_n_0_[0] ),
        .O(\ap_CS_fsm[1]_i_1_n_0 ));
  (* FSM_ENCODING = "none" *) 
  FDSE #(
    .INIT(1'b1)) 
    \ap_CS_fsm_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm),
        .Q(\ap_CS_fsm_reg_n_0_[0] ),
        .S(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm[1]_i_1_n_0 ),
        .Q(\ap_CS_fsm_reg_n_0_[1] ),
        .R(ap_rst_n_inv));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h2)) 
    ap_idle_INST_0
       (.I0(\ap_CS_fsm_reg_n_0_[0] ),
        .I1(ap_start),
        .O(ap_idle));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi control_s_axi_U
       (.\FSM_onehot_rstate_reg[1]_0 (s_axi_control_ARREADY),
        .\FSM_onehot_wstate_reg[1]_0 (s_axi_control_AWREADY),
        .\FSM_onehot_wstate_reg[2]_0 (s_axi_control_WREADY),
        .SR(ap_rst_n_inv),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .s_axi_control_ARADDR(s_axi_control_ARADDR),
        .s_axi_control_ARVALID(s_axi_control_ARVALID),
        .s_axi_control_AWADDR(s_axi_control_AWADDR),
        .s_axi_control_AWVALID(s_axi_control_AWVALID),
        .s_axi_control_BREADY(s_axi_control_BREADY),
        .s_axi_control_BVALID(s_axi_control_BVALID),
        .s_axi_control_RDATA(s_axi_control_RDATA),
        .s_axi_control_RREADY(s_axi_control_RREADY),
        .s_axi_control_RVALID(s_axi_control_RVALID),
        .s_axi_control_WDATA(s_axi_control_WDATA),
        .s_axi_control_WSTRB(s_axi_control_WSTRB),
        .s_axi_control_WVALID(s_axi_control_WVALID));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi
   (SR,
    \FSM_onehot_rstate_reg[1]_0 ,
    s_axi_control_BVALID,
    \FSM_onehot_wstate_reg[2]_0 ,
    \FSM_onehot_wstate_reg[1]_0 ,
    s_axi_control_RVALID,
    s_axi_control_RDATA,
    ap_rst_n,
    s_axi_control_ARVALID,
    s_axi_control_ARADDR,
    ap_clk,
    s_axi_control_AWADDR,
    s_axi_control_WVALID,
    s_axi_control_BREADY,
    s_axi_control_AWVALID,
    s_axi_control_RREADY,
    s_axi_control_WDATA,
    s_axi_control_WSTRB);
  output [0:0]SR;
  output \FSM_onehot_rstate_reg[1]_0 ;
  output s_axi_control_BVALID;
  output \FSM_onehot_wstate_reg[2]_0 ;
  output \FSM_onehot_wstate_reg[1]_0 ;
  output s_axi_control_RVALID;
  output [31:0]s_axi_control_RDATA;
  input ap_rst_n;
  input s_axi_control_ARVALID;
  input [5:0]s_axi_control_ARADDR;
  input ap_clk;
  input [5:0]s_axi_control_AWADDR;
  input s_axi_control_WVALID;
  input s_axi_control_BREADY;
  input s_axi_control_AWVALID;
  input s_axi_control_RREADY;
  input [31:0]s_axi_control_WDATA;
  input [3:0]s_axi_control_WSTRB;

  wire \FSM_onehot_rstate[1]_i_1_n_0 ;
  wire \FSM_onehot_rstate[2]_i_1_n_0 ;
  wire \FSM_onehot_rstate_reg[1]_0 ;
  wire \FSM_onehot_wstate[1]_i_2_n_0 ;
  wire \FSM_onehot_wstate[2]_i_1_n_0 ;
  wire \FSM_onehot_wstate[3]_i_1_n_0 ;
  wire \FSM_onehot_wstate_reg[1]_0 ;
  wire \FSM_onehot_wstate_reg[2]_0 ;
  wire [0:0]SR;
  wire ap_clk;
  wire ap_rst_n;
  wire int_len;
  wire [31:0]int_len0;
  wire \int_len_reg_n_0_[0] ;
  wire \int_len_reg_n_0_[10] ;
  wire \int_len_reg_n_0_[11] ;
  wire \int_len_reg_n_0_[12] ;
  wire \int_len_reg_n_0_[13] ;
  wire \int_len_reg_n_0_[14] ;
  wire \int_len_reg_n_0_[15] ;
  wire \int_len_reg_n_0_[16] ;
  wire \int_len_reg_n_0_[17] ;
  wire \int_len_reg_n_0_[18] ;
  wire \int_len_reg_n_0_[19] ;
  wire \int_len_reg_n_0_[1] ;
  wire \int_len_reg_n_0_[20] ;
  wire \int_len_reg_n_0_[21] ;
  wire \int_len_reg_n_0_[22] ;
  wire \int_len_reg_n_0_[23] ;
  wire \int_len_reg_n_0_[24] ;
  wire \int_len_reg_n_0_[25] ;
  wire \int_len_reg_n_0_[26] ;
  wire \int_len_reg_n_0_[27] ;
  wire \int_len_reg_n_0_[28] ;
  wire \int_len_reg_n_0_[29] ;
  wire \int_len_reg_n_0_[2] ;
  wire \int_len_reg_n_0_[30] ;
  wire \int_len_reg_n_0_[31] ;
  wire \int_len_reg_n_0_[3] ;
  wire \int_len_reg_n_0_[4] ;
  wire \int_len_reg_n_0_[5] ;
  wire \int_len_reg_n_0_[6] ;
  wire \int_len_reg_n_0_[7] ;
  wire \int_len_reg_n_0_[8] ;
  wire \int_len_reg_n_0_[9] ;
  wire int_ramadr;
  wire int_ramadr3_out;
  wire \int_ramadr[31]_i_3_n_0 ;
  wire [31:0]int_ramadr_reg0;
  wire [31:0]int_ramadr_reg02_out;
  wire \int_ramadr_reg_n_0_[0] ;
  wire \int_ramadr_reg_n_0_[10] ;
  wire \int_ramadr_reg_n_0_[11] ;
  wire \int_ramadr_reg_n_0_[12] ;
  wire \int_ramadr_reg_n_0_[13] ;
  wire \int_ramadr_reg_n_0_[14] ;
  wire \int_ramadr_reg_n_0_[15] ;
  wire \int_ramadr_reg_n_0_[16] ;
  wire \int_ramadr_reg_n_0_[17] ;
  wire \int_ramadr_reg_n_0_[18] ;
  wire \int_ramadr_reg_n_0_[19] ;
  wire \int_ramadr_reg_n_0_[1] ;
  wire \int_ramadr_reg_n_0_[20] ;
  wire \int_ramadr_reg_n_0_[21] ;
  wire \int_ramadr_reg_n_0_[22] ;
  wire \int_ramadr_reg_n_0_[23] ;
  wire \int_ramadr_reg_n_0_[24] ;
  wire \int_ramadr_reg_n_0_[25] ;
  wire \int_ramadr_reg_n_0_[26] ;
  wire \int_ramadr_reg_n_0_[27] ;
  wire \int_ramadr_reg_n_0_[28] ;
  wire \int_ramadr_reg_n_0_[29] ;
  wire \int_ramadr_reg_n_0_[2] ;
  wire \int_ramadr_reg_n_0_[30] ;
  wire \int_ramadr_reg_n_0_[31] ;
  wire \int_ramadr_reg_n_0_[32] ;
  wire \int_ramadr_reg_n_0_[33] ;
  wire \int_ramadr_reg_n_0_[34] ;
  wire \int_ramadr_reg_n_0_[35] ;
  wire \int_ramadr_reg_n_0_[36] ;
  wire \int_ramadr_reg_n_0_[37] ;
  wire \int_ramadr_reg_n_0_[38] ;
  wire \int_ramadr_reg_n_0_[39] ;
  wire \int_ramadr_reg_n_0_[3] ;
  wire \int_ramadr_reg_n_0_[40] ;
  wire \int_ramadr_reg_n_0_[41] ;
  wire \int_ramadr_reg_n_0_[42] ;
  wire \int_ramadr_reg_n_0_[43] ;
  wire \int_ramadr_reg_n_0_[44] ;
  wire \int_ramadr_reg_n_0_[45] ;
  wire \int_ramadr_reg_n_0_[46] ;
  wire \int_ramadr_reg_n_0_[47] ;
  wire \int_ramadr_reg_n_0_[48] ;
  wire \int_ramadr_reg_n_0_[49] ;
  wire \int_ramadr_reg_n_0_[4] ;
  wire \int_ramadr_reg_n_0_[50] ;
  wire \int_ramadr_reg_n_0_[51] ;
  wire \int_ramadr_reg_n_0_[52] ;
  wire \int_ramadr_reg_n_0_[53] ;
  wire \int_ramadr_reg_n_0_[54] ;
  wire \int_ramadr_reg_n_0_[55] ;
  wire \int_ramadr_reg_n_0_[56] ;
  wire \int_ramadr_reg_n_0_[57] ;
  wire \int_ramadr_reg_n_0_[58] ;
  wire \int_ramadr_reg_n_0_[59] ;
  wire \int_ramadr_reg_n_0_[5] ;
  wire \int_ramadr_reg_n_0_[60] ;
  wire \int_ramadr_reg_n_0_[61] ;
  wire \int_ramadr_reg_n_0_[62] ;
  wire \int_ramadr_reg_n_0_[63] ;
  wire \int_ramadr_reg_n_0_[6] ;
  wire \int_ramadr_reg_n_0_[7] ;
  wire \int_ramadr_reg_n_0_[8] ;
  wire \int_ramadr_reg_n_0_[9] ;
  wire rdata;
  wire \rdata[0]_i_1_n_0 ;
  wire \rdata[10]_i_1_n_0 ;
  wire \rdata[11]_i_1_n_0 ;
  wire \rdata[12]_i_1_n_0 ;
  wire \rdata[13]_i_1_n_0 ;
  wire \rdata[14]_i_1_n_0 ;
  wire \rdata[15]_i_1_n_0 ;
  wire \rdata[16]_i_1_n_0 ;
  wire \rdata[17]_i_1_n_0 ;
  wire \rdata[18]_i_1_n_0 ;
  wire \rdata[19]_i_1_n_0 ;
  wire \rdata[1]_i_1_n_0 ;
  wire \rdata[20]_i_1_n_0 ;
  wire \rdata[21]_i_1_n_0 ;
  wire \rdata[22]_i_1_n_0 ;
  wire \rdata[23]_i_1_n_0 ;
  wire \rdata[24]_i_1_n_0 ;
  wire \rdata[25]_i_1_n_0 ;
  wire \rdata[26]_i_1_n_0 ;
  wire \rdata[27]_i_1_n_0 ;
  wire \rdata[28]_i_1_n_0 ;
  wire \rdata[29]_i_1_n_0 ;
  wire \rdata[2]_i_1_n_0 ;
  wire \rdata[30]_i_1_n_0 ;
  wire \rdata[31]_i_1_n_0 ;
  wire \rdata[31]_i_3_n_0 ;
  wire \rdata[3]_i_1_n_0 ;
  wire \rdata[4]_i_1_n_0 ;
  wire \rdata[5]_i_1_n_0 ;
  wire \rdata[6]_i_1_n_0 ;
  wire \rdata[7]_i_1_n_0 ;
  wire \rdata[8]_i_1_n_0 ;
  wire \rdata[9]_i_1_n_0 ;
  wire [5:0]s_axi_control_ARADDR;
  wire s_axi_control_ARVALID;
  wire [5:0]s_axi_control_AWADDR;
  wire s_axi_control_AWVALID;
  wire s_axi_control_BREADY;
  wire s_axi_control_BVALID;
  wire [31:0]s_axi_control_RDATA;
  wire s_axi_control_RREADY;
  wire s_axi_control_RVALID;
  wire [31:0]s_axi_control_WDATA;
  wire [3:0]s_axi_control_WSTRB;
  wire s_axi_control_WVALID;
  wire waddr;
  wire \waddr_reg_n_0_[0] ;
  wire \waddr_reg_n_0_[1] ;
  wire \waddr_reg_n_0_[2] ;
  wire \waddr_reg_n_0_[3] ;
  wire \waddr_reg_n_0_[4] ;
  wire \waddr_reg_n_0_[5] ;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hF747)) 
    \FSM_onehot_rstate[1]_i_1 
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .I2(s_axi_control_RVALID),
        .I3(s_axi_control_RREADY),
        .O(\FSM_onehot_rstate[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_rstate[2]_i_1 
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .I2(s_axi_control_RREADY),
        .I3(s_axi_control_RVALID),
        .O(\FSM_onehot_rstate[2]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rstate_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_rstate[1]_i_1_n_0 ),
        .Q(\FSM_onehot_rstate_reg[1]_0 ),
        .R(SR));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rstate_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_rstate[2]_i_1_n_0 ),
        .Q(s_axi_control_RVALID),
        .R(SR));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_wstate[1]_i_1 
       (.I0(ap_rst_n),
        .O(SR));
  LUT5 #(
    .INIT(32'hFF1D0C1D)) 
    \FSM_onehot_wstate[1]_i_2 
       (.I0(\FSM_onehot_wstate_reg[2]_0 ),
        .I1(\FSM_onehot_wstate_reg[1]_0 ),
        .I2(s_axi_control_AWVALID),
        .I3(s_axi_control_BVALID),
        .I4(s_axi_control_BREADY),
        .O(\FSM_onehot_wstate[1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_wstate[2]_i_1 
       (.I0(s_axi_control_AWVALID),
        .I1(\FSM_onehot_wstate_reg[1]_0 ),
        .I2(s_axi_control_WVALID),
        .I3(\FSM_onehot_wstate_reg[2]_0 ),
        .O(\FSM_onehot_wstate[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h88F8)) 
    \FSM_onehot_wstate[3]_i_1 
       (.I0(s_axi_control_WVALID),
        .I1(\FSM_onehot_wstate_reg[2]_0 ),
        .I2(s_axi_control_BVALID),
        .I3(s_axi_control_BREADY),
        .O(\FSM_onehot_wstate[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[1]_i_2_n_0 ),
        .Q(\FSM_onehot_wstate_reg[1]_0 ),
        .R(SR));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[2]_i_1_n_0 ),
        .Q(\FSM_onehot_wstate_reg[2]_0 ),
        .R(SR));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[3]_i_1_n_0 ),
        .Q(s_axi_control_BVALID),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[0]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[0] ),
        .O(int_len0[0]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[10]_i_1 
       (.I0(s_axi_control_WDATA[10]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[10] ),
        .O(int_len0[10]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[11]_i_1 
       (.I0(s_axi_control_WDATA[11]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[11] ),
        .O(int_len0[11]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[12]_i_1 
       (.I0(s_axi_control_WDATA[12]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[12] ),
        .O(int_len0[12]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[13]_i_1 
       (.I0(s_axi_control_WDATA[13]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[13] ),
        .O(int_len0[13]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[14]_i_1 
       (.I0(s_axi_control_WDATA[14]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[14] ),
        .O(int_len0[14]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[15]_i_1 
       (.I0(s_axi_control_WDATA[15]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[15] ),
        .O(int_len0[15]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[16]_i_1 
       (.I0(s_axi_control_WDATA[16]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[16] ),
        .O(int_len0[16]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[17]_i_1 
       (.I0(s_axi_control_WDATA[17]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[17] ),
        .O(int_len0[17]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[18]_i_1 
       (.I0(s_axi_control_WDATA[18]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[18] ),
        .O(int_len0[18]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[19]_i_1 
       (.I0(s_axi_control_WDATA[19]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[19] ),
        .O(int_len0[19]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[1]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[1] ),
        .O(int_len0[1]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[20]_i_1 
       (.I0(s_axi_control_WDATA[20]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[20] ),
        .O(int_len0[20]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[21]_i_1 
       (.I0(s_axi_control_WDATA[21]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[21] ),
        .O(int_len0[21]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[22]_i_1 
       (.I0(s_axi_control_WDATA[22]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[22] ),
        .O(int_len0[22]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[23]_i_1 
       (.I0(s_axi_control_WDATA[23]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_len_reg_n_0_[23] ),
        .O(int_len0[23]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[24]_i_1 
       (.I0(s_axi_control_WDATA[24]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[24] ),
        .O(int_len0[24]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[25]_i_1 
       (.I0(s_axi_control_WDATA[25]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[25] ),
        .O(int_len0[25]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[26]_i_1 
       (.I0(s_axi_control_WDATA[26]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[26] ),
        .O(int_len0[26]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[27]_i_1 
       (.I0(s_axi_control_WDATA[27]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[27] ),
        .O(int_len0[27]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[28]_i_1 
       (.I0(s_axi_control_WDATA[28]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[28] ),
        .O(int_len0[28]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[29]_i_1 
       (.I0(s_axi_control_WDATA[29]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[29] ),
        .O(int_len0[29]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[2]_i_1 
       (.I0(s_axi_control_WDATA[2]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[2] ),
        .O(int_len0[2]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[30]_i_1 
       (.I0(s_axi_control_WDATA[30]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[30] ),
        .O(int_len0[30]));
  LUT5 #(
    .INIT(32'h80000000)) 
    \int_len[31]_i_1 
       (.I0(\FSM_onehot_wstate_reg[2]_0 ),
        .I1(s_axi_control_WVALID),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(\waddr_reg_n_0_[3] ),
        .I4(\int_ramadr[31]_i_3_n_0 ),
        .O(int_len));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[31]_i_2 
       (.I0(s_axi_control_WDATA[31]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_len_reg_n_0_[31] ),
        .O(int_len0[31]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[3]_i_1 
       (.I0(s_axi_control_WDATA[3]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[3] ),
        .O(int_len0[3]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[4]_i_1 
       (.I0(s_axi_control_WDATA[4]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[4] ),
        .O(int_len0[4]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[5]_i_1 
       (.I0(s_axi_control_WDATA[5]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[5] ),
        .O(int_len0[5]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[6]_i_1 
       (.I0(s_axi_control_WDATA[6]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[6] ),
        .O(int_len0[6]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[7]_i_1 
       (.I0(s_axi_control_WDATA[7]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_len_reg_n_0_[7] ),
        .O(int_len0[7]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[8]_i_1 
       (.I0(s_axi_control_WDATA[8]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[8] ),
        .O(int_len0[8]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_len[9]_i_1 
       (.I0(s_axi_control_WDATA[9]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_len_reg_n_0_[9] ),
        .O(int_len0[9]));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[0] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[0]),
        .Q(\int_len_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[10] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[10]),
        .Q(\int_len_reg_n_0_[10] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[11] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[11]),
        .Q(\int_len_reg_n_0_[11] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[12] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[12]),
        .Q(\int_len_reg_n_0_[12] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[13] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[13]),
        .Q(\int_len_reg_n_0_[13] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[14] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[14]),
        .Q(\int_len_reg_n_0_[14] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[15] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[15]),
        .Q(\int_len_reg_n_0_[15] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[16] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[16]),
        .Q(\int_len_reg_n_0_[16] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[17] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[17]),
        .Q(\int_len_reg_n_0_[17] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[18] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[18]),
        .Q(\int_len_reg_n_0_[18] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[19] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[19]),
        .Q(\int_len_reg_n_0_[19] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[1] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[1]),
        .Q(\int_len_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[20] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[20]),
        .Q(\int_len_reg_n_0_[20] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[21] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[21]),
        .Q(\int_len_reg_n_0_[21] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[22] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[22]),
        .Q(\int_len_reg_n_0_[22] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[23] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[23]),
        .Q(\int_len_reg_n_0_[23] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[24] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[24]),
        .Q(\int_len_reg_n_0_[24] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[25] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[25]),
        .Q(\int_len_reg_n_0_[25] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[26] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[26]),
        .Q(\int_len_reg_n_0_[26] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[27] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[27]),
        .Q(\int_len_reg_n_0_[27] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[28] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[28]),
        .Q(\int_len_reg_n_0_[28] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[29] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[29]),
        .Q(\int_len_reg_n_0_[29] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[2] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[2]),
        .Q(\int_len_reg_n_0_[2] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[30] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[30]),
        .Q(\int_len_reg_n_0_[30] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[31] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[31]),
        .Q(\int_len_reg_n_0_[31] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[3] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[3]),
        .Q(\int_len_reg_n_0_[3] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[4] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[4]),
        .Q(\int_len_reg_n_0_[4] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[5] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[5]),
        .Q(\int_len_reg_n_0_[5] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[6] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[6]),
        .Q(\int_len_reg_n_0_[6] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[7] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[7]),
        .Q(\int_len_reg_n_0_[7] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[8] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[8]),
        .Q(\int_len_reg_n_0_[8] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_len_reg[9] 
       (.C(ap_clk),
        .CE(int_len),
        .D(int_len0[9]),
        .Q(\int_len_reg_n_0_[9] ),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[0]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[0] ),
        .O(int_ramadr_reg02_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[10]_i_1 
       (.I0(s_axi_control_WDATA[10]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[10] ),
        .O(int_ramadr_reg02_out[10]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[11]_i_1 
       (.I0(s_axi_control_WDATA[11]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[11] ),
        .O(int_ramadr_reg02_out[11]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[12]_i_1 
       (.I0(s_axi_control_WDATA[12]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[12] ),
        .O(int_ramadr_reg02_out[12]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[13]_i_1 
       (.I0(s_axi_control_WDATA[13]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[13] ),
        .O(int_ramadr_reg02_out[13]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[14]_i_1 
       (.I0(s_axi_control_WDATA[14]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[14] ),
        .O(int_ramadr_reg02_out[14]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[15]_i_1 
       (.I0(s_axi_control_WDATA[15]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[15] ),
        .O(int_ramadr_reg02_out[15]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[16]_i_1 
       (.I0(s_axi_control_WDATA[16]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[16] ),
        .O(int_ramadr_reg02_out[16]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[17]_i_1 
       (.I0(s_axi_control_WDATA[17]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[17] ),
        .O(int_ramadr_reg02_out[17]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[18]_i_1 
       (.I0(s_axi_control_WDATA[18]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[18] ),
        .O(int_ramadr_reg02_out[18]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[19]_i_1 
       (.I0(s_axi_control_WDATA[19]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[19] ),
        .O(int_ramadr_reg02_out[19]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[1]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[1] ),
        .O(int_ramadr_reg02_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[20]_i_1 
       (.I0(s_axi_control_WDATA[20]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[20] ),
        .O(int_ramadr_reg02_out[20]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[21]_i_1 
       (.I0(s_axi_control_WDATA[21]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[21] ),
        .O(int_ramadr_reg02_out[21]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[22]_i_1 
       (.I0(s_axi_control_WDATA[22]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[22] ),
        .O(int_ramadr_reg02_out[22]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[23]_i_1 
       (.I0(s_axi_control_WDATA[23]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[23] ),
        .O(int_ramadr_reg02_out[23]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[24]_i_1 
       (.I0(s_axi_control_WDATA[24]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[24] ),
        .O(int_ramadr_reg02_out[24]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[25]_i_1 
       (.I0(s_axi_control_WDATA[25]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[25] ),
        .O(int_ramadr_reg02_out[25]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[26]_i_1 
       (.I0(s_axi_control_WDATA[26]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[26] ),
        .O(int_ramadr_reg02_out[26]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[27]_i_1 
       (.I0(s_axi_control_WDATA[27]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[27] ),
        .O(int_ramadr_reg02_out[27]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[28]_i_1 
       (.I0(s_axi_control_WDATA[28]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[28] ),
        .O(int_ramadr_reg02_out[28]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[29]_i_1 
       (.I0(s_axi_control_WDATA[29]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[29] ),
        .O(int_ramadr_reg02_out[29]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[2]_i_1 
       (.I0(s_axi_control_WDATA[2]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[2] ),
        .O(int_ramadr_reg02_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[30]_i_1 
       (.I0(s_axi_control_WDATA[30]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[30] ),
        .O(int_ramadr_reg02_out[30]));
  LUT5 #(
    .INIT(32'h00080000)) 
    \int_ramadr[31]_i_1 
       (.I0(\FSM_onehot_wstate_reg[2]_0 ),
        .I1(s_axi_control_WVALID),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(\waddr_reg_n_0_[3] ),
        .I4(\int_ramadr[31]_i_3_n_0 ),
        .O(int_ramadr3_out));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[31]_i_2 
       (.I0(s_axi_control_WDATA[31]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[31] ),
        .O(int_ramadr_reg02_out[31]));
  LUT4 #(
    .INIT(16'h0100)) 
    \int_ramadr[31]_i_3 
       (.I0(\waddr_reg_n_0_[1] ),
        .I1(\waddr_reg_n_0_[0] ),
        .I2(\waddr_reg_n_0_[5] ),
        .I3(\waddr_reg_n_0_[4] ),
        .O(\int_ramadr[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[32]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[32] ),
        .O(int_ramadr_reg0[0]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[33]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[33] ),
        .O(int_ramadr_reg0[1]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[34]_i_1 
       (.I0(s_axi_control_WDATA[2]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[34] ),
        .O(int_ramadr_reg0[2]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[35]_i_1 
       (.I0(s_axi_control_WDATA[3]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[35] ),
        .O(int_ramadr_reg0[3]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[36]_i_1 
       (.I0(s_axi_control_WDATA[4]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[36] ),
        .O(int_ramadr_reg0[4]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[37]_i_1 
       (.I0(s_axi_control_WDATA[5]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[37] ),
        .O(int_ramadr_reg0[5]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[38]_i_1 
       (.I0(s_axi_control_WDATA[6]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[38] ),
        .O(int_ramadr_reg0[6]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[39]_i_1 
       (.I0(s_axi_control_WDATA[7]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[39] ),
        .O(int_ramadr_reg0[7]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[3]_i_1 
       (.I0(s_axi_control_WDATA[3]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[3] ),
        .O(int_ramadr_reg02_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[40]_i_1 
       (.I0(s_axi_control_WDATA[8]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[40] ),
        .O(int_ramadr_reg0[8]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[41]_i_1 
       (.I0(s_axi_control_WDATA[9]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[41] ),
        .O(int_ramadr_reg0[9]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[42]_i_1 
       (.I0(s_axi_control_WDATA[10]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[42] ),
        .O(int_ramadr_reg0[10]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[43]_i_1 
       (.I0(s_axi_control_WDATA[11]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[43] ),
        .O(int_ramadr_reg0[11]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[44]_i_1 
       (.I0(s_axi_control_WDATA[12]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[44] ),
        .O(int_ramadr_reg0[12]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[45]_i_1 
       (.I0(s_axi_control_WDATA[13]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[45] ),
        .O(int_ramadr_reg0[13]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[46]_i_1 
       (.I0(s_axi_control_WDATA[14]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[46] ),
        .O(int_ramadr_reg0[14]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[47]_i_1 
       (.I0(s_axi_control_WDATA[15]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[47] ),
        .O(int_ramadr_reg0[15]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[48]_i_1 
       (.I0(s_axi_control_WDATA[16]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[48] ),
        .O(int_ramadr_reg0[16]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[49]_i_1 
       (.I0(s_axi_control_WDATA[17]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[49] ),
        .O(int_ramadr_reg0[17]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[4]_i_1 
       (.I0(s_axi_control_WDATA[4]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[4] ),
        .O(int_ramadr_reg02_out[4]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[50]_i_1 
       (.I0(s_axi_control_WDATA[18]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[50] ),
        .O(int_ramadr_reg0[18]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[51]_i_1 
       (.I0(s_axi_control_WDATA[19]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[51] ),
        .O(int_ramadr_reg0[19]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[52]_i_1 
       (.I0(s_axi_control_WDATA[20]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[52] ),
        .O(int_ramadr_reg0[20]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[53]_i_1 
       (.I0(s_axi_control_WDATA[21]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[53] ),
        .O(int_ramadr_reg0[21]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[54]_i_1 
       (.I0(s_axi_control_WDATA[22]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[54] ),
        .O(int_ramadr_reg0[22]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[55]_i_1 
       (.I0(s_axi_control_WDATA[23]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(\int_ramadr_reg_n_0_[55] ),
        .O(int_ramadr_reg0[23]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[56]_i_1 
       (.I0(s_axi_control_WDATA[24]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[56] ),
        .O(int_ramadr_reg0[24]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[57]_i_1 
       (.I0(s_axi_control_WDATA[25]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[57] ),
        .O(int_ramadr_reg0[25]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[58]_i_1 
       (.I0(s_axi_control_WDATA[26]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[58] ),
        .O(int_ramadr_reg0[26]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[59]_i_1 
       (.I0(s_axi_control_WDATA[27]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[59] ),
        .O(int_ramadr_reg0[27]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[5]_i_1 
       (.I0(s_axi_control_WDATA[5]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[5] ),
        .O(int_ramadr_reg02_out[5]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[60]_i_1 
       (.I0(s_axi_control_WDATA[28]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[60] ),
        .O(int_ramadr_reg0[28]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[61]_i_1 
       (.I0(s_axi_control_WDATA[29]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[61] ),
        .O(int_ramadr_reg0[29]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[62]_i_1 
       (.I0(s_axi_control_WDATA[30]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[62] ),
        .O(int_ramadr_reg0[30]));
  LUT5 #(
    .INIT(32'h00800000)) 
    \int_ramadr[63]_i_1 
       (.I0(\FSM_onehot_wstate_reg[2]_0 ),
        .I1(s_axi_control_WVALID),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(\waddr_reg_n_0_[3] ),
        .I4(\int_ramadr[31]_i_3_n_0 ),
        .O(int_ramadr));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[63]_i_2 
       (.I0(s_axi_control_WDATA[31]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(\int_ramadr_reg_n_0_[63] ),
        .O(int_ramadr_reg0[31]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[6]_i_1 
       (.I0(s_axi_control_WDATA[6]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[6] ),
        .O(int_ramadr_reg02_out[6]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[7]_i_1 
       (.I0(s_axi_control_WDATA[7]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ramadr_reg_n_0_[7] ),
        .O(int_ramadr_reg02_out[7]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[8]_i_1 
       (.I0(s_axi_control_WDATA[8]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[8] ),
        .O(int_ramadr_reg02_out[8]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[9]_i_1 
       (.I0(s_axi_control_WDATA[9]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(\int_ramadr_reg_n_0_[9] ),
        .O(int_ramadr_reg02_out[9]));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[0] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[0]),
        .Q(\int_ramadr_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[10] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[10]),
        .Q(\int_ramadr_reg_n_0_[10] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[11] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[11]),
        .Q(\int_ramadr_reg_n_0_[11] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[12] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[12]),
        .Q(\int_ramadr_reg_n_0_[12] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[13] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[13]),
        .Q(\int_ramadr_reg_n_0_[13] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[14] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[14]),
        .Q(\int_ramadr_reg_n_0_[14] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[15] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[15]),
        .Q(\int_ramadr_reg_n_0_[15] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[16] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[16]),
        .Q(\int_ramadr_reg_n_0_[16] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[17] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[17]),
        .Q(\int_ramadr_reg_n_0_[17] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[18] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[18]),
        .Q(\int_ramadr_reg_n_0_[18] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[19] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[19]),
        .Q(\int_ramadr_reg_n_0_[19] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[1] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[1]),
        .Q(\int_ramadr_reg_n_0_[1] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[20] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[20]),
        .Q(\int_ramadr_reg_n_0_[20] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[21] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[21]),
        .Q(\int_ramadr_reg_n_0_[21] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[22] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[22]),
        .Q(\int_ramadr_reg_n_0_[22] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[23] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[23]),
        .Q(\int_ramadr_reg_n_0_[23] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[24] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[24]),
        .Q(\int_ramadr_reg_n_0_[24] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[25] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[25]),
        .Q(\int_ramadr_reg_n_0_[25] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[26] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[26]),
        .Q(\int_ramadr_reg_n_0_[26] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[27] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[27]),
        .Q(\int_ramadr_reg_n_0_[27] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[28] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[28]),
        .Q(\int_ramadr_reg_n_0_[28] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[29] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[29]),
        .Q(\int_ramadr_reg_n_0_[29] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[2] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[2]),
        .Q(\int_ramadr_reg_n_0_[2] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[30] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[30]),
        .Q(\int_ramadr_reg_n_0_[30] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[31] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[31]),
        .Q(\int_ramadr_reg_n_0_[31] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[32] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[0]),
        .Q(\int_ramadr_reg_n_0_[32] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[33] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[1]),
        .Q(\int_ramadr_reg_n_0_[33] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[34] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[2]),
        .Q(\int_ramadr_reg_n_0_[34] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[35] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[3]),
        .Q(\int_ramadr_reg_n_0_[35] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[36] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[4]),
        .Q(\int_ramadr_reg_n_0_[36] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[37] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[5]),
        .Q(\int_ramadr_reg_n_0_[37] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[38] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[6]),
        .Q(\int_ramadr_reg_n_0_[38] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[39] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[7]),
        .Q(\int_ramadr_reg_n_0_[39] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[3] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[3]),
        .Q(\int_ramadr_reg_n_0_[3] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[40] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[8]),
        .Q(\int_ramadr_reg_n_0_[40] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[41] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[9]),
        .Q(\int_ramadr_reg_n_0_[41] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[42] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[10]),
        .Q(\int_ramadr_reg_n_0_[42] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[43] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[11]),
        .Q(\int_ramadr_reg_n_0_[43] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[44] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[12]),
        .Q(\int_ramadr_reg_n_0_[44] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[45] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[13]),
        .Q(\int_ramadr_reg_n_0_[45] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[46] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[14]),
        .Q(\int_ramadr_reg_n_0_[46] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[47] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[15]),
        .Q(\int_ramadr_reg_n_0_[47] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[48] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[16]),
        .Q(\int_ramadr_reg_n_0_[48] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[49] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[17]),
        .Q(\int_ramadr_reg_n_0_[49] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[4] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[4]),
        .Q(\int_ramadr_reg_n_0_[4] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[50] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[18]),
        .Q(\int_ramadr_reg_n_0_[50] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[51] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[19]),
        .Q(\int_ramadr_reg_n_0_[51] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[52] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[20]),
        .Q(\int_ramadr_reg_n_0_[52] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[53] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[21]),
        .Q(\int_ramadr_reg_n_0_[53] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[54] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[22]),
        .Q(\int_ramadr_reg_n_0_[54] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[55] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[23]),
        .Q(\int_ramadr_reg_n_0_[55] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[56] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[24]),
        .Q(\int_ramadr_reg_n_0_[56] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[57] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[25]),
        .Q(\int_ramadr_reg_n_0_[57] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[58] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[26]),
        .Q(\int_ramadr_reg_n_0_[58] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[59] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[27]),
        .Q(\int_ramadr_reg_n_0_[59] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[5] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[5]),
        .Q(\int_ramadr_reg_n_0_[5] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[60] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[28]),
        .Q(\int_ramadr_reg_n_0_[60] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[61] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[29]),
        .Q(\int_ramadr_reg_n_0_[61] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[62] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[30]),
        .Q(\int_ramadr_reg_n_0_[62] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[63] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[31]),
        .Q(\int_ramadr_reg_n_0_[63] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[6] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[6]),
        .Q(\int_ramadr_reg_n_0_[6] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[7] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[7]),
        .Q(\int_ramadr_reg_n_0_[7] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[8] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[8]),
        .Q(\int_ramadr_reg_n_0_[8] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[9] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[9]),
        .Q(\int_ramadr_reg_n_0_[9] ),
        .R(SR));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[0]_i_1 
       (.I0(\int_ramadr_reg_n_0_[0] ),
        .I1(\int_ramadr_reg_n_0_[32] ),
        .I2(\int_len_reg_n_0_[0] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[10]_i_1 
       (.I0(\int_ramadr_reg_n_0_[10] ),
        .I1(\int_ramadr_reg_n_0_[42] ),
        .I2(\int_len_reg_n_0_[10] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[11]_i_1 
       (.I0(\int_ramadr_reg_n_0_[11] ),
        .I1(\int_ramadr_reg_n_0_[43] ),
        .I2(\int_len_reg_n_0_[11] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[12]_i_1 
       (.I0(\int_ramadr_reg_n_0_[12] ),
        .I1(\int_ramadr_reg_n_0_[44] ),
        .I2(\int_len_reg_n_0_[12] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[13]_i_1 
       (.I0(\int_ramadr_reg_n_0_[13] ),
        .I1(\int_ramadr_reg_n_0_[45] ),
        .I2(\int_len_reg_n_0_[13] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[14]_i_1 
       (.I0(\int_ramadr_reg_n_0_[14] ),
        .I1(\int_ramadr_reg_n_0_[46] ),
        .I2(\int_len_reg_n_0_[14] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[15]_i_1 
       (.I0(\int_ramadr_reg_n_0_[15] ),
        .I1(\int_ramadr_reg_n_0_[47] ),
        .I2(\int_len_reg_n_0_[15] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[16]_i_1 
       (.I0(\int_ramadr_reg_n_0_[16] ),
        .I1(\int_ramadr_reg_n_0_[48] ),
        .I2(\int_len_reg_n_0_[16] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[17]_i_1 
       (.I0(\int_ramadr_reg_n_0_[17] ),
        .I1(\int_ramadr_reg_n_0_[49] ),
        .I2(\int_len_reg_n_0_[17] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[18]_i_1 
       (.I0(\int_ramadr_reg_n_0_[18] ),
        .I1(\int_ramadr_reg_n_0_[50] ),
        .I2(\int_len_reg_n_0_[18] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[19]_i_1 
       (.I0(\int_ramadr_reg_n_0_[19] ),
        .I1(\int_ramadr_reg_n_0_[51] ),
        .I2(\int_len_reg_n_0_[19] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[1]_i_1 
       (.I0(\int_ramadr_reg_n_0_[1] ),
        .I1(\int_ramadr_reg_n_0_[33] ),
        .I2(\int_len_reg_n_0_[1] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[20]_i_1 
       (.I0(\int_ramadr_reg_n_0_[20] ),
        .I1(\int_ramadr_reg_n_0_[52] ),
        .I2(\int_len_reg_n_0_[20] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[21]_i_1 
       (.I0(\int_ramadr_reg_n_0_[21] ),
        .I1(\int_ramadr_reg_n_0_[53] ),
        .I2(\int_len_reg_n_0_[21] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[22]_i_1 
       (.I0(\int_ramadr_reg_n_0_[22] ),
        .I1(\int_ramadr_reg_n_0_[54] ),
        .I2(\int_len_reg_n_0_[22] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[23]_i_1 
       (.I0(\int_ramadr_reg_n_0_[23] ),
        .I1(\int_ramadr_reg_n_0_[55] ),
        .I2(\int_len_reg_n_0_[23] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[24]_i_1 
       (.I0(\int_ramadr_reg_n_0_[24] ),
        .I1(\int_ramadr_reg_n_0_[56] ),
        .I2(\int_len_reg_n_0_[24] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[25]_i_1 
       (.I0(\int_ramadr_reg_n_0_[25] ),
        .I1(\int_ramadr_reg_n_0_[57] ),
        .I2(\int_len_reg_n_0_[25] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[26]_i_1 
       (.I0(\int_ramadr_reg_n_0_[26] ),
        .I1(\int_ramadr_reg_n_0_[58] ),
        .I2(\int_len_reg_n_0_[26] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[27]_i_1 
       (.I0(\int_ramadr_reg_n_0_[27] ),
        .I1(\int_ramadr_reg_n_0_[59] ),
        .I2(\int_len_reg_n_0_[27] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[28]_i_1 
       (.I0(\int_ramadr_reg_n_0_[28] ),
        .I1(\int_ramadr_reg_n_0_[60] ),
        .I2(\int_len_reg_n_0_[28] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[29]_i_1 
       (.I0(\int_ramadr_reg_n_0_[29] ),
        .I1(\int_ramadr_reg_n_0_[61] ),
        .I2(\int_len_reg_n_0_[29] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[2]_i_1 
       (.I0(\int_ramadr_reg_n_0_[2] ),
        .I1(\int_ramadr_reg_n_0_[34] ),
        .I2(\int_len_reg_n_0_[2] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[30]_i_1 
       (.I0(\int_ramadr_reg_n_0_[30] ),
        .I1(\int_ramadr_reg_n_0_[62] ),
        .I2(\int_len_reg_n_0_[30] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8888888888888088)) 
    \rdata[31]_i_1 
       (.I0(\FSM_onehot_rstate_reg[1]_0 ),
        .I1(s_axi_control_ARVALID),
        .I2(s_axi_control_ARADDR[1]),
        .I3(s_axi_control_ARADDR[4]),
        .I4(s_axi_control_ARADDR[5]),
        .I5(s_axi_control_ARADDR[0]),
        .O(\rdata[31]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \rdata[31]_i_2 
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .O(rdata));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[31]_i_3 
       (.I0(\int_ramadr_reg_n_0_[31] ),
        .I1(\int_ramadr_reg_n_0_[63] ),
        .I2(\int_len_reg_n_0_[31] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[3]_i_1 
       (.I0(\int_ramadr_reg_n_0_[3] ),
        .I1(\int_ramadr_reg_n_0_[35] ),
        .I2(\int_len_reg_n_0_[3] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[4]_i_1 
       (.I0(\int_ramadr_reg_n_0_[4] ),
        .I1(\int_ramadr_reg_n_0_[36] ),
        .I2(\int_len_reg_n_0_[4] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[5]_i_1 
       (.I0(\int_ramadr_reg_n_0_[5] ),
        .I1(\int_ramadr_reg_n_0_[37] ),
        .I2(\int_len_reg_n_0_[5] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[6]_i_1 
       (.I0(\int_ramadr_reg_n_0_[6] ),
        .I1(\int_ramadr_reg_n_0_[38] ),
        .I2(\int_len_reg_n_0_[6] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[7]_i_1 
       (.I0(\int_ramadr_reg_n_0_[7] ),
        .I1(\int_ramadr_reg_n_0_[39] ),
        .I2(\int_len_reg_n_0_[7] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[8]_i_1 
       (.I0(\int_ramadr_reg_n_0_[8] ),
        .I1(\int_ramadr_reg_n_0_[40] ),
        .I2(\int_len_reg_n_0_[8] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[9]_i_1 
       (.I0(\int_ramadr_reg_n_0_[9] ),
        .I1(\int_ramadr_reg_n_0_[41] ),
        .I2(\int_len_reg_n_0_[9] ),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[9]_i_1_n_0 ));
  FDRE \rdata_reg[0] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[0]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[0]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[10] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[10]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[10]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[11] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[11]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[11]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[12] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[12]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[12]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[13] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[13]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[13]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[14] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[14]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[14]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[15] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[15]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[15]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[16] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[16]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[16]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[17] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[17]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[17]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[18] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[18]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[18]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[19] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[19]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[19]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[1] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[1]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[1]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[20] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[20]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[20]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[21] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[21]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[21]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[22] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[22]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[22]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[23] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[23]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[23]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[24] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[24]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[24]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[25] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[25]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[25]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[26] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[26]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[26]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[27] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[27]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[27]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[28] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[28]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[28]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[29] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[29]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[29]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[2] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[2]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[2]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[30] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[30]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[30]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[31] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[31]_i_3_n_0 ),
        .Q(s_axi_control_RDATA[31]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[3] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[3]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[3]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[4] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[4]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[4]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[5] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[5]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[5]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[6] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[6]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[6]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[7] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[7]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[7]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[8] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[8]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[8]),
        .R(\rdata[31]_i_1_n_0 ));
  FDRE \rdata_reg[9] 
       (.C(ap_clk),
        .CE(rdata),
        .D(\rdata[9]_i_1_n_0 ),
        .Q(s_axi_control_RDATA[9]),
        .R(\rdata[31]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \waddr[5]_i_1 
       (.I0(\FSM_onehot_wstate_reg[1]_0 ),
        .I1(s_axi_control_AWVALID),
        .O(waddr));
  FDRE \waddr_reg[0] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_control_AWADDR[0]),
        .Q(\waddr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \waddr_reg[1] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_control_AWADDR[1]),
        .Q(\waddr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \waddr_reg[2] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_control_AWADDR[2]),
        .Q(\waddr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \waddr_reg[3] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_control_AWADDR[3]),
        .Q(\waddr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \waddr_reg[4] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_control_AWADDR[4]),
        .Q(\waddr_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \waddr_reg[5] 
       (.C(ap_clk),
        .CE(waddr),
        .D(s_axi_control_AWADDR[5]),
        .Q(\waddr_reg_n_0_[5] ),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
