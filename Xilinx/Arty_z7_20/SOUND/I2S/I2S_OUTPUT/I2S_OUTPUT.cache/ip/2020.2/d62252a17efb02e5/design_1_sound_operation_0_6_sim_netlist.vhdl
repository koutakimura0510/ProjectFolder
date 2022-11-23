-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Mon May 10 19:52:53 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_sound_operation_0_6_sim_netlist.vhdl
-- Design      : design_1_sound_operation_0_6
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_onehot_rstate_reg[1]_0\ : out STD_LOGIC;
    s_axi_control_BVALID : out STD_LOGIC;
    \FSM_onehot_wstate_reg[2]_0\ : out STD_LOGIC;
    \FSM_onehot_wstate_reg[1]_0\ : out STD_LOGIC;
    s_axi_control_RVALID : out STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_rst_n : in STD_LOGIC;
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    ap_clk : in STD_LOGIC;
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi is
  signal \FSM_onehot_rstate[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_rstate[2]_i_1_n_0\ : STD_LOGIC;
  signal \^fsm_onehot_rstate_reg[1]_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[3]_i_1_n_0\ : STD_LOGIC;
  signal \^fsm_onehot_wstate_reg[1]_0\ : STD_LOGIC;
  signal \^fsm_onehot_wstate_reg[2]_0\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal int_len : STD_LOGIC;
  signal int_len0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \int_len_reg_n_0_[0]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[10]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[11]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[12]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[13]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[14]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[15]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[16]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[17]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[18]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[19]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[1]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[20]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[21]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[22]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[23]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[24]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[25]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[26]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[27]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[28]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[29]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[2]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[30]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[31]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[3]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[4]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[5]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[6]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[7]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[8]\ : STD_LOGIC;
  signal \int_len_reg_n_0_[9]\ : STD_LOGIC;
  signal int_ramadr : STD_LOGIC;
  signal int_ramadr3_out : STD_LOGIC;
  signal \int_ramadr[31]_i_3_n_0\ : STD_LOGIC;
  signal int_ramadr_reg0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal int_ramadr_reg02_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \int_ramadr_reg_n_0_[0]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[10]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[11]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[12]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[13]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[14]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[15]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[16]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[17]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[18]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[19]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[1]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[20]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[21]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[22]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[23]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[24]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[25]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[26]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[27]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[28]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[29]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[2]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[30]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[31]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[32]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[33]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[34]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[35]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[36]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[37]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[38]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[39]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[3]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[40]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[41]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[42]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[43]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[44]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[45]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[46]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[47]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[48]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[49]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[4]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[50]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[51]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[52]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[53]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[54]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[55]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[56]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[57]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[58]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[59]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[5]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[60]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[61]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[62]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[63]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[6]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[7]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[8]\ : STD_LOGIC;
  signal \int_ramadr_reg_n_0_[9]\ : STD_LOGIC;
  signal rdata : STD_LOGIC;
  signal \rdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[10]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[11]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[12]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[13]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[14]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[15]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[16]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[17]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[18]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[19]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[20]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[21]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[22]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[23]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[24]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[25]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[26]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[27]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[28]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[29]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[30]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_3_n_0\ : STD_LOGIC;
  signal \rdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[7]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[8]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[9]_i_1_n_0\ : STD_LOGIC;
  signal \^s_axi_control_bvalid\ : STD_LOGIC;
  signal \^s_axi_control_rvalid\ : STD_LOGIC;
  signal waddr : STD_LOGIC;
  signal \waddr_reg_n_0_[0]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[1]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[2]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[3]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[4]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[5]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_rstate[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_onehot_rstate[2]_i_1\ : label is "soft_lutpair0";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_rstate_reg[1]\ : label is "RDIDLE:010,RDDATA:100,iSTATE:001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_rstate_reg[2]\ : label is "RDIDLE:010,RDDATA:100,iSTATE:001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[1]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[2]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[3]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute SOFT_HLUTNM of \int_len[0]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \int_len[10]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \int_len[11]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \int_len[12]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \int_len[13]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \int_len[14]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \int_len[15]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \int_len[16]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \int_len[17]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \int_len[18]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \int_len[19]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \int_len[1]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \int_len[20]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \int_len[21]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \int_len[22]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \int_len[23]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \int_len[24]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \int_len[25]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \int_len[26]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \int_len[27]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \int_len[28]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \int_len[29]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \int_len[2]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \int_len[30]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \int_len[31]_i_2\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \int_len[3]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \int_len[4]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \int_len[5]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \int_len[6]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \int_len[7]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \int_len[8]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \int_len[9]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \int_ramadr[0]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \int_ramadr[10]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \int_ramadr[11]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \int_ramadr[12]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \int_ramadr[13]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \int_ramadr[14]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \int_ramadr[15]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \int_ramadr[16]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \int_ramadr[17]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \int_ramadr[18]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \int_ramadr[19]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \int_ramadr[1]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \int_ramadr[20]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \int_ramadr[21]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \int_ramadr[22]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \int_ramadr[23]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \int_ramadr[24]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \int_ramadr[25]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \int_ramadr[26]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \int_ramadr[27]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \int_ramadr[28]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \int_ramadr[29]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \int_ramadr[2]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \int_ramadr[30]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \int_ramadr[31]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \int_ramadr[32]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \int_ramadr[33]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \int_ramadr[34]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \int_ramadr[35]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \int_ramadr[36]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \int_ramadr[37]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \int_ramadr[38]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \int_ramadr[39]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \int_ramadr[3]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \int_ramadr[40]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \int_ramadr[41]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \int_ramadr[42]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \int_ramadr[43]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \int_ramadr[44]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \int_ramadr[45]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \int_ramadr[46]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \int_ramadr[47]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \int_ramadr[48]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \int_ramadr[49]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \int_ramadr[4]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \int_ramadr[50]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \int_ramadr[51]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \int_ramadr[52]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \int_ramadr[53]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \int_ramadr[54]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \int_ramadr[55]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \int_ramadr[56]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \int_ramadr[57]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \int_ramadr[58]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \int_ramadr[59]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \int_ramadr[5]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \int_ramadr[60]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \int_ramadr[61]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \int_ramadr[62]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \int_ramadr[63]_i_2\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \int_ramadr[6]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \int_ramadr[7]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \int_ramadr[8]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \int_ramadr[9]_i_1\ : label is "soft_lutpair12";
begin
  \FSM_onehot_rstate_reg[1]_0\ <= \^fsm_onehot_rstate_reg[1]_0\;
  \FSM_onehot_wstate_reg[1]_0\ <= \^fsm_onehot_wstate_reg[1]_0\;
  \FSM_onehot_wstate_reg[2]_0\ <= \^fsm_onehot_wstate_reg[2]_0\;
  SR(0) <= \^sr\(0);
  s_axi_control_BVALID <= \^s_axi_control_bvalid\;
  s_axi_control_RVALID <= \^s_axi_control_rvalid\;
\FSM_onehot_rstate[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F747"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => \^fsm_onehot_rstate_reg[1]_0\,
      I2 => \^s_axi_control_rvalid\,
      I3 => s_axi_control_RREADY,
      O => \FSM_onehot_rstate[1]_i_1_n_0\
    );
\FSM_onehot_rstate[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => \^fsm_onehot_rstate_reg[1]_0\,
      I2 => s_axi_control_RREADY,
      I3 => \^s_axi_control_rvalid\,
      O => \FSM_onehot_rstate[2]_i_1_n_0\
    );
\FSM_onehot_rstate_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_rstate[1]_i_1_n_0\,
      Q => \^fsm_onehot_rstate_reg[1]_0\,
      R => \^sr\(0)
    );
\FSM_onehot_rstate_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_rstate[2]_i_1_n_0\,
      Q => \^s_axi_control_rvalid\,
      R => \^sr\(0)
    );
\FSM_onehot_wstate[1]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => ap_rst_n,
      O => \^sr\(0)
    );
\FSM_onehot_wstate[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF1D0C1D"
    )
        port map (
      I0 => \^fsm_onehot_wstate_reg[2]_0\,
      I1 => \^fsm_onehot_wstate_reg[1]_0\,
      I2 => s_axi_control_AWVALID,
      I3 => \^s_axi_control_bvalid\,
      I4 => s_axi_control_BREADY,
      O => \FSM_onehot_wstate[1]_i_2_n_0\
    );
\FSM_onehot_wstate[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => s_axi_control_AWVALID,
      I1 => \^fsm_onehot_wstate_reg[1]_0\,
      I2 => s_axi_control_WVALID,
      I3 => \^fsm_onehot_wstate_reg[2]_0\,
      O => \FSM_onehot_wstate[2]_i_1_n_0\
    );
\FSM_onehot_wstate[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88F8"
    )
        port map (
      I0 => s_axi_control_WVALID,
      I1 => \^fsm_onehot_wstate_reg[2]_0\,
      I2 => \^s_axi_control_bvalid\,
      I3 => s_axi_control_BREADY,
      O => \FSM_onehot_wstate[3]_i_1_n_0\
    );
\FSM_onehot_wstate_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_wstate[1]_i_2_n_0\,
      Q => \^fsm_onehot_wstate_reg[1]_0\,
      R => \^sr\(0)
    );
\FSM_onehot_wstate_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_wstate[2]_i_1_n_0\,
      Q => \^fsm_onehot_wstate_reg[2]_0\,
      R => \^sr\(0)
    );
\FSM_onehot_wstate_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_wstate[3]_i_1_n_0\,
      Q => \^s_axi_control_bvalid\,
      R => \^sr\(0)
    );
\int_len[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[0]\,
      O => int_len0(0)
    );
\int_len[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(10),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[10]\,
      O => int_len0(10)
    );
\int_len[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(11),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[11]\,
      O => int_len0(11)
    );
\int_len[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(12),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[12]\,
      O => int_len0(12)
    );
\int_len[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(13),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[13]\,
      O => int_len0(13)
    );
\int_len[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(14),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[14]\,
      O => int_len0(14)
    );
\int_len[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(15),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[15]\,
      O => int_len0(15)
    );
\int_len[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(16),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[16]\,
      O => int_len0(16)
    );
\int_len[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(17),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[17]\,
      O => int_len0(17)
    );
\int_len[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(18),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[18]\,
      O => int_len0(18)
    );
\int_len[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(19),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[19]\,
      O => int_len0(19)
    );
\int_len[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[1]\,
      O => int_len0(1)
    );
\int_len[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(20),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[20]\,
      O => int_len0(20)
    );
\int_len[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(21),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[21]\,
      O => int_len0(21)
    );
\int_len[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(22),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[22]\,
      O => int_len0(22)
    );
\int_len[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(23),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_len_reg_n_0_[23]\,
      O => int_len0(23)
    );
\int_len[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(24),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[24]\,
      O => int_len0(24)
    );
\int_len[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(25),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[25]\,
      O => int_len0(25)
    );
\int_len[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(26),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[26]\,
      O => int_len0(26)
    );
\int_len[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(27),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[27]\,
      O => int_len0(27)
    );
\int_len[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(28),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[28]\,
      O => int_len0(28)
    );
\int_len[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(29),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[29]\,
      O => int_len0(29)
    );
\int_len[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(2),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[2]\,
      O => int_len0(2)
    );
\int_len[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(30),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[30]\,
      O => int_len0(30)
    );
\int_len[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \^fsm_onehot_wstate_reg[2]_0\,
      I1 => s_axi_control_WVALID,
      I2 => \waddr_reg_n_0_[2]\,
      I3 => \waddr_reg_n_0_[3]\,
      I4 => \int_ramadr[31]_i_3_n_0\,
      O => int_len
    );
\int_len[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(31),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_len_reg_n_0_[31]\,
      O => int_len0(31)
    );
\int_len[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(3),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[3]\,
      O => int_len0(3)
    );
\int_len[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(4),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[4]\,
      O => int_len0(4)
    );
\int_len[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(5),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[5]\,
      O => int_len0(5)
    );
\int_len[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(6),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[6]\,
      O => int_len0(6)
    );
\int_len[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(7),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_len_reg_n_0_[7]\,
      O => int_len0(7)
    );
\int_len[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(8),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[8]\,
      O => int_len0(8)
    );
\int_len[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(9),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_len_reg_n_0_[9]\,
      O => int_len0(9)
    );
\int_len_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(0),
      Q => \int_len_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\int_len_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(10),
      Q => \int_len_reg_n_0_[10]\,
      R => \^sr\(0)
    );
\int_len_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(11),
      Q => \int_len_reg_n_0_[11]\,
      R => \^sr\(0)
    );
\int_len_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(12),
      Q => \int_len_reg_n_0_[12]\,
      R => \^sr\(0)
    );
\int_len_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(13),
      Q => \int_len_reg_n_0_[13]\,
      R => \^sr\(0)
    );
\int_len_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(14),
      Q => \int_len_reg_n_0_[14]\,
      R => \^sr\(0)
    );
\int_len_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(15),
      Q => \int_len_reg_n_0_[15]\,
      R => \^sr\(0)
    );
\int_len_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(16),
      Q => \int_len_reg_n_0_[16]\,
      R => \^sr\(0)
    );
\int_len_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(17),
      Q => \int_len_reg_n_0_[17]\,
      R => \^sr\(0)
    );
\int_len_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(18),
      Q => \int_len_reg_n_0_[18]\,
      R => \^sr\(0)
    );
\int_len_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(19),
      Q => \int_len_reg_n_0_[19]\,
      R => \^sr\(0)
    );
\int_len_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(1),
      Q => \int_len_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\int_len_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(20),
      Q => \int_len_reg_n_0_[20]\,
      R => \^sr\(0)
    );
\int_len_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(21),
      Q => \int_len_reg_n_0_[21]\,
      R => \^sr\(0)
    );
\int_len_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(22),
      Q => \int_len_reg_n_0_[22]\,
      R => \^sr\(0)
    );
\int_len_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(23),
      Q => \int_len_reg_n_0_[23]\,
      R => \^sr\(0)
    );
\int_len_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(24),
      Q => \int_len_reg_n_0_[24]\,
      R => \^sr\(0)
    );
\int_len_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(25),
      Q => \int_len_reg_n_0_[25]\,
      R => \^sr\(0)
    );
\int_len_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(26),
      Q => \int_len_reg_n_0_[26]\,
      R => \^sr\(0)
    );
\int_len_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(27),
      Q => \int_len_reg_n_0_[27]\,
      R => \^sr\(0)
    );
\int_len_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(28),
      Q => \int_len_reg_n_0_[28]\,
      R => \^sr\(0)
    );
\int_len_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(29),
      Q => \int_len_reg_n_0_[29]\,
      R => \^sr\(0)
    );
\int_len_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(2),
      Q => \int_len_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\int_len_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(30),
      Q => \int_len_reg_n_0_[30]\,
      R => \^sr\(0)
    );
\int_len_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(31),
      Q => \int_len_reg_n_0_[31]\,
      R => \^sr\(0)
    );
\int_len_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(3),
      Q => \int_len_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\int_len_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(4),
      Q => \int_len_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\int_len_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(5),
      Q => \int_len_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\int_len_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(6),
      Q => \int_len_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\int_len_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(7),
      Q => \int_len_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\int_len_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(8),
      Q => \int_len_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\int_len_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_len,
      D => int_len0(9),
      Q => \int_len_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\int_ramadr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[0]\,
      O => int_ramadr_reg02_out(0)
    );
\int_ramadr[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(10),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[10]\,
      O => int_ramadr_reg02_out(10)
    );
\int_ramadr[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(11),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[11]\,
      O => int_ramadr_reg02_out(11)
    );
\int_ramadr[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(12),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[12]\,
      O => int_ramadr_reg02_out(12)
    );
\int_ramadr[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(13),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[13]\,
      O => int_ramadr_reg02_out(13)
    );
\int_ramadr[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(14),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[14]\,
      O => int_ramadr_reg02_out(14)
    );
\int_ramadr[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(15),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[15]\,
      O => int_ramadr_reg02_out(15)
    );
\int_ramadr[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(16),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[16]\,
      O => int_ramadr_reg02_out(16)
    );
\int_ramadr[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(17),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[17]\,
      O => int_ramadr_reg02_out(17)
    );
\int_ramadr[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(18),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[18]\,
      O => int_ramadr_reg02_out(18)
    );
\int_ramadr[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(19),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[19]\,
      O => int_ramadr_reg02_out(19)
    );
\int_ramadr[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[1]\,
      O => int_ramadr_reg02_out(1)
    );
\int_ramadr[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(20),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[20]\,
      O => int_ramadr_reg02_out(20)
    );
\int_ramadr[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(21),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[21]\,
      O => int_ramadr_reg02_out(21)
    );
\int_ramadr[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(22),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[22]\,
      O => int_ramadr_reg02_out(22)
    );
\int_ramadr[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(23),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[23]\,
      O => int_ramadr_reg02_out(23)
    );
\int_ramadr[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(24),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[24]\,
      O => int_ramadr_reg02_out(24)
    );
\int_ramadr[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(25),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[25]\,
      O => int_ramadr_reg02_out(25)
    );
\int_ramadr[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(26),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[26]\,
      O => int_ramadr_reg02_out(26)
    );
\int_ramadr[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(27),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[27]\,
      O => int_ramadr_reg02_out(27)
    );
\int_ramadr[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(28),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[28]\,
      O => int_ramadr_reg02_out(28)
    );
\int_ramadr[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(29),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[29]\,
      O => int_ramadr_reg02_out(29)
    );
\int_ramadr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(2),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[2]\,
      O => int_ramadr_reg02_out(2)
    );
\int_ramadr[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(30),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[30]\,
      O => int_ramadr_reg02_out(30)
    );
\int_ramadr[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => \^fsm_onehot_wstate_reg[2]_0\,
      I1 => s_axi_control_WVALID,
      I2 => \waddr_reg_n_0_[2]\,
      I3 => \waddr_reg_n_0_[3]\,
      I4 => \int_ramadr[31]_i_3_n_0\,
      O => int_ramadr3_out
    );
\int_ramadr[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(31),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[31]\,
      O => int_ramadr_reg02_out(31)
    );
\int_ramadr[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \waddr_reg_n_0_[1]\,
      I1 => \waddr_reg_n_0_[0]\,
      I2 => \waddr_reg_n_0_[5]\,
      I3 => \waddr_reg_n_0_[4]\,
      O => \int_ramadr[31]_i_3_n_0\
    );
\int_ramadr[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[32]\,
      O => int_ramadr_reg0(0)
    );
\int_ramadr[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[33]\,
      O => int_ramadr_reg0(1)
    );
\int_ramadr[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(2),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[34]\,
      O => int_ramadr_reg0(2)
    );
\int_ramadr[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(3),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[35]\,
      O => int_ramadr_reg0(3)
    );
\int_ramadr[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(4),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[36]\,
      O => int_ramadr_reg0(4)
    );
\int_ramadr[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(5),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[37]\,
      O => int_ramadr_reg0(5)
    );
\int_ramadr[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(6),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[38]\,
      O => int_ramadr_reg0(6)
    );
\int_ramadr[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(7),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[39]\,
      O => int_ramadr_reg0(7)
    );
\int_ramadr[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(3),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[3]\,
      O => int_ramadr_reg02_out(3)
    );
\int_ramadr[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(8),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[40]\,
      O => int_ramadr_reg0(8)
    );
\int_ramadr[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(9),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[41]\,
      O => int_ramadr_reg0(9)
    );
\int_ramadr[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(10),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[42]\,
      O => int_ramadr_reg0(10)
    );
\int_ramadr[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(11),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[43]\,
      O => int_ramadr_reg0(11)
    );
\int_ramadr[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(12),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[44]\,
      O => int_ramadr_reg0(12)
    );
\int_ramadr[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(13),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[45]\,
      O => int_ramadr_reg0(13)
    );
\int_ramadr[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(14),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[46]\,
      O => int_ramadr_reg0(14)
    );
\int_ramadr[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(15),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[47]\,
      O => int_ramadr_reg0(15)
    );
\int_ramadr[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(16),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[48]\,
      O => int_ramadr_reg0(16)
    );
\int_ramadr[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(17),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[49]\,
      O => int_ramadr_reg0(17)
    );
\int_ramadr[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(4),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[4]\,
      O => int_ramadr_reg02_out(4)
    );
\int_ramadr[50]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(18),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[50]\,
      O => int_ramadr_reg0(18)
    );
\int_ramadr[51]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(19),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[51]\,
      O => int_ramadr_reg0(19)
    );
\int_ramadr[52]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(20),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[52]\,
      O => int_ramadr_reg0(20)
    );
\int_ramadr[53]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(21),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[53]\,
      O => int_ramadr_reg0(21)
    );
\int_ramadr[54]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(22),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[54]\,
      O => int_ramadr_reg0(22)
    );
\int_ramadr[55]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(23),
      I1 => s_axi_control_WSTRB(2),
      I2 => \int_ramadr_reg_n_0_[55]\,
      O => int_ramadr_reg0(23)
    );
\int_ramadr[56]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(24),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[56]\,
      O => int_ramadr_reg0(24)
    );
\int_ramadr[57]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(25),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[57]\,
      O => int_ramadr_reg0(25)
    );
\int_ramadr[58]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(26),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[58]\,
      O => int_ramadr_reg0(26)
    );
\int_ramadr[59]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(27),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[59]\,
      O => int_ramadr_reg0(27)
    );
\int_ramadr[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(5),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[5]\,
      O => int_ramadr_reg02_out(5)
    );
\int_ramadr[60]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(28),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[60]\,
      O => int_ramadr_reg0(28)
    );
\int_ramadr[61]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(29),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[61]\,
      O => int_ramadr_reg0(29)
    );
\int_ramadr[62]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(30),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[62]\,
      O => int_ramadr_reg0(30)
    );
\int_ramadr[63]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00800000"
    )
        port map (
      I0 => \^fsm_onehot_wstate_reg[2]_0\,
      I1 => s_axi_control_WVALID,
      I2 => \waddr_reg_n_0_[2]\,
      I3 => \waddr_reg_n_0_[3]\,
      I4 => \int_ramadr[31]_i_3_n_0\,
      O => int_ramadr
    );
\int_ramadr[63]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(31),
      I1 => s_axi_control_WSTRB(3),
      I2 => \int_ramadr_reg_n_0_[63]\,
      O => int_ramadr_reg0(31)
    );
\int_ramadr[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(6),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[6]\,
      O => int_ramadr_reg02_out(6)
    );
\int_ramadr[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(7),
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ramadr_reg_n_0_[7]\,
      O => int_ramadr_reg02_out(7)
    );
\int_ramadr[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(8),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[8]\,
      O => int_ramadr_reg02_out(8)
    );
\int_ramadr[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(9),
      I1 => s_axi_control_WSTRB(1),
      I2 => \int_ramadr_reg_n_0_[9]\,
      O => int_ramadr_reg02_out(9)
    );
\int_ramadr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(0),
      Q => \int_ramadr_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(10),
      Q => \int_ramadr_reg_n_0_[10]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(11),
      Q => \int_ramadr_reg_n_0_[11]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(12),
      Q => \int_ramadr_reg_n_0_[12]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(13),
      Q => \int_ramadr_reg_n_0_[13]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(14),
      Q => \int_ramadr_reg_n_0_[14]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(15),
      Q => \int_ramadr_reg_n_0_[15]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(16),
      Q => \int_ramadr_reg_n_0_[16]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(17),
      Q => \int_ramadr_reg_n_0_[17]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(18),
      Q => \int_ramadr_reg_n_0_[18]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(19),
      Q => \int_ramadr_reg_n_0_[19]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(1),
      Q => \int_ramadr_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(20),
      Q => \int_ramadr_reg_n_0_[20]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(21),
      Q => \int_ramadr_reg_n_0_[21]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(22),
      Q => \int_ramadr_reg_n_0_[22]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(23),
      Q => \int_ramadr_reg_n_0_[23]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(24),
      Q => \int_ramadr_reg_n_0_[24]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(25),
      Q => \int_ramadr_reg_n_0_[25]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(26),
      Q => \int_ramadr_reg_n_0_[26]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(27),
      Q => \int_ramadr_reg_n_0_[27]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(28),
      Q => \int_ramadr_reg_n_0_[28]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(29),
      Q => \int_ramadr_reg_n_0_[29]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(2),
      Q => \int_ramadr_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(30),
      Q => \int_ramadr_reg_n_0_[30]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(31),
      Q => \int_ramadr_reg_n_0_[31]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(0),
      Q => \int_ramadr_reg_n_0_[32]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(1),
      Q => \int_ramadr_reg_n_0_[33]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(2),
      Q => \int_ramadr_reg_n_0_[34]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(3),
      Q => \int_ramadr_reg_n_0_[35]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(4),
      Q => \int_ramadr_reg_n_0_[36]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(5),
      Q => \int_ramadr_reg_n_0_[37]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(6),
      Q => \int_ramadr_reg_n_0_[38]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(7),
      Q => \int_ramadr_reg_n_0_[39]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(3),
      Q => \int_ramadr_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(8),
      Q => \int_ramadr_reg_n_0_[40]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(9),
      Q => \int_ramadr_reg_n_0_[41]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(10),
      Q => \int_ramadr_reg_n_0_[42]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(11),
      Q => \int_ramadr_reg_n_0_[43]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(12),
      Q => \int_ramadr_reg_n_0_[44]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(13),
      Q => \int_ramadr_reg_n_0_[45]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(14),
      Q => \int_ramadr_reg_n_0_[46]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(15),
      Q => \int_ramadr_reg_n_0_[47]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(16),
      Q => \int_ramadr_reg_n_0_[48]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(17),
      Q => \int_ramadr_reg_n_0_[49]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(4),
      Q => \int_ramadr_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(18),
      Q => \int_ramadr_reg_n_0_[50]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(19),
      Q => \int_ramadr_reg_n_0_[51]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[52]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(20),
      Q => \int_ramadr_reg_n_0_[52]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[53]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(21),
      Q => \int_ramadr_reg_n_0_[53]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[54]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(22),
      Q => \int_ramadr_reg_n_0_[54]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[55]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(23),
      Q => \int_ramadr_reg_n_0_[55]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[56]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(24),
      Q => \int_ramadr_reg_n_0_[56]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[57]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(25),
      Q => \int_ramadr_reg_n_0_[57]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[58]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(26),
      Q => \int_ramadr_reg_n_0_[58]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[59]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(27),
      Q => \int_ramadr_reg_n_0_[59]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(5),
      Q => \int_ramadr_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[60]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(28),
      Q => \int_ramadr_reg_n_0_[60]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[61]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(29),
      Q => \int_ramadr_reg_n_0_[61]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[62]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(30),
      Q => \int_ramadr_reg_n_0_[62]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[63]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(31),
      Q => \int_ramadr_reg_n_0_[63]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(6),
      Q => \int_ramadr_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(7),
      Q => \int_ramadr_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(8),
      Q => \int_ramadr_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\int_ramadr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(9),
      Q => \int_ramadr_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\rdata[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[0]\,
      I1 => \int_ramadr_reg_n_0_[32]\,
      I2 => \int_len_reg_n_0_[0]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[0]_i_1_n_0\
    );
\rdata[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[10]\,
      I1 => \int_ramadr_reg_n_0_[42]\,
      I2 => \int_len_reg_n_0_[10]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[10]_i_1_n_0\
    );
\rdata[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[11]\,
      I1 => \int_ramadr_reg_n_0_[43]\,
      I2 => \int_len_reg_n_0_[11]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[11]_i_1_n_0\
    );
\rdata[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[12]\,
      I1 => \int_ramadr_reg_n_0_[44]\,
      I2 => \int_len_reg_n_0_[12]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[12]_i_1_n_0\
    );
\rdata[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[13]\,
      I1 => \int_ramadr_reg_n_0_[45]\,
      I2 => \int_len_reg_n_0_[13]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[13]_i_1_n_0\
    );
\rdata[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[14]\,
      I1 => \int_ramadr_reg_n_0_[46]\,
      I2 => \int_len_reg_n_0_[14]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[14]_i_1_n_0\
    );
\rdata[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[15]\,
      I1 => \int_ramadr_reg_n_0_[47]\,
      I2 => \int_len_reg_n_0_[15]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[15]_i_1_n_0\
    );
\rdata[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[16]\,
      I1 => \int_ramadr_reg_n_0_[48]\,
      I2 => \int_len_reg_n_0_[16]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[16]_i_1_n_0\
    );
\rdata[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[17]\,
      I1 => \int_ramadr_reg_n_0_[49]\,
      I2 => \int_len_reg_n_0_[17]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[17]_i_1_n_0\
    );
\rdata[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[18]\,
      I1 => \int_ramadr_reg_n_0_[50]\,
      I2 => \int_len_reg_n_0_[18]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[18]_i_1_n_0\
    );
\rdata[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[19]\,
      I1 => \int_ramadr_reg_n_0_[51]\,
      I2 => \int_len_reg_n_0_[19]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[19]_i_1_n_0\
    );
\rdata[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[1]\,
      I1 => \int_ramadr_reg_n_0_[33]\,
      I2 => \int_len_reg_n_0_[1]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[1]_i_1_n_0\
    );
\rdata[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[20]\,
      I1 => \int_ramadr_reg_n_0_[52]\,
      I2 => \int_len_reg_n_0_[20]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[20]_i_1_n_0\
    );
\rdata[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[21]\,
      I1 => \int_ramadr_reg_n_0_[53]\,
      I2 => \int_len_reg_n_0_[21]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[21]_i_1_n_0\
    );
\rdata[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[22]\,
      I1 => \int_ramadr_reg_n_0_[54]\,
      I2 => \int_len_reg_n_0_[22]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[22]_i_1_n_0\
    );
\rdata[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[23]\,
      I1 => \int_ramadr_reg_n_0_[55]\,
      I2 => \int_len_reg_n_0_[23]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[23]_i_1_n_0\
    );
\rdata[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[24]\,
      I1 => \int_ramadr_reg_n_0_[56]\,
      I2 => \int_len_reg_n_0_[24]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[24]_i_1_n_0\
    );
\rdata[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[25]\,
      I1 => \int_ramadr_reg_n_0_[57]\,
      I2 => \int_len_reg_n_0_[25]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[25]_i_1_n_0\
    );
\rdata[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[26]\,
      I1 => \int_ramadr_reg_n_0_[58]\,
      I2 => \int_len_reg_n_0_[26]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[26]_i_1_n_0\
    );
\rdata[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[27]\,
      I1 => \int_ramadr_reg_n_0_[59]\,
      I2 => \int_len_reg_n_0_[27]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[27]_i_1_n_0\
    );
\rdata[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[28]\,
      I1 => \int_ramadr_reg_n_0_[60]\,
      I2 => \int_len_reg_n_0_[28]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[28]_i_1_n_0\
    );
\rdata[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[29]\,
      I1 => \int_ramadr_reg_n_0_[61]\,
      I2 => \int_len_reg_n_0_[29]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[29]_i_1_n_0\
    );
\rdata[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[2]\,
      I1 => \int_ramadr_reg_n_0_[34]\,
      I2 => \int_len_reg_n_0_[2]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[2]_i_1_n_0\
    );
\rdata[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[30]\,
      I1 => \int_ramadr_reg_n_0_[62]\,
      I2 => \int_len_reg_n_0_[30]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[30]_i_1_n_0\
    );
\rdata[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888888888088"
    )
        port map (
      I0 => \^fsm_onehot_rstate_reg[1]_0\,
      I1 => s_axi_control_ARVALID,
      I2 => s_axi_control_ARADDR(1),
      I3 => s_axi_control_ARADDR(4),
      I4 => s_axi_control_ARADDR(5),
      I5 => s_axi_control_ARADDR(0),
      O => \rdata[31]_i_1_n_0\
    );
\rdata[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => \^fsm_onehot_rstate_reg[1]_0\,
      O => rdata
    );
\rdata[31]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[31]\,
      I1 => \int_ramadr_reg_n_0_[63]\,
      I2 => \int_len_reg_n_0_[31]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[31]_i_3_n_0\
    );
\rdata[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[3]\,
      I1 => \int_ramadr_reg_n_0_[35]\,
      I2 => \int_len_reg_n_0_[3]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[3]_i_1_n_0\
    );
\rdata[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[4]\,
      I1 => \int_ramadr_reg_n_0_[36]\,
      I2 => \int_len_reg_n_0_[4]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[4]_i_1_n_0\
    );
\rdata[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[5]\,
      I1 => \int_ramadr_reg_n_0_[37]\,
      I2 => \int_len_reg_n_0_[5]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[5]_i_1_n_0\
    );
\rdata[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[6]\,
      I1 => \int_ramadr_reg_n_0_[38]\,
      I2 => \int_len_reg_n_0_[6]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[6]_i_1_n_0\
    );
\rdata[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[7]\,
      I1 => \int_ramadr_reg_n_0_[39]\,
      I2 => \int_len_reg_n_0_[7]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[7]_i_1_n_0\
    );
\rdata[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[8]\,
      I1 => \int_ramadr_reg_n_0_[40]\,
      I2 => \int_len_reg_n_0_[8]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[8]_i_1_n_0\
    );
\rdata[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => \int_ramadr_reg_n_0_[9]\,
      I1 => \int_ramadr_reg_n_0_[41]\,
      I2 => \int_len_reg_n_0_[9]\,
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[9]_i_1_n_0\
    );
\rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[0]_i_1_n_0\,
      Q => s_axi_control_RDATA(0),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[10]_i_1_n_0\,
      Q => s_axi_control_RDATA(10),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[11]_i_1_n_0\,
      Q => s_axi_control_RDATA(11),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[12]_i_1_n_0\,
      Q => s_axi_control_RDATA(12),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[13]_i_1_n_0\,
      Q => s_axi_control_RDATA(13),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[14]_i_1_n_0\,
      Q => s_axi_control_RDATA(14),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[15]_i_1_n_0\,
      Q => s_axi_control_RDATA(15),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[16]_i_1_n_0\,
      Q => s_axi_control_RDATA(16),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[17]_i_1_n_0\,
      Q => s_axi_control_RDATA(17),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[18]_i_1_n_0\,
      Q => s_axi_control_RDATA(18),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[19]_i_1_n_0\,
      Q => s_axi_control_RDATA(19),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[1]_i_1_n_0\,
      Q => s_axi_control_RDATA(1),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[20]_i_1_n_0\,
      Q => s_axi_control_RDATA(20),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[21]_i_1_n_0\,
      Q => s_axi_control_RDATA(21),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[22]_i_1_n_0\,
      Q => s_axi_control_RDATA(22),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[23]_i_1_n_0\,
      Q => s_axi_control_RDATA(23),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[24]_i_1_n_0\,
      Q => s_axi_control_RDATA(24),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[25]_i_1_n_0\,
      Q => s_axi_control_RDATA(25),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[26]_i_1_n_0\,
      Q => s_axi_control_RDATA(26),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[27]_i_1_n_0\,
      Q => s_axi_control_RDATA(27),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[28]_i_1_n_0\,
      Q => s_axi_control_RDATA(28),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[29]_i_1_n_0\,
      Q => s_axi_control_RDATA(29),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[2]_i_1_n_0\,
      Q => s_axi_control_RDATA(2),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[30]_i_1_n_0\,
      Q => s_axi_control_RDATA(30),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[31]_i_3_n_0\,
      Q => s_axi_control_RDATA(31),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[3]_i_1_n_0\,
      Q => s_axi_control_RDATA(3),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[4]_i_1_n_0\,
      Q => s_axi_control_RDATA(4),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[5]_i_1_n_0\,
      Q => s_axi_control_RDATA(5),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[6]_i_1_n_0\,
      Q => s_axi_control_RDATA(6),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[7]_i_1_n_0\,
      Q => s_axi_control_RDATA(7),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[8]_i_1_n_0\,
      Q => s_axi_control_RDATA(8),
      R => \rdata[31]_i_1_n_0\
    );
\rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => rdata,
      D => \rdata[9]_i_1_n_0\,
      Q => s_axi_control_RDATA(9),
      R => \rdata[31]_i_1_n_0\
    );
\waddr[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^fsm_onehot_wstate_reg[1]_0\,
      I1 => s_axi_control_AWVALID,
      O => waddr
    );
\waddr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => waddr,
      D => s_axi_control_AWADDR(0),
      Q => \waddr_reg_n_0_[0]\,
      R => '0'
    );
\waddr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => waddr,
      D => s_axi_control_AWADDR(1),
      Q => \waddr_reg_n_0_[1]\,
      R => '0'
    );
\waddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => waddr,
      D => s_axi_control_AWADDR(2),
      Q => \waddr_reg_n_0_[2]\,
      R => '0'
    );
\waddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => waddr,
      D => s_axi_control_AWADDR(3),
      Q => \waddr_reg_n_0_[3]\,
      R => '0'
    );
\waddr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => waddr,
      D => s_axi_control_AWADDR(4),
      Q => \waddr_reg_n_0_[4]\,
      R => '0'
    );
\waddr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => waddr,
      D => s_axi_control_AWADDR(5),
      Q => \waddr_reg_n_0_[5]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    m_axi_sound_AWVALID : out STD_LOGIC;
    m_axi_sound_AWREADY : in STD_LOGIC;
    m_axi_sound_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_sound_AWID : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sound_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_AWUSER : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_WVALID : out STD_LOGIC;
    m_axi_sound_WREADY : in STD_LOGIC;
    m_axi_sound_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sound_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_WLAST : out STD_LOGIC;
    m_axi_sound_WID : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_WUSER : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_ARVALID : out STD_LOGIC;
    m_axi_sound_ARREADY : in STD_LOGIC;
    m_axi_sound_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_sound_ARID : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_sound_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_sound_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_sound_ARUSER : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_RVALID : in STD_LOGIC;
    m_axi_sound_RREADY : out STD_LOGIC;
    m_axi_sound_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_sound_RLAST : in STD_LOGIC;
    m_axi_sound_RID : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_RUSER : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_BVALID : in STD_LOGIC;
    m_axi_sound_BREADY : out STD_LOGIC;
    m_axi_sound_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_sound_BID : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_sound_BUSER : in STD_LOGIC_VECTOR ( 0 to 0 );
    outdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    status : in STD_LOGIC_VECTOR ( 31 downto 0 );
    response : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_AWREADY : out STD_LOGIC;
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_WREADY : out STD_LOGIC;
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARREADY : out STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_control_RVALID : out STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_BVALID : out STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute C_M_AXI_SOUND_ADDR_WIDTH : integer;
  attribute C_M_AXI_SOUND_ADDR_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 64;
  attribute C_M_AXI_SOUND_ARUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_ARUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_SOUND_AWUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_AWUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_SOUND_BUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_BUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_SOUND_CACHE_VALUE : string;
  attribute C_M_AXI_SOUND_CACHE_VALUE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "4'b0011";
  attribute C_M_AXI_SOUND_DATA_WIDTH : integer;
  attribute C_M_AXI_SOUND_DATA_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 32;
  attribute C_M_AXI_SOUND_ID_WIDTH : integer;
  attribute C_M_AXI_SOUND_ID_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_SOUND_PROT_VALUE : string;
  attribute C_M_AXI_SOUND_PROT_VALUE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "3'b000";
  attribute C_M_AXI_SOUND_RUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_RUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_SOUND_USER_VALUE : integer;
  attribute C_M_AXI_SOUND_USER_VALUE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 0;
  attribute C_M_AXI_SOUND_WSTRB_WIDTH : integer;
  attribute C_M_AXI_SOUND_WSTRB_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 4;
  attribute C_M_AXI_SOUND_WUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_WUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_S_AXI_CONTROL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CONTROL_ADDR_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 6;
  attribute C_S_AXI_CONTROL_DATA_WIDTH : integer;
  attribute C_S_AXI_CONTROL_DATA_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 32;
  attribute C_S_AXI_CONTROL_WSTRB_WIDTH : integer;
  attribute C_S_AXI_CONTROL_WSTRB_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 4;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 32;
  attribute C_S_AXI_WSTRB_WIDTH : integer;
  attribute C_S_AXI_WSTRB_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 4;
  attribute ap_ST_fsm_state1 : string;
  attribute ap_ST_fsm_state1 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "2'b01";
  attribute ap_ST_fsm_state2 : string;
  attribute ap_ST_fsm_state2 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "2'b10";
  attribute hls_module : string;
  attribute hls_module of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "yes";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation is
  signal \<const0>\ : STD_LOGIC;
  signal \ap_CS_fsm[1]_i_1_n_0\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[0]\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[1]\ : STD_LOGIC;
  signal ap_NS_fsm : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ap_rst_n_inv : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ap_CS_fsm[0]_i_1\ : label is "soft_lutpair49";
  attribute FSM_ENCODING : string;
  attribute FSM_ENCODING of \ap_CS_fsm_reg[0]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[1]\ : label is "none";
  attribute SOFT_HLUTNM of ap_idle_INST_0 : label is "soft_lutpair49";
begin
  ap_done <= \<const0>\;
  ap_ready <= \<const0>\;
  m_axi_sound_ARADDR(63) <= \<const0>\;
  m_axi_sound_ARADDR(62) <= \<const0>\;
  m_axi_sound_ARADDR(61) <= \<const0>\;
  m_axi_sound_ARADDR(60) <= \<const0>\;
  m_axi_sound_ARADDR(59) <= \<const0>\;
  m_axi_sound_ARADDR(58) <= \<const0>\;
  m_axi_sound_ARADDR(57) <= \<const0>\;
  m_axi_sound_ARADDR(56) <= \<const0>\;
  m_axi_sound_ARADDR(55) <= \<const0>\;
  m_axi_sound_ARADDR(54) <= \<const0>\;
  m_axi_sound_ARADDR(53) <= \<const0>\;
  m_axi_sound_ARADDR(52) <= \<const0>\;
  m_axi_sound_ARADDR(51) <= \<const0>\;
  m_axi_sound_ARADDR(50) <= \<const0>\;
  m_axi_sound_ARADDR(49) <= \<const0>\;
  m_axi_sound_ARADDR(48) <= \<const0>\;
  m_axi_sound_ARADDR(47) <= \<const0>\;
  m_axi_sound_ARADDR(46) <= \<const0>\;
  m_axi_sound_ARADDR(45) <= \<const0>\;
  m_axi_sound_ARADDR(44) <= \<const0>\;
  m_axi_sound_ARADDR(43) <= \<const0>\;
  m_axi_sound_ARADDR(42) <= \<const0>\;
  m_axi_sound_ARADDR(41) <= \<const0>\;
  m_axi_sound_ARADDR(40) <= \<const0>\;
  m_axi_sound_ARADDR(39) <= \<const0>\;
  m_axi_sound_ARADDR(38) <= \<const0>\;
  m_axi_sound_ARADDR(37) <= \<const0>\;
  m_axi_sound_ARADDR(36) <= \<const0>\;
  m_axi_sound_ARADDR(35) <= \<const0>\;
  m_axi_sound_ARADDR(34) <= \<const0>\;
  m_axi_sound_ARADDR(33) <= \<const0>\;
  m_axi_sound_ARADDR(32) <= \<const0>\;
  m_axi_sound_ARADDR(31) <= \<const0>\;
  m_axi_sound_ARADDR(30) <= \<const0>\;
  m_axi_sound_ARADDR(29) <= \<const0>\;
  m_axi_sound_ARADDR(28) <= \<const0>\;
  m_axi_sound_ARADDR(27) <= \<const0>\;
  m_axi_sound_ARADDR(26) <= \<const0>\;
  m_axi_sound_ARADDR(25) <= \<const0>\;
  m_axi_sound_ARADDR(24) <= \<const0>\;
  m_axi_sound_ARADDR(23) <= \<const0>\;
  m_axi_sound_ARADDR(22) <= \<const0>\;
  m_axi_sound_ARADDR(21) <= \<const0>\;
  m_axi_sound_ARADDR(20) <= \<const0>\;
  m_axi_sound_ARADDR(19) <= \<const0>\;
  m_axi_sound_ARADDR(18) <= \<const0>\;
  m_axi_sound_ARADDR(17) <= \<const0>\;
  m_axi_sound_ARADDR(16) <= \<const0>\;
  m_axi_sound_ARADDR(15) <= \<const0>\;
  m_axi_sound_ARADDR(14) <= \<const0>\;
  m_axi_sound_ARADDR(13) <= \<const0>\;
  m_axi_sound_ARADDR(12) <= \<const0>\;
  m_axi_sound_ARADDR(11) <= \<const0>\;
  m_axi_sound_ARADDR(10) <= \<const0>\;
  m_axi_sound_ARADDR(9) <= \<const0>\;
  m_axi_sound_ARADDR(8) <= \<const0>\;
  m_axi_sound_ARADDR(7) <= \<const0>\;
  m_axi_sound_ARADDR(6) <= \<const0>\;
  m_axi_sound_ARADDR(5) <= \<const0>\;
  m_axi_sound_ARADDR(4) <= \<const0>\;
  m_axi_sound_ARADDR(3) <= \<const0>\;
  m_axi_sound_ARADDR(2) <= \<const0>\;
  m_axi_sound_ARADDR(1) <= \<const0>\;
  m_axi_sound_ARADDR(0) <= \<const0>\;
  m_axi_sound_ARBURST(1) <= \<const0>\;
  m_axi_sound_ARBURST(0) <= \<const0>\;
  m_axi_sound_ARCACHE(3) <= \<const0>\;
  m_axi_sound_ARCACHE(2) <= \<const0>\;
  m_axi_sound_ARCACHE(1) <= \<const0>\;
  m_axi_sound_ARCACHE(0) <= \<const0>\;
  m_axi_sound_ARID(0) <= \<const0>\;
  m_axi_sound_ARLEN(7) <= \<const0>\;
  m_axi_sound_ARLEN(6) <= \<const0>\;
  m_axi_sound_ARLEN(5) <= \<const0>\;
  m_axi_sound_ARLEN(4) <= \<const0>\;
  m_axi_sound_ARLEN(3) <= \<const0>\;
  m_axi_sound_ARLEN(2) <= \<const0>\;
  m_axi_sound_ARLEN(1) <= \<const0>\;
  m_axi_sound_ARLEN(0) <= \<const0>\;
  m_axi_sound_ARLOCK(1) <= \<const0>\;
  m_axi_sound_ARLOCK(0) <= \<const0>\;
  m_axi_sound_ARPROT(2) <= \<const0>\;
  m_axi_sound_ARPROT(1) <= \<const0>\;
  m_axi_sound_ARPROT(0) <= \<const0>\;
  m_axi_sound_ARQOS(3) <= \<const0>\;
  m_axi_sound_ARQOS(2) <= \<const0>\;
  m_axi_sound_ARQOS(1) <= \<const0>\;
  m_axi_sound_ARQOS(0) <= \<const0>\;
  m_axi_sound_ARREGION(3) <= \<const0>\;
  m_axi_sound_ARREGION(2) <= \<const0>\;
  m_axi_sound_ARREGION(1) <= \<const0>\;
  m_axi_sound_ARREGION(0) <= \<const0>\;
  m_axi_sound_ARSIZE(2) <= \<const0>\;
  m_axi_sound_ARSIZE(1) <= \<const0>\;
  m_axi_sound_ARSIZE(0) <= \<const0>\;
  m_axi_sound_ARUSER(0) <= \<const0>\;
  m_axi_sound_ARVALID <= \<const0>\;
  m_axi_sound_AWADDR(63) <= \<const0>\;
  m_axi_sound_AWADDR(62) <= \<const0>\;
  m_axi_sound_AWADDR(61) <= \<const0>\;
  m_axi_sound_AWADDR(60) <= \<const0>\;
  m_axi_sound_AWADDR(59) <= \<const0>\;
  m_axi_sound_AWADDR(58) <= \<const0>\;
  m_axi_sound_AWADDR(57) <= \<const0>\;
  m_axi_sound_AWADDR(56) <= \<const0>\;
  m_axi_sound_AWADDR(55) <= \<const0>\;
  m_axi_sound_AWADDR(54) <= \<const0>\;
  m_axi_sound_AWADDR(53) <= \<const0>\;
  m_axi_sound_AWADDR(52) <= \<const0>\;
  m_axi_sound_AWADDR(51) <= \<const0>\;
  m_axi_sound_AWADDR(50) <= \<const0>\;
  m_axi_sound_AWADDR(49) <= \<const0>\;
  m_axi_sound_AWADDR(48) <= \<const0>\;
  m_axi_sound_AWADDR(47) <= \<const0>\;
  m_axi_sound_AWADDR(46) <= \<const0>\;
  m_axi_sound_AWADDR(45) <= \<const0>\;
  m_axi_sound_AWADDR(44) <= \<const0>\;
  m_axi_sound_AWADDR(43) <= \<const0>\;
  m_axi_sound_AWADDR(42) <= \<const0>\;
  m_axi_sound_AWADDR(41) <= \<const0>\;
  m_axi_sound_AWADDR(40) <= \<const0>\;
  m_axi_sound_AWADDR(39) <= \<const0>\;
  m_axi_sound_AWADDR(38) <= \<const0>\;
  m_axi_sound_AWADDR(37) <= \<const0>\;
  m_axi_sound_AWADDR(36) <= \<const0>\;
  m_axi_sound_AWADDR(35) <= \<const0>\;
  m_axi_sound_AWADDR(34) <= \<const0>\;
  m_axi_sound_AWADDR(33) <= \<const0>\;
  m_axi_sound_AWADDR(32) <= \<const0>\;
  m_axi_sound_AWADDR(31) <= \<const0>\;
  m_axi_sound_AWADDR(30) <= \<const0>\;
  m_axi_sound_AWADDR(29) <= \<const0>\;
  m_axi_sound_AWADDR(28) <= \<const0>\;
  m_axi_sound_AWADDR(27) <= \<const0>\;
  m_axi_sound_AWADDR(26) <= \<const0>\;
  m_axi_sound_AWADDR(25) <= \<const0>\;
  m_axi_sound_AWADDR(24) <= \<const0>\;
  m_axi_sound_AWADDR(23) <= \<const0>\;
  m_axi_sound_AWADDR(22) <= \<const0>\;
  m_axi_sound_AWADDR(21) <= \<const0>\;
  m_axi_sound_AWADDR(20) <= \<const0>\;
  m_axi_sound_AWADDR(19) <= \<const0>\;
  m_axi_sound_AWADDR(18) <= \<const0>\;
  m_axi_sound_AWADDR(17) <= \<const0>\;
  m_axi_sound_AWADDR(16) <= \<const0>\;
  m_axi_sound_AWADDR(15) <= \<const0>\;
  m_axi_sound_AWADDR(14) <= \<const0>\;
  m_axi_sound_AWADDR(13) <= \<const0>\;
  m_axi_sound_AWADDR(12) <= \<const0>\;
  m_axi_sound_AWADDR(11) <= \<const0>\;
  m_axi_sound_AWADDR(10) <= \<const0>\;
  m_axi_sound_AWADDR(9) <= \<const0>\;
  m_axi_sound_AWADDR(8) <= \<const0>\;
  m_axi_sound_AWADDR(7) <= \<const0>\;
  m_axi_sound_AWADDR(6) <= \<const0>\;
  m_axi_sound_AWADDR(5) <= \<const0>\;
  m_axi_sound_AWADDR(4) <= \<const0>\;
  m_axi_sound_AWADDR(3) <= \<const0>\;
  m_axi_sound_AWADDR(2) <= \<const0>\;
  m_axi_sound_AWADDR(1) <= \<const0>\;
  m_axi_sound_AWADDR(0) <= \<const0>\;
  m_axi_sound_AWBURST(1) <= \<const0>\;
  m_axi_sound_AWBURST(0) <= \<const0>\;
  m_axi_sound_AWCACHE(3) <= \<const0>\;
  m_axi_sound_AWCACHE(2) <= \<const0>\;
  m_axi_sound_AWCACHE(1) <= \<const0>\;
  m_axi_sound_AWCACHE(0) <= \<const0>\;
  m_axi_sound_AWID(0) <= \<const0>\;
  m_axi_sound_AWLEN(7) <= \<const0>\;
  m_axi_sound_AWLEN(6) <= \<const0>\;
  m_axi_sound_AWLEN(5) <= \<const0>\;
  m_axi_sound_AWLEN(4) <= \<const0>\;
  m_axi_sound_AWLEN(3) <= \<const0>\;
  m_axi_sound_AWLEN(2) <= \<const0>\;
  m_axi_sound_AWLEN(1) <= \<const0>\;
  m_axi_sound_AWLEN(0) <= \<const0>\;
  m_axi_sound_AWLOCK(1) <= \<const0>\;
  m_axi_sound_AWLOCK(0) <= \<const0>\;
  m_axi_sound_AWPROT(2) <= \<const0>\;
  m_axi_sound_AWPROT(1) <= \<const0>\;
  m_axi_sound_AWPROT(0) <= \<const0>\;
  m_axi_sound_AWQOS(3) <= \<const0>\;
  m_axi_sound_AWQOS(2) <= \<const0>\;
  m_axi_sound_AWQOS(1) <= \<const0>\;
  m_axi_sound_AWQOS(0) <= \<const0>\;
  m_axi_sound_AWREGION(3) <= \<const0>\;
  m_axi_sound_AWREGION(2) <= \<const0>\;
  m_axi_sound_AWREGION(1) <= \<const0>\;
  m_axi_sound_AWREGION(0) <= \<const0>\;
  m_axi_sound_AWSIZE(2) <= \<const0>\;
  m_axi_sound_AWSIZE(1) <= \<const0>\;
  m_axi_sound_AWSIZE(0) <= \<const0>\;
  m_axi_sound_AWUSER(0) <= \<const0>\;
  m_axi_sound_AWVALID <= \<const0>\;
  m_axi_sound_BREADY <= \<const0>\;
  m_axi_sound_RREADY <= \<const0>\;
  m_axi_sound_WDATA(31) <= \<const0>\;
  m_axi_sound_WDATA(30) <= \<const0>\;
  m_axi_sound_WDATA(29) <= \<const0>\;
  m_axi_sound_WDATA(28) <= \<const0>\;
  m_axi_sound_WDATA(27) <= \<const0>\;
  m_axi_sound_WDATA(26) <= \<const0>\;
  m_axi_sound_WDATA(25) <= \<const0>\;
  m_axi_sound_WDATA(24) <= \<const0>\;
  m_axi_sound_WDATA(23) <= \<const0>\;
  m_axi_sound_WDATA(22) <= \<const0>\;
  m_axi_sound_WDATA(21) <= \<const0>\;
  m_axi_sound_WDATA(20) <= \<const0>\;
  m_axi_sound_WDATA(19) <= \<const0>\;
  m_axi_sound_WDATA(18) <= \<const0>\;
  m_axi_sound_WDATA(17) <= \<const0>\;
  m_axi_sound_WDATA(16) <= \<const0>\;
  m_axi_sound_WDATA(15) <= \<const0>\;
  m_axi_sound_WDATA(14) <= \<const0>\;
  m_axi_sound_WDATA(13) <= \<const0>\;
  m_axi_sound_WDATA(12) <= \<const0>\;
  m_axi_sound_WDATA(11) <= \<const0>\;
  m_axi_sound_WDATA(10) <= \<const0>\;
  m_axi_sound_WDATA(9) <= \<const0>\;
  m_axi_sound_WDATA(8) <= \<const0>\;
  m_axi_sound_WDATA(7) <= \<const0>\;
  m_axi_sound_WDATA(6) <= \<const0>\;
  m_axi_sound_WDATA(5) <= \<const0>\;
  m_axi_sound_WDATA(4) <= \<const0>\;
  m_axi_sound_WDATA(3) <= \<const0>\;
  m_axi_sound_WDATA(2) <= \<const0>\;
  m_axi_sound_WDATA(1) <= \<const0>\;
  m_axi_sound_WDATA(0) <= \<const0>\;
  m_axi_sound_WID(0) <= \<const0>\;
  m_axi_sound_WLAST <= \<const0>\;
  m_axi_sound_WSTRB(3) <= \<const0>\;
  m_axi_sound_WSTRB(2) <= \<const0>\;
  m_axi_sound_WSTRB(1) <= \<const0>\;
  m_axi_sound_WSTRB(0) <= \<const0>\;
  m_axi_sound_WUSER(0) <= \<const0>\;
  m_axi_sound_WVALID <= \<const0>\;
  s_axi_control_BRESP(1) <= \<const0>\;
  s_axi_control_BRESP(0) <= \<const0>\;
  s_axi_control_RRESP(1) <= \<const0>\;
  s_axi_control_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\ap_CS_fsm[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"07"
    )
        port map (
      I0 => \ap_CS_fsm_reg_n_0_[0]\,
      I1 => ap_start,
      I2 => \ap_CS_fsm_reg_n_0_[1]\,
      O => ap_NS_fsm(0)
    );
\ap_CS_fsm[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => ap_start,
      I1 => \ap_CS_fsm_reg_n_0_[0]\,
      O => \ap_CS_fsm[1]_i_1_n_0\
    );
\ap_CS_fsm_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_NS_fsm(0),
      Q => \ap_CS_fsm_reg_n_0_[0]\,
      S => ap_rst_n_inv
    );
\ap_CS_fsm_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \ap_CS_fsm[1]_i_1_n_0\,
      Q => \ap_CS_fsm_reg_n_0_[1]\,
      R => ap_rst_n_inv
    );
ap_idle_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \ap_CS_fsm_reg_n_0_[0]\,
      I1 => ap_start,
      O => ap_idle
    );
control_s_axi_U: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi
     port map (
      \FSM_onehot_rstate_reg[1]_0\ => s_axi_control_ARREADY,
      \FSM_onehot_wstate_reg[1]_0\ => s_axi_control_AWREADY,
      \FSM_onehot_wstate_reg[2]_0\ => s_axi_control_WREADY,
      SR(0) => ap_rst_n_inv,
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      s_axi_control_ARADDR(5 downto 0) => s_axi_control_ARADDR(5 downto 0),
      s_axi_control_ARVALID => s_axi_control_ARVALID,
      s_axi_control_AWADDR(5 downto 0) => s_axi_control_AWADDR(5 downto 0),
      s_axi_control_AWVALID => s_axi_control_AWVALID,
      s_axi_control_BREADY => s_axi_control_BREADY,
      s_axi_control_BVALID => s_axi_control_BVALID,
      s_axi_control_RDATA(31 downto 0) => s_axi_control_RDATA(31 downto 0),
      s_axi_control_RREADY => s_axi_control_RREADY,
      s_axi_control_RVALID => s_axi_control_RVALID,
      s_axi_control_WDATA(31 downto 0) => s_axi_control_WDATA(31 downto 0),
      s_axi_control_WSTRB(3 downto 0) => s_axi_control_WSTRB(3 downto 0),
      s_axi_control_WVALID => s_axi_control_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_1_sound_operation_0_6,sound_operation,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "HLS";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "sound_operation,Vivado 2020.2";
  attribute hls_module : string;
  attribute hls_module of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  signal NLW_inst_ap_done_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_ap_ready_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_sound_ARVALID_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_sound_AWVALID_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_sound_BREADY_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_sound_RREADY_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_sound_WLAST_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_sound_WVALID_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_sound_ARADDR_UNCONNECTED : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal NLW_inst_m_axi_sound_ARBURST_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_sound_ARCACHE_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_sound_ARID_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_sound_ARLEN_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_m_axi_sound_ARLOCK_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_sound_ARPROT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_sound_ARQOS_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_sound_ARREGION_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_sound_ARSIZE_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_sound_ARUSER_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_sound_AWADDR_UNCONNECTED : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal NLW_inst_m_axi_sound_AWBURST_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_sound_AWCACHE_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_sound_AWID_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_sound_AWLEN_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_m_axi_sound_AWLOCK_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_sound_AWPROT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_sound_AWQOS_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_sound_AWREGION_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_sound_AWSIZE_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_sound_AWUSER_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_sound_WDATA_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_m_axi_sound_WID_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_sound_WSTRB_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_sound_WUSER_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_control_BRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_s_axi_control_RRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_M_AXI_SOUND_ADDR_WIDTH : integer;
  attribute C_M_AXI_SOUND_ADDR_WIDTH of inst : label is 64;
  attribute C_M_AXI_SOUND_ARUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_ARUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_SOUND_AWUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_AWUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_SOUND_BUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_BUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_SOUND_CACHE_VALUE : string;
  attribute C_M_AXI_SOUND_CACHE_VALUE of inst : label is "4'b0011";
  attribute C_M_AXI_SOUND_DATA_WIDTH : integer;
  attribute C_M_AXI_SOUND_DATA_WIDTH of inst : label is 32;
  attribute C_M_AXI_SOUND_ID_WIDTH : integer;
  attribute C_M_AXI_SOUND_ID_WIDTH of inst : label is 1;
  attribute C_M_AXI_SOUND_PROT_VALUE : string;
  attribute C_M_AXI_SOUND_PROT_VALUE of inst : label is "3'b000";
  attribute C_M_AXI_SOUND_RUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_RUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_SOUND_USER_VALUE : integer;
  attribute C_M_AXI_SOUND_USER_VALUE of inst : label is 0;
  attribute C_M_AXI_SOUND_WSTRB_WIDTH : integer;
  attribute C_M_AXI_SOUND_WSTRB_WIDTH of inst : label is 4;
  attribute C_M_AXI_SOUND_WUSER_WIDTH : integer;
  attribute C_M_AXI_SOUND_WUSER_WIDTH of inst : label is 1;
  attribute C_S_AXI_CONTROL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CONTROL_ADDR_WIDTH of inst : label is 6;
  attribute C_S_AXI_CONTROL_DATA_WIDTH : integer;
  attribute C_S_AXI_CONTROL_DATA_WIDTH of inst : label is 32;
  attribute C_S_AXI_CONTROL_WSTRB_WIDTH : integer;
  attribute C_S_AXI_CONTROL_WSTRB_WIDTH of inst : label is 4;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of inst : label is 32;
  attribute C_S_AXI_WSTRB_WIDTH : integer;
  attribute C_S_AXI_WSTRB_WIDTH of inst : label is 4;
  attribute SDX_KERNEL : string;
  attribute SDX_KERNEL of inst : label is "true";
  attribute SDX_KERNEL_SYNTH_INST : string;
  attribute SDX_KERNEL_SYNTH_INST of inst : label is "inst";
  attribute SDX_KERNEL_TYPE : string;
  attribute SDX_KERNEL_TYPE of inst : label is "hls";
  attribute ap_ST_fsm_state1 : string;
  attribute ap_ST_fsm_state1 of inst : label is "2'b01";
  attribute ap_ST_fsm_state2 : string;
  attribute ap_ST_fsm_state2 of inst : label is "2'b10";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ap_clk : signal is "xilinx.com:signal:clock:1.0 ap_clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ap_clk : signal is "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:m_axi_sound, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of ap_done : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl done";
  attribute X_INTERFACE_INFO of ap_idle : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl idle";
  attribute X_INTERFACE_INFO of ap_ready : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl ready";
  attribute X_INTERFACE_INFO of ap_rst_n : signal is "xilinx.com:signal:reset:1.0 ap_rst_n RST";
  attribute X_INTERFACE_PARAMETER of ap_rst_n : signal is "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of ap_start : signal is "xilinx.com:interface:acc_handshake:1.0 ap_ctrl start";
  attribute X_INTERFACE_INFO of m_axi_sound_ARREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARREADY";
  attribute X_INTERFACE_INFO of m_axi_sound_ARVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARVALID";
  attribute X_INTERFACE_INFO of m_axi_sound_AWREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWREADY";
  attribute X_INTERFACE_INFO of m_axi_sound_AWVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWVALID";
  attribute X_INTERFACE_INFO of m_axi_sound_BREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound BREADY";
  attribute X_INTERFACE_INFO of m_axi_sound_BVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound BVALID";
  attribute X_INTERFACE_INFO of m_axi_sound_RLAST : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound RLAST";
  attribute X_INTERFACE_INFO of m_axi_sound_RREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound RREADY";
  attribute X_INTERFACE_PARAMETER of m_axi_sound_RREADY : signal is "XIL_INTERFACENAME m_axi_sound, ADDR_WIDTH 64, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 32, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_sound_RVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound RVALID";
  attribute X_INTERFACE_INFO of m_axi_sound_WLAST : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound WLAST";
  attribute X_INTERFACE_INFO of m_axi_sound_WREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound WREADY";
  attribute X_INTERFACE_INFO of m_axi_sound_WVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound WVALID";
  attribute X_INTERFACE_INFO of s_axi_control_ARREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY";
  attribute X_INTERFACE_INFO of s_axi_control_ARVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID";
  attribute X_INTERFACE_INFO of s_axi_control_AWREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY";
  attribute X_INTERFACE_INFO of s_axi_control_AWVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID";
  attribute X_INTERFACE_INFO of s_axi_control_BREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BREADY";
  attribute X_INTERFACE_INFO of s_axi_control_BVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BVALID";
  attribute X_INTERFACE_INFO of s_axi_control_RREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RREADY";
  attribute X_INTERFACE_PARAMETER of s_axi_control_RREADY : signal is "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_control_RVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RVALID";
  attribute X_INTERFACE_INFO of s_axi_control_WREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WREADY";
  attribute X_INTERFACE_INFO of s_axi_control_WVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WVALID";
  attribute X_INTERFACE_INFO of m_axi_sound_ARADDR : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARADDR";
  attribute X_INTERFACE_INFO of m_axi_sound_ARBURST : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARBURST";
  attribute X_INTERFACE_INFO of m_axi_sound_ARCACHE : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARCACHE";
  attribute X_INTERFACE_INFO of m_axi_sound_ARLEN : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARLEN";
  attribute X_INTERFACE_INFO of m_axi_sound_ARLOCK : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARLOCK";
  attribute X_INTERFACE_INFO of m_axi_sound_ARPROT : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARPROT";
  attribute X_INTERFACE_INFO of m_axi_sound_ARQOS : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARQOS";
  attribute X_INTERFACE_INFO of m_axi_sound_ARREGION : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARREGION";
  attribute X_INTERFACE_INFO of m_axi_sound_ARSIZE : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound ARSIZE";
  attribute X_INTERFACE_INFO of m_axi_sound_AWADDR : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWADDR";
  attribute X_INTERFACE_INFO of m_axi_sound_AWBURST : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWBURST";
  attribute X_INTERFACE_INFO of m_axi_sound_AWCACHE : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWCACHE";
  attribute X_INTERFACE_INFO of m_axi_sound_AWLEN : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWLEN";
  attribute X_INTERFACE_INFO of m_axi_sound_AWLOCK : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWLOCK";
  attribute X_INTERFACE_INFO of m_axi_sound_AWPROT : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWPROT";
  attribute X_INTERFACE_INFO of m_axi_sound_AWQOS : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWQOS";
  attribute X_INTERFACE_INFO of m_axi_sound_AWREGION : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWREGION";
  attribute X_INTERFACE_INFO of m_axi_sound_AWSIZE : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound AWSIZE";
  attribute X_INTERFACE_INFO of m_axi_sound_BRESP : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound BRESP";
  attribute X_INTERFACE_INFO of m_axi_sound_RDATA : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound RDATA";
  attribute X_INTERFACE_INFO of m_axi_sound_RRESP : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound RRESP";
  attribute X_INTERFACE_INFO of m_axi_sound_WDATA : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound WDATA";
  attribute X_INTERFACE_INFO of m_axi_sound_WSTRB : signal is "xilinx.com:interface:aximm:1.0 m_axi_sound WSTRB";
  attribute X_INTERFACE_INFO of outdata : signal is "xilinx.com:signal:data:1.0 outdata DATA";
  attribute X_INTERFACE_PARAMETER of outdata : signal is "XIL_INTERFACENAME outdata, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of response : signal is "xilinx.com:signal:data:1.0 response DATA";
  attribute X_INTERFACE_PARAMETER of response : signal is "XIL_INTERFACENAME response, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of s_axi_control_ARADDR : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR";
  attribute X_INTERFACE_INFO of s_axi_control_AWADDR : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR";
  attribute X_INTERFACE_INFO of s_axi_control_BRESP : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BRESP";
  attribute X_INTERFACE_INFO of s_axi_control_RDATA : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RDATA";
  attribute X_INTERFACE_INFO of s_axi_control_RRESP : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RRESP";
  attribute X_INTERFACE_INFO of s_axi_control_WDATA : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WDATA";
  attribute X_INTERFACE_INFO of s_axi_control_WSTRB : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB";
  attribute X_INTERFACE_INFO of status : signal is "xilinx.com:signal:data:1.0 status DATA";
  attribute X_INTERFACE_PARAMETER of status : signal is "XIL_INTERFACENAME status, LAYERED_METADATA undef";
begin
  ap_done <= \<const0>\;
  ap_ready <= \<const0>\;
  m_axi_sound_ARADDR(63) <= \<const0>\;
  m_axi_sound_ARADDR(62) <= \<const0>\;
  m_axi_sound_ARADDR(61) <= \<const0>\;
  m_axi_sound_ARADDR(60) <= \<const0>\;
  m_axi_sound_ARADDR(59) <= \<const0>\;
  m_axi_sound_ARADDR(58) <= \<const0>\;
  m_axi_sound_ARADDR(57) <= \<const0>\;
  m_axi_sound_ARADDR(56) <= \<const0>\;
  m_axi_sound_ARADDR(55) <= \<const0>\;
  m_axi_sound_ARADDR(54) <= \<const0>\;
  m_axi_sound_ARADDR(53) <= \<const0>\;
  m_axi_sound_ARADDR(52) <= \<const0>\;
  m_axi_sound_ARADDR(51) <= \<const0>\;
  m_axi_sound_ARADDR(50) <= \<const0>\;
  m_axi_sound_ARADDR(49) <= \<const0>\;
  m_axi_sound_ARADDR(48) <= \<const0>\;
  m_axi_sound_ARADDR(47) <= \<const0>\;
  m_axi_sound_ARADDR(46) <= \<const0>\;
  m_axi_sound_ARADDR(45) <= \<const0>\;
  m_axi_sound_ARADDR(44) <= \<const0>\;
  m_axi_sound_ARADDR(43) <= \<const0>\;
  m_axi_sound_ARADDR(42) <= \<const0>\;
  m_axi_sound_ARADDR(41) <= \<const0>\;
  m_axi_sound_ARADDR(40) <= \<const0>\;
  m_axi_sound_ARADDR(39) <= \<const0>\;
  m_axi_sound_ARADDR(38) <= \<const0>\;
  m_axi_sound_ARADDR(37) <= \<const0>\;
  m_axi_sound_ARADDR(36) <= \<const0>\;
  m_axi_sound_ARADDR(35) <= \<const0>\;
  m_axi_sound_ARADDR(34) <= \<const0>\;
  m_axi_sound_ARADDR(33) <= \<const0>\;
  m_axi_sound_ARADDR(32) <= \<const0>\;
  m_axi_sound_ARADDR(31) <= \<const0>\;
  m_axi_sound_ARADDR(30) <= \<const0>\;
  m_axi_sound_ARADDR(29) <= \<const0>\;
  m_axi_sound_ARADDR(28) <= \<const0>\;
  m_axi_sound_ARADDR(27) <= \<const0>\;
  m_axi_sound_ARADDR(26) <= \<const0>\;
  m_axi_sound_ARADDR(25) <= \<const0>\;
  m_axi_sound_ARADDR(24) <= \<const0>\;
  m_axi_sound_ARADDR(23) <= \<const0>\;
  m_axi_sound_ARADDR(22) <= \<const0>\;
  m_axi_sound_ARADDR(21) <= \<const0>\;
  m_axi_sound_ARADDR(20) <= \<const0>\;
  m_axi_sound_ARADDR(19) <= \<const0>\;
  m_axi_sound_ARADDR(18) <= \<const0>\;
  m_axi_sound_ARADDR(17) <= \<const0>\;
  m_axi_sound_ARADDR(16) <= \<const0>\;
  m_axi_sound_ARADDR(15) <= \<const0>\;
  m_axi_sound_ARADDR(14) <= \<const0>\;
  m_axi_sound_ARADDR(13) <= \<const0>\;
  m_axi_sound_ARADDR(12) <= \<const0>\;
  m_axi_sound_ARADDR(11) <= \<const0>\;
  m_axi_sound_ARADDR(10) <= \<const0>\;
  m_axi_sound_ARADDR(9) <= \<const0>\;
  m_axi_sound_ARADDR(8) <= \<const0>\;
  m_axi_sound_ARADDR(7) <= \<const0>\;
  m_axi_sound_ARADDR(6) <= \<const0>\;
  m_axi_sound_ARADDR(5) <= \<const0>\;
  m_axi_sound_ARADDR(4) <= \<const0>\;
  m_axi_sound_ARADDR(3) <= \<const0>\;
  m_axi_sound_ARADDR(2) <= \<const0>\;
  m_axi_sound_ARADDR(1) <= \<const0>\;
  m_axi_sound_ARADDR(0) <= \<const0>\;
  m_axi_sound_ARBURST(1) <= \<const0>\;
  m_axi_sound_ARBURST(0) <= \<const0>\;
  m_axi_sound_ARCACHE(3) <= \<const0>\;
  m_axi_sound_ARCACHE(2) <= \<const0>\;
  m_axi_sound_ARCACHE(1) <= \<const0>\;
  m_axi_sound_ARCACHE(0) <= \<const0>\;
  m_axi_sound_ARLEN(7) <= \<const0>\;
  m_axi_sound_ARLEN(6) <= \<const0>\;
  m_axi_sound_ARLEN(5) <= \<const0>\;
  m_axi_sound_ARLEN(4) <= \<const0>\;
  m_axi_sound_ARLEN(3) <= \<const0>\;
  m_axi_sound_ARLEN(2) <= \<const0>\;
  m_axi_sound_ARLEN(1) <= \<const0>\;
  m_axi_sound_ARLEN(0) <= \<const0>\;
  m_axi_sound_ARLOCK(1) <= \<const0>\;
  m_axi_sound_ARLOCK(0) <= \<const0>\;
  m_axi_sound_ARPROT(2) <= \<const0>\;
  m_axi_sound_ARPROT(1) <= \<const0>\;
  m_axi_sound_ARPROT(0) <= \<const0>\;
  m_axi_sound_ARQOS(3) <= \<const0>\;
  m_axi_sound_ARQOS(2) <= \<const0>\;
  m_axi_sound_ARQOS(1) <= \<const0>\;
  m_axi_sound_ARQOS(0) <= \<const0>\;
  m_axi_sound_ARREGION(3) <= \<const0>\;
  m_axi_sound_ARREGION(2) <= \<const0>\;
  m_axi_sound_ARREGION(1) <= \<const0>\;
  m_axi_sound_ARREGION(0) <= \<const0>\;
  m_axi_sound_ARSIZE(2) <= \<const0>\;
  m_axi_sound_ARSIZE(1) <= \<const0>\;
  m_axi_sound_ARSIZE(0) <= \<const0>\;
  m_axi_sound_ARVALID <= \<const0>\;
  m_axi_sound_AWADDR(63) <= \<const0>\;
  m_axi_sound_AWADDR(62) <= \<const0>\;
  m_axi_sound_AWADDR(61) <= \<const0>\;
  m_axi_sound_AWADDR(60) <= \<const0>\;
  m_axi_sound_AWADDR(59) <= \<const0>\;
  m_axi_sound_AWADDR(58) <= \<const0>\;
  m_axi_sound_AWADDR(57) <= \<const0>\;
  m_axi_sound_AWADDR(56) <= \<const0>\;
  m_axi_sound_AWADDR(55) <= \<const0>\;
  m_axi_sound_AWADDR(54) <= \<const0>\;
  m_axi_sound_AWADDR(53) <= \<const0>\;
  m_axi_sound_AWADDR(52) <= \<const0>\;
  m_axi_sound_AWADDR(51) <= \<const0>\;
  m_axi_sound_AWADDR(50) <= \<const0>\;
  m_axi_sound_AWADDR(49) <= \<const0>\;
  m_axi_sound_AWADDR(48) <= \<const0>\;
  m_axi_sound_AWADDR(47) <= \<const0>\;
  m_axi_sound_AWADDR(46) <= \<const0>\;
  m_axi_sound_AWADDR(45) <= \<const0>\;
  m_axi_sound_AWADDR(44) <= \<const0>\;
  m_axi_sound_AWADDR(43) <= \<const0>\;
  m_axi_sound_AWADDR(42) <= \<const0>\;
  m_axi_sound_AWADDR(41) <= \<const0>\;
  m_axi_sound_AWADDR(40) <= \<const0>\;
  m_axi_sound_AWADDR(39) <= \<const0>\;
  m_axi_sound_AWADDR(38) <= \<const0>\;
  m_axi_sound_AWADDR(37) <= \<const0>\;
  m_axi_sound_AWADDR(36) <= \<const0>\;
  m_axi_sound_AWADDR(35) <= \<const0>\;
  m_axi_sound_AWADDR(34) <= \<const0>\;
  m_axi_sound_AWADDR(33) <= \<const0>\;
  m_axi_sound_AWADDR(32) <= \<const0>\;
  m_axi_sound_AWADDR(31) <= \<const0>\;
  m_axi_sound_AWADDR(30) <= \<const0>\;
  m_axi_sound_AWADDR(29) <= \<const0>\;
  m_axi_sound_AWADDR(28) <= \<const0>\;
  m_axi_sound_AWADDR(27) <= \<const0>\;
  m_axi_sound_AWADDR(26) <= \<const0>\;
  m_axi_sound_AWADDR(25) <= \<const0>\;
  m_axi_sound_AWADDR(24) <= \<const0>\;
  m_axi_sound_AWADDR(23) <= \<const0>\;
  m_axi_sound_AWADDR(22) <= \<const0>\;
  m_axi_sound_AWADDR(21) <= \<const0>\;
  m_axi_sound_AWADDR(20) <= \<const0>\;
  m_axi_sound_AWADDR(19) <= \<const0>\;
  m_axi_sound_AWADDR(18) <= \<const0>\;
  m_axi_sound_AWADDR(17) <= \<const0>\;
  m_axi_sound_AWADDR(16) <= \<const0>\;
  m_axi_sound_AWADDR(15) <= \<const0>\;
  m_axi_sound_AWADDR(14) <= \<const0>\;
  m_axi_sound_AWADDR(13) <= \<const0>\;
  m_axi_sound_AWADDR(12) <= \<const0>\;
  m_axi_sound_AWADDR(11) <= \<const0>\;
  m_axi_sound_AWADDR(10) <= \<const0>\;
  m_axi_sound_AWADDR(9) <= \<const0>\;
  m_axi_sound_AWADDR(8) <= \<const0>\;
  m_axi_sound_AWADDR(7) <= \<const0>\;
  m_axi_sound_AWADDR(6) <= \<const0>\;
  m_axi_sound_AWADDR(5) <= \<const0>\;
  m_axi_sound_AWADDR(4) <= \<const0>\;
  m_axi_sound_AWADDR(3) <= \<const0>\;
  m_axi_sound_AWADDR(2) <= \<const0>\;
  m_axi_sound_AWADDR(1) <= \<const0>\;
  m_axi_sound_AWADDR(0) <= \<const0>\;
  m_axi_sound_AWBURST(1) <= \<const0>\;
  m_axi_sound_AWBURST(0) <= \<const0>\;
  m_axi_sound_AWCACHE(3) <= \<const0>\;
  m_axi_sound_AWCACHE(2) <= \<const0>\;
  m_axi_sound_AWCACHE(1) <= \<const0>\;
  m_axi_sound_AWCACHE(0) <= \<const0>\;
  m_axi_sound_AWLEN(7) <= \<const0>\;
  m_axi_sound_AWLEN(6) <= \<const0>\;
  m_axi_sound_AWLEN(5) <= \<const0>\;
  m_axi_sound_AWLEN(4) <= \<const0>\;
  m_axi_sound_AWLEN(3) <= \<const0>\;
  m_axi_sound_AWLEN(2) <= \<const0>\;
  m_axi_sound_AWLEN(1) <= \<const0>\;
  m_axi_sound_AWLEN(0) <= \<const0>\;
  m_axi_sound_AWLOCK(1) <= \<const0>\;
  m_axi_sound_AWLOCK(0) <= \<const0>\;
  m_axi_sound_AWPROT(2) <= \<const0>\;
  m_axi_sound_AWPROT(1) <= \<const0>\;
  m_axi_sound_AWPROT(0) <= \<const0>\;
  m_axi_sound_AWQOS(3) <= \<const0>\;
  m_axi_sound_AWQOS(2) <= \<const0>\;
  m_axi_sound_AWQOS(1) <= \<const0>\;
  m_axi_sound_AWQOS(0) <= \<const0>\;
  m_axi_sound_AWREGION(3) <= \<const0>\;
  m_axi_sound_AWREGION(2) <= \<const0>\;
  m_axi_sound_AWREGION(1) <= \<const0>\;
  m_axi_sound_AWREGION(0) <= \<const0>\;
  m_axi_sound_AWSIZE(2) <= \<const0>\;
  m_axi_sound_AWSIZE(1) <= \<const0>\;
  m_axi_sound_AWSIZE(0) <= \<const0>\;
  m_axi_sound_AWVALID <= \<const0>\;
  m_axi_sound_BREADY <= \<const0>\;
  m_axi_sound_RREADY <= \<const0>\;
  m_axi_sound_WDATA(31) <= \<const0>\;
  m_axi_sound_WDATA(30) <= \<const0>\;
  m_axi_sound_WDATA(29) <= \<const0>\;
  m_axi_sound_WDATA(28) <= \<const0>\;
  m_axi_sound_WDATA(27) <= \<const0>\;
  m_axi_sound_WDATA(26) <= \<const0>\;
  m_axi_sound_WDATA(25) <= \<const0>\;
  m_axi_sound_WDATA(24) <= \<const0>\;
  m_axi_sound_WDATA(23) <= \<const0>\;
  m_axi_sound_WDATA(22) <= \<const0>\;
  m_axi_sound_WDATA(21) <= \<const0>\;
  m_axi_sound_WDATA(20) <= \<const0>\;
  m_axi_sound_WDATA(19) <= \<const0>\;
  m_axi_sound_WDATA(18) <= \<const0>\;
  m_axi_sound_WDATA(17) <= \<const0>\;
  m_axi_sound_WDATA(16) <= \<const0>\;
  m_axi_sound_WDATA(15) <= \<const0>\;
  m_axi_sound_WDATA(14) <= \<const0>\;
  m_axi_sound_WDATA(13) <= \<const0>\;
  m_axi_sound_WDATA(12) <= \<const0>\;
  m_axi_sound_WDATA(11) <= \<const0>\;
  m_axi_sound_WDATA(10) <= \<const0>\;
  m_axi_sound_WDATA(9) <= \<const0>\;
  m_axi_sound_WDATA(8) <= \<const0>\;
  m_axi_sound_WDATA(7) <= \<const0>\;
  m_axi_sound_WDATA(6) <= \<const0>\;
  m_axi_sound_WDATA(5) <= \<const0>\;
  m_axi_sound_WDATA(4) <= \<const0>\;
  m_axi_sound_WDATA(3) <= \<const0>\;
  m_axi_sound_WDATA(2) <= \<const0>\;
  m_axi_sound_WDATA(1) <= \<const0>\;
  m_axi_sound_WDATA(0) <= \<const0>\;
  m_axi_sound_WLAST <= \<const0>\;
  m_axi_sound_WSTRB(3) <= \<const0>\;
  m_axi_sound_WSTRB(2) <= \<const0>\;
  m_axi_sound_WSTRB(1) <= \<const0>\;
  m_axi_sound_WSTRB(0) <= \<const0>\;
  m_axi_sound_WVALID <= \<const0>\;
  s_axi_control_BRESP(1) <= \<const0>\;
  s_axi_control_BRESP(0) <= \<const0>\;
  s_axi_control_RRESP(1) <= \<const0>\;
  s_axi_control_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation
     port map (
      ap_clk => ap_clk,
      ap_done => NLW_inst_ap_done_UNCONNECTED,
      ap_idle => ap_idle,
      ap_ready => NLW_inst_ap_ready_UNCONNECTED,
      ap_rst_n => ap_rst_n,
      ap_start => ap_start,
      m_axi_sound_ARADDR(63 downto 0) => NLW_inst_m_axi_sound_ARADDR_UNCONNECTED(63 downto 0),
      m_axi_sound_ARBURST(1 downto 0) => NLW_inst_m_axi_sound_ARBURST_UNCONNECTED(1 downto 0),
      m_axi_sound_ARCACHE(3 downto 0) => NLW_inst_m_axi_sound_ARCACHE_UNCONNECTED(3 downto 0),
      m_axi_sound_ARID(0) => NLW_inst_m_axi_sound_ARID_UNCONNECTED(0),
      m_axi_sound_ARLEN(7 downto 0) => NLW_inst_m_axi_sound_ARLEN_UNCONNECTED(7 downto 0),
      m_axi_sound_ARLOCK(1 downto 0) => NLW_inst_m_axi_sound_ARLOCK_UNCONNECTED(1 downto 0),
      m_axi_sound_ARPROT(2 downto 0) => NLW_inst_m_axi_sound_ARPROT_UNCONNECTED(2 downto 0),
      m_axi_sound_ARQOS(3 downto 0) => NLW_inst_m_axi_sound_ARQOS_UNCONNECTED(3 downto 0),
      m_axi_sound_ARREADY => '0',
      m_axi_sound_ARREGION(3 downto 0) => NLW_inst_m_axi_sound_ARREGION_UNCONNECTED(3 downto 0),
      m_axi_sound_ARSIZE(2 downto 0) => NLW_inst_m_axi_sound_ARSIZE_UNCONNECTED(2 downto 0),
      m_axi_sound_ARUSER(0) => NLW_inst_m_axi_sound_ARUSER_UNCONNECTED(0),
      m_axi_sound_ARVALID => NLW_inst_m_axi_sound_ARVALID_UNCONNECTED,
      m_axi_sound_AWADDR(63 downto 0) => NLW_inst_m_axi_sound_AWADDR_UNCONNECTED(63 downto 0),
      m_axi_sound_AWBURST(1 downto 0) => NLW_inst_m_axi_sound_AWBURST_UNCONNECTED(1 downto 0),
      m_axi_sound_AWCACHE(3 downto 0) => NLW_inst_m_axi_sound_AWCACHE_UNCONNECTED(3 downto 0),
      m_axi_sound_AWID(0) => NLW_inst_m_axi_sound_AWID_UNCONNECTED(0),
      m_axi_sound_AWLEN(7 downto 0) => NLW_inst_m_axi_sound_AWLEN_UNCONNECTED(7 downto 0),
      m_axi_sound_AWLOCK(1 downto 0) => NLW_inst_m_axi_sound_AWLOCK_UNCONNECTED(1 downto 0),
      m_axi_sound_AWPROT(2 downto 0) => NLW_inst_m_axi_sound_AWPROT_UNCONNECTED(2 downto 0),
      m_axi_sound_AWQOS(3 downto 0) => NLW_inst_m_axi_sound_AWQOS_UNCONNECTED(3 downto 0),
      m_axi_sound_AWREADY => '0',
      m_axi_sound_AWREGION(3 downto 0) => NLW_inst_m_axi_sound_AWREGION_UNCONNECTED(3 downto 0),
      m_axi_sound_AWSIZE(2 downto 0) => NLW_inst_m_axi_sound_AWSIZE_UNCONNECTED(2 downto 0),
      m_axi_sound_AWUSER(0) => NLW_inst_m_axi_sound_AWUSER_UNCONNECTED(0),
      m_axi_sound_AWVALID => NLW_inst_m_axi_sound_AWVALID_UNCONNECTED,
      m_axi_sound_BID(0) => '0',
      m_axi_sound_BREADY => NLW_inst_m_axi_sound_BREADY_UNCONNECTED,
      m_axi_sound_BRESP(1 downto 0) => B"00",
      m_axi_sound_BUSER(0) => '0',
      m_axi_sound_BVALID => '0',
      m_axi_sound_RDATA(31 downto 0) => B"00000000000000000000000000000000",
      m_axi_sound_RID(0) => '0',
      m_axi_sound_RLAST => '0',
      m_axi_sound_RREADY => NLW_inst_m_axi_sound_RREADY_UNCONNECTED,
      m_axi_sound_RRESP(1 downto 0) => B"00",
      m_axi_sound_RUSER(0) => '0',
      m_axi_sound_RVALID => '0',
      m_axi_sound_WDATA(31 downto 0) => NLW_inst_m_axi_sound_WDATA_UNCONNECTED(31 downto 0),
      m_axi_sound_WID(0) => NLW_inst_m_axi_sound_WID_UNCONNECTED(0),
      m_axi_sound_WLAST => NLW_inst_m_axi_sound_WLAST_UNCONNECTED,
      m_axi_sound_WREADY => '0',
      m_axi_sound_WSTRB(3 downto 0) => NLW_inst_m_axi_sound_WSTRB_UNCONNECTED(3 downto 0),
      m_axi_sound_WUSER(0) => NLW_inst_m_axi_sound_WUSER_UNCONNECTED(0),
      m_axi_sound_WVALID => NLW_inst_m_axi_sound_WVALID_UNCONNECTED,
      outdata(31 downto 0) => B"00000000000000000000000000000000",
      response(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_control_ARADDR(5 downto 0) => s_axi_control_ARADDR(5 downto 0),
      s_axi_control_ARREADY => s_axi_control_ARREADY,
      s_axi_control_ARVALID => s_axi_control_ARVALID,
      s_axi_control_AWADDR(5 downto 0) => s_axi_control_AWADDR(5 downto 0),
      s_axi_control_AWREADY => s_axi_control_AWREADY,
      s_axi_control_AWVALID => s_axi_control_AWVALID,
      s_axi_control_BREADY => s_axi_control_BREADY,
      s_axi_control_BRESP(1 downto 0) => NLW_inst_s_axi_control_BRESP_UNCONNECTED(1 downto 0),
      s_axi_control_BVALID => s_axi_control_BVALID,
      s_axi_control_RDATA(31 downto 0) => s_axi_control_RDATA(31 downto 0),
      s_axi_control_RREADY => s_axi_control_RREADY,
      s_axi_control_RRESP(1 downto 0) => NLW_inst_s_axi_control_RRESP_UNCONNECTED(1 downto 0),
      s_axi_control_RVALID => s_axi_control_RVALID,
      s_axi_control_WDATA(31 downto 0) => s_axi_control_WDATA(31 downto 0),
      s_axi_control_WREADY => s_axi_control_WREADY,
      s_axi_control_WSTRB(3 downto 0) => s_axi_control_WSTRB(3 downto 0),
      s_axi_control_WVALID => s_axi_control_WVALID,
      status(31 downto 0) => B"00000000000000000000000000000000"
    );
end STRUCTURE;
