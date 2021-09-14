-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Sat May  8 15:18:16 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/Graphic/mapchip/vivado/MAPCHIP.gen/sources_1/bd/design_1/ip/design_1_mapchip_0_0/design_1_mapchip_0_0_stub.vhdl
-- Design      : design_1_mapchip_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_mapchip_0_0 is
  Port ( 
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_AWREADY : out STD_LOGIC;
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_WREADY : out STD_LOGIC;
    s_axi_control_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_BVALID : out STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARREADY : out STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_RVALID : out STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    m_axi_src_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_src_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_src_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_src_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_src_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_src_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_src_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_src_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_src_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_src_AWVALID : out STD_LOGIC;
    m_axi_src_AWREADY : in STD_LOGIC;
    m_axi_src_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_src_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_src_WLAST : out STD_LOGIC;
    m_axi_src_WVALID : out STD_LOGIC;
    m_axi_src_WREADY : in STD_LOGIC;
    m_axi_src_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_src_BVALID : in STD_LOGIC;
    m_axi_src_BREADY : out STD_LOGIC;
    m_axi_src_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_src_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_src_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_src_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_src_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_src_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_src_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_src_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_src_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_src_ARVALID : out STD_LOGIC;
    m_axi_src_ARREADY : in STD_LOGIC;
    m_axi_src_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_src_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_src_RLAST : in STD_LOGIC;
    m_axi_src_RVALID : in STD_LOGIC;
    m_axi_src_RREADY : out STD_LOGIC;
    m_axi_dst_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_dst_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_dst_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dst_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dst_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dst_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dst_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dst_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dst_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dst_AWVALID : out STD_LOGIC;
    m_axi_dst_AWREADY : in STD_LOGIC;
    m_axi_dst_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dst_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dst_WLAST : out STD_LOGIC;
    m_axi_dst_WVALID : out STD_LOGIC;
    m_axi_dst_WREADY : in STD_LOGIC;
    m_axi_dst_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dst_BVALID : in STD_LOGIC;
    m_axi_dst_BREADY : out STD_LOGIC;
    m_axi_dst_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_dst_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_dst_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dst_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dst_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dst_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dst_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dst_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_dst_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_dst_ARVALID : out STD_LOGIC;
    m_axi_dst_ARREADY : in STD_LOGIC;
    m_axi_dst_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_dst_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_dst_RLAST : in STD_LOGIC;
    m_axi_dst_RVALID : in STD_LOGIC;
    m_axi_dst_RREADY : out STD_LOGIC
  );

end design_1_mapchip_0_0;

architecture stub of design_1_mapchip_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_control_AWADDR[5:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[5:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,interrupt,m_axi_src_AWADDR[63:0],m_axi_src_AWLEN[7:0],m_axi_src_AWSIZE[2:0],m_axi_src_AWBURST[1:0],m_axi_src_AWLOCK[1:0],m_axi_src_AWREGION[3:0],m_axi_src_AWCACHE[3:0],m_axi_src_AWPROT[2:0],m_axi_src_AWQOS[3:0],m_axi_src_AWVALID,m_axi_src_AWREADY,m_axi_src_WDATA[31:0],m_axi_src_WSTRB[3:0],m_axi_src_WLAST,m_axi_src_WVALID,m_axi_src_WREADY,m_axi_src_BRESP[1:0],m_axi_src_BVALID,m_axi_src_BREADY,m_axi_src_ARADDR[63:0],m_axi_src_ARLEN[7:0],m_axi_src_ARSIZE[2:0],m_axi_src_ARBURST[1:0],m_axi_src_ARLOCK[1:0],m_axi_src_ARREGION[3:0],m_axi_src_ARCACHE[3:0],m_axi_src_ARPROT[2:0],m_axi_src_ARQOS[3:0],m_axi_src_ARVALID,m_axi_src_ARREADY,m_axi_src_RDATA[31:0],m_axi_src_RRESP[1:0],m_axi_src_RLAST,m_axi_src_RVALID,m_axi_src_RREADY,m_axi_dst_AWADDR[63:0],m_axi_dst_AWLEN[7:0],m_axi_dst_AWSIZE[2:0],m_axi_dst_AWBURST[1:0],m_axi_dst_AWLOCK[1:0],m_axi_dst_AWREGION[3:0],m_axi_dst_AWCACHE[3:0],m_axi_dst_AWPROT[2:0],m_axi_dst_AWQOS[3:0],m_axi_dst_AWVALID,m_axi_dst_AWREADY,m_axi_dst_WDATA[31:0],m_axi_dst_WSTRB[3:0],m_axi_dst_WLAST,m_axi_dst_WVALID,m_axi_dst_WREADY,m_axi_dst_BRESP[1:0],m_axi_dst_BVALID,m_axi_dst_BREADY,m_axi_dst_ARADDR[63:0],m_axi_dst_ARLEN[7:0],m_axi_dst_ARSIZE[2:0],m_axi_dst_ARBURST[1:0],m_axi_dst_ARLOCK[1:0],m_axi_dst_ARREGION[3:0],m_axi_dst_ARCACHE[3:0],m_axi_dst_ARPROT[2:0],m_axi_dst_ARQOS[3:0],m_axi_dst_ARVALID,m_axi_dst_ARREADY,m_axi_dst_RDATA[31:0],m_axi_dst_RRESP[1:0],m_axi_dst_RLAST,m_axi_dst_RVALID,m_axi_dst_RREADY";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "mapchip,Vivado 2020.2";
begin
end;
