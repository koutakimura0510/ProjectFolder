// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sun Apr  4 18:16:08 2021
// Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd_vivado/muladd.gen/sources_1/bd/design_1/ip/design_1_muladd_0_0/design_1_muladd_0_0_sim_netlist.v
// Design      : design_1_muladd_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_muladd_0_0,muladd,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "HLS" *) 
(* X_CORE_INFO = "muladd,Vivado 2020.2" *) (* hls_module = "yes" *) 
(* NotValidForBitStream *)
module design_1_muladd_0_0
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
    interrupt);
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR" *) input [7:0]s_axi_control_AWADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID" *) input s_axi_control_AWVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY" *) output s_axi_control_AWREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WDATA" *) input [31:0]s_axi_control_WDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB" *) input [3:0]s_axi_control_WSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WVALID" *) input s_axi_control_WVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control WREADY" *) output s_axi_control_WREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BRESP" *) output [1:0]s_axi_control_BRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BVALID" *) output s_axi_control_BVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control BREADY" *) input s_axi_control_BREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR" *) input [7:0]s_axi_control_ARADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID" *) input s_axi_control_ARVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY" *) output s_axi_control_ARREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RDATA" *) output [31:0]s_axi_control_RDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RRESP" *) output [1:0]s_axi_control_RRESP;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RVALID" *) output s_axi_control_RVALID;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_control RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 8, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s_axi_control_RREADY;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input ap_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input ap_rst_n;
  (* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output interrupt;

  wire \<const0> ;
  wire ap_clk;
  wire ap_rst_n;
  wire interrupt;
  wire [7:0]s_axi_control_ARADDR;
  wire s_axi_control_ARREADY;
  wire s_axi_control_ARVALID;
  wire [7:0]s_axi_control_AWADDR;
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
  wire [1:0]NLW_inst_s_axi_control_BRESP_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_control_RRESP_UNCONNECTED;

  assign s_axi_control_BRESP[1] = \<const0> ;
  assign s_axi_control_BRESP[0] = \<const0> ;
  assign s_axi_control_RRESP[1] = \<const0> ;
  assign s_axi_control_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_S_AXI_CONTROL_ADDR_WIDTH = "8" *) 
  (* C_S_AXI_CONTROL_DATA_WIDTH = "32" *) 
  (* C_S_AXI_CONTROL_WSTRB_WIDTH = "4" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_WSTRB_WIDTH = "4" *) 
  (* SDX_KERNEL = "true" *) 
  (* SDX_KERNEL_SYNTH_INST = "inst" *) 
  (* SDX_KERNEL_TYPE = "hls" *) 
  (* ap_ST_fsm_pp0_stage0 = "3'b010" *) 
  (* ap_ST_fsm_state1 = "3'b001" *) 
  (* ap_ST_fsm_state7 = "3'b100" *) 
  design_1_muladd_0_0_muladd inst
       (.ap_clk(ap_clk),
        .ap_rst_n(ap_rst_n),
        .interrupt(interrupt),
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
        .s_axi_control_WVALID(s_axi_control_WVALID));
endmodule

(* C_S_AXI_CONTROL_ADDR_WIDTH = "8" *) (* C_S_AXI_CONTROL_DATA_WIDTH = "32" *) (* C_S_AXI_CONTROL_WSTRB_WIDTH = "4" *) 
(* C_S_AXI_DATA_WIDTH = "32" *) (* C_S_AXI_WSTRB_WIDTH = "4" *) (* ORIG_REF_NAME = "muladd" *) 
(* ap_ST_fsm_pp0_stage0 = "3'b010" *) (* ap_ST_fsm_state1 = "3'b001" *) (* ap_ST_fsm_state7 = "3'b100" *) 
(* hls_module = "yes" *) 
module design_1_muladd_0_0_muladd
   (ap_clk,
    ap_rst_n,
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
    s_axi_control_BRESP,
    interrupt);
  input ap_clk;
  input ap_rst_n;
  input s_axi_control_AWVALID;
  output s_axi_control_AWREADY;
  input [7:0]s_axi_control_AWADDR;
  input s_axi_control_WVALID;
  output s_axi_control_WREADY;
  input [31:0]s_axi_control_WDATA;
  input [3:0]s_axi_control_WSTRB;
  input s_axi_control_ARVALID;
  output s_axi_control_ARREADY;
  input [7:0]s_axi_control_ARADDR;
  output s_axi_control_RVALID;
  input s_axi_control_RREADY;
  output [31:0]s_axi_control_RDATA;
  output [1:0]s_axi_control_RRESP;
  output s_axi_control_BVALID;
  input s_axi_control_BREADY;
  output [1:0]s_axi_control_BRESP;
  output interrupt;

  wire \<const0> ;
  wire a_ce0;
  wire [31:0]a_q0;
  wire [4:0]add_ln7_fu_105_p2;
  wire ap_CS_fsm_pp0_stage0;
  wire \ap_CS_fsm_reg_n_0_[0] ;
  wire ap_CS_fsm_state7;
  wire [2:1]ap_NS_fsm;
  wire ap_NS_fsm1;
  wire ap_clk;
  wire ap_enable_reg_pp0_iter0;
  wire ap_enable_reg_pp0_iter1;
  wire ap_enable_reg_pp0_iter2;
  wire ap_enable_reg_pp0_iter3;
  wire ap_enable_reg_pp0_iter4;
  wire ap_enable_reg_pp0_iter4_i_1_n_0;
  wire ap_rst_n;
  wire ap_rst_n_inv;
  wire [31:0]b_q0;
  wire control_s_axi_U_n_0;
  wire control_s_axi_U_n_1;
  wire control_s_axi_U_n_10;
  wire control_s_axi_U_n_100;
  wire control_s_axi_U_n_101;
  wire control_s_axi_U_n_102;
  wire control_s_axi_U_n_103;
  wire control_s_axi_U_n_104;
  wire control_s_axi_U_n_105;
  wire control_s_axi_U_n_106;
  wire control_s_axi_U_n_107;
  wire control_s_axi_U_n_108;
  wire control_s_axi_U_n_109;
  wire control_s_axi_U_n_11;
  wire control_s_axi_U_n_110;
  wire control_s_axi_U_n_111;
  wire control_s_axi_U_n_112;
  wire control_s_axi_U_n_113;
  wire control_s_axi_U_n_114;
  wire control_s_axi_U_n_115;
  wire control_s_axi_U_n_116;
  wire control_s_axi_U_n_117;
  wire control_s_axi_U_n_118;
  wire control_s_axi_U_n_119;
  wire control_s_axi_U_n_12;
  wire control_s_axi_U_n_120;
  wire control_s_axi_U_n_121;
  wire control_s_axi_U_n_122;
  wire control_s_axi_U_n_123;
  wire control_s_axi_U_n_124;
  wire control_s_axi_U_n_125;
  wire control_s_axi_U_n_126;
  wire control_s_axi_U_n_127;
  wire control_s_axi_U_n_13;
  wire control_s_axi_U_n_14;
  wire control_s_axi_U_n_15;
  wire control_s_axi_U_n_16;
  wire control_s_axi_U_n_161;
  wire control_s_axi_U_n_163;
  wire control_s_axi_U_n_17;
  wire control_s_axi_U_n_18;
  wire control_s_axi_U_n_19;
  wire control_s_axi_U_n_2;
  wire control_s_axi_U_n_20;
  wire control_s_axi_U_n_202;
  wire control_s_axi_U_n_203;
  wire control_s_axi_U_n_21;
  wire control_s_axi_U_n_22;
  wire control_s_axi_U_n_23;
  wire control_s_axi_U_n_24;
  wire control_s_axi_U_n_25;
  wire control_s_axi_U_n_26;
  wire control_s_axi_U_n_27;
  wire control_s_axi_U_n_28;
  wire control_s_axi_U_n_29;
  wire control_s_axi_U_n_3;
  wire control_s_axi_U_n_30;
  wire control_s_axi_U_n_31;
  wire control_s_axi_U_n_32;
  wire control_s_axi_U_n_33;
  wire control_s_axi_U_n_34;
  wire control_s_axi_U_n_35;
  wire control_s_axi_U_n_36;
  wire control_s_axi_U_n_37;
  wire control_s_axi_U_n_38;
  wire control_s_axi_U_n_39;
  wire control_s_axi_U_n_4;
  wire control_s_axi_U_n_40;
  wire control_s_axi_U_n_41;
  wire control_s_axi_U_n_42;
  wire control_s_axi_U_n_43;
  wire control_s_axi_U_n_44;
  wire control_s_axi_U_n_45;
  wire control_s_axi_U_n_46;
  wire control_s_axi_U_n_47;
  wire control_s_axi_U_n_48;
  wire control_s_axi_U_n_49;
  wire control_s_axi_U_n_5;
  wire control_s_axi_U_n_50;
  wire control_s_axi_U_n_51;
  wire control_s_axi_U_n_52;
  wire control_s_axi_U_n_53;
  wire control_s_axi_U_n_54;
  wire control_s_axi_U_n_55;
  wire control_s_axi_U_n_56;
  wire control_s_axi_U_n_57;
  wire control_s_axi_U_n_58;
  wire control_s_axi_U_n_59;
  wire control_s_axi_U_n_6;
  wire control_s_axi_U_n_60;
  wire control_s_axi_U_n_61;
  wire control_s_axi_U_n_62;
  wire control_s_axi_U_n_63;
  wire control_s_axi_U_n_64;
  wire control_s_axi_U_n_65;
  wire control_s_axi_U_n_66;
  wire control_s_axi_U_n_67;
  wire control_s_axi_U_n_68;
  wire control_s_axi_U_n_69;
  wire control_s_axi_U_n_7;
  wire control_s_axi_U_n_70;
  wire control_s_axi_U_n_71;
  wire control_s_axi_U_n_72;
  wire control_s_axi_U_n_73;
  wire control_s_axi_U_n_74;
  wire control_s_axi_U_n_75;
  wire control_s_axi_U_n_76;
  wire control_s_axi_U_n_77;
  wire control_s_axi_U_n_78;
  wire control_s_axi_U_n_79;
  wire control_s_axi_U_n_8;
  wire control_s_axi_U_n_80;
  wire control_s_axi_U_n_81;
  wire control_s_axi_U_n_82;
  wire control_s_axi_U_n_83;
  wire control_s_axi_U_n_84;
  wire control_s_axi_U_n_85;
  wire control_s_axi_U_n_86;
  wire control_s_axi_U_n_87;
  wire control_s_axi_U_n_88;
  wire control_s_axi_U_n_89;
  wire control_s_axi_U_n_9;
  wire control_s_axi_U_n_90;
  wire control_s_axi_U_n_91;
  wire control_s_axi_U_n_92;
  wire control_s_axi_U_n_93;
  wire control_s_axi_U_n_94;
  wire control_s_axi_U_n_95;
  wire control_s_axi_U_n_96;
  wire control_s_axi_U_n_97;
  wire control_s_axi_U_n_98;
  wire control_s_axi_U_n_99;
  wire i_reg_820;
  wire [3:0]i_reg_82_reg;
  wire [4:4]i_reg_82_reg__0;
  wire icmp_ln7_fu_111_p2;
  wire icmp_ln7_reg_137;
  wire \icmp_ln7_reg_137[0]_i_1_n_0 ;
  wire icmp_ln7_reg_137_pp0_iter1_reg;
  wire \icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1_n_0 ;
  wire icmp_ln7_reg_137_pp0_iter2_reg;
  wire icmp_ln7_reg_137_pp0_iter3_reg;
  wire interrupt;
  wire mul_32s_32s_32_2_1_U1_n_16;
  wire mul_32s_32s_32_2_1_U1_n_17;
  wire mul_32s_32s_32_2_1_U1_n_18;
  wire mul_32s_32s_32_2_1_U1_n_19;
  wire mul_32s_32s_32_2_1_U1_n_20;
  wire mul_32s_32s_32_2_1_U1_n_21;
  wire mul_32s_32s_32_2_1_U1_n_22;
  wire mul_32s_32s_32_2_1_U1_n_23;
  wire mul_32s_32s_32_2_1_U1_n_24;
  wire mul_32s_32s_32_2_1_U1_n_25;
  wire mul_32s_32s_32_2_1_U1_n_26;
  wire mul_32s_32s_32_2_1_U1_n_27;
  wire mul_32s_32s_32_2_1_U1_n_28;
  wire mul_32s_32s_32_2_1_U1_n_29;
  wire mul_32s_32s_32_2_1_U1_n_30;
  wire mul_32s_32s_32_2_1_U1_n_31;
  wire [31:0]mul_ln9_reg_161;
  wire \mul_ln9_reg_161[31]_i_1_n_0 ;
  wire [31:16]\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 ;
  wire p_reg_i_16_n_0;
  wire p_reg_i_17_n_0;
  wire p_reg_i_18_n_0;
  wire p_reg_i_19_n_0;
  wire p_reg_i_20_n_0;
  wire p_reg_i_21_n_0;
  wire p_reg_i_22_n_0;
  wire p_reg_i_23_n_0;
  wire p_reg_i_24_n_0;
  wire p_reg_i_25_n_0;
  wire p_reg_i_26_n_0;
  wire p_reg_i_27_n_0;
  wire p_reg_i_28_n_0;
  wire p_reg_i_29_n_0;
  wire p_reg_i_30_n_0;
  wire \rdata_reg[0]_i_5_n_0 ;
  wire \rdata_reg[0]_i_6_n_0 ;
  wire \rdata_reg[10]_i_5_n_0 ;
  wire \rdata_reg[10]_i_6_n_0 ;
  wire \rdata_reg[11]_i_5_n_0 ;
  wire \rdata_reg[11]_i_6_n_0 ;
  wire \rdata_reg[12]_i_5_n_0 ;
  wire \rdata_reg[12]_i_6_n_0 ;
  wire \rdata_reg[13]_i_5_n_0 ;
  wire \rdata_reg[13]_i_6_n_0 ;
  wire \rdata_reg[14]_i_5_n_0 ;
  wire \rdata_reg[14]_i_6_n_0 ;
  wire \rdata_reg[15]_i_5_n_0 ;
  wire \rdata_reg[15]_i_6_n_0 ;
  wire \rdata_reg[16]_i_5_n_0 ;
  wire \rdata_reg[16]_i_6_n_0 ;
  wire \rdata_reg[17]_i_5_n_0 ;
  wire \rdata_reg[17]_i_6_n_0 ;
  wire \rdata_reg[18]_i_5_n_0 ;
  wire \rdata_reg[18]_i_6_n_0 ;
  wire \rdata_reg[19]_i_5_n_0 ;
  wire \rdata_reg[19]_i_6_n_0 ;
  wire \rdata_reg[1]_i_7_n_0 ;
  wire \rdata_reg[1]_i_8_n_0 ;
  wire \rdata_reg[20]_i_5_n_0 ;
  wire \rdata_reg[20]_i_6_n_0 ;
  wire \rdata_reg[21]_i_5_n_0 ;
  wire \rdata_reg[21]_i_6_n_0 ;
  wire \rdata_reg[22]_i_5_n_0 ;
  wire \rdata_reg[22]_i_6_n_0 ;
  wire \rdata_reg[23]_i_5_n_0 ;
  wire \rdata_reg[23]_i_6_n_0 ;
  wire \rdata_reg[24]_i_5_n_0 ;
  wire \rdata_reg[24]_i_6_n_0 ;
  wire \rdata_reg[25]_i_5_n_0 ;
  wire \rdata_reg[25]_i_6_n_0 ;
  wire \rdata_reg[26]_i_5_n_0 ;
  wire \rdata_reg[26]_i_6_n_0 ;
  wire \rdata_reg[27]_i_5_n_0 ;
  wire \rdata_reg[27]_i_6_n_0 ;
  wire \rdata_reg[28]_i_5_n_0 ;
  wire \rdata_reg[28]_i_6_n_0 ;
  wire \rdata_reg[29]_i_5_n_0 ;
  wire \rdata_reg[29]_i_6_n_0 ;
  wire \rdata_reg[2]_i_5_n_0 ;
  wire \rdata_reg[2]_i_6_n_0 ;
  wire \rdata_reg[30]_i_5_n_0 ;
  wire \rdata_reg[30]_i_6_n_0 ;
  wire \rdata_reg[31]_i_6_n_0 ;
  wire \rdata_reg[31]_i_7_n_0 ;
  wire \rdata_reg[31]_i_8_n_0 ;
  wire \rdata_reg[31]_i_9_n_0 ;
  wire \rdata_reg[3]_i_5_n_0 ;
  wire \rdata_reg[3]_i_6_n_0 ;
  wire \rdata_reg[4]_i_5_n_0 ;
  wire \rdata_reg[4]_i_6_n_0 ;
  wire \rdata_reg[5]_i_5_n_0 ;
  wire \rdata_reg[5]_i_6_n_0 ;
  wire \rdata_reg[6]_i_5_n_0 ;
  wire \rdata_reg[6]_i_6_n_0 ;
  wire \rdata_reg[7]_i_5_n_0 ;
  wire \rdata_reg[7]_i_6_n_0 ;
  wire \rdata_reg[8]_i_5_n_0 ;
  wire \rdata_reg[8]_i_6_n_0 ;
  wire \rdata_reg[9]_i_5_n_0 ;
  wire \rdata_reg[9]_i_6_n_0 ;
  wire [7:0]s_axi_control_ARADDR;
  wire s_axi_control_ARREADY;
  wire s_axi_control_ARVALID;
  wire [7:0]s_axi_control_AWADDR;
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
  wire temp_reg_930;
  wire \temp_reg_93[0]_i_4_n_0 ;
  wire \temp_reg_93[0]_i_5_n_0 ;
  wire \temp_reg_93[0]_i_6_n_0 ;
  wire \temp_reg_93[0]_i_7_n_0 ;
  wire \temp_reg_93[12]_i_2_n_0 ;
  wire \temp_reg_93[12]_i_3_n_0 ;
  wire \temp_reg_93[12]_i_4_n_0 ;
  wire \temp_reg_93[12]_i_5_n_0 ;
  wire \temp_reg_93[16]_i_2_n_0 ;
  wire \temp_reg_93[16]_i_3_n_0 ;
  wire \temp_reg_93[16]_i_4_n_0 ;
  wire \temp_reg_93[16]_i_5_n_0 ;
  wire \temp_reg_93[20]_i_2_n_0 ;
  wire \temp_reg_93[20]_i_3_n_0 ;
  wire \temp_reg_93[20]_i_4_n_0 ;
  wire \temp_reg_93[20]_i_5_n_0 ;
  wire \temp_reg_93[24]_i_2_n_0 ;
  wire \temp_reg_93[24]_i_3_n_0 ;
  wire \temp_reg_93[24]_i_4_n_0 ;
  wire \temp_reg_93[24]_i_5_n_0 ;
  wire \temp_reg_93[28]_i_2_n_0 ;
  wire \temp_reg_93[28]_i_3_n_0 ;
  wire \temp_reg_93[28]_i_4_n_0 ;
  wire \temp_reg_93[28]_i_5_n_0 ;
  wire \temp_reg_93[4]_i_2_n_0 ;
  wire \temp_reg_93[4]_i_3_n_0 ;
  wire \temp_reg_93[4]_i_4_n_0 ;
  wire \temp_reg_93[4]_i_5_n_0 ;
  wire \temp_reg_93[8]_i_2_n_0 ;
  wire \temp_reg_93[8]_i_3_n_0 ;
  wire \temp_reg_93[8]_i_4_n_0 ;
  wire \temp_reg_93[8]_i_5_n_0 ;
  wire [31:0]temp_reg_93_reg;
  wire \temp_reg_93_reg[0]_i_3_n_0 ;
  wire \temp_reg_93_reg[0]_i_3_n_1 ;
  wire \temp_reg_93_reg[0]_i_3_n_2 ;
  wire \temp_reg_93_reg[0]_i_3_n_3 ;
  wire \temp_reg_93_reg[0]_i_3_n_4 ;
  wire \temp_reg_93_reg[0]_i_3_n_5 ;
  wire \temp_reg_93_reg[0]_i_3_n_6 ;
  wire \temp_reg_93_reg[0]_i_3_n_7 ;
  wire \temp_reg_93_reg[12]_i_1_n_0 ;
  wire \temp_reg_93_reg[12]_i_1_n_1 ;
  wire \temp_reg_93_reg[12]_i_1_n_2 ;
  wire \temp_reg_93_reg[12]_i_1_n_3 ;
  wire \temp_reg_93_reg[12]_i_1_n_4 ;
  wire \temp_reg_93_reg[12]_i_1_n_5 ;
  wire \temp_reg_93_reg[12]_i_1_n_6 ;
  wire \temp_reg_93_reg[12]_i_1_n_7 ;
  wire \temp_reg_93_reg[16]_i_1_n_0 ;
  wire \temp_reg_93_reg[16]_i_1_n_1 ;
  wire \temp_reg_93_reg[16]_i_1_n_2 ;
  wire \temp_reg_93_reg[16]_i_1_n_3 ;
  wire \temp_reg_93_reg[16]_i_1_n_4 ;
  wire \temp_reg_93_reg[16]_i_1_n_5 ;
  wire \temp_reg_93_reg[16]_i_1_n_6 ;
  wire \temp_reg_93_reg[16]_i_1_n_7 ;
  wire \temp_reg_93_reg[20]_i_1_n_0 ;
  wire \temp_reg_93_reg[20]_i_1_n_1 ;
  wire \temp_reg_93_reg[20]_i_1_n_2 ;
  wire \temp_reg_93_reg[20]_i_1_n_3 ;
  wire \temp_reg_93_reg[20]_i_1_n_4 ;
  wire \temp_reg_93_reg[20]_i_1_n_5 ;
  wire \temp_reg_93_reg[20]_i_1_n_6 ;
  wire \temp_reg_93_reg[20]_i_1_n_7 ;
  wire \temp_reg_93_reg[24]_i_1_n_0 ;
  wire \temp_reg_93_reg[24]_i_1_n_1 ;
  wire \temp_reg_93_reg[24]_i_1_n_2 ;
  wire \temp_reg_93_reg[24]_i_1_n_3 ;
  wire \temp_reg_93_reg[24]_i_1_n_4 ;
  wire \temp_reg_93_reg[24]_i_1_n_5 ;
  wire \temp_reg_93_reg[24]_i_1_n_6 ;
  wire \temp_reg_93_reg[24]_i_1_n_7 ;
  wire \temp_reg_93_reg[28]_i_1_n_1 ;
  wire \temp_reg_93_reg[28]_i_1_n_2 ;
  wire \temp_reg_93_reg[28]_i_1_n_3 ;
  wire \temp_reg_93_reg[28]_i_1_n_4 ;
  wire \temp_reg_93_reg[28]_i_1_n_5 ;
  wire \temp_reg_93_reg[28]_i_1_n_6 ;
  wire \temp_reg_93_reg[28]_i_1_n_7 ;
  wire \temp_reg_93_reg[4]_i_1_n_0 ;
  wire \temp_reg_93_reg[4]_i_1_n_1 ;
  wire \temp_reg_93_reg[4]_i_1_n_2 ;
  wire \temp_reg_93_reg[4]_i_1_n_3 ;
  wire \temp_reg_93_reg[4]_i_1_n_4 ;
  wire \temp_reg_93_reg[4]_i_1_n_5 ;
  wire \temp_reg_93_reg[4]_i_1_n_6 ;
  wire \temp_reg_93_reg[4]_i_1_n_7 ;
  wire \temp_reg_93_reg[8]_i_1_n_0 ;
  wire \temp_reg_93_reg[8]_i_1_n_1 ;
  wire \temp_reg_93_reg[8]_i_1_n_2 ;
  wire \temp_reg_93_reg[8]_i_1_n_3 ;
  wire \temp_reg_93_reg[8]_i_1_n_4 ;
  wire \temp_reg_93_reg[8]_i_1_n_5 ;
  wire \temp_reg_93_reg[8]_i_1_n_6 ;
  wire \temp_reg_93_reg[8]_i_1_n_7 ;
  wire tmp_product__0_i_18_n_0;
  wire tmp_product__0_i_19_n_0;
  wire tmp_product__0_i_20_n_0;
  wire tmp_product__0_i_21_n_0;
  wire tmp_product__0_i_22_n_0;
  wire tmp_product__0_i_23_n_0;
  wire tmp_product__0_i_24_n_0;
  wire tmp_product__0_i_25_n_0;
  wire tmp_product__0_i_26_n_0;
  wire tmp_product__0_i_27_n_0;
  wire tmp_product__0_i_28_n_0;
  wire tmp_product__0_i_29_n_0;
  wire tmp_product__0_i_30_n_0;
  wire tmp_product__0_i_31_n_0;
  wire tmp_product__0_i_32_n_0;
  wire tmp_product__0_i_33_n_0;
  wire tmp_product__0_i_34_n_0;
  wire tmp_product_i_34_n_0;
  wire tmp_product_i_35_n_0;
  wire tmp_product_i_36_n_0;
  wire tmp_product_i_37_n_0;
  wire tmp_product_i_38_n_0;
  wire tmp_product_i_39_n_0;
  wire tmp_product_i_40_n_0;
  wire tmp_product_i_41_n_0;
  wire tmp_product_i_42_n_0;
  wire tmp_product_i_43_n_0;
  wire tmp_product_i_44_n_0;
  wire tmp_product_i_45_n_0;
  wire tmp_product_i_46_n_0;
  wire tmp_product_i_47_n_0;
  wire tmp_product_i_48_n_0;
  wire tmp_product_i_49_n_0;
  wire tmp_product_i_50_n_0;
  wire tmp_product_i_51_n_0;
  wire tmp_product_i_52_n_0;
  wire tmp_product_i_53_n_0;
  wire tmp_product_i_54_n_0;
  wire tmp_product_i_55_n_0;
  wire tmp_product_i_56_n_0;
  wire tmp_product_i_57_n_0;
  wire tmp_product_i_58_n_0;
  wire tmp_product_i_59_n_0;
  wire tmp_product_i_60_n_0;
  wire tmp_product_i_61_n_0;
  wire tmp_product_i_62_n_0;
  wire tmp_product_i_63_n_0;
  wire tmp_product_i_64_n_0;
  wire tmp_product_i_65_n_0;
  wire tmp_product_i_66_n_0;
  wire [3:3]\NLW_temp_reg_93_reg[28]_i_1_CO_UNCONNECTED ;

  assign s_axi_control_BRESP[1] = \<const0> ;
  assign s_axi_control_BRESP[0] = \<const0> ;
  assign s_axi_control_RRESP[1] = \<const0> ;
  assign s_axi_control_RRESP[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \ap_CS_fsm[2]_i_1 
       (.I0(ap_CS_fsm_pp0_stage0),
        .I1(ap_enable_reg_pp0_iter3),
        .I2(ap_enable_reg_pp0_iter2),
        .O(ap_NS_fsm[2]));
  (* FSM_ENCODING = "none" *) 
  FDSE #(
    .INIT(1'b1)) 
    \ap_CS_fsm_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(control_s_axi_U_n_202),
        .Q(\ap_CS_fsm_reg_n_0_[0] ),
        .S(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[1]),
        .Q(ap_CS_fsm_pp0_stage0),
        .R(ap_rst_n_inv));
  (* FSM_ENCODING = "none" *) 
  FDRE #(
    .INIT(1'b0)) 
    \ap_CS_fsm_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_NS_fsm[2]),
        .Q(ap_CS_fsm_state7),
        .R(ap_rst_n_inv));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp0_iter0_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(control_s_axi_U_n_203),
        .Q(ap_enable_reg_pp0_iter0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp0_iter1_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp0_iter0),
        .Q(ap_enable_reg_pp0_iter1),
        .R(ap_rst_n_inv));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp0_iter2_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp0_iter1),
        .Q(ap_enable_reg_pp0_iter2),
        .R(ap_rst_n_inv));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp0_iter3_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp0_iter2),
        .Q(ap_enable_reg_pp0_iter3),
        .R(ap_rst_n_inv));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h8)) 
    ap_enable_reg_pp0_iter4_i_1
       (.I0(ap_enable_reg_pp0_iter2),
        .I1(ap_enable_reg_pp0_iter3),
        .O(ap_enable_reg_pp0_iter4_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ap_enable_reg_pp0_iter4_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_enable_reg_pp0_iter4_i_1_n_0),
        .Q(ap_enable_reg_pp0_iter4),
        .R(ap_rst_n_inv));
  design_1_muladd_0_0_muladd_control_s_axi control_s_axi_U
       (.D({ap_NS_fsm[1],control_s_axi_U_n_202}),
        .DOADO({control_s_axi_U_n_0,control_s_axi_U_n_1,control_s_axi_U_n_2,control_s_axi_U_n_3,control_s_axi_U_n_4,control_s_axi_U_n_5,control_s_axi_U_n_6,control_s_axi_U_n_7,control_s_axi_U_n_8,control_s_axi_U_n_9,control_s_axi_U_n_10,control_s_axi_U_n_11,control_s_axi_U_n_12,control_s_axi_U_n_13,control_s_axi_U_n_14,control_s_axi_U_n_15,control_s_axi_U_n_16,control_s_axi_U_n_17,control_s_axi_U_n_18,control_s_axi_U_n_19,control_s_axi_U_n_20,control_s_axi_U_n_21,control_s_axi_U_n_22,control_s_axi_U_n_23,control_s_axi_U_n_24,control_s_axi_U_n_25,control_s_axi_U_n_26,control_s_axi_U_n_27,control_s_axi_U_n_28,control_s_axi_U_n_29,control_s_axi_U_n_30,control_s_axi_U_n_31}),
        .DOBDO({control_s_axi_U_n_32,control_s_axi_U_n_33,control_s_axi_U_n_34,control_s_axi_U_n_35,control_s_axi_U_n_36,control_s_axi_U_n_37,control_s_axi_U_n_38,control_s_axi_U_n_39,control_s_axi_U_n_40,control_s_axi_U_n_41,control_s_axi_U_n_42,control_s_axi_U_n_43,control_s_axi_U_n_44,control_s_axi_U_n_45,control_s_axi_U_n_46,control_s_axi_U_n_47,control_s_axi_U_n_48,control_s_axi_U_n_49,control_s_axi_U_n_50,control_s_axi_U_n_51,control_s_axi_U_n_52,control_s_axi_U_n_53,control_s_axi_U_n_54,control_s_axi_U_n_55,control_s_axi_U_n_56,control_s_axi_U_n_57,control_s_axi_U_n_58,control_s_axi_U_n_59,control_s_axi_U_n_60,control_s_axi_U_n_61,control_s_axi_U_n_62,control_s_axi_U_n_63}),
        .\FSM_onehot_rstate_reg[1]_0 (s_axi_control_ARREADY),
        .\FSM_onehot_wstate_reg[1]_0 (s_axi_control_AWREADY),
        .Q(i_reg_82_reg),
        .a_q0(a_q0),
        .\ap_CS_fsm_reg[1] (control_s_axi_U_n_203),
        .ap_NS_fsm1(ap_NS_fsm1),
        .ap_clk(ap_clk),
        .ap_enable_reg_pp0_iter0(ap_enable_reg_pp0_iter0),
        .ap_enable_reg_pp0_iter2(ap_enable_reg_pp0_iter2),
        .ap_enable_reg_pp0_iter3(ap_enable_reg_pp0_iter3),
        .ap_rst_n(ap_rst_n),
        .ap_rst_n_inv(ap_rst_n_inv),
        .b_q0(b_q0),
        .\gen_write[1].mem_reg ({control_s_axi_U_n_64,control_s_axi_U_n_65,control_s_axi_U_n_66,control_s_axi_U_n_67,control_s_axi_U_n_68,control_s_axi_U_n_69,control_s_axi_U_n_70,control_s_axi_U_n_71,control_s_axi_U_n_72,control_s_axi_U_n_73,control_s_axi_U_n_74,control_s_axi_U_n_75,control_s_axi_U_n_76,control_s_axi_U_n_77,control_s_axi_U_n_78,control_s_axi_U_n_79,control_s_axi_U_n_80,control_s_axi_U_n_81,control_s_axi_U_n_82,control_s_axi_U_n_83,control_s_axi_U_n_84,control_s_axi_U_n_85,control_s_axi_U_n_86,control_s_axi_U_n_87,control_s_axi_U_n_88,control_s_axi_U_n_89,control_s_axi_U_n_90,control_s_axi_U_n_91,control_s_axi_U_n_92,control_s_axi_U_n_93,control_s_axi_U_n_94,control_s_axi_U_n_95}),
        .\gen_write[1].mem_reg_0 ({control_s_axi_U_n_96,control_s_axi_U_n_97,control_s_axi_U_n_98,control_s_axi_U_n_99,control_s_axi_U_n_100,control_s_axi_U_n_101,control_s_axi_U_n_102,control_s_axi_U_n_103,control_s_axi_U_n_104,control_s_axi_U_n_105,control_s_axi_U_n_106,control_s_axi_U_n_107,control_s_axi_U_n_108,control_s_axi_U_n_109,control_s_axi_U_n_110,control_s_axi_U_n_111,control_s_axi_U_n_112,control_s_axi_U_n_113,control_s_axi_U_n_114,control_s_axi_U_n_115,control_s_axi_U_n_116,control_s_axi_U_n_117,control_s_axi_U_n_118,control_s_axi_U_n_119,control_s_axi_U_n_120,control_s_axi_U_n_121,control_s_axi_U_n_122,control_s_axi_U_n_123,control_s_axi_U_n_124,control_s_axi_U_n_125,control_s_axi_U_n_126,control_s_axi_U_n_127}),
        .icmp_ln7_fu_111_p2(icmp_ln7_fu_111_p2),
        .int_a_write_reg_0(control_s_axi_U_n_161),
        .int_ap_ready_reg_0({ap_CS_fsm_state7,ap_CS_fsm_pp0_stage0,\ap_CS_fsm_reg_n_0_[0] }),
        .\int_ap_return_reg[31]_0 (temp_reg_93_reg),
        .int_b_write_reg_0(control_s_axi_U_n_163),
        .interrupt(interrupt),
        .p_reg(p_reg_i_30_n_0),
        .p_reg_0(p_reg_i_29_n_0),
        .p_reg_1(p_reg_i_28_n_0),
        .p_reg_10(p_reg_i_19_n_0),
        .p_reg_11(p_reg_i_18_n_0),
        .p_reg_12(p_reg_i_17_n_0),
        .p_reg_13(p_reg_i_16_n_0),
        .p_reg_2(p_reg_i_27_n_0),
        .p_reg_3(p_reg_i_26_n_0),
        .p_reg_4(p_reg_i_25_n_0),
        .p_reg_5(p_reg_i_24_n_0),
        .p_reg_6(p_reg_i_23_n_0),
        .p_reg_7(p_reg_i_22_n_0),
        .p_reg_8(p_reg_i_21_n_0),
        .p_reg_9(p_reg_i_20_n_0),
        .\rdata_reg[0]_0 (\rdata_reg[0]_i_5_n_0 ),
        .\rdata_reg[0]_1 (\rdata_reg[0]_i_6_n_0 ),
        .\rdata_reg[10]_0 (\rdata_reg[10]_i_5_n_0 ),
        .\rdata_reg[10]_1 (\rdata_reg[10]_i_6_n_0 ),
        .\rdata_reg[11]_0 (\rdata_reg[11]_i_5_n_0 ),
        .\rdata_reg[11]_1 (\rdata_reg[11]_i_6_n_0 ),
        .\rdata_reg[12]_0 (\rdata_reg[12]_i_5_n_0 ),
        .\rdata_reg[12]_1 (\rdata_reg[12]_i_6_n_0 ),
        .\rdata_reg[13]_0 (\rdata_reg[13]_i_5_n_0 ),
        .\rdata_reg[13]_1 (\rdata_reg[13]_i_6_n_0 ),
        .\rdata_reg[14]_0 (\rdata_reg[14]_i_5_n_0 ),
        .\rdata_reg[14]_1 (\rdata_reg[14]_i_6_n_0 ),
        .\rdata_reg[15]_0 (\rdata_reg[15]_i_5_n_0 ),
        .\rdata_reg[15]_1 (\rdata_reg[15]_i_6_n_0 ),
        .\rdata_reg[16]_0 (\rdata_reg[16]_i_5_n_0 ),
        .\rdata_reg[16]_1 (\rdata_reg[16]_i_6_n_0 ),
        .\rdata_reg[17]_0 (\rdata_reg[17]_i_5_n_0 ),
        .\rdata_reg[17]_1 (\rdata_reg[17]_i_6_n_0 ),
        .\rdata_reg[18]_0 (\rdata_reg[18]_i_5_n_0 ),
        .\rdata_reg[18]_1 (\rdata_reg[18]_i_6_n_0 ),
        .\rdata_reg[19]_0 (\rdata_reg[19]_i_5_n_0 ),
        .\rdata_reg[19]_1 (\rdata_reg[19]_i_6_n_0 ),
        .\rdata_reg[1]_0 (\rdata_reg[1]_i_7_n_0 ),
        .\rdata_reg[1]_1 (\rdata_reg[1]_i_8_n_0 ),
        .\rdata_reg[20]_0 (\rdata_reg[20]_i_5_n_0 ),
        .\rdata_reg[20]_1 (\rdata_reg[20]_i_6_n_0 ),
        .\rdata_reg[21]_0 (\rdata_reg[21]_i_5_n_0 ),
        .\rdata_reg[21]_1 (\rdata_reg[21]_i_6_n_0 ),
        .\rdata_reg[22]_0 (\rdata_reg[22]_i_5_n_0 ),
        .\rdata_reg[22]_1 (\rdata_reg[22]_i_6_n_0 ),
        .\rdata_reg[23]_0 (\rdata_reg[23]_i_5_n_0 ),
        .\rdata_reg[23]_1 (\rdata_reg[23]_i_6_n_0 ),
        .\rdata_reg[24]_0 (\rdata_reg[24]_i_5_n_0 ),
        .\rdata_reg[24]_1 (\rdata_reg[24]_i_6_n_0 ),
        .\rdata_reg[25]_0 (\rdata_reg[25]_i_5_n_0 ),
        .\rdata_reg[25]_1 (\rdata_reg[25]_i_6_n_0 ),
        .\rdata_reg[26]_0 (\rdata_reg[26]_i_5_n_0 ),
        .\rdata_reg[26]_1 (\rdata_reg[26]_i_6_n_0 ),
        .\rdata_reg[27]_0 (\rdata_reg[27]_i_5_n_0 ),
        .\rdata_reg[27]_1 (\rdata_reg[27]_i_6_n_0 ),
        .\rdata_reg[28]_0 (\rdata_reg[28]_i_5_n_0 ),
        .\rdata_reg[28]_1 (\rdata_reg[28]_i_6_n_0 ),
        .\rdata_reg[29]_0 (\rdata_reg[29]_i_5_n_0 ),
        .\rdata_reg[29]_1 (\rdata_reg[29]_i_6_n_0 ),
        .\rdata_reg[2]_0 (\rdata_reg[2]_i_5_n_0 ),
        .\rdata_reg[2]_1 (\rdata_reg[2]_i_6_n_0 ),
        .\rdata_reg[30]_0 (\rdata_reg[30]_i_5_n_0 ),
        .\rdata_reg[30]_1 (\rdata_reg[30]_i_6_n_0 ),
        .\rdata_reg[31]_0 (\rdata_reg[31]_i_6_n_0 ),
        .\rdata_reg[31]_1 (\rdata_reg[31]_i_7_n_0 ),
        .\rdata_reg[31]_2 (\rdata_reg[31]_i_8_n_0 ),
        .\rdata_reg[31]_3 (\rdata_reg[31]_i_9_n_0 ),
        .\rdata_reg[3]_0 (\rdata_reg[3]_i_5_n_0 ),
        .\rdata_reg[3]_1 (\rdata_reg[3]_i_6_n_0 ),
        .\rdata_reg[4]_0 (\rdata_reg[4]_i_5_n_0 ),
        .\rdata_reg[4]_1 (\rdata_reg[4]_i_6_n_0 ),
        .\rdata_reg[5]_0 (\rdata_reg[5]_i_5_n_0 ),
        .\rdata_reg[5]_1 (\rdata_reg[5]_i_6_n_0 ),
        .\rdata_reg[6]_0 (\rdata_reg[6]_i_5_n_0 ),
        .\rdata_reg[6]_1 (\rdata_reg[6]_i_6_n_0 ),
        .\rdata_reg[7]_0 (\rdata_reg[7]_i_5_n_0 ),
        .\rdata_reg[7]_1 (\rdata_reg[7]_i_6_n_0 ),
        .\rdata_reg[8]_0 (\rdata_reg[8]_i_5_n_0 ),
        .\rdata_reg[8]_1 (\rdata_reg[8]_i_6_n_0 ),
        .\rdata_reg[9]_0 (\rdata_reg[9]_i_5_n_0 ),
        .\rdata_reg[9]_1 (\rdata_reg[9]_i_6_n_0 ),
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
        .s_axi_control_WREADY(s_axi_control_WREADY),
        .s_axi_control_WSTRB(s_axi_control_WSTRB),
        .s_axi_control_WVALID(s_axi_control_WVALID),
        .tmp_product(tmp_product_i_34_n_0),
        .tmp_product_0(tmp_product_i_49_n_0),
        .tmp_product_1(tmp_product_i_48_n_0),
        .tmp_product_10(tmp_product_i_39_n_0),
        .tmp_product_11(tmp_product_i_38_n_0),
        .tmp_product_12(tmp_product_i_37_n_0),
        .tmp_product_13(tmp_product_i_36_n_0),
        .tmp_product_14(tmp_product_i_35_n_0),
        .tmp_product_2(tmp_product_i_47_n_0),
        .tmp_product_3(tmp_product_i_46_n_0),
        .tmp_product_4(tmp_product_i_45_n_0),
        .tmp_product_5(tmp_product_i_44_n_0),
        .tmp_product_6(tmp_product_i_43_n_0),
        .tmp_product_7(tmp_product_i_42_n_0),
        .tmp_product_8(tmp_product_i_41_n_0),
        .tmp_product_9(tmp_product_i_40_n_0),
        .tmp_product__0(tmp_product_i_66_n_0),
        .tmp_product__0_0(tmp_product_i_65_n_0),
        .tmp_product__0_1(tmp_product_i_64_n_0),
        .tmp_product__0_10(tmp_product_i_55_n_0),
        .tmp_product__0_11(tmp_product_i_54_n_0),
        .tmp_product__0_12(tmp_product_i_53_n_0),
        .tmp_product__0_13(tmp_product_i_52_n_0),
        .tmp_product__0_14(tmp_product_i_51_n_0),
        .tmp_product__0_15(tmp_product_i_50_n_0),
        .tmp_product__0_16(tmp_product__0_i_34_n_0),
        .tmp_product__0_17(tmp_product__0_i_33_n_0),
        .tmp_product__0_18(tmp_product__0_i_32_n_0),
        .tmp_product__0_19(tmp_product__0_i_31_n_0),
        .tmp_product__0_2(tmp_product_i_63_n_0),
        .tmp_product__0_20(tmp_product__0_i_30_n_0),
        .tmp_product__0_21(tmp_product__0_i_29_n_0),
        .tmp_product__0_22(tmp_product__0_i_28_n_0),
        .tmp_product__0_23(tmp_product__0_i_27_n_0),
        .tmp_product__0_24(tmp_product__0_i_26_n_0),
        .tmp_product__0_25(tmp_product__0_i_25_n_0),
        .tmp_product__0_26(tmp_product__0_i_24_n_0),
        .tmp_product__0_27(tmp_product__0_i_23_n_0),
        .tmp_product__0_28(tmp_product__0_i_22_n_0),
        .tmp_product__0_29(tmp_product__0_i_21_n_0),
        .tmp_product__0_3(tmp_product_i_62_n_0),
        .tmp_product__0_30(tmp_product__0_i_20_n_0),
        .tmp_product__0_31(tmp_product__0_i_19_n_0),
        .tmp_product__0_32(tmp_product__0_i_18_n_0),
        .tmp_product__0_4(tmp_product_i_61_n_0),
        .tmp_product__0_5(tmp_product_i_60_n_0),
        .tmp_product__0_6(tmp_product_i_59_n_0),
        .tmp_product__0_7(tmp_product_i_58_n_0),
        .tmp_product__0_8(tmp_product_i_57_n_0),
        .tmp_product__0_9(tmp_product_i_56_n_0));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \i_reg_82[0]_i_1 
       (.I0(i_reg_82_reg[0]),
        .O(add_ln7_fu_105_p2[0]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \i_reg_82[1]_i_1 
       (.I0(i_reg_82_reg[0]),
        .I1(i_reg_82_reg[1]),
        .O(add_ln7_fu_105_p2[1]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \i_reg_82[2]_i_1 
       (.I0(i_reg_82_reg[0]),
        .I1(i_reg_82_reg[1]),
        .I2(i_reg_82_reg[2]),
        .O(add_ln7_fu_105_p2[2]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \i_reg_82[3]_i_1 
       (.I0(i_reg_82_reg[3]),
        .I1(i_reg_82_reg[0]),
        .I2(i_reg_82_reg[1]),
        .I3(i_reg_82_reg[2]),
        .O(add_ln7_fu_105_p2[3]));
  LUT3 #(
    .INIT(8'h08)) 
    \i_reg_82[4]_i_1 
       (.I0(ap_enable_reg_pp0_iter0),
        .I1(ap_CS_fsm_pp0_stage0),
        .I2(icmp_ln7_fu_111_p2),
        .O(i_reg_820));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \i_reg_82[4]_i_2 
       (.I0(i_reg_82_reg__0),
        .I1(i_reg_82_reg[2]),
        .I2(i_reg_82_reg[1]),
        .I3(i_reg_82_reg[0]),
        .I4(i_reg_82_reg[3]),
        .O(add_ln7_fu_105_p2[4]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT5 #(
    .INIT(32'h00000100)) 
    \i_reg_82[4]_i_3 
       (.I0(i_reg_82_reg[1]),
        .I1(i_reg_82_reg[0]),
        .I2(i_reg_82_reg[2]),
        .I3(i_reg_82_reg__0),
        .I4(i_reg_82_reg[3]),
        .O(icmp_ln7_fu_111_p2));
  FDRE \i_reg_82_reg[0] 
       (.C(ap_clk),
        .CE(i_reg_820),
        .D(add_ln7_fu_105_p2[0]),
        .Q(i_reg_82_reg[0]),
        .R(ap_NS_fsm1));
  FDRE \i_reg_82_reg[1] 
       (.C(ap_clk),
        .CE(i_reg_820),
        .D(add_ln7_fu_105_p2[1]),
        .Q(i_reg_82_reg[1]),
        .R(ap_NS_fsm1));
  FDRE \i_reg_82_reg[2] 
       (.C(ap_clk),
        .CE(i_reg_820),
        .D(add_ln7_fu_105_p2[2]),
        .Q(i_reg_82_reg[2]),
        .R(ap_NS_fsm1));
  FDRE \i_reg_82_reg[3] 
       (.C(ap_clk),
        .CE(i_reg_820),
        .D(add_ln7_fu_105_p2[3]),
        .Q(i_reg_82_reg[3]),
        .R(ap_NS_fsm1));
  FDRE \i_reg_82_reg[4] 
       (.C(ap_clk),
        .CE(i_reg_820),
        .D(add_ln7_fu_105_p2[4]),
        .Q(i_reg_82_reg__0),
        .R(ap_NS_fsm1));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \icmp_ln7_reg_137[0]_i_1 
       (.I0(icmp_ln7_fu_111_p2),
        .I1(ap_CS_fsm_pp0_stage0),
        .I2(icmp_ln7_reg_137),
        .O(\icmp_ln7_reg_137[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1 
       (.I0(icmp_ln7_reg_137),
        .I1(ap_CS_fsm_pp0_stage0),
        .I2(icmp_ln7_reg_137_pp0_iter1_reg),
        .O(\icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1_n_0 ));
  FDRE \icmp_ln7_reg_137_pp0_iter1_reg_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1_n_0 ),
        .Q(icmp_ln7_reg_137_pp0_iter1_reg),
        .R(1'b0));
  FDRE \icmp_ln7_reg_137_pp0_iter2_reg_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(icmp_ln7_reg_137_pp0_iter1_reg),
        .Q(icmp_ln7_reg_137_pp0_iter2_reg),
        .R(1'b0));
  FDRE \icmp_ln7_reg_137_pp0_iter3_reg_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(icmp_ln7_reg_137_pp0_iter2_reg),
        .Q(icmp_ln7_reg_137_pp0_iter3_reg),
        .R(1'b0));
  FDRE \icmp_ln7_reg_137_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\icmp_ln7_reg_137[0]_i_1_n_0 ),
        .Q(icmp_ln7_reg_137),
        .R(1'b0));
  design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1 mul_32s_32s_32_2_1_U1
       (.D({\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 ,mul_32s_32s_32_2_1_U1_n_16,mul_32s_32s_32_2_1_U1_n_17,mul_32s_32s_32_2_1_U1_n_18,mul_32s_32s_32_2_1_U1_n_19,mul_32s_32s_32_2_1_U1_n_20,mul_32s_32s_32_2_1_U1_n_21,mul_32s_32s_32_2_1_U1_n_22,mul_32s_32s_32_2_1_U1_n_23,mul_32s_32s_32_2_1_U1_n_24,mul_32s_32s_32_2_1_U1_n_25,mul_32s_32s_32_2_1_U1_n_26,mul_32s_32s_32_2_1_U1_n_27,mul_32s_32s_32_2_1_U1_n_28,mul_32s_32s_32_2_1_U1_n_29,mul_32s_32s_32_2_1_U1_n_30,mul_32s_32s_32_2_1_U1_n_31}),
        .Q(ap_CS_fsm_pp0_stage0),
        .a_q0(a_q0),
        .ap_clk(ap_clk),
        .b_q0(b_q0),
        .icmp_ln7_reg_137(icmp_ln7_reg_137));
  LUT1 #(
    .INIT(2'h1)) 
    \mul_ln9_reg_161[31]_i_1 
       (.I0(icmp_ln7_reg_137_pp0_iter2_reg),
        .O(\mul_ln9_reg_161[31]_i_1_n_0 ));
  FDRE \mul_ln9_reg_161_reg[0] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_31),
        .Q(mul_ln9_reg_161[0]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[10] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_21),
        .Q(mul_ln9_reg_161[10]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[11] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_20),
        .Q(mul_ln9_reg_161[11]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[12] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_19),
        .Q(mul_ln9_reg_161[12]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[13] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_18),
        .Q(mul_ln9_reg_161[13]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[14] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_17),
        .Q(mul_ln9_reg_161[14]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[15] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_16),
        .Q(mul_ln9_reg_161[15]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[16] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [16]),
        .Q(mul_ln9_reg_161[16]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[17] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [17]),
        .Q(mul_ln9_reg_161[17]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[18] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [18]),
        .Q(mul_ln9_reg_161[18]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[19] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [19]),
        .Q(mul_ln9_reg_161[19]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[1] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_30),
        .Q(mul_ln9_reg_161[1]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[20] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [20]),
        .Q(mul_ln9_reg_161[20]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[21] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [21]),
        .Q(mul_ln9_reg_161[21]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[22] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [22]),
        .Q(mul_ln9_reg_161[22]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[23] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [23]),
        .Q(mul_ln9_reg_161[23]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[24] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [24]),
        .Q(mul_ln9_reg_161[24]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[25] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [25]),
        .Q(mul_ln9_reg_161[25]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[26] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [26]),
        .Q(mul_ln9_reg_161[26]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[27] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [27]),
        .Q(mul_ln9_reg_161[27]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[28] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [28]),
        .Q(mul_ln9_reg_161[28]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[29] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [29]),
        .Q(mul_ln9_reg_161[29]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[2] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_29),
        .Q(mul_ln9_reg_161[2]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[30] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [30]),
        .Q(mul_ln9_reg_161[30]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[31] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(\muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1 [31]),
        .Q(mul_ln9_reg_161[31]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[3] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_28),
        .Q(mul_ln9_reg_161[3]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[4] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_27),
        .Q(mul_ln9_reg_161[4]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[5] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_26),
        .Q(mul_ln9_reg_161[5]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[6] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_25),
        .Q(mul_ln9_reg_161[6]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[7] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_24),
        .Q(mul_ln9_reg_161[7]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[8] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_23),
        .Q(mul_ln9_reg_161[8]),
        .R(1'b0));
  FDRE \mul_ln9_reg_161_reg[9] 
       (.C(ap_clk),
        .CE(\mul_ln9_reg_161[31]_i_1_n_0 ),
        .D(mul_32s_32s_32_2_1_U1_n_22),
        .Q(mul_ln9_reg_161[9]),
        .R(1'b0));
  FDRE p_reg_i_16
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_32),
        .Q(p_reg_i_16_n_0),
        .R(1'b0));
  FDRE p_reg_i_17
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_33),
        .Q(p_reg_i_17_n_0),
        .R(1'b0));
  FDRE p_reg_i_18
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_34),
        .Q(p_reg_i_18_n_0),
        .R(1'b0));
  FDRE p_reg_i_19
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_35),
        .Q(p_reg_i_19_n_0),
        .R(1'b0));
  FDRE p_reg_i_20
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_36),
        .Q(p_reg_i_20_n_0),
        .R(1'b0));
  FDRE p_reg_i_21
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_37),
        .Q(p_reg_i_21_n_0),
        .R(1'b0));
  FDRE p_reg_i_22
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_38),
        .Q(p_reg_i_22_n_0),
        .R(1'b0));
  FDRE p_reg_i_23
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_39),
        .Q(p_reg_i_23_n_0),
        .R(1'b0));
  FDRE p_reg_i_24
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_40),
        .Q(p_reg_i_24_n_0),
        .R(1'b0));
  FDRE p_reg_i_25
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_41),
        .Q(p_reg_i_25_n_0),
        .R(1'b0));
  FDRE p_reg_i_26
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_42),
        .Q(p_reg_i_26_n_0),
        .R(1'b0));
  FDRE p_reg_i_27
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_43),
        .Q(p_reg_i_27_n_0),
        .R(1'b0));
  FDRE p_reg_i_28
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_44),
        .Q(p_reg_i_28_n_0),
        .R(1'b0));
  FDRE p_reg_i_29
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_45),
        .Q(p_reg_i_29_n_0),
        .R(1'b0));
  FDRE p_reg_i_30
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_46),
        .Q(p_reg_i_30_n_0),
        .R(1'b0));
  FDRE \rdata_reg[0]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_31),
        .Q(\rdata_reg[0]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[0]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_95),
        .Q(\rdata_reg[0]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[10]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_21),
        .Q(\rdata_reg[10]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[10]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_85),
        .Q(\rdata_reg[10]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[11]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_20),
        .Q(\rdata_reg[11]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[11]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_84),
        .Q(\rdata_reg[11]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[12]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_19),
        .Q(\rdata_reg[12]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[12]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_83),
        .Q(\rdata_reg[12]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[13]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_18),
        .Q(\rdata_reg[13]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[13]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_82),
        .Q(\rdata_reg[13]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[14]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_17),
        .Q(\rdata_reg[14]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[14]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_81),
        .Q(\rdata_reg[14]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[15]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_16),
        .Q(\rdata_reg[15]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[15]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_80),
        .Q(\rdata_reg[15]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[16]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_15),
        .Q(\rdata_reg[16]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[16]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_79),
        .Q(\rdata_reg[16]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[17]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_14),
        .Q(\rdata_reg[17]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[17]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_78),
        .Q(\rdata_reg[17]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[18]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_13),
        .Q(\rdata_reg[18]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[18]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_77),
        .Q(\rdata_reg[18]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[19]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_12),
        .Q(\rdata_reg[19]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[19]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_76),
        .Q(\rdata_reg[19]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[1]_i_7 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_30),
        .Q(\rdata_reg[1]_i_7_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[1]_i_8 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_94),
        .Q(\rdata_reg[1]_i_8_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[20]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_11),
        .Q(\rdata_reg[20]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[20]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_75),
        .Q(\rdata_reg[20]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[21]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_10),
        .Q(\rdata_reg[21]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[21]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_74),
        .Q(\rdata_reg[21]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[22]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_9),
        .Q(\rdata_reg[22]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[22]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_73),
        .Q(\rdata_reg[22]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[23]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_8),
        .Q(\rdata_reg[23]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[23]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_72),
        .Q(\rdata_reg[23]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[24]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_7),
        .Q(\rdata_reg[24]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[24]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_71),
        .Q(\rdata_reg[24]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[25]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_6),
        .Q(\rdata_reg[25]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[25]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_70),
        .Q(\rdata_reg[25]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[26]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_5),
        .Q(\rdata_reg[26]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[26]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_69),
        .Q(\rdata_reg[26]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[27]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_4),
        .Q(\rdata_reg[27]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[27]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_68),
        .Q(\rdata_reg[27]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[28]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_3),
        .Q(\rdata_reg[28]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[28]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_67),
        .Q(\rdata_reg[28]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[29]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_2),
        .Q(\rdata_reg[29]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[29]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_66),
        .Q(\rdata_reg[29]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[2]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_29),
        .Q(\rdata_reg[2]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[2]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_93),
        .Q(\rdata_reg[2]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[30]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_1),
        .Q(\rdata_reg[30]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[30]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_65),
        .Q(\rdata_reg[30]_i_6_n_0 ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rdata_reg[31]_i_6 
       (.C(ap_clk),
        .CE(1'b1),
        .D(control_s_axi_U_n_161),
        .Q(\rdata_reg[31]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[31]_i_7 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_0),
        .Q(\rdata_reg[31]_i_7_n_0 ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rdata_reg[31]_i_8 
       (.C(ap_clk),
        .CE(1'b1),
        .D(control_s_axi_U_n_163),
        .Q(\rdata_reg[31]_i_8_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[31]_i_9 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_64),
        .Q(\rdata_reg[31]_i_9_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[3]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_28),
        .Q(\rdata_reg[3]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[3]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_92),
        .Q(\rdata_reg[3]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[4]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_27),
        .Q(\rdata_reg[4]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[4]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_91),
        .Q(\rdata_reg[4]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[5]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_26),
        .Q(\rdata_reg[5]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[5]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_90),
        .Q(\rdata_reg[5]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[6]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_25),
        .Q(\rdata_reg[6]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[6]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_89),
        .Q(\rdata_reg[6]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[7]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_24),
        .Q(\rdata_reg[7]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[7]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_88),
        .Q(\rdata_reg[7]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[8]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_23),
        .Q(\rdata_reg[8]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[8]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_87),
        .Q(\rdata_reg[8]_i_6_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[9]_i_5 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_6_n_0 ),
        .D(control_s_axi_U_n_22),
        .Q(\rdata_reg[9]_i_5_n_0 ),
        .R(1'b0));
  FDRE \rdata_reg[9]_i_6 
       (.C(ap_clk),
        .CE(\rdata_reg[31]_i_8_n_0 ),
        .D(control_s_axi_U_n_86),
        .Q(\rdata_reg[9]_i_6_n_0 ),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    \temp_reg_93[0]_i_2 
       (.I0(ap_enable_reg_pp0_iter4),
        .I1(icmp_ln7_reg_137_pp0_iter3_reg),
        .O(temp_reg_930));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[0]_i_4 
       (.I0(mul_ln9_reg_161[3]),
        .I1(temp_reg_93_reg[3]),
        .O(\temp_reg_93[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[0]_i_5 
       (.I0(mul_ln9_reg_161[2]),
        .I1(temp_reg_93_reg[2]),
        .O(\temp_reg_93[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[0]_i_6 
       (.I0(mul_ln9_reg_161[1]),
        .I1(temp_reg_93_reg[1]),
        .O(\temp_reg_93[0]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[0]_i_7 
       (.I0(mul_ln9_reg_161[0]),
        .I1(temp_reg_93_reg[0]),
        .O(\temp_reg_93[0]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[12]_i_2 
       (.I0(mul_ln9_reg_161[15]),
        .I1(temp_reg_93_reg[15]),
        .O(\temp_reg_93[12]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[12]_i_3 
       (.I0(mul_ln9_reg_161[14]),
        .I1(temp_reg_93_reg[14]),
        .O(\temp_reg_93[12]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[12]_i_4 
       (.I0(mul_ln9_reg_161[13]),
        .I1(temp_reg_93_reg[13]),
        .O(\temp_reg_93[12]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[12]_i_5 
       (.I0(mul_ln9_reg_161[12]),
        .I1(temp_reg_93_reg[12]),
        .O(\temp_reg_93[12]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[16]_i_2 
       (.I0(mul_ln9_reg_161[19]),
        .I1(temp_reg_93_reg[19]),
        .O(\temp_reg_93[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[16]_i_3 
       (.I0(mul_ln9_reg_161[18]),
        .I1(temp_reg_93_reg[18]),
        .O(\temp_reg_93[16]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[16]_i_4 
       (.I0(mul_ln9_reg_161[17]),
        .I1(temp_reg_93_reg[17]),
        .O(\temp_reg_93[16]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[16]_i_5 
       (.I0(mul_ln9_reg_161[16]),
        .I1(temp_reg_93_reg[16]),
        .O(\temp_reg_93[16]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[20]_i_2 
       (.I0(mul_ln9_reg_161[23]),
        .I1(temp_reg_93_reg[23]),
        .O(\temp_reg_93[20]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[20]_i_3 
       (.I0(mul_ln9_reg_161[22]),
        .I1(temp_reg_93_reg[22]),
        .O(\temp_reg_93[20]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[20]_i_4 
       (.I0(mul_ln9_reg_161[21]),
        .I1(temp_reg_93_reg[21]),
        .O(\temp_reg_93[20]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[20]_i_5 
       (.I0(mul_ln9_reg_161[20]),
        .I1(temp_reg_93_reg[20]),
        .O(\temp_reg_93[20]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[24]_i_2 
       (.I0(mul_ln9_reg_161[27]),
        .I1(temp_reg_93_reg[27]),
        .O(\temp_reg_93[24]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[24]_i_3 
       (.I0(mul_ln9_reg_161[26]),
        .I1(temp_reg_93_reg[26]),
        .O(\temp_reg_93[24]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[24]_i_4 
       (.I0(mul_ln9_reg_161[25]),
        .I1(temp_reg_93_reg[25]),
        .O(\temp_reg_93[24]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[24]_i_5 
       (.I0(mul_ln9_reg_161[24]),
        .I1(temp_reg_93_reg[24]),
        .O(\temp_reg_93[24]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[28]_i_2 
       (.I0(temp_reg_93_reg[31]),
        .I1(mul_ln9_reg_161[31]),
        .O(\temp_reg_93[28]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[28]_i_3 
       (.I0(mul_ln9_reg_161[30]),
        .I1(temp_reg_93_reg[30]),
        .O(\temp_reg_93[28]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[28]_i_4 
       (.I0(mul_ln9_reg_161[29]),
        .I1(temp_reg_93_reg[29]),
        .O(\temp_reg_93[28]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[28]_i_5 
       (.I0(mul_ln9_reg_161[28]),
        .I1(temp_reg_93_reg[28]),
        .O(\temp_reg_93[28]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[4]_i_2 
       (.I0(mul_ln9_reg_161[7]),
        .I1(temp_reg_93_reg[7]),
        .O(\temp_reg_93[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[4]_i_3 
       (.I0(mul_ln9_reg_161[6]),
        .I1(temp_reg_93_reg[6]),
        .O(\temp_reg_93[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[4]_i_4 
       (.I0(mul_ln9_reg_161[5]),
        .I1(temp_reg_93_reg[5]),
        .O(\temp_reg_93[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[4]_i_5 
       (.I0(mul_ln9_reg_161[4]),
        .I1(temp_reg_93_reg[4]),
        .O(\temp_reg_93[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[8]_i_2 
       (.I0(mul_ln9_reg_161[11]),
        .I1(temp_reg_93_reg[11]),
        .O(\temp_reg_93[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[8]_i_3 
       (.I0(mul_ln9_reg_161[10]),
        .I1(temp_reg_93_reg[10]),
        .O(\temp_reg_93[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[8]_i_4 
       (.I0(mul_ln9_reg_161[9]),
        .I1(temp_reg_93_reg[9]),
        .O(\temp_reg_93[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \temp_reg_93[8]_i_5 
       (.I0(mul_ln9_reg_161[8]),
        .I1(temp_reg_93_reg[8]),
        .O(\temp_reg_93[8]_i_5_n_0 ));
  FDRE \temp_reg_93_reg[0] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[0]_i_3_n_7 ),
        .Q(temp_reg_93_reg[0]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\temp_reg_93_reg[0]_i_3_n_0 ,\temp_reg_93_reg[0]_i_3_n_1 ,\temp_reg_93_reg[0]_i_3_n_2 ,\temp_reg_93_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI(mul_ln9_reg_161[3:0]),
        .O({\temp_reg_93_reg[0]_i_3_n_4 ,\temp_reg_93_reg[0]_i_3_n_5 ,\temp_reg_93_reg[0]_i_3_n_6 ,\temp_reg_93_reg[0]_i_3_n_7 }),
        .S({\temp_reg_93[0]_i_4_n_0 ,\temp_reg_93[0]_i_5_n_0 ,\temp_reg_93[0]_i_6_n_0 ,\temp_reg_93[0]_i_7_n_0 }));
  FDRE \temp_reg_93_reg[10] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[8]_i_1_n_5 ),
        .Q(temp_reg_93_reg[10]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[11] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[8]_i_1_n_4 ),
        .Q(temp_reg_93_reg[11]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[12] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[12]_i_1_n_7 ),
        .Q(temp_reg_93_reg[12]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[12]_i_1 
       (.CI(\temp_reg_93_reg[8]_i_1_n_0 ),
        .CO({\temp_reg_93_reg[12]_i_1_n_0 ,\temp_reg_93_reg[12]_i_1_n_1 ,\temp_reg_93_reg[12]_i_1_n_2 ,\temp_reg_93_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(mul_ln9_reg_161[15:12]),
        .O({\temp_reg_93_reg[12]_i_1_n_4 ,\temp_reg_93_reg[12]_i_1_n_5 ,\temp_reg_93_reg[12]_i_1_n_6 ,\temp_reg_93_reg[12]_i_1_n_7 }),
        .S({\temp_reg_93[12]_i_2_n_0 ,\temp_reg_93[12]_i_3_n_0 ,\temp_reg_93[12]_i_4_n_0 ,\temp_reg_93[12]_i_5_n_0 }));
  FDRE \temp_reg_93_reg[13] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[12]_i_1_n_6 ),
        .Q(temp_reg_93_reg[13]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[14] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[12]_i_1_n_5 ),
        .Q(temp_reg_93_reg[14]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[15] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[12]_i_1_n_4 ),
        .Q(temp_reg_93_reg[15]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[16] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[16]_i_1_n_7 ),
        .Q(temp_reg_93_reg[16]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[16]_i_1 
       (.CI(\temp_reg_93_reg[12]_i_1_n_0 ),
        .CO({\temp_reg_93_reg[16]_i_1_n_0 ,\temp_reg_93_reg[16]_i_1_n_1 ,\temp_reg_93_reg[16]_i_1_n_2 ,\temp_reg_93_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(mul_ln9_reg_161[19:16]),
        .O({\temp_reg_93_reg[16]_i_1_n_4 ,\temp_reg_93_reg[16]_i_1_n_5 ,\temp_reg_93_reg[16]_i_1_n_6 ,\temp_reg_93_reg[16]_i_1_n_7 }),
        .S({\temp_reg_93[16]_i_2_n_0 ,\temp_reg_93[16]_i_3_n_0 ,\temp_reg_93[16]_i_4_n_0 ,\temp_reg_93[16]_i_5_n_0 }));
  FDRE \temp_reg_93_reg[17] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[16]_i_1_n_6 ),
        .Q(temp_reg_93_reg[17]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[18] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[16]_i_1_n_5 ),
        .Q(temp_reg_93_reg[18]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[19] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[16]_i_1_n_4 ),
        .Q(temp_reg_93_reg[19]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[1] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[0]_i_3_n_6 ),
        .Q(temp_reg_93_reg[1]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[20] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[20]_i_1_n_7 ),
        .Q(temp_reg_93_reg[20]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[20]_i_1 
       (.CI(\temp_reg_93_reg[16]_i_1_n_0 ),
        .CO({\temp_reg_93_reg[20]_i_1_n_0 ,\temp_reg_93_reg[20]_i_1_n_1 ,\temp_reg_93_reg[20]_i_1_n_2 ,\temp_reg_93_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(mul_ln9_reg_161[23:20]),
        .O({\temp_reg_93_reg[20]_i_1_n_4 ,\temp_reg_93_reg[20]_i_1_n_5 ,\temp_reg_93_reg[20]_i_1_n_6 ,\temp_reg_93_reg[20]_i_1_n_7 }),
        .S({\temp_reg_93[20]_i_2_n_0 ,\temp_reg_93[20]_i_3_n_0 ,\temp_reg_93[20]_i_4_n_0 ,\temp_reg_93[20]_i_5_n_0 }));
  FDRE \temp_reg_93_reg[21] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[20]_i_1_n_6 ),
        .Q(temp_reg_93_reg[21]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[22] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[20]_i_1_n_5 ),
        .Q(temp_reg_93_reg[22]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[23] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[20]_i_1_n_4 ),
        .Q(temp_reg_93_reg[23]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[24] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[24]_i_1_n_7 ),
        .Q(temp_reg_93_reg[24]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[24]_i_1 
       (.CI(\temp_reg_93_reg[20]_i_1_n_0 ),
        .CO({\temp_reg_93_reg[24]_i_1_n_0 ,\temp_reg_93_reg[24]_i_1_n_1 ,\temp_reg_93_reg[24]_i_1_n_2 ,\temp_reg_93_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(mul_ln9_reg_161[27:24]),
        .O({\temp_reg_93_reg[24]_i_1_n_4 ,\temp_reg_93_reg[24]_i_1_n_5 ,\temp_reg_93_reg[24]_i_1_n_6 ,\temp_reg_93_reg[24]_i_1_n_7 }),
        .S({\temp_reg_93[24]_i_2_n_0 ,\temp_reg_93[24]_i_3_n_0 ,\temp_reg_93[24]_i_4_n_0 ,\temp_reg_93[24]_i_5_n_0 }));
  FDRE \temp_reg_93_reg[25] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[24]_i_1_n_6 ),
        .Q(temp_reg_93_reg[25]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[26] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[24]_i_1_n_5 ),
        .Q(temp_reg_93_reg[26]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[27] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[24]_i_1_n_4 ),
        .Q(temp_reg_93_reg[27]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[28] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[28]_i_1_n_7 ),
        .Q(temp_reg_93_reg[28]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[28]_i_1 
       (.CI(\temp_reg_93_reg[24]_i_1_n_0 ),
        .CO({\NLW_temp_reg_93_reg[28]_i_1_CO_UNCONNECTED [3],\temp_reg_93_reg[28]_i_1_n_1 ,\temp_reg_93_reg[28]_i_1_n_2 ,\temp_reg_93_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,mul_ln9_reg_161[30:28]}),
        .O({\temp_reg_93_reg[28]_i_1_n_4 ,\temp_reg_93_reg[28]_i_1_n_5 ,\temp_reg_93_reg[28]_i_1_n_6 ,\temp_reg_93_reg[28]_i_1_n_7 }),
        .S({\temp_reg_93[28]_i_2_n_0 ,\temp_reg_93[28]_i_3_n_0 ,\temp_reg_93[28]_i_4_n_0 ,\temp_reg_93[28]_i_5_n_0 }));
  FDRE \temp_reg_93_reg[29] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[28]_i_1_n_6 ),
        .Q(temp_reg_93_reg[29]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[2] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[0]_i_3_n_5 ),
        .Q(temp_reg_93_reg[2]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[30] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[28]_i_1_n_5 ),
        .Q(temp_reg_93_reg[30]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[31] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[28]_i_1_n_4 ),
        .Q(temp_reg_93_reg[31]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[3] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[0]_i_3_n_4 ),
        .Q(temp_reg_93_reg[3]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[4] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[4]_i_1_n_7 ),
        .Q(temp_reg_93_reg[4]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[4]_i_1 
       (.CI(\temp_reg_93_reg[0]_i_3_n_0 ),
        .CO({\temp_reg_93_reg[4]_i_1_n_0 ,\temp_reg_93_reg[4]_i_1_n_1 ,\temp_reg_93_reg[4]_i_1_n_2 ,\temp_reg_93_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(mul_ln9_reg_161[7:4]),
        .O({\temp_reg_93_reg[4]_i_1_n_4 ,\temp_reg_93_reg[4]_i_1_n_5 ,\temp_reg_93_reg[4]_i_1_n_6 ,\temp_reg_93_reg[4]_i_1_n_7 }),
        .S({\temp_reg_93[4]_i_2_n_0 ,\temp_reg_93[4]_i_3_n_0 ,\temp_reg_93[4]_i_4_n_0 ,\temp_reg_93[4]_i_5_n_0 }));
  FDRE \temp_reg_93_reg[5] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[4]_i_1_n_6 ),
        .Q(temp_reg_93_reg[5]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[6] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[4]_i_1_n_5 ),
        .Q(temp_reg_93_reg[6]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[7] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[4]_i_1_n_4 ),
        .Q(temp_reg_93_reg[7]),
        .R(ap_NS_fsm1));
  FDRE \temp_reg_93_reg[8] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[8]_i_1_n_7 ),
        .Q(temp_reg_93_reg[8]),
        .R(ap_NS_fsm1));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \temp_reg_93_reg[8]_i_1 
       (.CI(\temp_reg_93_reg[4]_i_1_n_0 ),
        .CO({\temp_reg_93_reg[8]_i_1_n_0 ,\temp_reg_93_reg[8]_i_1_n_1 ,\temp_reg_93_reg[8]_i_1_n_2 ,\temp_reg_93_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(mul_ln9_reg_161[11:8]),
        .O({\temp_reg_93_reg[8]_i_1_n_4 ,\temp_reg_93_reg[8]_i_1_n_5 ,\temp_reg_93_reg[8]_i_1_n_6 ,\temp_reg_93_reg[8]_i_1_n_7 }),
        .S({\temp_reg_93[8]_i_2_n_0 ,\temp_reg_93[8]_i_3_n_0 ,\temp_reg_93[8]_i_4_n_0 ,\temp_reg_93[8]_i_5_n_0 }));
  FDRE \temp_reg_93_reg[9] 
       (.C(ap_clk),
        .CE(temp_reg_930),
        .D(\temp_reg_93_reg[8]_i_1_n_6 ),
        .Q(temp_reg_93_reg[9]),
        .R(ap_NS_fsm1));
  FDRE tmp_product__0_i_18
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_111),
        .Q(tmp_product__0_i_18_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_19
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_112),
        .Q(tmp_product__0_i_19_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_20
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_113),
        .Q(tmp_product__0_i_20_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_21
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_114),
        .Q(tmp_product__0_i_21_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_22
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_115),
        .Q(tmp_product__0_i_22_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_23
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_116),
        .Q(tmp_product__0_i_23_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_24
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_117),
        .Q(tmp_product__0_i_24_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_25
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_118),
        .Q(tmp_product__0_i_25_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_26
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_119),
        .Q(tmp_product__0_i_26_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_27
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_120),
        .Q(tmp_product__0_i_27_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_28
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_121),
        .Q(tmp_product__0_i_28_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_29
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_122),
        .Q(tmp_product__0_i_29_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_30
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_123),
        .Q(tmp_product__0_i_30_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_31
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_124),
        .Q(tmp_product__0_i_31_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_32
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_125),
        .Q(tmp_product__0_i_32_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_33
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_126),
        .Q(tmp_product__0_i_33_n_0),
        .R(1'b0));
  FDRE tmp_product__0_i_34
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_127),
        .Q(tmp_product__0_i_34_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    tmp_product_i_34
       (.C(ap_clk),
        .CE(1'b1),
        .D(a_ce0),
        .Q(tmp_product_i_34_n_0),
        .R(1'b0));
  FDRE tmp_product_i_35
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_96),
        .Q(tmp_product_i_35_n_0),
        .R(1'b0));
  FDRE tmp_product_i_36
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_97),
        .Q(tmp_product_i_36_n_0),
        .R(1'b0));
  FDRE tmp_product_i_37
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_98),
        .Q(tmp_product_i_37_n_0),
        .R(1'b0));
  FDRE tmp_product_i_38
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_99),
        .Q(tmp_product_i_38_n_0),
        .R(1'b0));
  FDRE tmp_product_i_39
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_100),
        .Q(tmp_product_i_39_n_0),
        .R(1'b0));
  FDRE tmp_product_i_40
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_101),
        .Q(tmp_product_i_40_n_0),
        .R(1'b0));
  FDRE tmp_product_i_41
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_102),
        .Q(tmp_product_i_41_n_0),
        .R(1'b0));
  FDRE tmp_product_i_42
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_103),
        .Q(tmp_product_i_42_n_0),
        .R(1'b0));
  FDRE tmp_product_i_43
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_104),
        .Q(tmp_product_i_43_n_0),
        .R(1'b0));
  FDRE tmp_product_i_44
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_105),
        .Q(tmp_product_i_44_n_0),
        .R(1'b0));
  FDRE tmp_product_i_45
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_106),
        .Q(tmp_product_i_45_n_0),
        .R(1'b0));
  FDRE tmp_product_i_46
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_107),
        .Q(tmp_product_i_46_n_0),
        .R(1'b0));
  FDRE tmp_product_i_47
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_108),
        .Q(tmp_product_i_47_n_0),
        .R(1'b0));
  FDRE tmp_product_i_48
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_109),
        .Q(tmp_product_i_48_n_0),
        .R(1'b0));
  FDRE tmp_product_i_49
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_110),
        .Q(tmp_product_i_49_n_0),
        .R(1'b0));
  FDRE tmp_product_i_50
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_47),
        .Q(tmp_product_i_50_n_0),
        .R(1'b0));
  FDRE tmp_product_i_51
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_48),
        .Q(tmp_product_i_51_n_0),
        .R(1'b0));
  FDRE tmp_product_i_52
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_49),
        .Q(tmp_product_i_52_n_0),
        .R(1'b0));
  FDRE tmp_product_i_53
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_50),
        .Q(tmp_product_i_53_n_0),
        .R(1'b0));
  FDRE tmp_product_i_54
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_51),
        .Q(tmp_product_i_54_n_0),
        .R(1'b0));
  FDRE tmp_product_i_55
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_52),
        .Q(tmp_product_i_55_n_0),
        .R(1'b0));
  FDRE tmp_product_i_56
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_53),
        .Q(tmp_product_i_56_n_0),
        .R(1'b0));
  FDRE tmp_product_i_57
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_54),
        .Q(tmp_product_i_57_n_0),
        .R(1'b0));
  FDRE tmp_product_i_58
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_55),
        .Q(tmp_product_i_58_n_0),
        .R(1'b0));
  FDRE tmp_product_i_59
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_56),
        .Q(tmp_product_i_59_n_0),
        .R(1'b0));
  FDRE tmp_product_i_60
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_57),
        .Q(tmp_product_i_60_n_0),
        .R(1'b0));
  FDRE tmp_product_i_61
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_58),
        .Q(tmp_product_i_61_n_0),
        .R(1'b0));
  FDRE tmp_product_i_62
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_59),
        .Q(tmp_product_i_62_n_0),
        .R(1'b0));
  FDRE tmp_product_i_63
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_60),
        .Q(tmp_product_i_63_n_0),
        .R(1'b0));
  FDRE tmp_product_i_64
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_61),
        .Q(tmp_product_i_64_n_0),
        .R(1'b0));
  FDRE tmp_product_i_65
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_62),
        .Q(tmp_product_i_65_n_0),
        .R(1'b0));
  FDRE tmp_product_i_66
       (.C(ap_clk),
        .CE(tmp_product_i_34_n_0),
        .D(control_s_axi_U_n_63),
        .Q(tmp_product_i_66_n_0),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    tmp_product_i_67
       (.I0(ap_CS_fsm_pp0_stage0),
        .I1(ap_enable_reg_pp0_iter0),
        .O(a_ce0));
endmodule

(* ORIG_REF_NAME = "muladd_control_s_axi" *) 
module design_1_muladd_0_0_muladd_control_s_axi
   (DOADO,
    DOBDO,
    \gen_write[1].mem_reg ,
    \gen_write[1].mem_reg_0 ,
    ap_rst_n_inv,
    a_q0,
    int_a_write_reg_0,
    \FSM_onehot_rstate_reg[1]_0 ,
    int_b_write_reg_0,
    b_q0,
    \FSM_onehot_wstate_reg[1]_0 ,
    s_axi_control_BVALID,
    s_axi_control_WREADY,
    s_axi_control_RVALID,
    interrupt,
    D,
    \ap_CS_fsm_reg[1] ,
    ap_NS_fsm1,
    s_axi_control_RDATA,
    ap_clk,
    Q,
    s_axi_control_WDATA,
    int_ap_ready_reg_0,
    \rdata_reg[31]_0 ,
    \rdata_reg[0]_0 ,
    \rdata_reg[1]_0 ,
    \rdata_reg[2]_0 ,
    \rdata_reg[3]_0 ,
    \rdata_reg[4]_0 ,
    \rdata_reg[5]_0 ,
    \rdata_reg[6]_0 ,
    \rdata_reg[7]_0 ,
    \rdata_reg[8]_0 ,
    \rdata_reg[9]_0 ,
    \rdata_reg[10]_0 ,
    \rdata_reg[11]_0 ,
    \rdata_reg[12]_0 ,
    \rdata_reg[13]_0 ,
    \rdata_reg[14]_0 ,
    \rdata_reg[15]_0 ,
    \rdata_reg[16]_0 ,
    \rdata_reg[17]_0 ,
    \rdata_reg[18]_0 ,
    \rdata_reg[19]_0 ,
    \rdata_reg[20]_0 ,
    \rdata_reg[21]_0 ,
    \rdata_reg[22]_0 ,
    \rdata_reg[23]_0 ,
    \rdata_reg[24]_0 ,
    \rdata_reg[25]_0 ,
    \rdata_reg[26]_0 ,
    \rdata_reg[27]_0 ,
    \rdata_reg[28]_0 ,
    \rdata_reg[29]_0 ,
    \rdata_reg[30]_0 ,
    \rdata_reg[31]_1 ,
    tmp_product,
    tmp_product__0,
    tmp_product__0_0,
    tmp_product__0_1,
    tmp_product__0_2,
    tmp_product__0_3,
    tmp_product__0_4,
    tmp_product__0_5,
    tmp_product__0_6,
    tmp_product__0_7,
    tmp_product__0_8,
    tmp_product__0_9,
    tmp_product__0_10,
    tmp_product__0_11,
    tmp_product__0_12,
    tmp_product__0_13,
    tmp_product__0_14,
    tmp_product__0_15,
    p_reg,
    p_reg_0,
    p_reg_1,
    p_reg_2,
    p_reg_3,
    p_reg_4,
    p_reg_5,
    p_reg_6,
    p_reg_7,
    p_reg_8,
    p_reg_9,
    p_reg_10,
    p_reg_11,
    p_reg_12,
    p_reg_13,
    s_axi_control_WVALID,
    s_axi_control_ARVALID,
    \rdata_reg[31]_2 ,
    \rdata_reg[0]_1 ,
    \rdata_reg[1]_1 ,
    \rdata_reg[2]_1 ,
    \rdata_reg[3]_1 ,
    \rdata_reg[4]_1 ,
    \rdata_reg[5]_1 ,
    \rdata_reg[6]_1 ,
    \rdata_reg[7]_1 ,
    \rdata_reg[8]_1 ,
    \rdata_reg[9]_1 ,
    \rdata_reg[10]_1 ,
    \rdata_reg[11]_1 ,
    \rdata_reg[12]_1 ,
    \rdata_reg[13]_1 ,
    \rdata_reg[14]_1 ,
    \rdata_reg[15]_1 ,
    \rdata_reg[16]_1 ,
    \rdata_reg[17]_1 ,
    \rdata_reg[18]_1 ,
    \rdata_reg[19]_1 ,
    \rdata_reg[20]_1 ,
    \rdata_reg[21]_1 ,
    \rdata_reg[22]_1 ,
    \rdata_reg[23]_1 ,
    \rdata_reg[24]_1 ,
    \rdata_reg[25]_1 ,
    \rdata_reg[26]_1 ,
    \rdata_reg[27]_1 ,
    \rdata_reg[28]_1 ,
    \rdata_reg[29]_1 ,
    \rdata_reg[30]_1 ,
    \rdata_reg[31]_3 ,
    tmp_product__0_16,
    tmp_product__0_17,
    tmp_product__0_18,
    tmp_product__0_19,
    tmp_product__0_20,
    tmp_product__0_21,
    tmp_product__0_22,
    tmp_product__0_23,
    tmp_product__0_24,
    tmp_product__0_25,
    tmp_product__0_26,
    tmp_product__0_27,
    tmp_product__0_28,
    tmp_product__0_29,
    tmp_product__0_30,
    tmp_product__0_31,
    tmp_product__0_32,
    tmp_product_0,
    tmp_product_1,
    tmp_product_2,
    tmp_product_3,
    tmp_product_4,
    tmp_product_5,
    tmp_product_6,
    tmp_product_7,
    tmp_product_8,
    tmp_product_9,
    tmp_product_10,
    tmp_product_11,
    tmp_product_12,
    tmp_product_13,
    tmp_product_14,
    s_axi_control_ARADDR,
    s_axi_control_RREADY,
    s_axi_control_AWVALID,
    s_axi_control_BREADY,
    s_axi_control_WSTRB,
    ap_enable_reg_pp0_iter2,
    ap_enable_reg_pp0_iter3,
    icmp_ln7_fu_111_p2,
    ap_enable_reg_pp0_iter0,
    ap_rst_n,
    s_axi_control_AWADDR,
    \int_ap_return_reg[31]_0 );
  output [31:0]DOADO;
  output [31:0]DOBDO;
  output [31:0]\gen_write[1].mem_reg ;
  output [31:0]\gen_write[1].mem_reg_0 ;
  output ap_rst_n_inv;
  output [31:0]a_q0;
  output int_a_write_reg_0;
  output \FSM_onehot_rstate_reg[1]_0 ;
  output int_b_write_reg_0;
  output [31:0]b_q0;
  output \FSM_onehot_wstate_reg[1]_0 ;
  output s_axi_control_BVALID;
  output s_axi_control_WREADY;
  output s_axi_control_RVALID;
  output interrupt;
  output [1:0]D;
  output \ap_CS_fsm_reg[1] ;
  output ap_NS_fsm1;
  output [31:0]s_axi_control_RDATA;
  input ap_clk;
  input [3:0]Q;
  input [31:0]s_axi_control_WDATA;
  input [2:0]int_ap_ready_reg_0;
  input \rdata_reg[31]_0 ;
  input \rdata_reg[0]_0 ;
  input \rdata_reg[1]_0 ;
  input \rdata_reg[2]_0 ;
  input \rdata_reg[3]_0 ;
  input \rdata_reg[4]_0 ;
  input \rdata_reg[5]_0 ;
  input \rdata_reg[6]_0 ;
  input \rdata_reg[7]_0 ;
  input \rdata_reg[8]_0 ;
  input \rdata_reg[9]_0 ;
  input \rdata_reg[10]_0 ;
  input \rdata_reg[11]_0 ;
  input \rdata_reg[12]_0 ;
  input \rdata_reg[13]_0 ;
  input \rdata_reg[14]_0 ;
  input \rdata_reg[15]_0 ;
  input \rdata_reg[16]_0 ;
  input \rdata_reg[17]_0 ;
  input \rdata_reg[18]_0 ;
  input \rdata_reg[19]_0 ;
  input \rdata_reg[20]_0 ;
  input \rdata_reg[21]_0 ;
  input \rdata_reg[22]_0 ;
  input \rdata_reg[23]_0 ;
  input \rdata_reg[24]_0 ;
  input \rdata_reg[25]_0 ;
  input \rdata_reg[26]_0 ;
  input \rdata_reg[27]_0 ;
  input \rdata_reg[28]_0 ;
  input \rdata_reg[29]_0 ;
  input \rdata_reg[30]_0 ;
  input \rdata_reg[31]_1 ;
  input tmp_product;
  input tmp_product__0;
  input tmp_product__0_0;
  input tmp_product__0_1;
  input tmp_product__0_2;
  input tmp_product__0_3;
  input tmp_product__0_4;
  input tmp_product__0_5;
  input tmp_product__0_6;
  input tmp_product__0_7;
  input tmp_product__0_8;
  input tmp_product__0_9;
  input tmp_product__0_10;
  input tmp_product__0_11;
  input tmp_product__0_12;
  input tmp_product__0_13;
  input tmp_product__0_14;
  input tmp_product__0_15;
  input p_reg;
  input p_reg_0;
  input p_reg_1;
  input p_reg_2;
  input p_reg_3;
  input p_reg_4;
  input p_reg_5;
  input p_reg_6;
  input p_reg_7;
  input p_reg_8;
  input p_reg_9;
  input p_reg_10;
  input p_reg_11;
  input p_reg_12;
  input p_reg_13;
  input s_axi_control_WVALID;
  input s_axi_control_ARVALID;
  input \rdata_reg[31]_2 ;
  input \rdata_reg[0]_1 ;
  input \rdata_reg[1]_1 ;
  input \rdata_reg[2]_1 ;
  input \rdata_reg[3]_1 ;
  input \rdata_reg[4]_1 ;
  input \rdata_reg[5]_1 ;
  input \rdata_reg[6]_1 ;
  input \rdata_reg[7]_1 ;
  input \rdata_reg[8]_1 ;
  input \rdata_reg[9]_1 ;
  input \rdata_reg[10]_1 ;
  input \rdata_reg[11]_1 ;
  input \rdata_reg[12]_1 ;
  input \rdata_reg[13]_1 ;
  input \rdata_reg[14]_1 ;
  input \rdata_reg[15]_1 ;
  input \rdata_reg[16]_1 ;
  input \rdata_reg[17]_1 ;
  input \rdata_reg[18]_1 ;
  input \rdata_reg[19]_1 ;
  input \rdata_reg[20]_1 ;
  input \rdata_reg[21]_1 ;
  input \rdata_reg[22]_1 ;
  input \rdata_reg[23]_1 ;
  input \rdata_reg[24]_1 ;
  input \rdata_reg[25]_1 ;
  input \rdata_reg[26]_1 ;
  input \rdata_reg[27]_1 ;
  input \rdata_reg[28]_1 ;
  input \rdata_reg[29]_1 ;
  input \rdata_reg[30]_1 ;
  input \rdata_reg[31]_3 ;
  input tmp_product__0_16;
  input tmp_product__0_17;
  input tmp_product__0_18;
  input tmp_product__0_19;
  input tmp_product__0_20;
  input tmp_product__0_21;
  input tmp_product__0_22;
  input tmp_product__0_23;
  input tmp_product__0_24;
  input tmp_product__0_25;
  input tmp_product__0_26;
  input tmp_product__0_27;
  input tmp_product__0_28;
  input tmp_product__0_29;
  input tmp_product__0_30;
  input tmp_product__0_31;
  input tmp_product__0_32;
  input tmp_product_0;
  input tmp_product_1;
  input tmp_product_2;
  input tmp_product_3;
  input tmp_product_4;
  input tmp_product_5;
  input tmp_product_6;
  input tmp_product_7;
  input tmp_product_8;
  input tmp_product_9;
  input tmp_product_10;
  input tmp_product_11;
  input tmp_product_12;
  input tmp_product_13;
  input tmp_product_14;
  input [7:0]s_axi_control_ARADDR;
  input s_axi_control_RREADY;
  input s_axi_control_AWVALID;
  input s_axi_control_BREADY;
  input [3:0]s_axi_control_WSTRB;
  input ap_enable_reg_pp0_iter2;
  input ap_enable_reg_pp0_iter3;
  input icmp_ln7_fu_111_p2;
  input ap_enable_reg_pp0_iter0;
  input ap_rst_n;
  input [7:0]s_axi_control_AWADDR;
  input [31:0]\int_ap_return_reg[31]_0 ;

  wire [1:0]D;
  wire [31:0]DOADO;
  wire [31:0]DOBDO;
  wire \FSM_onehot_rstate[1]_i_1_n_0 ;
  wire \FSM_onehot_rstate[2]_i_1_n_0 ;
  wire \FSM_onehot_rstate_reg[1]_0 ;
  wire \FSM_onehot_rstate_reg_n_0_[2] ;
  wire \FSM_onehot_wstate[1]_i_2_n_0 ;
  wire \FSM_onehot_wstate[2]_i_1_n_0 ;
  wire \FSM_onehot_wstate[3]_i_1_n_0 ;
  wire \FSM_onehot_wstate_reg[1]_0 ;
  wire \FSM_onehot_wstate_reg_n_0_[2] ;
  wire [3:0]Q;
  wire [31:0]a_q0;
  wire \ap_CS_fsm_reg[1] ;
  wire ap_NS_fsm1;
  wire ap_clk;
  wire ap_enable_reg_pp0_iter0;
  wire ap_enable_reg_pp0_iter2;
  wire ap_enable_reg_pp0_iter3;
  wire ap_idle;
  wire ap_rst_n;
  wire ap_rst_n_inv;
  wire ap_start;
  wire aw_hs;
  wire [31:0]b_q0;
  wire [31:0]\gen_write[1].mem_reg ;
  wire [31:0]\gen_write[1].mem_reg_0 ;
  wire icmp_ln7_fu_111_p2;
  wire [3:0]int_a_address1;
  wire int_a_read;
  wire int_a_read0;
  wire int_a_write_i_1_n_0;
  wire int_a_write_i_2_n_0;
  wire int_a_write_reg_0;
  wire int_a_write_reg_n_0;
  wire int_ap_done;
  wire int_ap_done_i_1_n_0;
  wire int_ap_done_i_2_n_0;
  wire int_ap_idle;
  wire int_ap_ready;
  wire [2:0]int_ap_ready_reg_0;
  wire [31:0]int_ap_return;
  wire [31:0]\int_ap_return_reg[31]_0 ;
  wire int_ap_start3_out;
  wire int_ap_start_i_1_n_0;
  wire int_auto_restart;
  wire int_auto_restart_i_1_n_0;
  wire int_auto_restart_i_2_n_0;
  wire [31:0]int_b_q1;
  wire int_b_read;
  wire int_b_read0;
  wire int_b_write_i_1_n_0;
  wire int_b_write_reg_0;
  wire int_b_write_reg_n_0;
  wire int_gie_i_1_n_0;
  wire int_gie_reg_n_0;
  wire \int_ier[0]_i_1_n_0 ;
  wire \int_ier[1]_i_1_n_0 ;
  wire \int_ier[1]_i_2_n_0 ;
  wire \int_ier[1]_i_3_n_0 ;
  wire \int_ier_reg_n_0_[0] ;
  wire \int_ier_reg_n_0_[1] ;
  wire int_isr6_out;
  wire \int_isr[0]_i_1_n_0 ;
  wire \int_isr[1]_i_1_n_0 ;
  wire interrupt;
  wire [31:0]p_0_in;
  wire [1:0]p_1_in0_in;
  wire p_reg;
  wire p_reg_0;
  wire p_reg_1;
  wire p_reg_10;
  wire p_reg_11;
  wire p_reg_12;
  wire p_reg_13;
  wire p_reg_2;
  wire p_reg_3;
  wire p_reg_4;
  wire p_reg_5;
  wire p_reg_6;
  wire p_reg_7;
  wire p_reg_8;
  wire p_reg_9;
  wire \rdata[0]_i_4_n_0 ;
  wire \rdata[0]_i_7_n_0 ;
  wire \rdata[10]_i_4_n_0 ;
  wire \rdata[11]_i_4_n_0 ;
  wire \rdata[12]_i_4_n_0 ;
  wire \rdata[13]_i_4_n_0 ;
  wire \rdata[14]_i_4_n_0 ;
  wire \rdata[15]_i_4_n_0 ;
  wire \rdata[16]_i_4_n_0 ;
  wire \rdata[17]_i_4_n_0 ;
  wire \rdata[18]_i_4_n_0 ;
  wire \rdata[19]_i_4_n_0 ;
  wire \rdata[1]_i_2_n_0 ;
  wire \rdata[1]_i_5_n_0 ;
  wire \rdata[1]_i_6_n_0 ;
  wire \rdata[20]_i_4_n_0 ;
  wire \rdata[21]_i_4_n_0 ;
  wire \rdata[22]_i_4_n_0 ;
  wire \rdata[23]_i_4_n_0 ;
  wire \rdata[24]_i_4_n_0 ;
  wire \rdata[25]_i_4_n_0 ;
  wire \rdata[26]_i_4_n_0 ;
  wire \rdata[27]_i_4_n_0 ;
  wire \rdata[28]_i_4_n_0 ;
  wire \rdata[29]_i_4_n_0 ;
  wire \rdata[2]_i_4_n_0 ;
  wire \rdata[30]_i_4_n_0 ;
  wire \rdata[31]_i_10_n_0 ;
  wire \rdata[31]_i_11_n_0 ;
  wire \rdata[31]_i_1_n_0 ;
  wire \rdata[31]_i_5_n_0 ;
  wire \rdata[3]_i_4_n_0 ;
  wire \rdata[4]_i_4_n_0 ;
  wire \rdata[5]_i_4_n_0 ;
  wire \rdata[6]_i_4_n_0 ;
  wire \rdata[7]_i_4_n_0 ;
  wire \rdata[8]_i_4_n_0 ;
  wire \rdata[9]_i_4_n_0 ;
  wire \rdata_reg[0]_0 ;
  wire \rdata_reg[0]_1 ;
  wire \rdata_reg[10]_0 ;
  wire \rdata_reg[10]_1 ;
  wire \rdata_reg[11]_0 ;
  wire \rdata_reg[11]_1 ;
  wire \rdata_reg[12]_0 ;
  wire \rdata_reg[12]_1 ;
  wire \rdata_reg[13]_0 ;
  wire \rdata_reg[13]_1 ;
  wire \rdata_reg[14]_0 ;
  wire \rdata_reg[14]_1 ;
  wire \rdata_reg[15]_0 ;
  wire \rdata_reg[15]_1 ;
  wire \rdata_reg[16]_0 ;
  wire \rdata_reg[16]_1 ;
  wire \rdata_reg[17]_0 ;
  wire \rdata_reg[17]_1 ;
  wire \rdata_reg[18]_0 ;
  wire \rdata_reg[18]_1 ;
  wire \rdata_reg[19]_0 ;
  wire \rdata_reg[19]_1 ;
  wire \rdata_reg[1]_0 ;
  wire \rdata_reg[1]_1 ;
  wire \rdata_reg[20]_0 ;
  wire \rdata_reg[20]_1 ;
  wire \rdata_reg[21]_0 ;
  wire \rdata_reg[21]_1 ;
  wire \rdata_reg[22]_0 ;
  wire \rdata_reg[22]_1 ;
  wire \rdata_reg[23]_0 ;
  wire \rdata_reg[23]_1 ;
  wire \rdata_reg[24]_0 ;
  wire \rdata_reg[24]_1 ;
  wire \rdata_reg[25]_0 ;
  wire \rdata_reg[25]_1 ;
  wire \rdata_reg[26]_0 ;
  wire \rdata_reg[26]_1 ;
  wire \rdata_reg[27]_0 ;
  wire \rdata_reg[27]_1 ;
  wire \rdata_reg[28]_0 ;
  wire \rdata_reg[28]_1 ;
  wire \rdata_reg[29]_0 ;
  wire \rdata_reg[29]_1 ;
  wire \rdata_reg[2]_0 ;
  wire \rdata_reg[2]_1 ;
  wire \rdata_reg[30]_0 ;
  wire \rdata_reg[30]_1 ;
  wire \rdata_reg[31]_0 ;
  wire \rdata_reg[31]_1 ;
  wire \rdata_reg[31]_2 ;
  wire \rdata_reg[31]_3 ;
  wire \rdata_reg[3]_0 ;
  wire \rdata_reg[3]_1 ;
  wire \rdata_reg[4]_0 ;
  wire \rdata_reg[4]_1 ;
  wire \rdata_reg[5]_0 ;
  wire \rdata_reg[5]_1 ;
  wire \rdata_reg[6]_0 ;
  wire \rdata_reg[6]_1 ;
  wire \rdata_reg[7]_0 ;
  wire \rdata_reg[7]_1 ;
  wire \rdata_reg[8]_0 ;
  wire \rdata_reg[8]_1 ;
  wire \rdata_reg[9]_0 ;
  wire \rdata_reg[9]_1 ;
  wire [7:0]s_axi_control_ARADDR;
  wire s_axi_control_ARVALID;
  wire [7:0]s_axi_control_AWADDR;
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
  wire tmp_product;
  wire tmp_product_0;
  wire tmp_product_1;
  wire tmp_product_10;
  wire tmp_product_11;
  wire tmp_product_12;
  wire tmp_product_13;
  wire tmp_product_14;
  wire tmp_product_2;
  wire tmp_product_3;
  wire tmp_product_4;
  wire tmp_product_5;
  wire tmp_product_6;
  wire tmp_product_7;
  wire tmp_product_8;
  wire tmp_product_9;
  wire tmp_product__0;
  wire tmp_product__0_0;
  wire tmp_product__0_1;
  wire tmp_product__0_10;
  wire tmp_product__0_11;
  wire tmp_product__0_12;
  wire tmp_product__0_13;
  wire tmp_product__0_14;
  wire tmp_product__0_15;
  wire tmp_product__0_16;
  wire tmp_product__0_17;
  wire tmp_product__0_18;
  wire tmp_product__0_19;
  wire tmp_product__0_2;
  wire tmp_product__0_20;
  wire tmp_product__0_21;
  wire tmp_product__0_22;
  wire tmp_product__0_23;
  wire tmp_product__0_24;
  wire tmp_product__0_25;
  wire tmp_product__0_26;
  wire tmp_product__0_27;
  wire tmp_product__0_28;
  wire tmp_product__0_29;
  wire tmp_product__0_3;
  wire tmp_product__0_30;
  wire tmp_product__0_31;
  wire tmp_product__0_32;
  wire tmp_product__0_4;
  wire tmp_product__0_5;
  wire tmp_product__0_6;
  wire tmp_product__0_7;
  wire tmp_product__0_8;
  wire tmp_product__0_9;
  wire \waddr_reg_n_0_[0] ;
  wire \waddr_reg_n_0_[1] ;
  wire \waddr_reg_n_0_[2] ;
  wire \waddr_reg_n_0_[3] ;
  wire \waddr_reg_n_0_[4] ;
  wire \waddr_reg_n_0_[5] ;
  wire \waddr_reg_n_0_[6] ;
  wire \waddr_reg_n_0_[7] ;

  LUT6 #(
    .INIT(64'h55555555000CFFFF)) 
    \FSM_onehot_rstate[1]_i_1 
       (.I0(s_axi_control_ARVALID),
        .I1(s_axi_control_RREADY),
        .I2(int_b_read),
        .I3(int_a_read),
        .I4(\FSM_onehot_rstate_reg_n_0_[2] ),
        .I5(\FSM_onehot_rstate_reg[1]_0 ),
        .O(\FSM_onehot_rstate[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEEEAEEEE44404444)) 
    \FSM_onehot_rstate[2]_i_1 
       (.I0(\FSM_onehot_rstate_reg[1]_0 ),
        .I1(\FSM_onehot_rstate_reg_n_0_[2] ),
        .I2(int_a_read),
        .I3(int_b_read),
        .I4(s_axi_control_RREADY),
        .I5(s_axi_control_ARVALID),
        .O(\FSM_onehot_rstate[2]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rstate_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_rstate[1]_i_1_n_0 ),
        .Q(\FSM_onehot_rstate_reg[1]_0 ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODED_STATES = "RDIDLE:010,RDDATA:100,iSTATE:001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_rstate_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_rstate[2]_i_1_n_0 ),
        .Q(\FSM_onehot_rstate_reg_n_0_[2] ),
        .R(ap_rst_n_inv));
  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_wstate[1]_i_1 
       (.I0(ap_rst_n),
        .O(ap_rst_n_inv));
  LUT5 #(
    .INIT(32'hBA30BA3F)) 
    \FSM_onehot_wstate[1]_i_2 
       (.I0(s_axi_control_BREADY),
        .I1(s_axi_control_AWVALID),
        .I2(\FSM_onehot_wstate_reg[1]_0 ),
        .I3(s_axi_control_BVALID),
        .I4(\FSM_onehot_wstate_reg_n_0_[2] ),
        .O(\FSM_onehot_wstate[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF8888888FFFF8888)) 
    \FSM_onehot_wstate[2]_i_1 
       (.I0(\FSM_onehot_wstate_reg[1]_0 ),
        .I1(s_axi_control_AWVALID),
        .I2(s_axi_control_ARVALID),
        .I3(\FSM_onehot_rstate_reg[1]_0 ),
        .I4(\FSM_onehot_wstate_reg_n_0_[2] ),
        .I5(s_axi_control_WVALID),
        .O(\FSM_onehot_wstate[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h08880888FFFF0888)) 
    \FSM_onehot_wstate[3]_i_1 
       (.I0(s_axi_control_WVALID),
        .I1(\FSM_onehot_wstate_reg_n_0_[2] ),
        .I2(\FSM_onehot_rstate_reg[1]_0 ),
        .I3(s_axi_control_ARVALID),
        .I4(s_axi_control_BVALID),
        .I5(s_axi_control_BREADY),
        .O(\FSM_onehot_wstate[3]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[1]_i_2_n_0 ),
        .Q(\FSM_onehot_wstate_reg[1]_0 ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[2] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[2]_i_1_n_0 ),
        .Q(\FSM_onehot_wstate_reg_n_0_[2] ),
        .R(ap_rst_n_inv));
  (* FSM_ENCODED_STATES = "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_wstate_reg[3] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\FSM_onehot_wstate[3]_i_1_n_0 ),
        .Q(s_axi_control_BVALID),
        .R(ap_rst_n_inv));
  LUT4 #(
    .INIT(16'h4555)) 
    \ap_CS_fsm[0]_i_1 
       (.I0(int_ap_ready_reg_0[1]),
        .I1(int_ap_ready_reg_0[2]),
        .I2(int_ap_ready_reg_0[0]),
        .I3(ap_start),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'hFBFBF000)) 
    \ap_CS_fsm[1]_i_1 
       (.I0(ap_enable_reg_pp0_iter2),
        .I1(ap_enable_reg_pp0_iter3),
        .I2(int_ap_ready_reg_0[0]),
        .I3(ap_start),
        .I4(int_ap_ready_reg_0[1]),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h7777700000000000)) 
    ap_enable_reg_pp0_iter0_i_1
       (.I0(icmp_ln7_fu_111_p2),
        .I1(int_ap_ready_reg_0[1]),
        .I2(ap_start),
        .I3(int_ap_ready_reg_0[0]),
        .I4(ap_enable_reg_pp0_iter0),
        .I5(ap_rst_n),
        .O(\ap_CS_fsm_reg[1] ));
  design_1_muladd_0_0_muladd_control_s_axi_ram int_a
       (.ADDRARDADDR(int_a_address1),
        .D(p_0_in),
        .DOADO(DOADO),
        .DOBDO(DOBDO),
        .Q(Q),
        .a_q0(a_q0),
        .ap_clk(ap_clk),
        .\gen_write[1].mem_reg_0 (\FSM_onehot_rstate_reg[1]_0 ),
        .\gen_write[1].mem_reg_1 (int_a_write_reg_n_0),
        .\gen_write[1].mem_reg_2 (\FSM_onehot_wstate_reg_n_0_[2] ),
        .int_a_read(int_a_read),
        .int_b_q1(int_b_q1),
        .p_reg(tmp_product),
        .p_reg_0(p_reg),
        .p_reg_1(p_reg_0),
        .p_reg_10(p_reg_9),
        .p_reg_11(p_reg_10),
        .p_reg_12(p_reg_11),
        .p_reg_13(p_reg_12),
        .p_reg_14(p_reg_13),
        .p_reg_2(p_reg_1),
        .p_reg_3(p_reg_2),
        .p_reg_4(p_reg_3),
        .p_reg_5(p_reg_4),
        .p_reg_6(p_reg_5),
        .p_reg_7(p_reg_6),
        .p_reg_8(p_reg_7),
        .p_reg_9(p_reg_8),
        .\rdata_reg[0] (\rdata_reg[0]_0 ),
        .\rdata_reg[0]_0 (\rdata[0]_i_4_n_0 ),
        .\rdata_reg[10] (\rdata_reg[10]_0 ),
        .\rdata_reg[10]_0 (\rdata[10]_i_4_n_0 ),
        .\rdata_reg[11] (\rdata_reg[11]_0 ),
        .\rdata_reg[11]_0 (\rdata[11]_i_4_n_0 ),
        .\rdata_reg[12] (\rdata_reg[12]_0 ),
        .\rdata_reg[12]_0 (\rdata[12]_i_4_n_0 ),
        .\rdata_reg[13] (\rdata_reg[13]_0 ),
        .\rdata_reg[13]_0 (\rdata[13]_i_4_n_0 ),
        .\rdata_reg[14] (\rdata_reg[14]_0 ),
        .\rdata_reg[14]_0 (\rdata[14]_i_4_n_0 ),
        .\rdata_reg[15] (\rdata_reg[15]_0 ),
        .\rdata_reg[15]_0 (\rdata[15]_i_4_n_0 ),
        .\rdata_reg[16] (\rdata_reg[16]_0 ),
        .\rdata_reg[16]_0 (\rdata[16]_i_4_n_0 ),
        .\rdata_reg[17] (\rdata_reg[17]_0 ),
        .\rdata_reg[17]_0 (\rdata[17]_i_4_n_0 ),
        .\rdata_reg[18] (\rdata_reg[18]_0 ),
        .\rdata_reg[18]_0 (\rdata[18]_i_4_n_0 ),
        .\rdata_reg[19] (\rdata_reg[19]_0 ),
        .\rdata_reg[19]_0 (\rdata[19]_i_4_n_0 ),
        .\rdata_reg[1] (\rdata_reg[1]_0 ),
        .\rdata_reg[1]_0 (\rdata[1]_i_2_n_0 ),
        .\rdata_reg[20] (\rdata_reg[20]_0 ),
        .\rdata_reg[20]_0 (\rdata[20]_i_4_n_0 ),
        .\rdata_reg[21] (\rdata_reg[21]_0 ),
        .\rdata_reg[21]_0 (\rdata[21]_i_4_n_0 ),
        .\rdata_reg[22] (\rdata_reg[22]_0 ),
        .\rdata_reg[22]_0 (\rdata[22]_i_4_n_0 ),
        .\rdata_reg[23] (\rdata_reg[23]_0 ),
        .\rdata_reg[23]_0 (\rdata[23]_i_4_n_0 ),
        .\rdata_reg[24] (\rdata_reg[24]_0 ),
        .\rdata_reg[24]_0 (\rdata[24]_i_4_n_0 ),
        .\rdata_reg[25] (\rdata_reg[25]_0 ),
        .\rdata_reg[25]_0 (\rdata[25]_i_4_n_0 ),
        .\rdata_reg[26] (\rdata_reg[26]_0 ),
        .\rdata_reg[26]_0 (\rdata[26]_i_4_n_0 ),
        .\rdata_reg[27] (\rdata_reg[27]_0 ),
        .\rdata_reg[27]_0 (\rdata[27]_i_4_n_0 ),
        .\rdata_reg[28] (\rdata_reg[28]_0 ),
        .\rdata_reg[28]_0 (\rdata[28]_i_4_n_0 ),
        .\rdata_reg[29] (\rdata_reg[29]_0 ),
        .\rdata_reg[29]_0 (\rdata[29]_i_4_n_0 ),
        .\rdata_reg[2] (\rdata_reg[2]_0 ),
        .\rdata_reg[2]_0 (\rdata[2]_i_4_n_0 ),
        .\rdata_reg[30] (\rdata_reg[30]_0 ),
        .\rdata_reg[30]_0 (\rdata[30]_i_4_n_0 ),
        .\rdata_reg[31] (\rdata_reg[31]_0 ),
        .\rdata_reg[31]_0 (\rdata_reg[31]_1 ),
        .\rdata_reg[31]_1 (\rdata[31]_i_5_n_0 ),
        .\rdata_reg[3] (\rdata_reg[3]_0 ),
        .\rdata_reg[3]_0 (\rdata[3]_i_4_n_0 ),
        .\rdata_reg[4] (\rdata_reg[4]_0 ),
        .\rdata_reg[4]_0 (\rdata[4]_i_4_n_0 ),
        .\rdata_reg[5] (\rdata_reg[5]_0 ),
        .\rdata_reg[5]_0 (\rdata[5]_i_4_n_0 ),
        .\rdata_reg[6] (\rdata_reg[6]_0 ),
        .\rdata_reg[6]_0 (\rdata[6]_i_4_n_0 ),
        .\rdata_reg[7] (\rdata_reg[7]_0 ),
        .\rdata_reg[7]_0 (\rdata[7]_i_4_n_0 ),
        .\rdata_reg[8] (\rdata_reg[8]_0 ),
        .\rdata_reg[8]_0 (\rdata[8]_i_4_n_0 ),
        .\rdata_reg[9] (\rdata_reg[9]_0 ),
        .\rdata_reg[9]_0 (\rdata[9]_i_4_n_0 ),
        .s_axi_control_ARVALID(s_axi_control_ARVALID),
        .s_axi_control_WDATA(s_axi_control_WDATA),
        .s_axi_control_WSTRB(s_axi_control_WSTRB),
        .s_axi_control_WVALID(s_axi_control_WVALID),
        .tmp_product__0(tmp_product__0),
        .tmp_product__0_0(tmp_product__0_0),
        .tmp_product__0_1(tmp_product__0_1),
        .tmp_product__0_10(tmp_product__0_10),
        .tmp_product__0_11(tmp_product__0_11),
        .tmp_product__0_12(tmp_product__0_12),
        .tmp_product__0_13(tmp_product__0_13),
        .tmp_product__0_14(tmp_product__0_14),
        .tmp_product__0_15(tmp_product__0_15),
        .tmp_product__0_2(tmp_product__0_2),
        .tmp_product__0_3(tmp_product__0_3),
        .tmp_product__0_4(tmp_product__0_4),
        .tmp_product__0_5(tmp_product__0_5),
        .tmp_product__0_6(tmp_product__0_6),
        .tmp_product__0_7(tmp_product__0_7),
        .tmp_product__0_8(tmp_product__0_8),
        .tmp_product__0_9(tmp_product__0_9));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    int_a_read_i_1
       (.I0(s_axi_control_ARADDR[7]),
        .I1(s_axi_control_ARADDR[6]),
        .I2(\FSM_onehot_rstate_reg[1]_0 ),
        .I3(s_axi_control_ARVALID),
        .O(int_a_read0));
  FDRE int_a_read_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_a_read0),
        .Q(int_a_read),
        .R(ap_rst_n_inv));
  LUT6 #(
    .INIT(64'hFFFF400040004000)) 
    int_a_write_i_1
       (.I0(s_axi_control_AWADDR[7]),
        .I1(s_axi_control_AWADDR[6]),
        .I2(s_axi_control_AWVALID),
        .I3(\FSM_onehot_wstate_reg[1]_0 ),
        .I4(int_a_write_i_2_n_0),
        .I5(int_a_write_reg_n_0),
        .O(int_a_write_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h8FFF)) 
    int_a_write_i_2
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .I2(\FSM_onehot_wstate_reg_n_0_[2] ),
        .I3(s_axi_control_WVALID),
        .O(int_a_write_i_2_n_0));
  FDRE int_a_write_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_a_write_i_1_n_0),
        .Q(int_a_write_reg_n_0),
        .R(ap_rst_n_inv));
  LUT4 #(
    .INIT(16'hFEAA)) 
    int_ap_done_i_1
       (.I0(int_ap_ready_reg_0[2]),
        .I1(int_ap_done_i_2_n_0),
        .I2(s_axi_control_ARADDR[4]),
        .I3(int_ap_done),
        .O(int_ap_done_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hFFF7)) 
    int_ap_done_i_2
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .I2(s_axi_control_ARADDR[2]),
        .I3(\rdata[31]_i_10_n_0 ),
        .O(int_ap_done_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    int_ap_done_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_ap_done_i_1_n_0),
        .Q(int_ap_done),
        .R(ap_rst_n_inv));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h2)) 
    int_ap_idle_i_1
       (.I0(int_ap_ready_reg_0[0]),
        .I1(ap_start),
        .O(ap_idle));
  FDRE int_ap_idle_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(ap_idle),
        .Q(int_ap_idle),
        .R(ap_rst_n_inv));
  FDRE int_ap_ready_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_ap_ready_reg_0[2]),
        .Q(int_ap_ready),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[0] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [0]),
        .Q(int_ap_return[0]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[10] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [10]),
        .Q(int_ap_return[10]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[11] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [11]),
        .Q(int_ap_return[11]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[12] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [12]),
        .Q(int_ap_return[12]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[13] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [13]),
        .Q(int_ap_return[13]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[14] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [14]),
        .Q(int_ap_return[14]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[15] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [15]),
        .Q(int_ap_return[15]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[16] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [16]),
        .Q(int_ap_return[16]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[17] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [17]),
        .Q(int_ap_return[17]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[18] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [18]),
        .Q(int_ap_return[18]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[19] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [19]),
        .Q(int_ap_return[19]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[1] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [1]),
        .Q(int_ap_return[1]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[20] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [20]),
        .Q(int_ap_return[20]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[21] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [21]),
        .Q(int_ap_return[21]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[22] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [22]),
        .Q(int_ap_return[22]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[23] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [23]),
        .Q(int_ap_return[23]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[24] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [24]),
        .Q(int_ap_return[24]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[25] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [25]),
        .Q(int_ap_return[25]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[26] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [26]),
        .Q(int_ap_return[26]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[27] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [27]),
        .Q(int_ap_return[27]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[28] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [28]),
        .Q(int_ap_return[28]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[29] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [29]),
        .Q(int_ap_return[29]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[2] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [2]),
        .Q(int_ap_return[2]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[30] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [30]),
        .Q(int_ap_return[30]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[31] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [31]),
        .Q(int_ap_return[31]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[3] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [3]),
        .Q(int_ap_return[3]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[4] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [4]),
        .Q(int_ap_return[4]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[5] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [5]),
        .Q(int_ap_return[5]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[6] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [6]),
        .Q(int_ap_return[6]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[7] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [7]),
        .Q(int_ap_return[7]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[8] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [8]),
        .Q(int_ap_return[8]),
        .R(ap_rst_n_inv));
  FDRE \int_ap_return_reg[9] 
       (.C(ap_clk),
        .CE(int_ap_ready_reg_0[2]),
        .D(\int_ap_return_reg[31]_0 [9]),
        .Q(int_ap_return[9]),
        .R(ap_rst_n_inv));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'hFBF8)) 
    int_ap_start_i_1
       (.I0(int_auto_restart),
        .I1(int_ap_ready_reg_0[2]),
        .I2(int_ap_start3_out),
        .I3(ap_start),
        .O(int_ap_start_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h2000)) 
    int_ap_start_i_2
       (.I0(s_axi_control_WDATA[0]),
        .I1(\waddr_reg_n_0_[2] ),
        .I2(s_axi_control_WSTRB[0]),
        .I3(int_auto_restart_i_2_n_0),
        .O(int_ap_start3_out));
  FDRE #(
    .INIT(1'b0)) 
    int_ap_start_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_ap_start_i_1_n_0),
        .Q(ap_start),
        .R(ap_rst_n_inv));
  LUT5 #(
    .INIT(32'hFFBF0080)) 
    int_auto_restart_i_1
       (.I0(s_axi_control_WDATA[7]),
        .I1(int_auto_restart_i_2_n_0),
        .I2(s_axi_control_WSTRB[0]),
        .I3(\waddr_reg_n_0_[2] ),
        .I4(int_auto_restart),
        .O(int_auto_restart_i_1_n_0));
  LUT6 #(
    .INIT(64'h0111000000000000)) 
    int_auto_restart_i_2
       (.I0(\waddr_reg_n_0_[3] ),
        .I1(\int_ier[1]_i_3_n_0 ),
        .I2(s_axi_control_ARVALID),
        .I3(\FSM_onehot_rstate_reg[1]_0 ),
        .I4(\FSM_onehot_wstate_reg_n_0_[2] ),
        .I5(s_axi_control_WVALID),
        .O(int_auto_restart_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    int_auto_restart_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_auto_restart_i_1_n_0),
        .Q(int_auto_restart),
        .R(ap_rst_n_inv));
  design_1_muladd_0_0_muladd_control_s_axi_ram_0 int_b
       (.ADDRARDADDR(int_a_address1),
        .Q(Q),
        .ap_clk(ap_clk),
        .b_q0(b_q0),
        .\gen_write[1].mem_reg_0 (\gen_write[1].mem_reg ),
        .\gen_write[1].mem_reg_1 (\gen_write[1].mem_reg_0 ),
        .\gen_write[1].mem_reg_2 ({\waddr_reg_n_0_[5] ,\waddr_reg_n_0_[4] ,\waddr_reg_n_0_[3] ,\waddr_reg_n_0_[2] }),
        .\gen_write[1].mem_reg_3 (\FSM_onehot_rstate_reg[1]_0 ),
        .\gen_write[1].mem_reg_4 (int_b_write_reg_n_0),
        .\gen_write[1].mem_reg_5 (\FSM_onehot_wstate_reg_n_0_[2] ),
        .int_b_q1(int_b_q1),
        .\rdata_reg[0] (\rdata_reg[0]_1 ),
        .\rdata_reg[10] (\rdata_reg[10]_1 ),
        .\rdata_reg[11] (\rdata_reg[11]_1 ),
        .\rdata_reg[12] (\rdata_reg[12]_1 ),
        .\rdata_reg[13] (\rdata_reg[13]_1 ),
        .\rdata_reg[14] (\rdata_reg[14]_1 ),
        .\rdata_reg[15] (\rdata_reg[15]_1 ),
        .\rdata_reg[16] (\rdata_reg[16]_1 ),
        .\rdata_reg[17] (\rdata_reg[17]_1 ),
        .\rdata_reg[18] (\rdata_reg[18]_1 ),
        .\rdata_reg[19] (\rdata_reg[19]_1 ),
        .\rdata_reg[1] (\rdata_reg[1]_1 ),
        .\rdata_reg[20] (\rdata_reg[20]_1 ),
        .\rdata_reg[21] (\rdata_reg[21]_1 ),
        .\rdata_reg[22] (\rdata_reg[22]_1 ),
        .\rdata_reg[23] (\rdata_reg[23]_1 ),
        .\rdata_reg[24] (\rdata_reg[24]_1 ),
        .\rdata_reg[25] (\rdata_reg[25]_1 ),
        .\rdata_reg[26] (\rdata_reg[26]_1 ),
        .\rdata_reg[27] (\rdata_reg[27]_1 ),
        .\rdata_reg[28] (\rdata_reg[28]_1 ),
        .\rdata_reg[29] (\rdata_reg[29]_1 ),
        .\rdata_reg[2] (\rdata_reg[2]_1 ),
        .\rdata_reg[30] (\rdata_reg[30]_1 ),
        .\rdata_reg[31] (\rdata_reg[31]_2 ),
        .\rdata_reg[31]_0 (\rdata_reg[31]_3 ),
        .\rdata_reg[3] (\rdata_reg[3]_1 ),
        .\rdata_reg[4] (\rdata_reg[4]_1 ),
        .\rdata_reg[5] (\rdata_reg[5]_1 ),
        .\rdata_reg[6] (\rdata_reg[6]_1 ),
        .\rdata_reg[7] (\rdata_reg[7]_1 ),
        .\rdata_reg[8] (\rdata_reg[8]_1 ),
        .\rdata_reg[9] (\rdata_reg[9]_1 ),
        .s_axi_control_ARADDR(s_axi_control_ARADDR[5:2]),
        .s_axi_control_ARVALID(s_axi_control_ARVALID),
        .s_axi_control_WDATA(s_axi_control_WDATA),
        .s_axi_control_WSTRB(s_axi_control_WSTRB),
        .s_axi_control_WVALID(s_axi_control_WVALID),
        .tmp_product(tmp_product),
        .tmp_product_0(tmp_product_0),
        .tmp_product_1(tmp_product_1),
        .tmp_product_10(tmp_product_10),
        .tmp_product_11(tmp_product_11),
        .tmp_product_12(tmp_product_12),
        .tmp_product_13(tmp_product_13),
        .tmp_product_14(tmp_product_14),
        .tmp_product_2(tmp_product_2),
        .tmp_product_3(tmp_product_3),
        .tmp_product_4(tmp_product_4),
        .tmp_product_5(tmp_product_5),
        .tmp_product_6(tmp_product_6),
        .tmp_product_7(tmp_product_7),
        .tmp_product_8(tmp_product_8),
        .tmp_product_9(tmp_product_9),
        .tmp_product__0(tmp_product__0_16),
        .tmp_product__0_0(tmp_product__0_17),
        .tmp_product__0_1(tmp_product__0_18),
        .tmp_product__0_10(tmp_product__0_27),
        .tmp_product__0_11(tmp_product__0_28),
        .tmp_product__0_12(tmp_product__0_29),
        .tmp_product__0_13(tmp_product__0_30),
        .tmp_product__0_14(tmp_product__0_31),
        .tmp_product__0_15(tmp_product__0_32),
        .tmp_product__0_2(tmp_product__0_19),
        .tmp_product__0_3(tmp_product__0_20),
        .tmp_product__0_4(tmp_product__0_21),
        .tmp_product__0_5(tmp_product__0_22),
        .tmp_product__0_6(tmp_product__0_23),
        .tmp_product__0_7(tmp_product__0_24),
        .tmp_product__0_8(tmp_product__0_25),
        .tmp_product__0_9(tmp_product__0_26));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    int_b_read_i_1
       (.I0(s_axi_control_ARADDR[6]),
        .I1(s_axi_control_ARADDR[7]),
        .I2(\FSM_onehot_rstate_reg[1]_0 ),
        .I3(s_axi_control_ARVALID),
        .O(int_b_read0));
  FDRE int_b_read_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_b_read0),
        .Q(int_b_read),
        .R(ap_rst_n_inv));
  LUT6 #(
    .INIT(64'hFFFF400040004000)) 
    int_b_write_i_1
       (.I0(s_axi_control_AWADDR[6]),
        .I1(s_axi_control_AWADDR[7]),
        .I2(s_axi_control_AWVALID),
        .I3(\FSM_onehot_wstate_reg[1]_0 ),
        .I4(int_a_write_i_2_n_0),
        .I5(int_b_write_reg_n_0),
        .O(int_b_write_i_1_n_0));
  FDRE int_b_write_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_b_write_i_1_n_0),
        .Q(int_b_write_reg_n_0),
        .R(ap_rst_n_inv));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT5 #(
    .INIT(32'hBFFF8000)) 
    int_gie_i_1
       (.I0(s_axi_control_WDATA[0]),
        .I1(int_auto_restart_i_2_n_0),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(s_axi_control_WSTRB[0]),
        .I4(int_gie_reg_n_0),
        .O(int_gie_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    int_gie_reg
       (.C(ap_clk),
        .CE(1'b1),
        .D(int_gie_i_1_n_0),
        .Q(int_gie_reg_n_0),
        .R(ap_rst_n_inv));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \int_ier[0]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(\int_ier[1]_i_2_n_0 ),
        .I4(\int_ier_reg_n_0_[0] ),
        .O(\int_ier[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \int_ier[1]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\waddr_reg_n_0_[2] ),
        .I3(\int_ier[1]_i_2_n_0 ),
        .I4(\int_ier_reg_n_0_[1] ),
        .O(\int_ier[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hEAFFFFFFFFFFFFFF)) 
    \int_ier[1]_i_2 
       (.I0(\int_ier[1]_i_3_n_0 ),
        .I1(s_axi_control_ARVALID),
        .I2(\FSM_onehot_rstate_reg[1]_0 ),
        .I3(\FSM_onehot_wstate_reg_n_0_[2] ),
        .I4(s_axi_control_WVALID),
        .I5(\waddr_reg_n_0_[3] ),
        .O(\int_ier[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \int_ier[1]_i_3 
       (.I0(\waddr_reg_n_0_[7] ),
        .I1(\waddr_reg_n_0_[1] ),
        .I2(\waddr_reg_n_0_[0] ),
        .I3(\waddr_reg_n_0_[6] ),
        .I4(\waddr_reg_n_0_[4] ),
        .I5(\waddr_reg_n_0_[5] ),
        .O(\int_ier[1]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \int_ier_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_ier[0]_i_1_n_0 ),
        .Q(\int_ier_reg_n_0_[0] ),
        .R(ap_rst_n_inv));
  FDRE #(
    .INIT(1'b0)) 
    \int_ier_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_ier[1]_i_1_n_0 ),
        .Q(\int_ier_reg_n_0_[1] ),
        .R(ap_rst_n_inv));
  LUT5 #(
    .INIT(32'hF777F888)) 
    \int_isr[0]_i_1 
       (.I0(s_axi_control_WDATA[0]),
        .I1(int_isr6_out),
        .I2(\int_ier_reg_n_0_[0] ),
        .I3(int_ap_ready_reg_0[2]),
        .I4(p_1_in0_in[0]),
        .O(\int_isr[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \int_isr[0]_i_2 
       (.I0(\waddr_reg_n_0_[2] ),
        .I1(s_axi_control_WSTRB[0]),
        .I2(\int_ier[1]_i_2_n_0 ),
        .O(int_isr6_out));
  LUT5 #(
    .INIT(32'hF777F888)) 
    \int_isr[1]_i_1 
       (.I0(s_axi_control_WDATA[1]),
        .I1(int_isr6_out),
        .I2(\int_ier_reg_n_0_[1] ),
        .I3(int_ap_ready_reg_0[2]),
        .I4(p_1_in0_in[1]),
        .O(\int_isr[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \int_isr_reg[0] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_isr[0]_i_1_n_0 ),
        .Q(p_1_in0_in[0]),
        .R(ap_rst_n_inv));
  FDRE #(
    .INIT(1'b0)) 
    \int_isr_reg[1] 
       (.C(ap_clk),
        .CE(1'b1),
        .D(\int_isr[1]_i_1_n_0 ),
        .Q(p_1_in0_in[1]),
        .R(ap_rst_n_inv));
  LUT3 #(
    .INIT(8'hA8)) 
    interrupt_INST_0
       (.I0(int_gie_reg_n_0),
        .I1(p_1_in0_in[1]),
        .I2(p_1_in0_in[0]),
        .O(interrupt));
  LUT6 #(
    .INIT(64'h00000000222E2222)) 
    \rdata[0]_i_4 
       (.I0(\rdata[0]_i_7_n_0 ),
        .I1(s_axi_control_ARADDR[4]),
        .I2(s_axi_control_ARADDR[2]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(int_ap_return[0]),
        .I5(\rdata[1]_i_5_n_0 ),
        .O(\rdata[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \rdata[0]_i_7 
       (.I0(p_1_in0_in[0]),
        .I1(\int_ier_reg_n_0_[0] ),
        .I2(s_axi_control_ARADDR[3]),
        .I3(int_gie_reg_n_0),
        .I4(s_axi_control_ARADDR[2]),
        .I5(ap_start),
        .O(\rdata[0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[10]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[10]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[10]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[11]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[11]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[11]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[12]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[12]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[12]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[13]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[13]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[13]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[14]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[14]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[14]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[15]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[15]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[15]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[16]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[16]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[16]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[17]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[17]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[17]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[18]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[18]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[18]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[19]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[19]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[19]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000001005555)) 
    \rdata[1]_i_2 
       (.I0(\rdata[1]_i_5_n_0 ),
        .I1(s_axi_control_ARADDR[2]),
        .I2(s_axi_control_ARADDR[3]),
        .I3(int_ap_return[1]),
        .I4(s_axi_control_ARADDR[4]),
        .I5(\rdata[1]_i_6_n_0 ),
        .O(\rdata[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \rdata[1]_i_5 
       (.I0(\rdata[31]_i_11_n_0 ),
        .I1(s_axi_control_ARADDR[6]),
        .I2(s_axi_control_ARADDR[5]),
        .I3(s_axi_control_ARADDR[7]),
        .I4(s_axi_control_ARADDR[0]),
        .I5(s_axi_control_ARADDR[1]),
        .O(\rdata[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h53F053F053F053FF)) 
    \rdata[1]_i_6 
       (.I0(p_1_in0_in[1]),
        .I1(\int_ier_reg_n_0_[1] ),
        .I2(s_axi_control_ARADDR[2]),
        .I3(s_axi_control_ARADDR[3]),
        .I4(s_axi_control_ARADDR[4]),
        .I5(int_ap_done),
        .O(\rdata[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[20]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[20]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[20]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[21]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[21]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[21]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[22]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[22]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[22]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[23]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[23]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[23]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[24]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[24]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[24]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[25]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[25]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[25]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[26]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[26]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[26]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[27]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[27]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[27]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[28]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[28]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[28]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[29]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[29]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[29]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \rdata[2]_i_4 
       (.I0(int_ap_idle),
        .I1(s_axi_control_ARADDR[4]),
        .I2(int_ap_return[2]),
        .I3(int_ap_done_i_2_n_0),
        .O(\rdata[2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[30]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[30]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[30]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFEEE)) 
    \rdata[31]_i_1 
       (.I0(int_b_read),
        .I1(int_a_read),
        .I2(\FSM_onehot_rstate_reg[1]_0 ),
        .I3(s_axi_control_ARVALID),
        .O(\rdata[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \rdata[31]_i_10 
       (.I0(s_axi_control_ARADDR[3]),
        .I1(s_axi_control_ARADDR[6]),
        .I2(s_axi_control_ARADDR[5]),
        .I3(s_axi_control_ARADDR[7]),
        .I4(s_axi_control_ARADDR[0]),
        .I5(s_axi_control_ARADDR[1]),
        .O(\rdata[31]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \rdata[31]_i_11 
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .O(\rdata[31]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[31]_i_12 
       (.I0(int_a_write_reg_n_0),
        .I1(s_axi_control_WVALID),
        .I2(s_axi_control_ARVALID),
        .I3(\FSM_onehot_rstate_reg[1]_0 ),
        .O(int_a_write_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'hF888)) 
    \rdata[31]_i_13 
       (.I0(int_b_write_reg_n_0),
        .I1(s_axi_control_WVALID),
        .I2(s_axi_control_ARVALID),
        .I3(\FSM_onehot_rstate_reg[1]_0 ),
        .O(int_b_write_reg_0));
  LUT6 #(
    .INIT(64'h0202000200000000)) 
    \rdata[31]_i_5 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(\rdata[31]_i_11_n_0 ),
        .I3(s_axi_control_ARADDR[2]),
        .I4(s_axi_control_ARADDR[3]),
        .I5(int_ap_return[31]),
        .O(\rdata[31]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \rdata[3]_i_4 
       (.I0(int_ap_ready),
        .I1(s_axi_control_ARADDR[4]),
        .I2(int_ap_return[3]),
        .I3(int_ap_done_i_2_n_0),
        .O(\rdata[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[4]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[4]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[4]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[5]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[5]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[6]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[6]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[6]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \rdata[7]_i_4 
       (.I0(int_auto_restart),
        .I1(s_axi_control_ARADDR[4]),
        .I2(int_ap_return[7]),
        .I3(int_ap_done_i_2_n_0),
        .O(\rdata[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[8]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[8]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[8]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0020002000000020)) 
    \rdata[9]_i_4 
       (.I0(s_axi_control_ARADDR[4]),
        .I1(\rdata[31]_i_10_n_0 ),
        .I2(int_ap_return[9]),
        .I3(\rdata[31]_i_11_n_0 ),
        .I4(s_axi_control_ARADDR[2]),
        .I5(s_axi_control_ARADDR[3]),
        .O(\rdata[9]_i_4_n_0 ));
  FDRE \rdata_reg[0] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[0]),
        .Q(s_axi_control_RDATA[0]),
        .R(1'b0));
  FDRE \rdata_reg[10] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[10]),
        .Q(s_axi_control_RDATA[10]),
        .R(1'b0));
  FDRE \rdata_reg[11] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[11]),
        .Q(s_axi_control_RDATA[11]),
        .R(1'b0));
  FDRE \rdata_reg[12] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[12]),
        .Q(s_axi_control_RDATA[12]),
        .R(1'b0));
  FDRE \rdata_reg[13] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[13]),
        .Q(s_axi_control_RDATA[13]),
        .R(1'b0));
  FDRE \rdata_reg[14] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[14]),
        .Q(s_axi_control_RDATA[14]),
        .R(1'b0));
  FDRE \rdata_reg[15] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[15]),
        .Q(s_axi_control_RDATA[15]),
        .R(1'b0));
  FDRE \rdata_reg[16] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[16]),
        .Q(s_axi_control_RDATA[16]),
        .R(1'b0));
  FDRE \rdata_reg[17] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[17]),
        .Q(s_axi_control_RDATA[17]),
        .R(1'b0));
  FDRE \rdata_reg[18] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[18]),
        .Q(s_axi_control_RDATA[18]),
        .R(1'b0));
  FDRE \rdata_reg[19] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[19]),
        .Q(s_axi_control_RDATA[19]),
        .R(1'b0));
  FDRE \rdata_reg[1] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[1]),
        .Q(s_axi_control_RDATA[1]),
        .R(1'b0));
  FDRE \rdata_reg[20] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[20]),
        .Q(s_axi_control_RDATA[20]),
        .R(1'b0));
  FDRE \rdata_reg[21] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[21]),
        .Q(s_axi_control_RDATA[21]),
        .R(1'b0));
  FDRE \rdata_reg[22] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[22]),
        .Q(s_axi_control_RDATA[22]),
        .R(1'b0));
  FDRE \rdata_reg[23] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[23]),
        .Q(s_axi_control_RDATA[23]),
        .R(1'b0));
  FDRE \rdata_reg[24] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[24]),
        .Q(s_axi_control_RDATA[24]),
        .R(1'b0));
  FDRE \rdata_reg[25] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[25]),
        .Q(s_axi_control_RDATA[25]),
        .R(1'b0));
  FDRE \rdata_reg[26] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[26]),
        .Q(s_axi_control_RDATA[26]),
        .R(1'b0));
  FDRE \rdata_reg[27] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[27]),
        .Q(s_axi_control_RDATA[27]),
        .R(1'b0));
  FDRE \rdata_reg[28] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[28]),
        .Q(s_axi_control_RDATA[28]),
        .R(1'b0));
  FDRE \rdata_reg[29] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[29]),
        .Q(s_axi_control_RDATA[29]),
        .R(1'b0));
  FDRE \rdata_reg[2] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[2]),
        .Q(s_axi_control_RDATA[2]),
        .R(1'b0));
  FDRE \rdata_reg[30] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[30]),
        .Q(s_axi_control_RDATA[30]),
        .R(1'b0));
  FDRE \rdata_reg[31] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[31]),
        .Q(s_axi_control_RDATA[31]),
        .R(1'b0));
  FDRE \rdata_reg[3] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[3]),
        .Q(s_axi_control_RDATA[3]),
        .R(1'b0));
  FDRE \rdata_reg[4] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[4]),
        .Q(s_axi_control_RDATA[4]),
        .R(1'b0));
  FDRE \rdata_reg[5] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[5]),
        .Q(s_axi_control_RDATA[5]),
        .R(1'b0));
  FDRE \rdata_reg[6] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[6]),
        .Q(s_axi_control_RDATA[6]),
        .R(1'b0));
  FDRE \rdata_reg[7] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[7]),
        .Q(s_axi_control_RDATA[7]),
        .R(1'b0));
  FDRE \rdata_reg[8] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[8]),
        .Q(s_axi_control_RDATA[8]),
        .R(1'b0));
  FDRE \rdata_reg[9] 
       (.C(ap_clk),
        .CE(\rdata[31]_i_1_n_0 ),
        .D(p_0_in[9]),
        .Q(s_axi_control_RDATA[9]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h02)) 
    s_axi_control_RVALID_INST_0
       (.I0(\FSM_onehot_rstate_reg_n_0_[2] ),
        .I1(int_b_read),
        .I2(int_a_read),
        .O(s_axi_control_RVALID));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'h70)) 
    s_axi_control_WREADY_INST_0
       (.I0(s_axi_control_ARVALID),
        .I1(\FSM_onehot_rstate_reg[1]_0 ),
        .I2(\FSM_onehot_wstate_reg_n_0_[2] ),
        .O(s_axi_control_WREADY));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \temp_reg_93[0]_i_1 
       (.I0(int_ap_ready_reg_0[0]),
        .I1(ap_start),
        .O(ap_NS_fsm1));
  LUT2 #(
    .INIT(4'h8)) 
    \waddr[7]_i_1 
       (.I0(s_axi_control_AWVALID),
        .I1(\FSM_onehot_wstate_reg[1]_0 ),
        .O(aw_hs));
  FDRE \waddr_reg[0] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[0]),
        .Q(\waddr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \waddr_reg[1] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[1]),
        .Q(\waddr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \waddr_reg[2] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[2]),
        .Q(\waddr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \waddr_reg[3] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[3]),
        .Q(\waddr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \waddr_reg[4] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[4]),
        .Q(\waddr_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \waddr_reg[5] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[5]),
        .Q(\waddr_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \waddr_reg[6] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[6]),
        .Q(\waddr_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \waddr_reg[7] 
       (.C(ap_clk),
        .CE(aw_hs),
        .D(s_axi_control_AWADDR[7]),
        .Q(\waddr_reg_n_0_[7] ),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "muladd_control_s_axi_ram" *) 
module design_1_muladd_0_0_muladd_control_s_axi_ram
   (DOADO,
    DOBDO,
    a_q0,
    D,
    ap_clk,
    ADDRARDADDR,
    Q,
    s_axi_control_WDATA,
    \rdata_reg[31] ,
    \rdata_reg[0] ,
    \rdata_reg[1] ,
    \rdata_reg[2] ,
    \rdata_reg[3] ,
    \rdata_reg[4] ,
    \rdata_reg[5] ,
    \rdata_reg[6] ,
    \rdata_reg[7] ,
    \rdata_reg[8] ,
    \rdata_reg[9] ,
    \rdata_reg[10] ,
    \rdata_reg[11] ,
    \rdata_reg[12] ,
    \rdata_reg[13] ,
    \rdata_reg[14] ,
    \rdata_reg[15] ,
    \rdata_reg[16] ,
    \rdata_reg[17] ,
    \rdata_reg[18] ,
    \rdata_reg[19] ,
    \rdata_reg[20] ,
    \rdata_reg[21] ,
    \rdata_reg[22] ,
    \rdata_reg[23] ,
    \rdata_reg[24] ,
    \rdata_reg[25] ,
    \rdata_reg[26] ,
    \rdata_reg[27] ,
    \rdata_reg[28] ,
    \rdata_reg[29] ,
    \rdata_reg[30] ,
    \rdata_reg[31]_0 ,
    p_reg,
    tmp_product__0,
    tmp_product__0_0,
    tmp_product__0_1,
    tmp_product__0_2,
    tmp_product__0_3,
    tmp_product__0_4,
    tmp_product__0_5,
    tmp_product__0_6,
    tmp_product__0_7,
    tmp_product__0_8,
    tmp_product__0_9,
    tmp_product__0_10,
    tmp_product__0_11,
    tmp_product__0_12,
    tmp_product__0_13,
    tmp_product__0_14,
    tmp_product__0_15,
    p_reg_0,
    p_reg_1,
    p_reg_2,
    p_reg_3,
    p_reg_4,
    p_reg_5,
    p_reg_6,
    p_reg_7,
    p_reg_8,
    p_reg_9,
    p_reg_10,
    p_reg_11,
    p_reg_12,
    p_reg_13,
    p_reg_14,
    int_a_read,
    int_b_q1,
    s_axi_control_ARVALID,
    \gen_write[1].mem_reg_0 ,
    \rdata_reg[0]_0 ,
    \rdata_reg[1]_0 ,
    \rdata_reg[2]_0 ,
    \rdata_reg[3]_0 ,
    \rdata_reg[4]_0 ,
    \rdata_reg[5]_0 ,
    \rdata_reg[6]_0 ,
    \rdata_reg[7]_0 ,
    \rdata_reg[8]_0 ,
    \rdata_reg[9]_0 ,
    \rdata_reg[10]_0 ,
    \rdata_reg[11]_0 ,
    \rdata_reg[12]_0 ,
    \rdata_reg[13]_0 ,
    \rdata_reg[14]_0 ,
    \rdata_reg[15]_0 ,
    \rdata_reg[16]_0 ,
    \rdata_reg[17]_0 ,
    \rdata_reg[18]_0 ,
    \rdata_reg[19]_0 ,
    \rdata_reg[20]_0 ,
    \rdata_reg[21]_0 ,
    \rdata_reg[22]_0 ,
    \rdata_reg[23]_0 ,
    \rdata_reg[24]_0 ,
    \rdata_reg[25]_0 ,
    \rdata_reg[26]_0 ,
    \rdata_reg[27]_0 ,
    \rdata_reg[28]_0 ,
    \rdata_reg[29]_0 ,
    \rdata_reg[30]_0 ,
    \rdata_reg[31]_1 ,
    s_axi_control_WSTRB,
    \gen_write[1].mem_reg_1 ,
    \gen_write[1].mem_reg_2 ,
    s_axi_control_WVALID);
  output [31:0]DOADO;
  output [31:0]DOBDO;
  output [31:0]a_q0;
  output [31:0]D;
  input ap_clk;
  input [3:0]ADDRARDADDR;
  input [3:0]Q;
  input [31:0]s_axi_control_WDATA;
  input \rdata_reg[31] ;
  input \rdata_reg[0] ;
  input \rdata_reg[1] ;
  input \rdata_reg[2] ;
  input \rdata_reg[3] ;
  input \rdata_reg[4] ;
  input \rdata_reg[5] ;
  input \rdata_reg[6] ;
  input \rdata_reg[7] ;
  input \rdata_reg[8] ;
  input \rdata_reg[9] ;
  input \rdata_reg[10] ;
  input \rdata_reg[11] ;
  input \rdata_reg[12] ;
  input \rdata_reg[13] ;
  input \rdata_reg[14] ;
  input \rdata_reg[15] ;
  input \rdata_reg[16] ;
  input \rdata_reg[17] ;
  input \rdata_reg[18] ;
  input \rdata_reg[19] ;
  input \rdata_reg[20] ;
  input \rdata_reg[21] ;
  input \rdata_reg[22] ;
  input \rdata_reg[23] ;
  input \rdata_reg[24] ;
  input \rdata_reg[25] ;
  input \rdata_reg[26] ;
  input \rdata_reg[27] ;
  input \rdata_reg[28] ;
  input \rdata_reg[29] ;
  input \rdata_reg[30] ;
  input \rdata_reg[31]_0 ;
  input p_reg;
  input tmp_product__0;
  input tmp_product__0_0;
  input tmp_product__0_1;
  input tmp_product__0_2;
  input tmp_product__0_3;
  input tmp_product__0_4;
  input tmp_product__0_5;
  input tmp_product__0_6;
  input tmp_product__0_7;
  input tmp_product__0_8;
  input tmp_product__0_9;
  input tmp_product__0_10;
  input tmp_product__0_11;
  input tmp_product__0_12;
  input tmp_product__0_13;
  input tmp_product__0_14;
  input tmp_product__0_15;
  input p_reg_0;
  input p_reg_1;
  input p_reg_2;
  input p_reg_3;
  input p_reg_4;
  input p_reg_5;
  input p_reg_6;
  input p_reg_7;
  input p_reg_8;
  input p_reg_9;
  input p_reg_10;
  input p_reg_11;
  input p_reg_12;
  input p_reg_13;
  input p_reg_14;
  input int_a_read;
  input [31:0]int_b_q1;
  input s_axi_control_ARVALID;
  input \gen_write[1].mem_reg_0 ;
  input \rdata_reg[0]_0 ;
  input \rdata_reg[1]_0 ;
  input \rdata_reg[2]_0 ;
  input \rdata_reg[3]_0 ;
  input \rdata_reg[4]_0 ;
  input \rdata_reg[5]_0 ;
  input \rdata_reg[6]_0 ;
  input \rdata_reg[7]_0 ;
  input \rdata_reg[8]_0 ;
  input \rdata_reg[9]_0 ;
  input \rdata_reg[10]_0 ;
  input \rdata_reg[11]_0 ;
  input \rdata_reg[12]_0 ;
  input \rdata_reg[13]_0 ;
  input \rdata_reg[14]_0 ;
  input \rdata_reg[15]_0 ;
  input \rdata_reg[16]_0 ;
  input \rdata_reg[17]_0 ;
  input \rdata_reg[18]_0 ;
  input \rdata_reg[19]_0 ;
  input \rdata_reg[20]_0 ;
  input \rdata_reg[21]_0 ;
  input \rdata_reg[22]_0 ;
  input \rdata_reg[23]_0 ;
  input \rdata_reg[24]_0 ;
  input \rdata_reg[25]_0 ;
  input \rdata_reg[26]_0 ;
  input \rdata_reg[27]_0 ;
  input \rdata_reg[28]_0 ;
  input \rdata_reg[29]_0 ;
  input \rdata_reg[30]_0 ;
  input \rdata_reg[31]_1 ;
  input [3:0]s_axi_control_WSTRB;
  input \gen_write[1].mem_reg_1 ;
  input \gen_write[1].mem_reg_2 ;
  input s_axi_control_WVALID;

  wire [3:0]ADDRARDADDR;
  wire [31:0]D;
  wire [31:0]DOADO;
  wire [31:0]DOBDO;
  wire [3:0]Q;
  wire [31:0]a_q0;
  wire ap_clk;
  wire \gen_write[1].mem_reg_0 ;
  wire \gen_write[1].mem_reg_1 ;
  wire \gen_write[1].mem_reg_2 ;
  wire \gen_write[1].mem_reg_i_5_n_0 ;
  wire \gen_write[1].mem_reg_i_6_n_0 ;
  wire \gen_write[1].mem_reg_i_7_n_0 ;
  wire \gen_write[1].mem_reg_i_8_n_0 ;
  wire [31:0]int_a_q1;
  wire int_a_read;
  wire [31:0]int_b_q1;
  wire p_reg;
  wire p_reg_0;
  wire p_reg_1;
  wire p_reg_10;
  wire p_reg_11;
  wire p_reg_12;
  wire p_reg_13;
  wire p_reg_14;
  wire p_reg_2;
  wire p_reg_3;
  wire p_reg_4;
  wire p_reg_5;
  wire p_reg_6;
  wire p_reg_7;
  wire p_reg_8;
  wire p_reg_9;
  wire \rdata_reg[0] ;
  wire \rdata_reg[0]_0 ;
  wire \rdata_reg[10] ;
  wire \rdata_reg[10]_0 ;
  wire \rdata_reg[11] ;
  wire \rdata_reg[11]_0 ;
  wire \rdata_reg[12] ;
  wire \rdata_reg[12]_0 ;
  wire \rdata_reg[13] ;
  wire \rdata_reg[13]_0 ;
  wire \rdata_reg[14] ;
  wire \rdata_reg[14]_0 ;
  wire \rdata_reg[15] ;
  wire \rdata_reg[15]_0 ;
  wire \rdata_reg[16] ;
  wire \rdata_reg[16]_0 ;
  wire \rdata_reg[17] ;
  wire \rdata_reg[17]_0 ;
  wire \rdata_reg[18] ;
  wire \rdata_reg[18]_0 ;
  wire \rdata_reg[19] ;
  wire \rdata_reg[19]_0 ;
  wire \rdata_reg[1] ;
  wire \rdata_reg[1]_0 ;
  wire \rdata_reg[20] ;
  wire \rdata_reg[20]_0 ;
  wire \rdata_reg[21] ;
  wire \rdata_reg[21]_0 ;
  wire \rdata_reg[22] ;
  wire \rdata_reg[22]_0 ;
  wire \rdata_reg[23] ;
  wire \rdata_reg[23]_0 ;
  wire \rdata_reg[24] ;
  wire \rdata_reg[24]_0 ;
  wire \rdata_reg[25] ;
  wire \rdata_reg[25]_0 ;
  wire \rdata_reg[26] ;
  wire \rdata_reg[26]_0 ;
  wire \rdata_reg[27] ;
  wire \rdata_reg[27]_0 ;
  wire \rdata_reg[28] ;
  wire \rdata_reg[28]_0 ;
  wire \rdata_reg[29] ;
  wire \rdata_reg[29]_0 ;
  wire \rdata_reg[2] ;
  wire \rdata_reg[2]_0 ;
  wire \rdata_reg[30] ;
  wire \rdata_reg[30]_0 ;
  wire \rdata_reg[31] ;
  wire \rdata_reg[31]_0 ;
  wire \rdata_reg[31]_1 ;
  wire \rdata_reg[3] ;
  wire \rdata_reg[3]_0 ;
  wire \rdata_reg[4] ;
  wire \rdata_reg[4]_0 ;
  wire \rdata_reg[5] ;
  wire \rdata_reg[5]_0 ;
  wire \rdata_reg[6] ;
  wire \rdata_reg[6]_0 ;
  wire \rdata_reg[7] ;
  wire \rdata_reg[7]_0 ;
  wire \rdata_reg[8] ;
  wire \rdata_reg[8]_0 ;
  wire \rdata_reg[9] ;
  wire \rdata_reg[9]_0 ;
  wire s_axi_control_ARVALID;
  wire [31:0]s_axi_control_WDATA;
  wire [3:0]s_axi_control_WSTRB;
  wire s_axi_control_WVALID;
  wire tmp_product__0;
  wire tmp_product__0_0;
  wire tmp_product__0_1;
  wire tmp_product__0_10;
  wire tmp_product__0_11;
  wire tmp_product__0_12;
  wire tmp_product__0_13;
  wire tmp_product__0_14;
  wire tmp_product__0_15;
  wire tmp_product__0_2;
  wire tmp_product__0_3;
  wire tmp_product__0_4;
  wire tmp_product__0_5;
  wire tmp_product__0_6;
  wire tmp_product__0_7;
  wire tmp_product__0_8;
  wire tmp_product__0_9;
  wire \NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED ;
  wire [3:0]\NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED ;

  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d8_p0_d8_p0_d8_p0_d8" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d8_p0_d8_p0_d8_p0_d8" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "512" *) 
  (* RTL_RAM_NAME = "control_s_axi_U/int_a/gen_write[1].mem" *) 
  (* RTL_RAM_TYPE = "RAM_TDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "1008" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "31" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(36),
    .READ_WIDTH_B(36),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(36),
    .WRITE_WIDTH_B(36)) 
    \gen_write[1].mem_reg 
       (.ADDRARDADDR({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,ADDRARDADDR,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,Q,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b1),
        .CASCADEINB(1'b1),
        .CASCADEOUTA(\NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(ap_clk),
        .CLKBWRCLK(ap_clk),
        .DBITERR(\NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED ),
        .DIADI(s_axi_control_WDATA),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(DOADO),
        .DOBDO(DOBDO),
        .DOPADOP(\NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(1'b1),
        .ENBWREN(1'b1),
        .INJECTDBITERR(\NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED ),
        .INJECTSBITERR(\NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED ),
        .RDADDRECC(\NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED ),
        .WEA({\gen_write[1].mem_reg_i_5_n_0 ,\gen_write[1].mem_reg_i_6_n_0 ,\gen_write[1].mem_reg_i_7_n_0 ,\gen_write[1].mem_reg_i_8_n_0 }),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_5 
       (.I0(s_axi_control_WSTRB[3]),
        .I1(\gen_write[1].mem_reg_1 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_0 ),
        .I4(\gen_write[1].mem_reg_2 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_6 
       (.I0(s_axi_control_WSTRB[2]),
        .I1(\gen_write[1].mem_reg_1 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_0 ),
        .I4(\gen_write[1].mem_reg_2 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_7 
       (.I0(s_axi_control_WSTRB[1]),
        .I1(\gen_write[1].mem_reg_1 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_0 ),
        .I4(\gen_write[1].mem_reg_2 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_8 
       (.I0(s_axi_control_WSTRB[0]),
        .I1(\gen_write[1].mem_reg_1 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_0 ),
        .I4(\gen_write[1].mem_reg_2 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_8_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_1
       (.I0(DOBDO[31]),
        .I1(p_reg),
        .I2(p_reg_14),
        .O(a_q0[31]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_10
       (.I0(DOBDO[22]),
        .I1(p_reg),
        .I2(p_reg_5),
        .O(a_q0[22]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_11
       (.I0(DOBDO[21]),
        .I1(p_reg),
        .I2(p_reg_4),
        .O(a_q0[21]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_12
       (.I0(DOBDO[20]),
        .I1(p_reg),
        .I2(p_reg_3),
        .O(a_q0[20]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_13
       (.I0(DOBDO[19]),
        .I1(p_reg),
        .I2(p_reg_2),
        .O(a_q0[19]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_14
       (.I0(DOBDO[18]),
        .I1(p_reg),
        .I2(p_reg_1),
        .O(a_q0[18]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_15
       (.I0(DOBDO[17]),
        .I1(p_reg),
        .I2(p_reg_0),
        .O(a_q0[17]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_2
       (.I0(DOBDO[30]),
        .I1(p_reg),
        .I2(p_reg_13),
        .O(a_q0[30]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_3
       (.I0(DOBDO[29]),
        .I1(p_reg),
        .I2(p_reg_12),
        .O(a_q0[29]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_4
       (.I0(DOBDO[28]),
        .I1(p_reg),
        .I2(p_reg_11),
        .O(a_q0[28]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_5
       (.I0(DOBDO[27]),
        .I1(p_reg),
        .I2(p_reg_10),
        .O(a_q0[27]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_6
       (.I0(DOBDO[26]),
        .I1(p_reg),
        .I2(p_reg_9),
        .O(a_q0[26]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_7
       (.I0(DOBDO[25]),
        .I1(p_reg),
        .I2(p_reg_8),
        .O(a_q0[25]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_8
       (.I0(DOBDO[24]),
        .I1(p_reg),
        .I2(p_reg_7),
        .O(a_q0[24]));
  LUT3 #(
    .INIT(8'hB8)) 
    p_reg_i_9
       (.I0(DOBDO[23]),
        .I1(p_reg),
        .I2(p_reg_6),
        .O(a_q0[23]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[0]_i_1 
       (.I0(int_a_q1[0]),
        .I1(int_a_read),
        .I2(int_b_q1[0]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[0]_0 ),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[0]_i_2 
       (.I0(DOADO[0]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[0] ),
        .O(int_a_q1[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[10]_i_1 
       (.I0(int_a_q1[10]),
        .I1(int_a_read),
        .I2(int_b_q1[10]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[10]_0 ),
        .O(D[10]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[10]_i_2 
       (.I0(DOADO[10]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[10] ),
        .O(int_a_q1[10]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[11]_i_1 
       (.I0(int_a_q1[11]),
        .I1(int_a_read),
        .I2(int_b_q1[11]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[11]_0 ),
        .O(D[11]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[11]_i_2 
       (.I0(DOADO[11]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[11] ),
        .O(int_a_q1[11]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[12]_i_1 
       (.I0(int_a_q1[12]),
        .I1(int_a_read),
        .I2(int_b_q1[12]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[12]_0 ),
        .O(D[12]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[12]_i_2 
       (.I0(DOADO[12]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[12] ),
        .O(int_a_q1[12]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[13]_i_1 
       (.I0(int_a_q1[13]),
        .I1(int_a_read),
        .I2(int_b_q1[13]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[13]_0 ),
        .O(D[13]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[13]_i_2 
       (.I0(DOADO[13]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[13] ),
        .O(int_a_q1[13]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[14]_i_1 
       (.I0(int_a_q1[14]),
        .I1(int_a_read),
        .I2(int_b_q1[14]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[14]_0 ),
        .O(D[14]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[14]_i_2 
       (.I0(DOADO[14]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[14] ),
        .O(int_a_q1[14]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[15]_i_1 
       (.I0(int_a_q1[15]),
        .I1(int_a_read),
        .I2(int_b_q1[15]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[15]_0 ),
        .O(D[15]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[15]_i_2 
       (.I0(DOADO[15]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[15] ),
        .O(int_a_q1[15]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[16]_i_1 
       (.I0(int_a_q1[16]),
        .I1(int_a_read),
        .I2(int_b_q1[16]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[16]_0 ),
        .O(D[16]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[16]_i_2 
       (.I0(DOADO[16]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[16] ),
        .O(int_a_q1[16]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[17]_i_1 
       (.I0(int_a_q1[17]),
        .I1(int_a_read),
        .I2(int_b_q1[17]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[17]_0 ),
        .O(D[17]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[17]_i_2 
       (.I0(DOADO[17]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[17] ),
        .O(int_a_q1[17]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[18]_i_1 
       (.I0(int_a_q1[18]),
        .I1(int_a_read),
        .I2(int_b_q1[18]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[18]_0 ),
        .O(D[18]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[18]_i_2 
       (.I0(DOADO[18]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[18] ),
        .O(int_a_q1[18]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[19]_i_1 
       (.I0(int_a_q1[19]),
        .I1(int_a_read),
        .I2(int_b_q1[19]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[19]_0 ),
        .O(D[19]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[19]_i_2 
       (.I0(DOADO[19]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[19] ),
        .O(int_a_q1[19]));
  LUT6 #(
    .INIT(64'hAAAAEFEAEFEAEFEA)) 
    \rdata[1]_i_1 
       (.I0(\rdata_reg[1]_0 ),
        .I1(int_a_q1[1]),
        .I2(int_a_read),
        .I3(int_b_q1[1]),
        .I4(s_axi_control_ARVALID),
        .I5(\gen_write[1].mem_reg_0 ),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[1]_i_3 
       (.I0(DOADO[1]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[1] ),
        .O(int_a_q1[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[20]_i_1 
       (.I0(int_a_q1[20]),
        .I1(int_a_read),
        .I2(int_b_q1[20]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[20]_0 ),
        .O(D[20]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[20]_i_2 
       (.I0(DOADO[20]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[20] ),
        .O(int_a_q1[20]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[21]_i_1 
       (.I0(int_a_q1[21]),
        .I1(int_a_read),
        .I2(int_b_q1[21]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[21]_0 ),
        .O(D[21]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[21]_i_2 
       (.I0(DOADO[21]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[21] ),
        .O(int_a_q1[21]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[22]_i_1 
       (.I0(int_a_q1[22]),
        .I1(int_a_read),
        .I2(int_b_q1[22]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[22]_0 ),
        .O(D[22]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[22]_i_2 
       (.I0(DOADO[22]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[22] ),
        .O(int_a_q1[22]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[23]_i_1 
       (.I0(int_a_q1[23]),
        .I1(int_a_read),
        .I2(int_b_q1[23]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[23]_0 ),
        .O(D[23]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[23]_i_2 
       (.I0(DOADO[23]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[23] ),
        .O(int_a_q1[23]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[24]_i_1 
       (.I0(int_a_q1[24]),
        .I1(int_a_read),
        .I2(int_b_q1[24]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[24]_0 ),
        .O(D[24]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[24]_i_2 
       (.I0(DOADO[24]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[24] ),
        .O(int_a_q1[24]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[25]_i_1 
       (.I0(int_a_q1[25]),
        .I1(int_a_read),
        .I2(int_b_q1[25]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[25]_0 ),
        .O(D[25]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[25]_i_2 
       (.I0(DOADO[25]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[25] ),
        .O(int_a_q1[25]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[26]_i_1 
       (.I0(int_a_q1[26]),
        .I1(int_a_read),
        .I2(int_b_q1[26]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[26]_0 ),
        .O(D[26]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[26]_i_2 
       (.I0(DOADO[26]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[26] ),
        .O(int_a_q1[26]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[27]_i_1 
       (.I0(int_a_q1[27]),
        .I1(int_a_read),
        .I2(int_b_q1[27]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[27]_0 ),
        .O(D[27]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[27]_i_2 
       (.I0(DOADO[27]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[27] ),
        .O(int_a_q1[27]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[28]_i_1 
       (.I0(int_a_q1[28]),
        .I1(int_a_read),
        .I2(int_b_q1[28]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[28]_0 ),
        .O(D[28]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[28]_i_2 
       (.I0(DOADO[28]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[28] ),
        .O(int_a_q1[28]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[29]_i_1 
       (.I0(int_a_q1[29]),
        .I1(int_a_read),
        .I2(int_b_q1[29]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[29]_0 ),
        .O(D[29]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[29]_i_2 
       (.I0(DOADO[29]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[29] ),
        .O(int_a_q1[29]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[2]_i_1 
       (.I0(int_a_q1[2]),
        .I1(int_a_read),
        .I2(int_b_q1[2]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[2]_0 ),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[2]_i_2 
       (.I0(DOADO[2]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[2] ),
        .O(int_a_q1[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[30]_i_1 
       (.I0(int_a_q1[30]),
        .I1(int_a_read),
        .I2(int_b_q1[30]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[30]_0 ),
        .O(D[30]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[30]_i_2 
       (.I0(DOADO[30]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[30] ),
        .O(int_a_q1[30]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[31]_i_2 
       (.I0(int_a_q1[31]),
        .I1(int_a_read),
        .I2(int_b_q1[31]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[31]_1 ),
        .O(D[31]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[31]_i_3 
       (.I0(DOADO[31]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[31]_0 ),
        .O(int_a_q1[31]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[3]_i_1 
       (.I0(int_a_q1[3]),
        .I1(int_a_read),
        .I2(int_b_q1[3]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[3]_0 ),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[3]_i_2 
       (.I0(DOADO[3]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[3] ),
        .O(int_a_q1[3]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[4]_i_1 
       (.I0(int_a_q1[4]),
        .I1(int_a_read),
        .I2(int_b_q1[4]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[4]_0 ),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[4]_i_2 
       (.I0(DOADO[4]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[4] ),
        .O(int_a_q1[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[5]_i_1 
       (.I0(int_a_q1[5]),
        .I1(int_a_read),
        .I2(int_b_q1[5]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[5]_0 ),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[5]_i_2 
       (.I0(DOADO[5]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[5] ),
        .O(int_a_q1[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[6]_i_1 
       (.I0(int_a_q1[6]),
        .I1(int_a_read),
        .I2(int_b_q1[6]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[6]_0 ),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[6]_i_2 
       (.I0(DOADO[6]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[6] ),
        .O(int_a_q1[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[7]_i_1 
       (.I0(int_a_q1[7]),
        .I1(int_a_read),
        .I2(int_b_q1[7]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[7]_0 ),
        .O(D[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[7]_i_2 
       (.I0(DOADO[7]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[7] ),
        .O(int_a_q1[7]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[8]_i_1 
       (.I0(int_a_q1[8]),
        .I1(int_a_read),
        .I2(int_b_q1[8]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[8]_0 ),
        .O(D[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[8]_i_2 
       (.I0(DOADO[8]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[8] ),
        .O(int_a_q1[8]));
  LUT6 #(
    .INIT(64'hFFFFFFFF00B8B8B8)) 
    \rdata[9]_i_1 
       (.I0(int_a_q1[9]),
        .I1(int_a_read),
        .I2(int_b_q1[9]),
        .I3(s_axi_control_ARVALID),
        .I4(\gen_write[1].mem_reg_0 ),
        .I5(\rdata_reg[9]_0 ),
        .O(D[9]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[9]_i_2 
       (.I0(DOADO[9]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[9] ),
        .O(int_a_q1[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_17
       (.I0(DOBDO[16]),
        .I1(p_reg),
        .I2(tmp_product__0_15),
        .O(a_q0[16]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_18
       (.I0(DOBDO[15]),
        .I1(p_reg),
        .I2(tmp_product__0_14),
        .O(a_q0[15]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_19
       (.I0(DOBDO[14]),
        .I1(p_reg),
        .I2(tmp_product__0_13),
        .O(a_q0[14]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_20
       (.I0(DOBDO[13]),
        .I1(p_reg),
        .I2(tmp_product__0_12),
        .O(a_q0[13]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_21
       (.I0(DOBDO[12]),
        .I1(p_reg),
        .I2(tmp_product__0_11),
        .O(a_q0[12]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_22
       (.I0(DOBDO[11]),
        .I1(p_reg),
        .I2(tmp_product__0_10),
        .O(a_q0[11]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_23
       (.I0(DOBDO[10]),
        .I1(p_reg),
        .I2(tmp_product__0_9),
        .O(a_q0[10]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_24
       (.I0(DOBDO[9]),
        .I1(p_reg),
        .I2(tmp_product__0_8),
        .O(a_q0[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_25
       (.I0(DOBDO[8]),
        .I1(p_reg),
        .I2(tmp_product__0_7),
        .O(a_q0[8]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_26
       (.I0(DOBDO[7]),
        .I1(p_reg),
        .I2(tmp_product__0_6),
        .O(a_q0[7]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_27
       (.I0(DOBDO[6]),
        .I1(p_reg),
        .I2(tmp_product__0_5),
        .O(a_q0[6]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_28
       (.I0(DOBDO[5]),
        .I1(p_reg),
        .I2(tmp_product__0_4),
        .O(a_q0[5]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_29
       (.I0(DOBDO[4]),
        .I1(p_reg),
        .I2(tmp_product__0_3),
        .O(a_q0[4]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_30
       (.I0(DOBDO[3]),
        .I1(p_reg),
        .I2(tmp_product__0_2),
        .O(a_q0[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_31
       (.I0(DOBDO[2]),
        .I1(p_reg),
        .I2(tmp_product__0_1),
        .O(a_q0[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_32
       (.I0(DOBDO[1]),
        .I1(p_reg),
        .I2(tmp_product__0_0),
        .O(a_q0[1]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_33
       (.I0(DOBDO[0]),
        .I1(p_reg),
        .I2(tmp_product__0),
        .O(a_q0[0]));
endmodule

(* ORIG_REF_NAME = "muladd_control_s_axi_ram" *) 
module design_1_muladd_0_0_muladd_control_s_axi_ram_0
   (\gen_write[1].mem_reg_0 ,
    \gen_write[1].mem_reg_1 ,
    ADDRARDADDR,
    int_b_q1,
    b_q0,
    ap_clk,
    Q,
    s_axi_control_WDATA,
    \rdata_reg[31] ,
    \rdata_reg[0] ,
    \rdata_reg[1] ,
    \rdata_reg[2] ,
    \rdata_reg[3] ,
    \rdata_reg[4] ,
    \rdata_reg[5] ,
    \rdata_reg[6] ,
    \rdata_reg[7] ,
    \rdata_reg[8] ,
    \rdata_reg[9] ,
    \rdata_reg[10] ,
    \rdata_reg[11] ,
    \rdata_reg[12] ,
    \rdata_reg[13] ,
    \rdata_reg[14] ,
    \rdata_reg[15] ,
    \rdata_reg[16] ,
    \rdata_reg[17] ,
    \rdata_reg[18] ,
    \rdata_reg[19] ,
    \rdata_reg[20] ,
    \rdata_reg[21] ,
    \rdata_reg[22] ,
    \rdata_reg[23] ,
    \rdata_reg[24] ,
    \rdata_reg[25] ,
    \rdata_reg[26] ,
    \rdata_reg[27] ,
    \rdata_reg[28] ,
    \rdata_reg[29] ,
    \rdata_reg[30] ,
    \rdata_reg[31]_0 ,
    tmp_product,
    tmp_product__0,
    tmp_product__0_0,
    tmp_product__0_1,
    tmp_product__0_2,
    tmp_product__0_3,
    tmp_product__0_4,
    tmp_product__0_5,
    tmp_product__0_6,
    tmp_product__0_7,
    tmp_product__0_8,
    tmp_product__0_9,
    tmp_product__0_10,
    tmp_product__0_11,
    tmp_product__0_12,
    tmp_product__0_13,
    tmp_product__0_14,
    tmp_product__0_15,
    tmp_product_0,
    tmp_product_1,
    tmp_product_2,
    tmp_product_3,
    tmp_product_4,
    tmp_product_5,
    tmp_product_6,
    tmp_product_7,
    tmp_product_8,
    tmp_product_9,
    tmp_product_10,
    tmp_product_11,
    tmp_product_12,
    tmp_product_13,
    tmp_product_14,
    \gen_write[1].mem_reg_2 ,
    s_axi_control_ARVALID,
    \gen_write[1].mem_reg_3 ,
    s_axi_control_ARADDR,
    s_axi_control_WSTRB,
    \gen_write[1].mem_reg_4 ,
    \gen_write[1].mem_reg_5 ,
    s_axi_control_WVALID);
  output [31:0]\gen_write[1].mem_reg_0 ;
  output [31:0]\gen_write[1].mem_reg_1 ;
  output [3:0]ADDRARDADDR;
  output [31:0]int_b_q1;
  output [31:0]b_q0;
  input ap_clk;
  input [3:0]Q;
  input [31:0]s_axi_control_WDATA;
  input \rdata_reg[31] ;
  input \rdata_reg[0] ;
  input \rdata_reg[1] ;
  input \rdata_reg[2] ;
  input \rdata_reg[3] ;
  input \rdata_reg[4] ;
  input \rdata_reg[5] ;
  input \rdata_reg[6] ;
  input \rdata_reg[7] ;
  input \rdata_reg[8] ;
  input \rdata_reg[9] ;
  input \rdata_reg[10] ;
  input \rdata_reg[11] ;
  input \rdata_reg[12] ;
  input \rdata_reg[13] ;
  input \rdata_reg[14] ;
  input \rdata_reg[15] ;
  input \rdata_reg[16] ;
  input \rdata_reg[17] ;
  input \rdata_reg[18] ;
  input \rdata_reg[19] ;
  input \rdata_reg[20] ;
  input \rdata_reg[21] ;
  input \rdata_reg[22] ;
  input \rdata_reg[23] ;
  input \rdata_reg[24] ;
  input \rdata_reg[25] ;
  input \rdata_reg[26] ;
  input \rdata_reg[27] ;
  input \rdata_reg[28] ;
  input \rdata_reg[29] ;
  input \rdata_reg[30] ;
  input \rdata_reg[31]_0 ;
  input tmp_product;
  input tmp_product__0;
  input tmp_product__0_0;
  input tmp_product__0_1;
  input tmp_product__0_2;
  input tmp_product__0_3;
  input tmp_product__0_4;
  input tmp_product__0_5;
  input tmp_product__0_6;
  input tmp_product__0_7;
  input tmp_product__0_8;
  input tmp_product__0_9;
  input tmp_product__0_10;
  input tmp_product__0_11;
  input tmp_product__0_12;
  input tmp_product__0_13;
  input tmp_product__0_14;
  input tmp_product__0_15;
  input tmp_product_0;
  input tmp_product_1;
  input tmp_product_2;
  input tmp_product_3;
  input tmp_product_4;
  input tmp_product_5;
  input tmp_product_6;
  input tmp_product_7;
  input tmp_product_8;
  input tmp_product_9;
  input tmp_product_10;
  input tmp_product_11;
  input tmp_product_12;
  input tmp_product_13;
  input tmp_product_14;
  input [3:0]\gen_write[1].mem_reg_2 ;
  input s_axi_control_ARVALID;
  input \gen_write[1].mem_reg_3 ;
  input [3:0]s_axi_control_ARADDR;
  input [3:0]s_axi_control_WSTRB;
  input \gen_write[1].mem_reg_4 ;
  input \gen_write[1].mem_reg_5 ;
  input s_axi_control_WVALID;

  wire [3:0]ADDRARDADDR;
  wire [3:0]Q;
  wire ap_clk;
  wire [31:0]b_q0;
  wire [31:0]\gen_write[1].mem_reg_0 ;
  wire [31:0]\gen_write[1].mem_reg_1 ;
  wire [3:0]\gen_write[1].mem_reg_2 ;
  wire \gen_write[1].mem_reg_3 ;
  wire \gen_write[1].mem_reg_4 ;
  wire \gen_write[1].mem_reg_5 ;
  wire \gen_write[1].mem_reg_i_1__0_n_0 ;
  wire \gen_write[1].mem_reg_i_2__0_n_0 ;
  wire \gen_write[1].mem_reg_i_3__0_n_0 ;
  wire \gen_write[1].mem_reg_i_4__0_n_0 ;
  wire [31:0]int_b_q1;
  wire \rdata_reg[0] ;
  wire \rdata_reg[10] ;
  wire \rdata_reg[11] ;
  wire \rdata_reg[12] ;
  wire \rdata_reg[13] ;
  wire \rdata_reg[14] ;
  wire \rdata_reg[15] ;
  wire \rdata_reg[16] ;
  wire \rdata_reg[17] ;
  wire \rdata_reg[18] ;
  wire \rdata_reg[19] ;
  wire \rdata_reg[1] ;
  wire \rdata_reg[20] ;
  wire \rdata_reg[21] ;
  wire \rdata_reg[22] ;
  wire \rdata_reg[23] ;
  wire \rdata_reg[24] ;
  wire \rdata_reg[25] ;
  wire \rdata_reg[26] ;
  wire \rdata_reg[27] ;
  wire \rdata_reg[28] ;
  wire \rdata_reg[29] ;
  wire \rdata_reg[2] ;
  wire \rdata_reg[30] ;
  wire \rdata_reg[31] ;
  wire \rdata_reg[31]_0 ;
  wire \rdata_reg[3] ;
  wire \rdata_reg[4] ;
  wire \rdata_reg[5] ;
  wire \rdata_reg[6] ;
  wire \rdata_reg[7] ;
  wire \rdata_reg[8] ;
  wire \rdata_reg[9] ;
  wire [3:0]s_axi_control_ARADDR;
  wire s_axi_control_ARVALID;
  wire [31:0]s_axi_control_WDATA;
  wire [3:0]s_axi_control_WSTRB;
  wire s_axi_control_WVALID;
  wire tmp_product;
  wire tmp_product_0;
  wire tmp_product_1;
  wire tmp_product_10;
  wire tmp_product_11;
  wire tmp_product_12;
  wire tmp_product_13;
  wire tmp_product_14;
  wire tmp_product_2;
  wire tmp_product_3;
  wire tmp_product_4;
  wire tmp_product_5;
  wire tmp_product_6;
  wire tmp_product_7;
  wire tmp_product_8;
  wire tmp_product_9;
  wire tmp_product__0;
  wire tmp_product__0_0;
  wire tmp_product__0_1;
  wire tmp_product__0_10;
  wire tmp_product__0_11;
  wire tmp_product__0_12;
  wire tmp_product__0_13;
  wire tmp_product__0_14;
  wire tmp_product__0_15;
  wire tmp_product__0_2;
  wire tmp_product__0_3;
  wire tmp_product__0_4;
  wire tmp_product__0_5;
  wire tmp_product__0_6;
  wire tmp_product__0_7;
  wire tmp_product__0_8;
  wire tmp_product__0_9;
  wire \NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED ;
  wire \NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED ;
  wire [3:0]\NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED ;

  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p0_d8_p0_d8_p0_d8_p0_d8" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d8_p0_d8_p0_d8_p0_d8" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}" *) 
  (* RTL_RAM_BITS = "512" *) 
  (* RTL_RAM_NAME = "control_s_axi_U/int_b/gen_write[1].mem" *) 
  (* RTL_RAM_TYPE = "RAM_TDP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "15" *) 
  (* ram_offset = "1008" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "31" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(36),
    .READ_WIDTH_B(36),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(36),
    .WRITE_WIDTH_B(36)) 
    \gen_write[1].mem_reg 
       (.ADDRARDADDR({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,ADDRARDADDR,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,Q,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b1),
        .CASCADEINB(1'b1),
        .CASCADEOUTA(\NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(ap_clk),
        .CLKBWRCLK(ap_clk),
        .DBITERR(\NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED ),
        .DIADI(s_axi_control_WDATA),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\gen_write[1].mem_reg_0 ),
        .DOBDO(\gen_write[1].mem_reg_1 ),
        .DOPADOP(\NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(1'b1),
        .ENBWREN(1'b1),
        .INJECTDBITERR(\NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED ),
        .INJECTSBITERR(\NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED ),
        .RDADDRECC(\NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED ),
        .WEA({\gen_write[1].mem_reg_i_1__0_n_0 ,\gen_write[1].mem_reg_i_2__0_n_0 ,\gen_write[1].mem_reg_i_3__0_n_0 ,\gen_write[1].mem_reg_i_4__0_n_0 }),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT4 #(
    .INIT(16'hEA2A)) 
    \gen_write[1].mem_reg_i_1 
       (.I0(\gen_write[1].mem_reg_2 [3]),
        .I1(s_axi_control_ARVALID),
        .I2(\gen_write[1].mem_reg_3 ),
        .I3(s_axi_control_ARADDR[3]),
        .O(ADDRARDADDR[3]));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_1__0 
       (.I0(s_axi_control_WSTRB[3]),
        .I1(\gen_write[1].mem_reg_4 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_3 ),
        .I4(\gen_write[1].mem_reg_5 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_1__0_n_0 ));
  LUT4 #(
    .INIT(16'hEA2A)) 
    \gen_write[1].mem_reg_i_2 
       (.I0(\gen_write[1].mem_reg_2 [2]),
        .I1(s_axi_control_ARVALID),
        .I2(\gen_write[1].mem_reg_3 ),
        .I3(s_axi_control_ARADDR[2]),
        .O(ADDRARDADDR[2]));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_2__0 
       (.I0(s_axi_control_WSTRB[2]),
        .I1(\gen_write[1].mem_reg_4 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_3 ),
        .I4(\gen_write[1].mem_reg_5 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_2__0_n_0 ));
  LUT4 #(
    .INIT(16'hEA2A)) 
    \gen_write[1].mem_reg_i_3 
       (.I0(\gen_write[1].mem_reg_2 [1]),
        .I1(s_axi_control_ARVALID),
        .I2(\gen_write[1].mem_reg_3 ),
        .I3(s_axi_control_ARADDR[1]),
        .O(ADDRARDADDR[1]));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_3__0 
       (.I0(s_axi_control_WSTRB[1]),
        .I1(\gen_write[1].mem_reg_4 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_3 ),
        .I4(\gen_write[1].mem_reg_5 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_3__0_n_0 ));
  LUT4 #(
    .INIT(16'hEA2A)) 
    \gen_write[1].mem_reg_i_4 
       (.I0(\gen_write[1].mem_reg_2 [0]),
        .I1(s_axi_control_ARVALID),
        .I2(\gen_write[1].mem_reg_3 ),
        .I3(s_axi_control_ARADDR[0]),
        .O(ADDRARDADDR[0]));
  LUT6 #(
    .INIT(64'h0888000000000000)) 
    \gen_write[1].mem_reg_i_4__0 
       (.I0(s_axi_control_WSTRB[0]),
        .I1(\gen_write[1].mem_reg_4 ),
        .I2(s_axi_control_ARVALID),
        .I3(\gen_write[1].mem_reg_3 ),
        .I4(\gen_write[1].mem_reg_5 ),
        .I5(s_axi_control_WVALID),
        .O(\gen_write[1].mem_reg_i_4__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[0]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [0]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[0] ),
        .O(int_b_q1[0]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[10]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [10]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[10] ),
        .O(int_b_q1[10]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[11]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [11]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[11] ),
        .O(int_b_q1[11]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[12]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [12]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[12] ),
        .O(int_b_q1[12]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[13]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [13]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[13] ),
        .O(int_b_q1[13]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[14]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [14]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[14] ),
        .O(int_b_q1[14]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[15]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [15]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[15] ),
        .O(int_b_q1[15]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[16]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [16]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[16] ),
        .O(int_b_q1[16]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[17]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [17]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[17] ),
        .O(int_b_q1[17]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[18]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [18]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[18] ),
        .O(int_b_q1[18]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[19]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [19]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[19] ),
        .O(int_b_q1[19]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[1]_i_4 
       (.I0(\gen_write[1].mem_reg_0 [1]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[1] ),
        .O(int_b_q1[1]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[20]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [20]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[20] ),
        .O(int_b_q1[20]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[21]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [21]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[21] ),
        .O(int_b_q1[21]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[22]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [22]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[22] ),
        .O(int_b_q1[22]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[23]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [23]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[23] ),
        .O(int_b_q1[23]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[24]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [24]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[24] ),
        .O(int_b_q1[24]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[25]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [25]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[25] ),
        .O(int_b_q1[25]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[26]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [26]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[26] ),
        .O(int_b_q1[26]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[27]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [27]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[27] ),
        .O(int_b_q1[27]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[28]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [28]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[28] ),
        .O(int_b_q1[28]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[29]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [29]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[29] ),
        .O(int_b_q1[29]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[2]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [2]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[2] ),
        .O(int_b_q1[2]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[30]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [30]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[30] ),
        .O(int_b_q1[30]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[31]_i_4 
       (.I0(\gen_write[1].mem_reg_0 [31]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[31]_0 ),
        .O(int_b_q1[31]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[3]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [3]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[3] ),
        .O(int_b_q1[3]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[4]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [4]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[4] ),
        .O(int_b_q1[4]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[5]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [5]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[5] ),
        .O(int_b_q1[5]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[6]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [6]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[6] ),
        .O(int_b_q1[6]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[7]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [7]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[7] ),
        .O(int_b_q1[7]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[8]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [8]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[8] ),
        .O(int_b_q1[8]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \rdata[9]_i_3 
       (.I0(\gen_write[1].mem_reg_0 [9]),
        .I1(\rdata_reg[31] ),
        .I2(\rdata_reg[9] ),
        .O(int_b_q1[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_1
       (.I0(\gen_write[1].mem_reg_1 [16]),
        .I1(tmp_product),
        .I2(tmp_product__0_15),
        .O(b_q0[16]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_10
       (.I0(\gen_write[1].mem_reg_1 [7]),
        .I1(tmp_product),
        .I2(tmp_product__0_6),
        .O(b_q0[7]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_11
       (.I0(\gen_write[1].mem_reg_1 [6]),
        .I1(tmp_product),
        .I2(tmp_product__0_5),
        .O(b_q0[6]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_12
       (.I0(\gen_write[1].mem_reg_1 [5]),
        .I1(tmp_product),
        .I2(tmp_product__0_4),
        .O(b_q0[5]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_13
       (.I0(\gen_write[1].mem_reg_1 [4]),
        .I1(tmp_product),
        .I2(tmp_product__0_3),
        .O(b_q0[4]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_14
       (.I0(\gen_write[1].mem_reg_1 [3]),
        .I1(tmp_product),
        .I2(tmp_product__0_2),
        .O(b_q0[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_15
       (.I0(\gen_write[1].mem_reg_1 [2]),
        .I1(tmp_product),
        .I2(tmp_product__0_1),
        .O(b_q0[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_16
       (.I0(\gen_write[1].mem_reg_1 [1]),
        .I1(tmp_product),
        .I2(tmp_product__0_0),
        .O(b_q0[1]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_17
       (.I0(\gen_write[1].mem_reg_1 [0]),
        .I1(tmp_product),
        .I2(tmp_product__0),
        .O(b_q0[0]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_2
       (.I0(\gen_write[1].mem_reg_1 [15]),
        .I1(tmp_product),
        .I2(tmp_product__0_14),
        .O(b_q0[15]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_3
       (.I0(\gen_write[1].mem_reg_1 [14]),
        .I1(tmp_product),
        .I2(tmp_product__0_13),
        .O(b_q0[14]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_4
       (.I0(\gen_write[1].mem_reg_1 [13]),
        .I1(tmp_product),
        .I2(tmp_product__0_12),
        .O(b_q0[13]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_5
       (.I0(\gen_write[1].mem_reg_1 [12]),
        .I1(tmp_product),
        .I2(tmp_product__0_11),
        .O(b_q0[12]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_6
       (.I0(\gen_write[1].mem_reg_1 [11]),
        .I1(tmp_product),
        .I2(tmp_product__0_10),
        .O(b_q0[11]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_7
       (.I0(\gen_write[1].mem_reg_1 [10]),
        .I1(tmp_product),
        .I2(tmp_product__0_9),
        .O(b_q0[10]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_8
       (.I0(\gen_write[1].mem_reg_1 [9]),
        .I1(tmp_product),
        .I2(tmp_product__0_8),
        .O(b_q0[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product__0_i_9
       (.I0(\gen_write[1].mem_reg_1 [8]),
        .I1(tmp_product),
        .I2(tmp_product__0_7),
        .O(b_q0[8]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_10
       (.I0(\gen_write[1].mem_reg_1 [23]),
        .I1(tmp_product),
        .I2(tmp_product_6),
        .O(b_q0[23]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_11
       (.I0(\gen_write[1].mem_reg_1 [22]),
        .I1(tmp_product),
        .I2(tmp_product_5),
        .O(b_q0[22]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_12
       (.I0(\gen_write[1].mem_reg_1 [21]),
        .I1(tmp_product),
        .I2(tmp_product_4),
        .O(b_q0[21]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_13
       (.I0(\gen_write[1].mem_reg_1 [20]),
        .I1(tmp_product),
        .I2(tmp_product_3),
        .O(b_q0[20]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_14
       (.I0(\gen_write[1].mem_reg_1 [19]),
        .I1(tmp_product),
        .I2(tmp_product_2),
        .O(b_q0[19]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_15
       (.I0(\gen_write[1].mem_reg_1 [18]),
        .I1(tmp_product),
        .I2(tmp_product_1),
        .O(b_q0[18]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_16
       (.I0(\gen_write[1].mem_reg_1 [17]),
        .I1(tmp_product),
        .I2(tmp_product_0),
        .O(b_q0[17]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_2
       (.I0(\gen_write[1].mem_reg_1 [31]),
        .I1(tmp_product),
        .I2(tmp_product_14),
        .O(b_q0[31]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_3
       (.I0(\gen_write[1].mem_reg_1 [30]),
        .I1(tmp_product),
        .I2(tmp_product_13),
        .O(b_q0[30]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_4
       (.I0(\gen_write[1].mem_reg_1 [29]),
        .I1(tmp_product),
        .I2(tmp_product_12),
        .O(b_q0[29]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_5
       (.I0(\gen_write[1].mem_reg_1 [28]),
        .I1(tmp_product),
        .I2(tmp_product_11),
        .O(b_q0[28]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_6
       (.I0(\gen_write[1].mem_reg_1 [27]),
        .I1(tmp_product),
        .I2(tmp_product_10),
        .O(b_q0[27]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_7
       (.I0(\gen_write[1].mem_reg_1 [26]),
        .I1(tmp_product),
        .I2(tmp_product_9),
        .O(b_q0[26]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_8
       (.I0(\gen_write[1].mem_reg_1 [25]),
        .I1(tmp_product),
        .I2(tmp_product_8),
        .O(b_q0[25]));
  LUT3 #(
    .INIT(8'hB8)) 
    tmp_product_i_9
       (.I0(\gen_write[1].mem_reg_1 [24]),
        .I1(tmp_product),
        .I2(tmp_product_7),
        .O(b_q0[24]));
endmodule

(* ORIG_REF_NAME = "muladd_mul_32s_32s_32_2_1" *) 
module design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1
   (D,
    ap_clk,
    b_q0,
    a_q0,
    Q,
    icmp_ln7_reg_137);
  output [31:0]D;
  input ap_clk;
  input [31:0]b_q0;
  input [31:0]a_q0;
  input [0:0]Q;
  input icmp_ln7_reg_137;

  wire [31:0]D;
  wire [0:0]Q;
  wire [31:0]a_q0;
  wire ap_clk;
  wire [31:0]b_q0;
  wire icmp_ln7_reg_137;

  design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1_Multiplier_0 muladd_mul_32s_32s_32_2_1_Multiplier_0_U
       (.D(D),
        .Q(Q),
        .a_q0(a_q0),
        .ap_clk(ap_clk),
        .b_q0(b_q0),
        .icmp_ln7_reg_137(icmp_ln7_reg_137));
endmodule

(* ORIG_REF_NAME = "muladd_mul_32s_32s_32_2_1_Multiplier_0" *) 
module design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1_Multiplier_0
   (D,
    ap_clk,
    b_q0,
    a_q0,
    Q,
    icmp_ln7_reg_137);
  output [31:0]D;
  input ap_clk;
  input [31:0]b_q0;
  input [31:0]a_q0;
  input [0:0]Q;
  input icmp_ln7_reg_137;

  wire [31:0]D;
  wire [0:0]Q;
  wire a_load_reg_1510;
  wire [31:0]a_q0;
  wire ap_clk;
  wire [31:0]b_q0;
  wire icmp_ln7_reg_137;
  wire \mul_ln9_reg_161[19]_i_2_n_0 ;
  wire \mul_ln9_reg_161[19]_i_3_n_0 ;
  wire \mul_ln9_reg_161[19]_i_4_n_0 ;
  wire \mul_ln9_reg_161[23]_i_2_n_0 ;
  wire \mul_ln9_reg_161[23]_i_3_n_0 ;
  wire \mul_ln9_reg_161[23]_i_4_n_0 ;
  wire \mul_ln9_reg_161[23]_i_5_n_0 ;
  wire \mul_ln9_reg_161[27]_i_2_n_0 ;
  wire \mul_ln9_reg_161[27]_i_3_n_0 ;
  wire \mul_ln9_reg_161[27]_i_4_n_0 ;
  wire \mul_ln9_reg_161[27]_i_5_n_0 ;
  wire \mul_ln9_reg_161[31]_i_3_n_0 ;
  wire \mul_ln9_reg_161[31]_i_4_n_0 ;
  wire \mul_ln9_reg_161[31]_i_5_n_0 ;
  wire \mul_ln9_reg_161[31]_i_6_n_0 ;
  wire \mul_ln9_reg_161_reg[19]_i_1_n_0 ;
  wire \mul_ln9_reg_161_reg[19]_i_1_n_1 ;
  wire \mul_ln9_reg_161_reg[19]_i_1_n_2 ;
  wire \mul_ln9_reg_161_reg[19]_i_1_n_3 ;
  wire \mul_ln9_reg_161_reg[23]_i_1_n_0 ;
  wire \mul_ln9_reg_161_reg[23]_i_1_n_1 ;
  wire \mul_ln9_reg_161_reg[23]_i_1_n_2 ;
  wire \mul_ln9_reg_161_reg[23]_i_1_n_3 ;
  wire \mul_ln9_reg_161_reg[27]_i_1_n_0 ;
  wire \mul_ln9_reg_161_reg[27]_i_1_n_1 ;
  wire \mul_ln9_reg_161_reg[27]_i_1_n_2 ;
  wire \mul_ln9_reg_161_reg[27]_i_1_n_3 ;
  wire \mul_ln9_reg_161_reg[31]_i_2_n_1 ;
  wire \mul_ln9_reg_161_reg[31]_i_2_n_2 ;
  wire \mul_ln9_reg_161_reg[31]_i_2_n_3 ;
  wire \p_reg[16]__0_n_0 ;
  wire p_reg_n_100;
  wire p_reg_n_101;
  wire p_reg_n_102;
  wire p_reg_n_103;
  wire p_reg_n_104;
  wire p_reg_n_105;
  wire p_reg_n_58;
  wire p_reg_n_59;
  wire p_reg_n_60;
  wire p_reg_n_61;
  wire p_reg_n_62;
  wire p_reg_n_63;
  wire p_reg_n_64;
  wire p_reg_n_65;
  wire p_reg_n_66;
  wire p_reg_n_67;
  wire p_reg_n_68;
  wire p_reg_n_69;
  wire p_reg_n_70;
  wire p_reg_n_71;
  wire p_reg_n_72;
  wire p_reg_n_73;
  wire p_reg_n_74;
  wire p_reg_n_75;
  wire p_reg_n_76;
  wire p_reg_n_77;
  wire p_reg_n_78;
  wire p_reg_n_79;
  wire p_reg_n_80;
  wire p_reg_n_81;
  wire p_reg_n_82;
  wire p_reg_n_83;
  wire p_reg_n_84;
  wire p_reg_n_85;
  wire p_reg_n_86;
  wire p_reg_n_87;
  wire p_reg_n_88;
  wire p_reg_n_89;
  wire p_reg_n_90;
  wire p_reg_n_91;
  wire p_reg_n_92;
  wire p_reg_n_93;
  wire p_reg_n_94;
  wire p_reg_n_95;
  wire p_reg_n_96;
  wire p_reg_n_97;
  wire p_reg_n_98;
  wire p_reg_n_99;
  wire tmp_product__0_n_100;
  wire tmp_product__0_n_101;
  wire tmp_product__0_n_102;
  wire tmp_product__0_n_103;
  wire tmp_product__0_n_104;
  wire tmp_product__0_n_105;
  wire tmp_product__0_n_106;
  wire tmp_product__0_n_107;
  wire tmp_product__0_n_108;
  wire tmp_product__0_n_109;
  wire tmp_product__0_n_110;
  wire tmp_product__0_n_111;
  wire tmp_product__0_n_112;
  wire tmp_product__0_n_113;
  wire tmp_product__0_n_114;
  wire tmp_product__0_n_115;
  wire tmp_product__0_n_116;
  wire tmp_product__0_n_117;
  wire tmp_product__0_n_118;
  wire tmp_product__0_n_119;
  wire tmp_product__0_n_120;
  wire tmp_product__0_n_121;
  wire tmp_product__0_n_122;
  wire tmp_product__0_n_123;
  wire tmp_product__0_n_124;
  wire tmp_product__0_n_125;
  wire tmp_product__0_n_126;
  wire tmp_product__0_n_127;
  wire tmp_product__0_n_128;
  wire tmp_product__0_n_129;
  wire tmp_product__0_n_130;
  wire tmp_product__0_n_131;
  wire tmp_product__0_n_132;
  wire tmp_product__0_n_133;
  wire tmp_product__0_n_134;
  wire tmp_product__0_n_135;
  wire tmp_product__0_n_136;
  wire tmp_product__0_n_137;
  wire tmp_product__0_n_138;
  wire tmp_product__0_n_139;
  wire tmp_product__0_n_140;
  wire tmp_product__0_n_141;
  wire tmp_product__0_n_142;
  wire tmp_product__0_n_143;
  wire tmp_product__0_n_144;
  wire tmp_product__0_n_145;
  wire tmp_product__0_n_146;
  wire tmp_product__0_n_147;
  wire tmp_product__0_n_148;
  wire tmp_product__0_n_149;
  wire tmp_product__0_n_150;
  wire tmp_product__0_n_151;
  wire tmp_product__0_n_152;
  wire tmp_product__0_n_153;
  wire tmp_product__0_n_24;
  wire tmp_product__0_n_25;
  wire tmp_product__0_n_26;
  wire tmp_product__0_n_27;
  wire tmp_product__0_n_28;
  wire tmp_product__0_n_29;
  wire tmp_product__0_n_30;
  wire tmp_product__0_n_31;
  wire tmp_product__0_n_32;
  wire tmp_product__0_n_33;
  wire tmp_product__0_n_34;
  wire tmp_product__0_n_35;
  wire tmp_product__0_n_36;
  wire tmp_product__0_n_37;
  wire tmp_product__0_n_38;
  wire tmp_product__0_n_39;
  wire tmp_product__0_n_40;
  wire tmp_product__0_n_41;
  wire tmp_product__0_n_42;
  wire tmp_product__0_n_43;
  wire tmp_product__0_n_44;
  wire tmp_product__0_n_45;
  wire tmp_product__0_n_46;
  wire tmp_product__0_n_47;
  wire tmp_product__0_n_48;
  wire tmp_product__0_n_49;
  wire tmp_product__0_n_50;
  wire tmp_product__0_n_51;
  wire tmp_product__0_n_52;
  wire tmp_product__0_n_53;
  wire tmp_product__0_n_58;
  wire tmp_product__0_n_59;
  wire tmp_product__0_n_60;
  wire tmp_product__0_n_61;
  wire tmp_product__0_n_62;
  wire tmp_product__0_n_63;
  wire tmp_product__0_n_64;
  wire tmp_product__0_n_65;
  wire tmp_product__0_n_66;
  wire tmp_product__0_n_67;
  wire tmp_product__0_n_68;
  wire tmp_product__0_n_69;
  wire tmp_product__0_n_70;
  wire tmp_product__0_n_71;
  wire tmp_product__0_n_72;
  wire tmp_product__0_n_73;
  wire tmp_product__0_n_74;
  wire tmp_product__0_n_75;
  wire tmp_product__0_n_76;
  wire tmp_product__0_n_77;
  wire tmp_product__0_n_78;
  wire tmp_product__0_n_79;
  wire tmp_product__0_n_80;
  wire tmp_product__0_n_81;
  wire tmp_product__0_n_82;
  wire tmp_product__0_n_83;
  wire tmp_product__0_n_84;
  wire tmp_product__0_n_85;
  wire tmp_product__0_n_86;
  wire tmp_product__0_n_87;
  wire tmp_product__0_n_88;
  wire tmp_product__0_n_89;
  wire tmp_product__0_n_90;
  wire tmp_product__0_n_91;
  wire tmp_product__0_n_92;
  wire tmp_product__0_n_93;
  wire tmp_product__0_n_94;
  wire tmp_product__0_n_95;
  wire tmp_product__0_n_96;
  wire tmp_product__0_n_97;
  wire tmp_product__0_n_98;
  wire tmp_product__0_n_99;
  wire tmp_product_n_100;
  wire tmp_product_n_101;
  wire tmp_product_n_102;
  wire tmp_product_n_103;
  wire tmp_product_n_104;
  wire tmp_product_n_105;
  wire tmp_product_n_106;
  wire tmp_product_n_107;
  wire tmp_product_n_108;
  wire tmp_product_n_109;
  wire tmp_product_n_110;
  wire tmp_product_n_111;
  wire tmp_product_n_112;
  wire tmp_product_n_113;
  wire tmp_product_n_114;
  wire tmp_product_n_115;
  wire tmp_product_n_116;
  wire tmp_product_n_117;
  wire tmp_product_n_118;
  wire tmp_product_n_119;
  wire tmp_product_n_120;
  wire tmp_product_n_121;
  wire tmp_product_n_122;
  wire tmp_product_n_123;
  wire tmp_product_n_124;
  wire tmp_product_n_125;
  wire tmp_product_n_126;
  wire tmp_product_n_127;
  wire tmp_product_n_128;
  wire tmp_product_n_129;
  wire tmp_product_n_130;
  wire tmp_product_n_131;
  wire tmp_product_n_132;
  wire tmp_product_n_133;
  wire tmp_product_n_134;
  wire tmp_product_n_135;
  wire tmp_product_n_136;
  wire tmp_product_n_137;
  wire tmp_product_n_138;
  wire tmp_product_n_139;
  wire tmp_product_n_140;
  wire tmp_product_n_141;
  wire tmp_product_n_142;
  wire tmp_product_n_143;
  wire tmp_product_n_144;
  wire tmp_product_n_145;
  wire tmp_product_n_146;
  wire tmp_product_n_147;
  wire tmp_product_n_148;
  wire tmp_product_n_149;
  wire tmp_product_n_150;
  wire tmp_product_n_151;
  wire tmp_product_n_152;
  wire tmp_product_n_153;
  wire tmp_product_n_58;
  wire tmp_product_n_59;
  wire tmp_product_n_60;
  wire tmp_product_n_61;
  wire tmp_product_n_62;
  wire tmp_product_n_63;
  wire tmp_product_n_64;
  wire tmp_product_n_65;
  wire tmp_product_n_66;
  wire tmp_product_n_67;
  wire tmp_product_n_68;
  wire tmp_product_n_69;
  wire tmp_product_n_70;
  wire tmp_product_n_71;
  wire tmp_product_n_72;
  wire tmp_product_n_73;
  wire tmp_product_n_74;
  wire tmp_product_n_75;
  wire tmp_product_n_76;
  wire tmp_product_n_77;
  wire tmp_product_n_78;
  wire tmp_product_n_79;
  wire tmp_product_n_80;
  wire tmp_product_n_81;
  wire tmp_product_n_82;
  wire tmp_product_n_83;
  wire tmp_product_n_84;
  wire tmp_product_n_85;
  wire tmp_product_n_86;
  wire tmp_product_n_87;
  wire tmp_product_n_88;
  wire tmp_product_n_89;
  wire tmp_product_n_90;
  wire tmp_product_n_91;
  wire tmp_product_n_92;
  wire tmp_product_n_93;
  wire tmp_product_n_94;
  wire tmp_product_n_95;
  wire tmp_product_n_96;
  wire tmp_product_n_97;
  wire tmp_product_n_98;
  wire tmp_product_n_99;
  wire [3:3]\NLW_mul_ln9_reg_161_reg[31]_i_2_CO_UNCONNECTED ;
  wire NLW_p_reg_CARRYCASCOUT_UNCONNECTED;
  wire NLW_p_reg_MULTSIGNOUT_UNCONNECTED;
  wire NLW_p_reg_OVERFLOW_UNCONNECTED;
  wire NLW_p_reg_PATTERNBDETECT_UNCONNECTED;
  wire NLW_p_reg_PATTERNDETECT_UNCONNECTED;
  wire NLW_p_reg_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_p_reg_ACOUT_UNCONNECTED;
  wire [17:0]NLW_p_reg_BCOUT_UNCONNECTED;
  wire [3:0]NLW_p_reg_CARRYOUT_UNCONNECTED;
  wire [47:0]NLW_p_reg_PCOUT_UNCONNECTED;
  wire NLW_tmp_product_CARRYCASCOUT_UNCONNECTED;
  wire NLW_tmp_product_MULTSIGNOUT_UNCONNECTED;
  wire NLW_tmp_product_OVERFLOW_UNCONNECTED;
  wire NLW_tmp_product_PATTERNBDETECT_UNCONNECTED;
  wire NLW_tmp_product_PATTERNDETECT_UNCONNECTED;
  wire NLW_tmp_product_UNDERFLOW_UNCONNECTED;
  wire [29:0]NLW_tmp_product_ACOUT_UNCONNECTED;
  wire [17:0]NLW_tmp_product_BCOUT_UNCONNECTED;
  wire [3:0]NLW_tmp_product_CARRYOUT_UNCONNECTED;
  wire NLW_tmp_product__0_CARRYCASCOUT_UNCONNECTED;
  wire NLW_tmp_product__0_MULTSIGNOUT_UNCONNECTED;
  wire NLW_tmp_product__0_OVERFLOW_UNCONNECTED;
  wire NLW_tmp_product__0_PATTERNBDETECT_UNCONNECTED;
  wire NLW_tmp_product__0_PATTERNDETECT_UNCONNECTED;
  wire NLW_tmp_product__0_UNDERFLOW_UNCONNECTED;
  wire [17:0]NLW_tmp_product__0_BCOUT_UNCONNECTED;
  wire [3:0]NLW_tmp_product__0_CARRYOUT_UNCONNECTED;

  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[19]_i_2 
       (.I0(p_reg_n_103),
        .I1(tmp_product_n_103),
        .O(\mul_ln9_reg_161[19]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[19]_i_3 
       (.I0(p_reg_n_104),
        .I1(tmp_product_n_104),
        .O(\mul_ln9_reg_161[19]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[19]_i_4 
       (.I0(p_reg_n_105),
        .I1(tmp_product_n_105),
        .O(\mul_ln9_reg_161[19]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[23]_i_2 
       (.I0(p_reg_n_99),
        .I1(tmp_product_n_99),
        .O(\mul_ln9_reg_161[23]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[23]_i_3 
       (.I0(p_reg_n_100),
        .I1(tmp_product_n_100),
        .O(\mul_ln9_reg_161[23]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[23]_i_4 
       (.I0(p_reg_n_101),
        .I1(tmp_product_n_101),
        .O(\mul_ln9_reg_161[23]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[23]_i_5 
       (.I0(p_reg_n_102),
        .I1(tmp_product_n_102),
        .O(\mul_ln9_reg_161[23]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[27]_i_2 
       (.I0(p_reg_n_95),
        .I1(tmp_product_n_95),
        .O(\mul_ln9_reg_161[27]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[27]_i_3 
       (.I0(p_reg_n_96),
        .I1(tmp_product_n_96),
        .O(\mul_ln9_reg_161[27]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[27]_i_4 
       (.I0(p_reg_n_97),
        .I1(tmp_product_n_97),
        .O(\mul_ln9_reg_161[27]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[27]_i_5 
       (.I0(p_reg_n_98),
        .I1(tmp_product_n_98),
        .O(\mul_ln9_reg_161[27]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[31]_i_3 
       (.I0(p_reg_n_91),
        .I1(tmp_product_n_91),
        .O(\mul_ln9_reg_161[31]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[31]_i_4 
       (.I0(p_reg_n_92),
        .I1(tmp_product_n_92),
        .O(\mul_ln9_reg_161[31]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[31]_i_5 
       (.I0(p_reg_n_93),
        .I1(tmp_product_n_93),
        .O(\mul_ln9_reg_161[31]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \mul_ln9_reg_161[31]_i_6 
       (.I0(p_reg_n_94),
        .I1(tmp_product_n_94),
        .O(\mul_ln9_reg_161[31]_i_6_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \mul_ln9_reg_161_reg[19]_i_1 
       (.CI(1'b0),
        .CO({\mul_ln9_reg_161_reg[19]_i_1_n_0 ,\mul_ln9_reg_161_reg[19]_i_1_n_1 ,\mul_ln9_reg_161_reg[19]_i_1_n_2 ,\mul_ln9_reg_161_reg[19]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({p_reg_n_103,p_reg_n_104,p_reg_n_105,1'b0}),
        .O(D[19:16]),
        .S({\mul_ln9_reg_161[19]_i_2_n_0 ,\mul_ln9_reg_161[19]_i_3_n_0 ,\mul_ln9_reg_161[19]_i_4_n_0 ,\p_reg[16]__0_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \mul_ln9_reg_161_reg[23]_i_1 
       (.CI(\mul_ln9_reg_161_reg[19]_i_1_n_0 ),
        .CO({\mul_ln9_reg_161_reg[23]_i_1_n_0 ,\mul_ln9_reg_161_reg[23]_i_1_n_1 ,\mul_ln9_reg_161_reg[23]_i_1_n_2 ,\mul_ln9_reg_161_reg[23]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({p_reg_n_99,p_reg_n_100,p_reg_n_101,p_reg_n_102}),
        .O(D[23:20]),
        .S({\mul_ln9_reg_161[23]_i_2_n_0 ,\mul_ln9_reg_161[23]_i_3_n_0 ,\mul_ln9_reg_161[23]_i_4_n_0 ,\mul_ln9_reg_161[23]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \mul_ln9_reg_161_reg[27]_i_1 
       (.CI(\mul_ln9_reg_161_reg[23]_i_1_n_0 ),
        .CO({\mul_ln9_reg_161_reg[27]_i_1_n_0 ,\mul_ln9_reg_161_reg[27]_i_1_n_1 ,\mul_ln9_reg_161_reg[27]_i_1_n_2 ,\mul_ln9_reg_161_reg[27]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({p_reg_n_95,p_reg_n_96,p_reg_n_97,p_reg_n_98}),
        .O(D[27:24]),
        .S({\mul_ln9_reg_161[27]_i_2_n_0 ,\mul_ln9_reg_161[27]_i_3_n_0 ,\mul_ln9_reg_161[27]_i_4_n_0 ,\mul_ln9_reg_161[27]_i_5_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \mul_ln9_reg_161_reg[31]_i_2 
       (.CI(\mul_ln9_reg_161_reg[27]_i_1_n_0 ),
        .CO({\NLW_mul_ln9_reg_161_reg[31]_i_2_CO_UNCONNECTED [3],\mul_ln9_reg_161_reg[31]_i_2_n_1 ,\mul_ln9_reg_161_reg[31]_i_2_n_2 ,\mul_ln9_reg_161_reg[31]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,p_reg_n_92,p_reg_n_93,p_reg_n_94}),
        .O(D[31:28]),
        .S({\mul_ln9_reg_161[31]_i_3_n_0 ,\mul_ln9_reg_161[31]_i_4_n_0 ,\mul_ln9_reg_161[31]_i_5_n_0 ,\mul_ln9_reg_161[31]_i_6_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 18x15 4}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("CASCADE"),
    .BCASCREG(1),
    .BREG(1),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(1),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    p_reg
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACIN({tmp_product__0_n_24,tmp_product__0_n_25,tmp_product__0_n_26,tmp_product__0_n_27,tmp_product__0_n_28,tmp_product__0_n_29,tmp_product__0_n_30,tmp_product__0_n_31,tmp_product__0_n_32,tmp_product__0_n_33,tmp_product__0_n_34,tmp_product__0_n_35,tmp_product__0_n_36,tmp_product__0_n_37,tmp_product__0_n_38,tmp_product__0_n_39,tmp_product__0_n_40,tmp_product__0_n_41,tmp_product__0_n_42,tmp_product__0_n_43,tmp_product__0_n_44,tmp_product__0_n_45,tmp_product__0_n_46,tmp_product__0_n_47,tmp_product__0_n_48,tmp_product__0_n_49,tmp_product__0_n_50,tmp_product__0_n_51,tmp_product__0_n_52,tmp_product__0_n_53}),
        .ACOUT(NLW_p_reg_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({a_q0[31],a_q0[31],a_q0[31],a_q0[31:17]}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_p_reg_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_p_reg_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_p_reg_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(1'b0),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(a_load_reg_1510),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b1),
        .CLK(ap_clk),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_p_reg_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b1,1'b0,1'b1,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_p_reg_OVERFLOW_UNCONNECTED),
        .P({p_reg_n_58,p_reg_n_59,p_reg_n_60,p_reg_n_61,p_reg_n_62,p_reg_n_63,p_reg_n_64,p_reg_n_65,p_reg_n_66,p_reg_n_67,p_reg_n_68,p_reg_n_69,p_reg_n_70,p_reg_n_71,p_reg_n_72,p_reg_n_73,p_reg_n_74,p_reg_n_75,p_reg_n_76,p_reg_n_77,p_reg_n_78,p_reg_n_79,p_reg_n_80,p_reg_n_81,p_reg_n_82,p_reg_n_83,p_reg_n_84,p_reg_n_85,p_reg_n_86,p_reg_n_87,p_reg_n_88,p_reg_n_89,p_reg_n_90,p_reg_n_91,p_reg_n_92,p_reg_n_93,p_reg_n_94,p_reg_n_95,p_reg_n_96,p_reg_n_97,p_reg_n_98,p_reg_n_99,p_reg_n_100,p_reg_n_101,p_reg_n_102,p_reg_n_103,p_reg_n_104,p_reg_n_105}),
        .PATTERNBDETECT(NLW_p_reg_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_p_reg_PATTERNDETECT_UNCONNECTED),
        .PCIN({tmp_product__0_n_106,tmp_product__0_n_107,tmp_product__0_n_108,tmp_product__0_n_109,tmp_product__0_n_110,tmp_product__0_n_111,tmp_product__0_n_112,tmp_product__0_n_113,tmp_product__0_n_114,tmp_product__0_n_115,tmp_product__0_n_116,tmp_product__0_n_117,tmp_product__0_n_118,tmp_product__0_n_119,tmp_product__0_n_120,tmp_product__0_n_121,tmp_product__0_n_122,tmp_product__0_n_123,tmp_product__0_n_124,tmp_product__0_n_125,tmp_product__0_n_126,tmp_product__0_n_127,tmp_product__0_n_128,tmp_product__0_n_129,tmp_product__0_n_130,tmp_product__0_n_131,tmp_product__0_n_132,tmp_product__0_n_133,tmp_product__0_n_134,tmp_product__0_n_135,tmp_product__0_n_136,tmp_product__0_n_137,tmp_product__0_n_138,tmp_product__0_n_139,tmp_product__0_n_140,tmp_product__0_n_141,tmp_product__0_n_142,tmp_product__0_n_143,tmp_product__0_n_144,tmp_product__0_n_145,tmp_product__0_n_146,tmp_product__0_n_147,tmp_product__0_n_148,tmp_product__0_n_149,tmp_product__0_n_150,tmp_product__0_n_151,tmp_product__0_n_152,tmp_product__0_n_153}),
        .PCOUT(NLW_p_reg_PCOUT_UNCONNECTED[47:0]),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_p_reg_UNDERFLOW_UNCONNECTED));
  FDRE \p_reg[0]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_105),
        .Q(D[0]),
        .R(1'b0));
  FDRE \p_reg[10]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_95),
        .Q(D[10]),
        .R(1'b0));
  FDRE \p_reg[11]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_94),
        .Q(D[11]),
        .R(1'b0));
  FDRE \p_reg[12]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_93),
        .Q(D[12]),
        .R(1'b0));
  FDRE \p_reg[13]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_92),
        .Q(D[13]),
        .R(1'b0));
  FDRE \p_reg[14]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_91),
        .Q(D[14]),
        .R(1'b0));
  FDRE \p_reg[15]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_90),
        .Q(D[15]),
        .R(1'b0));
  FDRE \p_reg[16]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_89),
        .Q(\p_reg[16]__0_n_0 ),
        .R(1'b0));
  FDRE \p_reg[1]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_104),
        .Q(D[1]),
        .R(1'b0));
  FDRE \p_reg[2]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_103),
        .Q(D[2]),
        .R(1'b0));
  FDRE \p_reg[3]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_102),
        .Q(D[3]),
        .R(1'b0));
  FDRE \p_reg[4]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_101),
        .Q(D[4]),
        .R(1'b0));
  FDRE \p_reg[5]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_100),
        .Q(D[5]),
        .R(1'b0));
  FDRE \p_reg[6]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_99),
        .Q(D[6]),
        .R(1'b0));
  FDRE \p_reg[7]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_98),
        .Q(D[7]),
        .R(1'b0));
  FDRE \p_reg[8]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_97),
        .Q(D[8]),
        .R(1'b0));
  FDRE \p_reg[9]__0 
       (.C(ap_clk),
        .CE(1'b1),
        .D(tmp_product__0_n_96),
        .Q(D[9]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 15x18 4}}" *) 
  DSP48E1 #(
    .ACASCREG(1),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(1),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(1),
    .BREG(1),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(1),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    tmp_product
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,a_q0[16:0]}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT(NLW_tmp_product_ACOUT_UNCONNECTED[29:0]),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({b_q0[31],b_q0[31],b_q0[31],b_q0[31:17]}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_tmp_product_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_tmp_product_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_tmp_product_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(a_load_reg_1510),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(a_load_reg_1510),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b1),
        .CLK(ap_clk),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_tmp_product_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_tmp_product_OVERFLOW_UNCONNECTED),
        .P({tmp_product_n_58,tmp_product_n_59,tmp_product_n_60,tmp_product_n_61,tmp_product_n_62,tmp_product_n_63,tmp_product_n_64,tmp_product_n_65,tmp_product_n_66,tmp_product_n_67,tmp_product_n_68,tmp_product_n_69,tmp_product_n_70,tmp_product_n_71,tmp_product_n_72,tmp_product_n_73,tmp_product_n_74,tmp_product_n_75,tmp_product_n_76,tmp_product_n_77,tmp_product_n_78,tmp_product_n_79,tmp_product_n_80,tmp_product_n_81,tmp_product_n_82,tmp_product_n_83,tmp_product_n_84,tmp_product_n_85,tmp_product_n_86,tmp_product_n_87,tmp_product_n_88,tmp_product_n_89,tmp_product_n_90,tmp_product_n_91,tmp_product_n_92,tmp_product_n_93,tmp_product_n_94,tmp_product_n_95,tmp_product_n_96,tmp_product_n_97,tmp_product_n_98,tmp_product_n_99,tmp_product_n_100,tmp_product_n_101,tmp_product_n_102,tmp_product_n_103,tmp_product_n_104,tmp_product_n_105}),
        .PATTERNBDETECT(NLW_tmp_product_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_tmp_product_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT({tmp_product_n_106,tmp_product_n_107,tmp_product_n_108,tmp_product_n_109,tmp_product_n_110,tmp_product_n_111,tmp_product_n_112,tmp_product_n_113,tmp_product_n_114,tmp_product_n_115,tmp_product_n_116,tmp_product_n_117,tmp_product_n_118,tmp_product_n_119,tmp_product_n_120,tmp_product_n_121,tmp_product_n_122,tmp_product_n_123,tmp_product_n_124,tmp_product_n_125,tmp_product_n_126,tmp_product_n_127,tmp_product_n_128,tmp_product_n_129,tmp_product_n_130,tmp_product_n_131,tmp_product_n_132,tmp_product_n_133,tmp_product_n_134,tmp_product_n_135,tmp_product_n_136,tmp_product_n_137,tmp_product_n_138,tmp_product_n_139,tmp_product_n_140,tmp_product_n_141,tmp_product_n_142,tmp_product_n_143,tmp_product_n_144,tmp_product_n_145,tmp_product_n_146,tmp_product_n_147,tmp_product_n_148,tmp_product_n_149,tmp_product_n_150,tmp_product_n_151,tmp_product_n_152,tmp_product_n_153}),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_tmp_product_UNDERFLOW_UNCONNECTED));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 18x18 4}}" *) 
  DSP48E1 #(
    .ACASCREG(1),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(1),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(1),
    .BREG(1),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    tmp_product__0
       (.A({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,b_q0[16:0]}),
        .ACIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ACOUT({tmp_product__0_n_24,tmp_product__0_n_25,tmp_product__0_n_26,tmp_product__0_n_27,tmp_product__0_n_28,tmp_product__0_n_29,tmp_product__0_n_30,tmp_product__0_n_31,tmp_product__0_n_32,tmp_product__0_n_33,tmp_product__0_n_34,tmp_product__0_n_35,tmp_product__0_n_36,tmp_product__0_n_37,tmp_product__0_n_38,tmp_product__0_n_39,tmp_product__0_n_40,tmp_product__0_n_41,tmp_product__0_n_42,tmp_product__0_n_43,tmp_product__0_n_44,tmp_product__0_n_45,tmp_product__0_n_46,tmp_product__0_n_47,tmp_product__0_n_48,tmp_product__0_n_49,tmp_product__0_n_50,tmp_product__0_n_51,tmp_product__0_n_52,tmp_product__0_n_53}),
        .ALUMODE({1'b0,1'b0,1'b0,1'b0}),
        .B({1'b0,a_q0[16:0]}),
        .BCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .BCOUT(NLW_tmp_product__0_BCOUT_UNCONNECTED[17:0]),
        .C({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .CARRYCASCIN(1'b0),
        .CARRYCASCOUT(NLW_tmp_product__0_CARRYCASCOUT_UNCONNECTED),
        .CARRYIN(1'b0),
        .CARRYINSEL({1'b0,1'b0,1'b0}),
        .CARRYOUT(NLW_tmp_product__0_CARRYOUT_UNCONNECTED[3:0]),
        .CEA1(1'b0),
        .CEA2(a_load_reg_1510),
        .CEAD(1'b0),
        .CEALUMODE(1'b0),
        .CEB1(1'b0),
        .CEB2(a_load_reg_1510),
        .CEC(1'b0),
        .CECARRYIN(1'b0),
        .CECTRL(1'b0),
        .CED(1'b0),
        .CEINMODE(1'b0),
        .CEM(1'b0),
        .CEP(1'b0),
        .CLK(ap_clk),
        .D({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .INMODE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .MULTSIGNIN(1'b0),
        .MULTSIGNOUT(NLW_tmp_product__0_MULTSIGNOUT_UNCONNECTED),
        .OPMODE({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}),
        .OVERFLOW(NLW_tmp_product__0_OVERFLOW_UNCONNECTED),
        .P({tmp_product__0_n_58,tmp_product__0_n_59,tmp_product__0_n_60,tmp_product__0_n_61,tmp_product__0_n_62,tmp_product__0_n_63,tmp_product__0_n_64,tmp_product__0_n_65,tmp_product__0_n_66,tmp_product__0_n_67,tmp_product__0_n_68,tmp_product__0_n_69,tmp_product__0_n_70,tmp_product__0_n_71,tmp_product__0_n_72,tmp_product__0_n_73,tmp_product__0_n_74,tmp_product__0_n_75,tmp_product__0_n_76,tmp_product__0_n_77,tmp_product__0_n_78,tmp_product__0_n_79,tmp_product__0_n_80,tmp_product__0_n_81,tmp_product__0_n_82,tmp_product__0_n_83,tmp_product__0_n_84,tmp_product__0_n_85,tmp_product__0_n_86,tmp_product__0_n_87,tmp_product__0_n_88,tmp_product__0_n_89,tmp_product__0_n_90,tmp_product__0_n_91,tmp_product__0_n_92,tmp_product__0_n_93,tmp_product__0_n_94,tmp_product__0_n_95,tmp_product__0_n_96,tmp_product__0_n_97,tmp_product__0_n_98,tmp_product__0_n_99,tmp_product__0_n_100,tmp_product__0_n_101,tmp_product__0_n_102,tmp_product__0_n_103,tmp_product__0_n_104,tmp_product__0_n_105}),
        .PATTERNBDETECT(NLW_tmp_product__0_PATTERNBDETECT_UNCONNECTED),
        .PATTERNDETECT(NLW_tmp_product__0_PATTERNDETECT_UNCONNECTED),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT({tmp_product__0_n_106,tmp_product__0_n_107,tmp_product__0_n_108,tmp_product__0_n_109,tmp_product__0_n_110,tmp_product__0_n_111,tmp_product__0_n_112,tmp_product__0_n_113,tmp_product__0_n_114,tmp_product__0_n_115,tmp_product__0_n_116,tmp_product__0_n_117,tmp_product__0_n_118,tmp_product__0_n_119,tmp_product__0_n_120,tmp_product__0_n_121,tmp_product__0_n_122,tmp_product__0_n_123,tmp_product__0_n_124,tmp_product__0_n_125,tmp_product__0_n_126,tmp_product__0_n_127,tmp_product__0_n_128,tmp_product__0_n_129,tmp_product__0_n_130,tmp_product__0_n_131,tmp_product__0_n_132,tmp_product__0_n_133,tmp_product__0_n_134,tmp_product__0_n_135,tmp_product__0_n_136,tmp_product__0_n_137,tmp_product__0_n_138,tmp_product__0_n_139,tmp_product__0_n_140,tmp_product__0_n_141,tmp_product__0_n_142,tmp_product__0_n_143,tmp_product__0_n_144,tmp_product__0_n_145,tmp_product__0_n_146,tmp_product__0_n_147,tmp_product__0_n_148,tmp_product__0_n_149,tmp_product__0_n_150,tmp_product__0_n_151,tmp_product__0_n_152,tmp_product__0_n_153}),
        .RSTA(1'b0),
        .RSTALLCARRYIN(1'b0),
        .RSTALUMODE(1'b0),
        .RSTB(1'b0),
        .RSTC(1'b0),
        .RSTCTRL(1'b0),
        .RSTD(1'b0),
        .RSTINMODE(1'b0),
        .RSTM(1'b0),
        .RSTP(1'b0),
        .UNDERFLOW(NLW_tmp_product__0_UNDERFLOW_UNCONNECTED));
  LUT2 #(
    .INIT(4'h2)) 
    tmp_product_i_1
       (.I0(Q),
        .I1(icmp_ln7_reg_137),
        .O(a_load_reg_1510));
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
