-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Mon May 10 19:52:53 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_sound_operation_0_6_stub.vhdl
-- Design      : design_1_sound_operation_0_6
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
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
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    m_axi_sound_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_sound_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sound_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_AWVALID : out STD_LOGIC;
    m_axi_sound_AWREADY : in STD_LOGIC;
    m_axi_sound_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sound_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_WLAST : out STD_LOGIC;
    m_axi_sound_WVALID : out STD_LOGIC;
    m_axi_sound_WREADY : in STD_LOGIC;
    m_axi_sound_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_BVALID : in STD_LOGIC;
    m_axi_sound_BREADY : out STD_LOGIC;
    m_axi_sound_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_sound_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sound_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_ARVALID : out STD_LOGIC;
    m_axi_sound_ARREADY : in STD_LOGIC;
    m_axi_sound_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sound_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_RLAST : in STD_LOGIC;
    m_axi_sound_RVALID : in STD_LOGIC;
    m_axi_sound_RREADY : out STD_LOGIC;
    outdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    status : in STD_LOGIC_VECTOR ( 31 downto 0 );
    response : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_control_AWADDR[5:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[5:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,ap_start,ap_done,ap_idle,ap_ready,m_axi_sound_AWADDR[63:0],m_axi_sound_AWLEN[7:0],m_axi_sound_AWSIZE[2:0],m_axi_sound_AWBURST[1:0],m_axi_sound_AWLOCK[1:0],m_axi_sound_AWREGION[3:0],m_axi_sound_AWCACHE[3:0],m_axi_sound_AWPROT[2:0],m_axi_sound_AWQOS[3:0],m_axi_sound_AWVALID,m_axi_sound_AWREADY,m_axi_sound_WDATA[31:0],m_axi_sound_WSTRB[3:0],m_axi_sound_WLAST,m_axi_sound_WVALID,m_axi_sound_WREADY,m_axi_sound_BRESP[1:0],m_axi_sound_BVALID,m_axi_sound_BREADY,m_axi_sound_ARADDR[63:0],m_axi_sound_ARLEN[7:0],m_axi_sound_ARSIZE[2:0],m_axi_sound_ARBURST[1:0],m_axi_sound_ARLOCK[1:0],m_axi_sound_ARREGION[3:0],m_axi_sound_ARCACHE[3:0],m_axi_sound_ARPROT[2:0],m_axi_sound_ARQOS[3:0],m_axi_sound_ARVALID,m_axi_sound_ARREADY,m_axi_sound_RDATA[31:0],m_axi_sound_RRESP[1:0],m_axi_sound_RLAST,m_axi_sound_RVALID,m_axi_sound_RREADY,outdata[31:0],status[31:0],response[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "sound_operation,Vivado 2020.2";
begin
end;
