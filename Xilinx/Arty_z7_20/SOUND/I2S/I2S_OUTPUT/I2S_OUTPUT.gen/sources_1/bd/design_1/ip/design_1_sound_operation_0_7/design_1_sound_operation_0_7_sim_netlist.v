// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue May 11 08:55:58 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.gen/sources_1/bd/design_1/ip/design_1_sound_operation_0_7/design_1_sound_operation_0_7_sim_netlist.v
// Design      : design_1_sound_operation_0_7
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_sound_operation_0_7,sound_operation,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "HLS" *) 
(* X_CORE_INFO = "sound_operation,Vivado 2020.2" *) (* hls_module = "yes" *) 
(* NotValidForBitStream *)
module design_1_sound_operation_0_7
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
    m_axi_ram_AWADDR,
    m_axi_ram_AWLEN,
    m_axi_ram_AWSIZE,
    m_axi_ram_AWBURST,
    m_axi_ram_AWLOCK,
    m_axi_ram_AWREGION,
    m_axi_ram_AWCACHE,
    m_axi_ram_AWPROT,
    m_axi_ram_AWQOS,
    m_axi_ram_AWVALID,
    m_axi_ram_AWREADY,
    m_axi_ram_WDATA,
    m_axi_ram_WSTRB,
    m_axi_ram_WLAST,
    m_axi_ram_WVALID,
    m_axi_ram_WREADY,
    m_axi_ram_BRESP,
    m_axi_ram_BVALID,
    m_axi_ram_BREADY,
    m_axi_ram_ARADDR,
    m_axi_ram_ARLEN,
    m_axi_ram_ARSIZE,
    m_axi_ram_ARBURST,
    m_axi_ram_ARLOCK,
    m_axi_ram_ARREGION,
    m_axi_ram_ARCACHE,
    m_axi_ram_ARPROT,
    m_axi_ram_ARQOS,
    m_axi_ram_ARVALID,
    m_axi_ram_ARREADY,
    m_axi_ram_RDATA,
    m_axi_ram_RRESP,
    m_axi_ram_RLAST,
    m_axi_ram_RVALID,
    m_axi_ram_RREADY,
    sdata,
    opeout,
    count);
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s_axi_control_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:m_axi_ram, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWADDR" *) output [63:0]m_axi_ram_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWLEN" *) output [7:0]m_axi_ram_AWLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWSIZE" *) output [2:0]m_axi_ram_AWSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWBURST" *) output [1:0]m_axi_ram_AWBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWLOCK" *) output [1:0]m_axi_ram_AWLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWREGION" *) output [3:0]m_axi_ram_AWREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWCACHE" *) output [3:0]m_axi_ram_AWCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWPROT" *) output [2:0]m_axi_ram_AWPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWQOS" *) output [3:0]m_axi_ram_AWQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWVALID" *) output m_axi_ram_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram AWREADY" *) input m_axi_ram_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram WDATA" *) output [31:0]m_axi_ram_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram WSTRB" *) output [3:0]m_axi_ram_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram WLAST" *) output m_axi_ram_WLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram WVALID" *) output m_axi_ram_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram WREADY" *) input m_axi_ram_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram BRESP" *) input [1:0]m_axi_ram_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram BVALID" *) input m_axi_ram_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram BREADY" *) output m_axi_ram_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARADDR" *) output [63:0]m_axi_ram_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARLEN" *) output [7:0]m_axi_ram_ARLEN;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARSIZE" *) output [2:0]m_axi_ram_ARSIZE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARBURST" *) output [1:0]m_axi_ram_ARBURST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARLOCK" *) output [1:0]m_axi_ram_ARLOCK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARREGION" *) output [3:0]m_axi_ram_ARREGION;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARCACHE" *) output [3:0]m_axi_ram_ARCACHE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARPROT" *) output [2:0]m_axi_ram_ARPROT;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARQOS" *) output [3:0]m_axi_ram_ARQOS;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARVALID" *) output m_axi_ram_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram ARREADY" *) input m_axi_ram_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram RDATA" *) input [31:0]m_axi_ram_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram RRESP" *) input [1:0]m_axi_ram_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram RLAST" *) input m_axi_ram_RLAST;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram RVALID" *) input m_axi_ram_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi_ram RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axi_ram, ADDR_WIDTH 64, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 32, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) output m_axi_ram_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 sdata DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME sdata, LAYERED_METADATA undef" *) output [31:0]sdata;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 opeout DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME opeout, LAYERED_METADATA undef" *) output [31:0]opeout;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 count DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME count, LAYERED_METADATA undef" *) input [31:0]count;

  wire \<const0> ;
  wire \<const1> ;
  wire ap_clk;
  wire ap_rst_n;
  wire [31:0]count;
  wire [63:2]\^m_axi_ram_ARADDR ;
  wire [4:0]\^m_axi_ram_ARLEN ;
  wire m_axi_ram_ARREADY;
  wire m_axi_ram_ARVALID;
  wire [31:0]m_axi_ram_RDATA;
  wire m_axi_ram_RLAST;
  wire m_axi_ram_RREADY;
  wire [1:0]m_axi_ram_RRESP;
  wire m_axi_ram_RVALID;
  wire [31:0]opeout;
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
  wire [31:0]sdata;
  wire NLW_inst_m_axi_ram_AWVALID_UNCONNECTED;
  wire NLW_inst_m_axi_ram_BREADY_UNCONNECTED;
  wire NLW_inst_m_axi_ram_WLAST_UNCONNECTED;
  wire NLW_inst_m_axi_ram_WVALID_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_ram_ARADDR_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_ram_ARBURST_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_ram_ARCACHE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_ram_ARID_UNCONNECTED;
  wire [7:5]NLW_inst_m_axi_ram_ARLEN_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_ram_ARLOCK_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_ram_ARPROT_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_ram_ARQOS_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_ram_ARREGION_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_ram_ARSIZE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_ram_ARUSER_UNCONNECTED;
  wire [63:0]NLW_inst_m_axi_ram_AWADDR_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_ram_AWBURST_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_ram_AWCACHE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_ram_AWID_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_ram_AWLEN_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_ram_AWLOCK_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_ram_AWPROT_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_ram_AWQOS_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_ram_AWREGION_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_ram_AWSIZE_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_ram_AWUSER_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_ram_WDATA_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_ram_WID_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_ram_WSTRB_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_ram_WUSER_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_control_BRESP_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_control_RRESP_UNCONNECTED;

  assign m_axi_ram_ARADDR[63:2] = \^m_axi_ram_ARADDR [63:2];
  assign m_axi_ram_ARADDR[1] = \<const0> ;
  assign m_axi_ram_ARADDR[0] = \<const0> ;
  assign m_axi_ram_ARBURST[1] = \<const0> ;
  assign m_axi_ram_ARBURST[0] = \<const1> ;
  assign m_axi_ram_ARCACHE[3] = \<const0> ;
  assign m_axi_ram_ARCACHE[2] = \<const0> ;
  assign m_axi_ram_ARCACHE[1] = \<const1> ;
  assign m_axi_ram_ARCACHE[0] = \<const1> ;
  assign m_axi_ram_ARLEN[7] = \<const0> ;
  assign m_axi_ram_ARLEN[6] = \<const0> ;
  assign m_axi_ram_ARLEN[5] = \<const0> ;
  assign m_axi_ram_ARLEN[4:0] = \^m_axi_ram_ARLEN [4:0];
  assign m_axi_ram_ARLOCK[1] = \<const0> ;
  assign m_axi_ram_ARLOCK[0] = \<const0> ;
  assign m_axi_ram_ARPROT[2] = \<const0> ;
  assign m_axi_ram_ARPROT[1] = \<const0> ;
  assign m_axi_ram_ARPROT[0] = \<const0> ;
  assign m_axi_ram_ARQOS[3] = \<const0> ;
  assign m_axi_ram_ARQOS[2] = \<const0> ;
  assign m_axi_ram_ARQOS[1] = \<const0> ;
  assign m_axi_ram_ARQOS[0] = \<const0> ;
  assign m_axi_ram_ARREGION[3] = \<const0> ;
  assign m_axi_ram_ARREGION[2] = \<const0> ;
  assign m_axi_ram_ARREGION[1] = \<const0> ;
  assign m_axi_ram_ARREGION[0] = \<const0> ;
  assign m_axi_ram_ARSIZE[2] = \<const0> ;
  assign m_axi_ram_ARSIZE[1] = \<const1> ;
  assign m_axi_ram_ARSIZE[0] = \<const0> ;
  assign m_axi_ram_AWADDR[63] = \<const0> ;
  assign m_axi_ram_AWADDR[62] = \<const0> ;
  assign m_axi_ram_AWADDR[61] = \<const0> ;
  assign m_axi_ram_AWADDR[60] = \<const0> ;
  assign m_axi_ram_AWADDR[59] = \<const0> ;
  assign m_axi_ram_AWADDR[58] = \<const0> ;
  assign m_axi_ram_AWADDR[57] = \<const0> ;
  assign m_axi_ram_AWADDR[56] = \<const0> ;
  assign m_axi_ram_AWADDR[55] = \<const0> ;
  assign m_axi_ram_AWADDR[54] = \<const0> ;
  assign m_axi_ram_AWADDR[53] = \<const0> ;
  assign m_axi_ram_AWADDR[52] = \<const0> ;
  assign m_axi_ram_AWADDR[51] = \<const0> ;
  assign m_axi_ram_AWADDR[50] = \<const0> ;
  assign m_axi_ram_AWADDR[49] = \<const0> ;
  assign m_axi_ram_AWADDR[48] = \<const0> ;
  assign m_axi_ram_AWADDR[47] = \<const0> ;
  assign m_axi_ram_AWADDR[46] = \<const0> ;
  assign m_axi_ram_AWADDR[45] = \<const0> ;
  assign m_axi_ram_AWADDR[44] = \<const0> ;
  assign m_axi_ram_AWADDR[43] = \<const0> ;
  assign m_axi_ram_AWADDR[42] = \<const0> ;
  assign m_axi_ram_AWADDR[41] = \<const0> ;
  assign m_axi_ram_AWADDR[40] = \<const0> ;
  assign m_axi_ram_AWADDR[39] = \<const0> ;
  assign m_axi_ram_AWADDR[38] = \<const0> ;
  assign m_axi_ram_AWADDR[37] = \<const0> ;
  assign m_axi_ram_AWADDR[36] = \<const0> ;
  assign m_axi_ram_AWADDR[35] = \<const0> ;
  assign m_axi_ram_AWADDR[34] = \<const0> ;
  assign m_axi_ram_AWADDR[33] = \<const0> ;
  assign m_axi_ram_AWADDR[32] = \<const0> ;
  assign m_axi_ram_AWADDR[31] = \<const0> ;
  assign m_axi_ram_AWADDR[30] = \<const0> ;
  assign m_axi_ram_AWADDR[29] = \<const0> ;
  assign m_axi_ram_AWADDR[28] = \<const0> ;
  assign m_axi_ram_AWADDR[27] = \<const0> ;
  assign m_axi_ram_AWADDR[26] = \<const0> ;
  assign m_axi_ram_AWADDR[25] = \<const0> ;
  assign m_axi_ram_AWADDR[24] = \<const0> ;
  assign m_axi_ram_AWADDR[23] = \<const0> ;
  assign m_axi_ram_AWADDR[22] = \<const0> ;
  assign m_axi_ram_AWADDR[21] = \<const0> ;
  assign m_axi_ram_AWADDR[20] = \<const0> ;
  assign m_axi_ram_AWADDR[19] = \<const0> ;
  assign m_axi_ram_AWADDR[18] = \<const0> ;
  assign m_axi_ram_AWADDR[17] = \<const0> ;
  assign m_axi_ram_AWADDR[16] = \<const0> ;
  assign m_axi_ram_AWADDR[15] = \<const0> ;
  assign m_axi_ram_AWADDR[14] = \<const0> ;
  assign m_axi_ram_AWADDR[13] = \<const0> ;
  assign m_axi_ram_AWADDR[12] = \<const0> ;
  assign m_axi_ram_AWADDR[11] = \<const0> ;
  assign m_axi_ram_AWADDR[10] = \<const0> ;
  assign m_axi_ram_AWADDR[9] = \<const0> ;
  assign m_axi_ram_AWADDR[8] = \<const0> ;
  assign m_axi_ram_AWADDR[7] = \<const0> ;
  assign m_axi_ram_AWADDR[6] = \<const0> ;
  assign m_axi_ram_AWADDR[5] = \<const0> ;
  assign m_axi_ram_AWADDR[4] = \<const0> ;
  assign m_axi_ram_AWADDR[3] = \<const0> ;
  assign m_axi_ram_AWADDR[2] = \<const0> ;
  assign m_axi_ram_AWADDR[1] = \<const0> ;
  assign m_axi_ram_AWADDR[0] = \<const0> ;
  assign m_axi_ram_AWBURST[1] = \<const0> ;
  assign m_axi_ram_AWBURST[0] = \<const1> ;
  assign m_axi_ram_AWCACHE[3] = \<const0> ;
  assign m_axi_ram_AWCACHE[2] = \<const0> ;
  assign m_axi_ram_AWCACHE[1] = \<const1> ;
  assign m_axi_ram_AWCACHE[0] = \<const1> ;
  assign m_axi_ram_AWLEN[7] = \<const0> ;
  assign m_axi_ram_AWLEN[6] = \<const0> ;
  assign m_axi_ram_AWLEN[5] = \<const0> ;
  assign m_axi_ram_AWLEN[4] = \<const0> ;
  assign m_axi_ram_AWLEN[3] = \<const0> ;
  assign m_axi_ram_AWLEN[2] = \<const0> ;
  assign m_axi_ram_AWLEN[1] = \<const0> ;
  assign m_axi_ram_AWLEN[0] = \<const0> ;
  assign m_axi_ram_AWLOCK[1] = \<const0> ;
  assign m_axi_ram_AWLOCK[0] = \<const0> ;
  assign m_axi_ram_AWPROT[2] = \<const0> ;
  assign m_axi_ram_AWPROT[1] = \<const0> ;
  assign m_axi_ram_AWPROT[0] = \<const0> ;
  assign m_axi_ram_AWQOS[3] = \<const0> ;
  assign m_axi_ram_AWQOS[2] = \<const0> ;
  assign m_axi_ram_AWQOS[1] = \<const0> ;
  assign m_axi_ram_AWQOS[0] = \<const0> ;
  assign m_axi_ram_AWREGION[3] = \<const0> ;
  assign m_axi_ram_AWREGION[2] = \<const0> ;
  assign m_axi_ram_AWREGION[1] = \<const0> ;
  assign m_axi_ram_AWREGION[0] = \<const0> ;
  assign m_axi_ram_AWSIZE[2] = \<const0> ;
  assign m_axi_ram_AWSIZE[1] = \<const1> ;
  assign m_axi_ram_AWSIZE[0] = \<const0> ;
  assign m_axi_ram_AWVALID = \<const0> ;
  assign m_axi_ram_BREADY = \<const1> ;
  assign m_axi_ram_WDATA[31] = \<const0> ;
  assign m_axi_ram_WDATA[30] = \<const0> ;
  assign m_axi_ram_WDATA[29] = \<const0> ;
  assign m_axi_ram_WDATA[28] = \<const0> ;
  assign m_axi_ram_WDATA[27] = \<const0> ;
  assign m_axi_ram_WDATA[26] = \<const0> ;
  assign m_axi_ram_WDATA[25] = \<const0> ;
  assign m_axi_ram_WDATA[24] = \<const0> ;
  assign m_axi_ram_WDATA[23] = \<const0> ;
  assign m_axi_ram_WDATA[22] = \<const0> ;
  assign m_axi_ram_WDATA[21] = \<const0> ;
  assign m_axi_ram_WDATA[20] = \<const0> ;
  assign m_axi_ram_WDATA[19] = \<const0> ;
  assign m_axi_ram_WDATA[18] = \<const0> ;
  assign m_axi_ram_WDATA[17] = \<const0> ;
  assign m_axi_ram_WDATA[16] = \<const0> ;
  assign m_axi_ram_WDATA[15] = \<const0> ;
  assign m_axi_ram_WDATA[14] = \<const0> ;
  assign m_axi_ram_WDATA[13] = \<const0> ;
  assign m_axi_ram_WDATA[12] = \<const0> ;
  assign m_axi_ram_WDATA[11] = \<const0> ;
  assign m_axi_ram_WDATA[10] = \<const0> ;
  assign m_axi_ram_WDATA[9] = \<const0> ;
  assign m_axi_ram_WDATA[8] = \<const0> ;
  assign m_axi_ram_WDATA[7] = \<const0> ;
  assign m_axi_ram_WDATA[6] = \<const0> ;
  assign m_axi_ram_WDATA[5] = \<const0> ;
  assign m_axi_ram_WDATA[4] = \<const0> ;
  assign m_axi_ram_WDATA[3] = \<const0> ;
  assign m_axi_ram_WDATA[2] = \<const0> ;
  assign m_axi_ram_WDATA[1] = \<const0> ;
  assign m_axi_ram_WDATA[0] = \<const0> ;
  assign m_axi_ram_WLAST = \<const0> ;
  assign m_axi_ram_WSTRB[3] = \<const0> ;
  assign m_axi_ram_WSTRB[2] = \<const0> ;
  assign m_axi_ram_WSTRB[1] = \<const0> ;
  assign m_axi_ram_WSTRB[0] = \<const0> ;
  assign m_axi_ram_WVALID = \<const0> ;
  assign s_axi_control_BRESP[1] = \<const0> ;
  assign s_axi_control_BRESP[0] = \<const0> ;
  assign s_axi_control_RRESP[1] = \<const0> ;
  assign s_axi_control_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* C_M_AXI_DATA_WIDTH = "32" *) 
  (* C_M_AXI_RAM_ADDR_WIDTH = "64" *) 
  (* C_M_AXI_RAM_ARUSER_WIDTH = "1" *) 
  (* C_M_AXI_RAM_AWUSER_WIDTH = "1" *) 
  (* C_M_AXI_RAM_BUSER_WIDTH = "1" *) 
  (* C_M_AXI_RAM_CACHE_VALUE = "4'b0011" *) 
  (* C_M_AXI_RAM_DATA_WIDTH = "32" *) 
  (* C_M_AXI_RAM_ID_WIDTH = "1" *) 
  (* C_M_AXI_RAM_PROT_VALUE = "3'b000" *) 
  (* C_M_AXI_RAM_RUSER_WIDTH = "1" *) 
  (* C_M_AXI_RAM_USER_VALUE = "0" *) 
  (* C_M_AXI_RAM_WSTRB_WIDTH = "4" *) 
  (* C_M_AXI_RAM_WUSER_WIDTH = "1" *) 
  (* C_M_AXI_WSTRB_WIDTH = "4" *) 
  (* C_S_AXI_CONTROL_ADDR_WIDTH = "6" *) 
  (* C_S_AXI_CONTROL_DATA_WIDTH = "32" *) 
  (* C_S_AXI_CONTROL_WSTRB_WIDTH = "4" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_WSTRB_WIDTH = "4" *) 
  (* SDX_KERNEL = "true" *) 
  (* SDX_KERNEL_SYNTH_INST = "inst" *) 
  (* SDX_KERNEL_TYPE = "hls" *) 
  (* ap_ST_fsm_state1 = "11'b00000000001" *) 
  (* ap_ST_fsm_state10 = "11'b01000000000" *) 
  (* ap_ST_fsm_state11 = "11'b10000000000" *) 
  (* ap_ST_fsm_state2 = "11'b00000000010" *) 
  (* ap_ST_fsm_state3 = "11'b00000000100" *) 
  (* ap_ST_fsm_state4 = "11'b00000001000" *) 
  (* ap_ST_fsm_state5 = "11'b00000010000" *) 
  (* ap_ST_fsm_state6 = "11'b00000100000" *) 
  (* ap_ST_fsm_state7 = "11'b00001000000" *) 
  (* ap_ST_fsm_state8 = "11'b00010000000" *) 
  (* ap_ST_fsm_state9 = "11'b00100000000" *) 
  design_1_sound_operation_0_7_sound_operation inst
       (.ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .count(count),
        .m_axi_ram_ARADDR({\^m_axi_ram_ARADDR ,NLW_inst_m_axi_ram_ARADDR_UNCONNECTED[1:0]}),
        .m_axi_ram_ARBURST(NLW_inst_m_axi_ram_ARBURST_UNCONNECTED[1:0]),
        .m_axi_ram_ARCACHE(NLW_inst_m_axi_ram_ARCACHE_UNCONNECTED[3:0]),
        .m_axi_ram_ARID(NLW_inst_m_axi_ram_ARID_UNCONNECTED[0]),
        .m_axi_ram_ARLEN({NLW_inst_m_axi_ram_ARLEN_UNCONNECTED[7:5],\^m_axi_ram_ARLEN }),
        .m_axi_ram_ARLOCK(NLW_inst_m_axi_ram_ARLOCK_UNCONNECTED[1:0]),
        .m_axi_ram_ARPROT(NLW_inst_m_axi_ram_ARPROT_UNCONNECTED[2:0]),
        .m_axi_ram_ARQOS(NLW_inst_m_axi_ram_ARQOS_UNCONNECTED[3:0]),
        .m_axi_ram_ARREADY(m_axi_ram_ARREADY),
        .m_axi_ram_ARREGION(NLW_inst_m_axi_ram_ARREGION_UNCONNECTED[3:0]),
        .m_axi_ram_ARSIZE(NLW_inst_m_axi_ram_ARSIZE_UNCONNECTED[2:0]),
        .m_axi_ram_ARUSER(NLW_inst_m_axi_ram_ARUSER_UNCONNECTED[0]),
        .m_axi_ram_ARVALID(m_axi_ram_ARVALID),
        .m_axi_ram_AWADDR(NLW_inst_m_axi_ram_AWADDR_UNCONNECTED[63:0]),
        .m_axi_ram_AWBURST(NLW_inst_m_axi_ram_AWBURST_UNCONNECTED[1:0]),
        .m_axi_ram_AWCACHE(NLW_inst_m_axi_ram_AWCACHE_UNCONNECTED[3:0]),
        .m_axi_ram_AWID(NLW_inst_m_axi_ram_AWID_UNCONNECTED[0]),
        .m_axi_ram_AWLEN(NLW_inst_m_axi_ram_AWLEN_UNCONNECTED[7:0]),
        .m_axi_ram_AWLOCK(NLW_inst_m_axi_ram_AWLOCK_UNCONNECTED[1:0]),
        .m_axi_ram_AWPROT(NLW_inst_m_axi_ram_AWPROT_UNCONNECTED[2:0]),
        .m_axi_ram_AWQOS(NLW_inst_m_axi_ram_AWQOS_UNCONNECTED[3:0]),
        .m_axi_ram_AWREADY(1'b0),
        .m_axi_ram_AWREGION(NLW_inst_m_axi_ram_AWREGION_UNCONNECTED[3:0]),
        .m_axi_ram_AWSIZE(NLW_inst_m_axi_ram_AWSIZE_UNCONNECTED[2:0]),
        .m_axi_ram_AWUSER(NLW_inst_m_axi_ram_AWUSER_UNCONNECTED[0]),
        .m_axi_ram_AWVALID(NLW_inst_m_axi_ram_AWVALID_UNCONNECTED),
        .m_axi_ram_BID(1'b0),
        .m_axi_ram_BREADY(NLW_inst_m_axi_ram_BREADY_UNCONNECTED),
        .m_axi_ram_BRESP({1'b0,1'b0}),
        .m_axi_ram_BUSER(1'b0),
        .m_axi_ram_BVALID(1'b0),
        .m_axi_ram_RDATA(m_axi_ram_RDATA),
        .m_axi_ram_RID(1'b0),
        .m_axi_ram_RLAST(m_axi_ram_RLAST),
        .m_axi_ram_RREADY(m_axi_ram_RREADY),
        .m_axi_ram_RRESP(m_axi_ram_RRESP),
        .m_axi_ram_RUSER(1'b0),
        .m_axi_ram_RVALID(m_axi_ram_RVALID),
        .m_axi_ram_WDATA(NLW_inst_m_axi_ram_WDATA_UNCONNECTED[31:0]),
        .m_axi_ram_WID(NLW_inst_m_axi_ram_WID_UNCONNECTED[0]),
        .m_axi_ram_WLAST(NLW_inst_m_axi_ram_WLAST_UNCONNECTED),
        .m_axi_ram_WREADY(1'b0),
        .m_axi_ram_WSTRB(NLW_inst_m_axi_ram_WSTRB_UNCONNECTED[3:0]),
        .m_axi_ram_WUSER(NLW_inst_m_axi_ram_WUSER_UNCONNECTED[0]),
        .m_axi_ram_WVALID(NLW_inst_m_axi_ram_WVALID_UNCONNECTED),
        .opeout(opeout),
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
        .sdata(sdata));
endmodule

(* C_M_AXI_DATA_WIDTH = "32" *) (* C_M_AXI_RAM_ADDR_WIDTH = "64" *) (* C_M_AXI_RAM_ARUSER_WIDTH = "1" *) 
(* C_M_AXI_RAM_AWUSER_WIDTH = "1" *) (* C_M_AXI_RAM_BUSER_WIDTH = "1" *) (* C_M_AXI_RAM_CACHE_VALUE = "4'b0011" *) 
(* C_M_AXI_RAM_DATA_WIDTH = "32" *) (* C_M_AXI_RAM_ID_WIDTH = "1" *) (* C_M_AXI_RAM_PROT_VALUE = "3'b000" *) 
(* C_M_AXI_RAM_RUSER_WIDTH = "1" *) (* C_M_AXI_RAM_USER_VALUE = "0" *) (* C_M_AXI_RAM_WSTRB_WIDTH = "4" *) 
(* C_M_AXI_RAM_WUSER_WIDTH = "1" *) (* C_M_AXI_WSTRB_WIDTH = "4" *) (* C_S_AXI_CONTROL_ADDR_WIDTH = "6" *) 
(* C_S_AXI_CONTROL_DATA_WIDTH = "32" *) (* C_S_AXI_CONTROL_WSTRB_WIDTH = "4" *) (* C_S_AXI_DATA_WIDTH = "32" *) 
(* C_S_AXI_WSTRB_WIDTH = "4" *) (* ORIG_REF_NAME = "sound_operation" *) (* ap_ST_fsm_state1 = "11'b00000000001" *) 
(* ap_ST_fsm_state10 = "11'b01000000000" *) (* ap_ST_fsm_state11 = "11'b10000000000" *) (* ap_ST_fsm_state2 = "11'b00000000010" *) 
(* ap_ST_fsm_state3 = "11'b00000000100" *) (* ap_ST_fsm_state4 = "11'b00000001000" *) (* ap_ST_fsm_state5 = "11'b00000010000" *) 
(* ap_ST_fsm_state6 = "11'b00000100000" *) (* ap_ST_fsm_state7 = "11'b00001000000" *) (* ap_ST_fsm_state8 = "11'b00010000000" *) 
(* ap_ST_fsm_state9 = "11'b00100000000" *) (* hls_module = "yes" *) 
module design_1_sound_operation_0_7_sound_operation
   (ap_clk,
    ap_rst_n,
    m_axi_ram_AWVALID,
    m_axi_ram_AWREADY,
    m_axi_ram_AWADDR,
    m_axi_ram_AWID,
    m_axi_ram_AWLEN,
    m_axi_ram_AWSIZE,
    m_axi_ram_AWBURST,
    m_axi_ram_AWLOCK,
    m_axi_ram_AWCACHE,
    m_axi_ram_AWPROT,
    m_axi_ram_AWQOS,
    m_axi_ram_AWREGION,
    m_axi_ram_AWUSER,
    m_axi_ram_WVALID,
    m_axi_ram_WREADY,
    m_axi_ram_WDATA,
    m_axi_ram_WSTRB,
    m_axi_ram_WLAST,
    m_axi_ram_WID,
    m_axi_ram_WUSER,
    m_axi_ram_ARVALID,
    m_axi_ram_ARREADY,
    m_axi_ram_ARADDR,
    m_axi_ram_ARID,
    m_axi_ram_ARLEN,
    m_axi_ram_ARSIZE,
    m_axi_ram_ARBURST,
    m_axi_ram_ARLOCK,
    m_axi_ram_ARCACHE,
    m_axi_ram_ARPROT,
    m_axi_ram_ARQOS,
    m_axi_ram_ARREGION,
    m_axi_ram_ARUSER,
    m_axi_ram_RVALID,
    m_axi_ram_RREADY,
    m_axi_ram_RDATA,
    m_axi_ram_RLAST,
    m_axi_ram_RID,
    m_axi_ram_RUSER,
    m_axi_ram_RRESP,
    m_axi_ram_BVALID,
    m_axi_ram_BREADY,
    m_axi_ram_BRESP,
    m_axi_ram_BID,
    m_axi_ram_BUSER,
    sdata,
    opeout,
    count,
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
  output m_axi_ram_AWVALID;
  input m_axi_ram_AWREADY;
  output [63:0]m_axi_ram_AWADDR;
  output [0:0]m_axi_ram_AWID;
  output [7:0]m_axi_ram_AWLEN;
  output [2:0]m_axi_ram_AWSIZE;
  output [1:0]m_axi_ram_AWBURST;
  output [1:0]m_axi_ram_AWLOCK;
  output [3:0]m_axi_ram_AWCACHE;
  output [2:0]m_axi_ram_AWPROT;
  output [3:0]m_axi_ram_AWQOS;
  output [3:0]m_axi_ram_AWREGION;
  output [0:0]m_axi_ram_AWUSER;
  output m_axi_ram_WVALID;
  input m_axi_ram_WREADY;
  output [31:0]m_axi_ram_WDATA;
  output [3:0]m_axi_ram_WSTRB;
  output m_axi_ram_WLAST;
  output [0:0]m_axi_ram_WID;
  output [0:0]m_axi_ram_WUSER;
  output m_axi_ram_ARVALID;
  input m_axi_ram_ARREADY;
  output [63:0]m_axi_ram_ARADDR;
  output [0:0]m_axi_ram_ARID;
  output [7:0]m_axi_ram_ARLEN;
  output [2:0]m_axi_ram_ARSIZE;
  output [1:0]m_axi_ram_ARBURST;
  output [1:0]m_axi_ram_ARLOCK;
  output [3:0]m_axi_ram_ARCACHE;
  output [2:0]m_axi_ram_ARPROT;
  output [3:0]m_axi_ram_ARQOS;
  output [3:0]m_axi_ram_ARREGION;
  output [0:0]m_axi_ram_ARUSER;
  input m_axi_ram_RVALID;
  output m_axi_ram_RREADY;
  input [31:0]m_axi_ram_RDATA;
  input m_axi_ram_RLAST;
  input [0:0]m_axi_ram_RID;
  input [0:0]m_axi_ram_RUSER;
  input [1:0]m_axi_ram_RRESP;
  input m_axi_ram_BVALID;
  output m_axi_ram_BREADY;
  input [1:0]m_axi_ram_BRESP;
  input [0:0]m_axi_ram_BID;
  input [0:0]m_axi_ram_BUSER;
  output [31:0]sdata;
  output [31:0]opeout;
  input [31:0]count;
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
  wire \ap_CS_fsm[1]_i_2_n_0 ;
  wire \ap_CS_fsm_reg_n_0_[10] ;
  wire \ap_CS_fsm_reg_n_0_[3] ;
  wire \ap_CS_fsm_reg_n_0_[4] ;
  wire \ap_CS_fsm_reg_n_0_[5] ;
  wire \ap_CS_fsm_reg_n_0_[6] ;
  wire \ap_CS_fsm_reg_n_0_[7] ;
  wire \ap_CS_fsm_reg_n_0_[8] ;
  wire ap_CS_fsm_state10;
  wire ap_CS_fsm_state2;
  wire ap_CS_fsm_state3;
  wire [10:1]ap_NS_fsm;
  wire ap_clk;
  wire ap_rst_n;
  wire ap_rst_n_inv;
  wire [31:0]count;
  wire [63:2]\^m_axi_ram_ARADDR ;
  wire [4:0]\^m_axi_ram_ARLEN ;
  wire m_axi_ram_ARREADY;
  wire m_axi_ram_ARVALID;
  wire [31:0]m_axi_ram_RDATA;
  wire m_axi_ram_RLAST;
  wire m_axi_ram_RREADY;
  wire [1:0]m_axi_ram_RRESP;
  wire m_axi_ram_RVALID;
  wire [31:0]opeout;
  wire opeout_1_vld_in;
  wire [31:0]ram_RDATA;
  wire [61:0]ram_addr_reg_160;
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
  wire [31:0]sdata;
  wire [61:0]sext_ln324_fu_150_p1;
  wire [31:0]status;
  wire [31:0]status_0_data_reg;
  wire [33:2]zext_ln324_fu_130_p1;

  assign m_axi_ram_ARADDR[63:2] = \^m_axi_ram_ARADDR [63:2];
  assign m_axi_ram_ARADDR[1] = \<const0> ;
  assign m_axi_ram_ARADDR[0] = \<const0> ;
  assign m_axi_ram_ARBURST[1] = \<const0> ;
  assign m_axi_ram_ARBURST[0] = \<const0> ;
  assign m_axi_ram_ARCACHE[3] = \<const0> ;
  assign m_axi_ram_ARCACHE[2] = \<const0> ;
  assign m_axi_ram_ARCACHE[1] = \<const0> ;
  assign m_axi_ram_ARCACHE[0] = \<const0> ;
  assign m_axi_ram_ARID[0] = \<const0> ;
  assign m_axi_ram_ARLEN[7] = \<const0> ;
  assign m_axi_ram_ARLEN[6] = \<const0> ;
  assign m_axi_ram_ARLEN[5] = \<const0> ;
  assign m_axi_ram_ARLEN[4:0] = \^m_axi_ram_ARLEN [4:0];
  assign m_axi_ram_ARLOCK[1] = \<const0> ;
  assign m_axi_ram_ARLOCK[0] = \<const0> ;
  assign m_axi_ram_ARPROT[2] = \<const0> ;
  assign m_axi_ram_ARPROT[1] = \<const0> ;
  assign m_axi_ram_ARPROT[0] = \<const0> ;
  assign m_axi_ram_ARQOS[3] = \<const0> ;
  assign m_axi_ram_ARQOS[2] = \<const0> ;
  assign m_axi_ram_ARQOS[1] = \<const0> ;
  assign m_axi_ram_ARQOS[0] = \<const0> ;
  assign m_axi_ram_ARREGION[3] = \<const0> ;
  assign m_axi_ram_ARREGION[2] = \<const0> ;
  assign m_axi_ram_ARREGION[1] = \<const0> ;
  assign m_axi_ram_ARREGION[0] = \<const0> ;
  assign m_axi_ram_ARSIZE[2] = \<const0> ;
  assign m_axi_ram_ARSIZE[1] = \<const0> ;
  assign m_axi_ram_ARSIZE[0] = \<const0> ;
  assign m_axi_ram_ARUSER[0] = \<const0> ;
  assign m_axi_ram_AWADDR[63] = \<const0> ;
  assign m_axi_ram_AWADDR[62] = \<const0> ;
  assign m_axi_ram_AWADDR[61] = \<const0> ;
  assign m_axi_ram_AWADDR[60] = \<const0> ;
  assign m_axi_ram_AWADDR[59] = \<const0> ;
  assign m_axi_ram_AWADDR[58] = \<const0> ;
  assign m_axi_ram_AWADDR[57] = \<const0> ;
  assign m_axi_ram_AWADDR[56] = \<const0> ;
  assign m_axi_ram_AWADDR[55] = \<const0> ;
  assign m_axi_ram_AWADDR[54] = \<const0> ;
  assign m_axi_ram_AWADDR[53] = \<const0> ;
  assign m_axi_ram_AWADDR[52] = \<const0> ;
  assign m_axi_ram_AWADDR[51] = \<const0> ;
  assign m_axi_ram_AWADDR[50] = \<const0> ;
  assign m_axi_ram_AWADDR[49] = \<const0> ;
  assign m_axi_ram_AWADDR[48] = \<const0> ;
  assign m_axi_ram_AWADDR[47] = \<const0> ;
  assign m_axi_ram_AWADDR[46] = \<const0> ;
  assign m_axi_ram_AWADDR[45] = \<const0> ;
  assign m_axi_ram_AWADDR[44] = \<const0> ;
  assign m_axi_ram_AWADDR[43] = \<const0> ;
  assign m_axi_ram_AWADDR[42] = \<const0> ;
  assign m_axi_ram_AWADDR[41] = \<const0> ;
  assign m_axi_ram_AWADDR[40] = \<const0> ;
  assign m_axi_ram_AWADDR[39] = \<const0> ;
  assign m_axi_ram_AWADDR[38] = \<const0> ;
  assign m_axi_ram_AWADDR[37] = \<const0> ;
  assign m_axi_ram_AWADDR[36] = \<const0> ;
  assign m_axi_ram_AWADDR[35] = \<const0> ;
  assign m_axi_ram_AWADDR[34] = \<const0> ;
  assign m_axi_ram_AWADDR[33] = \<const0> ;
  assign m_axi_ram_AWADDR[32] = \<const0> ;
  assign m_axi_ram_AWADDR[31] = \<const0> ;
  assign m_axi_ram_AWADDR[30] = \<const0> ;
  assign m_axi_ram_AWADDR[29] = \<const0> ;
  assign m_axi_ram_AWADDR[28] = \<const0> ;
  assign m_axi_ram_AWADDR[27] = \<const0> ;
  assign m_axi_ram_AWADDR[26] = \<const0> ;
  assign m_axi_ram_AWADDR[25] = \<const0> ;
  assign m_axi_ram_AWADDR[24] = \<const0> ;
  assign m_axi_ram_AWADDR[23] = \<const0> ;
  assign m_axi_ram_AWADDR[22] = \<const0> ;
  assign m_axi_ram_AWADDR[21] = \<const0> ;
  assign m_axi_ram_AWADDR[20] = \<const0> ;
  assign m_axi_ram_AWADDR[19] = \<const0> ;
  assign m_axi_ram_AWADDR[18] = \<const0> ;
  assign m_axi_ram_AWADDR[17] = \<const0> ;
  assign m_axi_ram_AWADDR[16] = \<const0> ;
  assign m_axi_ram_AWADDR[15] = \<const0> ;
  assign m_axi_ram_AWADDR[14] = \<const0> ;
  assign m_axi_ram_AWADDR[13] = \<const0> ;
  assign m_axi_ram_AWADDR[12] = \<const0> ;
  assign m_axi_ram_AWADDR[11] = \<const0> ;
  assign m_axi_ram_AWADDR[10] = \<const0> ;
  assign m_axi_ram_AWADDR[9] = \<const0> ;
  assign m_axi_ram_AWADDR[8] = \<const0> ;
  assign m_axi_ram_AWADDR[7] = \<const0> ;
  assign m_axi_ram_AWADDR[6] = \<const0> ;
  assign m_axi_ram_AWADDR[5] = \<const0> ;
  assign m_axi_ram_AWADDR[4] = \<const0> ;
  assign m_axi_ram_AWADDR[3] = \<const0> ;
  assign m_axi_ram_AWADDR[2] = \<const0> ;
  assign m_axi_ram_AWADDR[1] = \<const0> ;
  assign m_axi_ram_AWADDR[0] = \<const0> ;
  assign m_axi_ram_AWBURST[1] = \<const0> ;
  assign m_axi_ram_AWBURST[0] = \<const0> ;
  assign m_axi_ram_AWCACHE[3] = \<const0> ;
  assign m_axi_ram_AWCACHE[2] = \<const0> ;
  assign m_axi_ram_AWCACHE[1] = \<const0> ;
  assign m_axi_ram_AWCACHE[0] = \<const0> ;
  assign m_axi_ram_AWID[0] = \<const0> ;
  assign m_axi_ram_AWLEN[7] = \<const0> ;
  assign m_axi_ram_AWLEN[6] = \<const0> ;
  assign m_axi_ram_AWLEN[5] = \<const0> ;
  assign m_axi_ram_AWLEN[4] = \<const0> ;
  assign m_axi_ram_AWLEN[3] = \<const0> ;
  assign m_axi_ram_AWLEN[2] = \<const0> ;
  assign m_axi_ram_AWLEN[1] = \<const0> ;
  assign m_axi_ram_AWLEN[0] = \<const0> ;
  assign m_axi_ram_AWLOCK[1] = \<const0> ;
  assign m_axi_ram_AWLOCK[0] = \<const0> ;
  assign m_axi_ram_AWPROT[2] = \<const0> ;
  assign m_axi_ram_AWPROT[1] = \<const0> ;
  assign m_axi_ram_AWPROT[0] = \<const0> ;
  assign m_axi_ram_AWQOS[3] = \<const0> ;
  assign m_axi_ram_AWQOS[2] = \<const0> ;
  assign m_axi_ram_AWQOS[1] = \<const0> ;
  assign m_axi_ram_AWQOS[0] = \<const0> ;
  assign m_axi_ram_AWREGION[3] = \<const0> ;
  assign m_axi_ram_AWREGION[2] = \<const0> ;
  assign m_axi_ram_AWREGION[1] = \<const0> ;
  assign m_axi_ram_AWREGION[0] = \<const0> ;
  assign m_axi_ram_AWSIZE[2] = \<const0> ;
  assign m_axi_ram_AWSIZE[1] = \<const0> ;
  assign m_axi_ram_AWSIZE[0] = \<const0> ;
  assign m_axi_ram_AWUSER[0] = \<const0> ;
  assign m_axi_ram_AWVALID = \<const0> ;
  assign m_axi_ram_BREADY = \<const0> ;
  assign m_axi_ram_WDATA[31] = \<const0> ;
  assign m_axi_ram_WDATA[30] = \<const0> ;
  assign m_axi_ram_WDATA[29] = \<const0> ;
  assign m_axi_ram_WDATA[28] = \<const0> ;
  assign m_axi_ram_WDATA[27] = \<const0> ;
  assign m_axi_ram_WDATA[26] = \<const0> ;
  assign m_axi_ram_WDATA[25] = \<const0> ;
  assign m_axi_ram_WDATA[24] = \<const0> ;
  assign m_axi_ram_WDATA[23] = \<const0> ;
  assign m_axi_ram_WDATA[22] = \<const0> ;
  assign m_axi_ram_WDATA[21] = \<const0> ;
  assign m_axi_ram_WDATA[20] = \<const0> ;
  assign m_axi_ram_WDATA[19] = \<const0> ;
  assign m_axi_ram_WDATA[18] = \<const0> ;
  assign m_axi_ram_WDATA[17] = \<const0> ;
  assign m_axi_ram_WDATA[16] = \<const0> ;
  assign m_axi_ram_WDATA[15] = \<const0> ;
  assign m_axi_ram_WDATA[14] = \<const0> ;
  assign m_axi_ram_WDATA[13] = \<const0> ;
  assign m_axi_ram_WDATA[12] = \<const0> ;
  assign m_axi_ram_WDATA[11] = \<const0> ;
  assign m_axi_ram_WDATA[10] = \<const0> ;
  assign m_axi_ram_WDATA[9] = \<const0> ;
  assign m_axi_ram_WDATA[8] = \<const0> ;
  assign m_axi_ram_WDATA[7] = \<const0> ;
  assign m_axi_ram_WDATA[6] = \<const0> ;
  assign m_axi_ram_WDATA[5] = \<const0> ;
  assign m_axi_ram_WDATA[4] = \<const0> ;
  assign m_axi_ram_WDATA[3] = \<const0> ;
  assign m_axi_ram_WDATA[2] = \<const0> ;
  assign m_axi_ram_WDATA[1] = \<const0> ;
  assign m_axi_ram_WDATA[0] = \<const0> ;
  assign m_axi_ram_WID[0] = \<const0> ;
  assign m_axi_ram_WLAST = \<const0> ;
  assign m_axi_ram_WSTRB[3] = \<const0> ;
  assign m_axi_ram_WSTRB[2] = \<const0> ;
  assign m_axi_ram_WSTRB[1] = \<const0> ;
  assign m_axi_ram_WSTRB[0] = \<const0> ;
  assign m_axi_ram_WUSER[0] = \<const0> ;
  assign m_axi_ram_WVALID = \<const0> ;
  assign s_axi_control_BRESP[1] = \<const0> ;
  assign s_axi_control_BRESP[0] = \<const0> ;
  assign s_axi_control_RRESP[1] = \<const0> ;
  assign s_axi_control_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(\ap_CS_fsm_reg_n_0_[4] ),
        .I1(\ap_CS_fsm_reg_n_0_[7] ),
        .I2(ap_CS_fsm_state3),
        .I3(\ap_CS_fsm_reg_n_0_[3] ),
        .I4(\ap_CS_fsm[1]_i_2_n_0 ),
        .O(ap_NS_fsm[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \ap_CS_fsm[1]_i_2 
       (.I0(\ap_CS_fsm_reg_n_0_[8] ),
        .I1(ap_CS_fsm_state10),
        .I2(ap_CS_fsm_state2),
        .I3(\ap_CS_fsm_reg_n_0_[5] ),
        .I4(\ap_CS_fsm_reg_n_0_[10] ),
        .I5(\ap_CS_fsm_reg_n_0_[6] ),
        .O(\ap_CS_fsm[1]_i_2_n_0 ));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[10] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[10]),
        .Q(\ap_CS_fsm_reg_n_0_[10] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[1]),
        .Q(ap_CS_fsm_state2),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[2]),
        .Q(ap_CS_fsm_state3),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(opeout_1_vld_in),
        .Q(\ap_CS_fsm_reg_n_0_[3] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[4] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm_reg_n_0_[3] ),
        .Q(\ap_CS_fsm_reg_n_0_[4] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[5] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm_reg_n_0_[4] ),
        .Q(\ap_CS_fsm_reg_n_0_[5] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[6] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm_reg_n_0_[5] ),
        .Q(\ap_CS_fsm_reg_n_0_[6] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[7] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm_reg_n_0_[6] ),
        .Q(\ap_CS_fsm_reg_n_0_[7] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[8] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\ap_CS_fsm_reg_n_0_[7] ),
        .Q(\ap_CS_fsm_reg_n_0_[8] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[9] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[9]),
        .Q(ap_CS_fsm_state10),
        .R(ap_rst_n_inv));
  design_1_sound_operation_0_7_sound_operation_control_s_axi control_s_axi_U
       (.\FSM_onehot_rstate_reg[1]_0 (s_axi_control_ARREADY),
        .\FSM_onehot_wstate_reg[1]_0 (s_axi_control_AWREADY),
        .\FSM_onehot_wstate_reg[2]_0 (s_axi_control_WREADY),
        .O56(sext_ln324_fu_150_p1),
        .Q(status),
        .SR(ap_rst_n_inv),
        .ap_clk(ap_clk),
        .\ram_addr_reg_160_reg[34] (zext_ln324_fu_130_p1),
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
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[0]),
        .Q(zext_ln324_fu_130_p1[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[10] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[10]),
        .Q(zext_ln324_fu_130_p1[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[11] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[11]),
        .Q(zext_ln324_fu_130_p1[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[12] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[12]),
        .Q(zext_ln324_fu_130_p1[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[13] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[13]),
        .Q(zext_ln324_fu_130_p1[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[14] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[14]),
        .Q(zext_ln324_fu_130_p1[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[15] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[15]),
        .Q(zext_ln324_fu_130_p1[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[16] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[16]),
        .Q(zext_ln324_fu_130_p1[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[17] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[17]),
        .Q(zext_ln324_fu_130_p1[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[18] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[18]),
        .Q(zext_ln324_fu_130_p1[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[19] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[19]),
        .Q(zext_ln324_fu_130_p1[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[1]),
        .Q(zext_ln324_fu_130_p1[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[20] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[20]),
        .Q(zext_ln324_fu_130_p1[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[21] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[21]),
        .Q(zext_ln324_fu_130_p1[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[22] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[22]),
        .Q(zext_ln324_fu_130_p1[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[23] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[23]),
        .Q(zext_ln324_fu_130_p1[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[24] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[24]),
        .Q(zext_ln324_fu_130_p1[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[25] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[25]),
        .Q(zext_ln324_fu_130_p1[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[26] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[26]),
        .Q(zext_ln324_fu_130_p1[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[27] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[27]),
        .Q(zext_ln324_fu_130_p1[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[28] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[28]),
        .Q(zext_ln324_fu_130_p1[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[29] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[29]),
        .Q(zext_ln324_fu_130_p1[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[2]),
        .Q(zext_ln324_fu_130_p1[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[30] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[30]),
        .Q(zext_ln324_fu_130_p1[32]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[31] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[31]),
        .Q(zext_ln324_fu_130_p1[33]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[3]),
        .Q(zext_ln324_fu_130_p1[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[4] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[4]),
        .Q(zext_ln324_fu_130_p1[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[5] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[5]),
        .Q(zext_ln324_fu_130_p1[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[6] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[6]),
        .Q(zext_ln324_fu_130_p1[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[7] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[7]),
        .Q(zext_ln324_fu_130_p1[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[8] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[8]),
        .Q(zext_ln324_fu_130_p1[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_0_data_reg_reg[9] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(count[9]),
        .Q(zext_ln324_fu_130_p1[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[0] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[0]),
        .Q(opeout[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[10] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[10]),
        .Q(opeout[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[11] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[11]),
        .Q(opeout[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[12] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[12]),
        .Q(opeout[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[13] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[13]),
        .Q(opeout[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[14] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[14]),
        .Q(opeout[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[15] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[15]),
        .Q(opeout[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[16] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[16]),
        .Q(opeout[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[17] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[17]),
        .Q(opeout[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[18] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[18]),
        .Q(opeout[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[19] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[19]),
        .Q(opeout[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[1] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[1]),
        .Q(opeout[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[20] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[20]),
        .Q(opeout[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[21] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[21]),
        .Q(opeout[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[22] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[22]),
        .Q(opeout[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[23] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[23]),
        .Q(opeout[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[24] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[24]),
        .Q(opeout[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[25] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[25]),
        .Q(opeout[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[26] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[26]),
        .Q(opeout[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[27] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[27]),
        .Q(opeout[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[28] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[28]),
        .Q(opeout[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[29] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[29]),
        .Q(opeout[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[2] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[2]),
        .Q(opeout[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[30] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[30]),
        .Q(opeout[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[31] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[31]),
        .Q(opeout[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[3] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[3]),
        .Q(opeout[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[4] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[4]),
        .Q(opeout[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[5] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[5]),
        .Q(opeout[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[6] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[6]),
        .Q(opeout[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[7] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[7]),
        .Q(opeout[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[8] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[8]),
        .Q(opeout[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \opeout_1_data_reg_reg[9] 
       (.C(ap_clk),
        .CE(opeout_1_vld_in),
        .D(status_0_data_reg[9]),
        .Q(opeout[9]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[0] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[0]),
        .Q(ram_addr_reg_160[0]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[10] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[10]),
        .Q(ram_addr_reg_160[10]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[11] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[11]),
        .Q(ram_addr_reg_160[11]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[12] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[12]),
        .Q(ram_addr_reg_160[12]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[13] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[13]),
        .Q(ram_addr_reg_160[13]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[14] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[14]),
        .Q(ram_addr_reg_160[14]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[15] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[15]),
        .Q(ram_addr_reg_160[15]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[16] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[16]),
        .Q(ram_addr_reg_160[16]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[17] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[17]),
        .Q(ram_addr_reg_160[17]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[18] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[18]),
        .Q(ram_addr_reg_160[18]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[19] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[19]),
        .Q(ram_addr_reg_160[19]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[1] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[1]),
        .Q(ram_addr_reg_160[1]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[20] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[20]),
        .Q(ram_addr_reg_160[20]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[21] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[21]),
        .Q(ram_addr_reg_160[21]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[22] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[22]),
        .Q(ram_addr_reg_160[22]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[23] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[23]),
        .Q(ram_addr_reg_160[23]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[24] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[24]),
        .Q(ram_addr_reg_160[24]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[25] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[25]),
        .Q(ram_addr_reg_160[25]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[26] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[26]),
        .Q(ram_addr_reg_160[26]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[27] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[27]),
        .Q(ram_addr_reg_160[27]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[28] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[28]),
        .Q(ram_addr_reg_160[28]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[29] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[29]),
        .Q(ram_addr_reg_160[29]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[2] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[2]),
        .Q(ram_addr_reg_160[2]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[30] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[30]),
        .Q(ram_addr_reg_160[30]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[31] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[31]),
        .Q(ram_addr_reg_160[31]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[32] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[32]),
        .Q(ram_addr_reg_160[32]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[33] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[33]),
        .Q(ram_addr_reg_160[33]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[34] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[34]),
        .Q(ram_addr_reg_160[34]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[35] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[35]),
        .Q(ram_addr_reg_160[35]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[36] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[36]),
        .Q(ram_addr_reg_160[36]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[37] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[37]),
        .Q(ram_addr_reg_160[37]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[38] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[38]),
        .Q(ram_addr_reg_160[38]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[39] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[39]),
        .Q(ram_addr_reg_160[39]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[3] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[3]),
        .Q(ram_addr_reg_160[3]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[40] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[40]),
        .Q(ram_addr_reg_160[40]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[41] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[41]),
        .Q(ram_addr_reg_160[41]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[42] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[42]),
        .Q(ram_addr_reg_160[42]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[43] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[43]),
        .Q(ram_addr_reg_160[43]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[44] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[44]),
        .Q(ram_addr_reg_160[44]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[45] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[45]),
        .Q(ram_addr_reg_160[45]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[46] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[46]),
        .Q(ram_addr_reg_160[46]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[47] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[47]),
        .Q(ram_addr_reg_160[47]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[48] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[48]),
        .Q(ram_addr_reg_160[48]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[49] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[49]),
        .Q(ram_addr_reg_160[49]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[4] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[4]),
        .Q(ram_addr_reg_160[4]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[50] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[50]),
        .Q(ram_addr_reg_160[50]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[51] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[51]),
        .Q(ram_addr_reg_160[51]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[52] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[52]),
        .Q(ram_addr_reg_160[52]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[53] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[53]),
        .Q(ram_addr_reg_160[53]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[54] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[54]),
        .Q(ram_addr_reg_160[54]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[55] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[55]),
        .Q(ram_addr_reg_160[55]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[56] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[56]),
        .Q(ram_addr_reg_160[56]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[57] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[57]),
        .Q(ram_addr_reg_160[57]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[58] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[58]),
        .Q(ram_addr_reg_160[58]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[59] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[59]),
        .Q(ram_addr_reg_160[59]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[5] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[5]),
        .Q(ram_addr_reg_160[5]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[60] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[60]),
        .Q(ram_addr_reg_160[60]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[61] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[61]),
        .Q(ram_addr_reg_160[61]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[6] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[6]),
        .Q(ram_addr_reg_160[6]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[7] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[7]),
        .Q(ram_addr_reg_160[7]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[8] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[8]),
        .Q(ram_addr_reg_160[8]),
        .R(1'b0));
  FDRE \ram_addr_reg_160_reg[9] 
       (.C(ap_clk),
        .CE(ap_CS_fsm_state2),
        .D(sext_ln324_fu_150_p1[9]),
        .Q(ram_addr_reg_160[9]),
        .R(1'b0));
  design_1_sound_operation_0_7_sound_operation_ram_m_axi ram_m_axi_U
       (.D({m_axi_ram_RLAST,m_axi_ram_RDATA}),
        .E(opeout_1_vld_in),
        .Q({ap_CS_fsm_state10,\ap_CS_fsm_reg_n_0_[8] ,ap_CS_fsm_state3,ap_CS_fsm_state2}),
        .SR(ap_rst_n_inv),
        .ap_NS_fsm({ap_NS_fsm[10:9],ap_NS_fsm[2]}),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .\could_multi_bursts.ARVALID_Dummy_reg (m_axi_ram_ARVALID),
        .\could_multi_bursts.arlen_buf_reg[4] (\^m_axi_ram_ARLEN ),
        .\data_p1_reg[31] (ram_RDATA),
        .\data_p2_reg[61] (ram_addr_reg_160),
        .full_n_reg(m_axi_ram_RREADY),
        .m_axi_ram_ARADDR(\^m_axi_ram_ARADDR ),
        .m_axi_ram_ARREADY(m_axi_ram_ARREADY),
        .m_axi_ram_RRESP(m_axi_ram_RRESP),
        .m_axi_ram_RVALID(m_axi_ram_RVALID));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[0] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[0]),
        .Q(sdata[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[10] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[10]),
        .Q(sdata[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[11] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[11]),
        .Q(sdata[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[12] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[12]),
        .Q(sdata[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[13] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[13]),
        .Q(sdata[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[14] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[14]),
        .Q(sdata[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[15] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[15]),
        .Q(sdata[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[16] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[16]),
        .Q(sdata[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[17] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[17]),
        .Q(sdata[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[18] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[18]),
        .Q(sdata[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[19] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[19]),
        .Q(sdata[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[1] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[1]),
        .Q(sdata[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[20] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[20]),
        .Q(sdata[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[21] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[21]),
        .Q(sdata[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[22] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[22]),
        .Q(sdata[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[23] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[23]),
        .Q(sdata[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[24] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[24]),
        .Q(sdata[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[25] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[25]),
        .Q(sdata[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[26] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[26]),
        .Q(sdata[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[27] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[27]),
        .Q(sdata[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[28] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[28]),
        .Q(sdata[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[29] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[29]),
        .Q(sdata[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[2] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[2]),
        .Q(sdata[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[30] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[30]),
        .Q(sdata[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[31] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[31]),
        .Q(sdata[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[3] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[3]),
        .Q(sdata[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[4] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[4]),
        .Q(sdata[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[5] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[5]),
        .Q(sdata[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[6] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[6]),
        .Q(sdata[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[7] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[7]),
        .Q(sdata[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[8] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[8]),
        .Q(sdata[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdata_1_data_reg_reg[9] 
       (.C(ap_clk),
        .CE(ap_NS_fsm[10]),
        .D(ram_RDATA[9]),
        .Q(sdata[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[0]),
        .Q(status_0_data_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[10] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[10]),
        .Q(status_0_data_reg[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[11] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[11]),
        .Q(status_0_data_reg[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[12] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[12]),
        .Q(status_0_data_reg[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[13] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[13]),
        .Q(status_0_data_reg[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[14] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[14]),
        .Q(status_0_data_reg[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[15] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[15]),
        .Q(status_0_data_reg[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[16] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[16]),
        .Q(status_0_data_reg[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[17] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[17]),
        .Q(status_0_data_reg[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[18] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[18]),
        .Q(status_0_data_reg[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[19] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[19]),
        .Q(status_0_data_reg[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[1]),
        .Q(status_0_data_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[20] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[20]),
        .Q(status_0_data_reg[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[21] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[21]),
        .Q(status_0_data_reg[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[22] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[22]),
        .Q(status_0_data_reg[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[23] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[23]),
        .Q(status_0_data_reg[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[24] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[24]),
        .Q(status_0_data_reg[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[25] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[25]),
        .Q(status_0_data_reg[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[26] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[26]),
        .Q(status_0_data_reg[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[27] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[27]),
        .Q(status_0_data_reg[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[28] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[28]),
        .Q(status_0_data_reg[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[29] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[29]),
        .Q(status_0_data_reg[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[2]),
        .Q(status_0_data_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[30] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[30]),
        .Q(status_0_data_reg[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[31] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[31]),
        .Q(status_0_data_reg[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[3]),
        .Q(status_0_data_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[4] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[4]),
        .Q(status_0_data_reg[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[5] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[5]),
        .Q(status_0_data_reg[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[6] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[6]),
        .Q(status_0_data_reg[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[7] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[7]),
        .Q(status_0_data_reg[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[8] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[8]),
        .Q(status_0_data_reg[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \status_0_data_reg_reg[9] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(status[9]),
        .Q(status_0_data_reg[9]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "sound_operation_control_s_axi" *) 
module design_1_sound_operation_0_7_sound_operation_control_s_axi
   (\FSM_onehot_rstate_reg[1]_0 ,
    s_axi_control_BVALID,
    \FSM_onehot_wstate_reg[2]_0 ,
    \FSM_onehot_wstate_reg[1]_0 ,
    s_axi_control_RVALID,
    Q,
    s_axi_control_RDATA,
    O56,
    s_axi_control_ARVALID,
    s_axi_control_ARADDR,
    SR,
    ap_clk,
    s_axi_control_AWADDR,
    s_axi_control_AWVALID,
    s_axi_control_BREADY,
    s_axi_control_WVALID,
    s_axi_control_RREADY,
    \ram_addr_reg_160_reg[34] ,
    s_axi_control_WDATA,
    s_axi_control_WSTRB);
  output \FSM_onehot_rstate_reg[1]_0 ;
  output s_axi_control_BVALID;
  output \FSM_onehot_wstate_reg[2]_0 ;
  output \FSM_onehot_wstate_reg[1]_0 ;
  output s_axi_control_RVALID;
  output [31:0]Q;
  output [31:0]s_axi_control_RDATA;
  output [61:0]O56;
  input s_axi_control_ARVALID;
  input [5:0]s_axi_control_ARADDR;
  input [0:0]SR;
  input ap_clk;
  input [5:0]s_axi_control_AWADDR;
  input s_axi_control_AWVALID;
  input s_axi_control_BREADY;
  input s_axi_control_WVALID;
  input s_axi_control_RREADY;
  input [31:0]\ram_addr_reg_160_reg[34] ;
  input [31:0]s_axi_control_WDATA;
  input [3:0]s_axi_control_WSTRB;

  wire \FSM_onehot_rstate[1]_i_1_n_0 ;
  wire \FSM_onehot_rstate[2]_i_1_n_0 ;
  wire \FSM_onehot_rstate_reg[1]_0 ;
  wire \FSM_onehot_wstate[1]_i_1_n_0 ;
  wire \FSM_onehot_wstate[2]_i_1_n_0 ;
  wire \FSM_onehot_wstate[3]_i_1_n_0 ;
  wire \FSM_onehot_wstate_reg[1]_0 ;
  wire \FSM_onehot_wstate_reg[2]_0 ;
  wire [61:0]O56;
  wire [31:0]Q;
  wire [0:0]SR;
  wire ap_clk;
  wire int_ramadr;
  wire int_ramadr3_out;
  wire \int_ramadr[31]_i_3_n_0 ;
  wire \int_ramadr[63]_i_3_n_0 ;
  wire [31:0]int_ramadr_reg0;
  wire [31:0]int_ramadr_reg02_out;
  wire int_status;
  wire [31:0]int_status0;
  wire \ram_addr_reg_160[10]_i_2_n_0 ;
  wire \ram_addr_reg_160[10]_i_3_n_0 ;
  wire \ram_addr_reg_160[10]_i_4_n_0 ;
  wire \ram_addr_reg_160[10]_i_5_n_0 ;
  wire \ram_addr_reg_160[14]_i_2_n_0 ;
  wire \ram_addr_reg_160[14]_i_3_n_0 ;
  wire \ram_addr_reg_160[14]_i_4_n_0 ;
  wire \ram_addr_reg_160[14]_i_5_n_0 ;
  wire \ram_addr_reg_160[18]_i_2_n_0 ;
  wire \ram_addr_reg_160[18]_i_3_n_0 ;
  wire \ram_addr_reg_160[18]_i_4_n_0 ;
  wire \ram_addr_reg_160[18]_i_5_n_0 ;
  wire \ram_addr_reg_160[22]_i_2_n_0 ;
  wire \ram_addr_reg_160[22]_i_3_n_0 ;
  wire \ram_addr_reg_160[22]_i_4_n_0 ;
  wire \ram_addr_reg_160[22]_i_5_n_0 ;
  wire \ram_addr_reg_160[26]_i_2_n_0 ;
  wire \ram_addr_reg_160[26]_i_3_n_0 ;
  wire \ram_addr_reg_160[26]_i_4_n_0 ;
  wire \ram_addr_reg_160[26]_i_5_n_0 ;
  wire \ram_addr_reg_160[2]_i_2_n_0 ;
  wire \ram_addr_reg_160[2]_i_3_n_0 ;
  wire \ram_addr_reg_160[2]_i_4_n_0 ;
  wire \ram_addr_reg_160[30]_i_2_n_0 ;
  wire \ram_addr_reg_160[30]_i_3_n_0 ;
  wire \ram_addr_reg_160[30]_i_4_n_0 ;
  wire \ram_addr_reg_160[30]_i_5_n_0 ;
  wire \ram_addr_reg_160[34]_i_2_n_0 ;
  wire \ram_addr_reg_160[6]_i_2_n_0 ;
  wire \ram_addr_reg_160[6]_i_3_n_0 ;
  wire \ram_addr_reg_160[6]_i_4_n_0 ;
  wire \ram_addr_reg_160[6]_i_5_n_0 ;
  wire \ram_addr_reg_160_reg[10]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[10]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[10]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[10]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[14]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[14]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[14]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[14]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[18]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[18]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[18]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[18]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[22]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[22]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[22]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[22]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[26]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[26]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[26]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[26]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[2]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[2]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[2]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[2]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[30]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[30]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[30]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[30]_i_1_n_3 ;
  wire [31:0]\ram_addr_reg_160_reg[34] ;
  wire \ram_addr_reg_160_reg[34]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[34]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[34]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[34]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[38]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[38]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[38]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[38]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[42]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[42]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[42]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[42]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[46]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[46]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[46]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[46]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[50]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[50]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[50]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[50]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[54]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[54]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[54]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[54]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[58]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[58]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[58]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[58]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[61]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[61]_i_1_n_3 ;
  wire \ram_addr_reg_160_reg[6]_i_1_n_0 ;
  wire \ram_addr_reg_160_reg[6]_i_1_n_1 ;
  wire \ram_addr_reg_160_reg[6]_i_1_n_2 ;
  wire \ram_addr_reg_160_reg[6]_i_1_n_3 ;
  wire [63:0]ramadr;
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
  wire [0:0]\NLW_ram_addr_reg_160_reg[2]_i_1_O_UNCONNECTED ;
  wire [3:2]\NLW_ram_addr_reg_160_reg[61]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_ram_addr_reg_160_reg[61]_i_1_O_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hF747)) 
    \FSM_onehot_rstate[1]_i_1 
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .I2(s_axi_control_RVALID),
        .I3(s_axi_control_RREADY),
        .O(\FSM_onehot_rstate[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
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
  LUT5 #(
    .INIT(32'h8F888FBB)) 
    \FSM_onehot_wstate[1]_i_1 
       (.I0(s_axi_control_BREADY),
        .I1(s_axi_control_BVALID),
        .I2(s_axi_control_AWVALID),
        .I3(\FSM_onehot_wstate_reg[1]_0 ),
        .I4(\FSM_onehot_wstate_reg[2]_0 ),
        .O(\FSM_onehot_wstate[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h88F8)) 
    \FSM_onehot_wstate[2]_i_1 
       (.I0(s_axi_control_AWVALID),
        .I1(\FSM_onehot_wstate_reg[1]_0 ),
        .I2(\FSM_onehot_wstate_reg[2]_0 ),
        .I3(s_axi_control_WVALID),
        .O(\FSM_onehot_wstate[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hD5C0)) 
    \FSM_onehot_wstate[3]_i_1 
       (.I0(s_axi_control_BREADY),
        .I1(\FSM_onehot_wstate_reg[2]_0 ),
        .I2(s_axi_control_WVALID),
        .I3(s_axi_control_BVALID),
        .O(\FSM_onehot_wstate[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[1]_i_1_n_0 ),
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
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[0]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[0]),
        .O(int_ramadr_reg02_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[10]_i_1 
       (.I0(s_axi_control_WDATA[10]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[10]),
        .O(int_ramadr_reg02_out[10]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[11]_i_1 
       (.I0(s_axi_control_WDATA[11]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[11]),
        .O(int_ramadr_reg02_out[11]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[12]_i_1 
       (.I0(s_axi_control_WDATA[12]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[12]),
        .O(int_ramadr_reg02_out[12]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[13]_i_1 
       (.I0(s_axi_control_WDATA[13]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[13]),
        .O(int_ramadr_reg02_out[13]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[14]_i_1 
       (.I0(s_axi_control_WDATA[14]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[14]),
        .O(int_ramadr_reg02_out[14]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[15]_i_1 
       (.I0(s_axi_control_WDATA[15]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[15]),
        .O(int_ramadr_reg02_out[15]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[16]_i_1 
       (.I0(s_axi_control_WDATA[16]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[16]),
        .O(int_ramadr_reg02_out[16]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[17]_i_1 
       (.I0(s_axi_control_WDATA[17]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[17]),
        .O(int_ramadr_reg02_out[17]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[18]_i_1 
       (.I0(s_axi_control_WDATA[18]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[18]),
        .O(int_ramadr_reg02_out[18]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[19]_i_1 
       (.I0(s_axi_control_WDATA[19]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[19]),
        .O(int_ramadr_reg02_out[19]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[1]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[1]),
        .O(int_ramadr_reg02_out[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[20]_i_1 
       (.I0(s_axi_control_WDATA[20]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[20]),
        .O(int_ramadr_reg02_out[20]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[21]_i_1 
       (.I0(s_axi_control_WDATA[21]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[21]),
        .O(int_ramadr_reg02_out[21]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[22]_i_1 
       (.I0(s_axi_control_WDATA[22]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[22]),
        .O(int_ramadr_reg02_out[22]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[23]_i_1 
       (.I0(s_axi_control_WDATA[23]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[23]),
        .O(int_ramadr_reg02_out[23]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[24]_i_1 
       (.I0(s_axi_control_WDATA[24]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[24]),
        .O(int_ramadr_reg02_out[24]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[25]_i_1 
       (.I0(s_axi_control_WDATA[25]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[25]),
        .O(int_ramadr_reg02_out[25]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[26]_i_1 
       (.I0(s_axi_control_WDATA[26]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[26]),
        .O(int_ramadr_reg02_out[26]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[27]_i_1 
       (.I0(s_axi_control_WDATA[27]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[27]),
        .O(int_ramadr_reg02_out[27]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[28]_i_1 
       (.I0(s_axi_control_WDATA[28]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[28]),
        .O(int_ramadr_reg02_out[28]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[29]_i_1 
       (.I0(s_axi_control_WDATA[29]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[29]),
        .O(int_ramadr_reg02_out[29]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[2]_i_1 
       (.I0(s_axi_control_WDATA[2]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[2]),
        .O(int_ramadr_reg02_out[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[30]_i_1 
       (.I0(s_axi_control_WDATA[30]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[30]),
        .O(int_ramadr_reg02_out[30]));
  LUT5 #(
    .INIT(32'h00200000)) 
    \int_ramadr[31]_i_1 
       (.I0(s_axi_control_WVALID),
        .I1(\waddr_reg_n_0_[2] ),
        .I2(\int_ramadr[31]_i_3_n_0 ),
        .I3(\waddr_reg_n_0_[3] ),
        .I4(\FSM_onehot_wstate_reg[2]_0 ),
        .O(int_ramadr3_out));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[31]_i_2 
       (.I0(s_axi_control_WDATA[31]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[31]),
        .O(int_ramadr_reg02_out[31]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \int_ramadr[31]_i_3 
       (.I0(\waddr_reg_n_0_[5] ),
        .I1(\waddr_reg_n_0_[4] ),
        .I2(\waddr_reg_n_0_[0] ),
        .I3(\waddr_reg_n_0_[1] ),
        .O(\int_ramadr[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[32]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[32]),
        .O(int_ramadr_reg0[0]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[33]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[33]),
        .O(int_ramadr_reg0[1]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[34]_i_1 
       (.I0(s_axi_control_WDATA[2]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[34]),
        .O(int_ramadr_reg0[2]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[35]_i_1 
       (.I0(s_axi_control_WDATA[3]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[35]),
        .O(int_ramadr_reg0[3]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[36]_i_1 
       (.I0(s_axi_control_WDATA[4]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[36]),
        .O(int_ramadr_reg0[4]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[37]_i_1 
       (.I0(s_axi_control_WDATA[5]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[37]),
        .O(int_ramadr_reg0[5]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[38]_i_1 
       (.I0(s_axi_control_WDATA[6]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[38]),
        .O(int_ramadr_reg0[6]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[39]_i_1 
       (.I0(s_axi_control_WDATA[7]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[39]),
        .O(int_ramadr_reg0[7]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[3]_i_1 
       (.I0(s_axi_control_WDATA[3]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[3]),
        .O(int_ramadr_reg02_out[3]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[40]_i_1 
       (.I0(s_axi_control_WDATA[8]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[40]),
        .O(int_ramadr_reg0[8]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[41]_i_1 
       (.I0(s_axi_control_WDATA[9]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[41]),
        .O(int_ramadr_reg0[9]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[42]_i_1 
       (.I0(s_axi_control_WDATA[10]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[42]),
        .O(int_ramadr_reg0[10]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[43]_i_1 
       (.I0(s_axi_control_WDATA[11]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[43]),
        .O(int_ramadr_reg0[11]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[44]_i_1 
       (.I0(s_axi_control_WDATA[12]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[44]),
        .O(int_ramadr_reg0[12]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[45]_i_1 
       (.I0(s_axi_control_WDATA[13]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[45]),
        .O(int_ramadr_reg0[13]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[46]_i_1 
       (.I0(s_axi_control_WDATA[14]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[46]),
        .O(int_ramadr_reg0[14]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[47]_i_1 
       (.I0(s_axi_control_WDATA[15]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[47]),
        .O(int_ramadr_reg0[15]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[48]_i_1 
       (.I0(s_axi_control_WDATA[16]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[48]),
        .O(int_ramadr_reg0[16]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[49]_i_1 
       (.I0(s_axi_control_WDATA[17]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[49]),
        .O(int_ramadr_reg0[17]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[4]_i_1 
       (.I0(s_axi_control_WDATA[4]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[4]),
        .O(int_ramadr_reg02_out[4]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[50]_i_1 
       (.I0(s_axi_control_WDATA[18]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[50]),
        .O(int_ramadr_reg0[18]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[51]_i_1 
       (.I0(s_axi_control_WDATA[19]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[51]),
        .O(int_ramadr_reg0[19]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[52]_i_1 
       (.I0(s_axi_control_WDATA[20]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[52]),
        .O(int_ramadr_reg0[20]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[53]_i_1 
       (.I0(s_axi_control_WDATA[21]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[53]),
        .O(int_ramadr_reg0[21]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[54]_i_1 
       (.I0(s_axi_control_WDATA[22]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[54]),
        .O(int_ramadr_reg0[22]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[55]_i_1 
       (.I0(s_axi_control_WDATA[23]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(ramadr[55]),
        .O(int_ramadr_reg0[23]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[56]_i_1 
       (.I0(s_axi_control_WDATA[24]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[56]),
        .O(int_ramadr_reg0[24]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[57]_i_1 
       (.I0(s_axi_control_WDATA[25]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[57]),
        .O(int_ramadr_reg0[25]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[58]_i_1 
       (.I0(s_axi_control_WDATA[26]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[58]),
        .O(int_ramadr_reg0[26]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[59]_i_1 
       (.I0(s_axi_control_WDATA[27]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[59]),
        .O(int_ramadr_reg0[27]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[5]_i_1 
       (.I0(s_axi_control_WDATA[5]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[5]),
        .O(int_ramadr_reg02_out[5]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[60]_i_1 
       (.I0(s_axi_control_WDATA[28]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[60]),
        .O(int_ramadr_reg0[28]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[61]_i_1 
       (.I0(s_axi_control_WDATA[29]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[61]),
        .O(int_ramadr_reg0[29]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[62]_i_1 
       (.I0(s_axi_control_WDATA[30]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[62]),
        .O(int_ramadr_reg0[30]));
  LUT4 #(
    .INIT(16'h0800)) 
    \int_ramadr[63]_i_1 
       (.I0(s_axi_control_WVALID),
        .I1(\int_ramadr[63]_i_3_n_0 ),
        .I2(\waddr_reg_n_0_[3] ),
        .I3(\FSM_onehot_wstate_reg[2]_0 ),
        .O(int_ramadr));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[63]_i_2 
       (.I0(s_axi_control_WDATA[31]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(ramadr[63]),
        .O(int_ramadr_reg0[31]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00100000)) 
    \int_ramadr[63]_i_3 
       (.I0(\waddr_reg_n_0_[1] ),
        .I1(\waddr_reg_n_0_[0] ),
        .I2(\waddr_reg_n_0_[4] ),
        .I3(\waddr_reg_n_0_[5] ),
        .I4(\waddr_reg_n_0_[2] ),
        .O(\int_ramadr[63]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[6]_i_1 
       (.I0(s_axi_control_WDATA[6]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[6]),
        .O(int_ramadr_reg02_out[6]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[7]_i_1 
       (.I0(s_axi_control_WDATA[7]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(ramadr[7]),
        .O(int_ramadr_reg02_out[7]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[8]_i_1 
       (.I0(s_axi_control_WDATA[8]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[8]),
        .O(int_ramadr_reg02_out[8]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_ramadr[9]_i_1 
       (.I0(s_axi_control_WDATA[9]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(ramadr[9]),
        .O(int_ramadr_reg02_out[9]));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[0] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[0]),
        .Q(ramadr[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[10] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[10]),
        .Q(ramadr[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[11] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[11]),
        .Q(ramadr[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[12] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[12]),
        .Q(ramadr[12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[13] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[13]),
        .Q(ramadr[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[14] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[14]),
        .Q(ramadr[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[15] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[15]),
        .Q(ramadr[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[16] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[16]),
        .Q(ramadr[16]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[17] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[17]),
        .Q(ramadr[17]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[18] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[18]),
        .Q(ramadr[18]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[19] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[19]),
        .Q(ramadr[19]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[1] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[1]),
        .Q(ramadr[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[20] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[20]),
        .Q(ramadr[20]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[21] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[21]),
        .Q(ramadr[21]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[22] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[22]),
        .Q(ramadr[22]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[23] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[23]),
        .Q(ramadr[23]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[24] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[24]),
        .Q(ramadr[24]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[25] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[25]),
        .Q(ramadr[25]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[26] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[26]),
        .Q(ramadr[26]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[27] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[27]),
        .Q(ramadr[27]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[28] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[28]),
        .Q(ramadr[28]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[29] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[29]),
        .Q(ramadr[29]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[2] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[2]),
        .Q(ramadr[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[30] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[30]),
        .Q(ramadr[30]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[31] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[31]),
        .Q(ramadr[31]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[32] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[0]),
        .Q(ramadr[32]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[33] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[1]),
        .Q(ramadr[33]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[34] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[2]),
        .Q(ramadr[34]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[35] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[3]),
        .Q(ramadr[35]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[36] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[4]),
        .Q(ramadr[36]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[37] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[5]),
        .Q(ramadr[37]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[38] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[6]),
        .Q(ramadr[38]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[39] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[7]),
        .Q(ramadr[39]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[3] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[3]),
        .Q(ramadr[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[40] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[8]),
        .Q(ramadr[40]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[41] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[9]),
        .Q(ramadr[41]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[42] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[10]),
        .Q(ramadr[42]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[43] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[11]),
        .Q(ramadr[43]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[44] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[12]),
        .Q(ramadr[44]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[45] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[13]),
        .Q(ramadr[45]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[46] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[14]),
        .Q(ramadr[46]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[47] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[15]),
        .Q(ramadr[47]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[48] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[16]),
        .Q(ramadr[48]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[49] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[17]),
        .Q(ramadr[49]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[4] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[4]),
        .Q(ramadr[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[50] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[18]),
        .Q(ramadr[50]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[51] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[19]),
        .Q(ramadr[51]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[52] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[20]),
        .Q(ramadr[52]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[53] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[21]),
        .Q(ramadr[53]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[54] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[22]),
        .Q(ramadr[54]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[55] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[23]),
        .Q(ramadr[55]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[56] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[24]),
        .Q(ramadr[56]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[57] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[25]),
        .Q(ramadr[57]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[58] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[26]),
        .Q(ramadr[58]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[59] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[27]),
        .Q(ramadr[59]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[5] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[5]),
        .Q(ramadr[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[60] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[28]),
        .Q(ramadr[60]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[61] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[29]),
        .Q(ramadr[61]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[62] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[30]),
        .Q(ramadr[62]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[63] 
       (.C(ap_clk),
        .CE(int_ramadr),
        .D(int_ramadr_reg0[31]),
        .Q(ramadr[63]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[6] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[6]),
        .Q(ramadr[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[7] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[7]),
        .Q(ramadr[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[8] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[8]),
        .Q(ramadr[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_ramadr_reg[9] 
       (.C(ap_clk),
        .CE(int_ramadr3_out),
        .D(int_ramadr_reg02_out[9]),
        .Q(ramadr[9]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[0]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[0]),
        .O(int_status0[0]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[10]_i_1 
       (.I0(s_axi_control_WDATA[10]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[10]),
        .O(int_status0[10]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[11]_i_1 
       (.I0(s_axi_control_WDATA[11]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[11]),
        .O(int_status0[11]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[12]_i_1 
       (.I0(s_axi_control_WDATA[12]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[12]),
        .O(int_status0[12]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[13]_i_1 
       (.I0(s_axi_control_WDATA[13]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[13]),
        .O(int_status0[13]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[14]_i_1 
       (.I0(s_axi_control_WDATA[14]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[14]),
        .O(int_status0[14]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[15]_i_1 
       (.I0(s_axi_control_WDATA[15]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[15]),
        .O(int_status0[15]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[16]_i_1 
       (.I0(s_axi_control_WDATA[16]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[16]),
        .O(int_status0[16]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[17]_i_1 
       (.I0(s_axi_control_WDATA[17]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[17]),
        .O(int_status0[17]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[18]_i_1 
       (.I0(s_axi_control_WDATA[18]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[18]),
        .O(int_status0[18]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[19]_i_1 
       (.I0(s_axi_control_WDATA[19]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[19]),
        .O(int_status0[19]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[1]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[1]),
        .O(int_status0[1]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[20]_i_1 
       (.I0(s_axi_control_WDATA[20]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[20]),
        .O(int_status0[20]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[21]_i_1 
       (.I0(s_axi_control_WDATA[21]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[21]),
        .O(int_status0[21]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[22]_i_1 
       (.I0(s_axi_control_WDATA[22]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[22]),
        .O(int_status0[22]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[23]_i_1 
       (.I0(s_axi_control_WDATA[23]),
        .I1(s_axi_control_WSTRB[2]),
        .I2(Q[23]),
        .O(int_status0[23]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[24]_i_1 
       (.I0(s_axi_control_WDATA[24]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[24]),
        .O(int_status0[24]));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[25]_i_1 
       (.I0(s_axi_control_WDATA[25]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[25]),
        .O(int_status0[25]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[26]_i_1 
       (.I0(s_axi_control_WDATA[26]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[26]),
        .O(int_status0[26]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[27]_i_1 
       (.I0(s_axi_control_WDATA[27]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[27]),
        .O(int_status0[27]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[28]_i_1 
       (.I0(s_axi_control_WDATA[28]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[28]),
        .O(int_status0[28]));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[29]_i_1 
       (.I0(s_axi_control_WDATA[29]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[29]),
        .O(int_status0[29]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[2]_i_1 
       (.I0(s_axi_control_WDATA[2]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[2]),
        .O(int_status0[2]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[30]_i_1 
       (.I0(s_axi_control_WDATA[30]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[30]),
        .O(int_status0[30]));
  LUT4 #(
    .INIT(16'h8000)) 
    \int_status[31]_i_1 
       (.I0(s_axi_control_WVALID),
        .I1(\int_ramadr[63]_i_3_n_0 ),
        .I2(\waddr_reg_n_0_[3] ),
        .I3(\FSM_onehot_wstate_reg[2]_0 ),
        .O(int_status));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[31]_i_2 
       (.I0(s_axi_control_WDATA[31]),
        .I1(s_axi_control_WSTRB[3]),
        .I2(Q[31]),
        .O(int_status0[31]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[3]_i_1 
       (.I0(s_axi_control_WDATA[3]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[3]),
        .O(int_status0[3]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[4]_i_1 
       (.I0(s_axi_control_WDATA[4]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[4]),
        .O(int_status0[4]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[5]_i_1 
       (.I0(s_axi_control_WDATA[5]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[5]),
        .O(int_status0[5]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[6]_i_1 
       (.I0(s_axi_control_WDATA[6]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[6]),
        .O(int_status0[6]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[7]_i_1 
       (.I0(s_axi_control_WDATA[7]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(Q[7]),
        .O(int_status0[7]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[8]_i_1 
       (.I0(s_axi_control_WDATA[8]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[8]),
        .O(int_status0[8]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \int_status[9]_i_1 
       (.I0(s_axi_control_WDATA[9]),
        .I1(s_axi_control_WSTRB[1]),
        .I2(Q[9]),
        .O(int_status0[9]));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[0] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[10] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[10]),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[11] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[11]),
        .Q(Q[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[12] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[12]),
        .Q(Q[12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[13] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[13]),
        .Q(Q[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[14] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[14]),
        .Q(Q[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[15] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[15]),
        .Q(Q[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[16] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[16]),
        .Q(Q[16]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[17] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[17]),
        .Q(Q[17]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[18] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[18]),
        .Q(Q[18]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[19] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[19]),
        .Q(Q[19]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[1] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[20] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[20]),
        .Q(Q[20]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[21] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[21]),
        .Q(Q[21]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[22] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[22]),
        .Q(Q[22]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[23] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[23]),
        .Q(Q[23]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[24] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[24]),
        .Q(Q[24]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[25] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[25]),
        .Q(Q[25]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[26] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[26]),
        .Q(Q[26]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[27] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[27]),
        .Q(Q[27]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[28] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[28]),
        .Q(Q[28]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[29] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[29]),
        .Q(Q[29]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[2] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[30] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[30]),
        .Q(Q[30]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[31] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[31]),
        .Q(Q[31]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[3] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[3]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[4] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[4]),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[5] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[5]),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[6] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[6]),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[7] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[7]),
        .Q(Q[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[8] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[8]),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_status_reg[9] 
       (.C(ap_clk),
        .CE(int_status),
        .D(int_status0[9]),
        .Q(Q[9]),
        .R(SR));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[10]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [10]),
        .I1(ramadr[12]),
        .O(\ram_addr_reg_160[10]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[10]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [9]),
        .I1(ramadr[11]),
        .O(\ram_addr_reg_160[10]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[10]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [8]),
        .I1(ramadr[10]),
        .O(\ram_addr_reg_160[10]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[10]_i_5 
       (.I0(\ram_addr_reg_160_reg[34] [7]),
        .I1(ramadr[9]),
        .O(\ram_addr_reg_160[10]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[14]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [14]),
        .I1(ramadr[16]),
        .O(\ram_addr_reg_160[14]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[14]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [13]),
        .I1(ramadr[15]),
        .O(\ram_addr_reg_160[14]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[14]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [12]),
        .I1(ramadr[14]),
        .O(\ram_addr_reg_160[14]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[14]_i_5 
       (.I0(\ram_addr_reg_160_reg[34] [11]),
        .I1(ramadr[13]),
        .O(\ram_addr_reg_160[14]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[18]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [18]),
        .I1(ramadr[20]),
        .O(\ram_addr_reg_160[18]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[18]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [17]),
        .I1(ramadr[19]),
        .O(\ram_addr_reg_160[18]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[18]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [16]),
        .I1(ramadr[18]),
        .O(\ram_addr_reg_160[18]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[18]_i_5 
       (.I0(\ram_addr_reg_160_reg[34] [15]),
        .I1(ramadr[17]),
        .O(\ram_addr_reg_160[18]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[22]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [22]),
        .I1(ramadr[24]),
        .O(\ram_addr_reg_160[22]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[22]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [21]),
        .I1(ramadr[23]),
        .O(\ram_addr_reg_160[22]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[22]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [20]),
        .I1(ramadr[22]),
        .O(\ram_addr_reg_160[22]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[22]_i_5 
       (.I0(\ram_addr_reg_160_reg[34] [19]),
        .I1(ramadr[21]),
        .O(\ram_addr_reg_160[22]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[26]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [26]),
        .I1(ramadr[28]),
        .O(\ram_addr_reg_160[26]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[26]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [25]),
        .I1(ramadr[27]),
        .O(\ram_addr_reg_160[26]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[26]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [24]),
        .I1(ramadr[26]),
        .O(\ram_addr_reg_160[26]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[26]_i_5 
       (.I0(\ram_addr_reg_160_reg[34] [23]),
        .I1(ramadr[25]),
        .O(\ram_addr_reg_160[26]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[2]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [2]),
        .I1(ramadr[4]),
        .O(\ram_addr_reg_160[2]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[2]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [1]),
        .I1(ramadr[3]),
        .O(\ram_addr_reg_160[2]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[2]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [0]),
        .I1(ramadr[2]),
        .O(\ram_addr_reg_160[2]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[30]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [30]),
        .I1(ramadr[32]),
        .O(\ram_addr_reg_160[30]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[30]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [29]),
        .I1(ramadr[31]),
        .O(\ram_addr_reg_160[30]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[30]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [28]),
        .I1(ramadr[30]),
        .O(\ram_addr_reg_160[30]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[30]_i_5 
       (.I0(\ram_addr_reg_160_reg[34] [27]),
        .I1(ramadr[29]),
        .O(\ram_addr_reg_160[30]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[34]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [31]),
        .I1(ramadr[33]),
        .O(\ram_addr_reg_160[34]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[6]_i_2 
       (.I0(\ram_addr_reg_160_reg[34] [6]),
        .I1(ramadr[8]),
        .O(\ram_addr_reg_160[6]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[6]_i_3 
       (.I0(\ram_addr_reg_160_reg[34] [5]),
        .I1(ramadr[7]),
        .O(\ram_addr_reg_160[6]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[6]_i_4 
       (.I0(\ram_addr_reg_160_reg[34] [4]),
        .I1(ramadr[6]),
        .O(\ram_addr_reg_160[6]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ram_addr_reg_160[6]_i_5 
       (.I0(\ram_addr_reg_160_reg[34] [3]),
        .I1(ramadr[5]),
        .O(\ram_addr_reg_160[6]_i_5_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[10]_i_1 
       (.CI(\ram_addr_reg_160_reg[6]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[10]_i_1_n_0 ,\ram_addr_reg_160_reg[10]_i_1_n_1 ,\ram_addr_reg_160_reg[10]_i_1_n_2 ,\ram_addr_reg_160_reg[10]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\ram_addr_reg_160_reg[34] [10:7]),
        .O(O56[10:7]),
        .S({\ram_addr_reg_160[10]_i_2_n_0 ,\ram_addr_reg_160[10]_i_3_n_0 ,\ram_addr_reg_160[10]_i_4_n_0 ,\ram_addr_reg_160[10]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[14]_i_1 
       (.CI(\ram_addr_reg_160_reg[10]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[14]_i_1_n_0 ,\ram_addr_reg_160_reg[14]_i_1_n_1 ,\ram_addr_reg_160_reg[14]_i_1_n_2 ,\ram_addr_reg_160_reg[14]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\ram_addr_reg_160_reg[34] [14:11]),
        .O(O56[14:11]),
        .S({\ram_addr_reg_160[14]_i_2_n_0 ,\ram_addr_reg_160[14]_i_3_n_0 ,\ram_addr_reg_160[14]_i_4_n_0 ,\ram_addr_reg_160[14]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[18]_i_1 
       (.CI(\ram_addr_reg_160_reg[14]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[18]_i_1_n_0 ,\ram_addr_reg_160_reg[18]_i_1_n_1 ,\ram_addr_reg_160_reg[18]_i_1_n_2 ,\ram_addr_reg_160_reg[18]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\ram_addr_reg_160_reg[34] [18:15]),
        .O(O56[18:15]),
        .S({\ram_addr_reg_160[18]_i_2_n_0 ,\ram_addr_reg_160[18]_i_3_n_0 ,\ram_addr_reg_160[18]_i_4_n_0 ,\ram_addr_reg_160[18]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[22]_i_1 
       (.CI(\ram_addr_reg_160_reg[18]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[22]_i_1_n_0 ,\ram_addr_reg_160_reg[22]_i_1_n_1 ,\ram_addr_reg_160_reg[22]_i_1_n_2 ,\ram_addr_reg_160_reg[22]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\ram_addr_reg_160_reg[34] [22:19]),
        .O(O56[22:19]),
        .S({\ram_addr_reg_160[22]_i_2_n_0 ,\ram_addr_reg_160[22]_i_3_n_0 ,\ram_addr_reg_160[22]_i_4_n_0 ,\ram_addr_reg_160[22]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[26]_i_1 
       (.CI(\ram_addr_reg_160_reg[22]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[26]_i_1_n_0 ,\ram_addr_reg_160_reg[26]_i_1_n_1 ,\ram_addr_reg_160_reg[26]_i_1_n_2 ,\ram_addr_reg_160_reg[26]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\ram_addr_reg_160_reg[34] [26:23]),
        .O(O56[26:23]),
        .S({\ram_addr_reg_160[26]_i_2_n_0 ,\ram_addr_reg_160[26]_i_3_n_0 ,\ram_addr_reg_160[26]_i_4_n_0 ,\ram_addr_reg_160[26]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[2]_i_1 
       (.CI(1'b0),
        .CO({\ram_addr_reg_160_reg[2]_i_1_n_0 ,\ram_addr_reg_160_reg[2]_i_1_n_1 ,\ram_addr_reg_160_reg[2]_i_1_n_2 ,\ram_addr_reg_160_reg[2]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\ram_addr_reg_160_reg[34] [2:0],1'b0}),
        .O({O56[2:0],\NLW_ram_addr_reg_160_reg[2]_i_1_O_UNCONNECTED [0]}),
        .S({\ram_addr_reg_160[2]_i_2_n_0 ,\ram_addr_reg_160[2]_i_3_n_0 ,\ram_addr_reg_160[2]_i_4_n_0 ,ramadr[1]}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[30]_i_1 
       (.CI(\ram_addr_reg_160_reg[26]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[30]_i_1_n_0 ,\ram_addr_reg_160_reg[30]_i_1_n_1 ,\ram_addr_reg_160_reg[30]_i_1_n_2 ,\ram_addr_reg_160_reg[30]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\ram_addr_reg_160_reg[34] [30:27]),
        .O(O56[30:27]),
        .S({\ram_addr_reg_160[30]_i_2_n_0 ,\ram_addr_reg_160[30]_i_3_n_0 ,\ram_addr_reg_160[30]_i_4_n_0 ,\ram_addr_reg_160[30]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[34]_i_1 
       (.CI(\ram_addr_reg_160_reg[30]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[34]_i_1_n_0 ,\ram_addr_reg_160_reg[34]_i_1_n_1 ,\ram_addr_reg_160_reg[34]_i_1_n_2 ,\ram_addr_reg_160_reg[34]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,\ram_addr_reg_160_reg[34] [31]}),
        .O(O56[34:31]),
        .S({ramadr[36:34],\ram_addr_reg_160[34]_i_2_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[38]_i_1 
       (.CI(\ram_addr_reg_160_reg[34]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[38]_i_1_n_0 ,\ram_addr_reg_160_reg[38]_i_1_n_1 ,\ram_addr_reg_160_reg[38]_i_1_n_2 ,\ram_addr_reg_160_reg[38]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(O56[38:35]),
        .S(ramadr[40:37]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[42]_i_1 
       (.CI(\ram_addr_reg_160_reg[38]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[42]_i_1_n_0 ,\ram_addr_reg_160_reg[42]_i_1_n_1 ,\ram_addr_reg_160_reg[42]_i_1_n_2 ,\ram_addr_reg_160_reg[42]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(O56[42:39]),
        .S(ramadr[44:41]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[46]_i_1 
       (.CI(\ram_addr_reg_160_reg[42]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[46]_i_1_n_0 ,\ram_addr_reg_160_reg[46]_i_1_n_1 ,\ram_addr_reg_160_reg[46]_i_1_n_2 ,\ram_addr_reg_160_reg[46]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(O56[46:43]),
        .S(ramadr[48:45]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[50]_i_1 
       (.CI(\ram_addr_reg_160_reg[46]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[50]_i_1_n_0 ,\ram_addr_reg_160_reg[50]_i_1_n_1 ,\ram_addr_reg_160_reg[50]_i_1_n_2 ,\ram_addr_reg_160_reg[50]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(O56[50:47]),
        .S(ramadr[52:49]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[54]_i_1 
       (.CI(\ram_addr_reg_160_reg[50]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[54]_i_1_n_0 ,\ram_addr_reg_160_reg[54]_i_1_n_1 ,\ram_addr_reg_160_reg[54]_i_1_n_2 ,\ram_addr_reg_160_reg[54]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(O56[54:51]),
        .S(ramadr[56:53]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[58]_i_1 
       (.CI(\ram_addr_reg_160_reg[54]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[58]_i_1_n_0 ,\ram_addr_reg_160_reg[58]_i_1_n_1 ,\ram_addr_reg_160_reg[58]_i_1_n_2 ,\ram_addr_reg_160_reg[58]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(O56[58:55]),
        .S(ramadr[60:57]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[61]_i_1 
       (.CI(\ram_addr_reg_160_reg[58]_i_1_n_0 ),
        .CO({\NLW_ram_addr_reg_160_reg[61]_i_1_CO_UNCONNECTED [3:2],\ram_addr_reg_160_reg[61]_i_1_n_2 ,\ram_addr_reg_160_reg[61]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_ram_addr_reg_160_reg[61]_i_1_O_UNCONNECTED [3],O56[61:59]}),
        .S({1'b0,ramadr[63:61]}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ram_addr_reg_160_reg[6]_i_1 
       (.CI(\ram_addr_reg_160_reg[2]_i_1_n_0 ),
        .CO({\ram_addr_reg_160_reg[6]_i_1_n_0 ,\ram_addr_reg_160_reg[6]_i_1_n_1 ,\ram_addr_reg_160_reg[6]_i_1_n_2 ,\ram_addr_reg_160_reg[6]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\ram_addr_reg_160_reg[34] [6:3]),
        .O(O56[6:3]),
        .S({\ram_addr_reg_160[6]_i_2_n_0 ,\ram_addr_reg_160[6]_i_3_n_0 ,\ram_addr_reg_160[6]_i_4_n_0 ,\ram_addr_reg_160[6]_i_5_n_0 }));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[0]_i_1 
       (.I0(ramadr[0]),
        .I1(ramadr[32]),
        .I2(Q[0]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[10]_i_1 
       (.I0(ramadr[10]),
        .I1(ramadr[42]),
        .I2(Q[10]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[11]_i_1 
       (.I0(ramadr[11]),
        .I1(ramadr[43]),
        .I2(Q[11]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[12]_i_1 
       (.I0(ramadr[12]),
        .I1(ramadr[44]),
        .I2(Q[12]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[13]_i_1 
       (.I0(ramadr[13]),
        .I1(ramadr[45]),
        .I2(Q[13]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[14]_i_1 
       (.I0(ramadr[14]),
        .I1(ramadr[46]),
        .I2(Q[14]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[15]_i_1 
       (.I0(ramadr[15]),
        .I1(ramadr[47]),
        .I2(Q[15]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[16]_i_1 
       (.I0(ramadr[16]),
        .I1(ramadr[48]),
        .I2(Q[16]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[17]_i_1 
       (.I0(ramadr[17]),
        .I1(ramadr[49]),
        .I2(Q[17]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[18]_i_1 
       (.I0(ramadr[18]),
        .I1(ramadr[50]),
        .I2(Q[18]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[19]_i_1 
       (.I0(ramadr[19]),
        .I1(ramadr[51]),
        .I2(Q[19]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[1]_i_1 
       (.I0(ramadr[1]),
        .I1(ramadr[33]),
        .I2(Q[1]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[20]_i_1 
       (.I0(ramadr[20]),
        .I1(ramadr[52]),
        .I2(Q[20]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[21]_i_1 
       (.I0(ramadr[21]),
        .I1(ramadr[53]),
        .I2(Q[21]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[22]_i_1 
       (.I0(ramadr[22]),
        .I1(ramadr[54]),
        .I2(Q[22]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[23]_i_1 
       (.I0(ramadr[23]),
        .I1(ramadr[55]),
        .I2(Q[23]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[24]_i_1 
       (.I0(ramadr[24]),
        .I1(ramadr[56]),
        .I2(Q[24]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[25]_i_1 
       (.I0(ramadr[25]),
        .I1(ramadr[57]),
        .I2(Q[25]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[26]_i_1 
       (.I0(ramadr[26]),
        .I1(ramadr[58]),
        .I2(Q[26]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[27]_i_1 
       (.I0(ramadr[27]),
        .I1(ramadr[59]),
        .I2(Q[27]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[28]_i_1 
       (.I0(ramadr[28]),
        .I1(ramadr[60]),
        .I2(Q[28]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[29]_i_1 
       (.I0(ramadr[29]),
        .I1(ramadr[61]),
        .I2(Q[29]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[2]_i_1 
       (.I0(ramadr[2]),
        .I1(ramadr[34]),
        .I2(Q[2]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[30]_i_1 
       (.I0(ramadr[30]),
        .I1(ramadr[62]),
        .I2(Q[30]),
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
       (.I0(ramadr[31]),
        .I1(ramadr[63]),
        .I2(Q[31]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[31]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[3]_i_1 
       (.I0(ramadr[3]),
        .I1(ramadr[35]),
        .I2(Q[3]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[4]_i_1 
       (.I0(ramadr[4]),
        .I1(ramadr[36]),
        .I2(Q[4]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[5]_i_1 
       (.I0(ramadr[5]),
        .I1(ramadr[37]),
        .I2(Q[5]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[6]_i_1 
       (.I0(ramadr[6]),
        .I1(ramadr[38]),
        .I2(Q[6]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[7]_i_1 
       (.I0(ramadr[7]),
        .I1(ramadr[39]),
        .I2(Q[7]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[8]_i_1 
       (.I0(ramadr[8]),
        .I1(ramadr[40]),
        .I2(Q[8]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[2]),
        .O(\rdata[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF0CC00AA)) 
    \rdata[9]_i_1 
       (.I0(ramadr[9]),
        .I1(ramadr[41]),
        .I2(Q[9]),
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
       (.I0(s_axi_control_AWVALID),
        .I1(\FSM_onehot_wstate_reg[1]_0 ),
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

(* ORIG_REF_NAME = "sound_operation_ram_m_axi" *) 
module design_1_sound_operation_0_7_sound_operation_ram_m_axi
   (full_n_reg,
    SR,
    \could_multi_bursts.ARVALID_Dummy_reg ,
    m_axi_ram_ARADDR,
    E,
    ap_NS_fsm,
    \could_multi_bursts.arlen_buf_reg[4] ,
    \data_p1_reg[31] ,
    ap_clk,
    D,
    m_axi_ram_RRESP,
    m_axi_ram_RVALID,
    ap_rst_n,
    m_axi_ram_ARREADY,
    Q,
    \data_p2_reg[61] );
  output full_n_reg;
  output [0:0]SR;
  output \could_multi_bursts.ARVALID_Dummy_reg ;
  output [61:0]m_axi_ram_ARADDR;
  output [0:0]E;
  output [2:0]ap_NS_fsm;
  output [4:0]\could_multi_bursts.arlen_buf_reg[4] ;
  output [31:0]\data_p1_reg[31] ;
  input ap_clk;
  input [32:0]D;
  input [1:0]m_axi_ram_RRESP;
  input m_axi_ram_RVALID;
  input ap_rst_n;
  input m_axi_ram_ARREADY;
  input [3:0]Q;
  input [61:0]\data_p2_reg[61] ;

  wire [32:0]D;
  wire [0:0]E;
  wire [3:0]Q;
  wire [0:0]SR;
  wire [2:0]ap_NS_fsm;
  wire ap_clk;
  wire ap_rst_n;
  wire \could_multi_bursts.ARVALID_Dummy_reg ;
  wire [4:0]\could_multi_bursts.arlen_buf_reg[4] ;
  wire [31:0]\data_p1_reg[31] ;
  wire [61:0]\data_p2_reg[61] ;
  wire full_n_reg;
  wire [61:0]m_axi_ram_ARADDR;
  wire m_axi_ram_ARREADY;
  wire [1:0]m_axi_ram_RRESP;
  wire m_axi_ram_RVALID;

  design_1_sound_operation_0_7_sound_operation_ram_m_axi_read bus_read
       (.D(D),
        .E(E),
        .Q(Q),
        .SR(SR),
        .ap_NS_fsm(ap_NS_fsm),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .\could_multi_bursts.ARVALID_Dummy_reg_0 (\could_multi_bursts.ARVALID_Dummy_reg ),
        .\could_multi_bursts.arlen_buf_reg[4]_0 (\could_multi_bursts.arlen_buf_reg[4] ),
        .\data_p1_reg[31] (\data_p1_reg[31] ),
        .\data_p2_reg[61] (\data_p2_reg[61] ),
        .full_n_reg(full_n_reg),
        .m_axi_ram_ARADDR(m_axi_ram_ARADDR),
        .m_axi_ram_ARREADY(m_axi_ram_ARREADY),
        .m_axi_ram_RRESP(m_axi_ram_RRESP),
        .m_axi_ram_RVALID(m_axi_ram_RVALID));
endmodule

(* ORIG_REF_NAME = "sound_operation_ram_m_axi_buffer" *) 
module design_1_sound_operation_0_7_sound_operation_ram_m_axi_buffer__parameterized0
   (full_n_reg_0,
    beat_valid,
    SR,
    DI,
    Q,
    empty_n_reg_0,
    \dout_buf_reg[34]_0 ,
    dout_valid_reg_0,
    S,
    \mOutPtr_reg[8]_0 ,
    ap_clk,
    D,
    m_axi_ram_RRESP,
    m_axi_ram_RVALID,
    ap_rst_n,
    dout_valid_reg_1,
    rdata_ack_t,
    \pout_reg[3] ,
    \mOutPtr_reg[8]_1 );
  output full_n_reg_0;
  output beat_valid;
  output [0:0]SR;
  output [3:0]DI;
  output [3:0]Q;
  output empty_n_reg_0;
  output [32:0]\dout_buf_reg[34]_0 ;
  output dout_valid_reg_0;
  output [3:0]S;
  output [3:0]\mOutPtr_reg[8]_0 ;
  input ap_clk;
  input [32:0]D;
  input [1:0]m_axi_ram_RRESP;
  input m_axi_ram_RVALID;
  input ap_rst_n;
  input dout_valid_reg_1;
  input rdata_ack_t;
  input \pout_reg[3] ;
  input [7:0]\mOutPtr_reg[8]_1 ;

  wire [32:0]D;
  wire [3:0]DI;
  wire [3:0]Q;
  wire [3:0]S;
  wire [0:0]SR;
  wire ap_clk;
  wire ap_rst_n;
  wire beat_valid;
  wire \dout_buf[0]_i_1_n_0 ;
  wire \dout_buf[10]_i_1_n_0 ;
  wire \dout_buf[11]_i_1_n_0 ;
  wire \dout_buf[12]_i_1_n_0 ;
  wire \dout_buf[13]_i_1_n_0 ;
  wire \dout_buf[14]_i_1_n_0 ;
  wire \dout_buf[15]_i_1_n_0 ;
  wire \dout_buf[16]_i_1_n_0 ;
  wire \dout_buf[17]_i_1_n_0 ;
  wire \dout_buf[18]_i_1_n_0 ;
  wire \dout_buf[19]_i_1_n_0 ;
  wire \dout_buf[1]_i_1_n_0 ;
  wire \dout_buf[20]_i_1_n_0 ;
  wire \dout_buf[21]_i_1_n_0 ;
  wire \dout_buf[22]_i_1_n_0 ;
  wire \dout_buf[23]_i_1_n_0 ;
  wire \dout_buf[24]_i_1_n_0 ;
  wire \dout_buf[25]_i_1_n_0 ;
  wire \dout_buf[26]_i_1_n_0 ;
  wire \dout_buf[27]_i_1_n_0 ;
  wire \dout_buf[28]_i_1_n_0 ;
  wire \dout_buf[29]_i_1_n_0 ;
  wire \dout_buf[2]_i_1_n_0 ;
  wire \dout_buf[30]_i_1_n_0 ;
  wire \dout_buf[31]_i_1_n_0 ;
  wire \dout_buf[34]_i_2_n_0 ;
  wire \dout_buf[3]_i_1_n_0 ;
  wire \dout_buf[4]_i_1_n_0 ;
  wire \dout_buf[5]_i_1_n_0 ;
  wire \dout_buf[6]_i_1_n_0 ;
  wire \dout_buf[7]_i_1_n_0 ;
  wire \dout_buf[8]_i_1_n_0 ;
  wire \dout_buf[9]_i_1_n_0 ;
  wire [32:0]\dout_buf_reg[34]_0 ;
  wire dout_valid_i_1_n_0;
  wire dout_valid_reg_0;
  wire dout_valid_reg_1;
  wire empty_n_i_1_n_0;
  wire empty_n_i_2_n_0;
  wire empty_n_i_3_n_0;
  wire empty_n_reg_0;
  wire empty_n_reg_n_0;
  wire full_n_i_1_n_0;
  wire full_n_i_2__1_n_0;
  wire full_n_i_3__1_n_0;
  wire full_n_reg_0;
  wire \mOutPtr[0]_i_1_n_0 ;
  wire \mOutPtr[8]_i_1_n_0 ;
  wire [8:7]mOutPtr_reg;
  wire [3:0]\mOutPtr_reg[8]_0 ;
  wire [7:0]\mOutPtr_reg[8]_1 ;
  wire [1:0]m_axi_ram_RRESP;
  wire m_axi_ram_RVALID;
  wire mem_reg_i_10_n_0;
  wire mem_reg_i_11_n_0;
  wire mem_reg_i_12_n_0;
  wire mem_reg_i_13_n_0;
  wire mem_reg_i_14_n_0;
  wire mem_reg_n_32;
  wire mem_reg_n_33;
  wire pop;
  wire \pout_reg[3] ;
  wire push;
  wire [34:0]q_buf;
  wire [34:0]q_tmp;
  wire [8:0]raddr;
  wire rdata_ack_t;
  wire [8:0]rnext;
  wire show_ahead;
  wire show_ahead0;
  wire show_ahead1;
  wire show_ahead1_carry_i_1_n_0;
  wire show_ahead1_carry_i_2_n_0;
  wire show_ahead1_carry_i_3_n_0;
  wire show_ahead1_carry_n_2;
  wire show_ahead1_carry_n_3;
  wire [8:0]waddr;
  wire \waddr[0]_i_1_n_0 ;
  wire \waddr[1]_i_1_n_0 ;
  wire \waddr[2]_i_1_n_0 ;
  wire \waddr[3]_i_1_n_0 ;
  wire \waddr[4]_i_1_n_0 ;
  wire \waddr[5]_i_1__0_n_0 ;
  wire \waddr[6]_i_1_n_0 ;
  wire \waddr[6]_i_2_n_0 ;
  wire \waddr[7]_i_1_n_0 ;
  wire \waddr[8]_i_2_n_0 ;
  wire \waddr[8]_i_3_n_0 ;
  wire \waddr[8]_i_4_n_0 ;
  wire [1:1]NLW_mem_reg_DOPBDOP_UNCONNECTED;
  wire [3:3]NLW_show_ahead1_carry_CO_UNCONNECTED;
  wire [3:0]NLW_show_ahead1_carry_O_UNCONNECTED;

  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \bus_equal_gen.rdata_valid_t_i_1 
       (.I0(beat_valid),
        .I1(rdata_ack_t),
        .I2(dout_valid_reg_1),
        .O(dout_valid_reg_0));
  LUT1 #(
    .INIT(2'h1)) 
    \could_multi_bursts.araddr_buf[63]_i_1 
       (.I0(ap_rst_n),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[0]_i_1 
       (.I0(q_tmp[0]),
        .I1(q_buf[0]),
        .I2(show_ahead),
        .O(\dout_buf[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[10]_i_1 
       (.I0(q_tmp[10]),
        .I1(q_buf[10]),
        .I2(show_ahead),
        .O(\dout_buf[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[11]_i_1 
       (.I0(q_tmp[11]),
        .I1(q_buf[11]),
        .I2(show_ahead),
        .O(\dout_buf[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[12]_i_1 
       (.I0(q_tmp[12]),
        .I1(q_buf[12]),
        .I2(show_ahead),
        .O(\dout_buf[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[13]_i_1 
       (.I0(q_tmp[13]),
        .I1(q_buf[13]),
        .I2(show_ahead),
        .O(\dout_buf[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[14]_i_1 
       (.I0(q_tmp[14]),
        .I1(q_buf[14]),
        .I2(show_ahead),
        .O(\dout_buf[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[15]_i_1 
       (.I0(q_tmp[15]),
        .I1(q_buf[15]),
        .I2(show_ahead),
        .O(\dout_buf[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[16]_i_1 
       (.I0(q_tmp[16]),
        .I1(q_buf[16]),
        .I2(show_ahead),
        .O(\dout_buf[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[17]_i_1 
       (.I0(q_tmp[17]),
        .I1(q_buf[17]),
        .I2(show_ahead),
        .O(\dout_buf[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[18]_i_1 
       (.I0(q_tmp[18]),
        .I1(q_buf[18]),
        .I2(show_ahead),
        .O(\dout_buf[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[19]_i_1 
       (.I0(q_tmp[19]),
        .I1(q_buf[19]),
        .I2(show_ahead),
        .O(\dout_buf[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[1]_i_1 
       (.I0(q_tmp[1]),
        .I1(q_buf[1]),
        .I2(show_ahead),
        .O(\dout_buf[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[20]_i_1 
       (.I0(q_tmp[20]),
        .I1(q_buf[20]),
        .I2(show_ahead),
        .O(\dout_buf[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[21]_i_1 
       (.I0(q_tmp[21]),
        .I1(q_buf[21]),
        .I2(show_ahead),
        .O(\dout_buf[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[22]_i_1 
       (.I0(q_tmp[22]),
        .I1(q_buf[22]),
        .I2(show_ahead),
        .O(\dout_buf[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[23]_i_1 
       (.I0(q_tmp[23]),
        .I1(q_buf[23]),
        .I2(show_ahead),
        .O(\dout_buf[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[24]_i_1 
       (.I0(q_tmp[24]),
        .I1(q_buf[24]),
        .I2(show_ahead),
        .O(\dout_buf[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[25]_i_1 
       (.I0(q_tmp[25]),
        .I1(q_buf[25]),
        .I2(show_ahead),
        .O(\dout_buf[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[26]_i_1 
       (.I0(q_tmp[26]),
        .I1(q_buf[26]),
        .I2(show_ahead),
        .O(\dout_buf[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[27]_i_1 
       (.I0(q_tmp[27]),
        .I1(q_buf[27]),
        .I2(show_ahead),
        .O(\dout_buf[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[28]_i_1 
       (.I0(q_tmp[28]),
        .I1(q_buf[28]),
        .I2(show_ahead),
        .O(\dout_buf[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[29]_i_1 
       (.I0(q_tmp[29]),
        .I1(q_buf[29]),
        .I2(show_ahead),
        .O(\dout_buf[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[2]_i_1 
       (.I0(q_tmp[2]),
        .I1(q_buf[2]),
        .I2(show_ahead),
        .O(\dout_buf[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[30]_i_1 
       (.I0(q_tmp[30]),
        .I1(q_buf[30]),
        .I2(show_ahead),
        .O(\dout_buf[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[31]_i_1 
       (.I0(q_tmp[31]),
        .I1(q_buf[31]),
        .I2(show_ahead),
        .O(\dout_buf[31]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8AAA)) 
    \dout_buf[34]_i_1 
       (.I0(empty_n_reg_n_0),
        .I1(rdata_ack_t),
        .I2(dout_valid_reg_1),
        .I3(beat_valid),
        .O(pop));
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[34]_i_2 
       (.I0(q_tmp[34]),
        .I1(q_buf[34]),
        .I2(show_ahead),
        .O(\dout_buf[34]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[3]_i_1 
       (.I0(q_tmp[3]),
        .I1(q_buf[3]),
        .I2(show_ahead),
        .O(\dout_buf[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[4]_i_1 
       (.I0(q_tmp[4]),
        .I1(q_buf[4]),
        .I2(show_ahead),
        .O(\dout_buf[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[5]_i_1 
       (.I0(q_tmp[5]),
        .I1(q_buf[5]),
        .I2(show_ahead),
        .O(\dout_buf[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[6]_i_1 
       (.I0(q_tmp[6]),
        .I1(q_buf[6]),
        .I2(show_ahead),
        .O(\dout_buf[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[7]_i_1 
       (.I0(q_tmp[7]),
        .I1(q_buf[7]),
        .I2(show_ahead),
        .O(\dout_buf[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[8]_i_1 
       (.I0(q_tmp[8]),
        .I1(q_buf[8]),
        .I2(show_ahead),
        .O(\dout_buf[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \dout_buf[9]_i_1 
       (.I0(q_tmp[9]),
        .I1(q_buf[9]),
        .I2(show_ahead),
        .O(\dout_buf[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[0] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[0]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[10] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[10]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[11] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[11]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[12] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[12]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[13] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[13]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[14] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[14]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[15] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[15]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[16] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[16]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [16]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[17] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[17]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [17]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[18] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[18]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [18]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[19] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[19]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [19]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[1] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[1]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[20] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[20]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [20]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[21] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[21]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [21]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[22] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[22]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [22]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[23] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[23]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [23]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[24] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[24]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [24]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[25] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[25]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [25]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[26] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[26]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [26]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[27] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[27]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [27]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[28] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[28]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [28]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[29] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[29]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [29]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[2] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[2]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[30] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[30]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [30]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[31] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[31]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [31]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[34] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[34]_i_2_n_0 ),
        .Q(\dout_buf_reg[34]_0 [32]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[3] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[3]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[4] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[4]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[5] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[5]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[6] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[6]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[7] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[7]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[8] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[8]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \dout_buf_reg[9] 
       (.C(ap_clk),
        .CE(pop),
        .D(\dout_buf[9]_i_1_n_0 ),
        .Q(\dout_buf_reg[34]_0 [9]),
        .R(SR));
  LUT4 #(
    .INIT(16'hBAAA)) 
    dout_valid_i_1
       (.I0(empty_n_reg_n_0),
        .I1(rdata_ack_t),
        .I2(dout_valid_reg_1),
        .I3(beat_valid),
        .O(dout_valid_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dout_valid_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(dout_valid_i_1_n_0),
        .Q(beat_valid),
        .R(SR));
  LUT6 #(
    .INIT(64'hFF7F7F7F0F707070)) 
    empty_n_i_1
       (.I0(empty_n_i_2_n_0),
        .I1(empty_n_i_3_n_0),
        .I2(pop),
        .I3(m_axi_ram_RVALID),
        .I4(full_n_reg_0),
        .I5(empty_n_reg_n_0),
        .O(empty_n_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000100)) 
    empty_n_i_2
       (.I0(Q[2]),
        .I1(DI[3]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(DI[2]),
        .I5(DI[1]),
        .O(empty_n_i_2_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    empty_n_i_3
       (.I0(Q[3]),
        .I1(mOutPtr_reg[7]),
        .I2(mOutPtr_reg[8]),
        .O(empty_n_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    empty_n_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(empty_n_i_1_n_0),
        .Q(empty_n_reg_n_0),
        .R(SR));
  LUT6 #(
    .INIT(64'hFFFFFFFFFD55FF55)) 
    full_n_i_1
       (.I0(ap_rst_n),
        .I1(full_n_i_2__1_n_0),
        .I2(full_n_i_3__1_n_0),
        .I3(full_n_reg_0),
        .I4(m_axi_ram_RVALID),
        .I5(pop),
        .O(full_n_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    full_n_i_2__1
       (.I0(Q[2]),
        .I1(Q[0]),
        .I2(DI[3]),
        .O(full_n_i_2__1_n_0));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    full_n_i_3__1
       (.I0(mOutPtr_reg[7]),
        .I1(mOutPtr_reg[8]),
        .I2(DI[2]),
        .I3(Q[1]),
        .I4(DI[1]),
        .I5(Q[3]),
        .O(full_n_i_3__1_n_0));
  FDRE #(
    .INIT(1'b1)) 
    full_n_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(full_n_i_1_n_0),
        .Q(full_n_reg_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \mOutPtr[0]_i_1 
       (.I0(Q[0]),
        .O(\mOutPtr[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h08FFF700F700F700)) 
    \mOutPtr[8]_i_1 
       (.I0(beat_valid),
        .I1(dout_valid_reg_1),
        .I2(rdata_ack_t),
        .I3(empty_n_reg_n_0),
        .I4(full_n_reg_0),
        .I5(m_axi_ram_RVALID),
        .O(\mOutPtr[8]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[0] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr[0]_i_1_n_0 ),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[1] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [0]),
        .Q(DI[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[2] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [1]),
        .Q(DI[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[3] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [2]),
        .Q(DI[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[4] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [3]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[5] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [4]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[6] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [5]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[7] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [6]),
        .Q(mOutPtr_reg[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \mOutPtr_reg[8] 
       (.C(ap_clk),
        .CE(\mOutPtr[8]_i_1_n_0 ),
        .D(\mOutPtr_reg[8]_1 [7]),
        .Q(mOutPtr_reg[8]),
        .R(SR));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p3_d32" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p3_d32" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "17920" *) 
  (* RTL_RAM_NAME = "ram_m_axi_U/bus_read/buff_rdata/mem" *) 
  (* RTL_RAM_TYPE = "RAM_SDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "34" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .RAM_MODE("SDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(36),
    .READ_WIDTH_B(0),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(0),
    .WRITE_WIDTH_B(36)) 
    mem_reg
       (.ADDRARDADDR({rnext,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({waddr,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CLKARDCLK(ap_clk),
        .CLKBWRCLK(ap_clk),
        .DIADI(D[15:0]),
        .DIBDI(D[31:16]),
        .DIPADIP(m_axi_ram_RRESP),
        .DIPBDIP({1'b1,D[32]}),
        .DOADO(q_buf[15:0]),
        .DOBDO(q_buf[31:16]),
        .DOPADOP({mem_reg_n_32,mem_reg_n_33}),
        .DOPBDOP({NLW_mem_reg_DOPBDOP_UNCONNECTED[1],q_buf[34]}),
        .ENARDEN(1'b1),
        .ENBWREN(full_n_reg_0),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({1'b0,1'b0}),
        .WEBWE({m_axi_ram_RVALID,m_axi_ram_RVALID,m_axi_ram_RVALID,m_axi_ram_RVALID}));
  LUT5 #(
    .INIT(32'hDF20FF00)) 
    mem_reg_i_1
       (.I0(raddr[6]),
        .I1(mem_reg_i_10_n_0),
        .I2(raddr[7]),
        .I3(raddr[8]),
        .I4(pop),
        .O(rnext[8]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    mem_reg_i_10
       (.I0(raddr[4]),
        .I1(raddr[2]),
        .I2(raddr[0]),
        .I3(raddr[1]),
        .I4(raddr[3]),
        .I5(raddr[5]),
        .O(mem_reg_i_10_n_0));
  LUT6 #(
    .INIT(64'h00000000F7000000)) 
    mem_reg_i_11
       (.I0(beat_valid),
        .I1(dout_valid_reg_1),
        .I2(rdata_ack_t),
        .I3(empty_n_reg_n_0),
        .I4(raddr[6]),
        .I5(mem_reg_i_10_n_0),
        .O(mem_reg_i_11_n_0));
  LUT5 #(
    .INIT(32'h00800000)) 
    mem_reg_i_12
       (.I0(pop),
        .I1(raddr[8]),
        .I2(raddr[7]),
        .I3(mem_reg_i_10_n_0),
        .I4(raddr[6]),
        .O(mem_reg_i_12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'h7FFF)) 
    mem_reg_i_13
       (.I0(raddr[2]),
        .I1(raddr[0]),
        .I2(raddr[1]),
        .I3(raddr[3]),
        .O(mem_reg_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    mem_reg_i_14
       (.I0(pop),
        .I1(raddr[3]),
        .I2(raddr[1]),
        .I3(raddr[0]),
        .I4(raddr[2]),
        .O(mem_reg_i_14_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    mem_reg_i_2
       (.I0(raddr[7]),
        .I1(mem_reg_i_11_n_0),
        .O(rnext[7]));
  LUT6 #(
    .INIT(64'h9CCC9C9C9C9C9C9C)) 
    mem_reg_i_3
       (.I0(mem_reg_i_10_n_0),
        .I1(raddr[6]),
        .I2(empty_n_reg_n_0),
        .I3(rdata_ack_t),
        .I4(dout_valid_reg_1),
        .I5(beat_valid),
        .O(rnext[6]));
  LUT5 #(
    .INIT(32'h51045500)) 
    mem_reg_i_4
       (.I0(mem_reg_i_12_n_0),
        .I1(raddr[4]),
        .I2(mem_reg_i_13_n_0),
        .I3(raddr[5]),
        .I4(pop),
        .O(rnext[5]));
  LUT3 #(
    .INIT(8'h06)) 
    mem_reg_i_5
       (.I0(raddr[4]),
        .I1(mem_reg_i_14_n_0),
        .I2(mem_reg_i_12_n_0),
        .O(rnext[4]));
  LUT6 #(
    .INIT(64'h1555400055550000)) 
    mem_reg_i_6
       (.I0(mem_reg_i_12_n_0),
        .I1(raddr[2]),
        .I2(raddr[0]),
        .I3(raddr[1]),
        .I4(raddr[3]),
        .I5(pop),
        .O(rnext[3]));
  LUT5 #(
    .INIT(32'h15405500)) 
    mem_reg_i_7
       (.I0(mem_reg_i_12_n_0),
        .I1(raddr[1]),
        .I2(raddr[0]),
        .I3(raddr[2]),
        .I4(pop),
        .O(rnext[2]));
  LUT6 #(
    .INIT(64'h6A666666AAAAAAAA)) 
    mem_reg_i_8
       (.I0(raddr[1]),
        .I1(empty_n_reg_n_0),
        .I2(rdata_ack_t),
        .I3(dout_valid_reg_1),
        .I4(beat_valid),
        .I5(raddr[0]),
        .O(rnext[1]));
  LUT5 #(
    .INIT(32'h5595AAAA)) 
    mem_reg_i_9
       (.I0(raddr[0]),
        .I1(beat_valid),
        .I2(dout_valid_reg_1),
        .I3(rdata_ack_t),
        .I4(empty_n_reg_n_0),
        .O(rnext[0]));
  LUT2 #(
    .INIT(4'h9)) 
    p_0_out_carry__0_i_1
       (.I0(mOutPtr_reg[8]),
        .I1(mOutPtr_reg[7]),
        .O(\mOutPtr_reg[8]_0 [3]));
  LUT2 #(
    .INIT(4'h9)) 
    p_0_out_carry__0_i_2
       (.I0(Q[3]),
        .I1(mOutPtr_reg[7]),
        .O(\mOutPtr_reg[8]_0 [2]));
  LUT2 #(
    .INIT(4'h9)) 
    p_0_out_carry__0_i_3
       (.I0(Q[2]),
        .I1(Q[3]),
        .O(\mOutPtr_reg[8]_0 [1]));
  LUT2 #(
    .INIT(4'h9)) 
    p_0_out_carry__0_i_4
       (.I0(Q[1]),
        .I1(Q[2]),
        .O(\mOutPtr_reg[8]_0 [0]));
  LUT6 #(
    .INIT(64'h0000800088888888)) 
    p_0_out_carry_i_1
       (.I0(full_n_reg_0),
        .I1(m_axi_ram_RVALID),
        .I2(beat_valid),
        .I3(dout_valid_reg_1),
        .I4(rdata_ack_t),
        .I5(empty_n_reg_n_0),
        .O(DI[0]));
  LUT2 #(
    .INIT(4'h9)) 
    p_0_out_carry_i_2
       (.I0(DI[3]),
        .I1(Q[1]),
        .O(S[3]));
  LUT2 #(
    .INIT(4'h9)) 
    p_0_out_carry_i_3
       (.I0(DI[2]),
        .I1(DI[3]),
        .O(S[2]));
  LUT2 #(
    .INIT(4'h9)) 
    p_0_out_carry_i_4
       (.I0(DI[1]),
        .I1(DI[2]),
        .O(S[1]));
  LUT4 #(
    .INIT(16'h6555)) 
    p_0_out_carry_i_5
       (.I0(DI[1]),
        .I1(pop),
        .I2(m_axi_ram_RVALID),
        .I3(full_n_reg_0),
        .O(S[0]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT5 #(
    .INIT(32'h22A2AAAA)) 
    \pout[3]_i_4 
       (.I0(\pout_reg[3] ),
        .I1(beat_valid),
        .I2(dout_valid_reg_1),
        .I3(rdata_ack_t),
        .I4(\dout_buf_reg[34]_0 [32]),
        .O(empty_n_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[0] 
       (.C(ap_clk),
        .CE(push),
        .D(D[0]),
        .Q(q_tmp[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[10] 
       (.C(ap_clk),
        .CE(push),
        .D(D[10]),
        .Q(q_tmp[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[11] 
       (.C(ap_clk),
        .CE(push),
        .D(D[11]),
        .Q(q_tmp[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[12] 
       (.C(ap_clk),
        .CE(push),
        .D(D[12]),
        .Q(q_tmp[12]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[13] 
       (.C(ap_clk),
        .CE(push),
        .D(D[13]),
        .Q(q_tmp[13]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[14] 
       (.C(ap_clk),
        .CE(push),
        .D(D[14]),
        .Q(q_tmp[14]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[15] 
       (.C(ap_clk),
        .CE(push),
        .D(D[15]),
        .Q(q_tmp[15]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[16] 
       (.C(ap_clk),
        .CE(push),
        .D(D[16]),
        .Q(q_tmp[16]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[17] 
       (.C(ap_clk),
        .CE(push),
        .D(D[17]),
        .Q(q_tmp[17]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[18] 
       (.C(ap_clk),
        .CE(push),
        .D(D[18]),
        .Q(q_tmp[18]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[19] 
       (.C(ap_clk),
        .CE(push),
        .D(D[19]),
        .Q(q_tmp[19]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[1] 
       (.C(ap_clk),
        .CE(push),
        .D(D[1]),
        .Q(q_tmp[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[20] 
       (.C(ap_clk),
        .CE(push),
        .D(D[20]),
        .Q(q_tmp[20]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[21] 
       (.C(ap_clk),
        .CE(push),
        .D(D[21]),
        .Q(q_tmp[21]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[22] 
       (.C(ap_clk),
        .CE(push),
        .D(D[22]),
        .Q(q_tmp[22]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[23] 
       (.C(ap_clk),
        .CE(push),
        .D(D[23]),
        .Q(q_tmp[23]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[24] 
       (.C(ap_clk),
        .CE(push),
        .D(D[24]),
        .Q(q_tmp[24]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[25] 
       (.C(ap_clk),
        .CE(push),
        .D(D[25]),
        .Q(q_tmp[25]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[26] 
       (.C(ap_clk),
        .CE(push),
        .D(D[26]),
        .Q(q_tmp[26]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[27] 
       (.C(ap_clk),
        .CE(push),
        .D(D[27]),
        .Q(q_tmp[27]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[28] 
       (.C(ap_clk),
        .CE(push),
        .D(D[28]),
        .Q(q_tmp[28]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[29] 
       (.C(ap_clk),
        .CE(push),
        .D(D[29]),
        .Q(q_tmp[29]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[2] 
       (.C(ap_clk),
        .CE(push),
        .D(D[2]),
        .Q(q_tmp[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[30] 
       (.C(ap_clk),
        .CE(push),
        .D(D[30]),
        .Q(q_tmp[30]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[31] 
       (.C(ap_clk),
        .CE(push),
        .D(D[31]),
        .Q(q_tmp[31]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[34] 
       (.C(ap_clk),
        .CE(push),
        .D(D[32]),
        .Q(q_tmp[34]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[3] 
       (.C(ap_clk),
        .CE(push),
        .D(D[3]),
        .Q(q_tmp[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[4] 
       (.C(ap_clk),
        .CE(push),
        .D(D[4]),
        .Q(q_tmp[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[5] 
       (.C(ap_clk),
        .CE(push),
        .D(D[5]),
        .Q(q_tmp[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[6] 
       (.C(ap_clk),
        .CE(push),
        .D(D[6]),
        .Q(q_tmp[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[7] 
       (.C(ap_clk),
        .CE(push),
        .D(D[7]),
        .Q(q_tmp[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[8] 
       (.C(ap_clk),
        .CE(push),
        .D(D[8]),
        .Q(q_tmp[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \q_tmp_reg[9] 
       (.C(ap_clk),
        .CE(push),
        .D(D[9]),
        .Q(q_tmp[9]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[0]),
        .Q(raddr[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[1]),
        .Q(raddr[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[2]),
        .Q(raddr[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[3]),
        .Q(raddr[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[4] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[4]),
        .Q(raddr[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[5] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[5]),
        .Q(raddr[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[6] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[6]),
        .Q(raddr[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[7] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[7]),
        .Q(raddr[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \raddr_reg[8] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(rnext[8]),
        .Q(raddr[8]),
        .R(SR));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 show_ahead1_carry
       (.CI(1'b0),
        .CO({NLW_show_ahead1_carry_CO_UNCONNECTED[3],show_ahead1,show_ahead1_carry_n_2,show_ahead1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_show_ahead1_carry_O_UNCONNECTED[3:0]),
        .S({1'b0,show_ahead1_carry_i_1_n_0,show_ahead1_carry_i_2_n_0,show_ahead1_carry_i_3_n_0}));
  LUT3 #(
    .INIT(8'h01)) 
    show_ahead1_carry_i_1
       (.I0(Q[3]),
        .I1(mOutPtr_reg[7]),
        .I2(mOutPtr_reg[8]),
        .O(show_ahead1_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    show_ahead1_carry_i_2
       (.I0(Q[1]),
        .I1(DI[3]),
        .I2(Q[2]),
        .O(show_ahead1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h1001)) 
    show_ahead1_carry_i_3
       (.I0(DI[1]),
        .I1(DI[2]),
        .I2(pop),
        .I3(Q[0]),
        .O(show_ahead1_carry_i_3_n_0));
  LUT3 #(
    .INIT(8'h80)) 
    show_ahead_i_1
       (.I0(show_ahead1),
        .I1(full_n_reg_0),
        .I2(m_axi_ram_RVALID),
        .O(show_ahead0));
  FDRE #(
    .INIT(1'b0)) 
    show_ahead_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(show_ahead0),
        .Q(show_ahead),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \waddr[0]_i_1 
       (.I0(waddr[0]),
        .O(\waddr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \waddr[1]_i_1 
       (.I0(waddr[0]),
        .I1(waddr[1]),
        .O(\waddr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \waddr[2]_i_1 
       (.I0(waddr[2]),
        .I1(waddr[0]),
        .I2(waddr[1]),
        .O(\waddr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \waddr[3]_i_1 
       (.I0(waddr[3]),
        .I1(waddr[0]),
        .I2(waddr[1]),
        .I3(waddr[2]),
        .O(\waddr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \waddr[4]_i_1 
       (.I0(waddr[4]),
        .I1(waddr[2]),
        .I2(waddr[1]),
        .I3(waddr[0]),
        .I4(waddr[3]),
        .O(\waddr[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \waddr[5]_i_1__0 
       (.I0(waddr[5]),
        .I1(waddr[3]),
        .I2(waddr[0]),
        .I3(waddr[1]),
        .I4(waddr[2]),
        .I5(waddr[4]),
        .O(\waddr[5]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \waddr[6]_i_1 
       (.I0(waddr[6]),
        .I1(waddr[4]),
        .I2(waddr[2]),
        .I3(\waddr[6]_i_2_n_0 ),
        .I4(waddr[3]),
        .I5(waddr[5]),
        .O(\waddr[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \waddr[6]_i_2 
       (.I0(waddr[1]),
        .I1(waddr[0]),
        .O(\waddr[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT4 #(
    .INIT(16'hB8CC)) 
    \waddr[7]_i_1 
       (.I0(\waddr[8]_i_3_n_0 ),
        .I1(waddr[7]),
        .I2(\waddr[8]_i_4_n_0 ),
        .I3(waddr[6]),
        .O(\waddr[7]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \waddr[8]_i_1 
       (.I0(m_axi_ram_RVALID),
        .I1(full_n_reg_0),
        .O(push));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT5 #(
    .INIT(32'hBC8CCCCC)) 
    \waddr[8]_i_2 
       (.I0(\waddr[8]_i_3_n_0 ),
        .I1(waddr[8]),
        .I2(waddr[6]),
        .I3(\waddr[8]_i_4_n_0 ),
        .I4(waddr[7]),
        .O(\waddr[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \waddr[8]_i_3 
       (.I0(waddr[4]),
        .I1(waddr[2]),
        .I2(waddr[0]),
        .I3(waddr[1]),
        .I4(waddr[3]),
        .I5(waddr[5]),
        .O(\waddr[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \waddr[8]_i_4 
       (.I0(waddr[4]),
        .I1(waddr[2]),
        .I2(waddr[1]),
        .I3(waddr[0]),
        .I4(waddr[3]),
        .I5(waddr[5]),
        .O(\waddr[8]_i_4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[0] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[0]_i_1_n_0 ),
        .Q(waddr[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[1] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[1]_i_1_n_0 ),
        .Q(waddr[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[2] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[2]_i_1_n_0 ),
        .Q(waddr[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[3] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[3]_i_1_n_0 ),
        .Q(waddr[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[4] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[4]_i_1_n_0 ),
        .Q(waddr[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[5] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[5]_i_1__0_n_0 ),
        .Q(waddr[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[6] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[6]_i_1_n_0 ),
        .Q(waddr[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[7] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[7]_i_1_n_0 ),
        .Q(waddr[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \waddr_reg[8] 
       (.C(ap_clk),
        .CE(push),
        .D(\waddr[8]_i_2_n_0 ),
        .Q(waddr[8]),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "sound_operation_ram_m_axi_fifo" *) 
module design_1_sound_operation_0_7_sound_operation_ram_m_axi_fifo__parameterized0
   (fifo_rreq_valid,
    rs2f_rreq_ack,
    D,
    next_rreq,
    \sect_len_buf_reg[7] ,
    \sect_len_buf_reg[6] ,
    S,
    \q_reg[64]_0 ,
    invalid_len_event0,
    SR,
    E,
    ap_clk,
    ap_rst_n,
    p_21_in,
    CO,
    full_n_reg_0,
    push,
    Q,
    \sect_cnt_reg[51] ,
    sect_cnt0,
    fifo_rreq_valid_buf_reg,
    \sect_len_buf_reg[7]_0 ,
    \sect_len_buf_reg[7]_1 ,
    \q_reg[61]_0 );
  output fifo_rreq_valid;
  output rs2f_rreq_ack;
  output [51:0]D;
  output next_rreq;
  output \sect_len_buf_reg[7] ;
  output \sect_len_buf_reg[6] ;
  output [0:0]S;
  output [62:0]\q_reg[64]_0 ;
  output invalid_len_event0;
  input [0:0]SR;
  input [0:0]E;
  input ap_clk;
  input ap_rst_n;
  input p_21_in;
  input [0:0]CO;
  input full_n_reg_0;
  input push;
  input [0:0]Q;
  input [51:0]\sect_cnt_reg[51] ;
  input [50:0]sect_cnt0;
  input fifo_rreq_valid_buf_reg;
  input [4:0]\sect_len_buf_reg[7]_0 ;
  input [4:0]\sect_len_buf_reg[7]_1 ;
  input [61:0]\q_reg[61]_0 ;

  wire [0:0]CO;
  wire [51:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire ap_clk;
  wire ap_rst_n;
  wire data_vld_i_1_n_0;
  wire data_vld_reg_n_0;
  wire fifo_rreq_valid;
  wire fifo_rreq_valid_buf_i_2_n_0;
  wire fifo_rreq_valid_buf_reg;
  wire full_n_i_1__0_n_0;
  wire full_n_i_2_n_0;
  wire full_n_i_3_n_0;
  wire full_n_reg_0;
  wire invalid_len_event0;
  wire \mem_reg[4][0]_srl5_n_0 ;
  wire \mem_reg[4][10]_srl5_n_0 ;
  wire \mem_reg[4][11]_srl5_n_0 ;
  wire \mem_reg[4][12]_srl5_n_0 ;
  wire \mem_reg[4][13]_srl5_n_0 ;
  wire \mem_reg[4][14]_srl5_n_0 ;
  wire \mem_reg[4][15]_srl5_n_0 ;
  wire \mem_reg[4][16]_srl5_n_0 ;
  wire \mem_reg[4][17]_srl5_n_0 ;
  wire \mem_reg[4][18]_srl5_n_0 ;
  wire \mem_reg[4][19]_srl5_n_0 ;
  wire \mem_reg[4][1]_srl5_n_0 ;
  wire \mem_reg[4][20]_srl5_n_0 ;
  wire \mem_reg[4][21]_srl5_n_0 ;
  wire \mem_reg[4][22]_srl5_n_0 ;
  wire \mem_reg[4][23]_srl5_n_0 ;
  wire \mem_reg[4][24]_srl5_n_0 ;
  wire \mem_reg[4][25]_srl5_n_0 ;
  wire \mem_reg[4][26]_srl5_n_0 ;
  wire \mem_reg[4][27]_srl5_n_0 ;
  wire \mem_reg[4][28]_srl5_n_0 ;
  wire \mem_reg[4][29]_srl5_n_0 ;
  wire \mem_reg[4][2]_srl5_n_0 ;
  wire \mem_reg[4][30]_srl5_n_0 ;
  wire \mem_reg[4][31]_srl5_n_0 ;
  wire \mem_reg[4][32]_srl5_n_0 ;
  wire \mem_reg[4][33]_srl5_n_0 ;
  wire \mem_reg[4][34]_srl5_n_0 ;
  wire \mem_reg[4][35]_srl5_n_0 ;
  wire \mem_reg[4][36]_srl5_n_0 ;
  wire \mem_reg[4][37]_srl5_n_0 ;
  wire \mem_reg[4][38]_srl5_n_0 ;
  wire \mem_reg[4][39]_srl5_n_0 ;
  wire \mem_reg[4][3]_srl5_n_0 ;
  wire \mem_reg[4][40]_srl5_n_0 ;
  wire \mem_reg[4][41]_srl5_n_0 ;
  wire \mem_reg[4][42]_srl5_n_0 ;
  wire \mem_reg[4][43]_srl5_n_0 ;
  wire \mem_reg[4][44]_srl5_n_0 ;
  wire \mem_reg[4][45]_srl5_n_0 ;
  wire \mem_reg[4][46]_srl5_n_0 ;
  wire \mem_reg[4][47]_srl5_n_0 ;
  wire \mem_reg[4][48]_srl5_n_0 ;
  wire \mem_reg[4][49]_srl5_n_0 ;
  wire \mem_reg[4][4]_srl5_n_0 ;
  wire \mem_reg[4][50]_srl5_n_0 ;
  wire \mem_reg[4][51]_srl5_n_0 ;
  wire \mem_reg[4][52]_srl5_n_0 ;
  wire \mem_reg[4][53]_srl5_n_0 ;
  wire \mem_reg[4][54]_srl5_n_0 ;
  wire \mem_reg[4][55]_srl5_n_0 ;
  wire \mem_reg[4][56]_srl5_n_0 ;
  wire \mem_reg[4][57]_srl5_n_0 ;
  wire \mem_reg[4][58]_srl5_n_0 ;
  wire \mem_reg[4][59]_srl5_n_0 ;
  wire \mem_reg[4][5]_srl5_n_0 ;
  wire \mem_reg[4][60]_srl5_n_0 ;
  wire \mem_reg[4][61]_srl5_n_0 ;
  wire \mem_reg[4][64]_srl5_n_0 ;
  wire \mem_reg[4][6]_srl5_n_0 ;
  wire \mem_reg[4][7]_srl5_n_0 ;
  wire \mem_reg[4][8]_srl5_n_0 ;
  wire \mem_reg[4][9]_srl5_n_0 ;
  wire next_rreq;
  wire p_21_in;
  wire \pout[0]_i_1_n_0 ;
  wire \pout[0]_i_2_n_0 ;
  wire \pout[1]_i_1_n_0 ;
  wire \pout[2]_i_1_n_0 ;
  wire \pout[2]_i_2_n_0 ;
  wire \pout_reg_n_0_[0] ;
  wire \pout_reg_n_0_[1] ;
  wire \pout_reg_n_0_[2] ;
  wire push;
  wire [61:0]\q_reg[61]_0 ;
  wire [62:0]\q_reg[64]_0 ;
  wire rs2f_rreq_ack;
  wire [50:0]sect_cnt0;
  wire [51:0]\sect_cnt_reg[51] ;
  wire \sect_len_buf_reg[6] ;
  wire \sect_len_buf_reg[7] ;
  wire [4:0]\sect_len_buf_reg[7]_0 ;
  wire [4:0]\sect_len_buf_reg[7]_1 ;

  LUT1 #(
    .INIT(2'h1)) 
    align_len0_carry_i_1
       (.I0(\q_reg[64]_0 [62]),
        .O(S));
  LUT6 #(
    .INIT(64'hFFFEFFFFAAAAAAAA)) 
    data_vld_i_1
       (.I0(push),
        .I1(\pout_reg_n_0_[2] ),
        .I2(\pout_reg_n_0_[1] ),
        .I3(\pout_reg_n_0_[0] ),
        .I4(\pout[0]_i_2_n_0 ),
        .I5(data_vld_reg_n_0),
        .O(data_vld_i_1_n_0));
  FDRE data_vld_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(data_vld_i_1_n_0),
        .Q(data_vld_reg_n_0),
        .R(SR));
  FDRE empty_n_reg
       (.C(ap_clk),
        .CE(E),
        .D(data_vld_reg_n_0),
        .Q(fifo_rreq_valid),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT1 #(
    .INIT(2'h1)) 
    fifo_rreq_valid_buf_i_1
       (.I0(fifo_rreq_valid_buf_i_2_n_0),
        .O(next_rreq));
  LUT5 #(
    .INIT(32'h11F1F1F1)) 
    fifo_rreq_valid_buf_i_2
       (.I0(fifo_rreq_valid),
        .I1(fifo_rreq_valid_buf_reg),
        .I2(full_n_reg_0),
        .I3(CO),
        .I4(p_21_in),
        .O(fifo_rreq_valid_buf_i_2_n_0));
  LUT6 #(
    .INIT(64'hFBFBFBFBFBFBFBBB)) 
    full_n_i_1__0
       (.I0(\pout[0]_i_2_n_0 ),
        .I1(ap_rst_n),
        .I2(rs2f_rreq_ack),
        .I3(full_n_i_2_n_0),
        .I4(full_n_i_3_n_0),
        .I5(\pout_reg_n_0_[2] ),
        .O(full_n_i_1__0_n_0));
  LUT6 #(
    .INIT(64'h8FFFFFFFFFFFFFFF)) 
    full_n_i_2
       (.I0(p_21_in),
        .I1(CO),
        .I2(full_n_reg_0),
        .I3(fifo_rreq_valid),
        .I4(push),
        .I5(data_vld_reg_n_0),
        .O(full_n_i_2_n_0));
  LUT2 #(
    .INIT(4'h7)) 
    full_n_i_3
       (.I0(\pout_reg_n_0_[0] ),
        .I1(\pout_reg_n_0_[1] ),
        .O(full_n_i_3_n_0));
  FDRE full_n_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(full_n_i_1__0_n_0),
        .Q(rs2f_rreq_ack),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    invalid_len_event_i_1
       (.I0(fifo_rreq_valid),
        .I1(\q_reg[64]_0 [62]),
        .O(invalid_len_event0));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][0]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][0]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [0]),
        .Q(\mem_reg[4][0]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][10]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][10]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [10]),
        .Q(\mem_reg[4][10]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][11]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][11]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [11]),
        .Q(\mem_reg[4][11]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][12]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][12]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [12]),
        .Q(\mem_reg[4][12]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][13]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][13]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [13]),
        .Q(\mem_reg[4][13]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][14]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][14]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [14]),
        .Q(\mem_reg[4][14]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][15]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][15]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [15]),
        .Q(\mem_reg[4][15]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][16]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][16]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [16]),
        .Q(\mem_reg[4][16]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][17]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][17]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [17]),
        .Q(\mem_reg[4][17]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][18]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][18]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [18]),
        .Q(\mem_reg[4][18]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][19]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][19]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [19]),
        .Q(\mem_reg[4][19]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][1]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][1]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [1]),
        .Q(\mem_reg[4][1]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][20]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][20]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [20]),
        .Q(\mem_reg[4][20]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][21]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][21]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [21]),
        .Q(\mem_reg[4][21]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][22]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][22]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [22]),
        .Q(\mem_reg[4][22]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][23]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][23]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [23]),
        .Q(\mem_reg[4][23]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][24]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][24]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [24]),
        .Q(\mem_reg[4][24]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][25]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][25]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [25]),
        .Q(\mem_reg[4][25]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][26]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][26]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [26]),
        .Q(\mem_reg[4][26]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][27]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][27]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [27]),
        .Q(\mem_reg[4][27]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][28]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][28]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [28]),
        .Q(\mem_reg[4][28]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][29]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][29]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [29]),
        .Q(\mem_reg[4][29]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][2]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][2]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [2]),
        .Q(\mem_reg[4][2]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][30]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][30]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [30]),
        .Q(\mem_reg[4][30]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][31]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][31]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [31]),
        .Q(\mem_reg[4][31]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][32]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][32]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [32]),
        .Q(\mem_reg[4][32]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][33]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][33]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [33]),
        .Q(\mem_reg[4][33]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][34]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][34]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [34]),
        .Q(\mem_reg[4][34]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][35]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][35]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [35]),
        .Q(\mem_reg[4][35]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][36]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][36]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [36]),
        .Q(\mem_reg[4][36]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][37]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][37]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [37]),
        .Q(\mem_reg[4][37]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][38]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][38]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [38]),
        .Q(\mem_reg[4][38]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][39]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][39]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [39]),
        .Q(\mem_reg[4][39]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][3]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][3]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [3]),
        .Q(\mem_reg[4][3]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][40]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][40]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [40]),
        .Q(\mem_reg[4][40]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][41]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][41]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [41]),
        .Q(\mem_reg[4][41]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][42]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][42]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [42]),
        .Q(\mem_reg[4][42]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][43]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][43]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [43]),
        .Q(\mem_reg[4][43]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][44]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][44]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [44]),
        .Q(\mem_reg[4][44]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][45]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][45]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [45]),
        .Q(\mem_reg[4][45]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][46]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][46]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [46]),
        .Q(\mem_reg[4][46]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][47]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][47]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [47]),
        .Q(\mem_reg[4][47]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][48]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][48]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [48]),
        .Q(\mem_reg[4][48]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][49]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][49]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [49]),
        .Q(\mem_reg[4][49]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][4]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][4]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [4]),
        .Q(\mem_reg[4][4]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][50]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][50]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [50]),
        .Q(\mem_reg[4][50]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][51]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][51]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [51]),
        .Q(\mem_reg[4][51]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][52]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][52]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [52]),
        .Q(\mem_reg[4][52]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][53]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][53]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [53]),
        .Q(\mem_reg[4][53]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][54]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][54]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [54]),
        .Q(\mem_reg[4][54]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][55]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][55]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [55]),
        .Q(\mem_reg[4][55]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][56]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][56]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [56]),
        .Q(\mem_reg[4][56]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][57]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][57]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [57]),
        .Q(\mem_reg[4][57]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][58]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][58]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [58]),
        .Q(\mem_reg[4][58]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][59]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][59]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [59]),
        .Q(\mem_reg[4][59]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][5]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][5]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [5]),
        .Q(\mem_reg[4][5]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][60]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][60]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [60]),
        .Q(\mem_reg[4][60]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][61]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][61]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [61]),
        .Q(\mem_reg[4][61]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][64]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][64]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(1'b1),
        .Q(\mem_reg[4][64]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][6]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][6]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [6]),
        .Q(\mem_reg[4][6]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][7]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][7]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [7]),
        .Q(\mem_reg[4][7]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][8]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][8]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [8]),
        .Q(\mem_reg[4][8]_srl5_n_0 ));
  (* srl_bus_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4] " *) 
  (* srl_name = "inst/\ram_m_axi_U/bus_read/fifo_rreq/mem_reg[4][9]_srl5 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \mem_reg[4][9]_srl5 
       (.A0(\pout_reg_n_0_[0] ),
        .A1(\pout_reg_n_0_[1] ),
        .A2(\pout_reg_n_0_[2] ),
        .A3(1'b0),
        .CE(push),
        .CLK(ap_clk),
        .D(\q_reg[61]_0 [9]),
        .Q(\mem_reg[4][9]_srl5_n_0 ));
  LUT6 #(
    .INIT(64'hA7A7A7A758585808)) 
    \pout[0]_i_1 
       (.I0(push),
        .I1(data_vld_reg_n_0),
        .I2(\pout[0]_i_2_n_0 ),
        .I3(\pout_reg_n_0_[2] ),
        .I4(\pout_reg_n_0_[1] ),
        .I5(\pout_reg_n_0_[0] ),
        .O(\pout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT5 #(
    .INIT(32'h80AAAAAA)) 
    \pout[0]_i_2 
       (.I0(data_vld_reg_n_0),
        .I1(p_21_in),
        .I2(CO),
        .I3(full_n_reg_0),
        .I4(fifo_rreq_valid),
        .O(\pout[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h66CCCCCCCCCC98CC)) 
    \pout[1]_i_1 
       (.I0(\pout_reg_n_0_[0] ),
        .I1(\pout_reg_n_0_[1] ),
        .I2(\pout_reg_n_0_[2] ),
        .I3(data_vld_reg_n_0),
        .I4(\pout[2]_i_2_n_0 ),
        .I5(push),
        .O(\pout[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h78F0F0F0F0F0E0F0)) 
    \pout[2]_i_1 
       (.I0(\pout_reg_n_0_[0] ),
        .I1(\pout_reg_n_0_[1] ),
        .I2(\pout_reg_n_0_[2] ),
        .I3(data_vld_reg_n_0),
        .I4(\pout[2]_i_2_n_0 ),
        .I5(push),
        .O(\pout[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT4 #(
    .INIT(16'h0888)) 
    \pout[2]_i_2 
       (.I0(fifo_rreq_valid),
        .I1(full_n_reg_0),
        .I2(CO),
        .I3(p_21_in),
        .O(\pout[2]_i_2_n_0 ));
  FDRE \pout_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\pout[0]_i_1_n_0 ),
        .Q(\pout_reg_n_0_[0] ),
        .R(SR));
  FDRE \pout_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\pout[1]_i_1_n_0 ),
        .Q(\pout_reg_n_0_[1] ),
        .R(SR));
  FDRE \pout_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\pout[2]_i_1_n_0 ),
        .Q(\pout_reg_n_0_[2] ),
        .R(SR));
  FDRE \q_reg[0] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][0]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [0]),
        .R(SR));
  FDRE \q_reg[10] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][10]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [10]),
        .R(SR));
  FDRE \q_reg[11] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][11]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [11]),
        .R(SR));
  FDRE \q_reg[12] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][12]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [12]),
        .R(SR));
  FDRE \q_reg[13] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][13]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [13]),
        .R(SR));
  FDRE \q_reg[14] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][14]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [14]),
        .R(SR));
  FDRE \q_reg[15] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][15]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [15]),
        .R(SR));
  FDRE \q_reg[16] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][16]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [16]),
        .R(SR));
  FDRE \q_reg[17] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][17]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [17]),
        .R(SR));
  FDRE \q_reg[18] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][18]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [18]),
        .R(SR));
  FDRE \q_reg[19] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][19]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [19]),
        .R(SR));
  FDRE \q_reg[1] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][1]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [1]),
        .R(SR));
  FDRE \q_reg[20] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][20]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [20]),
        .R(SR));
  FDRE \q_reg[21] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][21]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [21]),
        .R(SR));
  FDRE \q_reg[22] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][22]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [22]),
        .R(SR));
  FDRE \q_reg[23] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][23]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [23]),
        .R(SR));
  FDRE \q_reg[24] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][24]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [24]),
        .R(SR));
  FDRE \q_reg[25] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][25]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [25]),
        .R(SR));
  FDRE \q_reg[26] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][26]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [26]),
        .R(SR));
  FDRE \q_reg[27] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][27]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [27]),
        .R(SR));
  FDRE \q_reg[28] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][28]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [28]),
        .R(SR));
  FDRE \q_reg[29] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][29]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [29]),
        .R(SR));
  FDRE \q_reg[2] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][2]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [2]),
        .R(SR));
  FDRE \q_reg[30] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][30]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [30]),
        .R(SR));
  FDRE \q_reg[31] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][31]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [31]),
        .R(SR));
  FDRE \q_reg[32] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][32]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [32]),
        .R(SR));
  FDRE \q_reg[33] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][33]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [33]),
        .R(SR));
  FDRE \q_reg[34] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][34]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [34]),
        .R(SR));
  FDRE \q_reg[35] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][35]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [35]),
        .R(SR));
  FDRE \q_reg[36] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][36]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [36]),
        .R(SR));
  FDRE \q_reg[37] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][37]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [37]),
        .R(SR));
  FDRE \q_reg[38] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][38]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [38]),
        .R(SR));
  FDRE \q_reg[39] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][39]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [39]),
        .R(SR));
  FDRE \q_reg[3] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][3]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [3]),
        .R(SR));
  FDRE \q_reg[40] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][40]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [40]),
        .R(SR));
  FDRE \q_reg[41] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][41]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [41]),
        .R(SR));
  FDRE \q_reg[42] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][42]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [42]),
        .R(SR));
  FDRE \q_reg[43] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][43]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [43]),
        .R(SR));
  FDRE \q_reg[44] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][44]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [44]),
        .R(SR));
  FDRE \q_reg[45] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][45]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [45]),
        .R(SR));
  FDRE \q_reg[46] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][46]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [46]),
        .R(SR));
  FDRE \q_reg[47] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][47]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [47]),
        .R(SR));
  FDRE \q_reg[48] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][48]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [48]),
        .R(SR));
  FDRE \q_reg[49] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][49]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [49]),
        .R(SR));
  FDRE \q_reg[4] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][4]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [4]),
        .R(SR));
  FDRE \q_reg[50] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][50]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [50]),
        .R(SR));
  FDRE \q_reg[51] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][51]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [51]),
        .R(SR));
  FDRE \q_reg[52] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][52]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [52]),
        .R(SR));
  FDRE \q_reg[53] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][53]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [53]),
        .R(SR));
  FDRE \q_reg[54] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][54]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [54]),
        .R(SR));
  FDRE \q_reg[55] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][55]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [55]),
        .R(SR));
  FDRE \q_reg[56] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][56]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [56]),
        .R(SR));
  FDRE \q_reg[57] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][57]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [57]),
        .R(SR));
  FDRE \q_reg[58] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][58]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [58]),
        .R(SR));
  FDRE \q_reg[59] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][59]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [59]),
        .R(SR));
  FDRE \q_reg[5] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][5]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [5]),
        .R(SR));
  FDRE \q_reg[60] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][60]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [60]),
        .R(SR));
  FDRE \q_reg[61] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][61]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [61]),
        .R(SR));
  FDRE \q_reg[64] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][64]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [62]),
        .R(SR));
  FDRE \q_reg[6] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][6]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [6]),
        .R(SR));
  FDRE \q_reg[7] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][7]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [7]),
        .R(SR));
  FDRE \q_reg[8] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][8]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [8]),
        .R(SR));
  FDRE \q_reg[9] 
       (.C(ap_clk),
        .CE(E),
        .D(\mem_reg[4][9]_srl5_n_0 ),
        .Q(\q_reg[64]_0 [9]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'h74)) 
    \sect_cnt[0]_i_1 
       (.I0(Q),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [0]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[10]_i_1 
       (.I0(sect_cnt0[9]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [10]),
        .O(D[10]));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[11]_i_1 
       (.I0(sect_cnt0[10]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [11]),
        .O(D[11]));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[12]_i_1 
       (.I0(sect_cnt0[11]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [12]),
        .O(D[12]));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[13]_i_1 
       (.I0(sect_cnt0[12]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [13]),
        .O(D[13]));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[14]_i_1 
       (.I0(sect_cnt0[13]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [14]),
        .O(D[14]));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[15]_i_1 
       (.I0(sect_cnt0[14]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [15]),
        .O(D[15]));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[16]_i_1 
       (.I0(sect_cnt0[15]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [16]),
        .O(D[16]));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[17]_i_1 
       (.I0(sect_cnt0[16]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [17]),
        .O(D[17]));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[18]_i_1 
       (.I0(sect_cnt0[17]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [18]),
        .O(D[18]));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[19]_i_1 
       (.I0(sect_cnt0[18]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [19]),
        .O(D[19]));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[1]_i_1 
       (.I0(sect_cnt0[0]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [1]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[20]_i_1 
       (.I0(sect_cnt0[19]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [20]),
        .O(D[20]));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[21]_i_1 
       (.I0(sect_cnt0[20]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [21]),
        .O(D[21]));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[22]_i_1 
       (.I0(sect_cnt0[21]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [22]),
        .O(D[22]));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[23]_i_1 
       (.I0(sect_cnt0[22]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [23]),
        .O(D[23]));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[24]_i_1 
       (.I0(sect_cnt0[23]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [24]),
        .O(D[24]));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[25]_i_1 
       (.I0(sect_cnt0[24]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [25]),
        .O(D[25]));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[26]_i_1 
       (.I0(sect_cnt0[25]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [26]),
        .O(D[26]));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[27]_i_1 
       (.I0(sect_cnt0[26]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [27]),
        .O(D[27]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[28]_i_1 
       (.I0(sect_cnt0[27]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [28]),
        .O(D[28]));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[29]_i_1 
       (.I0(sect_cnt0[28]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [29]),
        .O(D[29]));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[2]_i_1 
       (.I0(sect_cnt0[1]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [2]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[30]_i_1 
       (.I0(sect_cnt0[29]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [30]),
        .O(D[30]));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[31]_i_1 
       (.I0(sect_cnt0[30]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [31]),
        .O(D[31]));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[32]_i_1 
       (.I0(sect_cnt0[31]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [32]),
        .O(D[32]));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[33]_i_1 
       (.I0(sect_cnt0[32]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [33]),
        .O(D[33]));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[34]_i_1 
       (.I0(sect_cnt0[33]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [34]),
        .O(D[34]));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[35]_i_1 
       (.I0(sect_cnt0[34]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [35]),
        .O(D[35]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[36]_i_1 
       (.I0(sect_cnt0[35]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [36]),
        .O(D[36]));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[37]_i_1 
       (.I0(sect_cnt0[36]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [37]),
        .O(D[37]));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[38]_i_1 
       (.I0(sect_cnt0[37]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [38]),
        .O(D[38]));
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[39]_i_1 
       (.I0(sect_cnt0[38]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [39]),
        .O(D[39]));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[3]_i_1 
       (.I0(sect_cnt0[2]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [3]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[40]_i_1 
       (.I0(sect_cnt0[39]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [40]),
        .O(D[40]));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[41]_i_1 
       (.I0(sect_cnt0[40]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [41]),
        .O(D[41]));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[42]_i_1 
       (.I0(sect_cnt0[41]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [42]),
        .O(D[42]));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[43]_i_1 
       (.I0(sect_cnt0[42]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [43]),
        .O(D[43]));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[44]_i_1 
       (.I0(sect_cnt0[43]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [44]),
        .O(D[44]));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[45]_i_1 
       (.I0(sect_cnt0[44]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [45]),
        .O(D[45]));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[46]_i_1 
       (.I0(sect_cnt0[45]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [46]),
        .O(D[46]));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[47]_i_1 
       (.I0(sect_cnt0[46]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [47]),
        .O(D[47]));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[48]_i_1 
       (.I0(sect_cnt0[47]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [48]),
        .O(D[48]));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[49]_i_1 
       (.I0(sect_cnt0[48]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [49]),
        .O(D[49]));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[4]_i_1 
       (.I0(sect_cnt0[3]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [4]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[50]_i_1 
       (.I0(sect_cnt0[49]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [50]),
        .O(D[50]));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[51]_i_2 
       (.I0(sect_cnt0[50]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [51]),
        .O(D[51]));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[5]_i_1 
       (.I0(sect_cnt0[4]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [5]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[6]_i_1 
       (.I0(sect_cnt0[5]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [6]),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[7]_i_1 
       (.I0(sect_cnt0[6]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [7]),
        .O(D[7]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[8]_i_1 
       (.I0(sect_cnt0[7]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [8]),
        .O(D[8]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_cnt[9]_i_1 
       (.I0(sect_cnt0[8]),
        .I1(fifo_rreq_valid_buf_i_2_n_0),
        .I2(\sect_cnt_reg[51] [9]),
        .O(D[9]));
  LUT4 #(
    .INIT(16'h9009)) 
    \sect_len_buf[9]_i_4 
       (.I0(\sect_len_buf_reg[7]_0 [1]),
        .I1(\sect_len_buf_reg[7]_1 [1]),
        .I2(\sect_len_buf_reg[7]_0 [0]),
        .I3(\sect_len_buf_reg[7]_1 [0]),
        .O(\sect_len_buf_reg[6] ));
  LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
    \sect_len_buf[9]_i_5 
       (.I0(\sect_len_buf_reg[7]_0 [2]),
        .I1(\sect_len_buf_reg[7]_1 [2]),
        .I2(\sect_len_buf_reg[7]_1 [4]),
        .I3(\sect_len_buf_reg[7]_0 [4]),
        .I4(\sect_len_buf_reg[7]_1 [3]),
        .I5(\sect_len_buf_reg[7]_0 [3]),
        .O(\sect_len_buf_reg[7] ));
endmodule

(* ORIG_REF_NAME = "sound_operation_ram_m_axi_fifo" *) 
module design_1_sound_operation_0_7_sound_operation_ram_m_axi_fifo__parameterized1
   (empty_n_reg_0,
    invalid_len_event_reg2_reg,
    E,
    p_21_in,
    \could_multi_bursts.sect_handling_reg ,
    rreq_handling_reg,
    rreq_handling_reg_0,
    rreq_handling_reg_1,
    ap_rst_n_0,
    rreq_handling_reg_2,
    ap_rst_n_1,
    \could_multi_bursts.sect_handling_reg_0 ,
    \could_multi_bursts.sect_handling_reg_1 ,
    \could_multi_bursts.sect_handling_reg_2 ,
    \could_multi_bursts.sect_handling_reg_3 ,
    \could_multi_bursts.sect_handling_reg_4 ,
    \could_multi_bursts.sect_handling_reg_5 ,
    ap_clk,
    SR,
    invalid_len_event_reg2,
    \could_multi_bursts.sect_handling_reg_6 ,
    \could_multi_bursts.sect_handling_reg_7 ,
    m_axi_ram_ARREADY,
    ap_rst_n,
    CO,
    rreq_handling_reg_3,
    fifo_rreq_valid,
    \sect_len_buf_reg[7] ,
    \sect_len_buf_reg[7]_0 ,
    \pout_reg[3]_0 ,
    empty_n_reg_1,
    rdata_ack_t,
    empty_n_reg_2,
    beat_valid,
    rreq_handling_reg_4,
    invalid_len_event,
    \could_multi_bursts.sect_handling_reg_8 ,
    \sect_addr_buf_reg[2] ,
    Q);
  output empty_n_reg_0;
  output invalid_len_event_reg2_reg;
  output [0:0]E;
  output p_21_in;
  output [0:0]\could_multi_bursts.sect_handling_reg ;
  output [0:0]rreq_handling_reg;
  output rreq_handling_reg_0;
  output rreq_handling_reg_1;
  output [0:0]ap_rst_n_0;
  output [0:0]rreq_handling_reg_2;
  output [0:0]ap_rst_n_1;
  output \could_multi_bursts.sect_handling_reg_0 ;
  output \could_multi_bursts.sect_handling_reg_1 ;
  output \could_multi_bursts.sect_handling_reg_2 ;
  output \could_multi_bursts.sect_handling_reg_3 ;
  output \could_multi_bursts.sect_handling_reg_4 ;
  output \could_multi_bursts.sect_handling_reg_5 ;
  input ap_clk;
  input [0:0]SR;
  input invalid_len_event_reg2;
  input \could_multi_bursts.sect_handling_reg_6 ;
  input \could_multi_bursts.sect_handling_reg_7 ;
  input m_axi_ram_ARREADY;
  input ap_rst_n;
  input [0:0]CO;
  input rreq_handling_reg_3;
  input fifo_rreq_valid;
  input \sect_len_buf_reg[7] ;
  input \sect_len_buf_reg[7]_0 ;
  input \pout_reg[3]_0 ;
  input [0:0]empty_n_reg_1;
  input rdata_ack_t;
  input empty_n_reg_2;
  input beat_valid;
  input rreq_handling_reg_4;
  input invalid_len_event;
  input \could_multi_bursts.sect_handling_reg_8 ;
  input [0:0]\sect_addr_buf_reg[2] ;
  input [4:0]Q;

  wire [0:0]CO;
  wire [0:0]E;
  wire [4:0]Q;
  wire [0:0]SR;
  wire ap_clk;
  wire ap_rst_n;
  wire [0:0]ap_rst_n_0;
  wire [0:0]ap_rst_n_1;
  wire beat_valid;
  wire [0:0]\could_multi_bursts.sect_handling_reg ;
  wire \could_multi_bursts.sect_handling_reg_0 ;
  wire \could_multi_bursts.sect_handling_reg_1 ;
  wire \could_multi_bursts.sect_handling_reg_2 ;
  wire \could_multi_bursts.sect_handling_reg_3 ;
  wire \could_multi_bursts.sect_handling_reg_4 ;
  wire \could_multi_bursts.sect_handling_reg_5 ;
  wire \could_multi_bursts.sect_handling_reg_6 ;
  wire \could_multi_bursts.sect_handling_reg_7 ;
  wire \could_multi_bursts.sect_handling_reg_8 ;
  wire data_vld_i_1__0_n_0;
  wire data_vld_reg_n_0;
  wire empty_n_i_1__0_n_0;
  wire empty_n_reg_0;
  wire [0:0]empty_n_reg_1;
  wire empty_n_reg_2;
  wire fifo_rctl_ready;
  wire fifo_rreq_valid;
  wire full_n_i_1__1_n_0;
  wire full_n_i_2__0_n_0;
  wire full_n_i_3__0_n_0;
  wire invalid_len_event;
  wire invalid_len_event_reg2;
  wire invalid_len_event_reg2_reg;
  wire m_axi_ram_ARREADY;
  wire p_21_in;
  wire \pout[0]_i_1_n_0 ;
  wire \pout[1]_i_1_n_0 ;
  wire \pout[2]_i_1_n_0 ;
  wire \pout[3]_i_1_n_0 ;
  wire \pout[3]_i_2_n_0 ;
  wire \pout[3]_i_3_n_0 ;
  wire \pout[3]_i_5_n_0 ;
  wire [3:0]pout_reg;
  wire \pout_reg[3]_0 ;
  wire rdata_ack_t;
  wire [0:0]rreq_handling_reg;
  wire rreq_handling_reg_0;
  wire rreq_handling_reg_1;
  wire [0:0]rreq_handling_reg_2;
  wire rreq_handling_reg_3;
  wire rreq_handling_reg_4;
  wire [0:0]\sect_addr_buf_reg[2] ;
  wire \sect_len_buf[9]_i_3_n_0 ;
  wire \sect_len_buf_reg[7] ;
  wire \sect_len_buf_reg[7]_0 ;

  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT4 #(
    .INIT(16'hD500)) 
    \align_len[31]_i_1 
       (.I0(rreq_handling_reg_3),
        .I1(CO),
        .I2(p_21_in),
        .I3(fifo_rreq_valid),
        .O(rreq_handling_reg_2));
  LUT6 #(
    .INIT(64'h4040FF4000000000)) 
    \could_multi_bursts.ARVALID_Dummy_i_1 
       (.I0(invalid_len_event_reg2),
        .I1(\could_multi_bursts.sect_handling_reg_6 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(m_axi_ram_ARREADY),
        .I5(ap_rst_n),
        .O(invalid_len_event_reg2_reg));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT4 #(
    .INIT(16'h8808)) 
    \could_multi_bursts.araddr_buf[63]_i_2 
       (.I0(\could_multi_bursts.sect_handling_reg_6 ),
        .I1(fifo_rctl_ready),
        .I2(\could_multi_bursts.sect_handling_reg_7 ),
        .I3(m_axi_ram_ARREADY),
        .O(\could_multi_bursts.sect_handling_reg ));
  LUT6 #(
    .INIT(64'hFFFFFFFF40400040)) 
    \could_multi_bursts.arlen_buf[0]_i_1 
       (.I0(\could_multi_bursts.sect_handling_reg_8 ),
        .I1(\could_multi_bursts.sect_handling_reg_6 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(m_axi_ram_ARREADY),
        .I5(Q[0]),
        .O(\could_multi_bursts.sect_handling_reg_1 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF40400040)) 
    \could_multi_bursts.arlen_buf[1]_i_1 
       (.I0(\could_multi_bursts.sect_handling_reg_8 ),
        .I1(\could_multi_bursts.sect_handling_reg_6 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(m_axi_ram_ARREADY),
        .I5(Q[1]),
        .O(\could_multi_bursts.sect_handling_reg_2 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF40400040)) 
    \could_multi_bursts.arlen_buf[2]_i_1 
       (.I0(\could_multi_bursts.sect_handling_reg_8 ),
        .I1(\could_multi_bursts.sect_handling_reg_6 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(m_axi_ram_ARREADY),
        .I5(Q[2]),
        .O(\could_multi_bursts.sect_handling_reg_3 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF40400040)) 
    \could_multi_bursts.arlen_buf[3]_i_1 
       (.I0(\could_multi_bursts.sect_handling_reg_8 ),
        .I1(\could_multi_bursts.sect_handling_reg_6 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(m_axi_ram_ARREADY),
        .I5(Q[3]),
        .O(\could_multi_bursts.sect_handling_reg_4 ));
  LUT4 #(
    .INIT(16'h8808)) 
    \could_multi_bursts.arlen_buf[4]_i_1 
       (.I0(\could_multi_bursts.sect_handling_reg_6 ),
        .I1(fifo_rctl_ready),
        .I2(\could_multi_bursts.sect_handling_reg_7 ),
        .I3(m_axi_ram_ARREADY),
        .O(\could_multi_bursts.sect_handling_reg_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF40400040)) 
    \could_multi_bursts.arlen_buf[4]_i_2 
       (.I0(\could_multi_bursts.sect_handling_reg_8 ),
        .I1(\could_multi_bursts.sect_handling_reg_6 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(m_axi_ram_ARREADY),
        .I5(Q[4]),
        .O(\could_multi_bursts.sect_handling_reg_5 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \could_multi_bursts.loop_cnt[4]_i_1 
       (.I0(p_21_in),
        .I1(ap_rst_n),
        .O(ap_rst_n_0));
  LUT6 #(
    .INIT(64'hAEAEEEAEEEEEEEEE)) 
    \could_multi_bursts.sect_handling_i_1 
       (.I0(rreq_handling_reg_3),
        .I1(\could_multi_bursts.sect_handling_reg_6 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(m_axi_ram_ARREADY),
        .I5(\could_multi_bursts.sect_handling_reg_8 ),
        .O(rreq_handling_reg_1));
  LUT4 #(
    .INIT(16'h7F0F)) 
    data_vld_i_1__0
       (.I0(\pout[3]_i_3_n_0 ),
        .I1(full_n_i_2__0_n_0),
        .I2(\sect_len_buf[9]_i_3_n_0 ),
        .I3(data_vld_reg_n_0),
        .O(data_vld_i_1__0_n_0));
  FDRE data_vld_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(data_vld_i_1__0_n_0),
        .Q(data_vld_reg_n_0),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT4 #(
    .INIT(16'h8FFF)) 
    empty_n_i_1
       (.I0(p_21_in),
        .I1(CO),
        .I2(rreq_handling_reg_3),
        .I3(fifo_rreq_valid),
        .O(E));
  LUT6 #(
    .INIT(64'hFFFFFFFF22A2AAAA)) 
    empty_n_i_1__0
       (.I0(empty_n_reg_0),
        .I1(beat_valid),
        .I2(empty_n_reg_2),
        .I3(rdata_ack_t),
        .I4(empty_n_reg_1),
        .I5(data_vld_reg_n_0),
        .O(empty_n_i_1__0_n_0));
  FDRE empty_n_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(empty_n_i_1__0_n_0),
        .Q(empty_n_reg_0),
        .R(SR));
  LUT6 #(
    .INIT(64'hFBFBFBFBFBBBFBFB)) 
    full_n_i_1__1
       (.I0(full_n_i_2__0_n_0),
        .I1(ap_rst_n),
        .I2(fifo_rctl_ready),
        .I3(full_n_i_3__0_n_0),
        .I4(\pout[3]_i_5_n_0 ),
        .I5(pout_reg[1]),
        .O(full_n_i_1__1_n_0));
  LUT6 #(
    .INIT(64'h80880000AAAAAAAA)) 
    full_n_i_2__0
       (.I0(data_vld_reg_n_0),
        .I1(empty_n_reg_1),
        .I2(rdata_ack_t),
        .I3(empty_n_reg_2),
        .I4(beat_valid),
        .I5(empty_n_reg_0),
        .O(full_n_i_2__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    full_n_i_3__0
       (.I0(pout_reg[2]),
        .I1(pout_reg[0]),
        .I2(pout_reg[3]),
        .O(full_n_i_3__0_n_0));
  FDRE full_n_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(full_n_i_1__1_n_0),
        .Q(fifo_rctl_ready),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \pout[0]_i_1 
       (.I0(pout_reg[0]),
        .O(\pout[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \pout[1]_i_1 
       (.I0(pout_reg[0]),
        .I1(\pout[3]_i_5_n_0 ),
        .I2(pout_reg[1]),
        .O(\pout[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT4 #(
    .INIT(16'h7E81)) 
    \pout[2]_i_1 
       (.I0(pout_reg[0]),
        .I1(\pout[3]_i_5_n_0 ),
        .I2(pout_reg[1]),
        .I3(pout_reg[2]),
        .O(\pout[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h5020)) 
    \pout[3]_i_1 
       (.I0(\sect_len_buf[9]_i_3_n_0 ),
        .I1(\pout[3]_i_3_n_0 ),
        .I2(data_vld_reg_n_0),
        .I3(\pout_reg[3]_0 ),
        .O(\pout[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT5 #(
    .INIT(32'h6AAAAAA9)) 
    \pout[3]_i_2 
       (.I0(pout_reg[3]),
        .I1(pout_reg[0]),
        .I2(\pout[3]_i_5_n_0 ),
        .I3(pout_reg[1]),
        .I4(pout_reg[2]),
        .O(\pout[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \pout[3]_i_3 
       (.I0(pout_reg[1]),
        .I1(pout_reg[2]),
        .I2(pout_reg[0]),
        .I3(pout_reg[3]),
        .O(\pout[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h8088000000000000)) 
    \pout[3]_i_5 
       (.I0(\pout_reg[3]_0 ),
        .I1(data_vld_reg_n_0),
        .I2(m_axi_ram_ARREADY),
        .I3(\could_multi_bursts.sect_handling_reg_7 ),
        .I4(fifo_rctl_ready),
        .I5(\could_multi_bursts.sect_handling_reg_6 ),
        .O(\pout[3]_i_5_n_0 ));
  FDRE \pout_reg[0] 
       (.C(ap_clk),
        .CE(\pout[3]_i_1_n_0 ),
        .D(\pout[0]_i_1_n_0 ),
        .Q(pout_reg[0]),
        .R(SR));
  FDRE \pout_reg[1] 
       (.C(ap_clk),
        .CE(\pout[3]_i_1_n_0 ),
        .D(\pout[1]_i_1_n_0 ),
        .Q(pout_reg[1]),
        .R(SR));
  FDRE \pout_reg[2] 
       (.C(ap_clk),
        .CE(\pout[3]_i_1_n_0 ),
        .D(\pout[2]_i_1_n_0 ),
        .Q(pout_reg[2]),
        .R(SR));
  FDRE \pout_reg[3] 
       (.C(ap_clk),
        .CE(\pout[3]_i_1_n_0 ),
        .D(\pout[3]_i_2_n_0 ),
        .Q(pout_reg[3]),
        .R(SR));
  LUT5 #(
    .INIT(32'h0CAEAEAE)) 
    rreq_handling_i_1
       (.I0(rreq_handling_reg_3),
        .I1(rreq_handling_reg_4),
        .I2(invalid_len_event),
        .I3(CO),
        .I4(p_21_in),
        .O(rreq_handling_reg_0));
  LUT3 #(
    .INIT(8'h4F)) 
    \sect_addr_buf[11]_i_1 
       (.I0(\sect_addr_buf_reg[2] ),
        .I1(p_21_in),
        .I2(ap_rst_n),
        .O(ap_rst_n_1));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT4 #(
    .INIT(16'hBBBA)) 
    \sect_cnt[51]_i_1 
       (.I0(p_21_in),
        .I1(rreq_handling_reg_3),
        .I2(rreq_handling_reg_4),
        .I3(fifo_rreq_valid),
        .O(rreq_handling_reg));
  LUT5 #(
    .INIT(32'h50507050)) 
    \sect_len_buf[9]_i_1 
       (.I0(\could_multi_bursts.sect_handling_reg_6 ),
        .I1(\sect_len_buf[9]_i_3_n_0 ),
        .I2(rreq_handling_reg_3),
        .I3(\sect_len_buf_reg[7] ),
        .I4(\sect_len_buf_reg[7]_0 ),
        .O(p_21_in));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT4 #(
    .INIT(16'h4FFF)) 
    \sect_len_buf[9]_i_3 
       (.I0(m_axi_ram_ARREADY),
        .I1(\could_multi_bursts.sect_handling_reg_7 ),
        .I2(fifo_rctl_ready),
        .I3(\could_multi_bursts.sect_handling_reg_6 ),
        .O(\sect_len_buf[9]_i_3_n_0 ));
endmodule

(* ORIG_REF_NAME = "sound_operation_ram_m_axi_read" *) 
module design_1_sound_operation_0_7_sound_operation_ram_m_axi_read
   (full_n_reg,
    SR,
    \could_multi_bursts.ARVALID_Dummy_reg_0 ,
    m_axi_ram_ARADDR,
    E,
    ap_NS_fsm,
    \could_multi_bursts.arlen_buf_reg[4]_0 ,
    \data_p1_reg[31] ,
    ap_clk,
    D,
    m_axi_ram_RRESP,
    m_axi_ram_RVALID,
    ap_rst_n,
    m_axi_ram_ARREADY,
    Q,
    \data_p2_reg[61] );
  output full_n_reg;
  output [0:0]SR;
  output \could_multi_bursts.ARVALID_Dummy_reg_0 ;
  output [61:0]m_axi_ram_ARADDR;
  output [0:0]E;
  output [2:0]ap_NS_fsm;
  output [4:0]\could_multi_bursts.arlen_buf_reg[4]_0 ;
  output [31:0]\data_p1_reg[31] ;
  input ap_clk;
  input [32:0]D;
  input [1:0]m_axi_ram_RRESP;
  input m_axi_ram_RVALID;
  input ap_rst_n;
  input m_axi_ram_ARREADY;
  input [3:0]Q;
  input [61:0]\data_p2_reg[61] ;

  wire [32:0]D;
  wire [0:0]E;
  wire [3:0]Q;
  wire [0:0]SR;
  wire [31:2]align_len0;
  wire align_len0_carry_n_2;
  wire align_len0_carry_n_3;
  wire \align_len_reg_n_0_[2] ;
  wire \align_len_reg_n_0_[31] ;
  wire [2:0]ap_NS_fsm;
  wire ap_clk;
  wire ap_rst_n;
  wire [63:2]araddr_tmp;
  wire [7:0]beat_len_buf;
  wire beat_valid;
  wire buff_rdata_n_11;
  wire buff_rdata_n_13;
  wire buff_rdata_n_14;
  wire buff_rdata_n_15;
  wire buff_rdata_n_16;
  wire buff_rdata_n_17;
  wire buff_rdata_n_18;
  wire buff_rdata_n_19;
  wire buff_rdata_n_20;
  wire buff_rdata_n_21;
  wire buff_rdata_n_22;
  wire buff_rdata_n_23;
  wire buff_rdata_n_24;
  wire buff_rdata_n_25;
  wire buff_rdata_n_26;
  wire buff_rdata_n_27;
  wire buff_rdata_n_28;
  wire buff_rdata_n_29;
  wire buff_rdata_n_30;
  wire buff_rdata_n_31;
  wire buff_rdata_n_32;
  wire buff_rdata_n_33;
  wire buff_rdata_n_34;
  wire buff_rdata_n_35;
  wire buff_rdata_n_36;
  wire buff_rdata_n_37;
  wire buff_rdata_n_38;
  wire buff_rdata_n_39;
  wire buff_rdata_n_40;
  wire buff_rdata_n_41;
  wire buff_rdata_n_42;
  wire buff_rdata_n_43;
  wire buff_rdata_n_44;
  wire buff_rdata_n_45;
  wire buff_rdata_n_46;
  wire buff_rdata_n_47;
  wire buff_rdata_n_48;
  wire buff_rdata_n_49;
  wire buff_rdata_n_50;
  wire buff_rdata_n_51;
  wire buff_rdata_n_52;
  wire buff_rdata_n_53;
  wire \bus_equal_gen.data_buf_reg_n_0_[0] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[10] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[11] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[12] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[13] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[14] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[15] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[16] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[17] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[18] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[19] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[1] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[20] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[21] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[22] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[23] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[24] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[25] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[26] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[27] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[28] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[29] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[2] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[30] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[31] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[3] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[4] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[5] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[6] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[7] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[8] ;
  wire \bus_equal_gen.data_buf_reg_n_0_[9] ;
  wire \bus_equal_gen.rdata_valid_t_reg_n_0 ;
  wire \could_multi_bursts.ARVALID_Dummy_reg_0 ;
  wire \could_multi_bursts.araddr_buf[4]_i_3_n_0 ;
  wire \could_multi_bursts.araddr_buf[4]_i_4_n_0 ;
  wire \could_multi_bursts.araddr_buf[4]_i_5_n_0 ;
  wire \could_multi_bursts.araddr_buf[63]_i_4_n_0 ;
  wire \could_multi_bursts.araddr_buf[8]_i_3_n_0 ;
  wire \could_multi_bursts.araddr_buf[8]_i_4_n_0 ;
  wire \could_multi_bursts.araddr_buf[8]_i_5_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[12]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[12]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[12]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[12]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[16]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[16]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[16]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[16]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[20]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[20]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[20]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[20]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[24]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[24]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[24]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[24]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[28]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[28]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[28]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[28]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[32]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[32]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[32]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[32]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[36]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[36]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[36]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[36]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[40]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[40]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[40]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[40]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[44]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[44]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[44]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[44]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[48]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[48]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[48]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[48]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[4]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[4]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[4]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[4]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[52]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[52]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[52]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[52]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[56]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[56]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[56]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[56]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[60]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[60]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[60]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[60]_i_2_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[63]_i_5_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[63]_i_5_n_3 ;
  wire \could_multi_bursts.araddr_buf_reg[8]_i_2_n_0 ;
  wire \could_multi_bursts.araddr_buf_reg[8]_i_2_n_1 ;
  wire \could_multi_bursts.araddr_buf_reg[8]_i_2_n_2 ;
  wire \could_multi_bursts.araddr_buf_reg[8]_i_2_n_3 ;
  wire \could_multi_bursts.arlen_buf[4]_i_3_n_0 ;
  wire [4:0]\could_multi_bursts.arlen_buf_reg[4]_0 ;
  wire [4:0]\could_multi_bursts.loop_cnt_reg ;
  wire \could_multi_bursts.sect_handling_reg_n_0 ;
  wire [63:2]data1;
  wire [31:0]\data_p1_reg[31] ;
  wire [61:0]\data_p2_reg[61] ;
  wire [34:34]data_pack;
  wire [63:2]end_addr;
  wire \end_addr_buf[13]_i_2_n_0 ;
  wire \end_addr_buf[13]_i_3_n_0 ;
  wire \end_addr_buf[13]_i_4_n_0 ;
  wire \end_addr_buf[13]_i_5_n_0 ;
  wire \end_addr_buf[17]_i_2_n_0 ;
  wire \end_addr_buf[17]_i_3_n_0 ;
  wire \end_addr_buf[17]_i_4_n_0 ;
  wire \end_addr_buf[17]_i_5_n_0 ;
  wire \end_addr_buf[21]_i_2_n_0 ;
  wire \end_addr_buf[21]_i_3_n_0 ;
  wire \end_addr_buf[21]_i_4_n_0 ;
  wire \end_addr_buf[21]_i_5_n_0 ;
  wire \end_addr_buf[25]_i_2_n_0 ;
  wire \end_addr_buf[25]_i_3_n_0 ;
  wire \end_addr_buf[25]_i_4_n_0 ;
  wire \end_addr_buf[25]_i_5_n_0 ;
  wire \end_addr_buf[29]_i_2_n_0 ;
  wire \end_addr_buf[29]_i_3_n_0 ;
  wire \end_addr_buf[29]_i_4_n_0 ;
  wire \end_addr_buf[29]_i_5_n_0 ;
  wire \end_addr_buf[33]_i_2_n_0 ;
  wire \end_addr_buf[33]_i_3_n_0 ;
  wire \end_addr_buf[5]_i_2_n_0 ;
  wire \end_addr_buf[5]_i_3_n_0 ;
  wire \end_addr_buf[5]_i_4_n_0 ;
  wire \end_addr_buf[5]_i_5_n_0 ;
  wire \end_addr_buf[9]_i_2_n_0 ;
  wire \end_addr_buf[9]_i_3_n_0 ;
  wire \end_addr_buf[9]_i_4_n_0 ;
  wire \end_addr_buf[9]_i_5_n_0 ;
  wire \end_addr_buf_reg[13]_i_1_n_0 ;
  wire \end_addr_buf_reg[13]_i_1_n_1 ;
  wire \end_addr_buf_reg[13]_i_1_n_2 ;
  wire \end_addr_buf_reg[13]_i_1_n_3 ;
  wire \end_addr_buf_reg[17]_i_1_n_0 ;
  wire \end_addr_buf_reg[17]_i_1_n_1 ;
  wire \end_addr_buf_reg[17]_i_1_n_2 ;
  wire \end_addr_buf_reg[17]_i_1_n_3 ;
  wire \end_addr_buf_reg[21]_i_1_n_0 ;
  wire \end_addr_buf_reg[21]_i_1_n_1 ;
  wire \end_addr_buf_reg[21]_i_1_n_2 ;
  wire \end_addr_buf_reg[21]_i_1_n_3 ;
  wire \end_addr_buf_reg[25]_i_1_n_0 ;
  wire \end_addr_buf_reg[25]_i_1_n_1 ;
  wire \end_addr_buf_reg[25]_i_1_n_2 ;
  wire \end_addr_buf_reg[25]_i_1_n_3 ;
  wire \end_addr_buf_reg[29]_i_1_n_0 ;
  wire \end_addr_buf_reg[29]_i_1_n_1 ;
  wire \end_addr_buf_reg[29]_i_1_n_2 ;
  wire \end_addr_buf_reg[29]_i_1_n_3 ;
  wire \end_addr_buf_reg[33]_i_1_n_0 ;
  wire \end_addr_buf_reg[33]_i_1_n_1 ;
  wire \end_addr_buf_reg[33]_i_1_n_2 ;
  wire \end_addr_buf_reg[33]_i_1_n_3 ;
  wire \end_addr_buf_reg[37]_i_1_n_0 ;
  wire \end_addr_buf_reg[37]_i_1_n_1 ;
  wire \end_addr_buf_reg[37]_i_1_n_2 ;
  wire \end_addr_buf_reg[37]_i_1_n_3 ;
  wire \end_addr_buf_reg[41]_i_1_n_0 ;
  wire \end_addr_buf_reg[41]_i_1_n_1 ;
  wire \end_addr_buf_reg[41]_i_1_n_2 ;
  wire \end_addr_buf_reg[41]_i_1_n_3 ;
  wire \end_addr_buf_reg[45]_i_1_n_0 ;
  wire \end_addr_buf_reg[45]_i_1_n_1 ;
  wire \end_addr_buf_reg[45]_i_1_n_2 ;
  wire \end_addr_buf_reg[45]_i_1_n_3 ;
  wire \end_addr_buf_reg[49]_i_1_n_0 ;
  wire \end_addr_buf_reg[49]_i_1_n_1 ;
  wire \end_addr_buf_reg[49]_i_1_n_2 ;
  wire \end_addr_buf_reg[49]_i_1_n_3 ;
  wire \end_addr_buf_reg[53]_i_1_n_0 ;
  wire \end_addr_buf_reg[53]_i_1_n_1 ;
  wire \end_addr_buf_reg[53]_i_1_n_2 ;
  wire \end_addr_buf_reg[53]_i_1_n_3 ;
  wire \end_addr_buf_reg[57]_i_1_n_0 ;
  wire \end_addr_buf_reg[57]_i_1_n_1 ;
  wire \end_addr_buf_reg[57]_i_1_n_2 ;
  wire \end_addr_buf_reg[57]_i_1_n_3 ;
  wire \end_addr_buf_reg[5]_i_1_n_0 ;
  wire \end_addr_buf_reg[5]_i_1_n_1 ;
  wire \end_addr_buf_reg[5]_i_1_n_2 ;
  wire \end_addr_buf_reg[5]_i_1_n_3 ;
  wire \end_addr_buf_reg[61]_i_1_n_0 ;
  wire \end_addr_buf_reg[61]_i_1_n_1 ;
  wire \end_addr_buf_reg[61]_i_1_n_2 ;
  wire \end_addr_buf_reg[61]_i_1_n_3 ;
  wire \end_addr_buf_reg[63]_i_1_n_3 ;
  wire \end_addr_buf_reg[9]_i_1_n_0 ;
  wire \end_addr_buf_reg[9]_i_1_n_1 ;
  wire \end_addr_buf_reg[9]_i_1_n_2 ;
  wire \end_addr_buf_reg[9]_i_1_n_3 ;
  wire \end_addr_buf_reg_n_0_[10] ;
  wire \end_addr_buf_reg_n_0_[11] ;
  wire \end_addr_buf_reg_n_0_[2] ;
  wire \end_addr_buf_reg_n_0_[3] ;
  wire \end_addr_buf_reg_n_0_[4] ;
  wire \end_addr_buf_reg_n_0_[5] ;
  wire \end_addr_buf_reg_n_0_[6] ;
  wire \end_addr_buf_reg_n_0_[7] ;
  wire \end_addr_buf_reg_n_0_[8] ;
  wire \end_addr_buf_reg_n_0_[9] ;
  wire fifo_rctl_n_0;
  wire fifo_rctl_n_1;
  wire fifo_rctl_n_10;
  wire fifo_rctl_n_11;
  wire fifo_rctl_n_12;
  wire fifo_rctl_n_13;
  wire fifo_rctl_n_14;
  wire fifo_rctl_n_15;
  wire fifo_rctl_n_16;
  wire fifo_rctl_n_5;
  wire fifo_rctl_n_6;
  wire fifo_rctl_n_7;
  wire fifo_rctl_n_8;
  wire fifo_rctl_n_9;
  wire [64:64]fifo_rreq_data;
  wire fifo_rreq_n_10;
  wire fifo_rreq_n_11;
  wire fifo_rreq_n_12;
  wire fifo_rreq_n_13;
  wire fifo_rreq_n_14;
  wire fifo_rreq_n_15;
  wire fifo_rreq_n_16;
  wire fifo_rreq_n_17;
  wire fifo_rreq_n_18;
  wire fifo_rreq_n_19;
  wire fifo_rreq_n_2;
  wire fifo_rreq_n_20;
  wire fifo_rreq_n_21;
  wire fifo_rreq_n_22;
  wire fifo_rreq_n_23;
  wire fifo_rreq_n_24;
  wire fifo_rreq_n_25;
  wire fifo_rreq_n_26;
  wire fifo_rreq_n_27;
  wire fifo_rreq_n_28;
  wire fifo_rreq_n_29;
  wire fifo_rreq_n_3;
  wire fifo_rreq_n_30;
  wire fifo_rreq_n_31;
  wire fifo_rreq_n_32;
  wire fifo_rreq_n_33;
  wire fifo_rreq_n_34;
  wire fifo_rreq_n_35;
  wire fifo_rreq_n_36;
  wire fifo_rreq_n_37;
  wire fifo_rreq_n_38;
  wire fifo_rreq_n_39;
  wire fifo_rreq_n_4;
  wire fifo_rreq_n_40;
  wire fifo_rreq_n_41;
  wire fifo_rreq_n_42;
  wire fifo_rreq_n_43;
  wire fifo_rreq_n_44;
  wire fifo_rreq_n_45;
  wire fifo_rreq_n_46;
  wire fifo_rreq_n_47;
  wire fifo_rreq_n_48;
  wire fifo_rreq_n_49;
  wire fifo_rreq_n_5;
  wire fifo_rreq_n_50;
  wire fifo_rreq_n_51;
  wire fifo_rreq_n_52;
  wire fifo_rreq_n_53;
  wire fifo_rreq_n_55;
  wire fifo_rreq_n_56;
  wire fifo_rreq_n_6;
  wire fifo_rreq_n_7;
  wire fifo_rreq_n_8;
  wire fifo_rreq_n_9;
  wire fifo_rreq_valid;
  wire fifo_rreq_valid_buf_reg_n_0;
  wire first_sect;
  wire first_sect_carry__0_i_1_n_0;
  wire first_sect_carry__0_i_2_n_0;
  wire first_sect_carry__0_i_3_n_0;
  wire first_sect_carry__0_i_4_n_0;
  wire first_sect_carry__0_n_0;
  wire first_sect_carry__0_n_1;
  wire first_sect_carry__0_n_2;
  wire first_sect_carry__0_n_3;
  wire first_sect_carry__1_i_1_n_0;
  wire first_sect_carry__1_i_2_n_0;
  wire first_sect_carry__1_i_3_n_0;
  wire first_sect_carry__1_i_4_n_0;
  wire first_sect_carry__1_n_0;
  wire first_sect_carry__1_n_1;
  wire first_sect_carry__1_n_2;
  wire first_sect_carry__1_n_3;
  wire first_sect_carry__2_i_1_n_0;
  wire first_sect_carry__2_i_2_n_0;
  wire first_sect_carry__2_i_3_n_0;
  wire first_sect_carry__2_i_4_n_0;
  wire first_sect_carry__2_n_0;
  wire first_sect_carry__2_n_1;
  wire first_sect_carry__2_n_2;
  wire first_sect_carry__2_n_3;
  wire first_sect_carry__3_i_1_n_0;
  wire first_sect_carry__3_i_2_n_0;
  wire first_sect_carry__3_n_3;
  wire first_sect_carry_i_1_n_0;
  wire first_sect_carry_i_2_n_0;
  wire first_sect_carry_i_3_n_0;
  wire first_sect_carry_i_4_n_0;
  wire first_sect_carry_n_0;
  wire first_sect_carry_n_1;
  wire first_sect_carry_n_2;
  wire first_sect_carry_n_3;
  wire full_n_reg;
  wire invalid_len_event;
  wire invalid_len_event0;
  wire invalid_len_event_reg1;
  wire invalid_len_event_reg2;
  wire last_sect;
  wire last_sect_carry__0_i_1_n_0;
  wire last_sect_carry__0_i_2_n_0;
  wire last_sect_carry__0_i_3_n_0;
  wire last_sect_carry__0_i_4_n_0;
  wire last_sect_carry__0_n_0;
  wire last_sect_carry__0_n_1;
  wire last_sect_carry__0_n_2;
  wire last_sect_carry__0_n_3;
  wire last_sect_carry__1_i_1_n_0;
  wire last_sect_carry__1_i_2_n_0;
  wire last_sect_carry__1_i_3_n_0;
  wire last_sect_carry__1_i_4_n_0;
  wire last_sect_carry__1_n_0;
  wire last_sect_carry__1_n_1;
  wire last_sect_carry__1_n_2;
  wire last_sect_carry__1_n_3;
  wire last_sect_carry__2_i_1_n_0;
  wire last_sect_carry__2_i_2_n_0;
  wire last_sect_carry__2_i_3_n_0;
  wire last_sect_carry__2_i_4_n_0;
  wire last_sect_carry__2_n_0;
  wire last_sect_carry__2_n_1;
  wire last_sect_carry__2_n_2;
  wire last_sect_carry__2_n_3;
  wire last_sect_carry__3_i_1_n_0;
  wire last_sect_carry__3_i_2_n_0;
  wire last_sect_carry__3_n_3;
  wire last_sect_carry_i_1_n_0;
  wire last_sect_carry_i_2_n_0;
  wire last_sect_carry_i_3_n_0;
  wire last_sect_carry_i_4_n_0;
  wire last_sect_carry_n_0;
  wire last_sect_carry_n_1;
  wire last_sect_carry_n_2;
  wire last_sect_carry_n_3;
  wire mOutPtr19_out;
  wire [6:0]mOutPtr_reg;
  wire [61:0]m_axi_ram_ARADDR;
  wire m_axi_ram_ARREADY;
  wire [1:0]m_axi_ram_RRESP;
  wire m_axi_ram_RVALID;
  wire next_beat;
  wire next_rreq;
  wire [4:0]p_0_in;
  wire [51:0]p_0_in0_in;
  wire [51:0]p_0_in_0;
  wire p_0_out_carry__0_n_1;
  wire p_0_out_carry__0_n_2;
  wire p_0_out_carry__0_n_3;
  wire p_0_out_carry__0_n_4;
  wire p_0_out_carry__0_n_5;
  wire p_0_out_carry__0_n_6;
  wire p_0_out_carry__0_n_7;
  wire p_0_out_carry_n_0;
  wire p_0_out_carry_n_1;
  wire p_0_out_carry_n_2;
  wire p_0_out_carry_n_3;
  wire p_0_out_carry_n_4;
  wire p_0_out_carry_n_5;
  wire p_0_out_carry_n_6;
  wire p_0_out_carry_n_7;
  wire [4:0]p_1_in;
  wire p_20_in;
  wire p_21_in;
  wire pop0;
  wire push;
  wire [61:0]q;
  wire rdata_ack_t;
  wire rreq_handling_reg_n_0;
  wire rs2f_rreq_ack;
  wire [61:0]rs2f_rreq_data;
  wire [63:2]sect_addr;
  wire \sect_addr_buf_reg_n_0_[10] ;
  wire \sect_addr_buf_reg_n_0_[11] ;
  wire \sect_addr_buf_reg_n_0_[12] ;
  wire \sect_addr_buf_reg_n_0_[13] ;
  wire \sect_addr_buf_reg_n_0_[14] ;
  wire \sect_addr_buf_reg_n_0_[15] ;
  wire \sect_addr_buf_reg_n_0_[16] ;
  wire \sect_addr_buf_reg_n_0_[17] ;
  wire \sect_addr_buf_reg_n_0_[18] ;
  wire \sect_addr_buf_reg_n_0_[19] ;
  wire \sect_addr_buf_reg_n_0_[20] ;
  wire \sect_addr_buf_reg_n_0_[21] ;
  wire \sect_addr_buf_reg_n_0_[22] ;
  wire \sect_addr_buf_reg_n_0_[23] ;
  wire \sect_addr_buf_reg_n_0_[24] ;
  wire \sect_addr_buf_reg_n_0_[25] ;
  wire \sect_addr_buf_reg_n_0_[26] ;
  wire \sect_addr_buf_reg_n_0_[27] ;
  wire \sect_addr_buf_reg_n_0_[28] ;
  wire \sect_addr_buf_reg_n_0_[29] ;
  wire \sect_addr_buf_reg_n_0_[2] ;
  wire \sect_addr_buf_reg_n_0_[30] ;
  wire \sect_addr_buf_reg_n_0_[31] ;
  wire \sect_addr_buf_reg_n_0_[32] ;
  wire \sect_addr_buf_reg_n_0_[33] ;
  wire \sect_addr_buf_reg_n_0_[34] ;
  wire \sect_addr_buf_reg_n_0_[35] ;
  wire \sect_addr_buf_reg_n_0_[36] ;
  wire \sect_addr_buf_reg_n_0_[37] ;
  wire \sect_addr_buf_reg_n_0_[38] ;
  wire \sect_addr_buf_reg_n_0_[39] ;
  wire \sect_addr_buf_reg_n_0_[3] ;
  wire \sect_addr_buf_reg_n_0_[40] ;
  wire \sect_addr_buf_reg_n_0_[41] ;
  wire \sect_addr_buf_reg_n_0_[42] ;
  wire \sect_addr_buf_reg_n_0_[43] ;
  wire \sect_addr_buf_reg_n_0_[44] ;
  wire \sect_addr_buf_reg_n_0_[45] ;
  wire \sect_addr_buf_reg_n_0_[46] ;
  wire \sect_addr_buf_reg_n_0_[47] ;
  wire \sect_addr_buf_reg_n_0_[48] ;
  wire \sect_addr_buf_reg_n_0_[49] ;
  wire \sect_addr_buf_reg_n_0_[4] ;
  wire \sect_addr_buf_reg_n_0_[50] ;
  wire \sect_addr_buf_reg_n_0_[51] ;
  wire \sect_addr_buf_reg_n_0_[52] ;
  wire \sect_addr_buf_reg_n_0_[53] ;
  wire \sect_addr_buf_reg_n_0_[54] ;
  wire \sect_addr_buf_reg_n_0_[55] ;
  wire \sect_addr_buf_reg_n_0_[56] ;
  wire \sect_addr_buf_reg_n_0_[57] ;
  wire \sect_addr_buf_reg_n_0_[58] ;
  wire \sect_addr_buf_reg_n_0_[59] ;
  wire \sect_addr_buf_reg_n_0_[5] ;
  wire \sect_addr_buf_reg_n_0_[60] ;
  wire \sect_addr_buf_reg_n_0_[61] ;
  wire \sect_addr_buf_reg_n_0_[62] ;
  wire \sect_addr_buf_reg_n_0_[63] ;
  wire \sect_addr_buf_reg_n_0_[6] ;
  wire \sect_addr_buf_reg_n_0_[7] ;
  wire \sect_addr_buf_reg_n_0_[8] ;
  wire \sect_addr_buf_reg_n_0_[9] ;
  wire [51:1]sect_cnt0;
  wire sect_cnt0_carry__0_n_0;
  wire sect_cnt0_carry__0_n_1;
  wire sect_cnt0_carry__0_n_2;
  wire sect_cnt0_carry__0_n_3;
  wire sect_cnt0_carry__10_n_0;
  wire sect_cnt0_carry__10_n_1;
  wire sect_cnt0_carry__10_n_2;
  wire sect_cnt0_carry__10_n_3;
  wire sect_cnt0_carry__11_n_2;
  wire sect_cnt0_carry__11_n_3;
  wire sect_cnt0_carry__1_n_0;
  wire sect_cnt0_carry__1_n_1;
  wire sect_cnt0_carry__1_n_2;
  wire sect_cnt0_carry__1_n_3;
  wire sect_cnt0_carry__2_n_0;
  wire sect_cnt0_carry__2_n_1;
  wire sect_cnt0_carry__2_n_2;
  wire sect_cnt0_carry__2_n_3;
  wire sect_cnt0_carry__3_n_0;
  wire sect_cnt0_carry__3_n_1;
  wire sect_cnt0_carry__3_n_2;
  wire sect_cnt0_carry__3_n_3;
  wire sect_cnt0_carry__4_n_0;
  wire sect_cnt0_carry__4_n_1;
  wire sect_cnt0_carry__4_n_2;
  wire sect_cnt0_carry__4_n_3;
  wire sect_cnt0_carry__5_n_0;
  wire sect_cnt0_carry__5_n_1;
  wire sect_cnt0_carry__5_n_2;
  wire sect_cnt0_carry__5_n_3;
  wire sect_cnt0_carry__6_n_0;
  wire sect_cnt0_carry__6_n_1;
  wire sect_cnt0_carry__6_n_2;
  wire sect_cnt0_carry__6_n_3;
  wire sect_cnt0_carry__7_n_0;
  wire sect_cnt0_carry__7_n_1;
  wire sect_cnt0_carry__7_n_2;
  wire sect_cnt0_carry__7_n_3;
  wire sect_cnt0_carry__8_n_0;
  wire sect_cnt0_carry__8_n_1;
  wire sect_cnt0_carry__8_n_2;
  wire sect_cnt0_carry__8_n_3;
  wire sect_cnt0_carry__9_n_0;
  wire sect_cnt0_carry__9_n_1;
  wire sect_cnt0_carry__9_n_2;
  wire sect_cnt0_carry__9_n_3;
  wire sect_cnt0_carry_n_0;
  wire sect_cnt0_carry_n_1;
  wire sect_cnt0_carry_n_2;
  wire sect_cnt0_carry_n_3;
  wire \sect_cnt_reg_n_0_[0] ;
  wire \sect_cnt_reg_n_0_[10] ;
  wire \sect_cnt_reg_n_0_[11] ;
  wire \sect_cnt_reg_n_0_[12] ;
  wire \sect_cnt_reg_n_0_[13] ;
  wire \sect_cnt_reg_n_0_[14] ;
  wire \sect_cnt_reg_n_0_[15] ;
  wire \sect_cnt_reg_n_0_[16] ;
  wire \sect_cnt_reg_n_0_[17] ;
  wire \sect_cnt_reg_n_0_[18] ;
  wire \sect_cnt_reg_n_0_[19] ;
  wire \sect_cnt_reg_n_0_[1] ;
  wire \sect_cnt_reg_n_0_[20] ;
  wire \sect_cnt_reg_n_0_[21] ;
  wire \sect_cnt_reg_n_0_[22] ;
  wire \sect_cnt_reg_n_0_[23] ;
  wire \sect_cnt_reg_n_0_[24] ;
  wire \sect_cnt_reg_n_0_[25] ;
  wire \sect_cnt_reg_n_0_[26] ;
  wire \sect_cnt_reg_n_0_[27] ;
  wire \sect_cnt_reg_n_0_[28] ;
  wire \sect_cnt_reg_n_0_[29] ;
  wire \sect_cnt_reg_n_0_[2] ;
  wire \sect_cnt_reg_n_0_[30] ;
  wire \sect_cnt_reg_n_0_[31] ;
  wire \sect_cnt_reg_n_0_[32] ;
  wire \sect_cnt_reg_n_0_[33] ;
  wire \sect_cnt_reg_n_0_[34] ;
  wire \sect_cnt_reg_n_0_[35] ;
  wire \sect_cnt_reg_n_0_[36] ;
  wire \sect_cnt_reg_n_0_[37] ;
  wire \sect_cnt_reg_n_0_[38] ;
  wire \sect_cnt_reg_n_0_[39] ;
  wire \sect_cnt_reg_n_0_[3] ;
  wire \sect_cnt_reg_n_0_[40] ;
  wire \sect_cnt_reg_n_0_[41] ;
  wire \sect_cnt_reg_n_0_[42] ;
  wire \sect_cnt_reg_n_0_[43] ;
  wire \sect_cnt_reg_n_0_[44] ;
  wire \sect_cnt_reg_n_0_[45] ;
  wire \sect_cnt_reg_n_0_[46] ;
  wire \sect_cnt_reg_n_0_[47] ;
  wire \sect_cnt_reg_n_0_[48] ;
  wire \sect_cnt_reg_n_0_[49] ;
  wire \sect_cnt_reg_n_0_[4] ;
  wire \sect_cnt_reg_n_0_[50] ;
  wire \sect_cnt_reg_n_0_[51] ;
  wire \sect_cnt_reg_n_0_[5] ;
  wire \sect_cnt_reg_n_0_[6] ;
  wire \sect_cnt_reg_n_0_[7] ;
  wire \sect_cnt_reg_n_0_[8] ;
  wire \sect_cnt_reg_n_0_[9] ;
  wire \sect_len_buf[0]_i_1_n_0 ;
  wire \sect_len_buf[1]_i_1_n_0 ;
  wire \sect_len_buf[2]_i_1_n_0 ;
  wire \sect_len_buf[3]_i_1_n_0 ;
  wire \sect_len_buf[4]_i_1_n_0 ;
  wire \sect_len_buf[5]_i_1_n_0 ;
  wire \sect_len_buf[6]_i_1_n_0 ;
  wire \sect_len_buf[7]_i_1_n_0 ;
  wire \sect_len_buf[8]_i_1_n_0 ;
  wire \sect_len_buf[9]_i_2_n_0 ;
  wire \sect_len_buf_reg_n_0_[5] ;
  wire \sect_len_buf_reg_n_0_[6] ;
  wire \sect_len_buf_reg_n_0_[7] ;
  wire \sect_len_buf_reg_n_0_[8] ;
  wire \sect_len_buf_reg_n_0_[9] ;
  wire \start_addr_buf_reg_n_0_[10] ;
  wire \start_addr_buf_reg_n_0_[11] ;
  wire \start_addr_buf_reg_n_0_[2] ;
  wire \start_addr_buf_reg_n_0_[3] ;
  wire \start_addr_buf_reg_n_0_[4] ;
  wire \start_addr_buf_reg_n_0_[5] ;
  wire \start_addr_buf_reg_n_0_[6] ;
  wire \start_addr_buf_reg_n_0_[7] ;
  wire \start_addr_buf_reg_n_0_[8] ;
  wire \start_addr_buf_reg_n_0_[9] ;
  wire \start_addr_reg_n_0_[10] ;
  wire \start_addr_reg_n_0_[11] ;
  wire \start_addr_reg_n_0_[12] ;
  wire \start_addr_reg_n_0_[13] ;
  wire \start_addr_reg_n_0_[14] ;
  wire \start_addr_reg_n_0_[15] ;
  wire \start_addr_reg_n_0_[16] ;
  wire \start_addr_reg_n_0_[17] ;
  wire \start_addr_reg_n_0_[18] ;
  wire \start_addr_reg_n_0_[19] ;
  wire \start_addr_reg_n_0_[20] ;
  wire \start_addr_reg_n_0_[21] ;
  wire \start_addr_reg_n_0_[22] ;
  wire \start_addr_reg_n_0_[23] ;
  wire \start_addr_reg_n_0_[24] ;
  wire \start_addr_reg_n_0_[25] ;
  wire \start_addr_reg_n_0_[26] ;
  wire \start_addr_reg_n_0_[27] ;
  wire \start_addr_reg_n_0_[28] ;
  wire \start_addr_reg_n_0_[29] ;
  wire \start_addr_reg_n_0_[2] ;
  wire \start_addr_reg_n_0_[30] ;
  wire \start_addr_reg_n_0_[31] ;
  wire \start_addr_reg_n_0_[32] ;
  wire \start_addr_reg_n_0_[33] ;
  wire \start_addr_reg_n_0_[34] ;
  wire \start_addr_reg_n_0_[35] ;
  wire \start_addr_reg_n_0_[36] ;
  wire \start_addr_reg_n_0_[37] ;
  wire \start_addr_reg_n_0_[38] ;
  wire \start_addr_reg_n_0_[39] ;
  wire \start_addr_reg_n_0_[3] ;
  wire \start_addr_reg_n_0_[40] ;
  wire \start_addr_reg_n_0_[41] ;
  wire \start_addr_reg_n_0_[42] ;
  wire \start_addr_reg_n_0_[43] ;
  wire \start_addr_reg_n_0_[44] ;
  wire \start_addr_reg_n_0_[45] ;
  wire \start_addr_reg_n_0_[46] ;
  wire \start_addr_reg_n_0_[47] ;
  wire \start_addr_reg_n_0_[48] ;
  wire \start_addr_reg_n_0_[49] ;
  wire \start_addr_reg_n_0_[4] ;
  wire \start_addr_reg_n_0_[50] ;
  wire \start_addr_reg_n_0_[51] ;
  wire \start_addr_reg_n_0_[52] ;
  wire \start_addr_reg_n_0_[53] ;
  wire \start_addr_reg_n_0_[54] ;
  wire \start_addr_reg_n_0_[55] ;
  wire \start_addr_reg_n_0_[56] ;
  wire \start_addr_reg_n_0_[57] ;
  wire \start_addr_reg_n_0_[58] ;
  wire \start_addr_reg_n_0_[59] ;
  wire \start_addr_reg_n_0_[5] ;
  wire \start_addr_reg_n_0_[60] ;
  wire \start_addr_reg_n_0_[61] ;
  wire \start_addr_reg_n_0_[62] ;
  wire \start_addr_reg_n_0_[63] ;
  wire \start_addr_reg_n_0_[6] ;
  wire \start_addr_reg_n_0_[7] ;
  wire \start_addr_reg_n_0_[8] ;
  wire \start_addr_reg_n_0_[9] ;
  wire zero_len_event0;
  wire [3:2]NLW_align_len0_carry_CO_UNCONNECTED;
  wire [3:0]NLW_align_len0_carry_O_UNCONNECTED;
  wire [0:0]\NLW_could_multi_bursts.araddr_buf_reg[4]_i_2_O_UNCONNECTED ;
  wire [3:2]\NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_O_UNCONNECTED ;
  wire [0:0]\NLW_end_addr_buf_reg[5]_i_1_O_UNCONNECTED ;
  wire [3:1]\NLW_end_addr_buf_reg[63]_i_1_CO_UNCONNECTED ;
  wire [3:2]\NLW_end_addr_buf_reg[63]_i_1_O_UNCONNECTED ;
  wire [3:0]NLW_first_sect_carry_O_UNCONNECTED;
  wire [3:0]NLW_first_sect_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_first_sect_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_first_sect_carry__2_O_UNCONNECTED;
  wire [3:2]NLW_first_sect_carry__3_CO_UNCONNECTED;
  wire [3:0]NLW_first_sect_carry__3_O_UNCONNECTED;
  wire [3:0]NLW_last_sect_carry_O_UNCONNECTED;
  wire [3:0]NLW_last_sect_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_last_sect_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_last_sect_carry__2_O_UNCONNECTED;
  wire [3:2]NLW_last_sect_carry__3_CO_UNCONNECTED;
  wire [3:0]NLW_last_sect_carry__3_O_UNCONNECTED;
  wire [3:3]NLW_p_0_out_carry__0_CO_UNCONNECTED;
  wire [3:2]NLW_sect_cnt0_carry__11_CO_UNCONNECTED;
  wire [3:3]NLW_sect_cnt0_carry__11_O_UNCONNECTED;

  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 align_len0_carry
       (.CI(1'b0),
        .CO({NLW_align_len0_carry_CO_UNCONNECTED[3:2],align_len0_carry_n_2,align_len0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,fifo_rreq_data,1'b0}),
        .O({NLW_align_len0_carry_O_UNCONNECTED[3],align_len0[31],align_len0[2],NLW_align_len0_carry_O_UNCONNECTED[0]}),
        .S({1'b0,1'b1,zero_len_event0,1'b1}));
  FDRE \align_len_reg[2] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(align_len0[2]),
        .Q(\align_len_reg_n_0_[2] ),
        .R(SR));
  FDRE \align_len_reg[31] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(align_len0[31]),
        .Q(\align_len_reg_n_0_[31] ),
        .R(SR));
  FDRE \beat_len_buf_reg[0] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\align_len_reg_n_0_[2] ),
        .Q(beat_len_buf[0]),
        .R(SR));
  FDRE \beat_len_buf_reg[7] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\align_len_reg_n_0_[31] ),
        .Q(beat_len_buf[7]),
        .R(SR));
  design_1_sound_operation_0_7_sound_operation_ram_m_axi_buffer__parameterized0 buff_rdata
       (.D(D),
        .DI({mOutPtr_reg[3:1],mOutPtr19_out}),
        .Q({mOutPtr_reg[6:4],mOutPtr_reg[0]}),
        .S({buff_rdata_n_46,buff_rdata_n_47,buff_rdata_n_48,buff_rdata_n_49}),
        .SR(SR),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .beat_valid(beat_valid),
        .\dout_buf_reg[34]_0 ({data_pack,buff_rdata_n_13,buff_rdata_n_14,buff_rdata_n_15,buff_rdata_n_16,buff_rdata_n_17,buff_rdata_n_18,buff_rdata_n_19,buff_rdata_n_20,buff_rdata_n_21,buff_rdata_n_22,buff_rdata_n_23,buff_rdata_n_24,buff_rdata_n_25,buff_rdata_n_26,buff_rdata_n_27,buff_rdata_n_28,buff_rdata_n_29,buff_rdata_n_30,buff_rdata_n_31,buff_rdata_n_32,buff_rdata_n_33,buff_rdata_n_34,buff_rdata_n_35,buff_rdata_n_36,buff_rdata_n_37,buff_rdata_n_38,buff_rdata_n_39,buff_rdata_n_40,buff_rdata_n_41,buff_rdata_n_42,buff_rdata_n_43,buff_rdata_n_44}),
        .dout_valid_reg_0(buff_rdata_n_45),
        .dout_valid_reg_1(\bus_equal_gen.rdata_valid_t_reg_n_0 ),
        .empty_n_reg_0(buff_rdata_n_11),
        .full_n_reg_0(full_n_reg),
        .\mOutPtr_reg[8]_0 ({buff_rdata_n_50,buff_rdata_n_51,buff_rdata_n_52,buff_rdata_n_53}),
        .\mOutPtr_reg[8]_1 ({p_0_out_carry__0_n_4,p_0_out_carry__0_n_5,p_0_out_carry__0_n_6,p_0_out_carry__0_n_7,p_0_out_carry_n_4,p_0_out_carry_n_5,p_0_out_carry_n_6,p_0_out_carry_n_7}),
        .m_axi_ram_RRESP(m_axi_ram_RRESP),
        .m_axi_ram_RVALID(m_axi_ram_RVALID),
        .\pout_reg[3] (fifo_rctl_n_0),
        .rdata_ack_t(rdata_ack_t));
  FDRE \bus_equal_gen.data_buf_reg[0] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_44),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[10] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_34),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[11] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_33),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[12] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_32),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[13] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_31),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[14] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_30),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[15] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_29),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[16] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_28),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[17] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_27),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[18] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_26),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[19] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_25),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[1] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_43),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[20] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_24),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[21] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_23),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[22] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_22),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[23] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_21),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[24] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_20),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[25] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_19),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[26] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_18),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[27] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_17),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[28] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_16),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[29] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_15),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[2] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_42),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[30] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_14),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[31] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_13),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[3] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_41),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[4] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_40),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[5] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_39),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[6] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_38),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[7] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_37),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[8] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_36),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \bus_equal_gen.data_buf_reg[9] 
       (.C(ap_clk),
        .CE(next_beat),
        .D(buff_rdata_n_35),
        .Q(\bus_equal_gen.data_buf_reg_n_0_[9] ),
        .R(1'b0));
  FDRE \bus_equal_gen.rdata_valid_t_reg 
       (.C(ap_clk),
        .CE(1'b1),
        .D(buff_rdata_n_45),
        .Q(\bus_equal_gen.rdata_valid_t_reg_n_0 ),
        .R(SR));
  FDRE \could_multi_bursts.ARVALID_Dummy_reg 
       (.C(ap_clk),
        .CE(1'b1),
        .D(fifo_rctl_n_1),
        .Q(\could_multi_bursts.ARVALID_Dummy_reg_0 ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair163" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[10]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[10] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[10]),
        .O(araddr_tmp[10]));
  (* SOFT_HLUTNM = "soft_lutpair164" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[11]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[11] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[11]),
        .O(araddr_tmp[11]));
  (* SOFT_HLUTNM = "soft_lutpair164" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[12]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[12] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[12]),
        .O(araddr_tmp[12]));
  (* SOFT_HLUTNM = "soft_lutpair163" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[13]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[13] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[13]),
        .O(araddr_tmp[13]));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[14]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[14] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[14]),
        .O(araddr_tmp[14]));
  (* SOFT_HLUTNM = "soft_lutpair136" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[15]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[15] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[15]),
        .O(araddr_tmp[15]));
  (* SOFT_HLUTNM = "soft_lutpair136" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[16]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[16] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[16]),
        .O(araddr_tmp[16]));
  (* SOFT_HLUTNM = "soft_lutpair135" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[17]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[17] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[17]),
        .O(araddr_tmp[17]));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[18]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[18] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[18]),
        .O(araddr_tmp[18]));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[19]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[19] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[19]),
        .O(araddr_tmp[19]));
  (* SOFT_HLUTNM = "soft_lutpair134" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[20]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[20] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[20]),
        .O(araddr_tmp[20]));
  (* SOFT_HLUTNM = "soft_lutpair133" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[21]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[21] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[21]),
        .O(araddr_tmp[21]));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[22]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[22] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[22]),
        .O(araddr_tmp[22]));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[23]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[23] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[23]),
        .O(araddr_tmp[23]));
  (* SOFT_HLUTNM = "soft_lutpair132" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[24]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[24] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[24]),
        .O(araddr_tmp[24]));
  (* SOFT_HLUTNM = "soft_lutpair131" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[25]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[25] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[25]),
        .O(araddr_tmp[25]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[26]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[26] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[26]),
        .O(araddr_tmp[26]));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[27]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[27] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[27]),
        .O(araddr_tmp[27]));
  (* SOFT_HLUTNM = "soft_lutpair130" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[28]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[28] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[28]),
        .O(araddr_tmp[28]));
  (* SOFT_HLUTNM = "soft_lutpair129" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[29]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[29] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[29]),
        .O(araddr_tmp[29]));
  (* SOFT_HLUTNM = "soft_lutpair168" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[2]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[2] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[2]),
        .O(araddr_tmp[2]));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[30]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[30] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[30]),
        .O(araddr_tmp[30]));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[31]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[31] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[31]),
        .O(araddr_tmp[31]));
  (* SOFT_HLUTNM = "soft_lutpair128" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[32]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[32] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[32]),
        .O(araddr_tmp[32]));
  (* SOFT_HLUTNM = "soft_lutpair127" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[33]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[33] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[33]),
        .O(araddr_tmp[33]));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[34]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[34] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[34]),
        .O(araddr_tmp[34]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[35]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[35] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[35]),
        .O(araddr_tmp[35]));
  (* SOFT_HLUTNM = "soft_lutpair126" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[36]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[36] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[36]),
        .O(araddr_tmp[36]));
  (* SOFT_HLUTNM = "soft_lutpair125" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[37]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[37] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[37]),
        .O(araddr_tmp[37]));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[38]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[38] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[38]),
        .O(araddr_tmp[38]));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[39]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[39] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[39]),
        .O(araddr_tmp[39]));
  (* SOFT_HLUTNM = "soft_lutpair168" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[3]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[3] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[3]),
        .O(araddr_tmp[3]));
  (* SOFT_HLUTNM = "soft_lutpair124" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[40]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[40] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[40]),
        .O(araddr_tmp[40]));
  (* SOFT_HLUTNM = "soft_lutpair123" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[41]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[41] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[41]),
        .O(araddr_tmp[41]));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[42]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[42] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[42]),
        .O(araddr_tmp[42]));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[43]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[43] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[43]),
        .O(araddr_tmp[43]));
  (* SOFT_HLUTNM = "soft_lutpair122" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[44]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[44] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[44]),
        .O(araddr_tmp[44]));
  (* SOFT_HLUTNM = "soft_lutpair121" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[45]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[45] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[45]),
        .O(araddr_tmp[45]));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[46]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[46] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[46]),
        .O(araddr_tmp[46]));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[47]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[47] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[47]),
        .O(araddr_tmp[47]));
  (* SOFT_HLUTNM = "soft_lutpair120" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[48]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[48] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[48]),
        .O(araddr_tmp[48]));
  (* SOFT_HLUTNM = "soft_lutpair119" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[49]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[49] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[49]),
        .O(araddr_tmp[49]));
  (* SOFT_HLUTNM = "soft_lutpair167" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[4]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[4] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[4]),
        .O(araddr_tmp[4]));
  LUT4 #(
    .INIT(16'h956A)) 
    \could_multi_bursts.araddr_buf[4]_i_3 
       (.I0(m_axi_ram_ARADDR[2]),
        .I1(\could_multi_bursts.arlen_buf_reg[4]_0 [0]),
        .I2(\could_multi_bursts.arlen_buf_reg[4]_0 [1]),
        .I3(\could_multi_bursts.arlen_buf_reg[4]_0 [2]),
        .O(\could_multi_bursts.araddr_buf[4]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \could_multi_bursts.araddr_buf[4]_i_4 
       (.I0(m_axi_ram_ARADDR[1]),
        .I1(\could_multi_bursts.arlen_buf_reg[4]_0 [1]),
        .I2(\could_multi_bursts.arlen_buf_reg[4]_0 [0]),
        .O(\could_multi_bursts.araddr_buf[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \could_multi_bursts.araddr_buf[4]_i_5 
       (.I0(m_axi_ram_ARADDR[0]),
        .I1(\could_multi_bursts.arlen_buf_reg[4]_0 [0]),
        .O(\could_multi_bursts.araddr_buf[4]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[50]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[50] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[50]),
        .O(araddr_tmp[50]));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[51]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[51] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[51]),
        .O(araddr_tmp[51]));
  (* SOFT_HLUTNM = "soft_lutpair118" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[52]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[52] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[52]),
        .O(araddr_tmp[52]));
  (* SOFT_HLUTNM = "soft_lutpair117" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[53]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[53] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[53]),
        .O(araddr_tmp[53]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[54]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[54] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[54]),
        .O(araddr_tmp[54]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[55]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[55] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[55]),
        .O(araddr_tmp[55]));
  (* SOFT_HLUTNM = "soft_lutpair116" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[56]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[56] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[56]),
        .O(araddr_tmp[56]));
  (* SOFT_HLUTNM = "soft_lutpair115" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[57]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[57] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[57]),
        .O(araddr_tmp[57]));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[58]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[58] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[58]),
        .O(araddr_tmp[58]));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[59]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[59] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[59]),
        .O(araddr_tmp[59]));
  (* SOFT_HLUTNM = "soft_lutpair167" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[5]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[5] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[5]),
        .O(araddr_tmp[5]));
  (* SOFT_HLUTNM = "soft_lutpair114" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[60]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[60] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[60]),
        .O(araddr_tmp[60]));
  (* SOFT_HLUTNM = "soft_lutpair113" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[61]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[61] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[61]),
        .O(araddr_tmp[61]));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[62]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[62] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[62]),
        .O(araddr_tmp[62]));
  (* SOFT_HLUTNM = "soft_lutpair112" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[63]_i_3 
       (.I0(\sect_addr_buf_reg_n_0_[63] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[63]),
        .O(araddr_tmp[63]));
  LUT5 #(
    .INIT(32'h00000001)) 
    \could_multi_bursts.araddr_buf[63]_i_4 
       (.I0(\could_multi_bursts.loop_cnt_reg [0]),
        .I1(\could_multi_bursts.loop_cnt_reg [1]),
        .I2(\could_multi_bursts.loop_cnt_reg [4]),
        .I3(\could_multi_bursts.loop_cnt_reg [2]),
        .I4(\could_multi_bursts.loop_cnt_reg [3]),
        .O(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair165" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[6]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[6] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[6]),
        .O(araddr_tmp[6]));
  (* SOFT_HLUTNM = "soft_lutpair166" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[7]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[7] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[7]),
        .O(araddr_tmp[7]));
  (* SOFT_HLUTNM = "soft_lutpair166" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[8]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[8] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[8]),
        .O(araddr_tmp[8]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \could_multi_bursts.araddr_buf[8]_i_3 
       (.I0(m_axi_ram_ARADDR[5]),
        .I1(\could_multi_bursts.arlen_buf_reg[4]_0 [3]),
        .I2(\could_multi_bursts.arlen_buf_reg[4]_0 [0]),
        .I3(\could_multi_bursts.arlen_buf_reg[4]_0 [1]),
        .I4(\could_multi_bursts.arlen_buf_reg[4]_0 [2]),
        .I5(\could_multi_bursts.arlen_buf_reg[4]_0 [4]),
        .O(\could_multi_bursts.araddr_buf[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h955555556AAAAAAA)) 
    \could_multi_bursts.araddr_buf[8]_i_4 
       (.I0(m_axi_ram_ARADDR[4]),
        .I1(\could_multi_bursts.arlen_buf_reg[4]_0 [3]),
        .I2(\could_multi_bursts.arlen_buf_reg[4]_0 [0]),
        .I3(\could_multi_bursts.arlen_buf_reg[4]_0 [1]),
        .I4(\could_multi_bursts.arlen_buf_reg[4]_0 [2]),
        .I5(\could_multi_bursts.arlen_buf_reg[4]_0 [4]),
        .O(\could_multi_bursts.araddr_buf[8]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h95556AAA)) 
    \could_multi_bursts.araddr_buf[8]_i_5 
       (.I0(m_axi_ram_ARADDR[3]),
        .I1(\could_multi_bursts.arlen_buf_reg[4]_0 [2]),
        .I2(\could_multi_bursts.arlen_buf_reg[4]_0 [1]),
        .I3(\could_multi_bursts.arlen_buf_reg[4]_0 [0]),
        .I4(\could_multi_bursts.arlen_buf_reg[4]_0 [3]),
        .O(\could_multi_bursts.araddr_buf[8]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair165" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \could_multi_bursts.araddr_buf[9]_i_1 
       (.I0(\sect_addr_buf_reg_n_0_[9] ),
        .I1(\could_multi_bursts.araddr_buf[63]_i_4_n_0 ),
        .I2(data1[9]),
        .O(araddr_tmp[9]));
  FDRE \could_multi_bursts.araddr_buf_reg[10] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[10]),
        .Q(m_axi_ram_ARADDR[8]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[11] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[11]),
        .Q(m_axi_ram_ARADDR[9]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[12] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[12]),
        .Q(m_axi_ram_ARADDR[10]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[12]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[8]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[12]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[12]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[12]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,m_axi_ram_ARADDR[8:7]}),
        .O(data1[12:9]),
        .S(m_axi_ram_ARADDR[10:7]));
  FDRE \could_multi_bursts.araddr_buf_reg[13] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[13]),
        .Q(m_axi_ram_ARADDR[11]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[14] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[14]),
        .Q(m_axi_ram_ARADDR[12]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[15] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[15]),
        .Q(m_axi_ram_ARADDR[13]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[16] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[16]),
        .Q(m_axi_ram_ARADDR[14]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[16]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[12]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[16]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[16]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[16]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[16:13]),
        .S(m_axi_ram_ARADDR[14:11]));
  FDRE \could_multi_bursts.araddr_buf_reg[17] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[17]),
        .Q(m_axi_ram_ARADDR[15]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[18] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[18]),
        .Q(m_axi_ram_ARADDR[16]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[19] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[19]),
        .Q(m_axi_ram_ARADDR[17]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[20] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[20]),
        .Q(m_axi_ram_ARADDR[18]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[20]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[16]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[20]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[20]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[20]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[20:17]),
        .S(m_axi_ram_ARADDR[18:15]));
  FDRE \could_multi_bursts.araddr_buf_reg[21] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[21]),
        .Q(m_axi_ram_ARADDR[19]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[22] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[22]),
        .Q(m_axi_ram_ARADDR[20]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[23] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[23]),
        .Q(m_axi_ram_ARADDR[21]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[24] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[24]),
        .Q(m_axi_ram_ARADDR[22]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[24]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[20]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[24]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[24]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[24]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[24:21]),
        .S(m_axi_ram_ARADDR[22:19]));
  FDRE \could_multi_bursts.araddr_buf_reg[25] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[25]),
        .Q(m_axi_ram_ARADDR[23]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[26] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[26]),
        .Q(m_axi_ram_ARADDR[24]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[27] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[27]),
        .Q(m_axi_ram_ARADDR[25]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[28] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[28]),
        .Q(m_axi_ram_ARADDR[26]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[28]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[24]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[28]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[28]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[28]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[28:25]),
        .S(m_axi_ram_ARADDR[26:23]));
  FDRE \could_multi_bursts.araddr_buf_reg[29] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[29]),
        .Q(m_axi_ram_ARADDR[27]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[2] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[2]),
        .Q(m_axi_ram_ARADDR[0]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[30] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[30]),
        .Q(m_axi_ram_ARADDR[28]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[31] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[31]),
        .Q(m_axi_ram_ARADDR[29]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[32] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[32]),
        .Q(m_axi_ram_ARADDR[30]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[32]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[28]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[32]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[32]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[32]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[32]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[32:29]),
        .S(m_axi_ram_ARADDR[30:27]));
  FDRE \could_multi_bursts.araddr_buf_reg[33] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[33]),
        .Q(m_axi_ram_ARADDR[31]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[34] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[34]),
        .Q(m_axi_ram_ARADDR[32]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[35] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[35]),
        .Q(m_axi_ram_ARADDR[33]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[36] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[36]),
        .Q(m_axi_ram_ARADDR[34]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[36]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[32]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[36]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[36]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[36]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[36]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[36:33]),
        .S(m_axi_ram_ARADDR[34:31]));
  FDRE \could_multi_bursts.araddr_buf_reg[37] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[37]),
        .Q(m_axi_ram_ARADDR[35]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[38] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[38]),
        .Q(m_axi_ram_ARADDR[36]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[39] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[39]),
        .Q(m_axi_ram_ARADDR[37]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[3] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[3]),
        .Q(m_axi_ram_ARADDR[1]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[40] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[40]),
        .Q(m_axi_ram_ARADDR[38]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[40]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[36]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[40]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[40]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[40]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[40]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[40:37]),
        .S(m_axi_ram_ARADDR[38:35]));
  FDRE \could_multi_bursts.araddr_buf_reg[41] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[41]),
        .Q(m_axi_ram_ARADDR[39]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[42] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[42]),
        .Q(m_axi_ram_ARADDR[40]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[43] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[43]),
        .Q(m_axi_ram_ARADDR[41]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[44] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[44]),
        .Q(m_axi_ram_ARADDR[42]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[44]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[40]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[44]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[44]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[44]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[44]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[44:41]),
        .S(m_axi_ram_ARADDR[42:39]));
  FDRE \could_multi_bursts.araddr_buf_reg[45] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[45]),
        .Q(m_axi_ram_ARADDR[43]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[46] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[46]),
        .Q(m_axi_ram_ARADDR[44]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[47] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[47]),
        .Q(m_axi_ram_ARADDR[45]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[48] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[48]),
        .Q(m_axi_ram_ARADDR[46]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[48]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[44]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[48]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[48]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[48]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[48]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[48:45]),
        .S(m_axi_ram_ARADDR[46:43]));
  FDRE \could_multi_bursts.araddr_buf_reg[49] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[49]),
        .Q(m_axi_ram_ARADDR[47]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[4] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[4]),
        .Q(m_axi_ram_ARADDR[2]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\could_multi_bursts.araddr_buf_reg[4]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[4]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[4]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[4]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({m_axi_ram_ARADDR[2:0],1'b0}),
        .O({data1[4:2],\NLW_could_multi_bursts.araddr_buf_reg[4]_i_2_O_UNCONNECTED [0]}),
        .S({\could_multi_bursts.araddr_buf[4]_i_3_n_0 ,\could_multi_bursts.araddr_buf[4]_i_4_n_0 ,\could_multi_bursts.araddr_buf[4]_i_5_n_0 ,1'b0}));
  FDRE \could_multi_bursts.araddr_buf_reg[50] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[50]),
        .Q(m_axi_ram_ARADDR[48]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[51] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[51]),
        .Q(m_axi_ram_ARADDR[49]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[52] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[52]),
        .Q(m_axi_ram_ARADDR[50]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[52]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[48]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[52]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[52]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[52]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[52]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[52:49]),
        .S(m_axi_ram_ARADDR[50:47]));
  FDRE \could_multi_bursts.araddr_buf_reg[53] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[53]),
        .Q(m_axi_ram_ARADDR[51]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[54] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[54]),
        .Q(m_axi_ram_ARADDR[52]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[55] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[55]),
        .Q(m_axi_ram_ARADDR[53]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[56] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[56]),
        .Q(m_axi_ram_ARADDR[54]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[56]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[52]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[56]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[56]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[56]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[56]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[56:53]),
        .S(m_axi_ram_ARADDR[54:51]));
  FDRE \could_multi_bursts.araddr_buf_reg[57] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[57]),
        .Q(m_axi_ram_ARADDR[55]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[58] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[58]),
        .Q(m_axi_ram_ARADDR[56]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[59] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[59]),
        .Q(m_axi_ram_ARADDR[57]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[5] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[5]),
        .Q(m_axi_ram_ARADDR[3]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[60] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[60]),
        .Q(m_axi_ram_ARADDR[58]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[60]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[56]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[60]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[60]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[60]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[60]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data1[60:57]),
        .S(m_axi_ram_ARADDR[58:55]));
  FDRE \could_multi_bursts.araddr_buf_reg[61] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[61]),
        .Q(m_axi_ram_ARADDR[59]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[62] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[62]),
        .Q(m_axi_ram_ARADDR[60]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[63] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[63]),
        .Q(m_axi_ram_ARADDR[61]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[63]_i_5 
       (.CI(\could_multi_bursts.araddr_buf_reg[60]_i_2_n_0 ),
        .CO({\NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_CO_UNCONNECTED [3:2],\could_multi_bursts.araddr_buf_reg[63]_i_5_n_2 ,\could_multi_bursts.araddr_buf_reg[63]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_O_UNCONNECTED [3],data1[63:61]}),
        .S({1'b0,m_axi_ram_ARADDR[61:59]}));
  FDRE \could_multi_bursts.araddr_buf_reg[6] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[6]),
        .Q(m_axi_ram_ARADDR[4]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[7] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[7]),
        .Q(m_axi_ram_ARADDR[5]),
        .R(SR));
  FDRE \could_multi_bursts.araddr_buf_reg[8] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[8]),
        .Q(m_axi_ram_ARADDR[6]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \could_multi_bursts.araddr_buf_reg[8]_i_2 
       (.CI(\could_multi_bursts.araddr_buf_reg[4]_i_2_n_0 ),
        .CO({\could_multi_bursts.araddr_buf_reg[8]_i_2_n_0 ,\could_multi_bursts.araddr_buf_reg[8]_i_2_n_1 ,\could_multi_bursts.araddr_buf_reg[8]_i_2_n_2 ,\could_multi_bursts.araddr_buf_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(m_axi_ram_ARADDR[6:3]),
        .O(data1[8:5]),
        .S({m_axi_ram_ARADDR[6],\could_multi_bursts.araddr_buf[8]_i_3_n_0 ,\could_multi_bursts.araddr_buf[8]_i_4_n_0 ,\could_multi_bursts.araddr_buf[8]_i_5_n_0 }));
  FDRE \could_multi_bursts.araddr_buf_reg[9] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(araddr_tmp[9]),
        .Q(m_axi_ram_ARADDR[7]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT5 #(
    .INIT(32'h00009009)) 
    \could_multi_bursts.arlen_buf[4]_i_3 
       (.I0(\could_multi_bursts.loop_cnt_reg [0]),
        .I1(\sect_len_buf_reg_n_0_[5] ),
        .I2(\could_multi_bursts.loop_cnt_reg [1]),
        .I3(\sect_len_buf_reg_n_0_[6] ),
        .I4(fifo_rreq_n_55),
        .O(\could_multi_bursts.arlen_buf[4]_i_3_n_0 ));
  FDRE \could_multi_bursts.arlen_buf_reg[0] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_11),
        .D(fifo_rctl_n_12),
        .Q(\could_multi_bursts.arlen_buf_reg[4]_0 [0]),
        .R(SR));
  FDRE \could_multi_bursts.arlen_buf_reg[1] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_11),
        .D(fifo_rctl_n_13),
        .Q(\could_multi_bursts.arlen_buf_reg[4]_0 [1]),
        .R(SR));
  FDRE \could_multi_bursts.arlen_buf_reg[2] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_11),
        .D(fifo_rctl_n_14),
        .Q(\could_multi_bursts.arlen_buf_reg[4]_0 [2]),
        .R(SR));
  FDRE \could_multi_bursts.arlen_buf_reg[3] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_11),
        .D(fifo_rctl_n_15),
        .Q(\could_multi_bursts.arlen_buf_reg[4]_0 [3]),
        .R(SR));
  FDRE \could_multi_bursts.arlen_buf_reg[4] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_11),
        .D(fifo_rctl_n_16),
        .Q(\could_multi_bursts.arlen_buf_reg[4]_0 [4]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair169" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \could_multi_bursts.loop_cnt[0]_i_1 
       (.I0(\could_multi_bursts.loop_cnt_reg [0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \could_multi_bursts.loop_cnt[1]_i_1 
       (.I0(\could_multi_bursts.loop_cnt_reg [1]),
        .I1(\could_multi_bursts.loop_cnt_reg [0]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair169" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \could_multi_bursts.loop_cnt[2]_i_1 
       (.I0(\could_multi_bursts.loop_cnt_reg [2]),
        .I1(\could_multi_bursts.loop_cnt_reg [0]),
        .I2(\could_multi_bursts.loop_cnt_reg [1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \could_multi_bursts.loop_cnt[3]_i_1 
       (.I0(\could_multi_bursts.loop_cnt_reg [3]),
        .I1(\could_multi_bursts.loop_cnt_reg [1]),
        .I2(\could_multi_bursts.loop_cnt_reg [0]),
        .I3(\could_multi_bursts.loop_cnt_reg [2]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \could_multi_bursts.loop_cnt[4]_i_2 
       (.I0(\could_multi_bursts.loop_cnt_reg [4]),
        .I1(\could_multi_bursts.loop_cnt_reg [2]),
        .I2(\could_multi_bursts.loop_cnt_reg [0]),
        .I3(\could_multi_bursts.loop_cnt_reg [1]),
        .I4(\could_multi_bursts.loop_cnt_reg [3]),
        .O(p_0_in[4]));
  FDRE \could_multi_bursts.loop_cnt_reg[0] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(p_0_in[0]),
        .Q(\could_multi_bursts.loop_cnt_reg [0]),
        .R(fifo_rctl_n_8));
  FDRE \could_multi_bursts.loop_cnt_reg[1] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(p_0_in[1]),
        .Q(\could_multi_bursts.loop_cnt_reg [1]),
        .R(fifo_rctl_n_8));
  FDRE \could_multi_bursts.loop_cnt_reg[2] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(p_0_in[2]),
        .Q(\could_multi_bursts.loop_cnt_reg [2]),
        .R(fifo_rctl_n_8));
  FDRE \could_multi_bursts.loop_cnt_reg[3] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(p_0_in[3]),
        .Q(\could_multi_bursts.loop_cnt_reg [3]),
        .R(fifo_rctl_n_8));
  FDRE \could_multi_bursts.loop_cnt_reg[4] 
       (.C(ap_clk),
        .CE(p_20_in),
        .D(p_0_in[4]),
        .Q(\could_multi_bursts.loop_cnt_reg [4]),
        .R(fifo_rctl_n_8));
  FDRE \could_multi_bursts.sect_handling_reg 
       (.C(ap_clk),
        .CE(1'b1),
        .D(fifo_rctl_n_7),
        .Q(\could_multi_bursts.sect_handling_reg_n_0 ),
        .R(SR));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[13]_i_2 
       (.I0(\start_addr_reg_n_0_[13] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[13]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[13]_i_3 
       (.I0(\start_addr_reg_n_0_[12] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[13]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[13]_i_4 
       (.I0(\start_addr_reg_n_0_[11] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[13]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[13]_i_5 
       (.I0(\start_addr_reg_n_0_[10] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[13]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[17]_i_2 
       (.I0(\start_addr_reg_n_0_[17] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[17]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[17]_i_3 
       (.I0(\start_addr_reg_n_0_[16] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[17]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[17]_i_4 
       (.I0(\start_addr_reg_n_0_[15] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[17]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[17]_i_5 
       (.I0(\start_addr_reg_n_0_[14] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[17]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[21]_i_2 
       (.I0(\start_addr_reg_n_0_[21] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[21]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[21]_i_3 
       (.I0(\start_addr_reg_n_0_[20] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[21]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[21]_i_4 
       (.I0(\start_addr_reg_n_0_[19] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[21]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[21]_i_5 
       (.I0(\start_addr_reg_n_0_[18] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[21]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[25]_i_2 
       (.I0(\start_addr_reg_n_0_[25] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[25]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[25]_i_3 
       (.I0(\start_addr_reg_n_0_[24] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[25]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[25]_i_4 
       (.I0(\start_addr_reg_n_0_[23] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[25]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[25]_i_5 
       (.I0(\start_addr_reg_n_0_[22] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[25]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[29]_i_2 
       (.I0(\start_addr_reg_n_0_[29] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[29]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[29]_i_3 
       (.I0(\start_addr_reg_n_0_[28] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[29]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[29]_i_4 
       (.I0(\start_addr_reg_n_0_[27] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[29]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[29]_i_5 
       (.I0(\start_addr_reg_n_0_[26] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[29]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[2]_i_1 
       (.I0(\start_addr_reg_n_0_[2] ),
        .I1(\align_len_reg_n_0_[2] ),
        .O(end_addr[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[33]_i_2 
       (.I0(\start_addr_reg_n_0_[31] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[33]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[33]_i_3 
       (.I0(\start_addr_reg_n_0_[30] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[33]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[5]_i_2 
       (.I0(\start_addr_reg_n_0_[5] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[5]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[5]_i_3 
       (.I0(\start_addr_reg_n_0_[4] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[5]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[5]_i_4 
       (.I0(\start_addr_reg_n_0_[3] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[5]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[5]_i_5 
       (.I0(\start_addr_reg_n_0_[2] ),
        .I1(\align_len_reg_n_0_[2] ),
        .O(\end_addr_buf[5]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[9]_i_2 
       (.I0(\start_addr_reg_n_0_[9] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[9]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[9]_i_3 
       (.I0(\start_addr_reg_n_0_[8] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[9]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[9]_i_4 
       (.I0(\start_addr_reg_n_0_[7] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[9]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \end_addr_buf[9]_i_5 
       (.I0(\start_addr_reg_n_0_[6] ),
        .I1(\align_len_reg_n_0_[31] ),
        .O(\end_addr_buf[9]_i_5_n_0 ));
  FDRE \end_addr_buf_reg[10] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[10]),
        .Q(\end_addr_buf_reg_n_0_[10] ),
        .R(SR));
  FDRE \end_addr_buf_reg[11] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[11]),
        .Q(\end_addr_buf_reg_n_0_[11] ),
        .R(SR));
  FDRE \end_addr_buf_reg[12] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[12]),
        .Q(p_0_in0_in[0]),
        .R(SR));
  FDRE \end_addr_buf_reg[13] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[13]),
        .Q(p_0_in0_in[1]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[13]_i_1 
       (.CI(\end_addr_buf_reg[9]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[13]_i_1_n_0 ,\end_addr_buf_reg[13]_i_1_n_1 ,\end_addr_buf_reg[13]_i_1_n_2 ,\end_addr_buf_reg[13]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\start_addr_reg_n_0_[13] ,\start_addr_reg_n_0_[12] ,\start_addr_reg_n_0_[11] ,\start_addr_reg_n_0_[10] }),
        .O(end_addr[13:10]),
        .S({\end_addr_buf[13]_i_2_n_0 ,\end_addr_buf[13]_i_3_n_0 ,\end_addr_buf[13]_i_4_n_0 ,\end_addr_buf[13]_i_5_n_0 }));
  FDRE \end_addr_buf_reg[14] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[14]),
        .Q(p_0_in0_in[2]),
        .R(SR));
  FDRE \end_addr_buf_reg[15] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[15]),
        .Q(p_0_in0_in[3]),
        .R(SR));
  FDRE \end_addr_buf_reg[16] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[16]),
        .Q(p_0_in0_in[4]),
        .R(SR));
  FDRE \end_addr_buf_reg[17] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[17]),
        .Q(p_0_in0_in[5]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[17]_i_1 
       (.CI(\end_addr_buf_reg[13]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[17]_i_1_n_0 ,\end_addr_buf_reg[17]_i_1_n_1 ,\end_addr_buf_reg[17]_i_1_n_2 ,\end_addr_buf_reg[17]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\start_addr_reg_n_0_[17] ,\start_addr_reg_n_0_[16] ,\start_addr_reg_n_0_[15] ,\start_addr_reg_n_0_[14] }),
        .O(end_addr[17:14]),
        .S({\end_addr_buf[17]_i_2_n_0 ,\end_addr_buf[17]_i_3_n_0 ,\end_addr_buf[17]_i_4_n_0 ,\end_addr_buf[17]_i_5_n_0 }));
  FDRE \end_addr_buf_reg[18] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[18]),
        .Q(p_0_in0_in[6]),
        .R(SR));
  FDRE \end_addr_buf_reg[19] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[19]),
        .Q(p_0_in0_in[7]),
        .R(SR));
  FDRE \end_addr_buf_reg[20] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[20]),
        .Q(p_0_in0_in[8]),
        .R(SR));
  FDRE \end_addr_buf_reg[21] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[21]),
        .Q(p_0_in0_in[9]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[21]_i_1 
       (.CI(\end_addr_buf_reg[17]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[21]_i_1_n_0 ,\end_addr_buf_reg[21]_i_1_n_1 ,\end_addr_buf_reg[21]_i_1_n_2 ,\end_addr_buf_reg[21]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\start_addr_reg_n_0_[21] ,\start_addr_reg_n_0_[20] ,\start_addr_reg_n_0_[19] ,\start_addr_reg_n_0_[18] }),
        .O(end_addr[21:18]),
        .S({\end_addr_buf[21]_i_2_n_0 ,\end_addr_buf[21]_i_3_n_0 ,\end_addr_buf[21]_i_4_n_0 ,\end_addr_buf[21]_i_5_n_0 }));
  FDRE \end_addr_buf_reg[22] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[22]),
        .Q(p_0_in0_in[10]),
        .R(SR));
  FDRE \end_addr_buf_reg[23] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[23]),
        .Q(p_0_in0_in[11]),
        .R(SR));
  FDRE \end_addr_buf_reg[24] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[24]),
        .Q(p_0_in0_in[12]),
        .R(SR));
  FDRE \end_addr_buf_reg[25] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[25]),
        .Q(p_0_in0_in[13]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[25]_i_1 
       (.CI(\end_addr_buf_reg[21]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[25]_i_1_n_0 ,\end_addr_buf_reg[25]_i_1_n_1 ,\end_addr_buf_reg[25]_i_1_n_2 ,\end_addr_buf_reg[25]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\start_addr_reg_n_0_[25] ,\start_addr_reg_n_0_[24] ,\start_addr_reg_n_0_[23] ,\start_addr_reg_n_0_[22] }),
        .O(end_addr[25:22]),
        .S({\end_addr_buf[25]_i_2_n_0 ,\end_addr_buf[25]_i_3_n_0 ,\end_addr_buf[25]_i_4_n_0 ,\end_addr_buf[25]_i_5_n_0 }));
  FDRE \end_addr_buf_reg[26] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[26]),
        .Q(p_0_in0_in[14]),
        .R(SR));
  FDRE \end_addr_buf_reg[27] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[27]),
        .Q(p_0_in0_in[15]),
        .R(SR));
  FDRE \end_addr_buf_reg[28] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[28]),
        .Q(p_0_in0_in[16]),
        .R(SR));
  FDRE \end_addr_buf_reg[29] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[29]),
        .Q(p_0_in0_in[17]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[29]_i_1 
       (.CI(\end_addr_buf_reg[25]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[29]_i_1_n_0 ,\end_addr_buf_reg[29]_i_1_n_1 ,\end_addr_buf_reg[29]_i_1_n_2 ,\end_addr_buf_reg[29]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\start_addr_reg_n_0_[29] ,\start_addr_reg_n_0_[28] ,\start_addr_reg_n_0_[27] ,\start_addr_reg_n_0_[26] }),
        .O(end_addr[29:26]),
        .S({\end_addr_buf[29]_i_2_n_0 ,\end_addr_buf[29]_i_3_n_0 ,\end_addr_buf[29]_i_4_n_0 ,\end_addr_buf[29]_i_5_n_0 }));
  FDRE \end_addr_buf_reg[2] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[2]),
        .Q(\end_addr_buf_reg_n_0_[2] ),
        .R(SR));
  FDRE \end_addr_buf_reg[30] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[30]),
        .Q(p_0_in0_in[18]),
        .R(SR));
  FDRE \end_addr_buf_reg[31] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[31]),
        .Q(p_0_in0_in[19]),
        .R(SR));
  FDRE \end_addr_buf_reg[32] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[32]),
        .Q(p_0_in0_in[20]),
        .R(SR));
  FDRE \end_addr_buf_reg[33] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[33]),
        .Q(p_0_in0_in[21]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[33]_i_1 
       (.CI(\end_addr_buf_reg[29]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[33]_i_1_n_0 ,\end_addr_buf_reg[33]_i_1_n_1 ,\end_addr_buf_reg[33]_i_1_n_2 ,\end_addr_buf_reg[33]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\start_addr_reg_n_0_[31] ,\start_addr_reg_n_0_[30] }),
        .O(end_addr[33:30]),
        .S({\start_addr_reg_n_0_[33] ,\start_addr_reg_n_0_[32] ,\end_addr_buf[33]_i_2_n_0 ,\end_addr_buf[33]_i_3_n_0 }));
  FDRE \end_addr_buf_reg[34] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[34]),
        .Q(p_0_in0_in[22]),
        .R(SR));
  FDRE \end_addr_buf_reg[35] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[35]),
        .Q(p_0_in0_in[23]),
        .R(SR));
  FDRE \end_addr_buf_reg[36] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[36]),
        .Q(p_0_in0_in[24]),
        .R(SR));
  FDRE \end_addr_buf_reg[37] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[37]),
        .Q(p_0_in0_in[25]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[37]_i_1 
       (.CI(\end_addr_buf_reg[33]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[37]_i_1_n_0 ,\end_addr_buf_reg[37]_i_1_n_1 ,\end_addr_buf_reg[37]_i_1_n_2 ,\end_addr_buf_reg[37]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(end_addr[37:34]),
        .S({\start_addr_reg_n_0_[37] ,\start_addr_reg_n_0_[36] ,\start_addr_reg_n_0_[35] ,\start_addr_reg_n_0_[34] }));
  FDRE \end_addr_buf_reg[38] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[38]),
        .Q(p_0_in0_in[26]),
        .R(SR));
  FDRE \end_addr_buf_reg[39] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[39]),
        .Q(p_0_in0_in[27]),
        .R(SR));
  FDRE \end_addr_buf_reg[3] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[3]),
        .Q(\end_addr_buf_reg_n_0_[3] ),
        .R(SR));
  FDRE \end_addr_buf_reg[40] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[40]),
        .Q(p_0_in0_in[28]),
        .R(SR));
  FDRE \end_addr_buf_reg[41] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[41]),
        .Q(p_0_in0_in[29]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[41]_i_1 
       (.CI(\end_addr_buf_reg[37]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[41]_i_1_n_0 ,\end_addr_buf_reg[41]_i_1_n_1 ,\end_addr_buf_reg[41]_i_1_n_2 ,\end_addr_buf_reg[41]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(end_addr[41:38]),
        .S({\start_addr_reg_n_0_[41] ,\start_addr_reg_n_0_[40] ,\start_addr_reg_n_0_[39] ,\start_addr_reg_n_0_[38] }));
  FDRE \end_addr_buf_reg[42] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[42]),
        .Q(p_0_in0_in[30]),
        .R(SR));
  FDRE \end_addr_buf_reg[43] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[43]),
        .Q(p_0_in0_in[31]),
        .R(SR));
  FDRE \end_addr_buf_reg[44] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[44]),
        .Q(p_0_in0_in[32]),
        .R(SR));
  FDRE \end_addr_buf_reg[45] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[45]),
        .Q(p_0_in0_in[33]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[45]_i_1 
       (.CI(\end_addr_buf_reg[41]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[45]_i_1_n_0 ,\end_addr_buf_reg[45]_i_1_n_1 ,\end_addr_buf_reg[45]_i_1_n_2 ,\end_addr_buf_reg[45]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(end_addr[45:42]),
        .S({\start_addr_reg_n_0_[45] ,\start_addr_reg_n_0_[44] ,\start_addr_reg_n_0_[43] ,\start_addr_reg_n_0_[42] }));
  FDRE \end_addr_buf_reg[46] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[46]),
        .Q(p_0_in0_in[34]),
        .R(SR));
  FDRE \end_addr_buf_reg[47] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[47]),
        .Q(p_0_in0_in[35]),
        .R(SR));
  FDRE \end_addr_buf_reg[48] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[48]),
        .Q(p_0_in0_in[36]),
        .R(SR));
  FDRE \end_addr_buf_reg[49] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[49]),
        .Q(p_0_in0_in[37]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[49]_i_1 
       (.CI(\end_addr_buf_reg[45]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[49]_i_1_n_0 ,\end_addr_buf_reg[49]_i_1_n_1 ,\end_addr_buf_reg[49]_i_1_n_2 ,\end_addr_buf_reg[49]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(end_addr[49:46]),
        .S({\start_addr_reg_n_0_[49] ,\start_addr_reg_n_0_[48] ,\start_addr_reg_n_0_[47] ,\start_addr_reg_n_0_[46] }));
  FDRE \end_addr_buf_reg[4] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[4]),
        .Q(\end_addr_buf_reg_n_0_[4] ),
        .R(SR));
  FDRE \end_addr_buf_reg[50] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[50]),
        .Q(p_0_in0_in[38]),
        .R(SR));
  FDRE \end_addr_buf_reg[51] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[51]),
        .Q(p_0_in0_in[39]),
        .R(SR));
  FDRE \end_addr_buf_reg[52] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[52]),
        .Q(p_0_in0_in[40]),
        .R(SR));
  FDRE \end_addr_buf_reg[53] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[53]),
        .Q(p_0_in0_in[41]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[53]_i_1 
       (.CI(\end_addr_buf_reg[49]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[53]_i_1_n_0 ,\end_addr_buf_reg[53]_i_1_n_1 ,\end_addr_buf_reg[53]_i_1_n_2 ,\end_addr_buf_reg[53]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(end_addr[53:50]),
        .S({\start_addr_reg_n_0_[53] ,\start_addr_reg_n_0_[52] ,\start_addr_reg_n_0_[51] ,\start_addr_reg_n_0_[50] }));
  FDRE \end_addr_buf_reg[54] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[54]),
        .Q(p_0_in0_in[42]),
        .R(SR));
  FDRE \end_addr_buf_reg[55] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[55]),
        .Q(p_0_in0_in[43]),
        .R(SR));
  FDRE \end_addr_buf_reg[56] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[56]),
        .Q(p_0_in0_in[44]),
        .R(SR));
  FDRE \end_addr_buf_reg[57] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[57]),
        .Q(p_0_in0_in[45]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[57]_i_1 
       (.CI(\end_addr_buf_reg[53]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[57]_i_1_n_0 ,\end_addr_buf_reg[57]_i_1_n_1 ,\end_addr_buf_reg[57]_i_1_n_2 ,\end_addr_buf_reg[57]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(end_addr[57:54]),
        .S({\start_addr_reg_n_0_[57] ,\start_addr_reg_n_0_[56] ,\start_addr_reg_n_0_[55] ,\start_addr_reg_n_0_[54] }));
  FDRE \end_addr_buf_reg[58] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[58]),
        .Q(p_0_in0_in[46]),
        .R(SR));
  FDRE \end_addr_buf_reg[59] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[59]),
        .Q(p_0_in0_in[47]),
        .R(SR));
  FDRE \end_addr_buf_reg[5] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[5]),
        .Q(\end_addr_buf_reg_n_0_[5] ),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[5]_i_1 
       (.CI(1'b0),
        .CO({\end_addr_buf_reg[5]_i_1_n_0 ,\end_addr_buf_reg[5]_i_1_n_1 ,\end_addr_buf_reg[5]_i_1_n_2 ,\end_addr_buf_reg[5]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\start_addr_reg_n_0_[5] ,\start_addr_reg_n_0_[4] ,\start_addr_reg_n_0_[3] ,\start_addr_reg_n_0_[2] }),
        .O({end_addr[5:3],\NLW_end_addr_buf_reg[5]_i_1_O_UNCONNECTED [0]}),
        .S({\end_addr_buf[5]_i_2_n_0 ,\end_addr_buf[5]_i_3_n_0 ,\end_addr_buf[5]_i_4_n_0 ,\end_addr_buf[5]_i_5_n_0 }));
  FDRE \end_addr_buf_reg[60] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[60]),
        .Q(p_0_in0_in[48]),
        .R(SR));
  FDRE \end_addr_buf_reg[61] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[61]),
        .Q(p_0_in0_in[49]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[61]_i_1 
       (.CI(\end_addr_buf_reg[57]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[61]_i_1_n_0 ,\end_addr_buf_reg[61]_i_1_n_1 ,\end_addr_buf_reg[61]_i_1_n_2 ,\end_addr_buf_reg[61]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(end_addr[61:58]),
        .S({\start_addr_reg_n_0_[61] ,\start_addr_reg_n_0_[60] ,\start_addr_reg_n_0_[59] ,\start_addr_reg_n_0_[58] }));
  FDRE \end_addr_buf_reg[62] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[62]),
        .Q(p_0_in0_in[50]),
        .R(SR));
  FDRE \end_addr_buf_reg[63] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[63]),
        .Q(p_0_in0_in[51]),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[63]_i_1 
       (.CI(\end_addr_buf_reg[61]_i_1_n_0 ),
        .CO({\NLW_end_addr_buf_reg[63]_i_1_CO_UNCONNECTED [3:1],\end_addr_buf_reg[63]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_end_addr_buf_reg[63]_i_1_O_UNCONNECTED [3:2],end_addr[63:62]}),
        .S({1'b0,1'b0,\start_addr_reg_n_0_[63] ,\start_addr_reg_n_0_[62] }));
  FDRE \end_addr_buf_reg[6] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[6]),
        .Q(\end_addr_buf_reg_n_0_[6] ),
        .R(SR));
  FDRE \end_addr_buf_reg[7] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[7]),
        .Q(\end_addr_buf_reg_n_0_[7] ),
        .R(SR));
  FDRE \end_addr_buf_reg[8] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[8]),
        .Q(\end_addr_buf_reg_n_0_[8] ),
        .R(SR));
  FDRE \end_addr_buf_reg[9] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(end_addr[9]),
        .Q(\end_addr_buf_reg_n_0_[9] ),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \end_addr_buf_reg[9]_i_1 
       (.CI(\end_addr_buf_reg[5]_i_1_n_0 ),
        .CO({\end_addr_buf_reg[9]_i_1_n_0 ,\end_addr_buf_reg[9]_i_1_n_1 ,\end_addr_buf_reg[9]_i_1_n_2 ,\end_addr_buf_reg[9]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\start_addr_reg_n_0_[9] ,\start_addr_reg_n_0_[8] ,\start_addr_reg_n_0_[7] ,\start_addr_reg_n_0_[6] }),
        .O(end_addr[9:6]),
        .S({\end_addr_buf[9]_i_2_n_0 ,\end_addr_buf[9]_i_3_n_0 ,\end_addr_buf[9]_i_4_n_0 ,\end_addr_buf[9]_i_5_n_0 }));
  design_1_sound_operation_0_7_sound_operation_ram_m_axi_fifo__parameterized1 fifo_rctl
       (.CO(last_sect),
        .E(pop0),
        .Q(p_1_in),
        .SR(SR),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .ap_rst_n_0(fifo_rctl_n_8),
        .ap_rst_n_1(fifo_rctl_n_10),
        .beat_valid(beat_valid),
        .\could_multi_bursts.sect_handling_reg (p_20_in),
        .\could_multi_bursts.sect_handling_reg_0 (fifo_rctl_n_11),
        .\could_multi_bursts.sect_handling_reg_1 (fifo_rctl_n_12),
        .\could_multi_bursts.sect_handling_reg_2 (fifo_rctl_n_13),
        .\could_multi_bursts.sect_handling_reg_3 (fifo_rctl_n_14),
        .\could_multi_bursts.sect_handling_reg_4 (fifo_rctl_n_15),
        .\could_multi_bursts.sect_handling_reg_5 (fifo_rctl_n_16),
        .\could_multi_bursts.sect_handling_reg_6 (\could_multi_bursts.sect_handling_reg_n_0 ),
        .\could_multi_bursts.sect_handling_reg_7 (\could_multi_bursts.ARVALID_Dummy_reg_0 ),
        .\could_multi_bursts.sect_handling_reg_8 (\could_multi_bursts.arlen_buf[4]_i_3_n_0 ),
        .empty_n_reg_0(fifo_rctl_n_0),
        .empty_n_reg_1(data_pack),
        .empty_n_reg_2(\bus_equal_gen.rdata_valid_t_reg_n_0 ),
        .fifo_rreq_valid(fifo_rreq_valid),
        .invalid_len_event(invalid_len_event),
        .invalid_len_event_reg2(invalid_len_event_reg2),
        .invalid_len_event_reg2_reg(fifo_rctl_n_1),
        .m_axi_ram_ARREADY(m_axi_ram_ARREADY),
        .p_21_in(p_21_in),
        .\pout_reg[3]_0 (buff_rdata_n_11),
        .rdata_ack_t(rdata_ack_t),
        .rreq_handling_reg(fifo_rctl_n_5),
        .rreq_handling_reg_0(fifo_rctl_n_6),
        .rreq_handling_reg_1(fifo_rctl_n_7),
        .rreq_handling_reg_2(fifo_rctl_n_9),
        .rreq_handling_reg_3(rreq_handling_reg_n_0),
        .rreq_handling_reg_4(fifo_rreq_valid_buf_reg_n_0),
        .\sect_addr_buf_reg[2] (first_sect),
        .\sect_len_buf_reg[7] (fifo_rreq_n_56),
        .\sect_len_buf_reg[7]_0 (fifo_rreq_n_55));
  design_1_sound_operation_0_7_sound_operation_ram_m_axi_fifo__parameterized0 fifo_rreq
       (.CO(last_sect),
        .D({fifo_rreq_n_2,fifo_rreq_n_3,fifo_rreq_n_4,fifo_rreq_n_5,fifo_rreq_n_6,fifo_rreq_n_7,fifo_rreq_n_8,fifo_rreq_n_9,fifo_rreq_n_10,fifo_rreq_n_11,fifo_rreq_n_12,fifo_rreq_n_13,fifo_rreq_n_14,fifo_rreq_n_15,fifo_rreq_n_16,fifo_rreq_n_17,fifo_rreq_n_18,fifo_rreq_n_19,fifo_rreq_n_20,fifo_rreq_n_21,fifo_rreq_n_22,fifo_rreq_n_23,fifo_rreq_n_24,fifo_rreq_n_25,fifo_rreq_n_26,fifo_rreq_n_27,fifo_rreq_n_28,fifo_rreq_n_29,fifo_rreq_n_30,fifo_rreq_n_31,fifo_rreq_n_32,fifo_rreq_n_33,fifo_rreq_n_34,fifo_rreq_n_35,fifo_rreq_n_36,fifo_rreq_n_37,fifo_rreq_n_38,fifo_rreq_n_39,fifo_rreq_n_40,fifo_rreq_n_41,fifo_rreq_n_42,fifo_rreq_n_43,fifo_rreq_n_44,fifo_rreq_n_45,fifo_rreq_n_46,fifo_rreq_n_47,fifo_rreq_n_48,fifo_rreq_n_49,fifo_rreq_n_50,fifo_rreq_n_51,fifo_rreq_n_52,fifo_rreq_n_53}),
        .E(pop0),
        .Q(\sect_cnt_reg_n_0_[0] ),
        .S(zero_len_event0),
        .SR(SR),
        .ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .fifo_rreq_valid(fifo_rreq_valid),
        .fifo_rreq_valid_buf_reg(fifo_rreq_valid_buf_reg_n_0),
        .full_n_reg_0(rreq_handling_reg_n_0),
        .invalid_len_event0(invalid_len_event0),
        .next_rreq(next_rreq),
        .p_21_in(p_21_in),
        .push(push),
        .\q_reg[61]_0 (rs2f_rreq_data),
        .\q_reg[64]_0 ({fifo_rreq_data,q}),
        .rs2f_rreq_ack(rs2f_rreq_ack),
        .sect_cnt0(sect_cnt0),
        .\sect_cnt_reg[51] ({\start_addr_reg_n_0_[63] ,\start_addr_reg_n_0_[62] ,\start_addr_reg_n_0_[61] ,\start_addr_reg_n_0_[60] ,\start_addr_reg_n_0_[59] ,\start_addr_reg_n_0_[58] ,\start_addr_reg_n_0_[57] ,\start_addr_reg_n_0_[56] ,\start_addr_reg_n_0_[55] ,\start_addr_reg_n_0_[54] ,\start_addr_reg_n_0_[53] ,\start_addr_reg_n_0_[52] ,\start_addr_reg_n_0_[51] ,\start_addr_reg_n_0_[50] ,\start_addr_reg_n_0_[49] ,\start_addr_reg_n_0_[48] ,\start_addr_reg_n_0_[47] ,\start_addr_reg_n_0_[46] ,\start_addr_reg_n_0_[45] ,\start_addr_reg_n_0_[44] ,\start_addr_reg_n_0_[43] ,\start_addr_reg_n_0_[42] ,\start_addr_reg_n_0_[41] ,\start_addr_reg_n_0_[40] ,\start_addr_reg_n_0_[39] ,\start_addr_reg_n_0_[38] ,\start_addr_reg_n_0_[37] ,\start_addr_reg_n_0_[36] ,\start_addr_reg_n_0_[35] ,\start_addr_reg_n_0_[34] ,\start_addr_reg_n_0_[33] ,\start_addr_reg_n_0_[32] ,\start_addr_reg_n_0_[31] ,\start_addr_reg_n_0_[30] ,\start_addr_reg_n_0_[29] ,\start_addr_reg_n_0_[28] ,\start_addr_reg_n_0_[27] ,\start_addr_reg_n_0_[26] ,\start_addr_reg_n_0_[25] ,\start_addr_reg_n_0_[24] ,\start_addr_reg_n_0_[23] ,\start_addr_reg_n_0_[22] ,\start_addr_reg_n_0_[21] ,\start_addr_reg_n_0_[20] ,\start_addr_reg_n_0_[19] ,\start_addr_reg_n_0_[18] ,\start_addr_reg_n_0_[17] ,\start_addr_reg_n_0_[16] ,\start_addr_reg_n_0_[15] ,\start_addr_reg_n_0_[14] ,\start_addr_reg_n_0_[13] ,\start_addr_reg_n_0_[12] }),
        .\sect_len_buf_reg[6] (fifo_rreq_n_56),
        .\sect_len_buf_reg[7] (fifo_rreq_n_55),
        .\sect_len_buf_reg[7]_0 ({\sect_len_buf_reg_n_0_[9] ,\sect_len_buf_reg_n_0_[8] ,\sect_len_buf_reg_n_0_[7] ,\sect_len_buf_reg_n_0_[6] ,\sect_len_buf_reg_n_0_[5] }),
        .\sect_len_buf_reg[7]_1 (\could_multi_bursts.loop_cnt_reg ));
  FDRE fifo_rreq_valid_buf_reg
       (.C(ap_clk),
        .CE(next_rreq),
        .D(fifo_rreq_valid),
        .Q(fifo_rreq_valid_buf_reg_n_0),
        .R(SR));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 first_sect_carry
       (.CI(1'b0),
        .CO({first_sect_carry_n_0,first_sect_carry_n_1,first_sect_carry_n_2,first_sect_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_first_sect_carry_O_UNCONNECTED[3:0]),
        .S({first_sect_carry_i_1_n_0,first_sect_carry_i_2_n_0,first_sect_carry_i_3_n_0,first_sect_carry_i_4_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 first_sect_carry__0
       (.CI(first_sect_carry_n_0),
        .CO({first_sect_carry__0_n_0,first_sect_carry__0_n_1,first_sect_carry__0_n_2,first_sect_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_first_sect_carry__0_O_UNCONNECTED[3:0]),
        .S({first_sect_carry__0_i_1_n_0,first_sect_carry__0_i_2_n_0,first_sect_carry__0_i_3_n_0,first_sect_carry__0_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__0_i_1
       (.I0(p_0_in_0[22]),
        .I1(\sect_cnt_reg_n_0_[22] ),
        .I2(\sect_cnt_reg_n_0_[21] ),
        .I3(p_0_in_0[21]),
        .I4(\sect_cnt_reg_n_0_[23] ),
        .I5(p_0_in_0[23]),
        .O(first_sect_carry__0_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__0_i_2
       (.I0(\sect_cnt_reg_n_0_[20] ),
        .I1(p_0_in_0[20]),
        .I2(\sect_cnt_reg_n_0_[19] ),
        .I3(p_0_in_0[19]),
        .I4(p_0_in_0[18]),
        .I5(\sect_cnt_reg_n_0_[18] ),
        .O(first_sect_carry__0_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__0_i_3
       (.I0(p_0_in_0[15]),
        .I1(\sect_cnt_reg_n_0_[15] ),
        .I2(\sect_cnt_reg_n_0_[16] ),
        .I3(p_0_in_0[16]),
        .I4(\sect_cnt_reg_n_0_[17] ),
        .I5(p_0_in_0[17]),
        .O(first_sect_carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__0_i_4
       (.I0(p_0_in_0[13]),
        .I1(\sect_cnt_reg_n_0_[13] ),
        .I2(\sect_cnt_reg_n_0_[14] ),
        .I3(p_0_in_0[14]),
        .I4(\sect_cnt_reg_n_0_[12] ),
        .I5(p_0_in_0[12]),
        .O(first_sect_carry__0_i_4_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 first_sect_carry__1
       (.CI(first_sect_carry__0_n_0),
        .CO({first_sect_carry__1_n_0,first_sect_carry__1_n_1,first_sect_carry__1_n_2,first_sect_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_first_sect_carry__1_O_UNCONNECTED[3:0]),
        .S({first_sect_carry__1_i_1_n_0,first_sect_carry__1_i_2_n_0,first_sect_carry__1_i_3_n_0,first_sect_carry__1_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__1_i_1
       (.I0(p_0_in_0[33]),
        .I1(\sect_cnt_reg_n_0_[33] ),
        .I2(\sect_cnt_reg_n_0_[34] ),
        .I3(p_0_in_0[34]),
        .I4(\sect_cnt_reg_n_0_[35] ),
        .I5(p_0_in_0[35]),
        .O(first_sect_carry__1_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__1_i_2
       (.I0(\sect_cnt_reg_n_0_[31] ),
        .I1(p_0_in_0[31]),
        .I2(\sect_cnt_reg_n_0_[32] ),
        .I3(p_0_in_0[32]),
        .I4(p_0_in_0[30]),
        .I5(\sect_cnt_reg_n_0_[30] ),
        .O(first_sect_carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__1_i_3
       (.I0(\sect_cnt_reg_n_0_[28] ),
        .I1(p_0_in_0[28]),
        .I2(\sect_cnt_reg_n_0_[29] ),
        .I3(p_0_in_0[29]),
        .I4(p_0_in_0[27]),
        .I5(\sect_cnt_reg_n_0_[27] ),
        .O(first_sect_carry__1_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__1_i_4
       (.I0(\sect_cnt_reg_n_0_[24] ),
        .I1(p_0_in_0[24]),
        .I2(\sect_cnt_reg_n_0_[26] ),
        .I3(p_0_in_0[26]),
        .I4(p_0_in_0[25]),
        .I5(\sect_cnt_reg_n_0_[25] ),
        .O(first_sect_carry__1_i_4_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 first_sect_carry__2
       (.CI(first_sect_carry__1_n_0),
        .CO({first_sect_carry__2_n_0,first_sect_carry__2_n_1,first_sect_carry__2_n_2,first_sect_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_first_sect_carry__2_O_UNCONNECTED[3:0]),
        .S({first_sect_carry__2_i_1_n_0,first_sect_carry__2_i_2_n_0,first_sect_carry__2_i_3_n_0,first_sect_carry__2_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__2_i_1
       (.I0(\sect_cnt_reg_n_0_[45] ),
        .I1(p_0_in_0[45]),
        .I2(\sect_cnt_reg_n_0_[47] ),
        .I3(p_0_in_0[47]),
        .I4(p_0_in_0[46]),
        .I5(\sect_cnt_reg_n_0_[46] ),
        .O(first_sect_carry__2_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__2_i_2
       (.I0(p_0_in_0[42]),
        .I1(\sect_cnt_reg_n_0_[42] ),
        .I2(\sect_cnt_reg_n_0_[43] ),
        .I3(p_0_in_0[43]),
        .I4(\sect_cnt_reg_n_0_[44] ),
        .I5(p_0_in_0[44]),
        .O(first_sect_carry__2_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__2_i_3
       (.I0(p_0_in_0[39]),
        .I1(\sect_cnt_reg_n_0_[39] ),
        .I2(\sect_cnt_reg_n_0_[41] ),
        .I3(p_0_in_0[41]),
        .I4(\sect_cnt_reg_n_0_[40] ),
        .I5(p_0_in_0[40]),
        .O(first_sect_carry__2_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__2_i_4
       (.I0(p_0_in_0[36]),
        .I1(\sect_cnt_reg_n_0_[36] ),
        .I2(\sect_cnt_reg_n_0_[38] ),
        .I3(p_0_in_0[38]),
        .I4(\sect_cnt_reg_n_0_[37] ),
        .I5(p_0_in_0[37]),
        .O(first_sect_carry__2_i_4_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 first_sect_carry__3
       (.CI(first_sect_carry__2_n_0),
        .CO({NLW_first_sect_carry__3_CO_UNCONNECTED[3:2],first_sect,first_sect_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_first_sect_carry__3_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,first_sect_carry__3_i_1_n_0,first_sect_carry__3_i_2_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    first_sect_carry__3_i_1
       (.I0(p_0_in_0[51]),
        .I1(\sect_cnt_reg_n_0_[51] ),
        .O(first_sect_carry__3_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry__3_i_2
       (.I0(\sect_cnt_reg_n_0_[49] ),
        .I1(p_0_in_0[49]),
        .I2(\sect_cnt_reg_n_0_[50] ),
        .I3(p_0_in_0[50]),
        .I4(p_0_in_0[48]),
        .I5(\sect_cnt_reg_n_0_[48] ),
        .O(first_sect_carry__3_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry_i_1
       (.I0(\sect_cnt_reg_n_0_[11] ),
        .I1(p_0_in_0[11]),
        .I2(\sect_cnt_reg_n_0_[9] ),
        .I3(p_0_in_0[9]),
        .I4(p_0_in_0[10]),
        .I5(\sect_cnt_reg_n_0_[10] ),
        .O(first_sect_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry_i_2
       (.I0(p_0_in_0[6]),
        .I1(\sect_cnt_reg_n_0_[6] ),
        .I2(\sect_cnt_reg_n_0_[8] ),
        .I3(p_0_in_0[8]),
        .I4(\sect_cnt_reg_n_0_[7] ),
        .I5(p_0_in_0[7]),
        .O(first_sect_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry_i_3
       (.I0(\sect_cnt_reg_n_0_[5] ),
        .I1(p_0_in_0[5]),
        .I2(\sect_cnt_reg_n_0_[4] ),
        .I3(p_0_in_0[4]),
        .I4(p_0_in_0[3]),
        .I5(\sect_cnt_reg_n_0_[3] ),
        .O(first_sect_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    first_sect_carry_i_4
       (.I0(p_0_in_0[0]),
        .I1(\sect_cnt_reg_n_0_[0] ),
        .I2(\sect_cnt_reg_n_0_[1] ),
        .I3(p_0_in_0[1]),
        .I4(\sect_cnt_reg_n_0_[2] ),
        .I5(p_0_in_0[2]),
        .O(first_sect_carry_i_4_n_0));
  FDRE invalid_len_event_reg
       (.C(ap_clk),
        .CE(next_rreq),
        .D(invalid_len_event0),
        .Q(invalid_len_event),
        .R(SR));
  FDRE invalid_len_event_reg1_reg
       (.C(ap_clk),
        .CE(next_rreq),
        .D(invalid_len_event),
        .Q(invalid_len_event_reg1),
        .R(SR));
  FDRE invalid_len_event_reg2_reg
       (.C(ap_clk),
        .CE(p_21_in),
        .D(invalid_len_event_reg1),
        .Q(invalid_len_event_reg2),
        .R(SR));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 last_sect_carry
       (.CI(1'b0),
        .CO({last_sect_carry_n_0,last_sect_carry_n_1,last_sect_carry_n_2,last_sect_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_last_sect_carry_O_UNCONNECTED[3:0]),
        .S({last_sect_carry_i_1_n_0,last_sect_carry_i_2_n_0,last_sect_carry_i_3_n_0,last_sect_carry_i_4_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 last_sect_carry__0
       (.CI(last_sect_carry_n_0),
        .CO({last_sect_carry__0_n_0,last_sect_carry__0_n_1,last_sect_carry__0_n_2,last_sect_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_last_sect_carry__0_O_UNCONNECTED[3:0]),
        .S({last_sect_carry__0_i_1_n_0,last_sect_carry__0_i_2_n_0,last_sect_carry__0_i_3_n_0,last_sect_carry__0_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__0_i_1
       (.I0(\sect_cnt_reg_n_0_[22] ),
        .I1(p_0_in0_in[22]),
        .I2(p_0_in0_in[23]),
        .I3(\sect_cnt_reg_n_0_[23] ),
        .I4(p_0_in0_in[21]),
        .I5(\sect_cnt_reg_n_0_[21] ),
        .O(last_sect_carry__0_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__0_i_2
       (.I0(p_0_in0_in[18]),
        .I1(\sect_cnt_reg_n_0_[18] ),
        .I2(p_0_in0_in[20]),
        .I3(\sect_cnt_reg_n_0_[20] ),
        .I4(\sect_cnt_reg_n_0_[19] ),
        .I5(p_0_in0_in[19]),
        .O(last_sect_carry__0_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__0_i_3
       (.I0(\sect_cnt_reg_n_0_[15] ),
        .I1(p_0_in0_in[15]),
        .I2(p_0_in0_in[16]),
        .I3(\sect_cnt_reg_n_0_[16] ),
        .I4(p_0_in0_in[17]),
        .I5(\sect_cnt_reg_n_0_[17] ),
        .O(last_sect_carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__0_i_4
       (.I0(\sect_cnt_reg_n_0_[13] ),
        .I1(p_0_in0_in[13]),
        .I2(p_0_in0_in[12]),
        .I3(\sect_cnt_reg_n_0_[12] ),
        .I4(p_0_in0_in[14]),
        .I5(\sect_cnt_reg_n_0_[14] ),
        .O(last_sect_carry__0_i_4_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 last_sect_carry__1
       (.CI(last_sect_carry__0_n_0),
        .CO({last_sect_carry__1_n_0,last_sect_carry__1_n_1,last_sect_carry__1_n_2,last_sect_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_last_sect_carry__1_O_UNCONNECTED[3:0]),
        .S({last_sect_carry__1_i_1_n_0,last_sect_carry__1_i_2_n_0,last_sect_carry__1_i_3_n_0,last_sect_carry__1_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__1_i_1
       (.I0(\sect_cnt_reg_n_0_[33] ),
        .I1(p_0_in0_in[33]),
        .I2(p_0_in0_in[34]),
        .I3(\sect_cnt_reg_n_0_[34] ),
        .I4(p_0_in0_in[35]),
        .I5(\sect_cnt_reg_n_0_[35] ),
        .O(last_sect_carry__1_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__1_i_2
       (.I0(p_0_in0_in[30]),
        .I1(\sect_cnt_reg_n_0_[30] ),
        .I2(p_0_in0_in[32]),
        .I3(\sect_cnt_reg_n_0_[32] ),
        .I4(\sect_cnt_reg_n_0_[31] ),
        .I5(p_0_in0_in[31]),
        .O(last_sect_carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__1_i_3
       (.I0(p_0_in0_in[27]),
        .I1(\sect_cnt_reg_n_0_[27] ),
        .I2(p_0_in0_in[29]),
        .I3(\sect_cnt_reg_n_0_[29] ),
        .I4(\sect_cnt_reg_n_0_[28] ),
        .I5(p_0_in0_in[28]),
        .O(last_sect_carry__1_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__1_i_4
       (.I0(p_0_in0_in[26]),
        .I1(\sect_cnt_reg_n_0_[26] ),
        .I2(p_0_in0_in[25]),
        .I3(\sect_cnt_reg_n_0_[25] ),
        .I4(\sect_cnt_reg_n_0_[24] ),
        .I5(p_0_in0_in[24]),
        .O(last_sect_carry__1_i_4_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 last_sect_carry__2
       (.CI(last_sect_carry__1_n_0),
        .CO({last_sect_carry__2_n_0,last_sect_carry__2_n_1,last_sect_carry__2_n_2,last_sect_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_last_sect_carry__2_O_UNCONNECTED[3:0]),
        .S({last_sect_carry__2_i_1_n_0,last_sect_carry__2_i_2_n_0,last_sect_carry__2_i_3_n_0,last_sect_carry__2_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__2_i_1
       (.I0(p_0_in0_in[46]),
        .I1(\sect_cnt_reg_n_0_[46] ),
        .I2(p_0_in0_in[47]),
        .I3(\sect_cnt_reg_n_0_[47] ),
        .I4(\sect_cnt_reg_n_0_[45] ),
        .I5(p_0_in0_in[45]),
        .O(last_sect_carry__2_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__2_i_2
       (.I0(\sect_cnt_reg_n_0_[42] ),
        .I1(p_0_in0_in[42]),
        .I2(p_0_in0_in[43]),
        .I3(\sect_cnt_reg_n_0_[43] ),
        .I4(p_0_in0_in[44]),
        .I5(\sect_cnt_reg_n_0_[44] ),
        .O(last_sect_carry__2_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__2_i_3
       (.I0(\sect_cnt_reg_n_0_[39] ),
        .I1(p_0_in0_in[39]),
        .I2(p_0_in0_in[40]),
        .I3(\sect_cnt_reg_n_0_[40] ),
        .I4(p_0_in0_in[41]),
        .I5(\sect_cnt_reg_n_0_[41] ),
        .O(last_sect_carry__2_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__2_i_4
       (.I0(\sect_cnt_reg_n_0_[36] ),
        .I1(p_0_in0_in[36]),
        .I2(p_0_in0_in[37]),
        .I3(\sect_cnt_reg_n_0_[37] ),
        .I4(p_0_in0_in[38]),
        .I5(\sect_cnt_reg_n_0_[38] ),
        .O(last_sect_carry__2_i_4_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 last_sect_carry__3
       (.CI(last_sect_carry__2_n_0),
        .CO({NLW_last_sect_carry__3_CO_UNCONNECTED[3:2],last_sect,last_sect_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_last_sect_carry__3_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,last_sect_carry__3_i_1_n_0,last_sect_carry__3_i_2_n_0}));
  LUT2 #(
    .INIT(4'h9)) 
    last_sect_carry__3_i_1
       (.I0(p_0_in0_in[51]),
        .I1(\sect_cnt_reg_n_0_[51] ),
        .O(last_sect_carry__3_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry__3_i_2
       (.I0(p_0_in0_in[48]),
        .I1(\sect_cnt_reg_n_0_[48] ),
        .I2(p_0_in0_in[50]),
        .I3(\sect_cnt_reg_n_0_[50] ),
        .I4(\sect_cnt_reg_n_0_[49] ),
        .I5(p_0_in0_in[49]),
        .O(last_sect_carry__3_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry_i_1
       (.I0(p_0_in0_in[10]),
        .I1(\sect_cnt_reg_n_0_[10] ),
        .I2(p_0_in0_in[11]),
        .I3(\sect_cnt_reg_n_0_[11] ),
        .I4(\sect_cnt_reg_n_0_[9] ),
        .I5(p_0_in0_in[9]),
        .O(last_sect_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry_i_2
       (.I0(\sect_cnt_reg_n_0_[6] ),
        .I1(p_0_in0_in[6]),
        .I2(p_0_in0_in[8]),
        .I3(\sect_cnt_reg_n_0_[8] ),
        .I4(p_0_in0_in[7]),
        .I5(\sect_cnt_reg_n_0_[7] ),
        .O(last_sect_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry_i_3
       (.I0(p_0_in0_in[3]),
        .I1(\sect_cnt_reg_n_0_[3] ),
        .I2(p_0_in0_in[5]),
        .I3(\sect_cnt_reg_n_0_[5] ),
        .I4(\sect_cnt_reg_n_0_[4] ),
        .I5(p_0_in0_in[4]),
        .O(last_sect_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    last_sect_carry_i_4
       (.I0(\sect_cnt_reg_n_0_[0] ),
        .I1(p_0_in0_in[0]),
        .I2(p_0_in0_in[2]),
        .I3(\sect_cnt_reg_n_0_[2] ),
        .I4(p_0_in0_in[1]),
        .I5(\sect_cnt_reg_n_0_[1] ),
        .O(last_sect_carry_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 p_0_out_carry
       (.CI(1'b0),
        .CO({p_0_out_carry_n_0,p_0_out_carry_n_1,p_0_out_carry_n_2,p_0_out_carry_n_3}),
        .CYINIT(mOutPtr_reg[0]),
        .DI({mOutPtr_reg[3:1],mOutPtr19_out}),
        .O({p_0_out_carry_n_4,p_0_out_carry_n_5,p_0_out_carry_n_6,p_0_out_carry_n_7}),
        .S({buff_rdata_n_46,buff_rdata_n_47,buff_rdata_n_48,buff_rdata_n_49}));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 p_0_out_carry__0
       (.CI(p_0_out_carry_n_0),
        .CO({NLW_p_0_out_carry__0_CO_UNCONNECTED[3],p_0_out_carry__0_n_1,p_0_out_carry__0_n_2,p_0_out_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,mOutPtr_reg[6:4]}),
        .O({p_0_out_carry__0_n_4,p_0_out_carry__0_n_5,p_0_out_carry__0_n_6,p_0_out_carry__0_n_7}),
        .S({buff_rdata_n_50,buff_rdata_n_51,buff_rdata_n_52,buff_rdata_n_53}));
  FDRE rreq_handling_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(fifo_rctl_n_6),
        .Q(rreq_handling_reg_n_0),
        .R(SR));
  design_1_sound_operation_0_7_sound_operation_ram_m_axi_reg_slice__parameterized0 rs_rdata
       (.E(next_beat),
        .Q(Q[3:2]),
        .SR(SR),
        .ap_NS_fsm(ap_NS_fsm[2:1]),
        .ap_clk(ap_clk),
        .beat_valid(beat_valid),
        .\data_p1_reg[31]_0 (\data_p1_reg[31] ),
        .\data_p2_reg[31]_0 ({\bus_equal_gen.data_buf_reg_n_0_[31] ,\bus_equal_gen.data_buf_reg_n_0_[30] ,\bus_equal_gen.data_buf_reg_n_0_[29] ,\bus_equal_gen.data_buf_reg_n_0_[28] ,\bus_equal_gen.data_buf_reg_n_0_[27] ,\bus_equal_gen.data_buf_reg_n_0_[26] ,\bus_equal_gen.data_buf_reg_n_0_[25] ,\bus_equal_gen.data_buf_reg_n_0_[24] ,\bus_equal_gen.data_buf_reg_n_0_[23] ,\bus_equal_gen.data_buf_reg_n_0_[22] ,\bus_equal_gen.data_buf_reg_n_0_[21] ,\bus_equal_gen.data_buf_reg_n_0_[20] ,\bus_equal_gen.data_buf_reg_n_0_[19] ,\bus_equal_gen.data_buf_reg_n_0_[18] ,\bus_equal_gen.data_buf_reg_n_0_[17] ,\bus_equal_gen.data_buf_reg_n_0_[16] ,\bus_equal_gen.data_buf_reg_n_0_[15] ,\bus_equal_gen.data_buf_reg_n_0_[14] ,\bus_equal_gen.data_buf_reg_n_0_[13] ,\bus_equal_gen.data_buf_reg_n_0_[12] ,\bus_equal_gen.data_buf_reg_n_0_[11] ,\bus_equal_gen.data_buf_reg_n_0_[10] ,\bus_equal_gen.data_buf_reg_n_0_[9] ,\bus_equal_gen.data_buf_reg_n_0_[8] ,\bus_equal_gen.data_buf_reg_n_0_[7] ,\bus_equal_gen.data_buf_reg_n_0_[6] ,\bus_equal_gen.data_buf_reg_n_0_[5] ,\bus_equal_gen.data_buf_reg_n_0_[4] ,\bus_equal_gen.data_buf_reg_n_0_[3] ,\bus_equal_gen.data_buf_reg_n_0_[2] ,\bus_equal_gen.data_buf_reg_n_0_[1] ,\bus_equal_gen.data_buf_reg_n_0_[0] }),
        .rdata_ack_t(rdata_ack_t),
        .s_ready_t_reg_0(\bus_equal_gen.rdata_valid_t_reg_n_0 ));
  design_1_sound_operation_0_7_sound_operation_ram_m_axi_reg_slice rs_rreq
       (.E(E),
        .Q(Q[1:0]),
        .SR(SR),
        .ap_NS_fsm(ap_NS_fsm[0]),
        .ap_clk(ap_clk),
        .\data_p1_reg[61]_0 (rs2f_rreq_data),
        .\data_p2_reg[61]_0 (\data_p2_reg[61] ),
        .push(push),
        .rs2f_rreq_ack(rs2f_rreq_ack));
  (* SOFT_HLUTNM = "soft_lutpair170" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[10]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[10] ),
        .O(sect_addr[10]));
  (* SOFT_HLUTNM = "soft_lutpair170" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[11]_i_2 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[11] ),
        .O(sect_addr[11]));
  (* SOFT_HLUTNM = "soft_lutpair162" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[12]_i_1 
       (.I0(p_0_in_0[0]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[0] ),
        .O(sect_addr[12]));
  (* SOFT_HLUTNM = "soft_lutpair162" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[13]_i_1 
       (.I0(p_0_in_0[1]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[1] ),
        .O(sect_addr[13]));
  (* SOFT_HLUTNM = "soft_lutpair161" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[14]_i_1 
       (.I0(p_0_in_0[2]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[2] ),
        .O(sect_addr[14]));
  (* SOFT_HLUTNM = "soft_lutpair161" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[15]_i_1 
       (.I0(p_0_in_0[3]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[3] ),
        .O(sect_addr[15]));
  (* SOFT_HLUTNM = "soft_lutpair160" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[16]_i_1 
       (.I0(p_0_in_0[4]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[4] ),
        .O(sect_addr[16]));
  (* SOFT_HLUTNM = "soft_lutpair160" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[17]_i_1 
       (.I0(p_0_in_0[5]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[5] ),
        .O(sect_addr[17]));
  (* SOFT_HLUTNM = "soft_lutpair159" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[18]_i_1 
       (.I0(p_0_in_0[6]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[6] ),
        .O(sect_addr[18]));
  (* SOFT_HLUTNM = "soft_lutpair159" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[19]_i_1 
       (.I0(p_0_in_0[7]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[7] ),
        .O(sect_addr[19]));
  (* SOFT_HLUTNM = "soft_lutpair158" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[20]_i_1 
       (.I0(p_0_in_0[8]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[8] ),
        .O(sect_addr[20]));
  (* SOFT_HLUTNM = "soft_lutpair158" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[21]_i_1 
       (.I0(p_0_in_0[9]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[9] ),
        .O(sect_addr[21]));
  (* SOFT_HLUTNM = "soft_lutpair157" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[22]_i_1 
       (.I0(p_0_in_0[10]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[10] ),
        .O(sect_addr[22]));
  (* SOFT_HLUTNM = "soft_lutpair157" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[23]_i_1 
       (.I0(p_0_in_0[11]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[11] ),
        .O(sect_addr[23]));
  (* SOFT_HLUTNM = "soft_lutpair156" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[24]_i_1 
       (.I0(p_0_in_0[12]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[12] ),
        .O(sect_addr[24]));
  (* SOFT_HLUTNM = "soft_lutpair156" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[25]_i_1 
       (.I0(p_0_in_0[13]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[13] ),
        .O(sect_addr[25]));
  (* SOFT_HLUTNM = "soft_lutpair155" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[26]_i_1 
       (.I0(p_0_in_0[14]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[14] ),
        .O(sect_addr[26]));
  (* SOFT_HLUTNM = "soft_lutpair155" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[27]_i_1 
       (.I0(p_0_in_0[15]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[15] ),
        .O(sect_addr[27]));
  (* SOFT_HLUTNM = "soft_lutpair154" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[28]_i_1 
       (.I0(p_0_in_0[16]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[16] ),
        .O(sect_addr[28]));
  (* SOFT_HLUTNM = "soft_lutpair154" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[29]_i_1 
       (.I0(p_0_in_0[17]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[17] ),
        .O(sect_addr[29]));
  (* SOFT_HLUTNM = "soft_lutpair174" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[2]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[2] ),
        .O(sect_addr[2]));
  (* SOFT_HLUTNM = "soft_lutpair153" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[30]_i_1 
       (.I0(p_0_in_0[18]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[18] ),
        .O(sect_addr[30]));
  (* SOFT_HLUTNM = "soft_lutpair153" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[31]_i_1 
       (.I0(p_0_in_0[19]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[19] ),
        .O(sect_addr[31]));
  (* SOFT_HLUTNM = "soft_lutpair152" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[32]_i_1 
       (.I0(p_0_in_0[20]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[20] ),
        .O(sect_addr[32]));
  (* SOFT_HLUTNM = "soft_lutpair152" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[33]_i_1 
       (.I0(p_0_in_0[21]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[21] ),
        .O(sect_addr[33]));
  (* SOFT_HLUTNM = "soft_lutpair151" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[34]_i_1 
       (.I0(p_0_in_0[22]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[22] ),
        .O(sect_addr[34]));
  (* SOFT_HLUTNM = "soft_lutpair151" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[35]_i_1 
       (.I0(p_0_in_0[23]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[23] ),
        .O(sect_addr[35]));
  (* SOFT_HLUTNM = "soft_lutpair150" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[36]_i_1 
       (.I0(p_0_in_0[24]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[24] ),
        .O(sect_addr[36]));
  (* SOFT_HLUTNM = "soft_lutpair150" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[37]_i_1 
       (.I0(p_0_in_0[25]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[25] ),
        .O(sect_addr[37]));
  (* SOFT_HLUTNM = "soft_lutpair149" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[38]_i_1 
       (.I0(p_0_in_0[26]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[26] ),
        .O(sect_addr[38]));
  (* SOFT_HLUTNM = "soft_lutpair149" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[39]_i_1 
       (.I0(p_0_in_0[27]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[27] ),
        .O(sect_addr[39]));
  (* SOFT_HLUTNM = "soft_lutpair174" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[3]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[3] ),
        .O(sect_addr[3]));
  (* SOFT_HLUTNM = "soft_lutpair148" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[40]_i_1 
       (.I0(p_0_in_0[28]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[28] ),
        .O(sect_addr[40]));
  (* SOFT_HLUTNM = "soft_lutpair148" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[41]_i_1 
       (.I0(p_0_in_0[29]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[29] ),
        .O(sect_addr[41]));
  (* SOFT_HLUTNM = "soft_lutpair147" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[42]_i_1 
       (.I0(p_0_in_0[30]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[30] ),
        .O(sect_addr[42]));
  (* SOFT_HLUTNM = "soft_lutpair147" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[43]_i_1 
       (.I0(p_0_in_0[31]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[31] ),
        .O(sect_addr[43]));
  (* SOFT_HLUTNM = "soft_lutpair146" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[44]_i_1 
       (.I0(p_0_in_0[32]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[32] ),
        .O(sect_addr[44]));
  (* SOFT_HLUTNM = "soft_lutpair146" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[45]_i_1 
       (.I0(p_0_in_0[33]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[33] ),
        .O(sect_addr[45]));
  (* SOFT_HLUTNM = "soft_lutpair145" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[46]_i_1 
       (.I0(p_0_in_0[34]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[34] ),
        .O(sect_addr[46]));
  (* SOFT_HLUTNM = "soft_lutpair145" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[47]_i_1 
       (.I0(p_0_in_0[35]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[35] ),
        .O(sect_addr[47]));
  (* SOFT_HLUTNM = "soft_lutpair144" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[48]_i_1 
       (.I0(p_0_in_0[36]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[36] ),
        .O(sect_addr[48]));
  (* SOFT_HLUTNM = "soft_lutpair144" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[49]_i_1 
       (.I0(p_0_in_0[37]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[37] ),
        .O(sect_addr[49]));
  (* SOFT_HLUTNM = "soft_lutpair173" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[4]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[4] ),
        .O(sect_addr[4]));
  (* SOFT_HLUTNM = "soft_lutpair143" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[50]_i_1 
       (.I0(p_0_in_0[38]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[38] ),
        .O(sect_addr[50]));
  (* SOFT_HLUTNM = "soft_lutpair143" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[51]_i_1 
       (.I0(p_0_in_0[39]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[39] ),
        .O(sect_addr[51]));
  (* SOFT_HLUTNM = "soft_lutpair142" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[52]_i_1 
       (.I0(p_0_in_0[40]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[40] ),
        .O(sect_addr[52]));
  (* SOFT_HLUTNM = "soft_lutpair142" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[53]_i_1 
       (.I0(p_0_in_0[41]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[41] ),
        .O(sect_addr[53]));
  (* SOFT_HLUTNM = "soft_lutpair141" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[54]_i_1 
       (.I0(p_0_in_0[42]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[42] ),
        .O(sect_addr[54]));
  (* SOFT_HLUTNM = "soft_lutpair141" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[55]_i_1 
       (.I0(p_0_in_0[43]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[43] ),
        .O(sect_addr[55]));
  (* SOFT_HLUTNM = "soft_lutpair140" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[56]_i_1 
       (.I0(p_0_in_0[44]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[44] ),
        .O(sect_addr[56]));
  (* SOFT_HLUTNM = "soft_lutpair140" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[57]_i_1 
       (.I0(p_0_in_0[45]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[45] ),
        .O(sect_addr[57]));
  (* SOFT_HLUTNM = "soft_lutpair139" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[58]_i_1 
       (.I0(p_0_in_0[46]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[46] ),
        .O(sect_addr[58]));
  (* SOFT_HLUTNM = "soft_lutpair139" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[59]_i_1 
       (.I0(p_0_in_0[47]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[47] ),
        .O(sect_addr[59]));
  (* SOFT_HLUTNM = "soft_lutpair173" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[5]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[5] ),
        .O(sect_addr[5]));
  (* SOFT_HLUTNM = "soft_lutpair138" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[60]_i_1 
       (.I0(p_0_in_0[48]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[48] ),
        .O(sect_addr[60]));
  (* SOFT_HLUTNM = "soft_lutpair138" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[61]_i_1 
       (.I0(p_0_in_0[49]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[49] ),
        .O(sect_addr[61]));
  (* SOFT_HLUTNM = "soft_lutpair137" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[62]_i_1 
       (.I0(p_0_in_0[50]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[50] ),
        .O(sect_addr[62]));
  (* SOFT_HLUTNM = "soft_lutpair137" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sect_addr_buf[63]_i_1 
       (.I0(p_0_in_0[51]),
        .I1(first_sect),
        .I2(\sect_cnt_reg_n_0_[51] ),
        .O(sect_addr[63]));
  (* SOFT_HLUTNM = "soft_lutpair172" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[6]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[6] ),
        .O(sect_addr[6]));
  (* SOFT_HLUTNM = "soft_lutpair172" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[7]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[7] ),
        .O(sect_addr[7]));
  (* SOFT_HLUTNM = "soft_lutpair171" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[8]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[8] ),
        .O(sect_addr[8]));
  (* SOFT_HLUTNM = "soft_lutpair171" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sect_addr_buf[9]_i_1 
       (.I0(first_sect),
        .I1(\start_addr_buf_reg_n_0_[9] ),
        .O(sect_addr[9]));
  FDRE \sect_addr_buf_reg[10] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[10]),
        .Q(\sect_addr_buf_reg_n_0_[10] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[11] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[11]),
        .Q(\sect_addr_buf_reg_n_0_[11] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[12] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[12]),
        .Q(\sect_addr_buf_reg_n_0_[12] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[13] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[13]),
        .Q(\sect_addr_buf_reg_n_0_[13] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[14] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[14]),
        .Q(\sect_addr_buf_reg_n_0_[14] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[15] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[15]),
        .Q(\sect_addr_buf_reg_n_0_[15] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[16] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[16]),
        .Q(\sect_addr_buf_reg_n_0_[16] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[17] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[17]),
        .Q(\sect_addr_buf_reg_n_0_[17] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[18] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[18]),
        .Q(\sect_addr_buf_reg_n_0_[18] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[19] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[19]),
        .Q(\sect_addr_buf_reg_n_0_[19] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[20] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[20]),
        .Q(\sect_addr_buf_reg_n_0_[20] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[21] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[21]),
        .Q(\sect_addr_buf_reg_n_0_[21] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[22] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[22]),
        .Q(\sect_addr_buf_reg_n_0_[22] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[23] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[23]),
        .Q(\sect_addr_buf_reg_n_0_[23] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[24] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[24]),
        .Q(\sect_addr_buf_reg_n_0_[24] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[25] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[25]),
        .Q(\sect_addr_buf_reg_n_0_[25] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[26] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[26]),
        .Q(\sect_addr_buf_reg_n_0_[26] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[27] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[27]),
        .Q(\sect_addr_buf_reg_n_0_[27] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[28] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[28]),
        .Q(\sect_addr_buf_reg_n_0_[28] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[29] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[29]),
        .Q(\sect_addr_buf_reg_n_0_[29] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[2] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[2]),
        .Q(\sect_addr_buf_reg_n_0_[2] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[30] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[30]),
        .Q(\sect_addr_buf_reg_n_0_[30] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[31] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[31]),
        .Q(\sect_addr_buf_reg_n_0_[31] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[32] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[32]),
        .Q(\sect_addr_buf_reg_n_0_[32] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[33] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[33]),
        .Q(\sect_addr_buf_reg_n_0_[33] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[34] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[34]),
        .Q(\sect_addr_buf_reg_n_0_[34] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[35] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[35]),
        .Q(\sect_addr_buf_reg_n_0_[35] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[36] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[36]),
        .Q(\sect_addr_buf_reg_n_0_[36] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[37] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[37]),
        .Q(\sect_addr_buf_reg_n_0_[37] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[38] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[38]),
        .Q(\sect_addr_buf_reg_n_0_[38] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[39] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[39]),
        .Q(\sect_addr_buf_reg_n_0_[39] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[3] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[3]),
        .Q(\sect_addr_buf_reg_n_0_[3] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[40] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[40]),
        .Q(\sect_addr_buf_reg_n_0_[40] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[41] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[41]),
        .Q(\sect_addr_buf_reg_n_0_[41] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[42] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[42]),
        .Q(\sect_addr_buf_reg_n_0_[42] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[43] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[43]),
        .Q(\sect_addr_buf_reg_n_0_[43] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[44] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[44]),
        .Q(\sect_addr_buf_reg_n_0_[44] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[45] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[45]),
        .Q(\sect_addr_buf_reg_n_0_[45] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[46] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[46]),
        .Q(\sect_addr_buf_reg_n_0_[46] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[47] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[47]),
        .Q(\sect_addr_buf_reg_n_0_[47] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[48] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[48]),
        .Q(\sect_addr_buf_reg_n_0_[48] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[49] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[49]),
        .Q(\sect_addr_buf_reg_n_0_[49] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[4] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[4]),
        .Q(\sect_addr_buf_reg_n_0_[4] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[50] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[50]),
        .Q(\sect_addr_buf_reg_n_0_[50] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[51] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[51]),
        .Q(\sect_addr_buf_reg_n_0_[51] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[52] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[52]),
        .Q(\sect_addr_buf_reg_n_0_[52] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[53] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[53]),
        .Q(\sect_addr_buf_reg_n_0_[53] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[54] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[54]),
        .Q(\sect_addr_buf_reg_n_0_[54] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[55] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[55]),
        .Q(\sect_addr_buf_reg_n_0_[55] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[56] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[56]),
        .Q(\sect_addr_buf_reg_n_0_[56] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[57] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[57]),
        .Q(\sect_addr_buf_reg_n_0_[57] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[58] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[58]),
        .Q(\sect_addr_buf_reg_n_0_[58] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[59] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[59]),
        .Q(\sect_addr_buf_reg_n_0_[59] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[5] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[5]),
        .Q(\sect_addr_buf_reg_n_0_[5] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[60] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[60]),
        .Q(\sect_addr_buf_reg_n_0_[60] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[61] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[61]),
        .Q(\sect_addr_buf_reg_n_0_[61] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[62] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[62]),
        .Q(\sect_addr_buf_reg_n_0_[62] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[63] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[63]),
        .Q(\sect_addr_buf_reg_n_0_[63] ),
        .R(SR));
  FDRE \sect_addr_buf_reg[6] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[6]),
        .Q(\sect_addr_buf_reg_n_0_[6] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[7] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[7]),
        .Q(\sect_addr_buf_reg_n_0_[7] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[8] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[8]),
        .Q(\sect_addr_buf_reg_n_0_[8] ),
        .R(fifo_rctl_n_10));
  FDRE \sect_addr_buf_reg[9] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(sect_addr[9]),
        .Q(\sect_addr_buf_reg_n_0_[9] ),
        .R(fifo_rctl_n_10));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry
       (.CI(1'b0),
        .CO({sect_cnt0_carry_n_0,sect_cnt0_carry_n_1,sect_cnt0_carry_n_2,sect_cnt0_carry_n_3}),
        .CYINIT(\sect_cnt_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[4:1]),
        .S({\sect_cnt_reg_n_0_[4] ,\sect_cnt_reg_n_0_[3] ,\sect_cnt_reg_n_0_[2] ,\sect_cnt_reg_n_0_[1] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__0
       (.CI(sect_cnt0_carry_n_0),
        .CO({sect_cnt0_carry__0_n_0,sect_cnt0_carry__0_n_1,sect_cnt0_carry__0_n_2,sect_cnt0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[8:5]),
        .S({\sect_cnt_reg_n_0_[8] ,\sect_cnt_reg_n_0_[7] ,\sect_cnt_reg_n_0_[6] ,\sect_cnt_reg_n_0_[5] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__1
       (.CI(sect_cnt0_carry__0_n_0),
        .CO({sect_cnt0_carry__1_n_0,sect_cnt0_carry__1_n_1,sect_cnt0_carry__1_n_2,sect_cnt0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[12:9]),
        .S({\sect_cnt_reg_n_0_[12] ,\sect_cnt_reg_n_0_[11] ,\sect_cnt_reg_n_0_[10] ,\sect_cnt_reg_n_0_[9] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__10
       (.CI(sect_cnt0_carry__9_n_0),
        .CO({sect_cnt0_carry__10_n_0,sect_cnt0_carry__10_n_1,sect_cnt0_carry__10_n_2,sect_cnt0_carry__10_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[48:45]),
        .S({\sect_cnt_reg_n_0_[48] ,\sect_cnt_reg_n_0_[47] ,\sect_cnt_reg_n_0_[46] ,\sect_cnt_reg_n_0_[45] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__11
       (.CI(sect_cnt0_carry__10_n_0),
        .CO({NLW_sect_cnt0_carry__11_CO_UNCONNECTED[3:2],sect_cnt0_carry__11_n_2,sect_cnt0_carry__11_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_sect_cnt0_carry__11_O_UNCONNECTED[3],sect_cnt0[51:49]}),
        .S({1'b0,\sect_cnt_reg_n_0_[51] ,\sect_cnt_reg_n_0_[50] ,\sect_cnt_reg_n_0_[49] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__2
       (.CI(sect_cnt0_carry__1_n_0),
        .CO({sect_cnt0_carry__2_n_0,sect_cnt0_carry__2_n_1,sect_cnt0_carry__2_n_2,sect_cnt0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[16:13]),
        .S({\sect_cnt_reg_n_0_[16] ,\sect_cnt_reg_n_0_[15] ,\sect_cnt_reg_n_0_[14] ,\sect_cnt_reg_n_0_[13] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__3
       (.CI(sect_cnt0_carry__2_n_0),
        .CO({sect_cnt0_carry__3_n_0,sect_cnt0_carry__3_n_1,sect_cnt0_carry__3_n_2,sect_cnt0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[20:17]),
        .S({\sect_cnt_reg_n_0_[20] ,\sect_cnt_reg_n_0_[19] ,\sect_cnt_reg_n_0_[18] ,\sect_cnt_reg_n_0_[17] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__4
       (.CI(sect_cnt0_carry__3_n_0),
        .CO({sect_cnt0_carry__4_n_0,sect_cnt0_carry__4_n_1,sect_cnt0_carry__4_n_2,sect_cnt0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[24:21]),
        .S({\sect_cnt_reg_n_0_[24] ,\sect_cnt_reg_n_0_[23] ,\sect_cnt_reg_n_0_[22] ,\sect_cnt_reg_n_0_[21] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__5
       (.CI(sect_cnt0_carry__4_n_0),
        .CO({sect_cnt0_carry__5_n_0,sect_cnt0_carry__5_n_1,sect_cnt0_carry__5_n_2,sect_cnt0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[28:25]),
        .S({\sect_cnt_reg_n_0_[28] ,\sect_cnt_reg_n_0_[27] ,\sect_cnt_reg_n_0_[26] ,\sect_cnt_reg_n_0_[25] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__6
       (.CI(sect_cnt0_carry__5_n_0),
        .CO({sect_cnt0_carry__6_n_0,sect_cnt0_carry__6_n_1,sect_cnt0_carry__6_n_2,sect_cnt0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[32:29]),
        .S({\sect_cnt_reg_n_0_[32] ,\sect_cnt_reg_n_0_[31] ,\sect_cnt_reg_n_0_[30] ,\sect_cnt_reg_n_0_[29] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__7
       (.CI(sect_cnt0_carry__6_n_0),
        .CO({sect_cnt0_carry__7_n_0,sect_cnt0_carry__7_n_1,sect_cnt0_carry__7_n_2,sect_cnt0_carry__7_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[36:33]),
        .S({\sect_cnt_reg_n_0_[36] ,\sect_cnt_reg_n_0_[35] ,\sect_cnt_reg_n_0_[34] ,\sect_cnt_reg_n_0_[33] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__8
       (.CI(sect_cnt0_carry__7_n_0),
        .CO({sect_cnt0_carry__8_n_0,sect_cnt0_carry__8_n_1,sect_cnt0_carry__8_n_2,sect_cnt0_carry__8_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[40:37]),
        .S({\sect_cnt_reg_n_0_[40] ,\sect_cnt_reg_n_0_[39] ,\sect_cnt_reg_n_0_[38] ,\sect_cnt_reg_n_0_[37] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 sect_cnt0_carry__9
       (.CI(sect_cnt0_carry__8_n_0),
        .CO({sect_cnt0_carry__9_n_0,sect_cnt0_carry__9_n_1,sect_cnt0_carry__9_n_2,sect_cnt0_carry__9_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(sect_cnt0[44:41]),
        .S({\sect_cnt_reg_n_0_[44] ,\sect_cnt_reg_n_0_[43] ,\sect_cnt_reg_n_0_[42] ,\sect_cnt_reg_n_0_[41] }));
  FDRE \sect_cnt_reg[0] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_53),
        .Q(\sect_cnt_reg_n_0_[0] ),
        .R(SR));
  FDRE \sect_cnt_reg[10] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_43),
        .Q(\sect_cnt_reg_n_0_[10] ),
        .R(SR));
  FDRE \sect_cnt_reg[11] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_42),
        .Q(\sect_cnt_reg_n_0_[11] ),
        .R(SR));
  FDRE \sect_cnt_reg[12] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_41),
        .Q(\sect_cnt_reg_n_0_[12] ),
        .R(SR));
  FDRE \sect_cnt_reg[13] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_40),
        .Q(\sect_cnt_reg_n_0_[13] ),
        .R(SR));
  FDRE \sect_cnt_reg[14] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_39),
        .Q(\sect_cnt_reg_n_0_[14] ),
        .R(SR));
  FDRE \sect_cnt_reg[15] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_38),
        .Q(\sect_cnt_reg_n_0_[15] ),
        .R(SR));
  FDRE \sect_cnt_reg[16] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_37),
        .Q(\sect_cnt_reg_n_0_[16] ),
        .R(SR));
  FDRE \sect_cnt_reg[17] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_36),
        .Q(\sect_cnt_reg_n_0_[17] ),
        .R(SR));
  FDRE \sect_cnt_reg[18] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_35),
        .Q(\sect_cnt_reg_n_0_[18] ),
        .R(SR));
  FDRE \sect_cnt_reg[19] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_34),
        .Q(\sect_cnt_reg_n_0_[19] ),
        .R(SR));
  FDRE \sect_cnt_reg[1] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_52),
        .Q(\sect_cnt_reg_n_0_[1] ),
        .R(SR));
  FDRE \sect_cnt_reg[20] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_33),
        .Q(\sect_cnt_reg_n_0_[20] ),
        .R(SR));
  FDRE \sect_cnt_reg[21] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_32),
        .Q(\sect_cnt_reg_n_0_[21] ),
        .R(SR));
  FDRE \sect_cnt_reg[22] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_31),
        .Q(\sect_cnt_reg_n_0_[22] ),
        .R(SR));
  FDRE \sect_cnt_reg[23] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_30),
        .Q(\sect_cnt_reg_n_0_[23] ),
        .R(SR));
  FDRE \sect_cnt_reg[24] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_29),
        .Q(\sect_cnt_reg_n_0_[24] ),
        .R(SR));
  FDRE \sect_cnt_reg[25] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_28),
        .Q(\sect_cnt_reg_n_0_[25] ),
        .R(SR));
  FDRE \sect_cnt_reg[26] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_27),
        .Q(\sect_cnt_reg_n_0_[26] ),
        .R(SR));
  FDRE \sect_cnt_reg[27] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_26),
        .Q(\sect_cnt_reg_n_0_[27] ),
        .R(SR));
  FDRE \sect_cnt_reg[28] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_25),
        .Q(\sect_cnt_reg_n_0_[28] ),
        .R(SR));
  FDRE \sect_cnt_reg[29] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_24),
        .Q(\sect_cnt_reg_n_0_[29] ),
        .R(SR));
  FDRE \sect_cnt_reg[2] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_51),
        .Q(\sect_cnt_reg_n_0_[2] ),
        .R(SR));
  FDRE \sect_cnt_reg[30] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_23),
        .Q(\sect_cnt_reg_n_0_[30] ),
        .R(SR));
  FDRE \sect_cnt_reg[31] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_22),
        .Q(\sect_cnt_reg_n_0_[31] ),
        .R(SR));
  FDRE \sect_cnt_reg[32] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_21),
        .Q(\sect_cnt_reg_n_0_[32] ),
        .R(SR));
  FDRE \sect_cnt_reg[33] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_20),
        .Q(\sect_cnt_reg_n_0_[33] ),
        .R(SR));
  FDRE \sect_cnt_reg[34] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_19),
        .Q(\sect_cnt_reg_n_0_[34] ),
        .R(SR));
  FDRE \sect_cnt_reg[35] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_18),
        .Q(\sect_cnt_reg_n_0_[35] ),
        .R(SR));
  FDRE \sect_cnt_reg[36] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_17),
        .Q(\sect_cnt_reg_n_0_[36] ),
        .R(SR));
  FDRE \sect_cnt_reg[37] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_16),
        .Q(\sect_cnt_reg_n_0_[37] ),
        .R(SR));
  FDRE \sect_cnt_reg[38] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_15),
        .Q(\sect_cnt_reg_n_0_[38] ),
        .R(SR));
  FDRE \sect_cnt_reg[39] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_14),
        .Q(\sect_cnt_reg_n_0_[39] ),
        .R(SR));
  FDRE \sect_cnt_reg[3] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_50),
        .Q(\sect_cnt_reg_n_0_[3] ),
        .R(SR));
  FDRE \sect_cnt_reg[40] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_13),
        .Q(\sect_cnt_reg_n_0_[40] ),
        .R(SR));
  FDRE \sect_cnt_reg[41] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_12),
        .Q(\sect_cnt_reg_n_0_[41] ),
        .R(SR));
  FDRE \sect_cnt_reg[42] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_11),
        .Q(\sect_cnt_reg_n_0_[42] ),
        .R(SR));
  FDRE \sect_cnt_reg[43] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_10),
        .Q(\sect_cnt_reg_n_0_[43] ),
        .R(SR));
  FDRE \sect_cnt_reg[44] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_9),
        .Q(\sect_cnt_reg_n_0_[44] ),
        .R(SR));
  FDRE \sect_cnt_reg[45] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_8),
        .Q(\sect_cnt_reg_n_0_[45] ),
        .R(SR));
  FDRE \sect_cnt_reg[46] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_7),
        .Q(\sect_cnt_reg_n_0_[46] ),
        .R(SR));
  FDRE \sect_cnt_reg[47] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_6),
        .Q(\sect_cnt_reg_n_0_[47] ),
        .R(SR));
  FDRE \sect_cnt_reg[48] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_5),
        .Q(\sect_cnt_reg_n_0_[48] ),
        .R(SR));
  FDRE \sect_cnt_reg[49] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_4),
        .Q(\sect_cnt_reg_n_0_[49] ),
        .R(SR));
  FDRE \sect_cnt_reg[4] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_49),
        .Q(\sect_cnt_reg_n_0_[4] ),
        .R(SR));
  FDRE \sect_cnt_reg[50] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_3),
        .Q(\sect_cnt_reg_n_0_[50] ),
        .R(SR));
  FDRE \sect_cnt_reg[51] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_2),
        .Q(\sect_cnt_reg_n_0_[51] ),
        .R(SR));
  FDRE \sect_cnt_reg[5] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_48),
        .Q(\sect_cnt_reg_n_0_[5] ),
        .R(SR));
  FDRE \sect_cnt_reg[6] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_47),
        .Q(\sect_cnt_reg_n_0_[6] ),
        .R(SR));
  FDRE \sect_cnt_reg[7] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_46),
        .Q(\sect_cnt_reg_n_0_[7] ),
        .R(SR));
  FDRE \sect_cnt_reg[8] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_45),
        .Q(\sect_cnt_reg_n_0_[8] ),
        .R(SR));
  FDRE \sect_cnt_reg[9] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_5),
        .D(fifo_rreq_n_44),
        .Q(\sect_cnt_reg_n_0_[9] ),
        .R(SR));
  LUT5 #(
    .INIT(32'hCC0FAAFF)) 
    \sect_len_buf[0]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[2] ),
        .I1(beat_len_buf[0]),
        .I2(\start_addr_buf_reg_n_0_[2] ),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[1]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[3] ),
        .I1(\start_addr_buf_reg_n_0_[3] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[2]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[4] ),
        .I1(\start_addr_buf_reg_n_0_[4] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[3]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[5] ),
        .I1(\start_addr_buf_reg_n_0_[5] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[4]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[6] ),
        .I1(\start_addr_buf_reg_n_0_[6] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[5]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[7] ),
        .I1(\start_addr_buf_reg_n_0_[7] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[6]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[8] ),
        .I1(\start_addr_buf_reg_n_0_[8] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[7]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[9] ),
        .I1(\start_addr_buf_reg_n_0_[9] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF033AAFF)) 
    \sect_len_buf[8]_i_1 
       (.I0(\end_addr_buf_reg_n_0_[10] ),
        .I1(\start_addr_buf_reg_n_0_[10] ),
        .I2(beat_len_buf[7]),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAA0FCCFF)) 
    \sect_len_buf[9]_i_2 
       (.I0(beat_len_buf[7]),
        .I1(\end_addr_buf_reg_n_0_[11] ),
        .I2(\start_addr_buf_reg_n_0_[11] ),
        .I3(last_sect),
        .I4(first_sect),
        .O(\sect_len_buf[9]_i_2_n_0 ));
  FDRE \sect_len_buf_reg[0] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[0]_i_1_n_0 ),
        .Q(p_1_in[0]),
        .R(SR));
  FDRE \sect_len_buf_reg[1] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[1]_i_1_n_0 ),
        .Q(p_1_in[1]),
        .R(SR));
  FDRE \sect_len_buf_reg[2] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[2]_i_1_n_0 ),
        .Q(p_1_in[2]),
        .R(SR));
  FDRE \sect_len_buf_reg[3] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[3]_i_1_n_0 ),
        .Q(p_1_in[3]),
        .R(SR));
  FDRE \sect_len_buf_reg[4] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[4]_i_1_n_0 ),
        .Q(p_1_in[4]),
        .R(SR));
  FDRE \sect_len_buf_reg[5] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[5]_i_1_n_0 ),
        .Q(\sect_len_buf_reg_n_0_[5] ),
        .R(SR));
  FDRE \sect_len_buf_reg[6] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[6]_i_1_n_0 ),
        .Q(\sect_len_buf_reg_n_0_[6] ),
        .R(SR));
  FDRE \sect_len_buf_reg[7] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[7]_i_1_n_0 ),
        .Q(\sect_len_buf_reg_n_0_[7] ),
        .R(SR));
  FDRE \sect_len_buf_reg[8] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[8]_i_1_n_0 ),
        .Q(\sect_len_buf_reg_n_0_[8] ),
        .R(SR));
  FDRE \sect_len_buf_reg[9] 
       (.C(ap_clk),
        .CE(p_21_in),
        .D(\sect_len_buf[9]_i_2_n_0 ),
        .Q(\sect_len_buf_reg_n_0_[9] ),
        .R(SR));
  FDRE \start_addr_buf_reg[10] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[10] ),
        .Q(\start_addr_buf_reg_n_0_[10] ),
        .R(SR));
  FDRE \start_addr_buf_reg[11] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[11] ),
        .Q(\start_addr_buf_reg_n_0_[11] ),
        .R(SR));
  FDRE \start_addr_buf_reg[12] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[12] ),
        .Q(p_0_in_0[0]),
        .R(SR));
  FDRE \start_addr_buf_reg[13] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[13] ),
        .Q(p_0_in_0[1]),
        .R(SR));
  FDRE \start_addr_buf_reg[14] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[14] ),
        .Q(p_0_in_0[2]),
        .R(SR));
  FDRE \start_addr_buf_reg[15] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[15] ),
        .Q(p_0_in_0[3]),
        .R(SR));
  FDRE \start_addr_buf_reg[16] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[16] ),
        .Q(p_0_in_0[4]),
        .R(SR));
  FDRE \start_addr_buf_reg[17] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[17] ),
        .Q(p_0_in_0[5]),
        .R(SR));
  FDRE \start_addr_buf_reg[18] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[18] ),
        .Q(p_0_in_0[6]),
        .R(SR));
  FDRE \start_addr_buf_reg[19] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[19] ),
        .Q(p_0_in_0[7]),
        .R(SR));
  FDRE \start_addr_buf_reg[20] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[20] ),
        .Q(p_0_in_0[8]),
        .R(SR));
  FDRE \start_addr_buf_reg[21] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[21] ),
        .Q(p_0_in_0[9]),
        .R(SR));
  FDRE \start_addr_buf_reg[22] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[22] ),
        .Q(p_0_in_0[10]),
        .R(SR));
  FDRE \start_addr_buf_reg[23] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[23] ),
        .Q(p_0_in_0[11]),
        .R(SR));
  FDRE \start_addr_buf_reg[24] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[24] ),
        .Q(p_0_in_0[12]),
        .R(SR));
  FDRE \start_addr_buf_reg[25] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[25] ),
        .Q(p_0_in_0[13]),
        .R(SR));
  FDRE \start_addr_buf_reg[26] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[26] ),
        .Q(p_0_in_0[14]),
        .R(SR));
  FDRE \start_addr_buf_reg[27] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[27] ),
        .Q(p_0_in_0[15]),
        .R(SR));
  FDRE \start_addr_buf_reg[28] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[28] ),
        .Q(p_0_in_0[16]),
        .R(SR));
  FDRE \start_addr_buf_reg[29] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[29] ),
        .Q(p_0_in_0[17]),
        .R(SR));
  FDRE \start_addr_buf_reg[2] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[2] ),
        .Q(\start_addr_buf_reg_n_0_[2] ),
        .R(SR));
  FDRE \start_addr_buf_reg[30] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[30] ),
        .Q(p_0_in_0[18]),
        .R(SR));
  FDRE \start_addr_buf_reg[31] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[31] ),
        .Q(p_0_in_0[19]),
        .R(SR));
  FDRE \start_addr_buf_reg[32] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[32] ),
        .Q(p_0_in_0[20]),
        .R(SR));
  FDRE \start_addr_buf_reg[33] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[33] ),
        .Q(p_0_in_0[21]),
        .R(SR));
  FDRE \start_addr_buf_reg[34] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[34] ),
        .Q(p_0_in_0[22]),
        .R(SR));
  FDRE \start_addr_buf_reg[35] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[35] ),
        .Q(p_0_in_0[23]),
        .R(SR));
  FDRE \start_addr_buf_reg[36] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[36] ),
        .Q(p_0_in_0[24]),
        .R(SR));
  FDRE \start_addr_buf_reg[37] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[37] ),
        .Q(p_0_in_0[25]),
        .R(SR));
  FDRE \start_addr_buf_reg[38] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[38] ),
        .Q(p_0_in_0[26]),
        .R(SR));
  FDRE \start_addr_buf_reg[39] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[39] ),
        .Q(p_0_in_0[27]),
        .R(SR));
  FDRE \start_addr_buf_reg[3] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[3] ),
        .Q(\start_addr_buf_reg_n_0_[3] ),
        .R(SR));
  FDRE \start_addr_buf_reg[40] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[40] ),
        .Q(p_0_in_0[28]),
        .R(SR));
  FDRE \start_addr_buf_reg[41] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[41] ),
        .Q(p_0_in_0[29]),
        .R(SR));
  FDRE \start_addr_buf_reg[42] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[42] ),
        .Q(p_0_in_0[30]),
        .R(SR));
  FDRE \start_addr_buf_reg[43] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[43] ),
        .Q(p_0_in_0[31]),
        .R(SR));
  FDRE \start_addr_buf_reg[44] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[44] ),
        .Q(p_0_in_0[32]),
        .R(SR));
  FDRE \start_addr_buf_reg[45] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[45] ),
        .Q(p_0_in_0[33]),
        .R(SR));
  FDRE \start_addr_buf_reg[46] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[46] ),
        .Q(p_0_in_0[34]),
        .R(SR));
  FDRE \start_addr_buf_reg[47] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[47] ),
        .Q(p_0_in_0[35]),
        .R(SR));
  FDRE \start_addr_buf_reg[48] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[48] ),
        .Q(p_0_in_0[36]),
        .R(SR));
  FDRE \start_addr_buf_reg[49] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[49] ),
        .Q(p_0_in_0[37]),
        .R(SR));
  FDRE \start_addr_buf_reg[4] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[4] ),
        .Q(\start_addr_buf_reg_n_0_[4] ),
        .R(SR));
  FDRE \start_addr_buf_reg[50] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[50] ),
        .Q(p_0_in_0[38]),
        .R(SR));
  FDRE \start_addr_buf_reg[51] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[51] ),
        .Q(p_0_in_0[39]),
        .R(SR));
  FDRE \start_addr_buf_reg[52] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[52] ),
        .Q(p_0_in_0[40]),
        .R(SR));
  FDRE \start_addr_buf_reg[53] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[53] ),
        .Q(p_0_in_0[41]),
        .R(SR));
  FDRE \start_addr_buf_reg[54] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[54] ),
        .Q(p_0_in_0[42]),
        .R(SR));
  FDRE \start_addr_buf_reg[55] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[55] ),
        .Q(p_0_in_0[43]),
        .R(SR));
  FDRE \start_addr_buf_reg[56] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[56] ),
        .Q(p_0_in_0[44]),
        .R(SR));
  FDRE \start_addr_buf_reg[57] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[57] ),
        .Q(p_0_in_0[45]),
        .R(SR));
  FDRE \start_addr_buf_reg[58] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[58] ),
        .Q(p_0_in_0[46]),
        .R(SR));
  FDRE \start_addr_buf_reg[59] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[59] ),
        .Q(p_0_in_0[47]),
        .R(SR));
  FDRE \start_addr_buf_reg[5] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[5] ),
        .Q(\start_addr_buf_reg_n_0_[5] ),
        .R(SR));
  FDRE \start_addr_buf_reg[60] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[60] ),
        .Q(p_0_in_0[48]),
        .R(SR));
  FDRE \start_addr_buf_reg[61] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[61] ),
        .Q(p_0_in_0[49]),
        .R(SR));
  FDRE \start_addr_buf_reg[62] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[62] ),
        .Q(p_0_in_0[50]),
        .R(SR));
  FDRE \start_addr_buf_reg[63] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[63] ),
        .Q(p_0_in_0[51]),
        .R(SR));
  FDRE \start_addr_buf_reg[6] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[6] ),
        .Q(\start_addr_buf_reg_n_0_[6] ),
        .R(SR));
  FDRE \start_addr_buf_reg[7] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[7] ),
        .Q(\start_addr_buf_reg_n_0_[7] ),
        .R(SR));
  FDRE \start_addr_buf_reg[8] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[8] ),
        .Q(\start_addr_buf_reg_n_0_[8] ),
        .R(SR));
  FDRE \start_addr_buf_reg[9] 
       (.C(ap_clk),
        .CE(next_rreq),
        .D(\start_addr_reg_n_0_[9] ),
        .Q(\start_addr_buf_reg_n_0_[9] ),
        .R(SR));
  FDRE \start_addr_reg[10] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[8]),
        .Q(\start_addr_reg_n_0_[10] ),
        .R(SR));
  FDRE \start_addr_reg[11] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[9]),
        .Q(\start_addr_reg_n_0_[11] ),
        .R(SR));
  FDRE \start_addr_reg[12] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[10]),
        .Q(\start_addr_reg_n_0_[12] ),
        .R(SR));
  FDRE \start_addr_reg[13] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[11]),
        .Q(\start_addr_reg_n_0_[13] ),
        .R(SR));
  FDRE \start_addr_reg[14] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[12]),
        .Q(\start_addr_reg_n_0_[14] ),
        .R(SR));
  FDRE \start_addr_reg[15] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[13]),
        .Q(\start_addr_reg_n_0_[15] ),
        .R(SR));
  FDRE \start_addr_reg[16] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[14]),
        .Q(\start_addr_reg_n_0_[16] ),
        .R(SR));
  FDRE \start_addr_reg[17] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[15]),
        .Q(\start_addr_reg_n_0_[17] ),
        .R(SR));
  FDRE \start_addr_reg[18] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[16]),
        .Q(\start_addr_reg_n_0_[18] ),
        .R(SR));
  FDRE \start_addr_reg[19] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[17]),
        .Q(\start_addr_reg_n_0_[19] ),
        .R(SR));
  FDRE \start_addr_reg[20] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[18]),
        .Q(\start_addr_reg_n_0_[20] ),
        .R(SR));
  FDRE \start_addr_reg[21] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[19]),
        .Q(\start_addr_reg_n_0_[21] ),
        .R(SR));
  FDRE \start_addr_reg[22] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[20]),
        .Q(\start_addr_reg_n_0_[22] ),
        .R(SR));
  FDRE \start_addr_reg[23] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[21]),
        .Q(\start_addr_reg_n_0_[23] ),
        .R(SR));
  FDRE \start_addr_reg[24] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[22]),
        .Q(\start_addr_reg_n_0_[24] ),
        .R(SR));
  FDRE \start_addr_reg[25] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[23]),
        .Q(\start_addr_reg_n_0_[25] ),
        .R(SR));
  FDRE \start_addr_reg[26] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[24]),
        .Q(\start_addr_reg_n_0_[26] ),
        .R(SR));
  FDRE \start_addr_reg[27] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[25]),
        .Q(\start_addr_reg_n_0_[27] ),
        .R(SR));
  FDRE \start_addr_reg[28] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[26]),
        .Q(\start_addr_reg_n_0_[28] ),
        .R(SR));
  FDRE \start_addr_reg[29] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[27]),
        .Q(\start_addr_reg_n_0_[29] ),
        .R(SR));
  FDRE \start_addr_reg[2] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[0]),
        .Q(\start_addr_reg_n_0_[2] ),
        .R(SR));
  FDRE \start_addr_reg[30] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[28]),
        .Q(\start_addr_reg_n_0_[30] ),
        .R(SR));
  FDRE \start_addr_reg[31] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[29]),
        .Q(\start_addr_reg_n_0_[31] ),
        .R(SR));
  FDRE \start_addr_reg[32] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[30]),
        .Q(\start_addr_reg_n_0_[32] ),
        .R(SR));
  FDRE \start_addr_reg[33] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[31]),
        .Q(\start_addr_reg_n_0_[33] ),
        .R(SR));
  FDRE \start_addr_reg[34] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[32]),
        .Q(\start_addr_reg_n_0_[34] ),
        .R(SR));
  FDRE \start_addr_reg[35] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[33]),
        .Q(\start_addr_reg_n_0_[35] ),
        .R(SR));
  FDRE \start_addr_reg[36] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[34]),
        .Q(\start_addr_reg_n_0_[36] ),
        .R(SR));
  FDRE \start_addr_reg[37] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[35]),
        .Q(\start_addr_reg_n_0_[37] ),
        .R(SR));
  FDRE \start_addr_reg[38] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[36]),
        .Q(\start_addr_reg_n_0_[38] ),
        .R(SR));
  FDRE \start_addr_reg[39] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[37]),
        .Q(\start_addr_reg_n_0_[39] ),
        .R(SR));
  FDRE \start_addr_reg[3] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[1]),
        .Q(\start_addr_reg_n_0_[3] ),
        .R(SR));
  FDRE \start_addr_reg[40] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[38]),
        .Q(\start_addr_reg_n_0_[40] ),
        .R(SR));
  FDRE \start_addr_reg[41] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[39]),
        .Q(\start_addr_reg_n_0_[41] ),
        .R(SR));
  FDRE \start_addr_reg[42] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[40]),
        .Q(\start_addr_reg_n_0_[42] ),
        .R(SR));
  FDRE \start_addr_reg[43] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[41]),
        .Q(\start_addr_reg_n_0_[43] ),
        .R(SR));
  FDRE \start_addr_reg[44] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[42]),
        .Q(\start_addr_reg_n_0_[44] ),
        .R(SR));
  FDRE \start_addr_reg[45] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[43]),
        .Q(\start_addr_reg_n_0_[45] ),
        .R(SR));
  FDRE \start_addr_reg[46] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[44]),
        .Q(\start_addr_reg_n_0_[46] ),
        .R(SR));
  FDRE \start_addr_reg[47] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[45]),
        .Q(\start_addr_reg_n_0_[47] ),
        .R(SR));
  FDRE \start_addr_reg[48] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[46]),
        .Q(\start_addr_reg_n_0_[48] ),
        .R(SR));
  FDRE \start_addr_reg[49] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[47]),
        .Q(\start_addr_reg_n_0_[49] ),
        .R(SR));
  FDRE \start_addr_reg[4] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[2]),
        .Q(\start_addr_reg_n_0_[4] ),
        .R(SR));
  FDRE \start_addr_reg[50] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[48]),
        .Q(\start_addr_reg_n_0_[50] ),
        .R(SR));
  FDRE \start_addr_reg[51] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[49]),
        .Q(\start_addr_reg_n_0_[51] ),
        .R(SR));
  FDRE \start_addr_reg[52] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[50]),
        .Q(\start_addr_reg_n_0_[52] ),
        .R(SR));
  FDRE \start_addr_reg[53] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[51]),
        .Q(\start_addr_reg_n_0_[53] ),
        .R(SR));
  FDRE \start_addr_reg[54] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[52]),
        .Q(\start_addr_reg_n_0_[54] ),
        .R(SR));
  FDRE \start_addr_reg[55] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[53]),
        .Q(\start_addr_reg_n_0_[55] ),
        .R(SR));
  FDRE \start_addr_reg[56] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[54]),
        .Q(\start_addr_reg_n_0_[56] ),
        .R(SR));
  FDRE \start_addr_reg[57] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[55]),
        .Q(\start_addr_reg_n_0_[57] ),
        .R(SR));
  FDRE \start_addr_reg[58] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[56]),
        .Q(\start_addr_reg_n_0_[58] ),
        .R(SR));
  FDRE \start_addr_reg[59] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[57]),
        .Q(\start_addr_reg_n_0_[59] ),
        .R(SR));
  FDRE \start_addr_reg[5] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[3]),
        .Q(\start_addr_reg_n_0_[5] ),
        .R(SR));
  FDRE \start_addr_reg[60] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[58]),
        .Q(\start_addr_reg_n_0_[60] ),
        .R(SR));
  FDRE \start_addr_reg[61] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[59]),
        .Q(\start_addr_reg_n_0_[61] ),
        .R(SR));
  FDRE \start_addr_reg[62] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[60]),
        .Q(\start_addr_reg_n_0_[62] ),
        .R(SR));
  FDRE \start_addr_reg[63] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[61]),
        .Q(\start_addr_reg_n_0_[63] ),
        .R(SR));
  FDRE \start_addr_reg[6] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[4]),
        .Q(\start_addr_reg_n_0_[6] ),
        .R(SR));
  FDRE \start_addr_reg[7] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[5]),
        .Q(\start_addr_reg_n_0_[7] ),
        .R(SR));
  FDRE \start_addr_reg[8] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[6]),
        .Q(\start_addr_reg_n_0_[8] ),
        .R(SR));
  FDRE \start_addr_reg[9] 
       (.C(ap_clk),
        .CE(fifo_rctl_n_9),
        .D(q[7]),
        .Q(\start_addr_reg_n_0_[9] ),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "sound_operation_ram_m_axi_reg_slice" *) 
module design_1_sound_operation_0_7_sound_operation_ram_m_axi_reg_slice
   (E,
    push,
    ap_NS_fsm,
    \data_p1_reg[61]_0 ,
    SR,
    ap_clk,
    rs2f_rreq_ack,
    Q,
    \data_p2_reg[61]_0 );
  output [0:0]E;
  output push;
  output [0:0]ap_NS_fsm;
  output [61:0]\data_p1_reg[61]_0 ;
  input [0:0]SR;
  input ap_clk;
  input rs2f_rreq_ack;
  input [1:0]Q;
  input [61:0]\data_p2_reg[61]_0 ;

  wire [0:0]E;
  wire [1:0]Q;
  wire [0:0]SR;
  wire [0:0]ap_NS_fsm;
  wire ap_clk;
  wire \data_p1[0]_i_1_n_0 ;
  wire \data_p1[10]_i_1_n_0 ;
  wire \data_p1[11]_i_1_n_0 ;
  wire \data_p1[12]_i_1_n_0 ;
  wire \data_p1[13]_i_1_n_0 ;
  wire \data_p1[14]_i_1_n_0 ;
  wire \data_p1[15]_i_1_n_0 ;
  wire \data_p1[16]_i_1_n_0 ;
  wire \data_p1[17]_i_1_n_0 ;
  wire \data_p1[18]_i_1_n_0 ;
  wire \data_p1[19]_i_1_n_0 ;
  wire \data_p1[1]_i_1_n_0 ;
  wire \data_p1[20]_i_1_n_0 ;
  wire \data_p1[21]_i_1_n_0 ;
  wire \data_p1[22]_i_1_n_0 ;
  wire \data_p1[23]_i_1_n_0 ;
  wire \data_p1[24]_i_1_n_0 ;
  wire \data_p1[25]_i_1_n_0 ;
  wire \data_p1[26]_i_1_n_0 ;
  wire \data_p1[27]_i_1_n_0 ;
  wire \data_p1[28]_i_1_n_0 ;
  wire \data_p1[29]_i_1_n_0 ;
  wire \data_p1[2]_i_1_n_0 ;
  wire \data_p1[30]_i_1_n_0 ;
  wire \data_p1[31]_i_1__0_n_0 ;
  wire \data_p1[32]_i_1_n_0 ;
  wire \data_p1[33]_i_1_n_0 ;
  wire \data_p1[34]_i_1_n_0 ;
  wire \data_p1[35]_i_1_n_0 ;
  wire \data_p1[36]_i_1_n_0 ;
  wire \data_p1[37]_i_1_n_0 ;
  wire \data_p1[38]_i_1_n_0 ;
  wire \data_p1[39]_i_1_n_0 ;
  wire \data_p1[3]_i_1_n_0 ;
  wire \data_p1[40]_i_1_n_0 ;
  wire \data_p1[41]_i_1_n_0 ;
  wire \data_p1[42]_i_1_n_0 ;
  wire \data_p1[43]_i_1_n_0 ;
  wire \data_p1[44]_i_1_n_0 ;
  wire \data_p1[45]_i_1_n_0 ;
  wire \data_p1[46]_i_1_n_0 ;
  wire \data_p1[47]_i_1_n_0 ;
  wire \data_p1[48]_i_1_n_0 ;
  wire \data_p1[49]_i_1_n_0 ;
  wire \data_p1[4]_i_1_n_0 ;
  wire \data_p1[50]_i_1_n_0 ;
  wire \data_p1[51]_i_1_n_0 ;
  wire \data_p1[52]_i_1_n_0 ;
  wire \data_p1[53]_i_1_n_0 ;
  wire \data_p1[54]_i_1_n_0 ;
  wire \data_p1[55]_i_1_n_0 ;
  wire \data_p1[56]_i_1_n_0 ;
  wire \data_p1[57]_i_1_n_0 ;
  wire \data_p1[58]_i_1_n_0 ;
  wire \data_p1[59]_i_1_n_0 ;
  wire \data_p1[5]_i_1_n_0 ;
  wire \data_p1[60]_i_1_n_0 ;
  wire \data_p1[61]_i_2_n_0 ;
  wire \data_p1[6]_i_1_n_0 ;
  wire \data_p1[7]_i_1_n_0 ;
  wire \data_p1[8]_i_1_n_0 ;
  wire \data_p1[9]_i_1_n_0 ;
  wire [61:0]\data_p1_reg[61]_0 ;
  wire [61:0]data_p2;
  wire [61:0]\data_p2_reg[61]_0 ;
  wire load_p1;
  wire [1:0]next__0;
  wire push;
  wire ram_ARREADY;
  wire rs2f_rreq_ack;
  wire rs2f_rreq_valid;
  wire s_ready_t_i_1_n_0;
  wire [1:1]state;
  wire \state[0]_i_1_n_0 ;
  wire \state[1]_i_1_n_0 ;
  wire [1:0]state__0;

  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT5 #(
    .INIT(32'h00000F80)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(ram_ARREADY),
        .I1(Q[1]),
        .I2(state__0[1]),
        .I3(state__0[0]),
        .I4(rs2f_rreq_ack),
        .O(next__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT5 #(
    .INIT(32'h0095AAC0)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(rs2f_rreq_ack),
        .I1(Q[1]),
        .I2(ram_ARREADY),
        .I3(state__0[0]),
        .I4(state__0[1]),
        .O(next__0[1]));
  (* FSM_ENCODED_STATES = "ZERO:00,TWO:01,ONE:10" *) 
  FDRE \FSM_sequential_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(next__0[0]),
        .Q(state__0[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "ZERO:00,TWO:01,ONE:10" *) 
  FDRE \FSM_sequential_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(next__0[1]),
        .Q(state__0[1]),
        .R(SR));
  LUT3 #(
    .INIT(8'hBA)) 
    \ap_CS_fsm[2]_i_1 
       (.I0(Q[0]),
        .I1(ram_ARREADY),
        .I2(Q[1]),
        .O(ap_NS_fsm));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[0]_i_1 
       (.I0(\data_p2_reg[61]_0 [0]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[0]),
        .O(\data_p1[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[10]_i_1 
       (.I0(\data_p2_reg[61]_0 [10]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[10]),
        .O(\data_p1[10]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[11]_i_1 
       (.I0(\data_p2_reg[61]_0 [11]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[11]),
        .O(\data_p1[11]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[12]_i_1 
       (.I0(\data_p2_reg[61]_0 [12]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[12]),
        .O(\data_p1[12]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[13]_i_1 
       (.I0(\data_p2_reg[61]_0 [13]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[13]),
        .O(\data_p1[13]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[14]_i_1 
       (.I0(\data_p2_reg[61]_0 [14]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[14]),
        .O(\data_p1[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[15]_i_1 
       (.I0(\data_p2_reg[61]_0 [15]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[15]),
        .O(\data_p1[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[16]_i_1 
       (.I0(\data_p2_reg[61]_0 [16]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[16]),
        .O(\data_p1[16]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[17]_i_1 
       (.I0(\data_p2_reg[61]_0 [17]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[17]),
        .O(\data_p1[17]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[18]_i_1 
       (.I0(\data_p2_reg[61]_0 [18]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[18]),
        .O(\data_p1[18]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[19]_i_1 
       (.I0(\data_p2_reg[61]_0 [19]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[19]),
        .O(\data_p1[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[1]_i_1 
       (.I0(\data_p2_reg[61]_0 [1]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[1]),
        .O(\data_p1[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[20]_i_1 
       (.I0(\data_p2_reg[61]_0 [20]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[20]),
        .O(\data_p1[20]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[21]_i_1 
       (.I0(\data_p2_reg[61]_0 [21]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[21]),
        .O(\data_p1[21]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[22]_i_1 
       (.I0(\data_p2_reg[61]_0 [22]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[22]),
        .O(\data_p1[22]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[23]_i_1 
       (.I0(\data_p2_reg[61]_0 [23]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[23]),
        .O(\data_p1[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[24]_i_1 
       (.I0(\data_p2_reg[61]_0 [24]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[24]),
        .O(\data_p1[24]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[25]_i_1 
       (.I0(\data_p2_reg[61]_0 [25]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[25]),
        .O(\data_p1[25]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[26]_i_1 
       (.I0(\data_p2_reg[61]_0 [26]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[26]),
        .O(\data_p1[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[27]_i_1 
       (.I0(\data_p2_reg[61]_0 [27]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[27]),
        .O(\data_p1[27]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[28]_i_1 
       (.I0(\data_p2_reg[61]_0 [28]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[28]),
        .O(\data_p1[28]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[29]_i_1 
       (.I0(\data_p2_reg[61]_0 [29]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[29]),
        .O(\data_p1[29]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[2]_i_1 
       (.I0(\data_p2_reg[61]_0 [2]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[2]),
        .O(\data_p1[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[30]_i_1 
       (.I0(\data_p2_reg[61]_0 [30]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[30]),
        .O(\data_p1[30]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[31]_i_1__0 
       (.I0(\data_p2_reg[61]_0 [31]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[31]),
        .O(\data_p1[31]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[32]_i_1 
       (.I0(\data_p2_reg[61]_0 [32]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[32]),
        .O(\data_p1[32]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[33]_i_1 
       (.I0(\data_p2_reg[61]_0 [33]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[33]),
        .O(\data_p1[33]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[34]_i_1 
       (.I0(\data_p2_reg[61]_0 [34]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[34]),
        .O(\data_p1[34]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[35]_i_1 
       (.I0(\data_p2_reg[61]_0 [35]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[35]),
        .O(\data_p1[35]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[36]_i_1 
       (.I0(\data_p2_reg[61]_0 [36]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[36]),
        .O(\data_p1[36]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[37]_i_1 
       (.I0(\data_p2_reg[61]_0 [37]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[37]),
        .O(\data_p1[37]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[38]_i_1 
       (.I0(\data_p2_reg[61]_0 [38]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[38]),
        .O(\data_p1[38]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[39]_i_1 
       (.I0(\data_p2_reg[61]_0 [39]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[39]),
        .O(\data_p1[39]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[3]_i_1 
       (.I0(\data_p2_reg[61]_0 [3]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[3]),
        .O(\data_p1[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[40]_i_1 
       (.I0(\data_p2_reg[61]_0 [40]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[40]),
        .O(\data_p1[40]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[41]_i_1 
       (.I0(\data_p2_reg[61]_0 [41]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[41]),
        .O(\data_p1[41]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[42]_i_1 
       (.I0(\data_p2_reg[61]_0 [42]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[42]),
        .O(\data_p1[42]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[43]_i_1 
       (.I0(\data_p2_reg[61]_0 [43]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[43]),
        .O(\data_p1[43]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[44]_i_1 
       (.I0(\data_p2_reg[61]_0 [44]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[44]),
        .O(\data_p1[44]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[45]_i_1 
       (.I0(\data_p2_reg[61]_0 [45]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[45]),
        .O(\data_p1[45]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[46]_i_1 
       (.I0(\data_p2_reg[61]_0 [46]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[46]),
        .O(\data_p1[46]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[47]_i_1 
       (.I0(\data_p2_reg[61]_0 [47]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[47]),
        .O(\data_p1[47]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[48]_i_1 
       (.I0(\data_p2_reg[61]_0 [48]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[48]),
        .O(\data_p1[48]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[49]_i_1 
       (.I0(\data_p2_reg[61]_0 [49]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[49]),
        .O(\data_p1[49]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[4]_i_1 
       (.I0(\data_p2_reg[61]_0 [4]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[4]),
        .O(\data_p1[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[50]_i_1 
       (.I0(\data_p2_reg[61]_0 [50]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[50]),
        .O(\data_p1[50]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[51]_i_1 
       (.I0(\data_p2_reg[61]_0 [51]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[51]),
        .O(\data_p1[51]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[52]_i_1 
       (.I0(\data_p2_reg[61]_0 [52]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[52]),
        .O(\data_p1[52]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[53]_i_1 
       (.I0(\data_p2_reg[61]_0 [53]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[53]),
        .O(\data_p1[53]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[54]_i_1 
       (.I0(\data_p2_reg[61]_0 [54]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[54]),
        .O(\data_p1[54]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[55]_i_1 
       (.I0(\data_p2_reg[61]_0 [55]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[55]),
        .O(\data_p1[55]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[56]_i_1 
       (.I0(\data_p2_reg[61]_0 [56]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[56]),
        .O(\data_p1[56]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[57]_i_1 
       (.I0(\data_p2_reg[61]_0 [57]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[57]),
        .O(\data_p1[57]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[58]_i_1 
       (.I0(\data_p2_reg[61]_0 [58]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[58]),
        .O(\data_p1[58]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[59]_i_1 
       (.I0(\data_p2_reg[61]_0 [59]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[59]),
        .O(\data_p1[59]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[5]_i_1 
       (.I0(\data_p2_reg[61]_0 [5]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[5]),
        .O(\data_p1[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[60]_i_1 
       (.I0(\data_p2_reg[61]_0 [60]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[60]),
        .O(\data_p1[60]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h2B080808)) 
    \data_p1[61]_i_1 
       (.I0(rs2f_rreq_ack),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(Q[1]),
        .I4(ram_ARREADY),
        .O(load_p1));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[61]_i_2 
       (.I0(\data_p2_reg[61]_0 [61]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[61]),
        .O(\data_p1[61]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[6]_i_1 
       (.I0(\data_p2_reg[61]_0 [6]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[6]),
        .O(\data_p1[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[7]_i_1 
       (.I0(\data_p2_reg[61]_0 [7]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[7]),
        .O(\data_p1[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[8]_i_1 
       (.I0(\data_p2_reg[61]_0 [8]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[8]),
        .O(\data_p1[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hBA8A)) 
    \data_p1[9]_i_1 
       (.I0(\data_p2_reg[61]_0 [9]),
        .I1(state__0[1]),
        .I2(state__0[0]),
        .I3(data_p2[9]),
        .O(\data_p1[9]_i_1_n_0 ));
  FDRE \data_p1_reg[0] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[0]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [0]),
        .R(1'b0));
  FDRE \data_p1_reg[10] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[10]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [10]),
        .R(1'b0));
  FDRE \data_p1_reg[11] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[11]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [11]),
        .R(1'b0));
  FDRE \data_p1_reg[12] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[12]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [12]),
        .R(1'b0));
  FDRE \data_p1_reg[13] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[13]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [13]),
        .R(1'b0));
  FDRE \data_p1_reg[14] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[14]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [14]),
        .R(1'b0));
  FDRE \data_p1_reg[15] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[15]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [15]),
        .R(1'b0));
  FDRE \data_p1_reg[16] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[16]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [16]),
        .R(1'b0));
  FDRE \data_p1_reg[17] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[17]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [17]),
        .R(1'b0));
  FDRE \data_p1_reg[18] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[18]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [18]),
        .R(1'b0));
  FDRE \data_p1_reg[19] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[19]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [19]),
        .R(1'b0));
  FDRE \data_p1_reg[1] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[1]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [1]),
        .R(1'b0));
  FDRE \data_p1_reg[20] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[20]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [20]),
        .R(1'b0));
  FDRE \data_p1_reg[21] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[21]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [21]),
        .R(1'b0));
  FDRE \data_p1_reg[22] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[22]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [22]),
        .R(1'b0));
  FDRE \data_p1_reg[23] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[23]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [23]),
        .R(1'b0));
  FDRE \data_p1_reg[24] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[24]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [24]),
        .R(1'b0));
  FDRE \data_p1_reg[25] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[25]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [25]),
        .R(1'b0));
  FDRE \data_p1_reg[26] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[26]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [26]),
        .R(1'b0));
  FDRE \data_p1_reg[27] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[27]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [27]),
        .R(1'b0));
  FDRE \data_p1_reg[28] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[28]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [28]),
        .R(1'b0));
  FDRE \data_p1_reg[29] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[29]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [29]),
        .R(1'b0));
  FDRE \data_p1_reg[2] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[2]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [2]),
        .R(1'b0));
  FDRE \data_p1_reg[30] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[30]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [30]),
        .R(1'b0));
  FDRE \data_p1_reg[31] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[31]_i_1__0_n_0 ),
        .Q(\data_p1_reg[61]_0 [31]),
        .R(1'b0));
  FDRE \data_p1_reg[32] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[32]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [32]),
        .R(1'b0));
  FDRE \data_p1_reg[33] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[33]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [33]),
        .R(1'b0));
  FDRE \data_p1_reg[34] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[34]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [34]),
        .R(1'b0));
  FDRE \data_p1_reg[35] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[35]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [35]),
        .R(1'b0));
  FDRE \data_p1_reg[36] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[36]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [36]),
        .R(1'b0));
  FDRE \data_p1_reg[37] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[37]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [37]),
        .R(1'b0));
  FDRE \data_p1_reg[38] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[38]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [38]),
        .R(1'b0));
  FDRE \data_p1_reg[39] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[39]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [39]),
        .R(1'b0));
  FDRE \data_p1_reg[3] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[3]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [3]),
        .R(1'b0));
  FDRE \data_p1_reg[40] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[40]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [40]),
        .R(1'b0));
  FDRE \data_p1_reg[41] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[41]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [41]),
        .R(1'b0));
  FDRE \data_p1_reg[42] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[42]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [42]),
        .R(1'b0));
  FDRE \data_p1_reg[43] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[43]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [43]),
        .R(1'b0));
  FDRE \data_p1_reg[44] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[44]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [44]),
        .R(1'b0));
  FDRE \data_p1_reg[45] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[45]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [45]),
        .R(1'b0));
  FDRE \data_p1_reg[46] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[46]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [46]),
        .R(1'b0));
  FDRE \data_p1_reg[47] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[47]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [47]),
        .R(1'b0));
  FDRE \data_p1_reg[48] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[48]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [48]),
        .R(1'b0));
  FDRE \data_p1_reg[49] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[49]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [49]),
        .R(1'b0));
  FDRE \data_p1_reg[4] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[4]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [4]),
        .R(1'b0));
  FDRE \data_p1_reg[50] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[50]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [50]),
        .R(1'b0));
  FDRE \data_p1_reg[51] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[51]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [51]),
        .R(1'b0));
  FDRE \data_p1_reg[52] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[52]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [52]),
        .R(1'b0));
  FDRE \data_p1_reg[53] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[53]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [53]),
        .R(1'b0));
  FDRE \data_p1_reg[54] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[54]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [54]),
        .R(1'b0));
  FDRE \data_p1_reg[55] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[55]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [55]),
        .R(1'b0));
  FDRE \data_p1_reg[56] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[56]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [56]),
        .R(1'b0));
  FDRE \data_p1_reg[57] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[57]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [57]),
        .R(1'b0));
  FDRE \data_p1_reg[58] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[58]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [58]),
        .R(1'b0));
  FDRE \data_p1_reg[59] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[59]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [59]),
        .R(1'b0));
  FDRE \data_p1_reg[5] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[5]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [5]),
        .R(1'b0));
  FDRE \data_p1_reg[60] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[60]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [60]),
        .R(1'b0));
  FDRE \data_p1_reg[61] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[61]_i_2_n_0 ),
        .Q(\data_p1_reg[61]_0 [61]),
        .R(1'b0));
  FDRE \data_p1_reg[6] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[6]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [6]),
        .R(1'b0));
  FDRE \data_p1_reg[7] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[7]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [7]),
        .R(1'b0));
  FDRE \data_p1_reg[8] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[8]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [8]),
        .R(1'b0));
  FDRE \data_p1_reg[9] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[9]_i_1_n_0 ),
        .Q(\data_p1_reg[61]_0 [9]),
        .R(1'b0));
  FDRE \data_p2_reg[0] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [0]),
        .Q(data_p2[0]),
        .R(1'b0));
  FDRE \data_p2_reg[10] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [10]),
        .Q(data_p2[10]),
        .R(1'b0));
  FDRE \data_p2_reg[11] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [11]),
        .Q(data_p2[11]),
        .R(1'b0));
  FDRE \data_p2_reg[12] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [12]),
        .Q(data_p2[12]),
        .R(1'b0));
  FDRE \data_p2_reg[13] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [13]),
        .Q(data_p2[13]),
        .R(1'b0));
  FDRE \data_p2_reg[14] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [14]),
        .Q(data_p2[14]),
        .R(1'b0));
  FDRE \data_p2_reg[15] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [15]),
        .Q(data_p2[15]),
        .R(1'b0));
  FDRE \data_p2_reg[16] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [16]),
        .Q(data_p2[16]),
        .R(1'b0));
  FDRE \data_p2_reg[17] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [17]),
        .Q(data_p2[17]),
        .R(1'b0));
  FDRE \data_p2_reg[18] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [18]),
        .Q(data_p2[18]),
        .R(1'b0));
  FDRE \data_p2_reg[19] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [19]),
        .Q(data_p2[19]),
        .R(1'b0));
  FDRE \data_p2_reg[1] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [1]),
        .Q(data_p2[1]),
        .R(1'b0));
  FDRE \data_p2_reg[20] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [20]),
        .Q(data_p2[20]),
        .R(1'b0));
  FDRE \data_p2_reg[21] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [21]),
        .Q(data_p2[21]),
        .R(1'b0));
  FDRE \data_p2_reg[22] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [22]),
        .Q(data_p2[22]),
        .R(1'b0));
  FDRE \data_p2_reg[23] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [23]),
        .Q(data_p2[23]),
        .R(1'b0));
  FDRE \data_p2_reg[24] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [24]),
        .Q(data_p2[24]),
        .R(1'b0));
  FDRE \data_p2_reg[25] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [25]),
        .Q(data_p2[25]),
        .R(1'b0));
  FDRE \data_p2_reg[26] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [26]),
        .Q(data_p2[26]),
        .R(1'b0));
  FDRE \data_p2_reg[27] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [27]),
        .Q(data_p2[27]),
        .R(1'b0));
  FDRE \data_p2_reg[28] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [28]),
        .Q(data_p2[28]),
        .R(1'b0));
  FDRE \data_p2_reg[29] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [29]),
        .Q(data_p2[29]),
        .R(1'b0));
  FDRE \data_p2_reg[2] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [2]),
        .Q(data_p2[2]),
        .R(1'b0));
  FDRE \data_p2_reg[30] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [30]),
        .Q(data_p2[30]),
        .R(1'b0));
  FDRE \data_p2_reg[31] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [31]),
        .Q(data_p2[31]),
        .R(1'b0));
  FDRE \data_p2_reg[32] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [32]),
        .Q(data_p2[32]),
        .R(1'b0));
  FDRE \data_p2_reg[33] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [33]),
        .Q(data_p2[33]),
        .R(1'b0));
  FDRE \data_p2_reg[34] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [34]),
        .Q(data_p2[34]),
        .R(1'b0));
  FDRE \data_p2_reg[35] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [35]),
        .Q(data_p2[35]),
        .R(1'b0));
  FDRE \data_p2_reg[36] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [36]),
        .Q(data_p2[36]),
        .R(1'b0));
  FDRE \data_p2_reg[37] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [37]),
        .Q(data_p2[37]),
        .R(1'b0));
  FDRE \data_p2_reg[38] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [38]),
        .Q(data_p2[38]),
        .R(1'b0));
  FDRE \data_p2_reg[39] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [39]),
        .Q(data_p2[39]),
        .R(1'b0));
  FDRE \data_p2_reg[3] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [3]),
        .Q(data_p2[3]),
        .R(1'b0));
  FDRE \data_p2_reg[40] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [40]),
        .Q(data_p2[40]),
        .R(1'b0));
  FDRE \data_p2_reg[41] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [41]),
        .Q(data_p2[41]),
        .R(1'b0));
  FDRE \data_p2_reg[42] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [42]),
        .Q(data_p2[42]),
        .R(1'b0));
  FDRE \data_p2_reg[43] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [43]),
        .Q(data_p2[43]),
        .R(1'b0));
  FDRE \data_p2_reg[44] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [44]),
        .Q(data_p2[44]),
        .R(1'b0));
  FDRE \data_p2_reg[45] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [45]),
        .Q(data_p2[45]),
        .R(1'b0));
  FDRE \data_p2_reg[46] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [46]),
        .Q(data_p2[46]),
        .R(1'b0));
  FDRE \data_p2_reg[47] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [47]),
        .Q(data_p2[47]),
        .R(1'b0));
  FDRE \data_p2_reg[48] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [48]),
        .Q(data_p2[48]),
        .R(1'b0));
  FDRE \data_p2_reg[49] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [49]),
        .Q(data_p2[49]),
        .R(1'b0));
  FDRE \data_p2_reg[4] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [4]),
        .Q(data_p2[4]),
        .R(1'b0));
  FDRE \data_p2_reg[50] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [50]),
        .Q(data_p2[50]),
        .R(1'b0));
  FDRE \data_p2_reg[51] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [51]),
        .Q(data_p2[51]),
        .R(1'b0));
  FDRE \data_p2_reg[52] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [52]),
        .Q(data_p2[52]),
        .R(1'b0));
  FDRE \data_p2_reg[53] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [53]),
        .Q(data_p2[53]),
        .R(1'b0));
  FDRE \data_p2_reg[54] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [54]),
        .Q(data_p2[54]),
        .R(1'b0));
  FDRE \data_p2_reg[55] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [55]),
        .Q(data_p2[55]),
        .R(1'b0));
  FDRE \data_p2_reg[56] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [56]),
        .Q(data_p2[56]),
        .R(1'b0));
  FDRE \data_p2_reg[57] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [57]),
        .Q(data_p2[57]),
        .R(1'b0));
  FDRE \data_p2_reg[58] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [58]),
        .Q(data_p2[58]),
        .R(1'b0));
  FDRE \data_p2_reg[59] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [59]),
        .Q(data_p2[59]),
        .R(1'b0));
  FDRE \data_p2_reg[5] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [5]),
        .Q(data_p2[5]),
        .R(1'b0));
  FDRE \data_p2_reg[60] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [60]),
        .Q(data_p2[60]),
        .R(1'b0));
  FDRE \data_p2_reg[61] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [61]),
        .Q(data_p2[61]),
        .R(1'b0));
  FDRE \data_p2_reg[6] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [6]),
        .Q(data_p2[6]),
        .R(1'b0));
  FDRE \data_p2_reg[7] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [7]),
        .Q(data_p2[7]),
        .R(1'b0));
  FDRE \data_p2_reg[8] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [8]),
        .Q(data_p2[8]),
        .R(1'b0));
  FDRE \data_p2_reg[9] 
       (.C(ap_clk),
        .CE(E),
        .D(\data_p2_reg[61]_0 [9]),
        .Q(data_p2[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \mem_reg[4][0]_srl5_i_1 
       (.I0(rs2f_rreq_valid),
        .I1(rs2f_rreq_ack),
        .O(push));
  LUT2 #(
    .INIT(4'h8)) 
    \opeout_1_data_reg[31]_i_1 
       (.I0(Q[1]),
        .I1(ram_ARREADY),
        .O(E));
  LUT5 #(
    .INIT(32'hF5F5D1F1)) 
    s_ready_t_i_1
       (.I0(state__0[1]),
        .I1(state__0[0]),
        .I2(ram_ARREADY),
        .I3(Q[1]),
        .I4(rs2f_rreq_ack),
        .O(s_ready_t_i_1_n_0));
  FDRE s_ready_t_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(s_ready_t_i_1_n_0),
        .Q(ram_ARREADY),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT5 #(
    .INIT(32'h8FFF8800)) 
    \state[0]_i_1 
       (.I0(Q[1]),
        .I1(ram_ARREADY),
        .I2(rs2f_rreq_ack),
        .I3(state),
        .I4(rs2f_rreq_valid),
        .O(\state[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFF70FF)) 
    \state[1]_i_1 
       (.I0(Q[1]),
        .I1(ram_ARREADY),
        .I2(state),
        .I3(rs2f_rreq_valid),
        .I4(rs2f_rreq_ack),
        .O(\state[1]_i_1_n_0 ));
  FDRE \state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\state[0]_i_1_n_0 ),
        .Q(rs2f_rreq_valid),
        .R(SR));
  FDSE \state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\state[1]_i_1_n_0 ),
        .Q(state),
        .S(SR));
endmodule

(* ORIG_REF_NAME = "sound_operation_ram_m_axi_reg_slice" *) 
module design_1_sound_operation_0_7_sound_operation_ram_m_axi_reg_slice__parameterized0
   (rdata_ack_t,
    E,
    ap_NS_fsm,
    \data_p1_reg[31]_0 ,
    SR,
    ap_clk,
    s_ready_t_reg_0,
    beat_valid,
    Q,
    \data_p2_reg[31]_0 );
  output rdata_ack_t;
  output [0:0]E;
  output [1:0]ap_NS_fsm;
  output [31:0]\data_p1_reg[31]_0 ;
  input [0:0]SR;
  input ap_clk;
  input s_ready_t_reg_0;
  input beat_valid;
  input [1:0]Q;
  input [31:0]\data_p2_reg[31]_0 ;

  wire [0:0]E;
  wire [1:0]Q;
  wire [0:0]SR;
  wire [1:0]ap_NS_fsm;
  wire ap_clk;
  wire beat_valid;
  wire \data_p1[0]_i_1__0_n_0 ;
  wire \data_p1[10]_i_1__0_n_0 ;
  wire \data_p1[11]_i_1__0_n_0 ;
  wire \data_p1[12]_i_1__0_n_0 ;
  wire \data_p1[13]_i_1__0_n_0 ;
  wire \data_p1[14]_i_1__0_n_0 ;
  wire \data_p1[15]_i_1__0_n_0 ;
  wire \data_p1[16]_i_1__0_n_0 ;
  wire \data_p1[17]_i_1__0_n_0 ;
  wire \data_p1[18]_i_1__0_n_0 ;
  wire \data_p1[19]_i_1__0_n_0 ;
  wire \data_p1[1]_i_1__0_n_0 ;
  wire \data_p1[20]_i_1__0_n_0 ;
  wire \data_p1[21]_i_1__0_n_0 ;
  wire \data_p1[22]_i_1__0_n_0 ;
  wire \data_p1[23]_i_1__0_n_0 ;
  wire \data_p1[24]_i_1__0_n_0 ;
  wire \data_p1[25]_i_1__0_n_0 ;
  wire \data_p1[26]_i_1__0_n_0 ;
  wire \data_p1[27]_i_1__0_n_0 ;
  wire \data_p1[28]_i_1__0_n_0 ;
  wire \data_p1[29]_i_1__0_n_0 ;
  wire \data_p1[2]_i_1__0_n_0 ;
  wire \data_p1[30]_i_1__0_n_0 ;
  wire \data_p1[31]_i_2_n_0 ;
  wire \data_p1[3]_i_1__0_n_0 ;
  wire \data_p1[4]_i_1__0_n_0 ;
  wire \data_p1[5]_i_1__0_n_0 ;
  wire \data_p1[6]_i_1__0_n_0 ;
  wire \data_p1[7]_i_1__0_n_0 ;
  wire \data_p1[8]_i_1__0_n_0 ;
  wire \data_p1[9]_i_1__0_n_0 ;
  wire [31:0]\data_p1_reg[31]_0 ;
  wire [31:0]\data_p2_reg[31]_0 ;
  wire \data_p2_reg_n_0_[0] ;
  wire \data_p2_reg_n_0_[10] ;
  wire \data_p2_reg_n_0_[11] ;
  wire \data_p2_reg_n_0_[12] ;
  wire \data_p2_reg_n_0_[13] ;
  wire \data_p2_reg_n_0_[14] ;
  wire \data_p2_reg_n_0_[15] ;
  wire \data_p2_reg_n_0_[16] ;
  wire \data_p2_reg_n_0_[17] ;
  wire \data_p2_reg_n_0_[18] ;
  wire \data_p2_reg_n_0_[19] ;
  wire \data_p2_reg_n_0_[1] ;
  wire \data_p2_reg_n_0_[20] ;
  wire \data_p2_reg_n_0_[21] ;
  wire \data_p2_reg_n_0_[22] ;
  wire \data_p2_reg_n_0_[23] ;
  wire \data_p2_reg_n_0_[24] ;
  wire \data_p2_reg_n_0_[25] ;
  wire \data_p2_reg_n_0_[26] ;
  wire \data_p2_reg_n_0_[27] ;
  wire \data_p2_reg_n_0_[28] ;
  wire \data_p2_reg_n_0_[29] ;
  wire \data_p2_reg_n_0_[2] ;
  wire \data_p2_reg_n_0_[30] ;
  wire \data_p2_reg_n_0_[31] ;
  wire \data_p2_reg_n_0_[3] ;
  wire \data_p2_reg_n_0_[4] ;
  wire \data_p2_reg_n_0_[5] ;
  wire \data_p2_reg_n_0_[6] ;
  wire \data_p2_reg_n_0_[7] ;
  wire \data_p2_reg_n_0_[8] ;
  wire \data_p2_reg_n_0_[9] ;
  wire load_p1;
  wire load_p2;
  wire [1:0]next__0;
  wire ram_RVALID;
  wire rdata_ack_t;
  wire s_ready_t_i_1__0_n_0;
  wire s_ready_t_reg_0;
  wire [1:1]state;
  wire \state[0]_i_1__0_n_0 ;
  wire \state[1]_i_1__0_n_0 ;
  wire [1:0]state__0;

  LUT5 #(
    .INIT(32'h002A3F00)) 
    \FSM_sequential_state[0]_i_1__0 
       (.I0(s_ready_t_reg_0),
        .I1(Q[1]),
        .I2(ram_RVALID),
        .I3(state__0[0]),
        .I4(state__0[1]),
        .O(next__0[0]));
  LUT6 #(
    .INIT(64'h0000F000C3338888)) 
    \FSM_sequential_state[1]_i_1__0 
       (.I0(rdata_ack_t),
        .I1(s_ready_t_reg_0),
        .I2(ram_RVALID),
        .I3(Q[1]),
        .I4(state__0[1]),
        .I5(state__0[0]),
        .O(next__0[1]));
  (* FSM_ENCODED_STATES = "ZERO:00,TWO:01,ONE:10" *) 
  FDRE \FSM_sequential_state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(next__0[0]),
        .Q(state__0[0]),
        .R(SR));
  (* FSM_ENCODED_STATES = "ZERO:00,TWO:01,ONE:10" *) 
  FDRE \FSM_sequential_state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(next__0[1]),
        .Q(state__0[1]),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \ap_CS_fsm[9]_i_1 
       (.I0(Q[0]),
        .I1(ram_RVALID),
        .I2(Q[1]),
        .O(ap_NS_fsm[0]));
  LUT3 #(
    .INIT(8'hB0)) 
    \bus_equal_gen.data_buf[31]_i_1 
       (.I0(rdata_ack_t),
        .I1(s_ready_t_reg_0),
        .I2(beat_valid),
        .O(E));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[0]_i_1__0 
       (.I0(\data_p2_reg_n_0_[0] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [0]),
        .O(\data_p1[0]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[10]_i_1__0 
       (.I0(\data_p2_reg_n_0_[10] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [10]),
        .O(\data_p1[10]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[11]_i_1__0 
       (.I0(\data_p2_reg_n_0_[11] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [11]),
        .O(\data_p1[11]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[12]_i_1__0 
       (.I0(\data_p2_reg_n_0_[12] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [12]),
        .O(\data_p1[12]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[13]_i_1__0 
       (.I0(\data_p2_reg_n_0_[13] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [13]),
        .O(\data_p1[13]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[14]_i_1__0 
       (.I0(\data_p2_reg_n_0_[14] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [14]),
        .O(\data_p1[14]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[15]_i_1__0 
       (.I0(\data_p2_reg_n_0_[15] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [15]),
        .O(\data_p1[15]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[16]_i_1__0 
       (.I0(\data_p2_reg_n_0_[16] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [16]),
        .O(\data_p1[16]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[17]_i_1__0 
       (.I0(\data_p2_reg_n_0_[17] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [17]),
        .O(\data_p1[17]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[18]_i_1__0 
       (.I0(\data_p2_reg_n_0_[18] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [18]),
        .O(\data_p1[18]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[19]_i_1__0 
       (.I0(\data_p2_reg_n_0_[19] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [19]),
        .O(\data_p1[19]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[1]_i_1__0 
       (.I0(\data_p2_reg_n_0_[1] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [1]),
        .O(\data_p1[1]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[20]_i_1__0 
       (.I0(\data_p2_reg_n_0_[20] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [20]),
        .O(\data_p1[20]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[21]_i_1__0 
       (.I0(\data_p2_reg_n_0_[21] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [21]),
        .O(\data_p1[21]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[22]_i_1__0 
       (.I0(\data_p2_reg_n_0_[22] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [22]),
        .O(\data_p1[22]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[23]_i_1__0 
       (.I0(\data_p2_reg_n_0_[23] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [23]),
        .O(\data_p1[23]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[24]_i_1__0 
       (.I0(\data_p2_reg_n_0_[24] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [24]),
        .O(\data_p1[24]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[25]_i_1__0 
       (.I0(\data_p2_reg_n_0_[25] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [25]),
        .O(\data_p1[25]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[26]_i_1__0 
       (.I0(\data_p2_reg_n_0_[26] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [26]),
        .O(\data_p1[26]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[27]_i_1__0 
       (.I0(\data_p2_reg_n_0_[27] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [27]),
        .O(\data_p1[27]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[28]_i_1__0 
       (.I0(\data_p2_reg_n_0_[28] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [28]),
        .O(\data_p1[28]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[29]_i_1__0 
       (.I0(\data_p2_reg_n_0_[29] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [29]),
        .O(\data_p1[29]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[2]_i_1__0 
       (.I0(\data_p2_reg_n_0_[2] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [2]),
        .O(\data_p1[2]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[30]_i_1__0 
       (.I0(\data_p2_reg_n_0_[30] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [30]),
        .O(\data_p1[30]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'h3000A222)) 
    \data_p1[31]_i_1 
       (.I0(s_ready_t_reg_0),
        .I1(state__0[1]),
        .I2(Q[1]),
        .I3(ram_RVALID),
        .I4(state__0[0]),
        .O(load_p1));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[31]_i_2 
       (.I0(\data_p2_reg_n_0_[31] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [31]),
        .O(\data_p1[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[3]_i_1__0 
       (.I0(\data_p2_reg_n_0_[3] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [3]),
        .O(\data_p1[3]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[4]_i_1__0 
       (.I0(\data_p2_reg_n_0_[4] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [4]),
        .O(\data_p1[4]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[5]_i_1__0 
       (.I0(\data_p2_reg_n_0_[5] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [5]),
        .O(\data_p1[5]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[6]_i_1__0 
       (.I0(\data_p2_reg_n_0_[6] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [6]),
        .O(\data_p1[6]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[7]_i_1__0 
       (.I0(\data_p2_reg_n_0_[7] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [7]),
        .O(\data_p1[7]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[8]_i_1__0 
       (.I0(\data_p2_reg_n_0_[8] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [8]),
        .O(\data_p1[8]_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hFB08)) 
    \data_p1[9]_i_1__0 
       (.I0(\data_p2_reg_n_0_[9] ),
        .I1(state__0[0]),
        .I2(state__0[1]),
        .I3(\data_p2_reg[31]_0 [9]),
        .O(\data_p1[9]_i_1__0_n_0 ));
  FDRE \data_p1_reg[0] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[0]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [0]),
        .R(1'b0));
  FDRE \data_p1_reg[10] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[10]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [10]),
        .R(1'b0));
  FDRE \data_p1_reg[11] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[11]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [11]),
        .R(1'b0));
  FDRE \data_p1_reg[12] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[12]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [12]),
        .R(1'b0));
  FDRE \data_p1_reg[13] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[13]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [13]),
        .R(1'b0));
  FDRE \data_p1_reg[14] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[14]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [14]),
        .R(1'b0));
  FDRE \data_p1_reg[15] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[15]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [15]),
        .R(1'b0));
  FDRE \data_p1_reg[16] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[16]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [16]),
        .R(1'b0));
  FDRE \data_p1_reg[17] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[17]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [17]),
        .R(1'b0));
  FDRE \data_p1_reg[18] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[18]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [18]),
        .R(1'b0));
  FDRE \data_p1_reg[19] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[19]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [19]),
        .R(1'b0));
  FDRE \data_p1_reg[1] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[1]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [1]),
        .R(1'b0));
  FDRE \data_p1_reg[20] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[20]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [20]),
        .R(1'b0));
  FDRE \data_p1_reg[21] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[21]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [21]),
        .R(1'b0));
  FDRE \data_p1_reg[22] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[22]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [22]),
        .R(1'b0));
  FDRE \data_p1_reg[23] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[23]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [23]),
        .R(1'b0));
  FDRE \data_p1_reg[24] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[24]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [24]),
        .R(1'b0));
  FDRE \data_p1_reg[25] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[25]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [25]),
        .R(1'b0));
  FDRE \data_p1_reg[26] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[26]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [26]),
        .R(1'b0));
  FDRE \data_p1_reg[27] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[27]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [27]),
        .R(1'b0));
  FDRE \data_p1_reg[28] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[28]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [28]),
        .R(1'b0));
  FDRE \data_p1_reg[29] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[29]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [29]),
        .R(1'b0));
  FDRE \data_p1_reg[2] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[2]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [2]),
        .R(1'b0));
  FDRE \data_p1_reg[30] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[30]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [30]),
        .R(1'b0));
  FDRE \data_p1_reg[31] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[31]_i_2_n_0 ),
        .Q(\data_p1_reg[31]_0 [31]),
        .R(1'b0));
  FDRE \data_p1_reg[3] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[3]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [3]),
        .R(1'b0));
  FDRE \data_p1_reg[4] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[4]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [4]),
        .R(1'b0));
  FDRE \data_p1_reg[5] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[5]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [5]),
        .R(1'b0));
  FDRE \data_p1_reg[6] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[6]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [6]),
        .R(1'b0));
  FDRE \data_p1_reg[7] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[7]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [7]),
        .R(1'b0));
  FDRE \data_p1_reg[8] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[8]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [8]),
        .R(1'b0));
  FDRE \data_p1_reg[9] 
       (.C(ap_clk),
        .CE(load_p1),
        .D(\data_p1[9]_i_1__0_n_0 ),
        .Q(\data_p1_reg[31]_0 [9]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    \data_p2[31]_i_1 
       (.I0(s_ready_t_reg_0),
        .I1(rdata_ack_t),
        .O(load_p2));
  FDRE \data_p2_reg[0] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [0]),
        .Q(\data_p2_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \data_p2_reg[10] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [10]),
        .Q(\data_p2_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \data_p2_reg[11] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [11]),
        .Q(\data_p2_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \data_p2_reg[12] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [12]),
        .Q(\data_p2_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \data_p2_reg[13] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [13]),
        .Q(\data_p2_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \data_p2_reg[14] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [14]),
        .Q(\data_p2_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \data_p2_reg[15] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [15]),
        .Q(\data_p2_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \data_p2_reg[16] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [16]),
        .Q(\data_p2_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \data_p2_reg[17] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [17]),
        .Q(\data_p2_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \data_p2_reg[18] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [18]),
        .Q(\data_p2_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \data_p2_reg[19] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [19]),
        .Q(\data_p2_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \data_p2_reg[1] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [1]),
        .Q(\data_p2_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \data_p2_reg[20] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [20]),
        .Q(\data_p2_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \data_p2_reg[21] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [21]),
        .Q(\data_p2_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \data_p2_reg[22] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [22]),
        .Q(\data_p2_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \data_p2_reg[23] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [23]),
        .Q(\data_p2_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \data_p2_reg[24] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [24]),
        .Q(\data_p2_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \data_p2_reg[25] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [25]),
        .Q(\data_p2_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \data_p2_reg[26] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [26]),
        .Q(\data_p2_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \data_p2_reg[27] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [27]),
        .Q(\data_p2_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \data_p2_reg[28] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [28]),
        .Q(\data_p2_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \data_p2_reg[29] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [29]),
        .Q(\data_p2_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \data_p2_reg[2] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [2]),
        .Q(\data_p2_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \data_p2_reg[30] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [30]),
        .Q(\data_p2_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \data_p2_reg[31] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [31]),
        .Q(\data_p2_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \data_p2_reg[3] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [3]),
        .Q(\data_p2_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \data_p2_reg[4] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [4]),
        .Q(\data_p2_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \data_p2_reg[5] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [5]),
        .Q(\data_p2_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \data_p2_reg[6] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [6]),
        .Q(\data_p2_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \data_p2_reg[7] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [7]),
        .Q(\data_p2_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \data_p2_reg[8] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [8]),
        .Q(\data_p2_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \data_p2_reg[9] 
       (.C(ap_clk),
        .CE(load_p2),
        .D(\data_p2_reg[31]_0 [9]),
        .Q(\data_p2_reg_n_0_[9] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFBFBFBF0F050505)) 
    s_ready_t_i_1__0
       (.I0(state__0[0]),
        .I1(s_ready_t_reg_0),
        .I2(state__0[1]),
        .I3(ram_RVALID),
        .I4(Q[1]),
        .I5(rdata_ack_t),
        .O(s_ready_t_i_1__0_n_0));
  FDRE s_ready_t_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(s_ready_t_i_1__0_n_0),
        .Q(rdata_ack_t),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \sdata_1_data_reg[31]_i_1 
       (.I0(Q[1]),
        .I1(ram_RVALID),
        .O(ap_NS_fsm[1]));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT5 #(
    .INIT(32'hEE0CCCCC)) 
    \state[0]_i_1__0 
       (.I0(rdata_ack_t),
        .I1(ram_RVALID),
        .I2(Q[1]),
        .I3(s_ready_t_reg_0),
        .I4(state),
        .O(\state[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT4 #(
    .INIT(16'hFF4F)) 
    \state[1]_i_1__0 
       (.I0(s_ready_t_reg_0),
        .I1(state),
        .I2(ram_RVALID),
        .I3(Q[1]),
        .O(\state[1]_i_1__0_n_0 ));
  FDRE \state_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\state[0]_i_1__0_n_0 ),
        .Q(ram_RVALID),
        .R(SR));
  FDSE \state_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\state[1]_i_1__0_n_0 ),
        .Q(state),
        .S(SR));
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
