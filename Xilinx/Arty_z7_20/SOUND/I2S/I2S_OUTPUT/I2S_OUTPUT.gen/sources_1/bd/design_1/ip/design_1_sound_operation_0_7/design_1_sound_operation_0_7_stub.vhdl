-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Tue May 11 08:55:58 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.gen/sources_1/bd/design_1/ip/design_1_sound_operation_0_7/design_1_sound_operation_0_7_stub.vhdl
-- Design      : design_1_sound_operation_0_7
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_sound_operation_0_7 is
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
    m_axi_ram_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_ram_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_ram_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_ram_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ram_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ram_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ram_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ram_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_ram_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ram_AWVALID : out STD_LOGIC;
    m_axi_ram_AWREADY : in STD_LOGIC;
    m_axi_ram_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_ram_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ram_WLAST : out STD_LOGIC;
    m_axi_ram_WVALID : out STD_LOGIC;
    m_axi_ram_WREADY : in STD_LOGIC;
    m_axi_ram_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ram_BVALID : in STD_LOGIC;
    m_axi_ram_BREADY : out STD_LOGIC;
    m_axi_ram_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_ram_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_ram_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_ram_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ram_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ram_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ram_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ram_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_ram_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_ram_ARVALID : out STD_LOGIC;
    m_axi_ram_ARREADY : in STD_LOGIC;
    m_axi_ram_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_ram_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_ram_RLAST : in STD_LOGIC;
    m_axi_ram_RVALID : in STD_LOGIC;
    m_axi_ram_RREADY : out STD_LOGIC;
    sdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    opeout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    count : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end design_1_sound_operation_0_7;

architecture stub of design_1_sound_operation_0_7 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_control_AWADDR[5:0],s_axi_control_AWVALID,s_axi_control_AWREADY,s_axi_control_WDATA[31:0],s_axi_control_WSTRB[3:0],s_axi_control_WVALID,s_axi_control_WREADY,s_axi_control_BRESP[1:0],s_axi_control_BVALID,s_axi_control_BREADY,s_axi_control_ARADDR[5:0],s_axi_control_ARVALID,s_axi_control_ARREADY,s_axi_control_RDATA[31:0],s_axi_control_RRESP[1:0],s_axi_control_RVALID,s_axi_control_RREADY,ap_clk,ap_rst_n,m_axi_ram_AWADDR[63:0],m_axi_ram_AWLEN[7:0],m_axi_ram_AWSIZE[2:0],m_axi_ram_AWBURST[1:0],m_axi_ram_AWLOCK[1:0],m_axi_ram_AWREGION[3:0],m_axi_ram_AWCACHE[3:0],m_axi_ram_AWPROT[2:0],m_axi_ram_AWQOS[3:0],m_axi_ram_AWVALID,m_axi_ram_AWREADY,m_axi_ram_WDATA[31:0],m_axi_ram_WSTRB[3:0],m_axi_ram_WLAST,m_axi_ram_WVALID,m_axi_ram_WREADY,m_axi_ram_BRESP[1:0],m_axi_ram_BVALID,m_axi_ram_BREADY,m_axi_ram_ARADDR[63:0],m_axi_ram_ARLEN[7:0],m_axi_ram_ARSIZE[2:0],m_axi_ram_ARBURST[1:0],m_axi_ram_ARLOCK[1:0],m_axi_ram_ARREGION[3:0],m_axi_ram_ARCACHE[3:0],m_axi_ram_ARPROT[2:0],m_axi_ram_ARQOS[3:0],m_axi_ram_ARVALID,m_axi_ram_ARREADY,m_axi_ram_RDATA[31:0],m_axi_ram_RRESP[1:0],m_axi_ram_RLAST,m_axi_ram_RVALID,m_axi_ram_RREADY,sdata[31:0],opeout[31:0],count[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "sound_operation,Vivado 2020.2";
begin
end;
