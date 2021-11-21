-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Tue May 11 08:25:35 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.gen/sources_1/bd/design_1/ip/design_1_MAIN_0_0/design_1_MAIN_0_0_stub.vhdl
-- Design      : design_1_MAIN_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_MAIN_0_0 is
  Port ( 
    CLK : in STD_LOGIC;
    RESET : in STD_LOGIC;
    MCLK_IN_IBUF : in STD_LOGIC;
    BCLK_OUT : out STD_LOGIC;
    AUDIO_DATA_OUT : out STD_LOGIC;
    LRCLK_OUT : out STD_LOGIC;
    SOUND_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    COUNT_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    GP_OPERATION : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end design_1_MAIN_0_0;

architecture stub of design_1_MAIN_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,RESET,MCLK_IN_IBUF,BCLK_OUT,AUDIO_DATA_OUT,LRCLK_OUT,SOUND_IN[31:0],COUNT_OUT[31:0],GP_OPERATION[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "MAIN,Vivado 2020.2";
begin
end;
