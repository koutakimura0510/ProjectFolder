-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Tue May 11 08:25:44 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_sound_operation_0_7_sim_netlist.vhdl
-- Design      : design_1_sound_operation_0_7
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
    \FSM_onehot_rstate_reg[1]_0\ : out STD_LOGIC;
    s_axi_control_BVALID : out STD_LOGIC;
    \FSM_onehot_wstate_reg[2]_0\ : out STD_LOGIC;
    \FSM_onehot_wstate_reg[1]_0\ : out STD_LOGIC;
    s_axi_control_RVALID : out STD_LOGIC;
    opeout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    O56 : out STD_LOGIC_VECTOR ( 61 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    ap_clk : in STD_LOGIC;
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    count : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi is
  signal \FSM_onehot_rstate[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_rstate[2]_i_1_n_0\ : STD_LOGIC;
  signal \^fsm_onehot_rstate_reg[1]_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[3]_i_1_n_0\ : STD_LOGIC;
  signal \^fsm_onehot_wstate_reg[1]_0\ : STD_LOGIC;
  signal \^fsm_onehot_wstate_reg[2]_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[10]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[10]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[10]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[10]_i_5_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[14]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[14]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[14]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[14]_i_5_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[18]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[18]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[18]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[18]_i_5_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[22]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[22]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[22]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[22]_i_5_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[26]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[26]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[26]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[26]_i_5_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[2]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[2]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[2]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[30]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[30]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[30]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[30]_i_5_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[34]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[6]_i_2_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[6]_i_3_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[6]_i_4_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158[6]_i_5_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[10]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[10]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[10]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[10]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[14]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[14]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[14]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[14]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[18]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[18]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[18]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[18]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[22]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[22]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[22]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[22]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[26]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[26]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[26]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[26]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[2]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[2]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[2]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[30]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[30]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[30]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[30]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[34]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[34]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[34]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[34]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[38]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[38]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[38]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[38]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[42]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[42]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[42]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[42]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[46]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[46]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[46]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[46]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[50]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[50]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[50]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[50]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[54]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[54]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[54]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[54]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[58]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[58]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[58]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[58]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[61]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[61]_i_1_n_3\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[6]_i_1_n_1\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[6]_i_1_n_2\ : STD_LOGIC;
  signal \gmem_addr_reg_158_reg[6]_i_1_n_3\ : STD_LOGIC;
  signal int_ramadr : STD_LOGIC;
  signal int_ramadr3_out : STD_LOGIC;
  signal \int_ramadr[31]_i_3_n_0\ : STD_LOGIC;
  signal int_ramadr_reg0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal int_ramadr_reg02_out : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal int_status : STD_LOGIC;
  signal int_status0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \int_status[31]_i_3_n_0\ : STD_LOGIC;
  signal \^opeout\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal ramadr : STD_LOGIC_VECTOR ( 63 downto 0 );
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
  signal \NLW_gmem_addr_reg_158_reg[2]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_gmem_addr_reg_158_reg[61]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_gmem_addr_reg_158_reg[61]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_onehot_rstate[1]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \FSM_onehot_rstate[2]_i_1\ : label is "soft_lutpair1";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_rstate_reg[1]\ : label is "RDIDLE:010,RDDATA:100,iSTATE:001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_rstate_reg[2]\ : label is "RDIDLE:010,RDDATA:100,iSTATE:001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[1]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[2]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[3]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[10]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[14]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[18]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[22]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[26]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[2]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[30]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[34]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[38]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[42]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[46]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[50]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[54]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[58]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[61]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \gmem_addr_reg_158_reg[6]_i_1\ : label is 35;
  attribute SOFT_HLUTNM of \int_ramadr[0]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \int_ramadr[10]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \int_ramadr[11]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \int_ramadr[12]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \int_ramadr[13]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \int_ramadr[14]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \int_ramadr[15]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \int_ramadr[16]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \int_ramadr[17]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \int_ramadr[18]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \int_ramadr[19]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \int_ramadr[1]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \int_ramadr[20]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \int_ramadr[21]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \int_ramadr[22]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \int_ramadr[23]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \int_ramadr[24]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \int_ramadr[25]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \int_ramadr[26]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \int_ramadr[27]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \int_ramadr[28]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \int_ramadr[29]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \int_ramadr[2]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \int_ramadr[30]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \int_ramadr[31]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \int_ramadr[31]_i_3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \int_ramadr[32]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \int_ramadr[33]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \int_ramadr[34]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \int_ramadr[35]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \int_ramadr[36]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \int_ramadr[37]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \int_ramadr[38]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \int_ramadr[39]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \int_ramadr[3]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \int_ramadr[40]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \int_ramadr[41]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \int_ramadr[42]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \int_ramadr[43]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \int_ramadr[44]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \int_ramadr[45]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \int_ramadr[46]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \int_ramadr[47]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \int_ramadr[48]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \int_ramadr[49]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \int_ramadr[4]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \int_ramadr[50]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \int_ramadr[51]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \int_ramadr[52]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \int_ramadr[53]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \int_ramadr[54]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \int_ramadr[55]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \int_ramadr[56]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \int_ramadr[57]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \int_ramadr[58]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \int_ramadr[59]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \int_ramadr[5]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \int_ramadr[60]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \int_ramadr[61]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \int_ramadr[62]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \int_ramadr[63]_i_2\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \int_ramadr[6]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \int_ramadr[7]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \int_ramadr[8]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \int_ramadr[9]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \int_status[0]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \int_status[10]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \int_status[11]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \int_status[12]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \int_status[13]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \int_status[14]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \int_status[15]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \int_status[16]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \int_status[17]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \int_status[18]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \int_status[19]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \int_status[1]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \int_status[20]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \int_status[21]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \int_status[22]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \int_status[23]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \int_status[24]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \int_status[25]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \int_status[26]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \int_status[27]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \int_status[28]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \int_status[29]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \int_status[2]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \int_status[30]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \int_status[31]_i_2\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \int_status[31]_i_3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \int_status[3]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \int_status[4]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \int_status[5]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \int_status[6]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \int_status[7]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \int_status[8]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \int_status[9]_i_1\ : label is "soft_lutpair45";
begin
  \FSM_onehot_rstate_reg[1]_0\ <= \^fsm_onehot_rstate_reg[1]_0\;
  \FSM_onehot_wstate_reg[1]_0\ <= \^fsm_onehot_wstate_reg[1]_0\;
  \FSM_onehot_wstate_reg[2]_0\ <= \^fsm_onehot_wstate_reg[2]_0\;
  opeout(31 downto 0) <= \^opeout\(31 downto 0);
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
      R => SR(0)
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
      R => SR(0)
    );
\FSM_onehot_wstate[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8F888FBB"
    )
        port map (
      I0 => s_axi_control_BREADY,
      I1 => \^s_axi_control_bvalid\,
      I2 => s_axi_control_AWVALID,
      I3 => \^fsm_onehot_wstate_reg[1]_0\,
      I4 => \^fsm_onehot_wstate_reg[2]_0\,
      O => \FSM_onehot_wstate[1]_i_1_n_0\
    );
\FSM_onehot_wstate[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"88F8"
    )
        port map (
      I0 => s_axi_control_AWVALID,
      I1 => \^fsm_onehot_wstate_reg[1]_0\,
      I2 => \^fsm_onehot_wstate_reg[2]_0\,
      I3 => s_axi_control_WVALID,
      O => \FSM_onehot_wstate[2]_i_1_n_0\
    );
\FSM_onehot_wstate[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D5C0"
    )
        port map (
      I0 => s_axi_control_BREADY,
      I1 => \^fsm_onehot_wstate_reg[2]_0\,
      I2 => s_axi_control_WVALID,
      I3 => \^s_axi_control_bvalid\,
      O => \FSM_onehot_wstate[3]_i_1_n_0\
    );
\FSM_onehot_wstate_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_wstate[1]_i_1_n_0\,
      Q => \^fsm_onehot_wstate_reg[1]_0\,
      R => SR(0)
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
      R => SR(0)
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
      R => SR(0)
    );
\gmem_addr_reg_158[10]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(10),
      I1 => ramadr(12),
      O => \gmem_addr_reg_158[10]_i_2_n_0\
    );
\gmem_addr_reg_158[10]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(9),
      I1 => ramadr(11),
      O => \gmem_addr_reg_158[10]_i_3_n_0\
    );
\gmem_addr_reg_158[10]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(8),
      I1 => ramadr(10),
      O => \gmem_addr_reg_158[10]_i_4_n_0\
    );
\gmem_addr_reg_158[10]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(7),
      I1 => ramadr(9),
      O => \gmem_addr_reg_158[10]_i_5_n_0\
    );
\gmem_addr_reg_158[14]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(14),
      I1 => ramadr(16),
      O => \gmem_addr_reg_158[14]_i_2_n_0\
    );
\gmem_addr_reg_158[14]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(13),
      I1 => ramadr(15),
      O => \gmem_addr_reg_158[14]_i_3_n_0\
    );
\gmem_addr_reg_158[14]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(12),
      I1 => ramadr(14),
      O => \gmem_addr_reg_158[14]_i_4_n_0\
    );
\gmem_addr_reg_158[14]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(11),
      I1 => ramadr(13),
      O => \gmem_addr_reg_158[14]_i_5_n_0\
    );
\gmem_addr_reg_158[18]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(18),
      I1 => ramadr(20),
      O => \gmem_addr_reg_158[18]_i_2_n_0\
    );
\gmem_addr_reg_158[18]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(17),
      I1 => ramadr(19),
      O => \gmem_addr_reg_158[18]_i_3_n_0\
    );
\gmem_addr_reg_158[18]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(16),
      I1 => ramadr(18),
      O => \gmem_addr_reg_158[18]_i_4_n_0\
    );
\gmem_addr_reg_158[18]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(15),
      I1 => ramadr(17),
      O => \gmem_addr_reg_158[18]_i_5_n_0\
    );
\gmem_addr_reg_158[22]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(22),
      I1 => ramadr(24),
      O => \gmem_addr_reg_158[22]_i_2_n_0\
    );
\gmem_addr_reg_158[22]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(21),
      I1 => ramadr(23),
      O => \gmem_addr_reg_158[22]_i_3_n_0\
    );
\gmem_addr_reg_158[22]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(20),
      I1 => ramadr(22),
      O => \gmem_addr_reg_158[22]_i_4_n_0\
    );
\gmem_addr_reg_158[22]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(19),
      I1 => ramadr(21),
      O => \gmem_addr_reg_158[22]_i_5_n_0\
    );
\gmem_addr_reg_158[26]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(26),
      I1 => ramadr(28),
      O => \gmem_addr_reg_158[26]_i_2_n_0\
    );
\gmem_addr_reg_158[26]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(25),
      I1 => ramadr(27),
      O => \gmem_addr_reg_158[26]_i_3_n_0\
    );
\gmem_addr_reg_158[26]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(24),
      I1 => ramadr(26),
      O => \gmem_addr_reg_158[26]_i_4_n_0\
    );
\gmem_addr_reg_158[26]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(23),
      I1 => ramadr(25),
      O => \gmem_addr_reg_158[26]_i_5_n_0\
    );
\gmem_addr_reg_158[2]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(2),
      I1 => ramadr(4),
      O => \gmem_addr_reg_158[2]_i_2_n_0\
    );
\gmem_addr_reg_158[2]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(1),
      I1 => ramadr(3),
      O => \gmem_addr_reg_158[2]_i_3_n_0\
    );
\gmem_addr_reg_158[2]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(0),
      I1 => ramadr(2),
      O => \gmem_addr_reg_158[2]_i_4_n_0\
    );
\gmem_addr_reg_158[30]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(30),
      I1 => ramadr(32),
      O => \gmem_addr_reg_158[30]_i_2_n_0\
    );
\gmem_addr_reg_158[30]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(29),
      I1 => ramadr(31),
      O => \gmem_addr_reg_158[30]_i_3_n_0\
    );
\gmem_addr_reg_158[30]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(28),
      I1 => ramadr(30),
      O => \gmem_addr_reg_158[30]_i_4_n_0\
    );
\gmem_addr_reg_158[30]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(27),
      I1 => ramadr(29),
      O => \gmem_addr_reg_158[30]_i_5_n_0\
    );
\gmem_addr_reg_158[34]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(31),
      I1 => ramadr(33),
      O => \gmem_addr_reg_158[34]_i_2_n_0\
    );
\gmem_addr_reg_158[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(6),
      I1 => ramadr(8),
      O => \gmem_addr_reg_158[6]_i_2_n_0\
    );
\gmem_addr_reg_158[6]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(5),
      I1 => ramadr(7),
      O => \gmem_addr_reg_158[6]_i_3_n_0\
    );
\gmem_addr_reg_158[6]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(4),
      I1 => ramadr(6),
      O => \gmem_addr_reg_158[6]_i_4_n_0\
    );
\gmem_addr_reg_158[6]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => count(3),
      I1 => ramadr(5),
      O => \gmem_addr_reg_158[6]_i_5_n_0\
    );
\gmem_addr_reg_158_reg[10]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[6]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[10]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[10]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[10]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[10]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => count(10 downto 7),
      O(3 downto 0) => O56(10 downto 7),
      S(3) => \gmem_addr_reg_158[10]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[10]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[10]_i_4_n_0\,
      S(0) => \gmem_addr_reg_158[10]_i_5_n_0\
    );
\gmem_addr_reg_158_reg[14]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[10]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[14]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[14]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[14]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[14]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => count(14 downto 11),
      O(3 downto 0) => O56(14 downto 11),
      S(3) => \gmem_addr_reg_158[14]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[14]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[14]_i_4_n_0\,
      S(0) => \gmem_addr_reg_158[14]_i_5_n_0\
    );
\gmem_addr_reg_158_reg[18]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[14]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[18]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[18]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[18]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[18]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => count(18 downto 15),
      O(3 downto 0) => O56(18 downto 15),
      S(3) => \gmem_addr_reg_158[18]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[18]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[18]_i_4_n_0\,
      S(0) => \gmem_addr_reg_158[18]_i_5_n_0\
    );
\gmem_addr_reg_158_reg[22]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[18]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[22]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[22]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[22]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[22]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => count(22 downto 19),
      O(3 downto 0) => O56(22 downto 19),
      S(3) => \gmem_addr_reg_158[22]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[22]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[22]_i_4_n_0\,
      S(0) => \gmem_addr_reg_158[22]_i_5_n_0\
    );
\gmem_addr_reg_158_reg[26]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[22]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[26]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[26]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[26]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[26]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => count(26 downto 23),
      O(3 downto 0) => O56(26 downto 23),
      S(3) => \gmem_addr_reg_158[26]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[26]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[26]_i_4_n_0\,
      S(0) => \gmem_addr_reg_158[26]_i_5_n_0\
    );
\gmem_addr_reg_158_reg[2]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \gmem_addr_reg_158_reg[2]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[2]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[2]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[2]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => count(2 downto 0),
      DI(0) => '0',
      O(3 downto 1) => O56(2 downto 0),
      O(0) => \NLW_gmem_addr_reg_158_reg[2]_i_1_O_UNCONNECTED\(0),
      S(3) => \gmem_addr_reg_158[2]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[2]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[2]_i_4_n_0\,
      S(0) => ramadr(1)
    );
\gmem_addr_reg_158_reg[30]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[26]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[30]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[30]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[30]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[30]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => count(30 downto 27),
      O(3 downto 0) => O56(30 downto 27),
      S(3) => \gmem_addr_reg_158[30]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[30]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[30]_i_4_n_0\,
      S(0) => \gmem_addr_reg_158[30]_i_5_n_0\
    );
\gmem_addr_reg_158_reg[34]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[30]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[34]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[34]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[34]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[34]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => count(31),
      O(3 downto 0) => O56(34 downto 31),
      S(3 downto 1) => ramadr(36 downto 34),
      S(0) => \gmem_addr_reg_158[34]_i_2_n_0\
    );
\gmem_addr_reg_158_reg[38]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[34]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[38]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[38]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[38]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[38]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => O56(38 downto 35),
      S(3 downto 0) => ramadr(40 downto 37)
    );
\gmem_addr_reg_158_reg[42]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[38]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[42]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[42]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[42]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[42]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => O56(42 downto 39),
      S(3 downto 0) => ramadr(44 downto 41)
    );
\gmem_addr_reg_158_reg[46]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[42]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[46]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[46]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[46]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[46]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => O56(46 downto 43),
      S(3 downto 0) => ramadr(48 downto 45)
    );
\gmem_addr_reg_158_reg[50]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[46]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[50]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[50]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[50]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[50]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => O56(50 downto 47),
      S(3 downto 0) => ramadr(52 downto 49)
    );
\gmem_addr_reg_158_reg[54]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[50]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[54]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[54]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[54]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[54]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => O56(54 downto 51),
      S(3 downto 0) => ramadr(56 downto 53)
    );
\gmem_addr_reg_158_reg[58]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[54]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[58]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[58]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[58]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[58]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => O56(58 downto 55),
      S(3 downto 0) => ramadr(60 downto 57)
    );
\gmem_addr_reg_158_reg[61]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[58]_i_1_n_0\,
      CO(3 downto 2) => \NLW_gmem_addr_reg_158_reg[61]_i_1_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \gmem_addr_reg_158_reg[61]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[61]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_gmem_addr_reg_158_reg[61]_i_1_O_UNCONNECTED\(3),
      O(2 downto 0) => O56(61 downto 59),
      S(3) => '0',
      S(2 downto 0) => ramadr(63 downto 61)
    );
\gmem_addr_reg_158_reg[6]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \gmem_addr_reg_158_reg[2]_i_1_n_0\,
      CO(3) => \gmem_addr_reg_158_reg[6]_i_1_n_0\,
      CO(2) => \gmem_addr_reg_158_reg[6]_i_1_n_1\,
      CO(1) => \gmem_addr_reg_158_reg[6]_i_1_n_2\,
      CO(0) => \gmem_addr_reg_158_reg[6]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => count(6 downto 3),
      O(3 downto 0) => O56(6 downto 3),
      S(3) => \gmem_addr_reg_158[6]_i_2_n_0\,
      S(2) => \gmem_addr_reg_158[6]_i_3_n_0\,
      S(1) => \gmem_addr_reg_158[6]_i_4_n_0\,
      S(0) => \gmem_addr_reg_158[6]_i_5_n_0\
    );
\int_ramadr[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(0),
      O => int_ramadr_reg02_out(0)
    );
\int_ramadr[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(10),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(10),
      O => int_ramadr_reg02_out(10)
    );
\int_ramadr[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(11),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(11),
      O => int_ramadr_reg02_out(11)
    );
\int_ramadr[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(12),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(12),
      O => int_ramadr_reg02_out(12)
    );
\int_ramadr[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(13),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(13),
      O => int_ramadr_reg02_out(13)
    );
\int_ramadr[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(14),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(14),
      O => int_ramadr_reg02_out(14)
    );
\int_ramadr[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(15),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(15),
      O => int_ramadr_reg02_out(15)
    );
\int_ramadr[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(16),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(16),
      O => int_ramadr_reg02_out(16)
    );
\int_ramadr[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(17),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(17),
      O => int_ramadr_reg02_out(17)
    );
\int_ramadr[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(18),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(18),
      O => int_ramadr_reg02_out(18)
    );
\int_ramadr[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(19),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(19),
      O => int_ramadr_reg02_out(19)
    );
\int_ramadr[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(1),
      O => int_ramadr_reg02_out(1)
    );
\int_ramadr[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(20),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(20),
      O => int_ramadr_reg02_out(20)
    );
\int_ramadr[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(21),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(21),
      O => int_ramadr_reg02_out(21)
    );
\int_ramadr[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(22),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(22),
      O => int_ramadr_reg02_out(22)
    );
\int_ramadr[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(23),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(23),
      O => int_ramadr_reg02_out(23)
    );
\int_ramadr[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(24),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(24),
      O => int_ramadr_reg02_out(24)
    );
\int_ramadr[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(25),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(25),
      O => int_ramadr_reg02_out(25)
    );
\int_ramadr[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(26),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(26),
      O => int_ramadr_reg02_out(26)
    );
\int_ramadr[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(27),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(27),
      O => int_ramadr_reg02_out(27)
    );
\int_ramadr[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(28),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(28),
      O => int_ramadr_reg02_out(28)
    );
\int_ramadr[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(29),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(29),
      O => int_ramadr_reg02_out(29)
    );
\int_ramadr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(2),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(2),
      O => int_ramadr_reg02_out(2)
    );
\int_ramadr[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(30),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(30),
      O => int_ramadr_reg02_out(30)
    );
\int_ramadr[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00200000"
    )
        port map (
      I0 => s_axi_control_WVALID,
      I1 => \waddr_reg_n_0_[2]\,
      I2 => \int_ramadr[31]_i_3_n_0\,
      I3 => \waddr_reg_n_0_[3]\,
      I4 => \^fsm_onehot_wstate_reg[2]_0\,
      O => int_ramadr3_out
    );
\int_ramadr[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(31),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(31),
      O => int_ramadr_reg02_out(31)
    );
\int_ramadr[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \waddr_reg_n_0_[5]\,
      I1 => \waddr_reg_n_0_[4]\,
      I2 => \waddr_reg_n_0_[0]\,
      I3 => \waddr_reg_n_0_[1]\,
      O => \int_ramadr[31]_i_3_n_0\
    );
\int_ramadr[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(32),
      O => int_ramadr_reg0(0)
    );
\int_ramadr[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(33),
      O => int_ramadr_reg0(1)
    );
\int_ramadr[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(2),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(34),
      O => int_ramadr_reg0(2)
    );
\int_ramadr[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(3),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(35),
      O => int_ramadr_reg0(3)
    );
\int_ramadr[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(4),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(36),
      O => int_ramadr_reg0(4)
    );
\int_ramadr[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(5),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(37),
      O => int_ramadr_reg0(5)
    );
\int_ramadr[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(6),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(38),
      O => int_ramadr_reg0(6)
    );
\int_ramadr[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(7),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(39),
      O => int_ramadr_reg0(7)
    );
\int_ramadr[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(3),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(3),
      O => int_ramadr_reg02_out(3)
    );
\int_ramadr[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(8),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(40),
      O => int_ramadr_reg0(8)
    );
\int_ramadr[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(9),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(41),
      O => int_ramadr_reg0(9)
    );
\int_ramadr[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(10),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(42),
      O => int_ramadr_reg0(10)
    );
\int_ramadr[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(11),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(43),
      O => int_ramadr_reg0(11)
    );
\int_ramadr[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(12),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(44),
      O => int_ramadr_reg0(12)
    );
\int_ramadr[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(13),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(45),
      O => int_ramadr_reg0(13)
    );
\int_ramadr[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(14),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(46),
      O => int_ramadr_reg0(14)
    );
\int_ramadr[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(15),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(47),
      O => int_ramadr_reg0(15)
    );
\int_ramadr[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(16),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(48),
      O => int_ramadr_reg0(16)
    );
\int_ramadr[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(17),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(49),
      O => int_ramadr_reg0(17)
    );
\int_ramadr[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(4),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(4),
      O => int_ramadr_reg02_out(4)
    );
\int_ramadr[50]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(18),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(50),
      O => int_ramadr_reg0(18)
    );
\int_ramadr[51]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(19),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(51),
      O => int_ramadr_reg0(19)
    );
\int_ramadr[52]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(20),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(52),
      O => int_ramadr_reg0(20)
    );
\int_ramadr[53]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(21),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(53),
      O => int_ramadr_reg0(21)
    );
\int_ramadr[54]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(22),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(54),
      O => int_ramadr_reg0(22)
    );
\int_ramadr[55]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(23),
      I1 => s_axi_control_WSTRB(2),
      I2 => ramadr(55),
      O => int_ramadr_reg0(23)
    );
\int_ramadr[56]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(24),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(56),
      O => int_ramadr_reg0(24)
    );
\int_ramadr[57]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(25),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(57),
      O => int_ramadr_reg0(25)
    );
\int_ramadr[58]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(26),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(58),
      O => int_ramadr_reg0(26)
    );
\int_ramadr[59]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(27),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(59),
      O => int_ramadr_reg0(27)
    );
\int_ramadr[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(5),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(5),
      O => int_ramadr_reg02_out(5)
    );
\int_ramadr[60]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(28),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(60),
      O => int_ramadr_reg0(28)
    );
\int_ramadr[61]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(29),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(61),
      O => int_ramadr_reg0(29)
    );
\int_ramadr[62]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(30),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(62),
      O => int_ramadr_reg0(30)
    );
\int_ramadr[63]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0800"
    )
        port map (
      I0 => s_axi_control_WVALID,
      I1 => \int_status[31]_i_3_n_0\,
      I2 => \waddr_reg_n_0_[3]\,
      I3 => \^fsm_onehot_wstate_reg[2]_0\,
      O => int_ramadr
    );
\int_ramadr[63]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(31),
      I1 => s_axi_control_WSTRB(3),
      I2 => ramadr(63),
      O => int_ramadr_reg0(31)
    );
\int_ramadr[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(6),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(6),
      O => int_ramadr_reg02_out(6)
    );
\int_ramadr[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(7),
      I1 => s_axi_control_WSTRB(0),
      I2 => ramadr(7),
      O => int_ramadr_reg02_out(7)
    );
\int_ramadr[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(8),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(8),
      O => int_ramadr_reg02_out(8)
    );
\int_ramadr[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(9),
      I1 => s_axi_control_WSTRB(1),
      I2 => ramadr(9),
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
      Q => ramadr(0),
      R => SR(0)
    );
\int_ramadr_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(10),
      Q => ramadr(10),
      R => SR(0)
    );
\int_ramadr_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(11),
      Q => ramadr(11),
      R => SR(0)
    );
\int_ramadr_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(12),
      Q => ramadr(12),
      R => SR(0)
    );
\int_ramadr_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(13),
      Q => ramadr(13),
      R => SR(0)
    );
\int_ramadr_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(14),
      Q => ramadr(14),
      R => SR(0)
    );
\int_ramadr_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(15),
      Q => ramadr(15),
      R => SR(0)
    );
\int_ramadr_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(16),
      Q => ramadr(16),
      R => SR(0)
    );
\int_ramadr_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(17),
      Q => ramadr(17),
      R => SR(0)
    );
\int_ramadr_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(18),
      Q => ramadr(18),
      R => SR(0)
    );
\int_ramadr_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(19),
      Q => ramadr(19),
      R => SR(0)
    );
\int_ramadr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(1),
      Q => ramadr(1),
      R => SR(0)
    );
\int_ramadr_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(20),
      Q => ramadr(20),
      R => SR(0)
    );
\int_ramadr_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(21),
      Q => ramadr(21),
      R => SR(0)
    );
\int_ramadr_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(22),
      Q => ramadr(22),
      R => SR(0)
    );
\int_ramadr_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(23),
      Q => ramadr(23),
      R => SR(0)
    );
\int_ramadr_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(24),
      Q => ramadr(24),
      R => SR(0)
    );
\int_ramadr_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(25),
      Q => ramadr(25),
      R => SR(0)
    );
\int_ramadr_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(26),
      Q => ramadr(26),
      R => SR(0)
    );
\int_ramadr_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(27),
      Q => ramadr(27),
      R => SR(0)
    );
\int_ramadr_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(28),
      Q => ramadr(28),
      R => SR(0)
    );
\int_ramadr_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(29),
      Q => ramadr(29),
      R => SR(0)
    );
\int_ramadr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(2),
      Q => ramadr(2),
      R => SR(0)
    );
\int_ramadr_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(30),
      Q => ramadr(30),
      R => SR(0)
    );
\int_ramadr_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(31),
      Q => ramadr(31),
      R => SR(0)
    );
\int_ramadr_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(0),
      Q => ramadr(32),
      R => SR(0)
    );
\int_ramadr_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(1),
      Q => ramadr(33),
      R => SR(0)
    );
\int_ramadr_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(2),
      Q => ramadr(34),
      R => SR(0)
    );
\int_ramadr_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(3),
      Q => ramadr(35),
      R => SR(0)
    );
\int_ramadr_reg[36]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(4),
      Q => ramadr(36),
      R => SR(0)
    );
\int_ramadr_reg[37]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(5),
      Q => ramadr(37),
      R => SR(0)
    );
\int_ramadr_reg[38]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(6),
      Q => ramadr(38),
      R => SR(0)
    );
\int_ramadr_reg[39]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(7),
      Q => ramadr(39),
      R => SR(0)
    );
\int_ramadr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(3),
      Q => ramadr(3),
      R => SR(0)
    );
\int_ramadr_reg[40]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(8),
      Q => ramadr(40),
      R => SR(0)
    );
\int_ramadr_reg[41]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(9),
      Q => ramadr(41),
      R => SR(0)
    );
\int_ramadr_reg[42]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(10),
      Q => ramadr(42),
      R => SR(0)
    );
\int_ramadr_reg[43]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(11),
      Q => ramadr(43),
      R => SR(0)
    );
\int_ramadr_reg[44]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(12),
      Q => ramadr(44),
      R => SR(0)
    );
\int_ramadr_reg[45]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(13),
      Q => ramadr(45),
      R => SR(0)
    );
\int_ramadr_reg[46]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(14),
      Q => ramadr(46),
      R => SR(0)
    );
\int_ramadr_reg[47]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(15),
      Q => ramadr(47),
      R => SR(0)
    );
\int_ramadr_reg[48]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(16),
      Q => ramadr(48),
      R => SR(0)
    );
\int_ramadr_reg[49]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(17),
      Q => ramadr(49),
      R => SR(0)
    );
\int_ramadr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(4),
      Q => ramadr(4),
      R => SR(0)
    );
\int_ramadr_reg[50]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(18),
      Q => ramadr(50),
      R => SR(0)
    );
\int_ramadr_reg[51]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(19),
      Q => ramadr(51),
      R => SR(0)
    );
\int_ramadr_reg[52]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(20),
      Q => ramadr(52),
      R => SR(0)
    );
\int_ramadr_reg[53]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(21),
      Q => ramadr(53),
      R => SR(0)
    );
\int_ramadr_reg[54]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(22),
      Q => ramadr(54),
      R => SR(0)
    );
\int_ramadr_reg[55]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(23),
      Q => ramadr(55),
      R => SR(0)
    );
\int_ramadr_reg[56]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(24),
      Q => ramadr(56),
      R => SR(0)
    );
\int_ramadr_reg[57]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(25),
      Q => ramadr(57),
      R => SR(0)
    );
\int_ramadr_reg[58]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(26),
      Q => ramadr(58),
      R => SR(0)
    );
\int_ramadr_reg[59]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(27),
      Q => ramadr(59),
      R => SR(0)
    );
\int_ramadr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(5),
      Q => ramadr(5),
      R => SR(0)
    );
\int_ramadr_reg[60]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(28),
      Q => ramadr(60),
      R => SR(0)
    );
\int_ramadr_reg[61]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(29),
      Q => ramadr(61),
      R => SR(0)
    );
\int_ramadr_reg[62]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(30),
      Q => ramadr(62),
      R => SR(0)
    );
\int_ramadr_reg[63]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr,
      D => int_ramadr_reg0(31),
      Q => ramadr(63),
      R => SR(0)
    );
\int_ramadr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(6),
      Q => ramadr(6),
      R => SR(0)
    );
\int_ramadr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(7),
      Q => ramadr(7),
      R => SR(0)
    );
\int_ramadr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(8),
      Q => ramadr(8),
      R => SR(0)
    );
\int_ramadr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_ramadr3_out,
      D => int_ramadr_reg02_out(9),
      Q => ramadr(9),
      R => SR(0)
    );
\int_status[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(0),
      O => int_status0(0)
    );
\int_status[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(10),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(10),
      O => int_status0(10)
    );
\int_status[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(11),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(11),
      O => int_status0(11)
    );
\int_status[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(12),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(12),
      O => int_status0(12)
    );
\int_status[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(13),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(13),
      O => int_status0(13)
    );
\int_status[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(14),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(14),
      O => int_status0(14)
    );
\int_status[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(15),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(15),
      O => int_status0(15)
    );
\int_status[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(16),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(16),
      O => int_status0(16)
    );
\int_status[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(17),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(17),
      O => int_status0(17)
    );
\int_status[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(18),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(18),
      O => int_status0(18)
    );
\int_status[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(19),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(19),
      O => int_status0(19)
    );
\int_status[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(1),
      O => int_status0(1)
    );
\int_status[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(20),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(20),
      O => int_status0(20)
    );
\int_status[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(21),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(21),
      O => int_status0(21)
    );
\int_status[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(22),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(22),
      O => int_status0(22)
    );
\int_status[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(23),
      I1 => s_axi_control_WSTRB(2),
      I2 => \^opeout\(23),
      O => int_status0(23)
    );
\int_status[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(24),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(24),
      O => int_status0(24)
    );
\int_status[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(25),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(25),
      O => int_status0(25)
    );
\int_status[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(26),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(26),
      O => int_status0(26)
    );
\int_status[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(27),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(27),
      O => int_status0(27)
    );
\int_status[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(28),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(28),
      O => int_status0(28)
    );
\int_status[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(29),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(29),
      O => int_status0(29)
    );
\int_status[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(2),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(2),
      O => int_status0(2)
    );
\int_status[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(30),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(30),
      O => int_status0(30)
    );
\int_status[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => s_axi_control_WVALID,
      I1 => \int_status[31]_i_3_n_0\,
      I2 => \waddr_reg_n_0_[3]\,
      I3 => \^fsm_onehot_wstate_reg[2]_0\,
      O => int_status
    );
\int_status[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(31),
      I1 => s_axi_control_WSTRB(3),
      I2 => \^opeout\(31),
      O => int_status0(31)
    );
\int_status[31]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00100000"
    )
        port map (
      I0 => \waddr_reg_n_0_[1]\,
      I1 => \waddr_reg_n_0_[0]\,
      I2 => \waddr_reg_n_0_[4]\,
      I3 => \waddr_reg_n_0_[5]\,
      I4 => \waddr_reg_n_0_[2]\,
      O => \int_status[31]_i_3_n_0\
    );
\int_status[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(3),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(3),
      O => int_status0(3)
    );
\int_status[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(4),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(4),
      O => int_status0(4)
    );
\int_status[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(5),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(5),
      O => int_status0(5)
    );
\int_status[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(6),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(6),
      O => int_status0(6)
    );
\int_status[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(7),
      I1 => s_axi_control_WSTRB(0),
      I2 => \^opeout\(7),
      O => int_status0(7)
    );
\int_status[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(8),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(8),
      O => int_status0(8)
    );
\int_status[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_control_WDATA(9),
      I1 => s_axi_control_WSTRB(1),
      I2 => \^opeout\(9),
      O => int_status0(9)
    );
\int_status_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(0),
      Q => \^opeout\(0),
      R => SR(0)
    );
\int_status_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(10),
      Q => \^opeout\(10),
      R => SR(0)
    );
\int_status_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(11),
      Q => \^opeout\(11),
      R => SR(0)
    );
\int_status_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(12),
      Q => \^opeout\(12),
      R => SR(0)
    );
\int_status_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(13),
      Q => \^opeout\(13),
      R => SR(0)
    );
\int_status_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(14),
      Q => \^opeout\(14),
      R => SR(0)
    );
\int_status_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(15),
      Q => \^opeout\(15),
      R => SR(0)
    );
\int_status_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(16),
      Q => \^opeout\(16),
      R => SR(0)
    );
\int_status_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(17),
      Q => \^opeout\(17),
      R => SR(0)
    );
\int_status_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(18),
      Q => \^opeout\(18),
      R => SR(0)
    );
\int_status_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(19),
      Q => \^opeout\(19),
      R => SR(0)
    );
\int_status_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(1),
      Q => \^opeout\(1),
      R => SR(0)
    );
\int_status_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(20),
      Q => \^opeout\(20),
      R => SR(0)
    );
\int_status_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(21),
      Q => \^opeout\(21),
      R => SR(0)
    );
\int_status_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(22),
      Q => \^opeout\(22),
      R => SR(0)
    );
\int_status_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(23),
      Q => \^opeout\(23),
      R => SR(0)
    );
\int_status_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(24),
      Q => \^opeout\(24),
      R => SR(0)
    );
\int_status_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(25),
      Q => \^opeout\(25),
      R => SR(0)
    );
\int_status_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(26),
      Q => \^opeout\(26),
      R => SR(0)
    );
\int_status_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(27),
      Q => \^opeout\(27),
      R => SR(0)
    );
\int_status_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(28),
      Q => \^opeout\(28),
      R => SR(0)
    );
\int_status_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(29),
      Q => \^opeout\(29),
      R => SR(0)
    );
\int_status_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(2),
      Q => \^opeout\(2),
      R => SR(0)
    );
\int_status_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(30),
      Q => \^opeout\(30),
      R => SR(0)
    );
\int_status_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(31),
      Q => \^opeout\(31),
      R => SR(0)
    );
\int_status_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(3),
      Q => \^opeout\(3),
      R => SR(0)
    );
\int_status_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(4),
      Q => \^opeout\(4),
      R => SR(0)
    );
\int_status_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(5),
      Q => \^opeout\(5),
      R => SR(0)
    );
\int_status_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(6),
      Q => \^opeout\(6),
      R => SR(0)
    );
\int_status_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(7),
      Q => \^opeout\(7),
      R => SR(0)
    );
\int_status_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(8),
      Q => \^opeout\(8),
      R => SR(0)
    );
\int_status_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => int_status,
      D => int_status0(9),
      Q => \^opeout\(9),
      R => SR(0)
    );
\rdata[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(0),
      I1 => ramadr(32),
      I2 => \^opeout\(0),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[0]_i_1_n_0\
    );
\rdata[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(10),
      I1 => ramadr(42),
      I2 => \^opeout\(10),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[10]_i_1_n_0\
    );
\rdata[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(11),
      I1 => ramadr(43),
      I2 => \^opeout\(11),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[11]_i_1_n_0\
    );
\rdata[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(12),
      I1 => ramadr(44),
      I2 => \^opeout\(12),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[12]_i_1_n_0\
    );
\rdata[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(13),
      I1 => ramadr(45),
      I2 => \^opeout\(13),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[13]_i_1_n_0\
    );
\rdata[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(14),
      I1 => ramadr(46),
      I2 => \^opeout\(14),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[14]_i_1_n_0\
    );
\rdata[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(15),
      I1 => ramadr(47),
      I2 => \^opeout\(15),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[15]_i_1_n_0\
    );
\rdata[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(16),
      I1 => ramadr(48),
      I2 => \^opeout\(16),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[16]_i_1_n_0\
    );
\rdata[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(17),
      I1 => ramadr(49),
      I2 => \^opeout\(17),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[17]_i_1_n_0\
    );
\rdata[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(18),
      I1 => ramadr(50),
      I2 => \^opeout\(18),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[18]_i_1_n_0\
    );
\rdata[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(19),
      I1 => ramadr(51),
      I2 => \^opeout\(19),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[19]_i_1_n_0\
    );
\rdata[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(1),
      I1 => ramadr(33),
      I2 => \^opeout\(1),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[1]_i_1_n_0\
    );
\rdata[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(20),
      I1 => ramadr(52),
      I2 => \^opeout\(20),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[20]_i_1_n_0\
    );
\rdata[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(21),
      I1 => ramadr(53),
      I2 => \^opeout\(21),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[21]_i_1_n_0\
    );
\rdata[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(22),
      I1 => ramadr(54),
      I2 => \^opeout\(22),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[22]_i_1_n_0\
    );
\rdata[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(23),
      I1 => ramadr(55),
      I2 => \^opeout\(23),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[23]_i_1_n_0\
    );
\rdata[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(24),
      I1 => ramadr(56),
      I2 => \^opeout\(24),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[24]_i_1_n_0\
    );
\rdata[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(25),
      I1 => ramadr(57),
      I2 => \^opeout\(25),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[25]_i_1_n_0\
    );
\rdata[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(26),
      I1 => ramadr(58),
      I2 => \^opeout\(26),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[26]_i_1_n_0\
    );
\rdata[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(27),
      I1 => ramadr(59),
      I2 => \^opeout\(27),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[27]_i_1_n_0\
    );
\rdata[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(28),
      I1 => ramadr(60),
      I2 => \^opeout\(28),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[28]_i_1_n_0\
    );
\rdata[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(29),
      I1 => ramadr(61),
      I2 => \^opeout\(29),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[29]_i_1_n_0\
    );
\rdata[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(2),
      I1 => ramadr(34),
      I2 => \^opeout\(2),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[2]_i_1_n_0\
    );
\rdata[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(30),
      I1 => ramadr(62),
      I2 => \^opeout\(30),
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
      I0 => ramadr(31),
      I1 => ramadr(63),
      I2 => \^opeout\(31),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[31]_i_3_n_0\
    );
\rdata[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(3),
      I1 => ramadr(35),
      I2 => \^opeout\(3),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[3]_i_1_n_0\
    );
\rdata[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(4),
      I1 => ramadr(36),
      I2 => \^opeout\(4),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[4]_i_1_n_0\
    );
\rdata[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(5),
      I1 => ramadr(37),
      I2 => \^opeout\(5),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[5]_i_1_n_0\
    );
\rdata[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(6),
      I1 => ramadr(38),
      I2 => \^opeout\(6),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[6]_i_1_n_0\
    );
\rdata[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(7),
      I1 => ramadr(39),
      I2 => \^opeout\(7),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[7]_i_1_n_0\
    );
\rdata[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(8),
      I1 => ramadr(40),
      I2 => \^opeout\(8),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(2),
      O => \rdata[8]_i_1_n_0\
    );
\rdata[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0CC00AA"
    )
        port map (
      I0 => ramadr(9),
      I1 => ramadr(41),
      I2 => \^opeout\(9),
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
      I0 => s_axi_control_AWVALID,
      I1 => \^fsm_onehot_wstate_reg[1]_0\,
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
entity \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_buffer__parameterized0\ is
  port (
    full_n_reg_0 : out STD_LOGIC;
    beat_valid : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    dout_valid_reg_0 : out STD_LOGIC;
    S : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 6 downto 0 );
    \mOutPtr_reg[8]_0\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    DI : out STD_LOGIC_VECTOR ( 0 to 0 );
    empty_n_reg_0 : out STD_LOGIC;
    \dout_buf_reg[34]_0\ : out STD_LOGIC_VECTOR ( 32 downto 0 );
    ap_clk : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 32 downto 0 );
    m_axi_gmem_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_RVALID : in STD_LOGIC;
    rdata_ack_t : in STD_LOGIC;
    dout_valid_reg_1 : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    \pout_reg[3]\ : in STD_LOGIC;
    \mOutPtr_reg[8]_1\ : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_buffer__parameterized0\ : entity is "sound_operation_gmem_m_axi_buffer";
end \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_buffer__parameterized0\;

architecture STRUCTURE of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_buffer__parameterized0\ is
  signal \^q\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^beat_valid\ : STD_LOGIC;
  signal \dout_buf[0]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[10]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[11]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[12]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[13]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[14]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[15]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[16]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[17]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[18]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[19]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[1]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[20]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[21]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[22]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[23]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[24]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[25]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[26]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[27]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[28]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[29]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[2]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[30]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[31]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[34]_i_2_n_0\ : STD_LOGIC;
  signal \dout_buf[3]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[4]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[5]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[6]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[7]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[8]_i_1_n_0\ : STD_LOGIC;
  signal \dout_buf[9]_i_1_n_0\ : STD_LOGIC;
  signal \^dout_buf_reg[34]_0\ : STD_LOGIC_VECTOR ( 32 downto 0 );
  signal dout_valid_i_1_n_0 : STD_LOGIC;
  signal empty_n_i_1_n_0 : STD_LOGIC;
  signal empty_n_i_2_n_0 : STD_LOGIC;
  signal empty_n_i_3_n_0 : STD_LOGIC;
  signal empty_n_reg_n_0 : STD_LOGIC;
  signal full_n_i_1_n_0 : STD_LOGIC;
  signal \full_n_i_2__1_n_0\ : STD_LOGIC;
  signal \full_n_i_3__1_n_0\ : STD_LOGIC;
  signal \^full_n_reg_0\ : STD_LOGIC;
  signal \mOutPtr[0]_i_1_n_0\ : STD_LOGIC;
  signal \mOutPtr[8]_i_1_n_0\ : STD_LOGIC;
  signal mOutPtr_reg : STD_LOGIC_VECTOR ( 8 downto 7 );
  signal mem_reg_i_10_n_0 : STD_LOGIC;
  signal mem_reg_i_11_n_0 : STD_LOGIC;
  signal mem_reg_i_12_n_0 : STD_LOGIC;
  signal mem_reg_n_32 : STD_LOGIC;
  signal mem_reg_n_33 : STD_LOGIC;
  signal pop : STD_LOGIC;
  signal push : STD_LOGIC;
  signal q_buf : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal q_tmp : STD_LOGIC_VECTOR ( 34 downto 0 );
  signal raddr : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal rnext : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal show_ahead : STD_LOGIC;
  signal show_ahead0 : STD_LOGIC;
  signal show_ahead1 : STD_LOGIC;
  signal show_ahead1_carry_i_1_n_0 : STD_LOGIC;
  signal show_ahead1_carry_i_2_n_0 : STD_LOGIC;
  signal show_ahead1_carry_i_3_n_0 : STD_LOGIC;
  signal show_ahead1_carry_n_2 : STD_LOGIC;
  signal show_ahead1_carry_n_3 : STD_LOGIC;
  signal waddr : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \waddr[0]_i_1_n_0\ : STD_LOGIC;
  signal \waddr[1]_i_1_n_0\ : STD_LOGIC;
  signal \waddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \waddr[3]_i_1_n_0\ : STD_LOGIC;
  signal \waddr[4]_i_1_n_0\ : STD_LOGIC;
  signal \waddr[5]_i_1__0_n_0\ : STD_LOGIC;
  signal \waddr[6]_i_1_n_0\ : STD_LOGIC;
  signal \waddr[6]_i_2_n_0\ : STD_LOGIC;
  signal \waddr[7]_i_1_n_0\ : STD_LOGIC;
  signal \waddr[8]_i_2_n_0\ : STD_LOGIC;
  signal \waddr[8]_i_3_n_0\ : STD_LOGIC;
  signal \waddr[8]_i_4_n_0\ : STD_LOGIC;
  signal NLW_mem_reg_DOPBDOP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 to 1 );
  signal NLW_show_ahead1_carry_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_show_ahead1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \bus_equal_gen.rdata_valid_t_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \dout_buf[0]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \dout_buf[10]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \dout_buf[11]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \dout_buf[12]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \dout_buf[13]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \dout_buf[14]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \dout_buf[15]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \dout_buf[16]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \dout_buf[17]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \dout_buf[18]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \dout_buf[19]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \dout_buf[1]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \dout_buf[20]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \dout_buf[21]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \dout_buf[22]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \dout_buf[23]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \dout_buf[24]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \dout_buf[25]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \dout_buf[26]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \dout_buf[27]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \dout_buf[28]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \dout_buf[29]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \dout_buf[2]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \dout_buf[30]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \dout_buf[31]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \dout_buf[3]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \dout_buf[4]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \dout_buf[5]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \dout_buf[6]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \dout_buf[7]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \dout_buf[8]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \dout_buf[9]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \full_n_i_2__1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \mOutPtr[0]_i_1\ : label is "soft_lutpair69";
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of mem_reg : label is "p3_d32";
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of mem_reg : label is "p3_d32";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of mem_reg : label is "{SYNTH-6 {cell *THIS*}}";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of mem_reg : label is 17920;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of mem_reg : label is "gmem_m_axi_U/bus_read/buff_rdata/mem";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of mem_reg : label is "RAM_SDP";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of mem_reg : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of mem_reg : label is 511;
  attribute ram_offset : integer;
  attribute ram_offset of mem_reg : label is 0;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of mem_reg : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of mem_reg : label is 34;
  attribute SOFT_HLUTNM of \pout[3]_i_4\ : label is "soft_lutpair50";
  attribute METHODOLOGY_DRC_VIOS of show_ahead1_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \waddr[0]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \waddr[1]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \waddr[2]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \waddr[3]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \waddr[4]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \waddr[6]_i_2\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \waddr[7]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \waddr[8]_i_2\ : label is "soft_lutpair51";
begin
  Q(6 downto 0) <= \^q\(6 downto 0);
  SR(0) <= \^sr\(0);
  beat_valid <= \^beat_valid\;
  \dout_buf_reg[34]_0\(32 downto 0) <= \^dout_buf_reg[34]_0\(32 downto 0);
  full_n_reg_0 <= \^full_n_reg_0\;
\bus_equal_gen.rdata_valid_t_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => \^beat_valid\,
      I1 => rdata_ack_t,
      I2 => dout_valid_reg_1,
      O => dout_valid_reg_0
    );
\could_multi_bursts.araddr_buf[63]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => ap_rst_n,
      O => \^sr\(0)
    );
\dout_buf[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(0),
      I1 => q_buf(0),
      I2 => show_ahead,
      O => \dout_buf[0]_i_1_n_0\
    );
\dout_buf[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(10),
      I1 => q_buf(10),
      I2 => show_ahead,
      O => \dout_buf[10]_i_1_n_0\
    );
\dout_buf[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(11),
      I1 => q_buf(11),
      I2 => show_ahead,
      O => \dout_buf[11]_i_1_n_0\
    );
\dout_buf[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(12),
      I1 => q_buf(12),
      I2 => show_ahead,
      O => \dout_buf[12]_i_1_n_0\
    );
\dout_buf[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(13),
      I1 => q_buf(13),
      I2 => show_ahead,
      O => \dout_buf[13]_i_1_n_0\
    );
\dout_buf[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(14),
      I1 => q_buf(14),
      I2 => show_ahead,
      O => \dout_buf[14]_i_1_n_0\
    );
\dout_buf[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(15),
      I1 => q_buf(15),
      I2 => show_ahead,
      O => \dout_buf[15]_i_1_n_0\
    );
\dout_buf[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(16),
      I1 => q_buf(16),
      I2 => show_ahead,
      O => \dout_buf[16]_i_1_n_0\
    );
\dout_buf[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(17),
      I1 => q_buf(17),
      I2 => show_ahead,
      O => \dout_buf[17]_i_1_n_0\
    );
\dout_buf[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(18),
      I1 => q_buf(18),
      I2 => show_ahead,
      O => \dout_buf[18]_i_1_n_0\
    );
\dout_buf[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(19),
      I1 => q_buf(19),
      I2 => show_ahead,
      O => \dout_buf[19]_i_1_n_0\
    );
\dout_buf[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(1),
      I1 => q_buf(1),
      I2 => show_ahead,
      O => \dout_buf[1]_i_1_n_0\
    );
\dout_buf[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(20),
      I1 => q_buf(20),
      I2 => show_ahead,
      O => \dout_buf[20]_i_1_n_0\
    );
\dout_buf[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(21),
      I1 => q_buf(21),
      I2 => show_ahead,
      O => \dout_buf[21]_i_1_n_0\
    );
\dout_buf[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(22),
      I1 => q_buf(22),
      I2 => show_ahead,
      O => \dout_buf[22]_i_1_n_0\
    );
\dout_buf[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(23),
      I1 => q_buf(23),
      I2 => show_ahead,
      O => \dout_buf[23]_i_1_n_0\
    );
\dout_buf[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(24),
      I1 => q_buf(24),
      I2 => show_ahead,
      O => \dout_buf[24]_i_1_n_0\
    );
\dout_buf[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(25),
      I1 => q_buf(25),
      I2 => show_ahead,
      O => \dout_buf[25]_i_1_n_0\
    );
\dout_buf[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(26),
      I1 => q_buf(26),
      I2 => show_ahead,
      O => \dout_buf[26]_i_1_n_0\
    );
\dout_buf[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(27),
      I1 => q_buf(27),
      I2 => show_ahead,
      O => \dout_buf[27]_i_1_n_0\
    );
\dout_buf[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(28),
      I1 => q_buf(28),
      I2 => show_ahead,
      O => \dout_buf[28]_i_1_n_0\
    );
\dout_buf[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(29),
      I1 => q_buf(29),
      I2 => show_ahead,
      O => \dout_buf[29]_i_1_n_0\
    );
\dout_buf[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(2),
      I1 => q_buf(2),
      I2 => show_ahead,
      O => \dout_buf[2]_i_1_n_0\
    );
\dout_buf[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(30),
      I1 => q_buf(30),
      I2 => show_ahead,
      O => \dout_buf[30]_i_1_n_0\
    );
\dout_buf[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(31),
      I1 => q_buf(31),
      I2 => show_ahead,
      O => \dout_buf[31]_i_1_n_0\
    );
\dout_buf[34]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8AAA"
    )
        port map (
      I0 => empty_n_reg_n_0,
      I1 => rdata_ack_t,
      I2 => dout_valid_reg_1,
      I3 => \^beat_valid\,
      O => pop
    );
\dout_buf[34]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(34),
      I1 => q_buf(34),
      I2 => show_ahead,
      O => \dout_buf[34]_i_2_n_0\
    );
\dout_buf[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(3),
      I1 => q_buf(3),
      I2 => show_ahead,
      O => \dout_buf[3]_i_1_n_0\
    );
\dout_buf[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(4),
      I1 => q_buf(4),
      I2 => show_ahead,
      O => \dout_buf[4]_i_1_n_0\
    );
\dout_buf[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(5),
      I1 => q_buf(5),
      I2 => show_ahead,
      O => \dout_buf[5]_i_1_n_0\
    );
\dout_buf[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(6),
      I1 => q_buf(6),
      I2 => show_ahead,
      O => \dout_buf[6]_i_1_n_0\
    );
\dout_buf[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(7),
      I1 => q_buf(7),
      I2 => show_ahead,
      O => \dout_buf[7]_i_1_n_0\
    );
\dout_buf[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(8),
      I1 => q_buf(8),
      I2 => show_ahead,
      O => \dout_buf[8]_i_1_n_0\
    );
\dout_buf[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => q_tmp(9),
      I1 => q_buf(9),
      I2 => show_ahead,
      O => \dout_buf[9]_i_1_n_0\
    );
\dout_buf_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[0]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(0),
      R => \^sr\(0)
    );
\dout_buf_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[10]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(10),
      R => \^sr\(0)
    );
\dout_buf_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[11]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(11),
      R => \^sr\(0)
    );
\dout_buf_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[12]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(12),
      R => \^sr\(0)
    );
\dout_buf_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[13]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(13),
      R => \^sr\(0)
    );
\dout_buf_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[14]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(14),
      R => \^sr\(0)
    );
\dout_buf_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[15]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(15),
      R => \^sr\(0)
    );
\dout_buf_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[16]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(16),
      R => \^sr\(0)
    );
\dout_buf_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[17]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(17),
      R => \^sr\(0)
    );
\dout_buf_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[18]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(18),
      R => \^sr\(0)
    );
\dout_buf_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[19]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(19),
      R => \^sr\(0)
    );
\dout_buf_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[1]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(1),
      R => \^sr\(0)
    );
\dout_buf_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[20]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(20),
      R => \^sr\(0)
    );
\dout_buf_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[21]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(21),
      R => \^sr\(0)
    );
\dout_buf_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[22]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(22),
      R => \^sr\(0)
    );
\dout_buf_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[23]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(23),
      R => \^sr\(0)
    );
\dout_buf_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[24]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(24),
      R => \^sr\(0)
    );
\dout_buf_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[25]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(25),
      R => \^sr\(0)
    );
\dout_buf_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[26]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(26),
      R => \^sr\(0)
    );
\dout_buf_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[27]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(27),
      R => \^sr\(0)
    );
\dout_buf_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[28]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(28),
      R => \^sr\(0)
    );
\dout_buf_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[29]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(29),
      R => \^sr\(0)
    );
\dout_buf_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[2]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(2),
      R => \^sr\(0)
    );
\dout_buf_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[30]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(30),
      R => \^sr\(0)
    );
\dout_buf_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[31]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(31),
      R => \^sr\(0)
    );
\dout_buf_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[34]_i_2_n_0\,
      Q => \^dout_buf_reg[34]_0\(32),
      R => \^sr\(0)
    );
\dout_buf_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[3]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(3),
      R => \^sr\(0)
    );
\dout_buf_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[4]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(4),
      R => \^sr\(0)
    );
\dout_buf_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[5]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(5),
      R => \^sr\(0)
    );
\dout_buf_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[6]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(6),
      R => \^sr\(0)
    );
\dout_buf_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[7]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(7),
      R => \^sr\(0)
    );
\dout_buf_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[8]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(8),
      R => \^sr\(0)
    );
\dout_buf_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => pop,
      D => \dout_buf[9]_i_1_n_0\,
      Q => \^dout_buf_reg[34]_0\(9),
      R => \^sr\(0)
    );
dout_valid_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BAAA"
    )
        port map (
      I0 => empty_n_reg_n_0,
      I1 => rdata_ack_t,
      I2 => dout_valid_reg_1,
      I3 => \^beat_valid\,
      O => dout_valid_i_1_n_0
    );
dout_valid_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => dout_valid_i_1_n_0,
      Q => \^beat_valid\,
      R => \^sr\(0)
    );
empty_n_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF7F7F7F0F707070"
    )
        port map (
      I0 => empty_n_i_2_n_0,
      I1 => empty_n_i_3_n_0,
      I2 => pop,
      I3 => m_axi_gmem_RVALID,
      I4 => \^full_n_reg_0\,
      I5 => empty_n_reg_n_0,
      O => empty_n_i_1_n_0
    );
empty_n_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000100"
    )
        port map (
      I0 => \^q\(5),
      I1 => \^q\(3),
      I2 => \^q\(4),
      I3 => \^q\(0),
      I4 => \^q\(2),
      I5 => \^q\(1),
      O => empty_n_i_2_n_0
    );
empty_n_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^q\(6),
      I1 => mOutPtr_reg(7),
      I2 => mOutPtr_reg(8),
      O => empty_n_i_3_n_0
    );
empty_n_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => empty_n_i_1_n_0,
      Q => empty_n_reg_n_0,
      R => \^sr\(0)
    );
full_n_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFD55FF55"
    )
        port map (
      I0 => ap_rst_n,
      I1 => \full_n_i_2__1_n_0\,
      I2 => \full_n_i_3__1_n_0\,
      I3 => \^full_n_reg_0\,
      I4 => m_axi_gmem_RVALID,
      I5 => pop,
      O => full_n_i_1_n_0
    );
\full_n_i_2__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(0),
      I2 => \^q\(4),
      O => \full_n_i_2__1_n_0\
    );
\full_n_i_3__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => mOutPtr_reg(7),
      I1 => mOutPtr_reg(8),
      I2 => \^q\(2),
      I3 => \^q\(6),
      I4 => \^q\(1),
      I5 => \^q\(5),
      O => \full_n_i_3__1_n_0\
    );
full_n_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => full_n_i_1_n_0,
      Q => \^full_n_reg_0\,
      R => '0'
    );
\mOutPtr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \mOutPtr[0]_i_1_n_0\
    );
\mOutPtr[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08FFF700F700F700"
    )
        port map (
      I0 => \^beat_valid\,
      I1 => dout_valid_reg_1,
      I2 => rdata_ack_t,
      I3 => empty_n_reg_n_0,
      I4 => \^full_n_reg_0\,
      I5 => m_axi_gmem_RVALID,
      O => \mOutPtr[8]_i_1_n_0\
    );
\mOutPtr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr[0]_i_1_n_0\,
      Q => \^q\(0),
      R => \^sr\(0)
    );
\mOutPtr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(0),
      Q => \^q\(1),
      R => \^sr\(0)
    );
\mOutPtr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(1),
      Q => \^q\(2),
      R => \^sr\(0)
    );
\mOutPtr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(2),
      Q => \^q\(3),
      R => \^sr\(0)
    );
\mOutPtr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(3),
      Q => \^q\(4),
      R => \^sr\(0)
    );
\mOutPtr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(4),
      Q => \^q\(5),
      R => \^sr\(0)
    );
\mOutPtr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(5),
      Q => \^q\(6),
      R => \^sr\(0)
    );
\mOutPtr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(6),
      Q => mOutPtr_reg(7),
      R => \^sr\(0)
    );
\mOutPtr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => \mOutPtr[8]_i_1_n_0\,
      D => \mOutPtr_reg[8]_1\(7),
      Q => mOutPtr_reg(8),
      R => \^sr\(0)
    );
mem_reg: unisim.vcomponents.RAMB18E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_A => X"00000",
      INIT_B => X"00000",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 0,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"00000",
      SRVAL_B => X"00000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(13 downto 5) => rnext(8 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(13 downto 5) => waddr(8 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CLKARDCLK => ap_clk,
      CLKBWRCLK => ap_clk,
      DIADI(15 downto 0) => D(15 downto 0),
      DIBDI(15 downto 0) => D(31 downto 16),
      DIPADIP(1 downto 0) => m_axi_gmem_RRESP(1 downto 0),
      DIPBDIP(1) => '1',
      DIPBDIP(0) => D(32),
      DOADO(15 downto 0) => q_buf(15 downto 0),
      DOBDO(15 downto 0) => q_buf(31 downto 16),
      DOPADOP(1) => mem_reg_n_32,
      DOPADOP(0) => mem_reg_n_33,
      DOPBDOP(1) => NLW_mem_reg_DOPBDOP_UNCONNECTED(1),
      DOPBDOP(0) => q_buf(34),
      ENARDEN => '1',
      ENBWREN => \^full_n_reg_0\,
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      WEA(1 downto 0) => B"00",
      WEBWE(3) => m_axi_gmem_RVALID,
      WEBWE(2) => m_axi_gmem_RVALID,
      WEBWE(1) => m_axi_gmem_RVALID,
      WEBWE(0) => m_axi_gmem_RVALID
    );
mem_reg_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => raddr(8),
      I1 => raddr(7),
      I2 => mem_reg_i_10_n_0,
      O => rnext(8)
    );
mem_reg_i_10: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F7000000"
    )
        port map (
      I0 => \^beat_valid\,
      I1 => dout_valid_reg_1,
      I2 => rdata_ack_t,
      I3 => empty_n_reg_n_0,
      I4 => raddr(6),
      I5 => mem_reg_i_11_n_0,
      O => mem_reg_i_10_n_0
    );
mem_reg_i_11: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => raddr(4),
      I1 => raddr(2),
      I2 => raddr(0),
      I3 => raddr(1),
      I4 => raddr(3),
      I5 => raddr(5),
      O => mem_reg_i_11_n_0
    );
mem_reg_i_12: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => raddr(3),
      I1 => raddr(1),
      I2 => raddr(0),
      I3 => raddr(2),
      I4 => raddr(4),
      O => mem_reg_i_12_n_0
    );
mem_reg_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => raddr(7),
      I1 => mem_reg_i_10_n_0,
      O => rnext(7)
    );
mem_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9CCC9C9C9C9C9C9C"
    )
        port map (
      I0 => mem_reg_i_11_n_0,
      I1 => raddr(6),
      I2 => empty_n_reg_n_0,
      I3 => rdata_ack_t,
      I4 => dout_valid_reg_1,
      I5 => \^beat_valid\,
      O => rnext(6)
    );
mem_reg_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9AAA9A9A9A9A9A9A"
    )
        port map (
      I0 => raddr(5),
      I1 => mem_reg_i_12_n_0,
      I2 => empty_n_reg_n_0,
      I3 => rdata_ack_t,
      I4 => dout_valid_reg_1,
      I5 => \^beat_valid\,
      O => rnext(5)
    );
mem_reg_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFF8000FFFF0000"
    )
        port map (
      I0 => raddr(3),
      I1 => raddr(1),
      I2 => raddr(0),
      I3 => raddr(2),
      I4 => raddr(4),
      I5 => pop,
      O => rnext(4)
    );
mem_reg_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => raddr(3),
      I1 => raddr(1),
      I2 => raddr(0),
      I3 => raddr(2),
      I4 => pop,
      O => rnext(3)
    );
mem_reg_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => raddr(2),
      I1 => raddr(0),
      I2 => raddr(1),
      I3 => pop,
      O => rnext(2)
    );
mem_reg_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6CCC6C6C6C6C6C6C"
    )
        port map (
      I0 => raddr(0),
      I1 => raddr(1),
      I2 => empty_n_reg_n_0,
      I3 => rdata_ack_t,
      I4 => dout_valid_reg_1,
      I5 => \^beat_valid\,
      O => rnext(1)
    );
mem_reg_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFFF7FF0000"
    )
        port map (
      I0 => raddr(8),
      I1 => raddr(7),
      I2 => mem_reg_i_11_n_0,
      I3 => raddr(6),
      I4 => pop,
      I5 => raddr(0),
      O => rnext(0)
    );
\p_0_out_carry__0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => mOutPtr_reg(8),
      I1 => mOutPtr_reg(7),
      O => \mOutPtr_reg[8]_0\(3)
    );
\p_0_out_carry__0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(6),
      I1 => mOutPtr_reg(7),
      O => \mOutPtr_reg[8]_0\(2)
    );
\p_0_out_carry__0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(5),
      I1 => \^q\(6),
      O => \mOutPtr_reg[8]_0\(1)
    );
\p_0_out_carry__0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(4),
      I1 => \^q\(5),
      O => \mOutPtr_reg[8]_0\(0)
    );
p_0_out_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000800088888888"
    )
        port map (
      I0 => \^full_n_reg_0\,
      I1 => m_axi_gmem_RVALID,
      I2 => \^beat_valid\,
      I3 => dout_valid_reg_1,
      I4 => rdata_ack_t,
      I5 => empty_n_reg_n_0,
      O => DI(0)
    );
p_0_out_carry_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(4),
      O => S(3)
    );
p_0_out_carry_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(3),
      O => S(2)
    );
p_0_out_carry_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(2),
      O => S(1)
    );
p_0_out_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6555"
    )
        port map (
      I0 => \^q\(1),
      I1 => pop,
      I2 => m_axi_gmem_RVALID,
      I3 => \^full_n_reg_0\,
      O => S(0)
    );
\pout[3]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"22A2AAAA"
    )
        port map (
      I0 => \pout_reg[3]\,
      I1 => \^beat_valid\,
      I2 => dout_valid_reg_1,
      I3 => rdata_ack_t,
      I4 => \^dout_buf_reg[34]_0\(32),
      O => empty_n_reg_0
    );
\q_tmp_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(0),
      Q => q_tmp(0),
      R => \^sr\(0)
    );
\q_tmp_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(10),
      Q => q_tmp(10),
      R => \^sr\(0)
    );
\q_tmp_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(11),
      Q => q_tmp(11),
      R => \^sr\(0)
    );
\q_tmp_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(12),
      Q => q_tmp(12),
      R => \^sr\(0)
    );
\q_tmp_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(13),
      Q => q_tmp(13),
      R => \^sr\(0)
    );
\q_tmp_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(14),
      Q => q_tmp(14),
      R => \^sr\(0)
    );
\q_tmp_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(15),
      Q => q_tmp(15),
      R => \^sr\(0)
    );
\q_tmp_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(16),
      Q => q_tmp(16),
      R => \^sr\(0)
    );
\q_tmp_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(17),
      Q => q_tmp(17),
      R => \^sr\(0)
    );
\q_tmp_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(18),
      Q => q_tmp(18),
      R => \^sr\(0)
    );
\q_tmp_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(19),
      Q => q_tmp(19),
      R => \^sr\(0)
    );
\q_tmp_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(1),
      Q => q_tmp(1),
      R => \^sr\(0)
    );
\q_tmp_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(20),
      Q => q_tmp(20),
      R => \^sr\(0)
    );
\q_tmp_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(21),
      Q => q_tmp(21),
      R => \^sr\(0)
    );
\q_tmp_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(22),
      Q => q_tmp(22),
      R => \^sr\(0)
    );
\q_tmp_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(23),
      Q => q_tmp(23),
      R => \^sr\(0)
    );
\q_tmp_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(24),
      Q => q_tmp(24),
      R => \^sr\(0)
    );
\q_tmp_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(25),
      Q => q_tmp(25),
      R => \^sr\(0)
    );
\q_tmp_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(26),
      Q => q_tmp(26),
      R => \^sr\(0)
    );
\q_tmp_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(27),
      Q => q_tmp(27),
      R => \^sr\(0)
    );
\q_tmp_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(28),
      Q => q_tmp(28),
      R => \^sr\(0)
    );
\q_tmp_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(29),
      Q => q_tmp(29),
      R => \^sr\(0)
    );
\q_tmp_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(2),
      Q => q_tmp(2),
      R => \^sr\(0)
    );
\q_tmp_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(30),
      Q => q_tmp(30),
      R => \^sr\(0)
    );
\q_tmp_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(31),
      Q => q_tmp(31),
      R => \^sr\(0)
    );
\q_tmp_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(32),
      Q => q_tmp(34),
      R => \^sr\(0)
    );
\q_tmp_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(3),
      Q => q_tmp(3),
      R => \^sr\(0)
    );
\q_tmp_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(4),
      Q => q_tmp(4),
      R => \^sr\(0)
    );
\q_tmp_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(5),
      Q => q_tmp(5),
      R => \^sr\(0)
    );
\q_tmp_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(6),
      Q => q_tmp(6),
      R => \^sr\(0)
    );
\q_tmp_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(7),
      Q => q_tmp(7),
      R => \^sr\(0)
    );
\q_tmp_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(8),
      Q => q_tmp(8),
      R => \^sr\(0)
    );
\q_tmp_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => D(9),
      Q => q_tmp(9),
      R => \^sr\(0)
    );
\raddr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(0),
      Q => raddr(0),
      R => \^sr\(0)
    );
\raddr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(1),
      Q => raddr(1),
      R => \^sr\(0)
    );
\raddr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(2),
      Q => raddr(2),
      R => \^sr\(0)
    );
\raddr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(3),
      Q => raddr(3),
      R => \^sr\(0)
    );
\raddr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(4),
      Q => raddr(4),
      R => \^sr\(0)
    );
\raddr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(5),
      Q => raddr(5),
      R => \^sr\(0)
    );
\raddr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(6),
      Q => raddr(6),
      R => \^sr\(0)
    );
\raddr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(7),
      Q => raddr(7),
      R => \^sr\(0)
    );
\raddr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => rnext(8),
      Q => raddr(8),
      R => \^sr\(0)
    );
show_ahead1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => NLW_show_ahead1_carry_CO_UNCONNECTED(3),
      CO(2) => show_ahead1,
      CO(1) => show_ahead1_carry_n_2,
      CO(0) => show_ahead1_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_show_ahead1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => '0',
      S(2) => show_ahead1_carry_i_1_n_0,
      S(1) => show_ahead1_carry_i_2_n_0,
      S(0) => show_ahead1_carry_i_3_n_0
    );
show_ahead1_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^q\(6),
      I1 => mOutPtr_reg(7),
      I2 => mOutPtr_reg(8),
      O => show_ahead1_carry_i_1_n_0
    );
show_ahead1_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^q\(4),
      I1 => \^q\(3),
      I2 => \^q\(5),
      O => show_ahead1_carry_i_2_n_0
    );
show_ahead1_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1001"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(2),
      I2 => pop,
      I3 => \^q\(0),
      O => show_ahead1_carry_i_3_n_0
    );
show_ahead_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => show_ahead1,
      I1 => \^full_n_reg_0\,
      I2 => m_axi_gmem_RVALID,
      O => show_ahead0
    );
show_ahead_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => show_ahead0,
      Q => show_ahead,
      R => \^sr\(0)
    );
\waddr[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => waddr(0),
      O => \waddr[0]_i_1_n_0\
    );
\waddr[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => waddr(0),
      I1 => waddr(1),
      O => \waddr[1]_i_1_n_0\
    );
\waddr[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => waddr(2),
      I1 => waddr(0),
      I2 => waddr(1),
      O => \waddr[2]_i_1_n_0\
    );
\waddr[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => waddr(3),
      I1 => waddr(0),
      I2 => waddr(1),
      I3 => waddr(2),
      O => \waddr[3]_i_1_n_0\
    );
\waddr[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => waddr(4),
      I1 => waddr(2),
      I2 => waddr(1),
      I3 => waddr(0),
      I4 => waddr(3),
      O => \waddr[4]_i_1_n_0\
    );
\waddr[5]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => waddr(5),
      I1 => waddr(3),
      I2 => waddr(0),
      I3 => waddr(1),
      I4 => waddr(2),
      I5 => waddr(4),
      O => \waddr[5]_i_1__0_n_0\
    );
\waddr[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => waddr(6),
      I1 => waddr(4),
      I2 => waddr(2),
      I3 => \waddr[6]_i_2_n_0\,
      I4 => waddr(3),
      I5 => waddr(5),
      O => \waddr[6]_i_1_n_0\
    );
\waddr[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => waddr(1),
      I1 => waddr(0),
      O => \waddr[6]_i_2_n_0\
    );
\waddr[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"B8CC"
    )
        port map (
      I0 => \waddr[8]_i_3_n_0\,
      I1 => waddr(7),
      I2 => \waddr[8]_i_4_n_0\,
      I3 => waddr(6),
      O => \waddr[7]_i_1_n_0\
    );
\waddr[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => m_axi_gmem_RVALID,
      I1 => \^full_n_reg_0\,
      O => push
    );
\waddr[8]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BC8CCCCC"
    )
        port map (
      I0 => \waddr[8]_i_3_n_0\,
      I1 => waddr(8),
      I2 => waddr(6),
      I3 => \waddr[8]_i_4_n_0\,
      I4 => waddr(7),
      O => \waddr[8]_i_2_n_0\
    );
\waddr[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => waddr(4),
      I1 => waddr(2),
      I2 => waddr(0),
      I3 => waddr(1),
      I4 => waddr(3),
      I5 => waddr(5),
      O => \waddr[8]_i_3_n_0\
    );
\waddr[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => waddr(4),
      I1 => waddr(2),
      I2 => waddr(1),
      I3 => waddr(0),
      I4 => waddr(3),
      I5 => waddr(5),
      O => \waddr[8]_i_4_n_0\
    );
\waddr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[0]_i_1_n_0\,
      Q => waddr(0),
      R => \^sr\(0)
    );
\waddr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[1]_i_1_n_0\,
      Q => waddr(1),
      R => \^sr\(0)
    );
\waddr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[2]_i_1_n_0\,
      Q => waddr(2),
      R => \^sr\(0)
    );
\waddr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[3]_i_1_n_0\,
      Q => waddr(3),
      R => \^sr\(0)
    );
\waddr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[4]_i_1_n_0\,
      Q => waddr(4),
      R => \^sr\(0)
    );
\waddr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[5]_i_1__0_n_0\,
      Q => waddr(5),
      R => \^sr\(0)
    );
\waddr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[6]_i_1_n_0\,
      Q => waddr(6),
      R => \^sr\(0)
    );
\waddr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[7]_i_1_n_0\,
      Q => waddr(7),
      R => \^sr\(0)
    );
\waddr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => push,
      D => \waddr[8]_i_2_n_0\,
      Q => waddr(8),
      R => \^sr\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized0\ is
  port (
    fifo_rreq_valid : out STD_LOGIC;
    rs2f_rreq_ack : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 51 downto 0 );
    next_rreq : out STD_LOGIC;
    \sect_len_buf_reg[7]\ : out STD_LOGIC;
    \sect_len_buf_reg[6]\ : out STD_LOGIC;
    S : out STD_LOGIC_VECTOR ( 0 to 0 );
    \q_reg[64]_0\ : out STD_LOGIC_VECTOR ( 62 downto 0 );
    invalid_len_event0 : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    ap_clk : in STD_LOGIC;
    push : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    p_21_in : in STD_LOGIC;
    CO : in STD_LOGIC_VECTOR ( 0 to 0 );
    full_n_reg_0 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    \sect_cnt_reg[51]\ : in STD_LOGIC_VECTOR ( 51 downto 0 );
    sect_cnt0 : in STD_LOGIC_VECTOR ( 50 downto 0 );
    fifo_rreq_valid_buf_reg : in STD_LOGIC;
    \sect_len_buf_reg[7]_0\ : in STD_LOGIC_VECTOR ( 4 downto 0 );
    \sect_len_buf_reg[7]_1\ : in STD_LOGIC_VECTOR ( 4 downto 0 );
    \q_reg[61]_0\ : in STD_LOGIC_VECTOR ( 61 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized0\ : entity is "sound_operation_gmem_m_axi_fifo";
end \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized0\;

architecture STRUCTURE of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized0\ is
  signal data_vld_i_1_n_0 : STD_LOGIC;
  signal data_vld_reg_n_0 : STD_LOGIC;
  signal \^fifo_rreq_valid\ : STD_LOGIC;
  signal fifo_rreq_valid_buf_i_2_n_0 : STD_LOGIC;
  signal \full_n_i_1__0_n_0\ : STD_LOGIC;
  signal full_n_i_2_n_0 : STD_LOGIC;
  signal full_n_i_3_n_0 : STD_LOGIC;
  signal \mem_reg[4][0]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][10]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][11]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][12]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][13]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][14]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][15]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][16]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][17]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][18]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][19]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][1]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][20]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][21]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][22]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][23]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][24]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][25]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][26]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][27]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][28]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][29]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][2]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][30]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][31]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][32]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][33]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][34]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][35]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][36]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][37]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][38]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][39]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][3]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][40]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][41]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][42]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][43]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][44]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][45]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][46]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][47]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][48]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][49]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][4]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][50]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][51]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][52]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][53]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][54]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][55]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][56]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][57]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][58]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][59]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][5]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][60]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][61]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][64]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][6]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][7]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][8]_srl5_n_0\ : STD_LOGIC;
  signal \mem_reg[4][9]_srl5_n_0\ : STD_LOGIC;
  signal \pout[0]_i_1_n_0\ : STD_LOGIC;
  signal \pout[0]_i_2_n_0\ : STD_LOGIC;
  signal \pout[1]_i_1_n_0\ : STD_LOGIC;
  signal \pout[2]_i_1_n_0\ : STD_LOGIC;
  signal \pout[2]_i_2_n_0\ : STD_LOGIC;
  signal \pout_reg_n_0_[0]\ : STD_LOGIC;
  signal \pout_reg_n_0_[1]\ : STD_LOGIC;
  signal \pout_reg_n_0_[2]\ : STD_LOGIC;
  signal \^q_reg[64]_0\ : STD_LOGIC_VECTOR ( 62 downto 0 );
  signal \^rs2f_rreq_ack\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of fifo_rreq_valid_buf_i_1 : label is "soft_lutpair79";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \mem_reg[4][0]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name : string;
  attribute srl_name of \mem_reg[4][0]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][0]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][10]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][10]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][10]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][11]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][11]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][11]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][12]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][12]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][12]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][13]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][13]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][13]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][14]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][14]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][14]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][15]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][15]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][15]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][16]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][16]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][16]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][17]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][17]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][17]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][18]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][18]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][18]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][19]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][19]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][19]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][1]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][1]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][1]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][20]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][20]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][20]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][21]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][21]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][21]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][22]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][22]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][22]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][23]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][23]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][23]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][24]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][24]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][24]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][25]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][25]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][25]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][26]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][26]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][26]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][27]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][27]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][27]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][28]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][28]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][28]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][29]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][29]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][29]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][2]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][2]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][2]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][30]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][30]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][30]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][31]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][31]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][31]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][32]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][32]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][32]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][33]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][33]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][33]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][34]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][34]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][34]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][35]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][35]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][35]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][36]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][36]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][36]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][37]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][37]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][37]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][38]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][38]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][38]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][39]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][39]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][39]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][3]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][3]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][3]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][40]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][40]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][40]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][41]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][41]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][41]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][42]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][42]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][42]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][43]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][43]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][43]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][44]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][44]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][44]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][45]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][45]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][45]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][46]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][46]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][46]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][47]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][47]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][47]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][48]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][48]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][48]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][49]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][49]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][49]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][4]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][4]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][4]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][50]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][50]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][50]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][51]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][51]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][51]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][52]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][52]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][52]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][53]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][53]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][53]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][54]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][54]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][54]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][55]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][55]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][55]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][56]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][56]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][56]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][57]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][57]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][57]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][58]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][58]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][58]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][59]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][59]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][59]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][5]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][5]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][5]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][60]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][60]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][60]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][61]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][61]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][61]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][64]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][64]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][64]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][6]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][6]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][6]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][7]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][7]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][7]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][8]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][8]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][8]_srl5 ";
  attribute srl_bus_name of \mem_reg[4][9]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4] ";
  attribute srl_name of \mem_reg[4][9]_srl5\ : label is "inst/\gmem_m_axi_U/bus_read/fifo_rreq/mem_reg[4][9]_srl5 ";
  attribute SOFT_HLUTNM of \pout[0]_i_2\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \pout[2]_i_2\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \sect_cnt[0]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \sect_cnt[10]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \sect_cnt[11]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \sect_cnt[12]_i_1\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \sect_cnt[13]_i_1\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \sect_cnt[14]_i_1\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \sect_cnt[15]_i_1\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \sect_cnt[16]_i_1\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \sect_cnt[17]_i_1\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \sect_cnt[18]_i_1\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \sect_cnt[19]_i_1\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \sect_cnt[1]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \sect_cnt[20]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \sect_cnt[21]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \sect_cnt[22]_i_1\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \sect_cnt[23]_i_1\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \sect_cnt[24]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \sect_cnt[25]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \sect_cnt[26]_i_1\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \sect_cnt[27]_i_1\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \sect_cnt[28]_i_1\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \sect_cnt[29]_i_1\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \sect_cnt[2]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \sect_cnt[30]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \sect_cnt[31]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \sect_cnt[32]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \sect_cnt[33]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \sect_cnt[34]_i_1\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \sect_cnt[35]_i_1\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \sect_cnt[36]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \sect_cnt[37]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \sect_cnt[38]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \sect_cnt[3]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \sect_cnt[40]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \sect_cnt[41]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \sect_cnt[42]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \sect_cnt[43]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \sect_cnt[44]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \sect_cnt[45]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \sect_cnt[46]_i_1\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \sect_cnt[47]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \sect_cnt[48]_i_1\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \sect_cnt[49]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \sect_cnt[4]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \sect_cnt[50]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \sect_cnt[51]_i_2\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \sect_cnt[5]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \sect_cnt[6]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \sect_cnt[7]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \sect_cnt[8]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \sect_cnt[9]_i_1\ : label is "soft_lutpair90";
begin
  fifo_rreq_valid <= \^fifo_rreq_valid\;
  \q_reg[64]_0\(62 downto 0) <= \^q_reg[64]_0\(62 downto 0);
  rs2f_rreq_ack <= \^rs2f_rreq_ack\;
align_len0_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q_reg[64]_0\(62),
      O => S(0)
    );
data_vld_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEFFFFAAAAAAAA"
    )
        port map (
      I0 => push,
      I1 => \pout_reg_n_0_[2]\,
      I2 => \pout_reg_n_0_[1]\,
      I3 => \pout_reg_n_0_[0]\,
      I4 => \pout[0]_i_2_n_0\,
      I5 => data_vld_reg_n_0,
      O => data_vld_i_1_n_0
    );
data_vld_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => data_vld_i_1_n_0,
      Q => data_vld_reg_n_0,
      R => SR(0)
    );
empty_n_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => data_vld_reg_n_0,
      Q => \^fifo_rreq_valid\,
      R => SR(0)
    );
fifo_rreq_valid_buf_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => fifo_rreq_valid_buf_i_2_n_0,
      O => next_rreq
    );
fifo_rreq_valid_buf_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"11F1F1F1"
    )
        port map (
      I0 => \^fifo_rreq_valid\,
      I1 => fifo_rreq_valid_buf_reg,
      I2 => full_n_reg_0,
      I3 => CO(0),
      I4 => p_21_in,
      O => fifo_rreq_valid_buf_i_2_n_0
    );
\full_n_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFBFBFBFBFBFBBB"
    )
        port map (
      I0 => \pout[0]_i_2_n_0\,
      I1 => ap_rst_n,
      I2 => \^rs2f_rreq_ack\,
      I3 => full_n_i_2_n_0,
      I4 => full_n_i_3_n_0,
      I5 => \pout_reg_n_0_[2]\,
      O => \full_n_i_1__0_n_0\
    );
full_n_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8FFFFFFFFFFFFFFF"
    )
        port map (
      I0 => p_21_in,
      I1 => CO(0),
      I2 => full_n_reg_0,
      I3 => \^fifo_rreq_valid\,
      I4 => push,
      I5 => data_vld_reg_n_0,
      O => full_n_i_2_n_0
    );
full_n_i_3: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \pout_reg_n_0_[0]\,
      I1 => \pout_reg_n_0_[1]\,
      O => full_n_i_3_n_0
    );
full_n_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \full_n_i_1__0_n_0\,
      Q => \^rs2f_rreq_ack\,
      R => '0'
    );
invalid_len_event_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^fifo_rreq_valid\,
      I1 => \^q_reg[64]_0\(62),
      O => invalid_len_event0
    );
\mem_reg[4][0]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(0),
      Q => \mem_reg[4][0]_srl5_n_0\
    );
\mem_reg[4][10]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(10),
      Q => \mem_reg[4][10]_srl5_n_0\
    );
\mem_reg[4][11]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(11),
      Q => \mem_reg[4][11]_srl5_n_0\
    );
\mem_reg[4][12]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(12),
      Q => \mem_reg[4][12]_srl5_n_0\
    );
\mem_reg[4][13]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(13),
      Q => \mem_reg[4][13]_srl5_n_0\
    );
\mem_reg[4][14]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(14),
      Q => \mem_reg[4][14]_srl5_n_0\
    );
\mem_reg[4][15]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(15),
      Q => \mem_reg[4][15]_srl5_n_0\
    );
\mem_reg[4][16]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(16),
      Q => \mem_reg[4][16]_srl5_n_0\
    );
\mem_reg[4][17]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(17),
      Q => \mem_reg[4][17]_srl5_n_0\
    );
\mem_reg[4][18]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(18),
      Q => \mem_reg[4][18]_srl5_n_0\
    );
\mem_reg[4][19]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(19),
      Q => \mem_reg[4][19]_srl5_n_0\
    );
\mem_reg[4][1]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(1),
      Q => \mem_reg[4][1]_srl5_n_0\
    );
\mem_reg[4][20]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(20),
      Q => \mem_reg[4][20]_srl5_n_0\
    );
\mem_reg[4][21]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(21),
      Q => \mem_reg[4][21]_srl5_n_0\
    );
\mem_reg[4][22]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(22),
      Q => \mem_reg[4][22]_srl5_n_0\
    );
\mem_reg[4][23]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(23),
      Q => \mem_reg[4][23]_srl5_n_0\
    );
\mem_reg[4][24]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(24),
      Q => \mem_reg[4][24]_srl5_n_0\
    );
\mem_reg[4][25]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(25),
      Q => \mem_reg[4][25]_srl5_n_0\
    );
\mem_reg[4][26]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(26),
      Q => \mem_reg[4][26]_srl5_n_0\
    );
\mem_reg[4][27]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(27),
      Q => \mem_reg[4][27]_srl5_n_0\
    );
\mem_reg[4][28]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(28),
      Q => \mem_reg[4][28]_srl5_n_0\
    );
\mem_reg[4][29]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(29),
      Q => \mem_reg[4][29]_srl5_n_0\
    );
\mem_reg[4][2]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(2),
      Q => \mem_reg[4][2]_srl5_n_0\
    );
\mem_reg[4][30]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(30),
      Q => \mem_reg[4][30]_srl5_n_0\
    );
\mem_reg[4][31]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(31),
      Q => \mem_reg[4][31]_srl5_n_0\
    );
\mem_reg[4][32]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(32),
      Q => \mem_reg[4][32]_srl5_n_0\
    );
\mem_reg[4][33]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(33),
      Q => \mem_reg[4][33]_srl5_n_0\
    );
\mem_reg[4][34]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(34),
      Q => \mem_reg[4][34]_srl5_n_0\
    );
\mem_reg[4][35]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(35),
      Q => \mem_reg[4][35]_srl5_n_0\
    );
\mem_reg[4][36]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(36),
      Q => \mem_reg[4][36]_srl5_n_0\
    );
\mem_reg[4][37]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(37),
      Q => \mem_reg[4][37]_srl5_n_0\
    );
\mem_reg[4][38]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(38),
      Q => \mem_reg[4][38]_srl5_n_0\
    );
\mem_reg[4][39]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(39),
      Q => \mem_reg[4][39]_srl5_n_0\
    );
\mem_reg[4][3]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(3),
      Q => \mem_reg[4][3]_srl5_n_0\
    );
\mem_reg[4][40]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(40),
      Q => \mem_reg[4][40]_srl5_n_0\
    );
\mem_reg[4][41]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(41),
      Q => \mem_reg[4][41]_srl5_n_0\
    );
\mem_reg[4][42]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(42),
      Q => \mem_reg[4][42]_srl5_n_0\
    );
\mem_reg[4][43]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(43),
      Q => \mem_reg[4][43]_srl5_n_0\
    );
\mem_reg[4][44]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(44),
      Q => \mem_reg[4][44]_srl5_n_0\
    );
\mem_reg[4][45]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(45),
      Q => \mem_reg[4][45]_srl5_n_0\
    );
\mem_reg[4][46]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(46),
      Q => \mem_reg[4][46]_srl5_n_0\
    );
\mem_reg[4][47]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(47),
      Q => \mem_reg[4][47]_srl5_n_0\
    );
\mem_reg[4][48]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(48),
      Q => \mem_reg[4][48]_srl5_n_0\
    );
\mem_reg[4][49]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(49),
      Q => \mem_reg[4][49]_srl5_n_0\
    );
\mem_reg[4][4]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(4),
      Q => \mem_reg[4][4]_srl5_n_0\
    );
\mem_reg[4][50]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(50),
      Q => \mem_reg[4][50]_srl5_n_0\
    );
\mem_reg[4][51]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(51),
      Q => \mem_reg[4][51]_srl5_n_0\
    );
\mem_reg[4][52]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(52),
      Q => \mem_reg[4][52]_srl5_n_0\
    );
\mem_reg[4][53]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(53),
      Q => \mem_reg[4][53]_srl5_n_0\
    );
\mem_reg[4][54]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(54),
      Q => \mem_reg[4][54]_srl5_n_0\
    );
\mem_reg[4][55]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(55),
      Q => \mem_reg[4][55]_srl5_n_0\
    );
\mem_reg[4][56]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(56),
      Q => \mem_reg[4][56]_srl5_n_0\
    );
\mem_reg[4][57]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(57),
      Q => \mem_reg[4][57]_srl5_n_0\
    );
\mem_reg[4][58]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(58),
      Q => \mem_reg[4][58]_srl5_n_0\
    );
\mem_reg[4][59]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(59),
      Q => \mem_reg[4][59]_srl5_n_0\
    );
\mem_reg[4][5]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(5),
      Q => \mem_reg[4][5]_srl5_n_0\
    );
\mem_reg[4][60]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(60),
      Q => \mem_reg[4][60]_srl5_n_0\
    );
\mem_reg[4][61]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(61),
      Q => \mem_reg[4][61]_srl5_n_0\
    );
\mem_reg[4][64]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => '1',
      Q => \mem_reg[4][64]_srl5_n_0\
    );
\mem_reg[4][6]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(6),
      Q => \mem_reg[4][6]_srl5_n_0\
    );
\mem_reg[4][7]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(7),
      Q => \mem_reg[4][7]_srl5_n_0\
    );
\mem_reg[4][8]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(8),
      Q => \mem_reg[4][8]_srl5_n_0\
    );
\mem_reg[4][9]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => \pout_reg_n_0_[0]\,
      A1 => \pout_reg_n_0_[1]\,
      A2 => \pout_reg_n_0_[2]\,
      A3 => '0',
      CE => push,
      CLK => ap_clk,
      D => \q_reg[61]_0\(9),
      Q => \mem_reg[4][9]_srl5_n_0\
    );
\pout[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A7A7A7A758585808"
    )
        port map (
      I0 => push,
      I1 => data_vld_reg_n_0,
      I2 => \pout[0]_i_2_n_0\,
      I3 => \pout_reg_n_0_[2]\,
      I4 => \pout_reg_n_0_[1]\,
      I5 => \pout_reg_n_0_[0]\,
      O => \pout[0]_i_1_n_0\
    );
\pout[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80AAAAAA"
    )
        port map (
      I0 => data_vld_reg_n_0,
      I1 => p_21_in,
      I2 => CO(0),
      I3 => full_n_reg_0,
      I4 => \^fifo_rreq_valid\,
      O => \pout[0]_i_2_n_0\
    );
\pout[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"66CCCCCCCCCC98CC"
    )
        port map (
      I0 => \pout_reg_n_0_[0]\,
      I1 => \pout_reg_n_0_[1]\,
      I2 => \pout_reg_n_0_[2]\,
      I3 => data_vld_reg_n_0,
      I4 => \pout[2]_i_2_n_0\,
      I5 => push,
      O => \pout[1]_i_1_n_0\
    );
\pout[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"78F0F0F0F0F0E0F0"
    )
        port map (
      I0 => \pout_reg_n_0_[0]\,
      I1 => \pout_reg_n_0_[1]\,
      I2 => \pout_reg_n_0_[2]\,
      I3 => data_vld_reg_n_0,
      I4 => \pout[2]_i_2_n_0\,
      I5 => push,
      O => \pout[2]_i_1_n_0\
    );
\pout[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0888"
    )
        port map (
      I0 => \^fifo_rreq_valid\,
      I1 => full_n_reg_0,
      I2 => CO(0),
      I3 => p_21_in,
      O => \pout[2]_i_2_n_0\
    );
\pout_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \pout[0]_i_1_n_0\,
      Q => \pout_reg_n_0_[0]\,
      R => SR(0)
    );
\pout_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \pout[1]_i_1_n_0\,
      Q => \pout_reg_n_0_[1]\,
      R => SR(0)
    );
\pout_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \pout[2]_i_1_n_0\,
      Q => \pout_reg_n_0_[2]\,
      R => SR(0)
    );
\q_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][0]_srl5_n_0\,
      Q => \^q_reg[64]_0\(0),
      R => SR(0)
    );
\q_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][10]_srl5_n_0\,
      Q => \^q_reg[64]_0\(10),
      R => SR(0)
    );
\q_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][11]_srl5_n_0\,
      Q => \^q_reg[64]_0\(11),
      R => SR(0)
    );
\q_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][12]_srl5_n_0\,
      Q => \^q_reg[64]_0\(12),
      R => SR(0)
    );
\q_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][13]_srl5_n_0\,
      Q => \^q_reg[64]_0\(13),
      R => SR(0)
    );
\q_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][14]_srl5_n_0\,
      Q => \^q_reg[64]_0\(14),
      R => SR(0)
    );
\q_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][15]_srl5_n_0\,
      Q => \^q_reg[64]_0\(15),
      R => SR(0)
    );
\q_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][16]_srl5_n_0\,
      Q => \^q_reg[64]_0\(16),
      R => SR(0)
    );
\q_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][17]_srl5_n_0\,
      Q => \^q_reg[64]_0\(17),
      R => SR(0)
    );
\q_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][18]_srl5_n_0\,
      Q => \^q_reg[64]_0\(18),
      R => SR(0)
    );
\q_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][19]_srl5_n_0\,
      Q => \^q_reg[64]_0\(19),
      R => SR(0)
    );
\q_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][1]_srl5_n_0\,
      Q => \^q_reg[64]_0\(1),
      R => SR(0)
    );
\q_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][20]_srl5_n_0\,
      Q => \^q_reg[64]_0\(20),
      R => SR(0)
    );
\q_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][21]_srl5_n_0\,
      Q => \^q_reg[64]_0\(21),
      R => SR(0)
    );
\q_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][22]_srl5_n_0\,
      Q => \^q_reg[64]_0\(22),
      R => SR(0)
    );
\q_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][23]_srl5_n_0\,
      Q => \^q_reg[64]_0\(23),
      R => SR(0)
    );
\q_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][24]_srl5_n_0\,
      Q => \^q_reg[64]_0\(24),
      R => SR(0)
    );
\q_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][25]_srl5_n_0\,
      Q => \^q_reg[64]_0\(25),
      R => SR(0)
    );
\q_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][26]_srl5_n_0\,
      Q => \^q_reg[64]_0\(26),
      R => SR(0)
    );
\q_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][27]_srl5_n_0\,
      Q => \^q_reg[64]_0\(27),
      R => SR(0)
    );
\q_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][28]_srl5_n_0\,
      Q => \^q_reg[64]_0\(28),
      R => SR(0)
    );
\q_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][29]_srl5_n_0\,
      Q => \^q_reg[64]_0\(29),
      R => SR(0)
    );
\q_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][2]_srl5_n_0\,
      Q => \^q_reg[64]_0\(2),
      R => SR(0)
    );
\q_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][30]_srl5_n_0\,
      Q => \^q_reg[64]_0\(30),
      R => SR(0)
    );
\q_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][31]_srl5_n_0\,
      Q => \^q_reg[64]_0\(31),
      R => SR(0)
    );
\q_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][32]_srl5_n_0\,
      Q => \^q_reg[64]_0\(32),
      R => SR(0)
    );
\q_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][33]_srl5_n_0\,
      Q => \^q_reg[64]_0\(33),
      R => SR(0)
    );
\q_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][34]_srl5_n_0\,
      Q => \^q_reg[64]_0\(34),
      R => SR(0)
    );
\q_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][35]_srl5_n_0\,
      Q => \^q_reg[64]_0\(35),
      R => SR(0)
    );
\q_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][36]_srl5_n_0\,
      Q => \^q_reg[64]_0\(36),
      R => SR(0)
    );
\q_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][37]_srl5_n_0\,
      Q => \^q_reg[64]_0\(37),
      R => SR(0)
    );
\q_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][38]_srl5_n_0\,
      Q => \^q_reg[64]_0\(38),
      R => SR(0)
    );
\q_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][39]_srl5_n_0\,
      Q => \^q_reg[64]_0\(39),
      R => SR(0)
    );
\q_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][3]_srl5_n_0\,
      Q => \^q_reg[64]_0\(3),
      R => SR(0)
    );
\q_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][40]_srl5_n_0\,
      Q => \^q_reg[64]_0\(40),
      R => SR(0)
    );
\q_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][41]_srl5_n_0\,
      Q => \^q_reg[64]_0\(41),
      R => SR(0)
    );
\q_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][42]_srl5_n_0\,
      Q => \^q_reg[64]_0\(42),
      R => SR(0)
    );
\q_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][43]_srl5_n_0\,
      Q => \^q_reg[64]_0\(43),
      R => SR(0)
    );
\q_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][44]_srl5_n_0\,
      Q => \^q_reg[64]_0\(44),
      R => SR(0)
    );
\q_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][45]_srl5_n_0\,
      Q => \^q_reg[64]_0\(45),
      R => SR(0)
    );
\q_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][46]_srl5_n_0\,
      Q => \^q_reg[64]_0\(46),
      R => SR(0)
    );
\q_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][47]_srl5_n_0\,
      Q => \^q_reg[64]_0\(47),
      R => SR(0)
    );
\q_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][48]_srl5_n_0\,
      Q => \^q_reg[64]_0\(48),
      R => SR(0)
    );
\q_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][49]_srl5_n_0\,
      Q => \^q_reg[64]_0\(49),
      R => SR(0)
    );
\q_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][4]_srl5_n_0\,
      Q => \^q_reg[64]_0\(4),
      R => SR(0)
    );
\q_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][50]_srl5_n_0\,
      Q => \^q_reg[64]_0\(50),
      R => SR(0)
    );
\q_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][51]_srl5_n_0\,
      Q => \^q_reg[64]_0\(51),
      R => SR(0)
    );
\q_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][52]_srl5_n_0\,
      Q => \^q_reg[64]_0\(52),
      R => SR(0)
    );
\q_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][53]_srl5_n_0\,
      Q => \^q_reg[64]_0\(53),
      R => SR(0)
    );
\q_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][54]_srl5_n_0\,
      Q => \^q_reg[64]_0\(54),
      R => SR(0)
    );
\q_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][55]_srl5_n_0\,
      Q => \^q_reg[64]_0\(55),
      R => SR(0)
    );
\q_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][56]_srl5_n_0\,
      Q => \^q_reg[64]_0\(56),
      R => SR(0)
    );
\q_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][57]_srl5_n_0\,
      Q => \^q_reg[64]_0\(57),
      R => SR(0)
    );
\q_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][58]_srl5_n_0\,
      Q => \^q_reg[64]_0\(58),
      R => SR(0)
    );
\q_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][59]_srl5_n_0\,
      Q => \^q_reg[64]_0\(59),
      R => SR(0)
    );
\q_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][5]_srl5_n_0\,
      Q => \^q_reg[64]_0\(5),
      R => SR(0)
    );
\q_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][60]_srl5_n_0\,
      Q => \^q_reg[64]_0\(60),
      R => SR(0)
    );
\q_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][61]_srl5_n_0\,
      Q => \^q_reg[64]_0\(61),
      R => SR(0)
    );
\q_reg[64]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][64]_srl5_n_0\,
      Q => \^q_reg[64]_0\(62),
      R => SR(0)
    );
\q_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][6]_srl5_n_0\,
      Q => \^q_reg[64]_0\(6),
      R => SR(0)
    );
\q_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][7]_srl5_n_0\,
      Q => \^q_reg[64]_0\(7),
      R => SR(0)
    );
\q_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][8]_srl5_n_0\,
      Q => \^q_reg[64]_0\(8),
      R => SR(0)
    );
\q_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => E(0),
      D => \mem_reg[4][9]_srl5_n_0\,
      Q => \^q_reg[64]_0\(9),
      R => SR(0)
    );
\sect_cnt[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"74"
    )
        port map (
      I0 => Q(0),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(0),
      O => D(0)
    );
\sect_cnt[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(9),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(10),
      O => D(10)
    );
\sect_cnt[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(10),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(11),
      O => D(11)
    );
\sect_cnt[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(11),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(12),
      O => D(12)
    );
\sect_cnt[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(12),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(13),
      O => D(13)
    );
\sect_cnt[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(13),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(14),
      O => D(14)
    );
\sect_cnt[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(14),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(15),
      O => D(15)
    );
\sect_cnt[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(15),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(16),
      O => D(16)
    );
\sect_cnt[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(16),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(17),
      O => D(17)
    );
\sect_cnt[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(17),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(18),
      O => D(18)
    );
\sect_cnt[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(18),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(19),
      O => D(19)
    );
\sect_cnt[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(0),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(1),
      O => D(1)
    );
\sect_cnt[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(19),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(20),
      O => D(20)
    );
\sect_cnt[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(20),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(21),
      O => D(21)
    );
\sect_cnt[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(21),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(22),
      O => D(22)
    );
\sect_cnt[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(22),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(23),
      O => D(23)
    );
\sect_cnt[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(23),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(24),
      O => D(24)
    );
\sect_cnt[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(24),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(25),
      O => D(25)
    );
\sect_cnt[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(25),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(26),
      O => D(26)
    );
\sect_cnt[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(26),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(27),
      O => D(27)
    );
\sect_cnt[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(27),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(28),
      O => D(28)
    );
\sect_cnt[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(28),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(29),
      O => D(29)
    );
\sect_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(1),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(2),
      O => D(2)
    );
\sect_cnt[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(29),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(30),
      O => D(30)
    );
\sect_cnt[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(30),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(31),
      O => D(31)
    );
\sect_cnt[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(31),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(32),
      O => D(32)
    );
\sect_cnt[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(32),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(33),
      O => D(33)
    );
\sect_cnt[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(33),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(34),
      O => D(34)
    );
\sect_cnt[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(34),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(35),
      O => D(35)
    );
\sect_cnt[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(35),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(36),
      O => D(36)
    );
\sect_cnt[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(36),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(37),
      O => D(37)
    );
\sect_cnt[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(37),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(38),
      O => D(38)
    );
\sect_cnt[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(38),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(39),
      O => D(39)
    );
\sect_cnt[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(2),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(3),
      O => D(3)
    );
\sect_cnt[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(39),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(40),
      O => D(40)
    );
\sect_cnt[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(40),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(41),
      O => D(41)
    );
\sect_cnt[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(41),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(42),
      O => D(42)
    );
\sect_cnt[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(42),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(43),
      O => D(43)
    );
\sect_cnt[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(43),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(44),
      O => D(44)
    );
\sect_cnt[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(44),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(45),
      O => D(45)
    );
\sect_cnt[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(45),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(46),
      O => D(46)
    );
\sect_cnt[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(46),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(47),
      O => D(47)
    );
\sect_cnt[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(47),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(48),
      O => D(48)
    );
\sect_cnt[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(48),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(49),
      O => D(49)
    );
\sect_cnt[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(3),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(4),
      O => D(4)
    );
\sect_cnt[50]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(49),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(50),
      O => D(50)
    );
\sect_cnt[51]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(50),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(51),
      O => D(51)
    );
\sect_cnt[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(4),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(5),
      O => D(5)
    );
\sect_cnt[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(5),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(6),
      O => D(6)
    );
\sect_cnt[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(6),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(7),
      O => D(7)
    );
\sect_cnt[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(7),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(8),
      O => D(8)
    );
\sect_cnt[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => sect_cnt0(8),
      I1 => fifo_rreq_valid_buf_i_2_n_0,
      I2 => \sect_cnt_reg[51]\(9),
      O => D(9)
    );
\sect_len_buf[9]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \sect_len_buf_reg[7]_0\(1),
      I1 => \sect_len_buf_reg[7]_1\(1),
      I2 => \sect_len_buf_reg[7]_0\(0),
      I3 => \sect_len_buf_reg[7]_1\(0),
      O => \sect_len_buf_reg[6]\
    );
\sect_len_buf[9]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => \sect_len_buf_reg[7]_0\(2),
      I1 => \sect_len_buf_reg[7]_1\(2),
      I2 => \sect_len_buf_reg[7]_1\(4),
      I3 => \sect_len_buf_reg[7]_0\(4),
      I4 => \sect_len_buf_reg[7]_1\(3),
      I5 => \sect_len_buf_reg[7]_0\(3),
      O => \sect_len_buf_reg[7]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized1\ is
  port (
    empty_n_reg_0 : out STD_LOGIC;
    rreq_handling_reg : out STD_LOGIC;
    p_21_in : out STD_LOGIC;
    rreq_handling_reg_0 : out STD_LOGIC;
    ap_rst_n_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    ap_rst_n_1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    \could_multi_bursts.sect_handling_reg\ : out STD_LOGIC;
    \could_multi_bursts.sect_handling_reg_0\ : out STD_LOGIC;
    \could_multi_bursts.sect_handling_reg_1\ : out STD_LOGIC;
    \could_multi_bursts.sect_handling_reg_2\ : out STD_LOGIC;
    \could_multi_bursts.sect_handling_reg_3\ : out STD_LOGIC;
    \could_multi_bursts.sect_handling_reg_4\ : out STD_LOGIC;
    invalid_len_event_reg2_reg : out STD_LOGIC;
    rreq_handling_reg_1 : out STD_LOGIC_VECTOR ( 0 to 0 );
    \could_multi_bursts.sect_handling_reg_5\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    rreq_handling_reg_2 : out STD_LOGIC_VECTOR ( 0 to 0 );
    ap_clk : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    beat_valid : in STD_LOGIC;
    empty_n_reg_1 : in STD_LOGIC;
    rdata_ack_t : in STD_LOGIC;
    empty_n_reg_2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    rreq_handling_reg_3 : in STD_LOGIC;
    rreq_handling_reg_4 : in STD_LOGIC;
    invalid_len_event : in STD_LOGIC;
    CO : in STD_LOGIC_VECTOR ( 0 to 0 );
    \could_multi_bursts.sect_handling_reg_6\ : in STD_LOGIC;
    \could_multi_bursts.sect_handling_reg_7\ : in STD_LOGIC;
    m_axi_gmem_ARREADY : in STD_LOGIC;
    \could_multi_bursts.sect_handling_reg_8\ : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    fifo_rreq_valid : in STD_LOGIC;
    \sect_addr_buf_reg[2]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    invalid_len_event_reg2 : in STD_LOGIC;
    \sect_len_buf_reg[7]\ : in STD_LOGIC;
    \sect_len_buf_reg[7]_0\ : in STD_LOGIC;
    \pout_reg[3]_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized1\ : entity is "sound_operation_gmem_m_axi_fifo";
end \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized1\;

architecture STRUCTURE of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized1\ is
  signal \data_vld_i_1__0_n_0\ : STD_LOGIC;
  signal data_vld_reg_n_0 : STD_LOGIC;
  signal \empty_n_i_1__0_n_0\ : STD_LOGIC;
  signal \^empty_n_reg_0\ : STD_LOGIC;
  signal fifo_rctl_ready : STD_LOGIC;
  signal \full_n_i_1__1_n_0\ : STD_LOGIC;
  signal \full_n_i_2__0_n_0\ : STD_LOGIC;
  signal \full_n_i_3__0_n_0\ : STD_LOGIC;
  signal \^p_21_in\ : STD_LOGIC;
  signal \pout[0]_i_1_n_0\ : STD_LOGIC;
  signal \pout[1]_i_1_n_0\ : STD_LOGIC;
  signal \pout[2]_i_1_n_0\ : STD_LOGIC;
  signal \pout[3]_i_1_n_0\ : STD_LOGIC;
  signal \pout[3]_i_2_n_0\ : STD_LOGIC;
  signal \pout[3]_i_3_n_0\ : STD_LOGIC;
  signal \pout[3]_i_5_n_0\ : STD_LOGIC;
  signal pout_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \sect_len_buf[9]_i_3_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \align_len[31]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \could_multi_bursts.arlen_buf[4]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \could_multi_bursts.loop_cnt[4]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of empty_n_i_1 : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \full_n_i_3__0\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \pout[0]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \pout[1]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \pout[2]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \pout[3]_i_2\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \pout[3]_i_3\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \sect_cnt[51]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \sect_len_buf[9]_i_3\ : label is "soft_lutpair74";
begin
  empty_n_reg_0 <= \^empty_n_reg_0\;
  p_21_in <= \^p_21_in\;
\align_len[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D500"
    )
        port map (
      I0 => rreq_handling_reg_3,
      I1 => CO(0),
      I2 => \^p_21_in\,
      I3 => fifo_rreq_valid,
      O => E(0)
    );
\could_multi_bursts.ARVALID_Dummy_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4040FF4000000000"
    )
        port map (
      I0 => invalid_len_event_reg2,
      I1 => \could_multi_bursts.sect_handling_reg_6\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => m_axi_gmem_ARREADY,
      I5 => ap_rst_n,
      O => invalid_len_event_reg2_reg
    );
\could_multi_bursts.araddr_buf[63]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8808"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_6\,
      I1 => fifo_rctl_ready,
      I2 => \could_multi_bursts.sect_handling_reg_7\,
      I3 => m_axi_gmem_ARREADY,
      O => \could_multi_bursts.sect_handling_reg_5\(0)
    );
\could_multi_bursts.arlen_buf[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF40400040"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_8\,
      I1 => \could_multi_bursts.sect_handling_reg_6\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => m_axi_gmem_ARREADY,
      I5 => Q(0),
      O => \could_multi_bursts.sect_handling_reg_0\
    );
\could_multi_bursts.arlen_buf[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF40400040"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_8\,
      I1 => \could_multi_bursts.sect_handling_reg_6\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => m_axi_gmem_ARREADY,
      I5 => Q(1),
      O => \could_multi_bursts.sect_handling_reg_1\
    );
\could_multi_bursts.arlen_buf[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF40400040"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_8\,
      I1 => \could_multi_bursts.sect_handling_reg_6\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => m_axi_gmem_ARREADY,
      I5 => Q(2),
      O => \could_multi_bursts.sect_handling_reg_2\
    );
\could_multi_bursts.arlen_buf[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF40400040"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_8\,
      I1 => \could_multi_bursts.sect_handling_reg_6\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => m_axi_gmem_ARREADY,
      I5 => Q(3),
      O => \could_multi_bursts.sect_handling_reg_3\
    );
\could_multi_bursts.arlen_buf[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8808"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_6\,
      I1 => fifo_rctl_ready,
      I2 => \could_multi_bursts.sect_handling_reg_7\,
      I3 => m_axi_gmem_ARREADY,
      O => \could_multi_bursts.sect_handling_reg\
    );
\could_multi_bursts.arlen_buf[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF40400040"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_8\,
      I1 => \could_multi_bursts.sect_handling_reg_6\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => m_axi_gmem_ARREADY,
      I5 => Q(4),
      O => \could_multi_bursts.sect_handling_reg_4\
    );
\could_multi_bursts.loop_cnt[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \^p_21_in\,
      I1 => ap_rst_n,
      O => ap_rst_n_0(0)
    );
\could_multi_bursts.sect_handling_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AEAEEEAEEEEEEEEE"
    )
        port map (
      I0 => rreq_handling_reg_3,
      I1 => \could_multi_bursts.sect_handling_reg_6\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => m_axi_gmem_ARREADY,
      I5 => \could_multi_bursts.sect_handling_reg_8\,
      O => rreq_handling_reg_0
    );
\data_vld_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F0F"
    )
        port map (
      I0 => \pout[3]_i_3_n_0\,
      I1 => \full_n_i_2__0_n_0\,
      I2 => \sect_len_buf[9]_i_3_n_0\,
      I3 => data_vld_reg_n_0,
      O => \data_vld_i_1__0_n_0\
    );
data_vld_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \data_vld_i_1__0_n_0\,
      Q => data_vld_reg_n_0,
      R => SR(0)
    );
empty_n_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8FFF"
    )
        port map (
      I0 => \^p_21_in\,
      I1 => CO(0),
      I2 => rreq_handling_reg_3,
      I3 => fifo_rreq_valid,
      O => rreq_handling_reg_1(0)
    );
\empty_n_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF22A2AAAA"
    )
        port map (
      I0 => \^empty_n_reg_0\,
      I1 => beat_valid,
      I2 => empty_n_reg_1,
      I3 => rdata_ack_t,
      I4 => empty_n_reg_2(0),
      I5 => data_vld_reg_n_0,
      O => \empty_n_i_1__0_n_0\
    );
empty_n_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \empty_n_i_1__0_n_0\,
      Q => \^empty_n_reg_0\,
      R => SR(0)
    );
\full_n_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFBFBFBFBBBFBFB"
    )
        port map (
      I0 => \full_n_i_2__0_n_0\,
      I1 => ap_rst_n,
      I2 => fifo_rctl_ready,
      I3 => \full_n_i_3__0_n_0\,
      I4 => \pout[3]_i_5_n_0\,
      I5 => pout_reg(1),
      O => \full_n_i_1__1_n_0\
    );
\full_n_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"80880000AAAAAAAA"
    )
        port map (
      I0 => data_vld_reg_n_0,
      I1 => empty_n_reg_2(0),
      I2 => rdata_ack_t,
      I3 => empty_n_reg_1,
      I4 => beat_valid,
      I5 => \^empty_n_reg_0\,
      O => \full_n_i_2__0_n_0\
    );
\full_n_i_3__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => pout_reg(2),
      I1 => pout_reg(0),
      I2 => pout_reg(3),
      O => \full_n_i_3__0_n_0\
    );
full_n_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \full_n_i_1__1_n_0\,
      Q => fifo_rctl_ready,
      R => '0'
    );
\pout[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => pout_reg(0),
      O => \pout[0]_i_1_n_0\
    );
\pout[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"69"
    )
        port map (
      I0 => pout_reg(0),
      I1 => \pout[3]_i_5_n_0\,
      I2 => pout_reg(1),
      O => \pout[1]_i_1_n_0\
    );
\pout[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7E81"
    )
        port map (
      I0 => pout_reg(0),
      I1 => \pout[3]_i_5_n_0\,
      I2 => pout_reg(1),
      I3 => pout_reg(2),
      O => \pout[2]_i_1_n_0\
    );
\pout[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5020"
    )
        port map (
      I0 => \sect_len_buf[9]_i_3_n_0\,
      I1 => \pout[3]_i_3_n_0\,
      I2 => data_vld_reg_n_0,
      I3 => \pout_reg[3]_0\,
      O => \pout[3]_i_1_n_0\
    );
\pout[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAA9"
    )
        port map (
      I0 => pout_reg(3),
      I1 => pout_reg(0),
      I2 => \pout[3]_i_5_n_0\,
      I3 => pout_reg(1),
      I4 => pout_reg(2),
      O => \pout[3]_i_2_n_0\
    );
\pout[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => pout_reg(1),
      I1 => pout_reg(2),
      I2 => pout_reg(0),
      I3 => pout_reg(3),
      O => \pout[3]_i_3_n_0\
    );
\pout[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8088000000000000"
    )
        port map (
      I0 => \pout_reg[3]_0\,
      I1 => data_vld_reg_n_0,
      I2 => m_axi_gmem_ARREADY,
      I3 => \could_multi_bursts.sect_handling_reg_7\,
      I4 => fifo_rctl_ready,
      I5 => \could_multi_bursts.sect_handling_reg_6\,
      O => \pout[3]_i_5_n_0\
    );
\pout_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \pout[3]_i_1_n_0\,
      D => \pout[0]_i_1_n_0\,
      Q => pout_reg(0),
      R => SR(0)
    );
\pout_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \pout[3]_i_1_n_0\,
      D => \pout[1]_i_1_n_0\,
      Q => pout_reg(1),
      R => SR(0)
    );
\pout_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \pout[3]_i_1_n_0\,
      D => \pout[2]_i_1_n_0\,
      Q => pout_reg(2),
      R => SR(0)
    );
\pout_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \pout[3]_i_1_n_0\,
      D => \pout[3]_i_2_n_0\,
      Q => pout_reg(3),
      R => SR(0)
    );
rreq_handling_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CAEAEAE"
    )
        port map (
      I0 => rreq_handling_reg_3,
      I1 => rreq_handling_reg_4,
      I2 => invalid_len_event,
      I3 => CO(0),
      I4 => \^p_21_in\,
      O => rreq_handling_reg
    );
\sect_addr_buf[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4F"
    )
        port map (
      I0 => \sect_addr_buf_reg[2]\(0),
      I1 => \^p_21_in\,
      I2 => ap_rst_n,
      O => ap_rst_n_1(0)
    );
\sect_cnt[51]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BBBA"
    )
        port map (
      I0 => \^p_21_in\,
      I1 => rreq_handling_reg_3,
      I2 => rreq_handling_reg_4,
      I3 => fifo_rreq_valid,
      O => rreq_handling_reg_2(0)
    );
\sect_len_buf[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"50507050"
    )
        port map (
      I0 => \could_multi_bursts.sect_handling_reg_6\,
      I1 => \sect_len_buf[9]_i_3_n_0\,
      I2 => rreq_handling_reg_3,
      I3 => \sect_len_buf_reg[7]\,
      I4 => \sect_len_buf_reg[7]_0\,
      O => \^p_21_in\
    );
\sect_len_buf[9]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4FFF"
    )
        port map (
      I0 => m_axi_gmem_ARREADY,
      I1 => \could_multi_bursts.sect_handling_reg_7\,
      I2 => fifo_rctl_ready,
      I3 => \could_multi_bursts.sect_handling_reg_6\,
      O => \sect_len_buf[9]_i_3_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice is
  port (
    ap_NS_fsm : out STD_LOGIC_VECTOR ( 0 to 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    push : out STD_LOGIC;
    \data_p1_reg[61]_0\ : out STD_LOGIC_VECTOR ( 61 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    ap_clk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 8 downto 0 );
    rs2f_rreq_ack : in STD_LOGIC;
    \data_p2_reg[61]_0\ : in STD_LOGIC_VECTOR ( 61 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice is
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \ap_CS_fsm[1]_i_2_n_0\ : STD_LOGIC;
  signal \data_p1[0]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[10]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[11]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[12]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[13]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[14]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[15]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[16]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[17]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[18]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[19]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[1]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[20]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[21]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[22]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[23]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[24]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[25]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[26]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[27]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[28]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[29]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[2]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[30]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[31]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[32]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[33]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[34]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[35]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[36]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[37]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[38]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[39]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[3]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[40]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[41]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[42]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[43]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[44]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[45]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[46]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[47]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[48]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[49]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[4]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[50]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[51]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[52]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[53]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[54]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[55]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[56]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[57]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[58]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[59]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[5]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[60]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[61]_i_2_n_0\ : STD_LOGIC;
  signal \data_p1[6]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[7]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[8]_i_1_n_0\ : STD_LOGIC;
  signal \data_p1[9]_i_1_n_0\ : STD_LOGIC;
  signal data_p2 : STD_LOGIC_VECTOR ( 61 downto 0 );
  signal gmem_ARREADY : STD_LOGIC;
  signal load_p1 : STD_LOGIC;
  signal \next__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal rs2f_rreq_valid : STD_LOGIC;
  signal s_ready_t_i_1_n_0 : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \state[0]_i_1_n_0\ : STD_LOGIC;
  signal \state[1]_i_1_n_0\ : STD_LOGIC;
  signal \state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_1\ : label is "soft_lutpair107";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "ZERO:00,TWO:01,ONE:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "ZERO:00,TWO:01,ONE:10";
  attribute SOFT_HLUTNM of \mem_reg[4][0]_srl5_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of s_ready_t_i_1 : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \state[1]_i_1\ : label is "soft_lutpair108";
begin
  E(0) <= \^e\(0);
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000F80"
    )
        port map (
      I0 => Q(1),
      I1 => gmem_ARREADY,
      I2 => \state__0\(1),
      I3 => \state__0\(0),
      I4 => rs2f_rreq_ack,
      O => \next__0\(0)
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0095AAC0"
    )
        port map (
      I0 => rs2f_rreq_ack,
      I1 => gmem_ARREADY,
      I2 => Q(1),
      I3 => \state__0\(0),
      I4 => \state__0\(1),
      O => \next__0\(1)
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \next__0\(0),
      Q => \state__0\(0),
      R => SR(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \next__0\(1),
      Q => \state__0\(1),
      R => SR(0)
    );
\ap_CS_fsm[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAAB"
    )
        port map (
      I0 => Q(0),
      I1 => \ap_CS_fsm[1]_i_2_n_0\,
      I2 => Q(4),
      I3 => Q(8),
      I4 => Q(2),
      O => ap_NS_fsm(0)
    );
\ap_CS_fsm[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFF8"
    )
        port map (
      I0 => Q(1),
      I1 => gmem_ARREADY,
      I2 => Q(3),
      I3 => Q(5),
      I4 => Q(7),
      I5 => Q(6),
      O => \ap_CS_fsm[1]_i_2_n_0\
    );
\data_p1[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(0),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(0),
      O => \data_p1[0]_i_1_n_0\
    );
\data_p1[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(10),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(10),
      O => \data_p1[10]_i_1_n_0\
    );
\data_p1[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(11),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(11),
      O => \data_p1[11]_i_1_n_0\
    );
\data_p1[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(12),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(12),
      O => \data_p1[12]_i_1_n_0\
    );
\data_p1[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(13),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(13),
      O => \data_p1[13]_i_1_n_0\
    );
\data_p1[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(14),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(14),
      O => \data_p1[14]_i_1_n_0\
    );
\data_p1[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(15),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(15),
      O => \data_p1[15]_i_1_n_0\
    );
\data_p1[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(16),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(16),
      O => \data_p1[16]_i_1_n_0\
    );
\data_p1[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(17),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(17),
      O => \data_p1[17]_i_1_n_0\
    );
\data_p1[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(18),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(18),
      O => \data_p1[18]_i_1_n_0\
    );
\data_p1[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(19),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(19),
      O => \data_p1[19]_i_1_n_0\
    );
\data_p1[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(1),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(1),
      O => \data_p1[1]_i_1_n_0\
    );
\data_p1[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(20),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(20),
      O => \data_p1[20]_i_1_n_0\
    );
\data_p1[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(21),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(21),
      O => \data_p1[21]_i_1_n_0\
    );
\data_p1[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(22),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(22),
      O => \data_p1[22]_i_1_n_0\
    );
\data_p1[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(23),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(23),
      O => \data_p1[23]_i_1_n_0\
    );
\data_p1[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(24),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(24),
      O => \data_p1[24]_i_1_n_0\
    );
\data_p1[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(25),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(25),
      O => \data_p1[25]_i_1_n_0\
    );
\data_p1[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(26),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(26),
      O => \data_p1[26]_i_1_n_0\
    );
\data_p1[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(27),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(27),
      O => \data_p1[27]_i_1_n_0\
    );
\data_p1[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(28),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(28),
      O => \data_p1[28]_i_1_n_0\
    );
\data_p1[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(29),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(29),
      O => \data_p1[29]_i_1_n_0\
    );
\data_p1[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(2),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(2),
      O => \data_p1[2]_i_1_n_0\
    );
\data_p1[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(30),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(30),
      O => \data_p1[30]_i_1_n_0\
    );
\data_p1[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(31),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(31),
      O => \data_p1[31]_i_1_n_0\
    );
\data_p1[32]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(32),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(32),
      O => \data_p1[32]_i_1_n_0\
    );
\data_p1[33]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(33),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(33),
      O => \data_p1[33]_i_1_n_0\
    );
\data_p1[34]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(34),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(34),
      O => \data_p1[34]_i_1_n_0\
    );
\data_p1[35]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(35),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(35),
      O => \data_p1[35]_i_1_n_0\
    );
\data_p1[36]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(36),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(36),
      O => \data_p1[36]_i_1_n_0\
    );
\data_p1[37]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(37),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(37),
      O => \data_p1[37]_i_1_n_0\
    );
\data_p1[38]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(38),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(38),
      O => \data_p1[38]_i_1_n_0\
    );
\data_p1[39]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(39),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(39),
      O => \data_p1[39]_i_1_n_0\
    );
\data_p1[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(3),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(3),
      O => \data_p1[3]_i_1_n_0\
    );
\data_p1[40]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(40),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(40),
      O => \data_p1[40]_i_1_n_0\
    );
\data_p1[41]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(41),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(41),
      O => \data_p1[41]_i_1_n_0\
    );
\data_p1[42]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(42),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(42),
      O => \data_p1[42]_i_1_n_0\
    );
\data_p1[43]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(43),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(43),
      O => \data_p1[43]_i_1_n_0\
    );
\data_p1[44]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(44),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(44),
      O => \data_p1[44]_i_1_n_0\
    );
\data_p1[45]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(45),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(45),
      O => \data_p1[45]_i_1_n_0\
    );
\data_p1[46]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(46),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(46),
      O => \data_p1[46]_i_1_n_0\
    );
\data_p1[47]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(47),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(47),
      O => \data_p1[47]_i_1_n_0\
    );
\data_p1[48]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(48),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(48),
      O => \data_p1[48]_i_1_n_0\
    );
\data_p1[49]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(49),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(49),
      O => \data_p1[49]_i_1_n_0\
    );
\data_p1[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(4),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(4),
      O => \data_p1[4]_i_1_n_0\
    );
\data_p1[50]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(50),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(50),
      O => \data_p1[50]_i_1_n_0\
    );
\data_p1[51]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(51),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(51),
      O => \data_p1[51]_i_1_n_0\
    );
\data_p1[52]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(52),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(52),
      O => \data_p1[52]_i_1_n_0\
    );
\data_p1[53]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(53),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(53),
      O => \data_p1[53]_i_1_n_0\
    );
\data_p1[54]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(54),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(54),
      O => \data_p1[54]_i_1_n_0\
    );
\data_p1[55]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(55),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(55),
      O => \data_p1[55]_i_1_n_0\
    );
\data_p1[56]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(56),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(56),
      O => \data_p1[56]_i_1_n_0\
    );
\data_p1[57]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(57),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(57),
      O => \data_p1[57]_i_1_n_0\
    );
\data_p1[58]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(58),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(58),
      O => \data_p1[58]_i_1_n_0\
    );
\data_p1[59]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(59),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(59),
      O => \data_p1[59]_i_1_n_0\
    );
\data_p1[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(5),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(5),
      O => \data_p1[5]_i_1_n_0\
    );
\data_p1[60]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(60),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(60),
      O => \data_p1[60]_i_1_n_0\
    );
\data_p1[61]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2B080808"
    )
        port map (
      I0 => rs2f_rreq_ack,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => gmem_ARREADY,
      I4 => Q(1),
      O => load_p1
    );
\data_p1[61]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(61),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(61),
      O => \data_p1[61]_i_2_n_0\
    );
\data_p1[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(6),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(6),
      O => \data_p1[6]_i_1_n_0\
    );
\data_p1[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(7),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(7),
      O => \data_p1[7]_i_1_n_0\
    );
\data_p1[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(8),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(8),
      O => \data_p1[8]_i_1_n_0\
    );
\data_p1[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \data_p2_reg[61]_0\(9),
      I1 => \state__0\(1),
      I2 => \state__0\(0),
      I3 => data_p2(9),
      O => \data_p1[9]_i_1_n_0\
    );
\data_p1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[0]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(0),
      R => '0'
    );
\data_p1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[10]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(10),
      R => '0'
    );
\data_p1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[11]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(11),
      R => '0'
    );
\data_p1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[12]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(12),
      R => '0'
    );
\data_p1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[13]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(13),
      R => '0'
    );
\data_p1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[14]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(14),
      R => '0'
    );
\data_p1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[15]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(15),
      R => '0'
    );
\data_p1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[16]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(16),
      R => '0'
    );
\data_p1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[17]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(17),
      R => '0'
    );
\data_p1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[18]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(18),
      R => '0'
    );
\data_p1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[19]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(19),
      R => '0'
    );
\data_p1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[1]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(1),
      R => '0'
    );
\data_p1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[20]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(20),
      R => '0'
    );
\data_p1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[21]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(21),
      R => '0'
    );
\data_p1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[22]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(22),
      R => '0'
    );
\data_p1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[23]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(23),
      R => '0'
    );
\data_p1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[24]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(24),
      R => '0'
    );
\data_p1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[25]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(25),
      R => '0'
    );
\data_p1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[26]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(26),
      R => '0'
    );
\data_p1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[27]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(27),
      R => '0'
    );
\data_p1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[28]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(28),
      R => '0'
    );
\data_p1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[29]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(29),
      R => '0'
    );
\data_p1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[2]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(2),
      R => '0'
    );
\data_p1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[30]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(30),
      R => '0'
    );
\data_p1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[31]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(31),
      R => '0'
    );
\data_p1_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[32]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(32),
      R => '0'
    );
\data_p1_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[33]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(33),
      R => '0'
    );
\data_p1_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[34]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(34),
      R => '0'
    );
\data_p1_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[35]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(35),
      R => '0'
    );
\data_p1_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[36]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(36),
      R => '0'
    );
\data_p1_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[37]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(37),
      R => '0'
    );
\data_p1_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[38]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(38),
      R => '0'
    );
\data_p1_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[39]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(39),
      R => '0'
    );
\data_p1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[3]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(3),
      R => '0'
    );
\data_p1_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[40]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(40),
      R => '0'
    );
\data_p1_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[41]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(41),
      R => '0'
    );
\data_p1_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[42]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(42),
      R => '0'
    );
\data_p1_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[43]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(43),
      R => '0'
    );
\data_p1_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[44]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(44),
      R => '0'
    );
\data_p1_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[45]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(45),
      R => '0'
    );
\data_p1_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[46]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(46),
      R => '0'
    );
\data_p1_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[47]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(47),
      R => '0'
    );
\data_p1_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[48]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(48),
      R => '0'
    );
\data_p1_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[49]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(49),
      R => '0'
    );
\data_p1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[4]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(4),
      R => '0'
    );
\data_p1_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[50]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(50),
      R => '0'
    );
\data_p1_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[51]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(51),
      R => '0'
    );
\data_p1_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[52]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(52),
      R => '0'
    );
\data_p1_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[53]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(53),
      R => '0'
    );
\data_p1_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[54]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(54),
      R => '0'
    );
\data_p1_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[55]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(55),
      R => '0'
    );
\data_p1_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[56]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(56),
      R => '0'
    );
\data_p1_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[57]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(57),
      R => '0'
    );
\data_p1_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[58]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(58),
      R => '0'
    );
\data_p1_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[59]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(59),
      R => '0'
    );
\data_p1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[5]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(5),
      R => '0'
    );
\data_p1_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[60]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(60),
      R => '0'
    );
\data_p1_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[61]_i_2_n_0\,
      Q => \data_p1_reg[61]_0\(61),
      R => '0'
    );
\data_p1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[6]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(6),
      R => '0'
    );
\data_p1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[7]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(7),
      R => '0'
    );
\data_p1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[8]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(8),
      R => '0'
    );
\data_p1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[9]_i_1_n_0\,
      Q => \data_p1_reg[61]_0\(9),
      R => '0'
    );
\data_p2[61]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => gmem_ARREADY,
      I1 => Q(1),
      O => \^e\(0)
    );
\data_p2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(0),
      Q => data_p2(0),
      R => '0'
    );
\data_p2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(10),
      Q => data_p2(10),
      R => '0'
    );
\data_p2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(11),
      Q => data_p2(11),
      R => '0'
    );
\data_p2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(12),
      Q => data_p2(12),
      R => '0'
    );
\data_p2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(13),
      Q => data_p2(13),
      R => '0'
    );
\data_p2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(14),
      Q => data_p2(14),
      R => '0'
    );
\data_p2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(15),
      Q => data_p2(15),
      R => '0'
    );
\data_p2_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(16),
      Q => data_p2(16),
      R => '0'
    );
\data_p2_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(17),
      Q => data_p2(17),
      R => '0'
    );
\data_p2_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(18),
      Q => data_p2(18),
      R => '0'
    );
\data_p2_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(19),
      Q => data_p2(19),
      R => '0'
    );
\data_p2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(1),
      Q => data_p2(1),
      R => '0'
    );
\data_p2_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(20),
      Q => data_p2(20),
      R => '0'
    );
\data_p2_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(21),
      Q => data_p2(21),
      R => '0'
    );
\data_p2_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(22),
      Q => data_p2(22),
      R => '0'
    );
\data_p2_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(23),
      Q => data_p2(23),
      R => '0'
    );
\data_p2_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(24),
      Q => data_p2(24),
      R => '0'
    );
\data_p2_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(25),
      Q => data_p2(25),
      R => '0'
    );
\data_p2_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(26),
      Q => data_p2(26),
      R => '0'
    );
\data_p2_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(27),
      Q => data_p2(27),
      R => '0'
    );
\data_p2_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(28),
      Q => data_p2(28),
      R => '0'
    );
\data_p2_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(29),
      Q => data_p2(29),
      R => '0'
    );
\data_p2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(2),
      Q => data_p2(2),
      R => '0'
    );
\data_p2_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(30),
      Q => data_p2(30),
      R => '0'
    );
\data_p2_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(31),
      Q => data_p2(31),
      R => '0'
    );
\data_p2_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(32),
      Q => data_p2(32),
      R => '0'
    );
\data_p2_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(33),
      Q => data_p2(33),
      R => '0'
    );
\data_p2_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(34),
      Q => data_p2(34),
      R => '0'
    );
\data_p2_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(35),
      Q => data_p2(35),
      R => '0'
    );
\data_p2_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(36),
      Q => data_p2(36),
      R => '0'
    );
\data_p2_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(37),
      Q => data_p2(37),
      R => '0'
    );
\data_p2_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(38),
      Q => data_p2(38),
      R => '0'
    );
\data_p2_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(39),
      Q => data_p2(39),
      R => '0'
    );
\data_p2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(3),
      Q => data_p2(3),
      R => '0'
    );
\data_p2_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(40),
      Q => data_p2(40),
      R => '0'
    );
\data_p2_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(41),
      Q => data_p2(41),
      R => '0'
    );
\data_p2_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(42),
      Q => data_p2(42),
      R => '0'
    );
\data_p2_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(43),
      Q => data_p2(43),
      R => '0'
    );
\data_p2_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(44),
      Q => data_p2(44),
      R => '0'
    );
\data_p2_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(45),
      Q => data_p2(45),
      R => '0'
    );
\data_p2_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(46),
      Q => data_p2(46),
      R => '0'
    );
\data_p2_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(47),
      Q => data_p2(47),
      R => '0'
    );
\data_p2_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(48),
      Q => data_p2(48),
      R => '0'
    );
\data_p2_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(49),
      Q => data_p2(49),
      R => '0'
    );
\data_p2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(4),
      Q => data_p2(4),
      R => '0'
    );
\data_p2_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(50),
      Q => data_p2(50),
      R => '0'
    );
\data_p2_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(51),
      Q => data_p2(51),
      R => '0'
    );
\data_p2_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(52),
      Q => data_p2(52),
      R => '0'
    );
\data_p2_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(53),
      Q => data_p2(53),
      R => '0'
    );
\data_p2_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(54),
      Q => data_p2(54),
      R => '0'
    );
\data_p2_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(55),
      Q => data_p2(55),
      R => '0'
    );
\data_p2_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(56),
      Q => data_p2(56),
      R => '0'
    );
\data_p2_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(57),
      Q => data_p2(57),
      R => '0'
    );
\data_p2_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(58),
      Q => data_p2(58),
      R => '0'
    );
\data_p2_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(59),
      Q => data_p2(59),
      R => '0'
    );
\data_p2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(5),
      Q => data_p2(5),
      R => '0'
    );
\data_p2_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(60),
      Q => data_p2(60),
      R => '0'
    );
\data_p2_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(61),
      Q => data_p2(61),
      R => '0'
    );
\data_p2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(6),
      Q => data_p2(6),
      R => '0'
    );
\data_p2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(7),
      Q => data_p2(7),
      R => '0'
    );
\data_p2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(8),
      Q => data_p2(8),
      R => '0'
    );
\data_p2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \^e\(0),
      D => \data_p2_reg[61]_0\(9),
      Q => data_p2(9),
      R => '0'
    );
\mem_reg[4][0]_srl5_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => rs2f_rreq_valid,
      I1 => rs2f_rreq_ack,
      O => push
    );
s_ready_t_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF55DF11"
    )
        port map (
      I0 => \state__0\(1),
      I1 => \state__0\(0),
      I2 => Q(1),
      I3 => gmem_ARREADY,
      I4 => rs2f_rreq_ack,
      O => s_ready_t_i_1_n_0
    );
s_ready_t_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => s_ready_t_i_1_n_0,
      Q => gmem_ARREADY,
      R => SR(0)
    );
\state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8FFF8800"
    )
        port map (
      I0 => gmem_ARREADY,
      I1 => Q(1),
      I2 => rs2f_rreq_ack,
      I3 => state(1),
      I4 => rs2f_rreq_valid,
      O => \state[0]_i_1_n_0\
    );
\state[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF70FF"
    )
        port map (
      I0 => gmem_ARREADY,
      I1 => Q(1),
      I2 => state(1),
      I3 => rs2f_rreq_valid,
      I4 => rs2f_rreq_ack,
      O => \state[1]_i_1_n_0\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \state[0]_i_1_n_0\,
      Q => rs2f_rreq_valid,
      R => SR(0)
    );
\state_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => ap_clk,
      CE => '1',
      D => \state[1]_i_1_n_0\,
      Q => state(1),
      S => SR(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice__parameterized0\ is
  port (
    rdata_ack_t : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    ap_NS_fsm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    sdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    ap_clk : in STD_LOGIC;
    s_ready_t_reg_0 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    beat_valid : in STD_LOGIC;
    \data_p2_reg[31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice__parameterized0\ : entity is "sound_operation_gmem_m_axi_reg_slice";
end \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice__parameterized0\;

architecture STRUCTURE of \decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice__parameterized0\ is
  signal \data_p1[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[10]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[11]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[12]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[13]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[14]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[15]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[16]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[17]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[18]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[19]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[1]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[20]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[21]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[22]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[23]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[24]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[25]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[26]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[27]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[28]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[29]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[2]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[30]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[31]_i_2_n_0\ : STD_LOGIC;
  signal \data_p1[3]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[4]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[5]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[6]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[7]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[8]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p1[9]_i_1__0_n_0\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[0]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[10]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[11]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[12]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[13]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[14]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[15]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[16]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[17]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[18]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[19]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[1]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[20]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[21]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[22]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[23]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[24]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[25]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[26]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[27]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[28]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[29]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[2]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[30]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[31]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[3]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[4]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[5]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[6]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[7]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[8]\ : STD_LOGIC;
  signal \data_p2_reg_n_0_[9]\ : STD_LOGIC;
  signal gmem_RVALID : STD_LOGIC;
  signal load_p1 : STD_LOGIC;
  signal load_p2 : STD_LOGIC;
  signal \next__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^rdata_ack_t\ : STD_LOGIC;
  signal \s_ready_t_i_1__0_n_0\ : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \state[0]_i_1__0_n_0\ : STD_LOGIC;
  signal \state[1]_i_1__0_n_0\ : STD_LOGIC;
  signal \state__0\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "ZERO:00,TWO:01,ONE:10";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "ZERO:00,TWO:01,ONE:10";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ap_CS_fsm[0]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \ap_CS_fsm[8]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \state[0]_i_1__0\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \state[1]_i_1__0\ : label is "soft_lutpair106";
begin
  rdata_ack_t <= \^rdata_ack_t\;
\FSM_sequential_state[0]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"002A3F00"
    )
        port map (
      I0 => s_ready_t_reg_0,
      I1 => gmem_RVALID,
      I2 => Q(1),
      I3 => \state__0\(0),
      I4 => \state__0\(1),
      O => \next__0\(0)
    );
\FSM_sequential_state[1]_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000F000C3338888"
    )
        port map (
      I0 => \^rdata_ack_t\,
      I1 => s_ready_t_reg_0,
      I2 => Q(1),
      I3 => gmem_RVALID,
      I4 => \state__0\(1),
      I5 => \state__0\(0),
      O => \next__0\(1)
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \next__0\(0),
      Q => \state__0\(0),
      R => SR(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \next__0\(1),
      Q => \state__0\(1),
      R => SR(0)
    );
\ap_CS_fsm[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => gmem_RVALID,
      I1 => Q(1),
      O => ap_NS_fsm(0)
    );
\ap_CS_fsm[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => Q(0),
      I1 => gmem_RVALID,
      I2 => Q(1),
      O => ap_NS_fsm(1)
    );
\bus_equal_gen.data_buf[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B0"
    )
        port map (
      I0 => \^rdata_ack_t\,
      I1 => s_ready_t_reg_0,
      I2 => beat_valid,
      O => E(0)
    );
\data_p1[0]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[0]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(0),
      O => \data_p1[0]_i_1__0_n_0\
    );
\data_p1[10]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[10]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(10),
      O => \data_p1[10]_i_1__0_n_0\
    );
\data_p1[11]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[11]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(11),
      O => \data_p1[11]_i_1__0_n_0\
    );
\data_p1[12]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[12]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(12),
      O => \data_p1[12]_i_1__0_n_0\
    );
\data_p1[13]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[13]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(13),
      O => \data_p1[13]_i_1__0_n_0\
    );
\data_p1[14]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[14]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(14),
      O => \data_p1[14]_i_1__0_n_0\
    );
\data_p1[15]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[15]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(15),
      O => \data_p1[15]_i_1__0_n_0\
    );
\data_p1[16]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[16]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(16),
      O => \data_p1[16]_i_1__0_n_0\
    );
\data_p1[17]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[17]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(17),
      O => \data_p1[17]_i_1__0_n_0\
    );
\data_p1[18]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[18]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(18),
      O => \data_p1[18]_i_1__0_n_0\
    );
\data_p1[19]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[19]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(19),
      O => \data_p1[19]_i_1__0_n_0\
    );
\data_p1[1]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[1]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(1),
      O => \data_p1[1]_i_1__0_n_0\
    );
\data_p1[20]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[20]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(20),
      O => \data_p1[20]_i_1__0_n_0\
    );
\data_p1[21]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[21]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(21),
      O => \data_p1[21]_i_1__0_n_0\
    );
\data_p1[22]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[22]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(22),
      O => \data_p1[22]_i_1__0_n_0\
    );
\data_p1[23]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[23]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(23),
      O => \data_p1[23]_i_1__0_n_0\
    );
\data_p1[24]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[24]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(24),
      O => \data_p1[24]_i_1__0_n_0\
    );
\data_p1[25]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[25]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(25),
      O => \data_p1[25]_i_1__0_n_0\
    );
\data_p1[26]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[26]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(26),
      O => \data_p1[26]_i_1__0_n_0\
    );
\data_p1[27]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[27]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(27),
      O => \data_p1[27]_i_1__0_n_0\
    );
\data_p1[28]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[28]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(28),
      O => \data_p1[28]_i_1__0_n_0\
    );
\data_p1[29]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[29]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(29),
      O => \data_p1[29]_i_1__0_n_0\
    );
\data_p1[2]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[2]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(2),
      O => \data_p1[2]_i_1__0_n_0\
    );
\data_p1[30]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[30]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(30),
      O => \data_p1[30]_i_1__0_n_0\
    );
\data_p1[31]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3000A222"
    )
        port map (
      I0 => s_ready_t_reg_0,
      I1 => \state__0\(1),
      I2 => gmem_RVALID,
      I3 => Q(1),
      I4 => \state__0\(0),
      O => load_p1
    );
\data_p1[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[31]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(31),
      O => \data_p1[31]_i_2_n_0\
    );
\data_p1[3]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[3]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(3),
      O => \data_p1[3]_i_1__0_n_0\
    );
\data_p1[4]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[4]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(4),
      O => \data_p1[4]_i_1__0_n_0\
    );
\data_p1[5]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[5]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(5),
      O => \data_p1[5]_i_1__0_n_0\
    );
\data_p1[6]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[6]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(6),
      O => \data_p1[6]_i_1__0_n_0\
    );
\data_p1[7]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[7]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(7),
      O => \data_p1[7]_i_1__0_n_0\
    );
\data_p1[8]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[8]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(8),
      O => \data_p1[8]_i_1__0_n_0\
    );
\data_p1[9]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB08"
    )
        port map (
      I0 => \data_p2_reg_n_0_[9]\,
      I1 => \state__0\(0),
      I2 => \state__0\(1),
      I3 => \data_p2_reg[31]_0\(9),
      O => \data_p1[9]_i_1__0_n_0\
    );
\data_p1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[0]_i_1__0_n_0\,
      Q => sdata(0),
      R => '0'
    );
\data_p1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[10]_i_1__0_n_0\,
      Q => sdata(10),
      R => '0'
    );
\data_p1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[11]_i_1__0_n_0\,
      Q => sdata(11),
      R => '0'
    );
\data_p1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[12]_i_1__0_n_0\,
      Q => sdata(12),
      R => '0'
    );
\data_p1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[13]_i_1__0_n_0\,
      Q => sdata(13),
      R => '0'
    );
\data_p1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[14]_i_1__0_n_0\,
      Q => sdata(14),
      R => '0'
    );
\data_p1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[15]_i_1__0_n_0\,
      Q => sdata(15),
      R => '0'
    );
\data_p1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[16]_i_1__0_n_0\,
      Q => sdata(16),
      R => '0'
    );
\data_p1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[17]_i_1__0_n_0\,
      Q => sdata(17),
      R => '0'
    );
\data_p1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[18]_i_1__0_n_0\,
      Q => sdata(18),
      R => '0'
    );
\data_p1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[19]_i_1__0_n_0\,
      Q => sdata(19),
      R => '0'
    );
\data_p1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[1]_i_1__0_n_0\,
      Q => sdata(1),
      R => '0'
    );
\data_p1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[20]_i_1__0_n_0\,
      Q => sdata(20),
      R => '0'
    );
\data_p1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[21]_i_1__0_n_0\,
      Q => sdata(21),
      R => '0'
    );
\data_p1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[22]_i_1__0_n_0\,
      Q => sdata(22),
      R => '0'
    );
\data_p1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[23]_i_1__0_n_0\,
      Q => sdata(23),
      R => '0'
    );
\data_p1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[24]_i_1__0_n_0\,
      Q => sdata(24),
      R => '0'
    );
\data_p1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[25]_i_1__0_n_0\,
      Q => sdata(25),
      R => '0'
    );
\data_p1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[26]_i_1__0_n_0\,
      Q => sdata(26),
      R => '0'
    );
\data_p1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[27]_i_1__0_n_0\,
      Q => sdata(27),
      R => '0'
    );
\data_p1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[28]_i_1__0_n_0\,
      Q => sdata(28),
      R => '0'
    );
\data_p1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[29]_i_1__0_n_0\,
      Q => sdata(29),
      R => '0'
    );
\data_p1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[2]_i_1__0_n_0\,
      Q => sdata(2),
      R => '0'
    );
\data_p1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[30]_i_1__0_n_0\,
      Q => sdata(30),
      R => '0'
    );
\data_p1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[31]_i_2_n_0\,
      Q => sdata(31),
      R => '0'
    );
\data_p1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[3]_i_1__0_n_0\,
      Q => sdata(3),
      R => '0'
    );
\data_p1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[4]_i_1__0_n_0\,
      Q => sdata(4),
      R => '0'
    );
\data_p1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[5]_i_1__0_n_0\,
      Q => sdata(5),
      R => '0'
    );
\data_p1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[6]_i_1__0_n_0\,
      Q => sdata(6),
      R => '0'
    );
\data_p1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[7]_i_1__0_n_0\,
      Q => sdata(7),
      R => '0'
    );
\data_p1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[8]_i_1__0_n_0\,
      Q => sdata(8),
      R => '0'
    );
\data_p1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p1,
      D => \data_p1[9]_i_1__0_n_0\,
      Q => sdata(9),
      R => '0'
    );
\data_p2[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_ready_t_reg_0,
      I1 => \^rdata_ack_t\,
      O => load_p2
    );
\data_p2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(0),
      Q => \data_p2_reg_n_0_[0]\,
      R => '0'
    );
\data_p2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(10),
      Q => \data_p2_reg_n_0_[10]\,
      R => '0'
    );
\data_p2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(11),
      Q => \data_p2_reg_n_0_[11]\,
      R => '0'
    );
\data_p2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(12),
      Q => \data_p2_reg_n_0_[12]\,
      R => '0'
    );
\data_p2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(13),
      Q => \data_p2_reg_n_0_[13]\,
      R => '0'
    );
\data_p2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(14),
      Q => \data_p2_reg_n_0_[14]\,
      R => '0'
    );
\data_p2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(15),
      Q => \data_p2_reg_n_0_[15]\,
      R => '0'
    );
\data_p2_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(16),
      Q => \data_p2_reg_n_0_[16]\,
      R => '0'
    );
\data_p2_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(17),
      Q => \data_p2_reg_n_0_[17]\,
      R => '0'
    );
\data_p2_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(18),
      Q => \data_p2_reg_n_0_[18]\,
      R => '0'
    );
\data_p2_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(19),
      Q => \data_p2_reg_n_0_[19]\,
      R => '0'
    );
\data_p2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(1),
      Q => \data_p2_reg_n_0_[1]\,
      R => '0'
    );
\data_p2_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(20),
      Q => \data_p2_reg_n_0_[20]\,
      R => '0'
    );
\data_p2_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(21),
      Q => \data_p2_reg_n_0_[21]\,
      R => '0'
    );
\data_p2_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(22),
      Q => \data_p2_reg_n_0_[22]\,
      R => '0'
    );
\data_p2_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(23),
      Q => \data_p2_reg_n_0_[23]\,
      R => '0'
    );
\data_p2_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(24),
      Q => \data_p2_reg_n_0_[24]\,
      R => '0'
    );
\data_p2_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(25),
      Q => \data_p2_reg_n_0_[25]\,
      R => '0'
    );
\data_p2_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(26),
      Q => \data_p2_reg_n_0_[26]\,
      R => '0'
    );
\data_p2_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(27),
      Q => \data_p2_reg_n_0_[27]\,
      R => '0'
    );
\data_p2_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(28),
      Q => \data_p2_reg_n_0_[28]\,
      R => '0'
    );
\data_p2_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(29),
      Q => \data_p2_reg_n_0_[29]\,
      R => '0'
    );
\data_p2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(2),
      Q => \data_p2_reg_n_0_[2]\,
      R => '0'
    );
\data_p2_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(30),
      Q => \data_p2_reg_n_0_[30]\,
      R => '0'
    );
\data_p2_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(31),
      Q => \data_p2_reg_n_0_[31]\,
      R => '0'
    );
\data_p2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(3),
      Q => \data_p2_reg_n_0_[3]\,
      R => '0'
    );
\data_p2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(4),
      Q => \data_p2_reg_n_0_[4]\,
      R => '0'
    );
\data_p2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(5),
      Q => \data_p2_reg_n_0_[5]\,
      R => '0'
    );
\data_p2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(6),
      Q => \data_p2_reg_n_0_[6]\,
      R => '0'
    );
\data_p2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(7),
      Q => \data_p2_reg_n_0_[7]\,
      R => '0'
    );
\data_p2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(8),
      Q => \data_p2_reg_n_0_[8]\,
      R => '0'
    );
\data_p2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => load_p2,
      D => \data_p2_reg[31]_0\(9),
      Q => \data_p2_reg_n_0_[9]\,
      R => '0'
    );
\s_ready_t_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFBFBFBF0F050505"
    )
        port map (
      I0 => \state__0\(0),
      I1 => s_ready_t_reg_0,
      I2 => \state__0\(1),
      I3 => Q(1),
      I4 => gmem_RVALID,
      I5 => \^rdata_ack_t\,
      O => \s_ready_t_i_1__0_n_0\
    );
s_ready_t_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \s_ready_t_i_1__0_n_0\,
      Q => \^rdata_ack_t\,
      R => SR(0)
    );
\state[0]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FA30F0F0"
    )
        port map (
      I0 => \^rdata_ack_t\,
      I1 => Q(1),
      I2 => gmem_RVALID,
      I3 => s_ready_t_reg_0,
      I4 => state(1),
      O => \state[0]_i_1__0_n_0\
    );
\state[1]_i_1__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF4F"
    )
        port map (
      I0 => s_ready_t_reg_0,
      I1 => state(1),
      I2 => gmem_RVALID,
      I3 => Q(1),
      O => \state[1]_i_1__0_n_0\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \state[0]_i_1__0_n_0\,
      Q => gmem_RVALID,
      R => SR(0)
    );
\state_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => ap_clk,
      CE => '1',
      D => \state[1]_i_1__0_n_0\,
      Q => state(1),
      S => SR(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_read is
  port (
    full_n_reg : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    \could_multi_bursts.ARVALID_Dummy_reg_0\ : out STD_LOGIC;
    m_axi_gmem_ARADDR : out STD_LOGIC_VECTOR ( 61 downto 0 );
    \could_multi_bursts.arlen_buf_reg[4]_0\ : out STD_LOGIC_VECTOR ( 4 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    sdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_NS_fsm : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ap_clk : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 32 downto 0 );
    m_axi_gmem_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_RVALID : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_gmem_ARREADY : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    \data_p2_reg[61]\ : in STD_LOGIC_VECTOR ( 61 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_read;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_read is
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal align_len0 : STD_LOGIC_VECTOR ( 31 downto 2 );
  signal align_len0_carry_n_2 : STD_LOGIC;
  signal align_len0_carry_n_3 : STD_LOGIC;
  signal \align_len_reg_n_0_[2]\ : STD_LOGIC;
  signal \align_len_reg_n_0_[31]\ : STD_LOGIC;
  signal araddr_tmp : STD_LOGIC_VECTOR ( 63 downto 2 );
  signal beat_len_buf : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal beat_valid : STD_LOGIC;
  signal buff_rdata_n_15 : STD_LOGIC;
  signal buff_rdata_n_16 : STD_LOGIC;
  signal buff_rdata_n_17 : STD_LOGIC;
  signal buff_rdata_n_18 : STD_LOGIC;
  signal buff_rdata_n_20 : STD_LOGIC;
  signal buff_rdata_n_22 : STD_LOGIC;
  signal buff_rdata_n_23 : STD_LOGIC;
  signal buff_rdata_n_24 : STD_LOGIC;
  signal buff_rdata_n_25 : STD_LOGIC;
  signal buff_rdata_n_26 : STD_LOGIC;
  signal buff_rdata_n_27 : STD_LOGIC;
  signal buff_rdata_n_28 : STD_LOGIC;
  signal buff_rdata_n_29 : STD_LOGIC;
  signal buff_rdata_n_3 : STD_LOGIC;
  signal buff_rdata_n_30 : STD_LOGIC;
  signal buff_rdata_n_31 : STD_LOGIC;
  signal buff_rdata_n_32 : STD_LOGIC;
  signal buff_rdata_n_33 : STD_LOGIC;
  signal buff_rdata_n_34 : STD_LOGIC;
  signal buff_rdata_n_35 : STD_LOGIC;
  signal buff_rdata_n_36 : STD_LOGIC;
  signal buff_rdata_n_37 : STD_LOGIC;
  signal buff_rdata_n_38 : STD_LOGIC;
  signal buff_rdata_n_39 : STD_LOGIC;
  signal buff_rdata_n_4 : STD_LOGIC;
  signal buff_rdata_n_40 : STD_LOGIC;
  signal buff_rdata_n_41 : STD_LOGIC;
  signal buff_rdata_n_42 : STD_LOGIC;
  signal buff_rdata_n_43 : STD_LOGIC;
  signal buff_rdata_n_44 : STD_LOGIC;
  signal buff_rdata_n_45 : STD_LOGIC;
  signal buff_rdata_n_46 : STD_LOGIC;
  signal buff_rdata_n_47 : STD_LOGIC;
  signal buff_rdata_n_48 : STD_LOGIC;
  signal buff_rdata_n_49 : STD_LOGIC;
  signal buff_rdata_n_5 : STD_LOGIC;
  signal buff_rdata_n_50 : STD_LOGIC;
  signal buff_rdata_n_51 : STD_LOGIC;
  signal buff_rdata_n_52 : STD_LOGIC;
  signal buff_rdata_n_53 : STD_LOGIC;
  signal buff_rdata_n_6 : STD_LOGIC;
  signal buff_rdata_n_7 : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[0]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[10]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[11]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[12]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[13]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[14]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[15]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[16]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[17]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[18]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[19]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[1]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[20]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[21]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[22]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[23]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[24]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[25]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[26]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[27]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[28]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[29]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[2]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[30]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[31]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[3]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[4]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[5]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[6]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[7]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[8]\ : STD_LOGIC;
  signal \bus_equal_gen.data_buf_reg_n_0_[9]\ : STD_LOGIC;
  signal \bus_equal_gen.rdata_valid_t_reg_n_0\ : STD_LOGIC;
  signal \^could_multi_bursts.arvalid_dummy_reg_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf[4]_i_3_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf[4]_i_4_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf[4]_i_5_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf[63]_i_4_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf[8]_i_3_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf[8]_i_4_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf[8]_i_5_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[20]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[20]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[20]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[20]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[24]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[24]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[24]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[24]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[28]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[28]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[28]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[28]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[32]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[32]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[32]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[32]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[36]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[36]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[36]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[36]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[40]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[40]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[40]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[40]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[44]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[44]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[44]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[44]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[48]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[48]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[48]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[48]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[52]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[52]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[52]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[52]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[56]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[56]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[56]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[56]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[60]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[60]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[60]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[60]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[63]_i_5_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[63]_i_5_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \could_multi_bursts.araddr_buf_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \could_multi_bursts.arlen_buf[4]_i_3_n_0\ : STD_LOGIC;
  signal \^could_multi_bursts.arlen_buf_reg[4]_0\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \could_multi_bursts.loop_cnt_reg\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \could_multi_bursts.sect_handling_reg_n_0\ : STD_LOGIC;
  signal data1 : STD_LOGIC_VECTOR ( 63 downto 2 );
  signal data_pack : STD_LOGIC_VECTOR ( 34 to 34 );
  signal end_addr : STD_LOGIC_VECTOR ( 63 downto 2 );
  signal \end_addr_buf[13]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[13]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[13]_i_4_n_0\ : STD_LOGIC;
  signal \end_addr_buf[13]_i_5_n_0\ : STD_LOGIC;
  signal \end_addr_buf[17]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[17]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[17]_i_4_n_0\ : STD_LOGIC;
  signal \end_addr_buf[17]_i_5_n_0\ : STD_LOGIC;
  signal \end_addr_buf[21]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[21]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[21]_i_4_n_0\ : STD_LOGIC;
  signal \end_addr_buf[21]_i_5_n_0\ : STD_LOGIC;
  signal \end_addr_buf[25]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[25]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[25]_i_4_n_0\ : STD_LOGIC;
  signal \end_addr_buf[25]_i_5_n_0\ : STD_LOGIC;
  signal \end_addr_buf[29]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[29]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[29]_i_4_n_0\ : STD_LOGIC;
  signal \end_addr_buf[29]_i_5_n_0\ : STD_LOGIC;
  signal \end_addr_buf[33]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[33]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[5]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[5]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[5]_i_4_n_0\ : STD_LOGIC;
  signal \end_addr_buf[5]_i_5_n_0\ : STD_LOGIC;
  signal \end_addr_buf[9]_i_2_n_0\ : STD_LOGIC;
  signal \end_addr_buf[9]_i_3_n_0\ : STD_LOGIC;
  signal \end_addr_buf[9]_i_4_n_0\ : STD_LOGIC;
  signal \end_addr_buf[9]_i_5_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[13]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[13]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[13]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[13]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[17]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[17]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[17]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[17]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[21]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[21]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[21]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[21]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[25]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[25]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[25]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[25]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[29]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[29]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[29]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[29]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[33]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[33]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[33]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[33]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[37]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[37]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[37]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[37]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[41]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[41]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[41]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[41]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[45]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[45]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[45]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[45]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[49]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[49]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[49]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[49]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[53]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[53]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[53]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[53]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[57]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[57]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[57]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[57]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[5]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[5]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[5]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[61]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[61]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[61]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[61]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[63]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg[9]_i_1_n_0\ : STD_LOGIC;
  signal \end_addr_buf_reg[9]_i_1_n_1\ : STD_LOGIC;
  signal \end_addr_buf_reg[9]_i_1_n_2\ : STD_LOGIC;
  signal \end_addr_buf_reg[9]_i_1_n_3\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[10]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[11]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[2]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[3]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[4]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[5]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[6]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[7]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[8]\ : STD_LOGIC;
  signal \end_addr_buf_reg_n_0_[9]\ : STD_LOGIC;
  signal fifo_rctl_n_0 : STD_LOGIC;
  signal fifo_rctl_n_1 : STD_LOGIC;
  signal fifo_rctl_n_10 : STD_LOGIC;
  signal fifo_rctl_n_11 : STD_LOGIC;
  signal fifo_rctl_n_12 : STD_LOGIC;
  signal fifo_rctl_n_13 : STD_LOGIC;
  signal fifo_rctl_n_16 : STD_LOGIC;
  signal fifo_rctl_n_3 : STD_LOGIC;
  signal fifo_rctl_n_4 : STD_LOGIC;
  signal fifo_rctl_n_5 : STD_LOGIC;
  signal fifo_rctl_n_6 : STD_LOGIC;
  signal fifo_rctl_n_7 : STD_LOGIC;
  signal fifo_rctl_n_8 : STD_LOGIC;
  signal fifo_rctl_n_9 : STD_LOGIC;
  signal fifo_rreq_data : STD_LOGIC_VECTOR ( 64 to 64 );
  signal fifo_rreq_n_10 : STD_LOGIC;
  signal fifo_rreq_n_11 : STD_LOGIC;
  signal fifo_rreq_n_12 : STD_LOGIC;
  signal fifo_rreq_n_13 : STD_LOGIC;
  signal fifo_rreq_n_14 : STD_LOGIC;
  signal fifo_rreq_n_15 : STD_LOGIC;
  signal fifo_rreq_n_16 : STD_LOGIC;
  signal fifo_rreq_n_17 : STD_LOGIC;
  signal fifo_rreq_n_18 : STD_LOGIC;
  signal fifo_rreq_n_19 : STD_LOGIC;
  signal fifo_rreq_n_2 : STD_LOGIC;
  signal fifo_rreq_n_20 : STD_LOGIC;
  signal fifo_rreq_n_21 : STD_LOGIC;
  signal fifo_rreq_n_22 : STD_LOGIC;
  signal fifo_rreq_n_23 : STD_LOGIC;
  signal fifo_rreq_n_24 : STD_LOGIC;
  signal fifo_rreq_n_25 : STD_LOGIC;
  signal fifo_rreq_n_26 : STD_LOGIC;
  signal fifo_rreq_n_27 : STD_LOGIC;
  signal fifo_rreq_n_28 : STD_LOGIC;
  signal fifo_rreq_n_29 : STD_LOGIC;
  signal fifo_rreq_n_3 : STD_LOGIC;
  signal fifo_rreq_n_30 : STD_LOGIC;
  signal fifo_rreq_n_31 : STD_LOGIC;
  signal fifo_rreq_n_32 : STD_LOGIC;
  signal fifo_rreq_n_33 : STD_LOGIC;
  signal fifo_rreq_n_34 : STD_LOGIC;
  signal fifo_rreq_n_35 : STD_LOGIC;
  signal fifo_rreq_n_36 : STD_LOGIC;
  signal fifo_rreq_n_37 : STD_LOGIC;
  signal fifo_rreq_n_38 : STD_LOGIC;
  signal fifo_rreq_n_39 : STD_LOGIC;
  signal fifo_rreq_n_4 : STD_LOGIC;
  signal fifo_rreq_n_40 : STD_LOGIC;
  signal fifo_rreq_n_41 : STD_LOGIC;
  signal fifo_rreq_n_42 : STD_LOGIC;
  signal fifo_rreq_n_43 : STD_LOGIC;
  signal fifo_rreq_n_44 : STD_LOGIC;
  signal fifo_rreq_n_45 : STD_LOGIC;
  signal fifo_rreq_n_46 : STD_LOGIC;
  signal fifo_rreq_n_47 : STD_LOGIC;
  signal fifo_rreq_n_48 : STD_LOGIC;
  signal fifo_rreq_n_49 : STD_LOGIC;
  signal fifo_rreq_n_5 : STD_LOGIC;
  signal fifo_rreq_n_50 : STD_LOGIC;
  signal fifo_rreq_n_51 : STD_LOGIC;
  signal fifo_rreq_n_52 : STD_LOGIC;
  signal fifo_rreq_n_53 : STD_LOGIC;
  signal fifo_rreq_n_55 : STD_LOGIC;
  signal fifo_rreq_n_56 : STD_LOGIC;
  signal fifo_rreq_n_6 : STD_LOGIC;
  signal fifo_rreq_n_7 : STD_LOGIC;
  signal fifo_rreq_n_8 : STD_LOGIC;
  signal fifo_rreq_n_9 : STD_LOGIC;
  signal fifo_rreq_valid : STD_LOGIC;
  signal fifo_rreq_valid_buf_reg_n_0 : STD_LOGIC;
  signal first_sect : STD_LOGIC;
  signal \first_sect_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \first_sect_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \first_sect_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \first_sect_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \first_sect_carry__0_n_0\ : STD_LOGIC;
  signal \first_sect_carry__0_n_1\ : STD_LOGIC;
  signal \first_sect_carry__0_n_2\ : STD_LOGIC;
  signal \first_sect_carry__0_n_3\ : STD_LOGIC;
  signal \first_sect_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \first_sect_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \first_sect_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \first_sect_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \first_sect_carry__1_n_0\ : STD_LOGIC;
  signal \first_sect_carry__1_n_1\ : STD_LOGIC;
  signal \first_sect_carry__1_n_2\ : STD_LOGIC;
  signal \first_sect_carry__1_n_3\ : STD_LOGIC;
  signal \first_sect_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \first_sect_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \first_sect_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \first_sect_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \first_sect_carry__2_n_0\ : STD_LOGIC;
  signal \first_sect_carry__2_n_1\ : STD_LOGIC;
  signal \first_sect_carry__2_n_2\ : STD_LOGIC;
  signal \first_sect_carry__2_n_3\ : STD_LOGIC;
  signal \first_sect_carry__3_i_1_n_0\ : STD_LOGIC;
  signal \first_sect_carry__3_i_2_n_0\ : STD_LOGIC;
  signal \first_sect_carry__3_n_3\ : STD_LOGIC;
  signal first_sect_carry_i_1_n_0 : STD_LOGIC;
  signal first_sect_carry_i_2_n_0 : STD_LOGIC;
  signal first_sect_carry_i_3_n_0 : STD_LOGIC;
  signal first_sect_carry_i_4_n_0 : STD_LOGIC;
  signal first_sect_carry_n_0 : STD_LOGIC;
  signal first_sect_carry_n_1 : STD_LOGIC;
  signal first_sect_carry_n_2 : STD_LOGIC;
  signal first_sect_carry_n_3 : STD_LOGIC;
  signal invalid_len_event : STD_LOGIC;
  signal invalid_len_event0 : STD_LOGIC;
  signal invalid_len_event_reg1 : STD_LOGIC;
  signal invalid_len_event_reg2 : STD_LOGIC;
  signal last_sect : STD_LOGIC;
  signal \last_sect_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \last_sect_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \last_sect_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \last_sect_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \last_sect_carry__0_n_0\ : STD_LOGIC;
  signal \last_sect_carry__0_n_1\ : STD_LOGIC;
  signal \last_sect_carry__0_n_2\ : STD_LOGIC;
  signal \last_sect_carry__0_n_3\ : STD_LOGIC;
  signal \last_sect_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \last_sect_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \last_sect_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \last_sect_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \last_sect_carry__1_n_0\ : STD_LOGIC;
  signal \last_sect_carry__1_n_1\ : STD_LOGIC;
  signal \last_sect_carry__1_n_2\ : STD_LOGIC;
  signal \last_sect_carry__1_n_3\ : STD_LOGIC;
  signal \last_sect_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \last_sect_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \last_sect_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \last_sect_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \last_sect_carry__2_n_0\ : STD_LOGIC;
  signal \last_sect_carry__2_n_1\ : STD_LOGIC;
  signal \last_sect_carry__2_n_2\ : STD_LOGIC;
  signal \last_sect_carry__2_n_3\ : STD_LOGIC;
  signal \last_sect_carry__3_i_1_n_0\ : STD_LOGIC;
  signal \last_sect_carry__3_i_2_n_0\ : STD_LOGIC;
  signal \last_sect_carry__3_n_3\ : STD_LOGIC;
  signal last_sect_carry_i_1_n_0 : STD_LOGIC;
  signal last_sect_carry_i_2_n_0 : STD_LOGIC;
  signal last_sect_carry_i_3_n_0 : STD_LOGIC;
  signal last_sect_carry_i_4_n_0 : STD_LOGIC;
  signal last_sect_carry_n_0 : STD_LOGIC;
  signal last_sect_carry_n_1 : STD_LOGIC;
  signal last_sect_carry_n_2 : STD_LOGIC;
  signal last_sect_carry_n_3 : STD_LOGIC;
  signal mOutPtr19_out : STD_LOGIC;
  signal mOutPtr_reg : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \^m_axi_gmem_araddr\ : STD_LOGIC_VECTOR ( 61 downto 0 );
  signal next_beat : STD_LOGIC;
  signal next_rreq : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_0_in0_in : STD_LOGIC_VECTOR ( 51 downto 0 );
  signal p_0_in_0 : STD_LOGIC_VECTOR ( 51 downto 0 );
  signal \p_0_out_carry__0_n_1\ : STD_LOGIC;
  signal \p_0_out_carry__0_n_2\ : STD_LOGIC;
  signal \p_0_out_carry__0_n_3\ : STD_LOGIC;
  signal \p_0_out_carry__0_n_4\ : STD_LOGIC;
  signal \p_0_out_carry__0_n_5\ : STD_LOGIC;
  signal \p_0_out_carry__0_n_6\ : STD_LOGIC;
  signal \p_0_out_carry__0_n_7\ : STD_LOGIC;
  signal p_0_out_carry_n_0 : STD_LOGIC;
  signal p_0_out_carry_n_1 : STD_LOGIC;
  signal p_0_out_carry_n_2 : STD_LOGIC;
  signal p_0_out_carry_n_3 : STD_LOGIC;
  signal p_0_out_carry_n_4 : STD_LOGIC;
  signal p_0_out_carry_n_5 : STD_LOGIC;
  signal p_0_out_carry_n_6 : STD_LOGIC;
  signal p_0_out_carry_n_7 : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal p_20_in : STD_LOGIC;
  signal p_21_in : STD_LOGIC;
  signal pop0 : STD_LOGIC;
  signal push : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 61 downto 0 );
  signal rdata_ack_t : STD_LOGIC;
  signal rreq_handling_reg_n_0 : STD_LOGIC;
  signal rs2f_rreq_ack : STD_LOGIC;
  signal rs2f_rreq_data : STD_LOGIC_VECTOR ( 61 downto 0 );
  signal sect_addr : STD_LOGIC_VECTOR ( 63 downto 2 );
  signal \sect_addr_buf_reg_n_0_[10]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[11]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[12]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[13]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[14]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[15]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[16]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[17]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[18]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[19]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[20]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[21]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[22]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[23]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[24]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[25]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[26]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[27]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[28]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[29]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[2]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[30]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[31]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[32]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[33]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[34]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[35]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[36]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[37]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[38]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[39]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[3]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[40]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[41]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[42]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[43]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[44]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[45]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[46]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[47]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[48]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[49]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[4]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[50]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[51]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[52]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[53]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[54]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[55]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[56]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[57]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[58]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[59]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[5]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[60]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[61]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[62]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[63]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[6]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[7]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[8]\ : STD_LOGIC;
  signal \sect_addr_buf_reg_n_0_[9]\ : STD_LOGIC;
  signal sect_cnt0 : STD_LOGIC_VECTOR ( 51 downto 1 );
  signal \sect_cnt0_carry__0_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__0_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__0_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__0_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__10_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__10_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__10_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__10_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__11_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__11_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__1_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__1_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__1_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__1_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__2_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__2_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__2_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__2_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__3_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__3_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__3_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__3_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__4_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__4_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__4_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__4_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__5_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__5_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__5_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__5_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__6_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__6_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__6_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__6_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__7_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__7_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__7_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__7_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__8_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__8_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__8_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__8_n_3\ : STD_LOGIC;
  signal \sect_cnt0_carry__9_n_0\ : STD_LOGIC;
  signal \sect_cnt0_carry__9_n_1\ : STD_LOGIC;
  signal \sect_cnt0_carry__9_n_2\ : STD_LOGIC;
  signal \sect_cnt0_carry__9_n_3\ : STD_LOGIC;
  signal sect_cnt0_carry_n_0 : STD_LOGIC;
  signal sect_cnt0_carry_n_1 : STD_LOGIC;
  signal sect_cnt0_carry_n_2 : STD_LOGIC;
  signal sect_cnt0_carry_n_3 : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[10]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[11]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[12]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[13]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[14]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[15]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[16]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[17]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[18]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[19]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[1]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[20]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[21]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[22]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[23]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[24]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[25]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[26]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[27]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[28]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[29]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[2]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[30]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[31]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[32]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[33]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[34]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[35]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[36]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[37]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[38]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[39]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[3]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[40]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[41]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[42]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[43]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[44]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[45]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[46]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[47]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[48]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[49]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[4]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[50]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[51]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[5]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[6]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[7]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[8]\ : STD_LOGIC;
  signal \sect_cnt_reg_n_0_[9]\ : STD_LOGIC;
  signal \sect_len_buf[0]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[1]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[2]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[3]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[4]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[5]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[6]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[7]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[8]_i_1_n_0\ : STD_LOGIC;
  signal \sect_len_buf[9]_i_2_n_0\ : STD_LOGIC;
  signal \sect_len_buf_reg_n_0_[5]\ : STD_LOGIC;
  signal \sect_len_buf_reg_n_0_[6]\ : STD_LOGIC;
  signal \sect_len_buf_reg_n_0_[7]\ : STD_LOGIC;
  signal \sect_len_buf_reg_n_0_[8]\ : STD_LOGIC;
  signal \sect_len_buf_reg_n_0_[9]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[10]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[11]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[2]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[3]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[4]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[5]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[6]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[7]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[8]\ : STD_LOGIC;
  signal \start_addr_buf_reg_n_0_[9]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[10]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[11]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[12]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[13]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[14]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[15]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[16]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[17]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[18]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[19]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[20]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[21]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[22]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[23]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[24]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[25]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[26]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[27]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[28]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[29]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[2]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[30]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[31]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[32]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[33]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[34]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[35]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[36]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[37]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[38]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[39]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[3]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[40]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[41]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[42]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[43]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[44]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[45]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[46]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[47]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[48]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[49]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[4]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[50]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[51]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[52]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[53]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[54]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[55]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[56]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[57]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[58]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[59]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[5]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[60]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[61]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[62]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[63]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[6]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[7]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[8]\ : STD_LOGIC;
  signal \start_addr_reg_n_0_[9]\ : STD_LOGIC;
  signal zero_len_event0 : STD_LOGIC;
  signal NLW_align_len0_carry_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_align_len0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_could_multi_bursts.araddr_buf_reg[4]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_end_addr_buf_reg[5]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \NLW_end_addr_buf_reg[63]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_end_addr_buf_reg[63]_i_1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal NLW_first_sect_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_first_sect_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_first_sect_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_first_sect_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_first_sect_carry__3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_first_sect_carry__3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_last_sect_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_last_sect_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_last_sect_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_last_sect_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_last_sect_carry__3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_last_sect_carry__3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_p_0_out_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_sect_cnt0_carry__11_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_sect_cnt0_carry__11_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of align_len0_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[10]_i_1\ : label is "soft_lutpair162";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[11]_i_1\ : label is "soft_lutpair163";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[12]_i_1\ : label is "soft_lutpair163";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[13]_i_1\ : label is "soft_lutpair162";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[14]_i_1\ : label is "soft_lutpair134";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[15]_i_1\ : label is "soft_lutpair135";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[16]_i_1\ : label is "soft_lutpair135";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[17]_i_1\ : label is "soft_lutpair134";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[18]_i_1\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[19]_i_1\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[20]_i_1\ : label is "soft_lutpair133";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[21]_i_1\ : label is "soft_lutpair132";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[22]_i_1\ : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[23]_i_1\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[24]_i_1\ : label is "soft_lutpair131";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[25]_i_1\ : label is "soft_lutpair130";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[26]_i_1\ : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[27]_i_1\ : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[28]_i_1\ : label is "soft_lutpair129";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[29]_i_1\ : label is "soft_lutpair128";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[2]_i_1\ : label is "soft_lutpair167";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[30]_i_1\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[31]_i_1\ : label is "soft_lutpair127";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[32]_i_1\ : label is "soft_lutpair127";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[33]_i_1\ : label is "soft_lutpair126";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[34]_i_1\ : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[35]_i_1\ : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[36]_i_1\ : label is "soft_lutpair125";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[37]_i_1\ : label is "soft_lutpair124";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[38]_i_1\ : label is "soft_lutpair122";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[39]_i_1\ : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[3]_i_1\ : label is "soft_lutpair167";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[40]_i_1\ : label is "soft_lutpair123";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[41]_i_1\ : label is "soft_lutpair122";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[42]_i_1\ : label is "soft_lutpair120";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[43]_i_1\ : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[44]_i_1\ : label is "soft_lutpair121";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[45]_i_1\ : label is "soft_lutpair120";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[46]_i_1\ : label is "soft_lutpair118";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[47]_i_1\ : label is "soft_lutpair119";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[48]_i_1\ : label is "soft_lutpair119";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[49]_i_1\ : label is "soft_lutpair118";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[4]_i_1\ : label is "soft_lutpair166";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[50]_i_1\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[51]_i_1\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[52]_i_1\ : label is "soft_lutpair117";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[53]_i_1\ : label is "soft_lutpair116";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[54]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[55]_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[56]_i_1\ : label is "soft_lutpair115";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[57]_i_1\ : label is "soft_lutpair114";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[58]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[59]_i_1\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[5]_i_1\ : label is "soft_lutpair166";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[60]_i_1\ : label is "soft_lutpair113";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[61]_i_1\ : label is "soft_lutpair112";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[62]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[63]_i_3\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[6]_i_1\ : label is "soft_lutpair164";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[7]_i_1\ : label is "soft_lutpair165";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[8]_i_1\ : label is "soft_lutpair165";
  attribute SOFT_HLUTNM of \could_multi_bursts.araddr_buf[9]_i_1\ : label is "soft_lutpair164";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[12]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[12]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[16]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[16]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[20]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[20]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[24]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[24]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[28]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[28]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[32]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[32]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[36]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[36]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[40]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[40]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[44]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[44]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[48]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[48]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[4]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[4]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[52]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[52]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[56]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[56]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[60]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[60]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[63]_i_5\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[63]_i_5\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \could_multi_bursts.araddr_buf_reg[8]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \could_multi_bursts.araddr_buf_reg[8]_i_2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \could_multi_bursts.arlen_buf[4]_i_3\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \could_multi_bursts.loop_cnt[0]_i_1\ : label is "soft_lutpair168";
  attribute SOFT_HLUTNM of \could_multi_bursts.loop_cnt[1]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \could_multi_bursts.loop_cnt[2]_i_1\ : label is "soft_lutpair168";
  attribute SOFT_HLUTNM of \could_multi_bursts.loop_cnt[3]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \could_multi_bursts.loop_cnt[4]_i_2\ : label is "soft_lutpair110";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[13]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[13]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[17]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[17]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[21]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[21]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[25]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[25]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[29]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[29]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[33]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[33]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[37]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[37]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[41]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[41]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[45]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[45]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[49]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[49]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[53]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[53]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[57]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[57]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[5]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[5]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[61]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[61]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[63]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[63]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \end_addr_buf_reg[9]_i_1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \end_addr_buf_reg[9]_i_1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of first_sect_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \first_sect_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \first_sect_carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \first_sect_carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \first_sect_carry__3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of last_sect_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \last_sect_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \last_sect_carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \last_sect_carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \last_sect_carry__3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of p_0_out_carry : label is 35;
  attribute METHODOLOGY_DRC_VIOS of p_0_out_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \p_0_out_carry__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \p_0_out_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \sect_addr_buf[10]_i_1\ : label is "soft_lutpair169";
  attribute SOFT_HLUTNM of \sect_addr_buf[11]_i_2\ : label is "soft_lutpair169";
  attribute SOFT_HLUTNM of \sect_addr_buf[12]_i_1\ : label is "soft_lutpair161";
  attribute SOFT_HLUTNM of \sect_addr_buf[13]_i_1\ : label is "soft_lutpair161";
  attribute SOFT_HLUTNM of \sect_addr_buf[14]_i_1\ : label is "soft_lutpair160";
  attribute SOFT_HLUTNM of \sect_addr_buf[15]_i_1\ : label is "soft_lutpair160";
  attribute SOFT_HLUTNM of \sect_addr_buf[16]_i_1\ : label is "soft_lutpair159";
  attribute SOFT_HLUTNM of \sect_addr_buf[17]_i_1\ : label is "soft_lutpair159";
  attribute SOFT_HLUTNM of \sect_addr_buf[18]_i_1\ : label is "soft_lutpair158";
  attribute SOFT_HLUTNM of \sect_addr_buf[19]_i_1\ : label is "soft_lutpair158";
  attribute SOFT_HLUTNM of \sect_addr_buf[20]_i_1\ : label is "soft_lutpair157";
  attribute SOFT_HLUTNM of \sect_addr_buf[21]_i_1\ : label is "soft_lutpair157";
  attribute SOFT_HLUTNM of \sect_addr_buf[22]_i_1\ : label is "soft_lutpair156";
  attribute SOFT_HLUTNM of \sect_addr_buf[23]_i_1\ : label is "soft_lutpair156";
  attribute SOFT_HLUTNM of \sect_addr_buf[24]_i_1\ : label is "soft_lutpair155";
  attribute SOFT_HLUTNM of \sect_addr_buf[25]_i_1\ : label is "soft_lutpair155";
  attribute SOFT_HLUTNM of \sect_addr_buf[26]_i_1\ : label is "soft_lutpair154";
  attribute SOFT_HLUTNM of \sect_addr_buf[27]_i_1\ : label is "soft_lutpair154";
  attribute SOFT_HLUTNM of \sect_addr_buf[28]_i_1\ : label is "soft_lutpair153";
  attribute SOFT_HLUTNM of \sect_addr_buf[29]_i_1\ : label is "soft_lutpair153";
  attribute SOFT_HLUTNM of \sect_addr_buf[2]_i_1\ : label is "soft_lutpair173";
  attribute SOFT_HLUTNM of \sect_addr_buf[30]_i_1\ : label is "soft_lutpair152";
  attribute SOFT_HLUTNM of \sect_addr_buf[31]_i_1\ : label is "soft_lutpair152";
  attribute SOFT_HLUTNM of \sect_addr_buf[32]_i_1\ : label is "soft_lutpair151";
  attribute SOFT_HLUTNM of \sect_addr_buf[33]_i_1\ : label is "soft_lutpair151";
  attribute SOFT_HLUTNM of \sect_addr_buf[34]_i_1\ : label is "soft_lutpair150";
  attribute SOFT_HLUTNM of \sect_addr_buf[35]_i_1\ : label is "soft_lutpair150";
  attribute SOFT_HLUTNM of \sect_addr_buf[36]_i_1\ : label is "soft_lutpair149";
  attribute SOFT_HLUTNM of \sect_addr_buf[37]_i_1\ : label is "soft_lutpair149";
  attribute SOFT_HLUTNM of \sect_addr_buf[38]_i_1\ : label is "soft_lutpair148";
  attribute SOFT_HLUTNM of \sect_addr_buf[39]_i_1\ : label is "soft_lutpair148";
  attribute SOFT_HLUTNM of \sect_addr_buf[3]_i_1\ : label is "soft_lutpair173";
  attribute SOFT_HLUTNM of \sect_addr_buf[40]_i_1\ : label is "soft_lutpair147";
  attribute SOFT_HLUTNM of \sect_addr_buf[41]_i_1\ : label is "soft_lutpair147";
  attribute SOFT_HLUTNM of \sect_addr_buf[42]_i_1\ : label is "soft_lutpair146";
  attribute SOFT_HLUTNM of \sect_addr_buf[43]_i_1\ : label is "soft_lutpair146";
  attribute SOFT_HLUTNM of \sect_addr_buf[44]_i_1\ : label is "soft_lutpair145";
  attribute SOFT_HLUTNM of \sect_addr_buf[45]_i_1\ : label is "soft_lutpair145";
  attribute SOFT_HLUTNM of \sect_addr_buf[46]_i_1\ : label is "soft_lutpair144";
  attribute SOFT_HLUTNM of \sect_addr_buf[47]_i_1\ : label is "soft_lutpair144";
  attribute SOFT_HLUTNM of \sect_addr_buf[48]_i_1\ : label is "soft_lutpair143";
  attribute SOFT_HLUTNM of \sect_addr_buf[49]_i_1\ : label is "soft_lutpair143";
  attribute SOFT_HLUTNM of \sect_addr_buf[4]_i_1\ : label is "soft_lutpair172";
  attribute SOFT_HLUTNM of \sect_addr_buf[50]_i_1\ : label is "soft_lutpair142";
  attribute SOFT_HLUTNM of \sect_addr_buf[51]_i_1\ : label is "soft_lutpair142";
  attribute SOFT_HLUTNM of \sect_addr_buf[52]_i_1\ : label is "soft_lutpair141";
  attribute SOFT_HLUTNM of \sect_addr_buf[53]_i_1\ : label is "soft_lutpair141";
  attribute SOFT_HLUTNM of \sect_addr_buf[54]_i_1\ : label is "soft_lutpair140";
  attribute SOFT_HLUTNM of \sect_addr_buf[55]_i_1\ : label is "soft_lutpair140";
  attribute SOFT_HLUTNM of \sect_addr_buf[56]_i_1\ : label is "soft_lutpair139";
  attribute SOFT_HLUTNM of \sect_addr_buf[57]_i_1\ : label is "soft_lutpair139";
  attribute SOFT_HLUTNM of \sect_addr_buf[58]_i_1\ : label is "soft_lutpair138";
  attribute SOFT_HLUTNM of \sect_addr_buf[59]_i_1\ : label is "soft_lutpair138";
  attribute SOFT_HLUTNM of \sect_addr_buf[5]_i_1\ : label is "soft_lutpair172";
  attribute SOFT_HLUTNM of \sect_addr_buf[60]_i_1\ : label is "soft_lutpair137";
  attribute SOFT_HLUTNM of \sect_addr_buf[61]_i_1\ : label is "soft_lutpair137";
  attribute SOFT_HLUTNM of \sect_addr_buf[62]_i_1\ : label is "soft_lutpair136";
  attribute SOFT_HLUTNM of \sect_addr_buf[63]_i_1\ : label is "soft_lutpair136";
  attribute SOFT_HLUTNM of \sect_addr_buf[6]_i_1\ : label is "soft_lutpair171";
  attribute SOFT_HLUTNM of \sect_addr_buf[7]_i_1\ : label is "soft_lutpair171";
  attribute SOFT_HLUTNM of \sect_addr_buf[8]_i_1\ : label is "soft_lutpair170";
  attribute SOFT_HLUTNM of \sect_addr_buf[9]_i_1\ : label is "soft_lutpair170";
  attribute ADDER_THRESHOLD of sect_cnt0_carry : label is 35;
  attribute METHODOLOGY_DRC_VIOS of sect_cnt0_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__10\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__10\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__11\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__11\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__5\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__5\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__6\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__6\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__7\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__7\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__8\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__8\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \sect_cnt0_carry__9\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \sect_cnt0_carry__9\ : label is "{SYNTH-8 {cell *THIS*}}";
begin
  SR(0) <= \^sr\(0);
  \could_multi_bursts.ARVALID_Dummy_reg_0\ <= \^could_multi_bursts.arvalid_dummy_reg_0\;
  \could_multi_bursts.arlen_buf_reg[4]_0\(4 downto 0) <= \^could_multi_bursts.arlen_buf_reg[4]_0\(4 downto 0);
  m_axi_gmem_ARADDR(61 downto 0) <= \^m_axi_gmem_araddr\(61 downto 0);
align_len0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3 downto 2) => NLW_align_len0_carry_CO_UNCONNECTED(3 downto 2),
      CO(1) => align_len0_carry_n_2,
      CO(0) => align_len0_carry_n_3,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => fifo_rreq_data(64),
      DI(0) => '0',
      O(3) => NLW_align_len0_carry_O_UNCONNECTED(3),
      O(2) => align_len0(31),
      O(1) => align_len0(2),
      O(0) => NLW_align_len0_carry_O_UNCONNECTED(0),
      S(3 downto 2) => B"01",
      S(1) => zero_len_event0,
      S(0) => '1'
    );
\align_len_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => align_len0(2),
      Q => \align_len_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\align_len_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => align_len0(31),
      Q => \align_len_reg_n_0_[31]\,
      R => \^sr\(0)
    );
\beat_len_buf_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \align_len_reg_n_0_[2]\,
      Q => beat_len_buf(0),
      R => \^sr\(0)
    );
\beat_len_buf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \align_len_reg_n_0_[31]\,
      Q => beat_len_buf(7),
      R => \^sr\(0)
    );
buff_rdata: entity work.\decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_buffer__parameterized0\
     port map (
      D(32 downto 0) => D(32 downto 0),
      DI(0) => mOutPtr19_out,
      Q(6 downto 0) => mOutPtr_reg(6 downto 0),
      S(3) => buff_rdata_n_4,
      S(2) => buff_rdata_n_5,
      S(1) => buff_rdata_n_6,
      S(0) => buff_rdata_n_7,
      SR(0) => \^sr\(0),
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      beat_valid => beat_valid,
      \dout_buf_reg[34]_0\(32) => data_pack(34),
      \dout_buf_reg[34]_0\(31) => buff_rdata_n_22,
      \dout_buf_reg[34]_0\(30) => buff_rdata_n_23,
      \dout_buf_reg[34]_0\(29) => buff_rdata_n_24,
      \dout_buf_reg[34]_0\(28) => buff_rdata_n_25,
      \dout_buf_reg[34]_0\(27) => buff_rdata_n_26,
      \dout_buf_reg[34]_0\(26) => buff_rdata_n_27,
      \dout_buf_reg[34]_0\(25) => buff_rdata_n_28,
      \dout_buf_reg[34]_0\(24) => buff_rdata_n_29,
      \dout_buf_reg[34]_0\(23) => buff_rdata_n_30,
      \dout_buf_reg[34]_0\(22) => buff_rdata_n_31,
      \dout_buf_reg[34]_0\(21) => buff_rdata_n_32,
      \dout_buf_reg[34]_0\(20) => buff_rdata_n_33,
      \dout_buf_reg[34]_0\(19) => buff_rdata_n_34,
      \dout_buf_reg[34]_0\(18) => buff_rdata_n_35,
      \dout_buf_reg[34]_0\(17) => buff_rdata_n_36,
      \dout_buf_reg[34]_0\(16) => buff_rdata_n_37,
      \dout_buf_reg[34]_0\(15) => buff_rdata_n_38,
      \dout_buf_reg[34]_0\(14) => buff_rdata_n_39,
      \dout_buf_reg[34]_0\(13) => buff_rdata_n_40,
      \dout_buf_reg[34]_0\(12) => buff_rdata_n_41,
      \dout_buf_reg[34]_0\(11) => buff_rdata_n_42,
      \dout_buf_reg[34]_0\(10) => buff_rdata_n_43,
      \dout_buf_reg[34]_0\(9) => buff_rdata_n_44,
      \dout_buf_reg[34]_0\(8) => buff_rdata_n_45,
      \dout_buf_reg[34]_0\(7) => buff_rdata_n_46,
      \dout_buf_reg[34]_0\(6) => buff_rdata_n_47,
      \dout_buf_reg[34]_0\(5) => buff_rdata_n_48,
      \dout_buf_reg[34]_0\(4) => buff_rdata_n_49,
      \dout_buf_reg[34]_0\(3) => buff_rdata_n_50,
      \dout_buf_reg[34]_0\(2) => buff_rdata_n_51,
      \dout_buf_reg[34]_0\(1) => buff_rdata_n_52,
      \dout_buf_reg[34]_0\(0) => buff_rdata_n_53,
      dout_valid_reg_0 => buff_rdata_n_3,
      dout_valid_reg_1 => \bus_equal_gen.rdata_valid_t_reg_n_0\,
      empty_n_reg_0 => buff_rdata_n_20,
      full_n_reg_0 => full_n_reg,
      \mOutPtr_reg[8]_0\(3) => buff_rdata_n_15,
      \mOutPtr_reg[8]_0\(2) => buff_rdata_n_16,
      \mOutPtr_reg[8]_0\(1) => buff_rdata_n_17,
      \mOutPtr_reg[8]_0\(0) => buff_rdata_n_18,
      \mOutPtr_reg[8]_1\(7) => \p_0_out_carry__0_n_4\,
      \mOutPtr_reg[8]_1\(6) => \p_0_out_carry__0_n_5\,
      \mOutPtr_reg[8]_1\(5) => \p_0_out_carry__0_n_6\,
      \mOutPtr_reg[8]_1\(4) => \p_0_out_carry__0_n_7\,
      \mOutPtr_reg[8]_1\(3) => p_0_out_carry_n_4,
      \mOutPtr_reg[8]_1\(2) => p_0_out_carry_n_5,
      \mOutPtr_reg[8]_1\(1) => p_0_out_carry_n_6,
      \mOutPtr_reg[8]_1\(0) => p_0_out_carry_n_7,
      m_axi_gmem_RRESP(1 downto 0) => m_axi_gmem_RRESP(1 downto 0),
      m_axi_gmem_RVALID => m_axi_gmem_RVALID,
      \pout_reg[3]\ => fifo_rctl_n_0,
      rdata_ack_t => rdata_ack_t
    );
\bus_equal_gen.data_buf_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_53,
      Q => \bus_equal_gen.data_buf_reg_n_0_[0]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_43,
      Q => \bus_equal_gen.data_buf_reg_n_0_[10]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_42,
      Q => \bus_equal_gen.data_buf_reg_n_0_[11]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_41,
      Q => \bus_equal_gen.data_buf_reg_n_0_[12]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_40,
      Q => \bus_equal_gen.data_buf_reg_n_0_[13]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_39,
      Q => \bus_equal_gen.data_buf_reg_n_0_[14]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_38,
      Q => \bus_equal_gen.data_buf_reg_n_0_[15]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_37,
      Q => \bus_equal_gen.data_buf_reg_n_0_[16]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_36,
      Q => \bus_equal_gen.data_buf_reg_n_0_[17]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_35,
      Q => \bus_equal_gen.data_buf_reg_n_0_[18]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_34,
      Q => \bus_equal_gen.data_buf_reg_n_0_[19]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_52,
      Q => \bus_equal_gen.data_buf_reg_n_0_[1]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_33,
      Q => \bus_equal_gen.data_buf_reg_n_0_[20]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_32,
      Q => \bus_equal_gen.data_buf_reg_n_0_[21]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_31,
      Q => \bus_equal_gen.data_buf_reg_n_0_[22]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_30,
      Q => \bus_equal_gen.data_buf_reg_n_0_[23]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_29,
      Q => \bus_equal_gen.data_buf_reg_n_0_[24]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_28,
      Q => \bus_equal_gen.data_buf_reg_n_0_[25]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_27,
      Q => \bus_equal_gen.data_buf_reg_n_0_[26]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_26,
      Q => \bus_equal_gen.data_buf_reg_n_0_[27]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_25,
      Q => \bus_equal_gen.data_buf_reg_n_0_[28]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_24,
      Q => \bus_equal_gen.data_buf_reg_n_0_[29]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_51,
      Q => \bus_equal_gen.data_buf_reg_n_0_[2]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_23,
      Q => \bus_equal_gen.data_buf_reg_n_0_[30]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_22,
      Q => \bus_equal_gen.data_buf_reg_n_0_[31]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_50,
      Q => \bus_equal_gen.data_buf_reg_n_0_[3]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_49,
      Q => \bus_equal_gen.data_buf_reg_n_0_[4]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_48,
      Q => \bus_equal_gen.data_buf_reg_n_0_[5]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_47,
      Q => \bus_equal_gen.data_buf_reg_n_0_[6]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_46,
      Q => \bus_equal_gen.data_buf_reg_n_0_[7]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_45,
      Q => \bus_equal_gen.data_buf_reg_n_0_[8]\,
      R => '0'
    );
\bus_equal_gen.data_buf_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_beat,
      D => buff_rdata_n_44,
      Q => \bus_equal_gen.data_buf_reg_n_0_[9]\,
      R => '0'
    );
\bus_equal_gen.rdata_valid_t_reg\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => buff_rdata_n_3,
      Q => \bus_equal_gen.rdata_valid_t_reg_n_0\,
      R => \^sr\(0)
    );
\could_multi_bursts.ARVALID_Dummy_reg\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => fifo_rctl_n_13,
      Q => \^could_multi_bursts.arvalid_dummy_reg_0\,
      R => '0'
    );
\could_multi_bursts.araddr_buf[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[10]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(10),
      O => araddr_tmp(10)
    );
\could_multi_bursts.araddr_buf[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[11]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(11),
      O => araddr_tmp(11)
    );
\could_multi_bursts.araddr_buf[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[12]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(12),
      O => araddr_tmp(12)
    );
\could_multi_bursts.araddr_buf[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[13]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(13),
      O => araddr_tmp(13)
    );
\could_multi_bursts.araddr_buf[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[14]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(14),
      O => araddr_tmp(14)
    );
\could_multi_bursts.araddr_buf[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[15]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(15),
      O => araddr_tmp(15)
    );
\could_multi_bursts.araddr_buf[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[16]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(16),
      O => araddr_tmp(16)
    );
\could_multi_bursts.araddr_buf[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[17]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(17),
      O => araddr_tmp(17)
    );
\could_multi_bursts.araddr_buf[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[18]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(18),
      O => araddr_tmp(18)
    );
\could_multi_bursts.araddr_buf[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[19]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(19),
      O => araddr_tmp(19)
    );
\could_multi_bursts.araddr_buf[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[20]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(20),
      O => araddr_tmp(20)
    );
\could_multi_bursts.araddr_buf[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[21]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(21),
      O => araddr_tmp(21)
    );
\could_multi_bursts.araddr_buf[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[22]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(22),
      O => araddr_tmp(22)
    );
\could_multi_bursts.araddr_buf[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[23]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(23),
      O => araddr_tmp(23)
    );
\could_multi_bursts.araddr_buf[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[24]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(24),
      O => araddr_tmp(24)
    );
\could_multi_bursts.araddr_buf[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[25]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(25),
      O => araddr_tmp(25)
    );
\could_multi_bursts.araddr_buf[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[26]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(26),
      O => araddr_tmp(26)
    );
\could_multi_bursts.araddr_buf[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[27]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(27),
      O => araddr_tmp(27)
    );
\could_multi_bursts.araddr_buf[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[28]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(28),
      O => araddr_tmp(28)
    );
\could_multi_bursts.araddr_buf[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[29]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(29),
      O => araddr_tmp(29)
    );
\could_multi_bursts.araddr_buf[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[2]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(2),
      O => araddr_tmp(2)
    );
\could_multi_bursts.araddr_buf[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[30]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(30),
      O => araddr_tmp(30)
    );
\could_multi_bursts.araddr_buf[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[31]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(31),
      O => araddr_tmp(31)
    );
\could_multi_bursts.araddr_buf[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[32]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(32),
      O => araddr_tmp(32)
    );
\could_multi_bursts.araddr_buf[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[33]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(33),
      O => araddr_tmp(33)
    );
\could_multi_bursts.araddr_buf[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[34]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(34),
      O => araddr_tmp(34)
    );
\could_multi_bursts.araddr_buf[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[35]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(35),
      O => araddr_tmp(35)
    );
\could_multi_bursts.araddr_buf[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[36]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(36),
      O => araddr_tmp(36)
    );
\could_multi_bursts.araddr_buf[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[37]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(37),
      O => araddr_tmp(37)
    );
\could_multi_bursts.araddr_buf[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[38]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(38),
      O => araddr_tmp(38)
    );
\could_multi_bursts.araddr_buf[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[39]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(39),
      O => araddr_tmp(39)
    );
\could_multi_bursts.araddr_buf[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[3]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(3),
      O => araddr_tmp(3)
    );
\could_multi_bursts.araddr_buf[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[40]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(40),
      O => araddr_tmp(40)
    );
\could_multi_bursts.araddr_buf[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[41]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(41),
      O => araddr_tmp(41)
    );
\could_multi_bursts.araddr_buf[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[42]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(42),
      O => araddr_tmp(42)
    );
\could_multi_bursts.araddr_buf[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[43]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(43),
      O => araddr_tmp(43)
    );
\could_multi_bursts.araddr_buf[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[44]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(44),
      O => araddr_tmp(44)
    );
\could_multi_bursts.araddr_buf[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[45]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(45),
      O => araddr_tmp(45)
    );
\could_multi_bursts.araddr_buf[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[46]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(46),
      O => araddr_tmp(46)
    );
\could_multi_bursts.araddr_buf[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[47]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(47),
      O => araddr_tmp(47)
    );
\could_multi_bursts.araddr_buf[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[48]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(48),
      O => araddr_tmp(48)
    );
\could_multi_bursts.araddr_buf[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[49]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(49),
      O => araddr_tmp(49)
    );
\could_multi_bursts.araddr_buf[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[4]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(4),
      O => araddr_tmp(4)
    );
\could_multi_bursts.araddr_buf[4]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"956A"
    )
        port map (
      I0 => \^m_axi_gmem_araddr\(2),
      I1 => \^could_multi_bursts.arlen_buf_reg[4]_0\(0),
      I2 => \^could_multi_bursts.arlen_buf_reg[4]_0\(1),
      I3 => \^could_multi_bursts.arlen_buf_reg[4]_0\(2),
      O => \could_multi_bursts.araddr_buf[4]_i_3_n_0\
    );
\could_multi_bursts.araddr_buf[4]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^m_axi_gmem_araddr\(1),
      I1 => \^could_multi_bursts.arlen_buf_reg[4]_0\(1),
      I2 => \^could_multi_bursts.arlen_buf_reg[4]_0\(0),
      O => \could_multi_bursts.araddr_buf[4]_i_4_n_0\
    );
\could_multi_bursts.araddr_buf[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \^m_axi_gmem_araddr\(0),
      I1 => \^could_multi_bursts.arlen_buf_reg[4]_0\(0),
      O => \could_multi_bursts.araddr_buf[4]_i_5_n_0\
    );
\could_multi_bursts.araddr_buf[50]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[50]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(50),
      O => araddr_tmp(50)
    );
\could_multi_bursts.araddr_buf[51]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[51]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(51),
      O => araddr_tmp(51)
    );
\could_multi_bursts.araddr_buf[52]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[52]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(52),
      O => araddr_tmp(52)
    );
\could_multi_bursts.araddr_buf[53]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[53]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(53),
      O => araddr_tmp(53)
    );
\could_multi_bursts.araddr_buf[54]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[54]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(54),
      O => araddr_tmp(54)
    );
\could_multi_bursts.araddr_buf[55]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[55]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(55),
      O => araddr_tmp(55)
    );
\could_multi_bursts.araddr_buf[56]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[56]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(56),
      O => araddr_tmp(56)
    );
\could_multi_bursts.araddr_buf[57]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[57]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(57),
      O => araddr_tmp(57)
    );
\could_multi_bursts.araddr_buf[58]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[58]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(58),
      O => araddr_tmp(58)
    );
\could_multi_bursts.araddr_buf[59]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[59]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(59),
      O => araddr_tmp(59)
    );
\could_multi_bursts.araddr_buf[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[5]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(5),
      O => araddr_tmp(5)
    );
\could_multi_bursts.araddr_buf[60]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[60]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(60),
      O => araddr_tmp(60)
    );
\could_multi_bursts.araddr_buf[61]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[61]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(61),
      O => araddr_tmp(61)
    );
\could_multi_bursts.araddr_buf[62]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[62]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(62),
      O => araddr_tmp(62)
    );
\could_multi_bursts.araddr_buf[63]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[63]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(63),
      O => araddr_tmp(63)
    );
\could_multi_bursts.araddr_buf[63]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \could_multi_bursts.loop_cnt_reg\(0),
      I1 => \could_multi_bursts.loop_cnt_reg\(1),
      I2 => \could_multi_bursts.loop_cnt_reg\(4),
      I3 => \could_multi_bursts.loop_cnt_reg\(2),
      I4 => \could_multi_bursts.loop_cnt_reg\(3),
      O => \could_multi_bursts.araddr_buf[63]_i_4_n_0\
    );
\could_multi_bursts.araddr_buf[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[6]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(6),
      O => araddr_tmp(6)
    );
\could_multi_bursts.araddr_buf[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[7]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(7),
      O => araddr_tmp(7)
    );
\could_multi_bursts.araddr_buf[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[8]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(8),
      O => araddr_tmp(8)
    );
\could_multi_bursts.araddr_buf[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \^m_axi_gmem_araddr\(5),
      I1 => \^could_multi_bursts.arlen_buf_reg[4]_0\(3),
      I2 => \^could_multi_bursts.arlen_buf_reg[4]_0\(0),
      I3 => \^could_multi_bursts.arlen_buf_reg[4]_0\(1),
      I4 => \^could_multi_bursts.arlen_buf_reg[4]_0\(2),
      I5 => \^could_multi_bursts.arlen_buf_reg[4]_0\(4),
      O => \could_multi_bursts.araddr_buf[8]_i_3_n_0\
    );
\could_multi_bursts.araddr_buf[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"955555556AAAAAAA"
    )
        port map (
      I0 => \^m_axi_gmem_araddr\(4),
      I1 => \^could_multi_bursts.arlen_buf_reg[4]_0\(3),
      I2 => \^could_multi_bursts.arlen_buf_reg[4]_0\(0),
      I3 => \^could_multi_bursts.arlen_buf_reg[4]_0\(1),
      I4 => \^could_multi_bursts.arlen_buf_reg[4]_0\(2),
      I5 => \^could_multi_bursts.arlen_buf_reg[4]_0\(4),
      O => \could_multi_bursts.araddr_buf[8]_i_4_n_0\
    );
\could_multi_bursts.araddr_buf[8]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"95556AAA"
    )
        port map (
      I0 => \^m_axi_gmem_araddr\(3),
      I1 => \^could_multi_bursts.arlen_buf_reg[4]_0\(2),
      I2 => \^could_multi_bursts.arlen_buf_reg[4]_0\(1),
      I3 => \^could_multi_bursts.arlen_buf_reg[4]_0\(0),
      I4 => \^could_multi_bursts.arlen_buf_reg[4]_0\(3),
      O => \could_multi_bursts.araddr_buf[8]_i_5_n_0\
    );
\could_multi_bursts.araddr_buf[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \sect_addr_buf_reg_n_0_[9]\,
      I1 => \could_multi_bursts.araddr_buf[63]_i_4_n_0\,
      I2 => data1(9),
      O => araddr_tmp(9)
    );
\could_multi_bursts.araddr_buf_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(10),
      Q => \^m_axi_gmem_araddr\(8),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(11),
      Q => \^m_axi_gmem_araddr\(9),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(12),
      Q => \^m_axi_gmem_araddr\(10),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[8]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[12]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[12]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[12]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1 downto 0) => \^m_axi_gmem_araddr\(8 downto 7),
      O(3 downto 0) => data1(12 downto 9),
      S(3 downto 0) => \^m_axi_gmem_araddr\(10 downto 7)
    );
\could_multi_bursts.araddr_buf_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(13),
      Q => \^m_axi_gmem_araddr\(11),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(14),
      Q => \^m_axi_gmem_araddr\(12),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(15),
      Q => \^m_axi_gmem_araddr\(13),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(16),
      Q => \^m_axi_gmem_araddr\(14),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[16]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[12]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[16]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[16]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[16]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[16]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(16 downto 13),
      S(3 downto 0) => \^m_axi_gmem_araddr\(14 downto 11)
    );
\could_multi_bursts.araddr_buf_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(17),
      Q => \^m_axi_gmem_araddr\(15),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(18),
      Q => \^m_axi_gmem_araddr\(16),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(19),
      Q => \^m_axi_gmem_araddr\(17),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(20),
      Q => \^m_axi_gmem_araddr\(18),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[20]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[16]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[20]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[20]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[20]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[20]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(20 downto 17),
      S(3 downto 0) => \^m_axi_gmem_araddr\(18 downto 15)
    );
\could_multi_bursts.araddr_buf_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(21),
      Q => \^m_axi_gmem_araddr\(19),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(22),
      Q => \^m_axi_gmem_araddr\(20),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(23),
      Q => \^m_axi_gmem_araddr\(21),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(24),
      Q => \^m_axi_gmem_araddr\(22),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[24]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[20]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[24]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[24]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[24]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[24]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(24 downto 21),
      S(3 downto 0) => \^m_axi_gmem_araddr\(22 downto 19)
    );
\could_multi_bursts.araddr_buf_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(25),
      Q => \^m_axi_gmem_araddr\(23),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(26),
      Q => \^m_axi_gmem_araddr\(24),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(27),
      Q => \^m_axi_gmem_araddr\(25),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(28),
      Q => \^m_axi_gmem_araddr\(26),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[28]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[24]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[28]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[28]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[28]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[28]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(28 downto 25),
      S(3 downto 0) => \^m_axi_gmem_araddr\(26 downto 23)
    );
\could_multi_bursts.araddr_buf_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(29),
      Q => \^m_axi_gmem_araddr\(27),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(2),
      Q => \^m_axi_gmem_araddr\(0),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(30),
      Q => \^m_axi_gmem_araddr\(28),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(31),
      Q => \^m_axi_gmem_araddr\(29),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(32),
      Q => \^m_axi_gmem_araddr\(30),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[32]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[28]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[32]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[32]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[32]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[32]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(32 downto 29),
      S(3 downto 0) => \^m_axi_gmem_araddr\(30 downto 27)
    );
\could_multi_bursts.araddr_buf_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(33),
      Q => \^m_axi_gmem_araddr\(31),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(34),
      Q => \^m_axi_gmem_araddr\(32),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(35),
      Q => \^m_axi_gmem_araddr\(33),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(36),
      Q => \^m_axi_gmem_araddr\(34),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[36]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[32]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[36]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[36]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[36]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[36]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(36 downto 33),
      S(3 downto 0) => \^m_axi_gmem_araddr\(34 downto 31)
    );
\could_multi_bursts.araddr_buf_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(37),
      Q => \^m_axi_gmem_araddr\(35),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(38),
      Q => \^m_axi_gmem_araddr\(36),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(39),
      Q => \^m_axi_gmem_araddr\(37),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(3),
      Q => \^m_axi_gmem_araddr\(1),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(40),
      Q => \^m_axi_gmem_araddr\(38),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[40]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[36]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[40]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[40]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[40]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[40]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(40 downto 37),
      S(3 downto 0) => \^m_axi_gmem_araddr\(38 downto 35)
    );
\could_multi_bursts.araddr_buf_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(41),
      Q => \^m_axi_gmem_araddr\(39),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(42),
      Q => \^m_axi_gmem_araddr\(40),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(43),
      Q => \^m_axi_gmem_araddr\(41),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(44),
      Q => \^m_axi_gmem_araddr\(42),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[44]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[40]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[44]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[44]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[44]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[44]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(44 downto 41),
      S(3 downto 0) => \^m_axi_gmem_araddr\(42 downto 39)
    );
\could_multi_bursts.araddr_buf_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(45),
      Q => \^m_axi_gmem_araddr\(43),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(46),
      Q => \^m_axi_gmem_araddr\(44),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(47),
      Q => \^m_axi_gmem_araddr\(45),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(48),
      Q => \^m_axi_gmem_araddr\(46),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[48]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[44]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[48]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[48]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[48]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[48]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(48 downto 45),
      S(3 downto 0) => \^m_axi_gmem_araddr\(46 downto 43)
    );
\could_multi_bursts.araddr_buf_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(49),
      Q => \^m_axi_gmem_araddr\(47),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(4),
      Q => \^m_axi_gmem_araddr\(2),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \could_multi_bursts.araddr_buf_reg[4]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[4]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[4]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[4]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => \^m_axi_gmem_araddr\(2 downto 0),
      DI(0) => '0',
      O(3 downto 1) => data1(4 downto 2),
      O(0) => \NLW_could_multi_bursts.araddr_buf_reg[4]_i_2_O_UNCONNECTED\(0),
      S(3) => \could_multi_bursts.araddr_buf[4]_i_3_n_0\,
      S(2) => \could_multi_bursts.araddr_buf[4]_i_4_n_0\,
      S(1) => \could_multi_bursts.araddr_buf[4]_i_5_n_0\,
      S(0) => '0'
    );
\could_multi_bursts.araddr_buf_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(50),
      Q => \^m_axi_gmem_araddr\(48),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(51),
      Q => \^m_axi_gmem_araddr\(49),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(52),
      Q => \^m_axi_gmem_araddr\(50),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[52]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[48]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[52]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[52]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[52]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[52]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(52 downto 49),
      S(3 downto 0) => \^m_axi_gmem_araddr\(50 downto 47)
    );
\could_multi_bursts.araddr_buf_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(53),
      Q => \^m_axi_gmem_araddr\(51),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(54),
      Q => \^m_axi_gmem_araddr\(52),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(55),
      Q => \^m_axi_gmem_araddr\(53),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(56),
      Q => \^m_axi_gmem_araddr\(54),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[56]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[52]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[56]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[56]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[56]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[56]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(56 downto 53),
      S(3 downto 0) => \^m_axi_gmem_araddr\(54 downto 51)
    );
\could_multi_bursts.araddr_buf_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(57),
      Q => \^m_axi_gmem_araddr\(55),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(58),
      Q => \^m_axi_gmem_araddr\(56),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(59),
      Q => \^m_axi_gmem_araddr\(57),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(5),
      Q => \^m_axi_gmem_araddr\(3),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(60),
      Q => \^m_axi_gmem_araddr\(58),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[60]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[56]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[60]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[60]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[60]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[60]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data1(60 downto 57),
      S(3 downto 0) => \^m_axi_gmem_araddr\(58 downto 55)
    );
\could_multi_bursts.araddr_buf_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(61),
      Q => \^m_axi_gmem_araddr\(59),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(62),
      Q => \^m_axi_gmem_araddr\(60),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(63),
      Q => \^m_axi_gmem_araddr\(61),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[63]_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[60]_i_2_n_0\,
      CO(3 downto 2) => \NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \could_multi_bursts.araddr_buf_reg[63]_i_5_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[63]_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_could_multi_bursts.araddr_buf_reg[63]_i_5_O_UNCONNECTED\(3),
      O(2 downto 0) => data1(63 downto 61),
      S(3) => '0',
      S(2 downto 0) => \^m_axi_gmem_araddr\(61 downto 59)
    );
\could_multi_bursts.araddr_buf_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(6),
      Q => \^m_axi_gmem_araddr\(4),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(7),
      Q => \^m_axi_gmem_araddr\(5),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(8),
      Q => \^m_axi_gmem_araddr\(6),
      R => \^sr\(0)
    );
\could_multi_bursts.araddr_buf_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \could_multi_bursts.araddr_buf_reg[4]_i_2_n_0\,
      CO(3) => \could_multi_bursts.araddr_buf_reg[8]_i_2_n_0\,
      CO(2) => \could_multi_bursts.araddr_buf_reg[8]_i_2_n_1\,
      CO(1) => \could_multi_bursts.araddr_buf_reg[8]_i_2_n_2\,
      CO(0) => \could_multi_bursts.araddr_buf_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \^m_axi_gmem_araddr\(6 downto 3),
      O(3 downto 0) => data1(8 downto 5),
      S(3) => \^m_axi_gmem_araddr\(6),
      S(2) => \could_multi_bursts.araddr_buf[8]_i_3_n_0\,
      S(1) => \could_multi_bursts.araddr_buf[8]_i_4_n_0\,
      S(0) => \could_multi_bursts.araddr_buf[8]_i_5_n_0\
    );
\could_multi_bursts.araddr_buf_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => araddr_tmp(9),
      Q => \^m_axi_gmem_araddr\(7),
      R => \^sr\(0)
    );
\could_multi_bursts.arlen_buf[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00009009"
    )
        port map (
      I0 => \could_multi_bursts.loop_cnt_reg\(0),
      I1 => \sect_len_buf_reg_n_0_[5]\,
      I2 => \could_multi_bursts.loop_cnt_reg\(1),
      I3 => \sect_len_buf_reg_n_0_[6]\,
      I4 => fifo_rreq_n_55,
      O => \could_multi_bursts.arlen_buf[4]_i_3_n_0\
    );
\could_multi_bursts.arlen_buf_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_7,
      D => fifo_rctl_n_8,
      Q => \^could_multi_bursts.arlen_buf_reg[4]_0\(0),
      R => \^sr\(0)
    );
\could_multi_bursts.arlen_buf_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_7,
      D => fifo_rctl_n_9,
      Q => \^could_multi_bursts.arlen_buf_reg[4]_0\(1),
      R => \^sr\(0)
    );
\could_multi_bursts.arlen_buf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_7,
      D => fifo_rctl_n_10,
      Q => \^could_multi_bursts.arlen_buf_reg[4]_0\(2),
      R => \^sr\(0)
    );
\could_multi_bursts.arlen_buf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_7,
      D => fifo_rctl_n_11,
      Q => \^could_multi_bursts.arlen_buf_reg[4]_0\(3),
      R => \^sr\(0)
    );
\could_multi_bursts.arlen_buf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_7,
      D => fifo_rctl_n_12,
      Q => \^could_multi_bursts.arlen_buf_reg[4]_0\(4),
      R => \^sr\(0)
    );
\could_multi_bursts.loop_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \could_multi_bursts.loop_cnt_reg\(0),
      O => p_0_in(0)
    );
\could_multi_bursts.loop_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \could_multi_bursts.loop_cnt_reg\(1),
      I1 => \could_multi_bursts.loop_cnt_reg\(0),
      O => p_0_in(1)
    );
\could_multi_bursts.loop_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \could_multi_bursts.loop_cnt_reg\(2),
      I1 => \could_multi_bursts.loop_cnt_reg\(0),
      I2 => \could_multi_bursts.loop_cnt_reg\(1),
      O => p_0_in(2)
    );
\could_multi_bursts.loop_cnt[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \could_multi_bursts.loop_cnt_reg\(3),
      I1 => \could_multi_bursts.loop_cnt_reg\(1),
      I2 => \could_multi_bursts.loop_cnt_reg\(0),
      I3 => \could_multi_bursts.loop_cnt_reg\(2),
      O => p_0_in(3)
    );
\could_multi_bursts.loop_cnt[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \could_multi_bursts.loop_cnt_reg\(4),
      I1 => \could_multi_bursts.loop_cnt_reg\(2),
      I2 => \could_multi_bursts.loop_cnt_reg\(0),
      I3 => \could_multi_bursts.loop_cnt_reg\(1),
      I4 => \could_multi_bursts.loop_cnt_reg\(3),
      O => p_0_in(4)
    );
\could_multi_bursts.loop_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => p_0_in(0),
      Q => \could_multi_bursts.loop_cnt_reg\(0),
      R => fifo_rctl_n_4
    );
\could_multi_bursts.loop_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => p_0_in(1),
      Q => \could_multi_bursts.loop_cnt_reg\(1),
      R => fifo_rctl_n_4
    );
\could_multi_bursts.loop_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => p_0_in(2),
      Q => \could_multi_bursts.loop_cnt_reg\(2),
      R => fifo_rctl_n_4
    );
\could_multi_bursts.loop_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => p_0_in(3),
      Q => \could_multi_bursts.loop_cnt_reg\(3),
      R => fifo_rctl_n_4
    );
\could_multi_bursts.loop_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_20_in,
      D => p_0_in(4),
      Q => \could_multi_bursts.loop_cnt_reg\(4),
      R => fifo_rctl_n_4
    );
\could_multi_bursts.sect_handling_reg\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => fifo_rctl_n_3,
      Q => \could_multi_bursts.sect_handling_reg_n_0\,
      R => \^sr\(0)
    );
\end_addr_buf[13]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[13]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[13]_i_2_n_0\
    );
\end_addr_buf[13]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[12]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[13]_i_3_n_0\
    );
\end_addr_buf[13]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[11]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[13]_i_4_n_0\
    );
\end_addr_buf[13]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[10]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[13]_i_5_n_0\
    );
\end_addr_buf[17]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[17]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[17]_i_2_n_0\
    );
\end_addr_buf[17]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[16]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[17]_i_3_n_0\
    );
\end_addr_buf[17]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[15]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[17]_i_4_n_0\
    );
\end_addr_buf[17]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[14]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[17]_i_5_n_0\
    );
\end_addr_buf[21]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[21]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[21]_i_2_n_0\
    );
\end_addr_buf[21]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[20]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[21]_i_3_n_0\
    );
\end_addr_buf[21]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[19]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[21]_i_4_n_0\
    );
\end_addr_buf[21]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[18]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[21]_i_5_n_0\
    );
\end_addr_buf[25]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[25]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[25]_i_2_n_0\
    );
\end_addr_buf[25]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[24]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[25]_i_3_n_0\
    );
\end_addr_buf[25]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[23]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[25]_i_4_n_0\
    );
\end_addr_buf[25]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[22]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[25]_i_5_n_0\
    );
\end_addr_buf[29]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[29]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[29]_i_2_n_0\
    );
\end_addr_buf[29]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[28]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[29]_i_3_n_0\
    );
\end_addr_buf[29]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[27]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[29]_i_4_n_0\
    );
\end_addr_buf[29]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[26]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[29]_i_5_n_0\
    );
\end_addr_buf[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[2]\,
      I1 => \align_len_reg_n_0_[2]\,
      O => end_addr(2)
    );
\end_addr_buf[33]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[31]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[33]_i_2_n_0\
    );
\end_addr_buf[33]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[30]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[33]_i_3_n_0\
    );
\end_addr_buf[5]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[5]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[5]_i_2_n_0\
    );
\end_addr_buf[5]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[4]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[5]_i_3_n_0\
    );
\end_addr_buf[5]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[3]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[5]_i_4_n_0\
    );
\end_addr_buf[5]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[2]\,
      I1 => \align_len_reg_n_0_[2]\,
      O => \end_addr_buf[5]_i_5_n_0\
    );
\end_addr_buf[9]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[9]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[9]_i_2_n_0\
    );
\end_addr_buf[9]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[8]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[9]_i_3_n_0\
    );
\end_addr_buf[9]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[7]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[9]_i_4_n_0\
    );
\end_addr_buf[9]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \start_addr_reg_n_0_[6]\,
      I1 => \align_len_reg_n_0_[31]\,
      O => \end_addr_buf[9]_i_5_n_0\
    );
\end_addr_buf_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(10),
      Q => \end_addr_buf_reg_n_0_[10]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(11),
      Q => \end_addr_buf_reg_n_0_[11]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(12),
      Q => p_0_in0_in(0),
      R => \^sr\(0)
    );
\end_addr_buf_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(13),
      Q => p_0_in0_in(1),
      R => \^sr\(0)
    );
\end_addr_buf_reg[13]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[9]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[13]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[13]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[13]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[13]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \start_addr_reg_n_0_[13]\,
      DI(2) => \start_addr_reg_n_0_[12]\,
      DI(1) => \start_addr_reg_n_0_[11]\,
      DI(0) => \start_addr_reg_n_0_[10]\,
      O(3 downto 0) => end_addr(13 downto 10),
      S(3) => \end_addr_buf[13]_i_2_n_0\,
      S(2) => \end_addr_buf[13]_i_3_n_0\,
      S(1) => \end_addr_buf[13]_i_4_n_0\,
      S(0) => \end_addr_buf[13]_i_5_n_0\
    );
\end_addr_buf_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(14),
      Q => p_0_in0_in(2),
      R => \^sr\(0)
    );
\end_addr_buf_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(15),
      Q => p_0_in0_in(3),
      R => \^sr\(0)
    );
\end_addr_buf_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(16),
      Q => p_0_in0_in(4),
      R => \^sr\(0)
    );
\end_addr_buf_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(17),
      Q => p_0_in0_in(5),
      R => \^sr\(0)
    );
\end_addr_buf_reg[17]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[13]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[17]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[17]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[17]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[17]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \start_addr_reg_n_0_[17]\,
      DI(2) => \start_addr_reg_n_0_[16]\,
      DI(1) => \start_addr_reg_n_0_[15]\,
      DI(0) => \start_addr_reg_n_0_[14]\,
      O(3 downto 0) => end_addr(17 downto 14),
      S(3) => \end_addr_buf[17]_i_2_n_0\,
      S(2) => \end_addr_buf[17]_i_3_n_0\,
      S(1) => \end_addr_buf[17]_i_4_n_0\,
      S(0) => \end_addr_buf[17]_i_5_n_0\
    );
\end_addr_buf_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(18),
      Q => p_0_in0_in(6),
      R => \^sr\(0)
    );
\end_addr_buf_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(19),
      Q => p_0_in0_in(7),
      R => \^sr\(0)
    );
\end_addr_buf_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(20),
      Q => p_0_in0_in(8),
      R => \^sr\(0)
    );
\end_addr_buf_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(21),
      Q => p_0_in0_in(9),
      R => \^sr\(0)
    );
\end_addr_buf_reg[21]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[17]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[21]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[21]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[21]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[21]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \start_addr_reg_n_0_[21]\,
      DI(2) => \start_addr_reg_n_0_[20]\,
      DI(1) => \start_addr_reg_n_0_[19]\,
      DI(0) => \start_addr_reg_n_0_[18]\,
      O(3 downto 0) => end_addr(21 downto 18),
      S(3) => \end_addr_buf[21]_i_2_n_0\,
      S(2) => \end_addr_buf[21]_i_3_n_0\,
      S(1) => \end_addr_buf[21]_i_4_n_0\,
      S(0) => \end_addr_buf[21]_i_5_n_0\
    );
\end_addr_buf_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(22),
      Q => p_0_in0_in(10),
      R => \^sr\(0)
    );
\end_addr_buf_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(23),
      Q => p_0_in0_in(11),
      R => \^sr\(0)
    );
\end_addr_buf_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(24),
      Q => p_0_in0_in(12),
      R => \^sr\(0)
    );
\end_addr_buf_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(25),
      Q => p_0_in0_in(13),
      R => \^sr\(0)
    );
\end_addr_buf_reg[25]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[21]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[25]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[25]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[25]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[25]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \start_addr_reg_n_0_[25]\,
      DI(2) => \start_addr_reg_n_0_[24]\,
      DI(1) => \start_addr_reg_n_0_[23]\,
      DI(0) => \start_addr_reg_n_0_[22]\,
      O(3 downto 0) => end_addr(25 downto 22),
      S(3) => \end_addr_buf[25]_i_2_n_0\,
      S(2) => \end_addr_buf[25]_i_3_n_0\,
      S(1) => \end_addr_buf[25]_i_4_n_0\,
      S(0) => \end_addr_buf[25]_i_5_n_0\
    );
\end_addr_buf_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(26),
      Q => p_0_in0_in(14),
      R => \^sr\(0)
    );
\end_addr_buf_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(27),
      Q => p_0_in0_in(15),
      R => \^sr\(0)
    );
\end_addr_buf_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(28),
      Q => p_0_in0_in(16),
      R => \^sr\(0)
    );
\end_addr_buf_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(29),
      Q => p_0_in0_in(17),
      R => \^sr\(0)
    );
\end_addr_buf_reg[29]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[25]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[29]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[29]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[29]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[29]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \start_addr_reg_n_0_[29]\,
      DI(2) => \start_addr_reg_n_0_[28]\,
      DI(1) => \start_addr_reg_n_0_[27]\,
      DI(0) => \start_addr_reg_n_0_[26]\,
      O(3 downto 0) => end_addr(29 downto 26),
      S(3) => \end_addr_buf[29]_i_2_n_0\,
      S(2) => \end_addr_buf[29]_i_3_n_0\,
      S(1) => \end_addr_buf[29]_i_4_n_0\,
      S(0) => \end_addr_buf[29]_i_5_n_0\
    );
\end_addr_buf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(2),
      Q => \end_addr_buf_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(30),
      Q => p_0_in0_in(18),
      R => \^sr\(0)
    );
\end_addr_buf_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(31),
      Q => p_0_in0_in(19),
      R => \^sr\(0)
    );
\end_addr_buf_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(32),
      Q => p_0_in0_in(20),
      R => \^sr\(0)
    );
\end_addr_buf_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(33),
      Q => p_0_in0_in(21),
      R => \^sr\(0)
    );
\end_addr_buf_reg[33]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[29]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[33]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[33]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[33]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[33]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \start_addr_reg_n_0_[31]\,
      DI(0) => \start_addr_reg_n_0_[30]\,
      O(3 downto 0) => end_addr(33 downto 30),
      S(3) => \start_addr_reg_n_0_[33]\,
      S(2) => \start_addr_reg_n_0_[32]\,
      S(1) => \end_addr_buf[33]_i_2_n_0\,
      S(0) => \end_addr_buf[33]_i_3_n_0\
    );
\end_addr_buf_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(34),
      Q => p_0_in0_in(22),
      R => \^sr\(0)
    );
\end_addr_buf_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(35),
      Q => p_0_in0_in(23),
      R => \^sr\(0)
    );
\end_addr_buf_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(36),
      Q => p_0_in0_in(24),
      R => \^sr\(0)
    );
\end_addr_buf_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(37),
      Q => p_0_in0_in(25),
      R => \^sr\(0)
    );
\end_addr_buf_reg[37]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[33]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[37]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[37]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[37]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[37]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => end_addr(37 downto 34),
      S(3) => \start_addr_reg_n_0_[37]\,
      S(2) => \start_addr_reg_n_0_[36]\,
      S(1) => \start_addr_reg_n_0_[35]\,
      S(0) => \start_addr_reg_n_0_[34]\
    );
\end_addr_buf_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(38),
      Q => p_0_in0_in(26),
      R => \^sr\(0)
    );
\end_addr_buf_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(39),
      Q => p_0_in0_in(27),
      R => \^sr\(0)
    );
\end_addr_buf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(3),
      Q => \end_addr_buf_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(40),
      Q => p_0_in0_in(28),
      R => \^sr\(0)
    );
\end_addr_buf_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(41),
      Q => p_0_in0_in(29),
      R => \^sr\(0)
    );
\end_addr_buf_reg[41]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[37]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[41]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[41]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[41]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[41]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => end_addr(41 downto 38),
      S(3) => \start_addr_reg_n_0_[41]\,
      S(2) => \start_addr_reg_n_0_[40]\,
      S(1) => \start_addr_reg_n_0_[39]\,
      S(0) => \start_addr_reg_n_0_[38]\
    );
\end_addr_buf_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(42),
      Q => p_0_in0_in(30),
      R => \^sr\(0)
    );
\end_addr_buf_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(43),
      Q => p_0_in0_in(31),
      R => \^sr\(0)
    );
\end_addr_buf_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(44),
      Q => p_0_in0_in(32),
      R => \^sr\(0)
    );
\end_addr_buf_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(45),
      Q => p_0_in0_in(33),
      R => \^sr\(0)
    );
\end_addr_buf_reg[45]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[41]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[45]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[45]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[45]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[45]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => end_addr(45 downto 42),
      S(3) => \start_addr_reg_n_0_[45]\,
      S(2) => \start_addr_reg_n_0_[44]\,
      S(1) => \start_addr_reg_n_0_[43]\,
      S(0) => \start_addr_reg_n_0_[42]\
    );
\end_addr_buf_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(46),
      Q => p_0_in0_in(34),
      R => \^sr\(0)
    );
\end_addr_buf_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(47),
      Q => p_0_in0_in(35),
      R => \^sr\(0)
    );
\end_addr_buf_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(48),
      Q => p_0_in0_in(36),
      R => \^sr\(0)
    );
\end_addr_buf_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(49),
      Q => p_0_in0_in(37),
      R => \^sr\(0)
    );
\end_addr_buf_reg[49]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[45]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[49]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[49]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[49]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[49]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => end_addr(49 downto 46),
      S(3) => \start_addr_reg_n_0_[49]\,
      S(2) => \start_addr_reg_n_0_[48]\,
      S(1) => \start_addr_reg_n_0_[47]\,
      S(0) => \start_addr_reg_n_0_[46]\
    );
\end_addr_buf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(4),
      Q => \end_addr_buf_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(50),
      Q => p_0_in0_in(38),
      R => \^sr\(0)
    );
\end_addr_buf_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(51),
      Q => p_0_in0_in(39),
      R => \^sr\(0)
    );
\end_addr_buf_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(52),
      Q => p_0_in0_in(40),
      R => \^sr\(0)
    );
\end_addr_buf_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(53),
      Q => p_0_in0_in(41),
      R => \^sr\(0)
    );
\end_addr_buf_reg[53]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[49]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[53]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[53]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[53]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[53]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => end_addr(53 downto 50),
      S(3) => \start_addr_reg_n_0_[53]\,
      S(2) => \start_addr_reg_n_0_[52]\,
      S(1) => \start_addr_reg_n_0_[51]\,
      S(0) => \start_addr_reg_n_0_[50]\
    );
\end_addr_buf_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(54),
      Q => p_0_in0_in(42),
      R => \^sr\(0)
    );
\end_addr_buf_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(55),
      Q => p_0_in0_in(43),
      R => \^sr\(0)
    );
\end_addr_buf_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(56),
      Q => p_0_in0_in(44),
      R => \^sr\(0)
    );
\end_addr_buf_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(57),
      Q => p_0_in0_in(45),
      R => \^sr\(0)
    );
\end_addr_buf_reg[57]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[53]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[57]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[57]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[57]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[57]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => end_addr(57 downto 54),
      S(3) => \start_addr_reg_n_0_[57]\,
      S(2) => \start_addr_reg_n_0_[56]\,
      S(1) => \start_addr_reg_n_0_[55]\,
      S(0) => \start_addr_reg_n_0_[54]\
    );
\end_addr_buf_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(58),
      Q => p_0_in0_in(46),
      R => \^sr\(0)
    );
\end_addr_buf_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(59),
      Q => p_0_in0_in(47),
      R => \^sr\(0)
    );
\end_addr_buf_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(5),
      Q => \end_addr_buf_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[5]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \end_addr_buf_reg[5]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[5]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[5]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[5]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \start_addr_reg_n_0_[5]\,
      DI(2) => \start_addr_reg_n_0_[4]\,
      DI(1) => \start_addr_reg_n_0_[3]\,
      DI(0) => \start_addr_reg_n_0_[2]\,
      O(3 downto 1) => end_addr(5 downto 3),
      O(0) => \NLW_end_addr_buf_reg[5]_i_1_O_UNCONNECTED\(0),
      S(3) => \end_addr_buf[5]_i_2_n_0\,
      S(2) => \end_addr_buf[5]_i_3_n_0\,
      S(1) => \end_addr_buf[5]_i_4_n_0\,
      S(0) => \end_addr_buf[5]_i_5_n_0\
    );
\end_addr_buf_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(60),
      Q => p_0_in0_in(48),
      R => \^sr\(0)
    );
\end_addr_buf_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(61),
      Q => p_0_in0_in(49),
      R => \^sr\(0)
    );
\end_addr_buf_reg[61]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[57]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[61]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[61]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[61]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[61]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => end_addr(61 downto 58),
      S(3) => \start_addr_reg_n_0_[61]\,
      S(2) => \start_addr_reg_n_0_[60]\,
      S(1) => \start_addr_reg_n_0_[59]\,
      S(0) => \start_addr_reg_n_0_[58]\
    );
\end_addr_buf_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(62),
      Q => p_0_in0_in(50),
      R => \^sr\(0)
    );
\end_addr_buf_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(63),
      Q => p_0_in0_in(51),
      R => \^sr\(0)
    );
\end_addr_buf_reg[63]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[61]_i_1_n_0\,
      CO(3 downto 1) => \NLW_end_addr_buf_reg[63]_i_1_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \end_addr_buf_reg[63]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 2) => \NLW_end_addr_buf_reg[63]_i_1_O_UNCONNECTED\(3 downto 2),
      O(1 downto 0) => end_addr(63 downto 62),
      S(3 downto 2) => B"00",
      S(1) => \start_addr_reg_n_0_[63]\,
      S(0) => \start_addr_reg_n_0_[62]\
    );
\end_addr_buf_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(6),
      Q => \end_addr_buf_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(7),
      Q => \end_addr_buf_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(8),
      Q => \end_addr_buf_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => end_addr(9),
      Q => \end_addr_buf_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\end_addr_buf_reg[9]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \end_addr_buf_reg[5]_i_1_n_0\,
      CO(3) => \end_addr_buf_reg[9]_i_1_n_0\,
      CO(2) => \end_addr_buf_reg[9]_i_1_n_1\,
      CO(1) => \end_addr_buf_reg[9]_i_1_n_2\,
      CO(0) => \end_addr_buf_reg[9]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \start_addr_reg_n_0_[9]\,
      DI(2) => \start_addr_reg_n_0_[8]\,
      DI(1) => \start_addr_reg_n_0_[7]\,
      DI(0) => \start_addr_reg_n_0_[6]\,
      O(3 downto 0) => end_addr(9 downto 6),
      S(3) => \end_addr_buf[9]_i_2_n_0\,
      S(2) => \end_addr_buf[9]_i_3_n_0\,
      S(1) => \end_addr_buf[9]_i_4_n_0\,
      S(0) => \end_addr_buf[9]_i_5_n_0\
    );
fifo_rctl: entity work.\decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized1\
     port map (
      CO(0) => last_sect,
      E(0) => fifo_rctl_n_5,
      Q(4 downto 0) => p_1_in(4 downto 0),
      SR(0) => \^sr\(0),
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      ap_rst_n_0(0) => fifo_rctl_n_4,
      ap_rst_n_1(0) => fifo_rctl_n_6,
      beat_valid => beat_valid,
      \could_multi_bursts.sect_handling_reg\ => fifo_rctl_n_7,
      \could_multi_bursts.sect_handling_reg_0\ => fifo_rctl_n_8,
      \could_multi_bursts.sect_handling_reg_1\ => fifo_rctl_n_9,
      \could_multi_bursts.sect_handling_reg_2\ => fifo_rctl_n_10,
      \could_multi_bursts.sect_handling_reg_3\ => fifo_rctl_n_11,
      \could_multi_bursts.sect_handling_reg_4\ => fifo_rctl_n_12,
      \could_multi_bursts.sect_handling_reg_5\(0) => p_20_in,
      \could_multi_bursts.sect_handling_reg_6\ => \could_multi_bursts.sect_handling_reg_n_0\,
      \could_multi_bursts.sect_handling_reg_7\ => \^could_multi_bursts.arvalid_dummy_reg_0\,
      \could_multi_bursts.sect_handling_reg_8\ => \could_multi_bursts.arlen_buf[4]_i_3_n_0\,
      empty_n_reg_0 => fifo_rctl_n_0,
      empty_n_reg_1 => \bus_equal_gen.rdata_valid_t_reg_n_0\,
      empty_n_reg_2(0) => data_pack(34),
      fifo_rreq_valid => fifo_rreq_valid,
      invalid_len_event => invalid_len_event,
      invalid_len_event_reg2 => invalid_len_event_reg2,
      invalid_len_event_reg2_reg => fifo_rctl_n_13,
      m_axi_gmem_ARREADY => m_axi_gmem_ARREADY,
      p_21_in => p_21_in,
      \pout_reg[3]_0\ => buff_rdata_n_20,
      rdata_ack_t => rdata_ack_t,
      rreq_handling_reg => fifo_rctl_n_1,
      rreq_handling_reg_0 => fifo_rctl_n_3,
      rreq_handling_reg_1(0) => pop0,
      rreq_handling_reg_2(0) => fifo_rctl_n_16,
      rreq_handling_reg_3 => rreq_handling_reg_n_0,
      rreq_handling_reg_4 => fifo_rreq_valid_buf_reg_n_0,
      \sect_addr_buf_reg[2]\(0) => first_sect,
      \sect_len_buf_reg[7]\ => fifo_rreq_n_56,
      \sect_len_buf_reg[7]_0\ => fifo_rreq_n_55
    );
fifo_rreq: entity work.\decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_fifo__parameterized0\
     port map (
      CO(0) => last_sect,
      D(51) => fifo_rreq_n_2,
      D(50) => fifo_rreq_n_3,
      D(49) => fifo_rreq_n_4,
      D(48) => fifo_rreq_n_5,
      D(47) => fifo_rreq_n_6,
      D(46) => fifo_rreq_n_7,
      D(45) => fifo_rreq_n_8,
      D(44) => fifo_rreq_n_9,
      D(43) => fifo_rreq_n_10,
      D(42) => fifo_rreq_n_11,
      D(41) => fifo_rreq_n_12,
      D(40) => fifo_rreq_n_13,
      D(39) => fifo_rreq_n_14,
      D(38) => fifo_rreq_n_15,
      D(37) => fifo_rreq_n_16,
      D(36) => fifo_rreq_n_17,
      D(35) => fifo_rreq_n_18,
      D(34) => fifo_rreq_n_19,
      D(33) => fifo_rreq_n_20,
      D(32) => fifo_rreq_n_21,
      D(31) => fifo_rreq_n_22,
      D(30) => fifo_rreq_n_23,
      D(29) => fifo_rreq_n_24,
      D(28) => fifo_rreq_n_25,
      D(27) => fifo_rreq_n_26,
      D(26) => fifo_rreq_n_27,
      D(25) => fifo_rreq_n_28,
      D(24) => fifo_rreq_n_29,
      D(23) => fifo_rreq_n_30,
      D(22) => fifo_rreq_n_31,
      D(21) => fifo_rreq_n_32,
      D(20) => fifo_rreq_n_33,
      D(19) => fifo_rreq_n_34,
      D(18) => fifo_rreq_n_35,
      D(17) => fifo_rreq_n_36,
      D(16) => fifo_rreq_n_37,
      D(15) => fifo_rreq_n_38,
      D(14) => fifo_rreq_n_39,
      D(13) => fifo_rreq_n_40,
      D(12) => fifo_rreq_n_41,
      D(11) => fifo_rreq_n_42,
      D(10) => fifo_rreq_n_43,
      D(9) => fifo_rreq_n_44,
      D(8) => fifo_rreq_n_45,
      D(7) => fifo_rreq_n_46,
      D(6) => fifo_rreq_n_47,
      D(5) => fifo_rreq_n_48,
      D(4) => fifo_rreq_n_49,
      D(3) => fifo_rreq_n_50,
      D(2) => fifo_rreq_n_51,
      D(1) => fifo_rreq_n_52,
      D(0) => fifo_rreq_n_53,
      E(0) => pop0,
      Q(0) => \sect_cnt_reg_n_0_[0]\,
      S(0) => zero_len_event0,
      SR(0) => \^sr\(0),
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      fifo_rreq_valid => fifo_rreq_valid,
      fifo_rreq_valid_buf_reg => fifo_rreq_valid_buf_reg_n_0,
      full_n_reg_0 => rreq_handling_reg_n_0,
      invalid_len_event0 => invalid_len_event0,
      next_rreq => next_rreq,
      p_21_in => p_21_in,
      push => push,
      \q_reg[61]_0\(61 downto 0) => rs2f_rreq_data(61 downto 0),
      \q_reg[64]_0\(62) => fifo_rreq_data(64),
      \q_reg[64]_0\(61 downto 0) => \^q\(61 downto 0),
      rs2f_rreq_ack => rs2f_rreq_ack,
      sect_cnt0(50 downto 0) => sect_cnt0(51 downto 1),
      \sect_cnt_reg[51]\(51) => \start_addr_reg_n_0_[63]\,
      \sect_cnt_reg[51]\(50) => \start_addr_reg_n_0_[62]\,
      \sect_cnt_reg[51]\(49) => \start_addr_reg_n_0_[61]\,
      \sect_cnt_reg[51]\(48) => \start_addr_reg_n_0_[60]\,
      \sect_cnt_reg[51]\(47) => \start_addr_reg_n_0_[59]\,
      \sect_cnt_reg[51]\(46) => \start_addr_reg_n_0_[58]\,
      \sect_cnt_reg[51]\(45) => \start_addr_reg_n_0_[57]\,
      \sect_cnt_reg[51]\(44) => \start_addr_reg_n_0_[56]\,
      \sect_cnt_reg[51]\(43) => \start_addr_reg_n_0_[55]\,
      \sect_cnt_reg[51]\(42) => \start_addr_reg_n_0_[54]\,
      \sect_cnt_reg[51]\(41) => \start_addr_reg_n_0_[53]\,
      \sect_cnt_reg[51]\(40) => \start_addr_reg_n_0_[52]\,
      \sect_cnt_reg[51]\(39) => \start_addr_reg_n_0_[51]\,
      \sect_cnt_reg[51]\(38) => \start_addr_reg_n_0_[50]\,
      \sect_cnt_reg[51]\(37) => \start_addr_reg_n_0_[49]\,
      \sect_cnt_reg[51]\(36) => \start_addr_reg_n_0_[48]\,
      \sect_cnt_reg[51]\(35) => \start_addr_reg_n_0_[47]\,
      \sect_cnt_reg[51]\(34) => \start_addr_reg_n_0_[46]\,
      \sect_cnt_reg[51]\(33) => \start_addr_reg_n_0_[45]\,
      \sect_cnt_reg[51]\(32) => \start_addr_reg_n_0_[44]\,
      \sect_cnt_reg[51]\(31) => \start_addr_reg_n_0_[43]\,
      \sect_cnt_reg[51]\(30) => \start_addr_reg_n_0_[42]\,
      \sect_cnt_reg[51]\(29) => \start_addr_reg_n_0_[41]\,
      \sect_cnt_reg[51]\(28) => \start_addr_reg_n_0_[40]\,
      \sect_cnt_reg[51]\(27) => \start_addr_reg_n_0_[39]\,
      \sect_cnt_reg[51]\(26) => \start_addr_reg_n_0_[38]\,
      \sect_cnt_reg[51]\(25) => \start_addr_reg_n_0_[37]\,
      \sect_cnt_reg[51]\(24) => \start_addr_reg_n_0_[36]\,
      \sect_cnt_reg[51]\(23) => \start_addr_reg_n_0_[35]\,
      \sect_cnt_reg[51]\(22) => \start_addr_reg_n_0_[34]\,
      \sect_cnt_reg[51]\(21) => \start_addr_reg_n_0_[33]\,
      \sect_cnt_reg[51]\(20) => \start_addr_reg_n_0_[32]\,
      \sect_cnt_reg[51]\(19) => \start_addr_reg_n_0_[31]\,
      \sect_cnt_reg[51]\(18) => \start_addr_reg_n_0_[30]\,
      \sect_cnt_reg[51]\(17) => \start_addr_reg_n_0_[29]\,
      \sect_cnt_reg[51]\(16) => \start_addr_reg_n_0_[28]\,
      \sect_cnt_reg[51]\(15) => \start_addr_reg_n_0_[27]\,
      \sect_cnt_reg[51]\(14) => \start_addr_reg_n_0_[26]\,
      \sect_cnt_reg[51]\(13) => \start_addr_reg_n_0_[25]\,
      \sect_cnt_reg[51]\(12) => \start_addr_reg_n_0_[24]\,
      \sect_cnt_reg[51]\(11) => \start_addr_reg_n_0_[23]\,
      \sect_cnt_reg[51]\(10) => \start_addr_reg_n_0_[22]\,
      \sect_cnt_reg[51]\(9) => \start_addr_reg_n_0_[21]\,
      \sect_cnt_reg[51]\(8) => \start_addr_reg_n_0_[20]\,
      \sect_cnt_reg[51]\(7) => \start_addr_reg_n_0_[19]\,
      \sect_cnt_reg[51]\(6) => \start_addr_reg_n_0_[18]\,
      \sect_cnt_reg[51]\(5) => \start_addr_reg_n_0_[17]\,
      \sect_cnt_reg[51]\(4) => \start_addr_reg_n_0_[16]\,
      \sect_cnt_reg[51]\(3) => \start_addr_reg_n_0_[15]\,
      \sect_cnt_reg[51]\(2) => \start_addr_reg_n_0_[14]\,
      \sect_cnt_reg[51]\(1) => \start_addr_reg_n_0_[13]\,
      \sect_cnt_reg[51]\(0) => \start_addr_reg_n_0_[12]\,
      \sect_len_buf_reg[6]\ => fifo_rreq_n_56,
      \sect_len_buf_reg[7]\ => fifo_rreq_n_55,
      \sect_len_buf_reg[7]_0\(4) => \sect_len_buf_reg_n_0_[9]\,
      \sect_len_buf_reg[7]_0\(3) => \sect_len_buf_reg_n_0_[8]\,
      \sect_len_buf_reg[7]_0\(2) => \sect_len_buf_reg_n_0_[7]\,
      \sect_len_buf_reg[7]_0\(1) => \sect_len_buf_reg_n_0_[6]\,
      \sect_len_buf_reg[7]_0\(0) => \sect_len_buf_reg_n_0_[5]\,
      \sect_len_buf_reg[7]_1\(4 downto 0) => \could_multi_bursts.loop_cnt_reg\(4 downto 0)
    );
fifo_rreq_valid_buf_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => fifo_rreq_valid,
      Q => fifo_rreq_valid_buf_reg_n_0,
      R => \^sr\(0)
    );
first_sect_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => first_sect_carry_n_0,
      CO(2) => first_sect_carry_n_1,
      CO(1) => first_sect_carry_n_2,
      CO(0) => first_sect_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_first_sect_carry_O_UNCONNECTED(3 downto 0),
      S(3) => first_sect_carry_i_1_n_0,
      S(2) => first_sect_carry_i_2_n_0,
      S(1) => first_sect_carry_i_3_n_0,
      S(0) => first_sect_carry_i_4_n_0
    );
\first_sect_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => first_sect_carry_n_0,
      CO(3) => \first_sect_carry__0_n_0\,
      CO(2) => \first_sect_carry__0_n_1\,
      CO(1) => \first_sect_carry__0_n_2\,
      CO(0) => \first_sect_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_first_sect_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \first_sect_carry__0_i_1_n_0\,
      S(2) => \first_sect_carry__0_i_2_n_0\,
      S(1) => \first_sect_carry__0_i_3_n_0\,
      S(0) => \first_sect_carry__0_i_4_n_0\
    );
\first_sect_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[23]\,
      I1 => p_0_in_0(23),
      I2 => \sect_cnt_reg_n_0_[21]\,
      I3 => p_0_in_0(21),
      I4 => p_0_in_0(22),
      I5 => \sect_cnt_reg_n_0_[22]\,
      O => \first_sect_carry__0_i_1_n_0\
    );
\first_sect_carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(19),
      I1 => \sect_cnt_reg_n_0_[19]\,
      I2 => \sect_cnt_reg_n_0_[18]\,
      I3 => p_0_in_0(18),
      I4 => \sect_cnt_reg_n_0_[20]\,
      I5 => p_0_in_0(20),
      O => \first_sect_carry__0_i_2_n_0\
    );
\first_sect_carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(15),
      I1 => \sect_cnt_reg_n_0_[15]\,
      I2 => \sect_cnt_reg_n_0_[16]\,
      I3 => p_0_in_0(16),
      I4 => \sect_cnt_reg_n_0_[17]\,
      I5 => p_0_in_0(17),
      O => \first_sect_carry__0_i_3_n_0\
    );
\first_sect_carry__0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[14]\,
      I1 => p_0_in_0(14),
      I2 => \sect_cnt_reg_n_0_[12]\,
      I3 => p_0_in_0(12),
      I4 => p_0_in_0(13),
      I5 => \sect_cnt_reg_n_0_[13]\,
      O => \first_sect_carry__0_i_4_n_0\
    );
\first_sect_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \first_sect_carry__0_n_0\,
      CO(3) => \first_sect_carry__1_n_0\,
      CO(2) => \first_sect_carry__1_n_1\,
      CO(1) => \first_sect_carry__1_n_2\,
      CO(0) => \first_sect_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_first_sect_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => \first_sect_carry__1_i_1_n_0\,
      S(2) => \first_sect_carry__1_i_2_n_0\,
      S(1) => \first_sect_carry__1_i_3_n_0\,
      S(0) => \first_sect_carry__1_i_4_n_0\
    );
\first_sect_carry__1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(33),
      I1 => \sect_cnt_reg_n_0_[33]\,
      I2 => \sect_cnt_reg_n_0_[34]\,
      I3 => p_0_in_0(34),
      I4 => \sect_cnt_reg_n_0_[35]\,
      I5 => p_0_in_0(35),
      O => \first_sect_carry__1_i_1_n_0\
    );
\first_sect_carry__1_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(30),
      I1 => \sect_cnt_reg_n_0_[30]\,
      I2 => \sect_cnt_reg_n_0_[31]\,
      I3 => p_0_in_0(31),
      I4 => \sect_cnt_reg_n_0_[32]\,
      I5 => p_0_in_0(32),
      O => \first_sect_carry__1_i_2_n_0\
    );
\first_sect_carry__1_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[29]\,
      I1 => p_0_in_0(29),
      I2 => \sect_cnt_reg_n_0_[28]\,
      I3 => p_0_in_0(28),
      I4 => p_0_in_0(27),
      I5 => \sect_cnt_reg_n_0_[27]\,
      O => \first_sect_carry__1_i_3_n_0\
    );
\first_sect_carry__1_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[24]\,
      I1 => p_0_in_0(24),
      I2 => \sect_cnt_reg_n_0_[26]\,
      I3 => p_0_in_0(26),
      I4 => p_0_in_0(25),
      I5 => \sect_cnt_reg_n_0_[25]\,
      O => \first_sect_carry__1_i_4_n_0\
    );
\first_sect_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \first_sect_carry__1_n_0\,
      CO(3) => \first_sect_carry__2_n_0\,
      CO(2) => \first_sect_carry__2_n_1\,
      CO(1) => \first_sect_carry__2_n_2\,
      CO(0) => \first_sect_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_first_sect_carry__2_O_UNCONNECTED\(3 downto 0),
      S(3) => \first_sect_carry__2_i_1_n_0\,
      S(2) => \first_sect_carry__2_i_2_n_0\,
      S(1) => \first_sect_carry__2_i_3_n_0\,
      S(0) => \first_sect_carry__2_i_4_n_0\
    );
\first_sect_carry__2_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(46),
      I1 => \sect_cnt_reg_n_0_[46]\,
      I2 => \sect_cnt_reg_n_0_[45]\,
      I3 => p_0_in_0(45),
      I4 => \sect_cnt_reg_n_0_[47]\,
      I5 => p_0_in_0(47),
      O => \first_sect_carry__2_i_1_n_0\
    );
\first_sect_carry__2_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[42]\,
      I1 => p_0_in_0(42),
      I2 => \sect_cnt_reg_n_0_[44]\,
      I3 => p_0_in_0(44),
      I4 => p_0_in_0(43),
      I5 => \sect_cnt_reg_n_0_[43]\,
      O => \first_sect_carry__2_i_2_n_0\
    );
\first_sect_carry__2_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(39),
      I1 => \sect_cnt_reg_n_0_[39]\,
      I2 => \sect_cnt_reg_n_0_[41]\,
      I3 => p_0_in_0(41),
      I4 => \sect_cnt_reg_n_0_[40]\,
      I5 => p_0_in_0(40),
      O => \first_sect_carry__2_i_3_n_0\
    );
\first_sect_carry__2_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[38]\,
      I1 => p_0_in_0(38),
      I2 => \sect_cnt_reg_n_0_[37]\,
      I3 => p_0_in_0(37),
      I4 => p_0_in_0(36),
      I5 => \sect_cnt_reg_n_0_[36]\,
      O => \first_sect_carry__2_i_4_n_0\
    );
\first_sect_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \first_sect_carry__2_n_0\,
      CO(3 downto 2) => \NLW_first_sect_carry__3_CO_UNCONNECTED\(3 downto 2),
      CO(1) => first_sect,
      CO(0) => \first_sect_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_first_sect_carry__3_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => B"00",
      S(1) => \first_sect_carry__3_i_1_n_0\,
      S(0) => \first_sect_carry__3_i_2_n_0\
    );
\first_sect_carry__3_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => p_0_in_0(51),
      I1 => \sect_cnt_reg_n_0_[51]\,
      O => \first_sect_carry__3_i_1_n_0\
    );
\first_sect_carry__3_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(48),
      I1 => \sect_cnt_reg_n_0_[48]\,
      I2 => \sect_cnt_reg_n_0_[49]\,
      I3 => p_0_in_0(49),
      I4 => \sect_cnt_reg_n_0_[50]\,
      I5 => p_0_in_0(50),
      O => \first_sect_carry__3_i_2_n_0\
    );
first_sect_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[9]\,
      I1 => p_0_in_0(9),
      I2 => \sect_cnt_reg_n_0_[11]\,
      I3 => p_0_in_0(11),
      I4 => p_0_in_0(10),
      I5 => \sect_cnt_reg_n_0_[10]\,
      O => first_sect_carry_i_1_n_0
    );
first_sect_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[8]\,
      I1 => p_0_in_0(8),
      I2 => \sect_cnt_reg_n_0_[7]\,
      I3 => p_0_in_0(7),
      I4 => p_0_in_0(6),
      I5 => \sect_cnt_reg_n_0_[6]\,
      O => first_sect_carry_i_2_n_0
    );
first_sect_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(3),
      I1 => \sect_cnt_reg_n_0_[3]\,
      I2 => \sect_cnt_reg_n_0_[5]\,
      I3 => p_0_in_0(5),
      I4 => \sect_cnt_reg_n_0_[4]\,
      I5 => p_0_in_0(4),
      O => first_sect_carry_i_3_n_0
    );
first_sect_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in_0(0),
      I1 => \sect_cnt_reg_n_0_[0]\,
      I2 => \sect_cnt_reg_n_0_[1]\,
      I3 => p_0_in_0(1),
      I4 => \sect_cnt_reg_n_0_[2]\,
      I5 => p_0_in_0(2),
      O => first_sect_carry_i_4_n_0
    );
invalid_len_event_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => invalid_len_event0,
      Q => invalid_len_event,
      R => \^sr\(0)
    );
invalid_len_event_reg1_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => invalid_len_event,
      Q => invalid_len_event_reg1,
      R => \^sr\(0)
    );
invalid_len_event_reg2_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => invalid_len_event_reg1,
      Q => invalid_len_event_reg2,
      R => \^sr\(0)
    );
last_sect_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => last_sect_carry_n_0,
      CO(2) => last_sect_carry_n_1,
      CO(1) => last_sect_carry_n_2,
      CO(0) => last_sect_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_last_sect_carry_O_UNCONNECTED(3 downto 0),
      S(3) => last_sect_carry_i_1_n_0,
      S(2) => last_sect_carry_i_2_n_0,
      S(1) => last_sect_carry_i_3_n_0,
      S(0) => last_sect_carry_i_4_n_0
    );
\last_sect_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => last_sect_carry_n_0,
      CO(3) => \last_sect_carry__0_n_0\,
      CO(2) => \last_sect_carry__0_n_1\,
      CO(1) => \last_sect_carry__0_n_2\,
      CO(0) => \last_sect_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_last_sect_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \last_sect_carry__0_i_1_n_0\,
      S(2) => \last_sect_carry__0_i_2_n_0\,
      S(1) => \last_sect_carry__0_i_3_n_0\,
      S(0) => \last_sect_carry__0_i_4_n_0\
    );
\last_sect_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(23),
      I1 => \sect_cnt_reg_n_0_[23]\,
      I2 => p_0_in0_in(22),
      I3 => \sect_cnt_reg_n_0_[22]\,
      I4 => \sect_cnt_reg_n_0_[21]\,
      I5 => p_0_in0_in(21),
      O => \last_sect_carry__0_i_1_n_0\
    );
\last_sect_carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[19]\,
      I1 => p_0_in0_in(19),
      I2 => p_0_in0_in(18),
      I3 => \sect_cnt_reg_n_0_[18]\,
      I4 => p_0_in0_in(20),
      I5 => \sect_cnt_reg_n_0_[20]\,
      O => \last_sect_carry__0_i_2_n_0\
    );
\last_sect_carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[15]\,
      I1 => p_0_in0_in(15),
      I2 => p_0_in0_in(17),
      I3 => \sect_cnt_reg_n_0_[17]\,
      I4 => p_0_in0_in(16),
      I5 => \sect_cnt_reg_n_0_[16]\,
      O => \last_sect_carry__0_i_3_n_0\
    );
\last_sect_carry__0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(13),
      I1 => \sect_cnt_reg_n_0_[13]\,
      I2 => p_0_in0_in(14),
      I3 => \sect_cnt_reg_n_0_[14]\,
      I4 => \sect_cnt_reg_n_0_[12]\,
      I5 => p_0_in0_in(12),
      O => \last_sect_carry__0_i_4_n_0\
    );
\last_sect_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \last_sect_carry__0_n_0\,
      CO(3) => \last_sect_carry__1_n_0\,
      CO(2) => \last_sect_carry__1_n_1\,
      CO(1) => \last_sect_carry__1_n_2\,
      CO(0) => \last_sect_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_last_sect_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => \last_sect_carry__1_i_1_n_0\,
      S(2) => \last_sect_carry__1_i_2_n_0\,
      S(1) => \last_sect_carry__1_i_3_n_0\,
      S(0) => \last_sect_carry__1_i_4_n_0\
    );
\last_sect_carry__1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[33]\,
      I1 => p_0_in0_in(33),
      I2 => p_0_in0_in(34),
      I3 => \sect_cnt_reg_n_0_[34]\,
      I4 => p_0_in0_in(35),
      I5 => \sect_cnt_reg_n_0_[35]\,
      O => \last_sect_carry__1_i_1_n_0\
    );
\last_sect_carry__1_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[30]\,
      I1 => p_0_in0_in(30),
      I2 => p_0_in0_in(31),
      I3 => \sect_cnt_reg_n_0_[31]\,
      I4 => p_0_in0_in(32),
      I5 => \sect_cnt_reg_n_0_[32]\,
      O => \last_sect_carry__1_i_2_n_0\
    );
\last_sect_carry__1_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(27),
      I1 => \sect_cnt_reg_n_0_[27]\,
      I2 => p_0_in0_in(29),
      I3 => \sect_cnt_reg_n_0_[29]\,
      I4 => \sect_cnt_reg_n_0_[28]\,
      I5 => p_0_in0_in(28),
      O => \last_sect_carry__1_i_3_n_0\
    );
\last_sect_carry__1_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(25),
      I1 => \sect_cnt_reg_n_0_[25]\,
      I2 => p_0_in0_in(26),
      I3 => \sect_cnt_reg_n_0_[26]\,
      I4 => \sect_cnt_reg_n_0_[24]\,
      I5 => p_0_in0_in(24),
      O => \last_sect_carry__1_i_4_n_0\
    );
\last_sect_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \last_sect_carry__1_n_0\,
      CO(3) => \last_sect_carry__2_n_0\,
      CO(2) => \last_sect_carry__2_n_1\,
      CO(1) => \last_sect_carry__2_n_2\,
      CO(0) => \last_sect_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_last_sect_carry__2_O_UNCONNECTED\(3 downto 0),
      S(3) => \last_sect_carry__2_i_1_n_0\,
      S(2) => \last_sect_carry__2_i_2_n_0\,
      S(1) => \last_sect_carry__2_i_3_n_0\,
      S(0) => \last_sect_carry__2_i_4_n_0\
    );
\last_sect_carry__2_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[46]\,
      I1 => p_0_in0_in(46),
      I2 => p_0_in0_in(45),
      I3 => \sect_cnt_reg_n_0_[45]\,
      I4 => p_0_in0_in(47),
      I5 => \sect_cnt_reg_n_0_[47]\,
      O => \last_sect_carry__2_i_1_n_0\
    );
\last_sect_carry__2_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(44),
      I1 => \sect_cnt_reg_n_0_[44]\,
      I2 => p_0_in0_in(43),
      I3 => \sect_cnt_reg_n_0_[43]\,
      I4 => \sect_cnt_reg_n_0_[42]\,
      I5 => p_0_in0_in(42),
      O => \last_sect_carry__2_i_2_n_0\
    );
\last_sect_carry__2_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[39]\,
      I1 => p_0_in0_in(39),
      I2 => p_0_in0_in(40),
      I3 => \sect_cnt_reg_n_0_[40]\,
      I4 => p_0_in0_in(41),
      I5 => \sect_cnt_reg_n_0_[41]\,
      O => \last_sect_carry__2_i_3_n_0\
    );
\last_sect_carry__2_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(38),
      I1 => \sect_cnt_reg_n_0_[38]\,
      I2 => p_0_in0_in(36),
      I3 => \sect_cnt_reg_n_0_[36]\,
      I4 => \sect_cnt_reg_n_0_[37]\,
      I5 => p_0_in0_in(37),
      O => \last_sect_carry__2_i_4_n_0\
    );
\last_sect_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \last_sect_carry__2_n_0\,
      CO(3 downto 2) => \NLW_last_sect_carry__3_CO_UNCONNECTED\(3 downto 2),
      CO(1) => last_sect,
      CO(0) => \last_sect_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_last_sect_carry__3_O_UNCONNECTED\(3 downto 0),
      S(3 downto 2) => B"00",
      S(1) => \last_sect_carry__3_i_1_n_0\,
      S(0) => \last_sect_carry__3_i_2_n_0\
    );
\last_sect_carry__3_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => p_0_in0_in(51),
      I1 => \sect_cnt_reg_n_0_[51]\,
      O => \last_sect_carry__3_i_1_n_0\
    );
\last_sect_carry__3_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[48]\,
      I1 => p_0_in0_in(48),
      I2 => p_0_in0_in(49),
      I3 => \sect_cnt_reg_n_0_[49]\,
      I4 => p_0_in0_in(50),
      I5 => \sect_cnt_reg_n_0_[50]\,
      O => \last_sect_carry__3_i_2_n_0\
    );
last_sect_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(10),
      I1 => \sect_cnt_reg_n_0_[10]\,
      I2 => p_0_in0_in(11),
      I3 => \sect_cnt_reg_n_0_[11]\,
      I4 => \sect_cnt_reg_n_0_[9]\,
      I5 => p_0_in0_in(9),
      O => last_sect_carry_i_1_n_0
    );
last_sect_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(8),
      I1 => \sect_cnt_reg_n_0_[8]\,
      I2 => p_0_in0_in(6),
      I3 => \sect_cnt_reg_n_0_[6]\,
      I4 => \sect_cnt_reg_n_0_[7]\,
      I5 => p_0_in0_in(7),
      O => last_sect_carry_i_2_n_0
    );
last_sect_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \sect_cnt_reg_n_0_[3]\,
      I1 => p_0_in0_in(3),
      I2 => p_0_in0_in(4),
      I3 => \sect_cnt_reg_n_0_[4]\,
      I4 => p_0_in0_in(5),
      I5 => \sect_cnt_reg_n_0_[5]\,
      O => last_sect_carry_i_3_n_0
    );
last_sect_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => p_0_in0_in(0),
      I1 => \sect_cnt_reg_n_0_[0]\,
      I2 => p_0_in0_in(2),
      I3 => \sect_cnt_reg_n_0_[2]\,
      I4 => \sect_cnt_reg_n_0_[1]\,
      I5 => p_0_in0_in(1),
      O => last_sect_carry_i_4_n_0
    );
p_0_out_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => p_0_out_carry_n_0,
      CO(2) => p_0_out_carry_n_1,
      CO(1) => p_0_out_carry_n_2,
      CO(0) => p_0_out_carry_n_3,
      CYINIT => mOutPtr_reg(0),
      DI(3 downto 1) => mOutPtr_reg(3 downto 1),
      DI(0) => mOutPtr19_out,
      O(3) => p_0_out_carry_n_4,
      O(2) => p_0_out_carry_n_5,
      O(1) => p_0_out_carry_n_6,
      O(0) => p_0_out_carry_n_7,
      S(3) => buff_rdata_n_4,
      S(2) => buff_rdata_n_5,
      S(1) => buff_rdata_n_6,
      S(0) => buff_rdata_n_7
    );
\p_0_out_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => p_0_out_carry_n_0,
      CO(3) => \NLW_p_0_out_carry__0_CO_UNCONNECTED\(3),
      CO(2) => \p_0_out_carry__0_n_1\,
      CO(1) => \p_0_out_carry__0_n_2\,
      CO(0) => \p_0_out_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => mOutPtr_reg(6 downto 4),
      O(3) => \p_0_out_carry__0_n_4\,
      O(2) => \p_0_out_carry__0_n_5\,
      O(1) => \p_0_out_carry__0_n_6\,
      O(0) => \p_0_out_carry__0_n_7\,
      S(3) => buff_rdata_n_15,
      S(2) => buff_rdata_n_16,
      S(1) => buff_rdata_n_17,
      S(0) => buff_rdata_n_18
    );
rreq_handling_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => fifo_rctl_n_1,
      Q => rreq_handling_reg_n_0,
      R => \^sr\(0)
    );
rs_rdata: entity work.\decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice__parameterized0\
     port map (
      E(0) => next_beat,
      Q(1 downto 0) => Q(8 downto 7),
      SR(0) => \^sr\(0),
      ap_NS_fsm(1) => ap_NS_fsm(2),
      ap_NS_fsm(0) => ap_NS_fsm(0),
      ap_clk => ap_clk,
      beat_valid => beat_valid,
      \data_p2_reg[31]_0\(31) => \bus_equal_gen.data_buf_reg_n_0_[31]\,
      \data_p2_reg[31]_0\(30) => \bus_equal_gen.data_buf_reg_n_0_[30]\,
      \data_p2_reg[31]_0\(29) => \bus_equal_gen.data_buf_reg_n_0_[29]\,
      \data_p2_reg[31]_0\(28) => \bus_equal_gen.data_buf_reg_n_0_[28]\,
      \data_p2_reg[31]_0\(27) => \bus_equal_gen.data_buf_reg_n_0_[27]\,
      \data_p2_reg[31]_0\(26) => \bus_equal_gen.data_buf_reg_n_0_[26]\,
      \data_p2_reg[31]_0\(25) => \bus_equal_gen.data_buf_reg_n_0_[25]\,
      \data_p2_reg[31]_0\(24) => \bus_equal_gen.data_buf_reg_n_0_[24]\,
      \data_p2_reg[31]_0\(23) => \bus_equal_gen.data_buf_reg_n_0_[23]\,
      \data_p2_reg[31]_0\(22) => \bus_equal_gen.data_buf_reg_n_0_[22]\,
      \data_p2_reg[31]_0\(21) => \bus_equal_gen.data_buf_reg_n_0_[21]\,
      \data_p2_reg[31]_0\(20) => \bus_equal_gen.data_buf_reg_n_0_[20]\,
      \data_p2_reg[31]_0\(19) => \bus_equal_gen.data_buf_reg_n_0_[19]\,
      \data_p2_reg[31]_0\(18) => \bus_equal_gen.data_buf_reg_n_0_[18]\,
      \data_p2_reg[31]_0\(17) => \bus_equal_gen.data_buf_reg_n_0_[17]\,
      \data_p2_reg[31]_0\(16) => \bus_equal_gen.data_buf_reg_n_0_[16]\,
      \data_p2_reg[31]_0\(15) => \bus_equal_gen.data_buf_reg_n_0_[15]\,
      \data_p2_reg[31]_0\(14) => \bus_equal_gen.data_buf_reg_n_0_[14]\,
      \data_p2_reg[31]_0\(13) => \bus_equal_gen.data_buf_reg_n_0_[13]\,
      \data_p2_reg[31]_0\(12) => \bus_equal_gen.data_buf_reg_n_0_[12]\,
      \data_p2_reg[31]_0\(11) => \bus_equal_gen.data_buf_reg_n_0_[11]\,
      \data_p2_reg[31]_0\(10) => \bus_equal_gen.data_buf_reg_n_0_[10]\,
      \data_p2_reg[31]_0\(9) => \bus_equal_gen.data_buf_reg_n_0_[9]\,
      \data_p2_reg[31]_0\(8) => \bus_equal_gen.data_buf_reg_n_0_[8]\,
      \data_p2_reg[31]_0\(7) => \bus_equal_gen.data_buf_reg_n_0_[7]\,
      \data_p2_reg[31]_0\(6) => \bus_equal_gen.data_buf_reg_n_0_[6]\,
      \data_p2_reg[31]_0\(5) => \bus_equal_gen.data_buf_reg_n_0_[5]\,
      \data_p2_reg[31]_0\(4) => \bus_equal_gen.data_buf_reg_n_0_[4]\,
      \data_p2_reg[31]_0\(3) => \bus_equal_gen.data_buf_reg_n_0_[3]\,
      \data_p2_reg[31]_0\(2) => \bus_equal_gen.data_buf_reg_n_0_[2]\,
      \data_p2_reg[31]_0\(1) => \bus_equal_gen.data_buf_reg_n_0_[1]\,
      \data_p2_reg[31]_0\(0) => \bus_equal_gen.data_buf_reg_n_0_[0]\,
      rdata_ack_t => rdata_ack_t,
      s_ready_t_reg_0 => \bus_equal_gen.rdata_valid_t_reg_n_0\,
      sdata(31 downto 0) => sdata(31 downto 0)
    );
rs_rreq: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_reg_slice
     port map (
      E(0) => E(0),
      Q(8 downto 0) => Q(8 downto 0),
      SR(0) => \^sr\(0),
      ap_NS_fsm(0) => ap_NS_fsm(1),
      ap_clk => ap_clk,
      \data_p1_reg[61]_0\(61 downto 0) => rs2f_rreq_data(61 downto 0),
      \data_p2_reg[61]_0\(61 downto 0) => \data_p2_reg[61]\(61 downto 0),
      push => push,
      rs2f_rreq_ack => rs2f_rreq_ack
    );
\sect_addr_buf[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[10]\,
      O => sect_addr(10)
    );
\sect_addr_buf[11]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[11]\,
      O => sect_addr(11)
    );
\sect_addr_buf[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(0),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[0]\,
      O => sect_addr(12)
    );
\sect_addr_buf[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(1),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[1]\,
      O => sect_addr(13)
    );
\sect_addr_buf[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(2),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[2]\,
      O => sect_addr(14)
    );
\sect_addr_buf[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(3),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[3]\,
      O => sect_addr(15)
    );
\sect_addr_buf[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(4),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[4]\,
      O => sect_addr(16)
    );
\sect_addr_buf[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(5),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[5]\,
      O => sect_addr(17)
    );
\sect_addr_buf[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(6),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[6]\,
      O => sect_addr(18)
    );
\sect_addr_buf[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(7),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[7]\,
      O => sect_addr(19)
    );
\sect_addr_buf[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(8),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[8]\,
      O => sect_addr(20)
    );
\sect_addr_buf[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(9),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[9]\,
      O => sect_addr(21)
    );
\sect_addr_buf[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(10),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[10]\,
      O => sect_addr(22)
    );
\sect_addr_buf[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(11),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[11]\,
      O => sect_addr(23)
    );
\sect_addr_buf[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(12),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[12]\,
      O => sect_addr(24)
    );
\sect_addr_buf[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(13),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[13]\,
      O => sect_addr(25)
    );
\sect_addr_buf[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(14),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[14]\,
      O => sect_addr(26)
    );
\sect_addr_buf[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(15),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[15]\,
      O => sect_addr(27)
    );
\sect_addr_buf[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(16),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[16]\,
      O => sect_addr(28)
    );
\sect_addr_buf[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(17),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[17]\,
      O => sect_addr(29)
    );
\sect_addr_buf[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[2]\,
      O => sect_addr(2)
    );
\sect_addr_buf[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(18),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[18]\,
      O => sect_addr(30)
    );
\sect_addr_buf[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(19),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[19]\,
      O => sect_addr(31)
    );
\sect_addr_buf[32]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(20),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[20]\,
      O => sect_addr(32)
    );
\sect_addr_buf[33]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(21),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[21]\,
      O => sect_addr(33)
    );
\sect_addr_buf[34]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(22),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[22]\,
      O => sect_addr(34)
    );
\sect_addr_buf[35]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(23),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[23]\,
      O => sect_addr(35)
    );
\sect_addr_buf[36]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(24),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[24]\,
      O => sect_addr(36)
    );
\sect_addr_buf[37]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(25),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[25]\,
      O => sect_addr(37)
    );
\sect_addr_buf[38]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(26),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[26]\,
      O => sect_addr(38)
    );
\sect_addr_buf[39]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(27),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[27]\,
      O => sect_addr(39)
    );
\sect_addr_buf[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[3]\,
      O => sect_addr(3)
    );
\sect_addr_buf[40]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(28),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[28]\,
      O => sect_addr(40)
    );
\sect_addr_buf[41]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(29),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[29]\,
      O => sect_addr(41)
    );
\sect_addr_buf[42]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(30),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[30]\,
      O => sect_addr(42)
    );
\sect_addr_buf[43]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(31),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[31]\,
      O => sect_addr(43)
    );
\sect_addr_buf[44]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(32),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[32]\,
      O => sect_addr(44)
    );
\sect_addr_buf[45]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(33),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[33]\,
      O => sect_addr(45)
    );
\sect_addr_buf[46]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(34),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[34]\,
      O => sect_addr(46)
    );
\sect_addr_buf[47]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(35),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[35]\,
      O => sect_addr(47)
    );
\sect_addr_buf[48]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(36),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[36]\,
      O => sect_addr(48)
    );
\sect_addr_buf[49]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(37),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[37]\,
      O => sect_addr(49)
    );
\sect_addr_buf[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[4]\,
      O => sect_addr(4)
    );
\sect_addr_buf[50]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(38),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[38]\,
      O => sect_addr(50)
    );
\sect_addr_buf[51]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(39),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[39]\,
      O => sect_addr(51)
    );
\sect_addr_buf[52]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(40),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[40]\,
      O => sect_addr(52)
    );
\sect_addr_buf[53]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(41),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[41]\,
      O => sect_addr(53)
    );
\sect_addr_buf[54]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(42),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[42]\,
      O => sect_addr(54)
    );
\sect_addr_buf[55]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(43),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[43]\,
      O => sect_addr(55)
    );
\sect_addr_buf[56]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(44),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[44]\,
      O => sect_addr(56)
    );
\sect_addr_buf[57]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(45),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[45]\,
      O => sect_addr(57)
    );
\sect_addr_buf[58]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(46),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[46]\,
      O => sect_addr(58)
    );
\sect_addr_buf[59]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(47),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[47]\,
      O => sect_addr(59)
    );
\sect_addr_buf[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[5]\,
      O => sect_addr(5)
    );
\sect_addr_buf[60]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(48),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[48]\,
      O => sect_addr(60)
    );
\sect_addr_buf[61]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(49),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[49]\,
      O => sect_addr(61)
    );
\sect_addr_buf[62]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(50),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[50]\,
      O => sect_addr(62)
    );
\sect_addr_buf[63]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => p_0_in_0(51),
      I1 => first_sect,
      I2 => \sect_cnt_reg_n_0_[51]\,
      O => sect_addr(63)
    );
\sect_addr_buf[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[6]\,
      O => sect_addr(6)
    );
\sect_addr_buf[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[7]\,
      O => sect_addr(7)
    );
\sect_addr_buf[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[8]\,
      O => sect_addr(8)
    );
\sect_addr_buf[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => first_sect,
      I1 => \start_addr_buf_reg_n_0_[9]\,
      O => sect_addr(9)
    );
\sect_addr_buf_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(10),
      Q => \sect_addr_buf_reg_n_0_[10]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(11),
      Q => \sect_addr_buf_reg_n_0_[11]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(12),
      Q => \sect_addr_buf_reg_n_0_[12]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(13),
      Q => \sect_addr_buf_reg_n_0_[13]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(14),
      Q => \sect_addr_buf_reg_n_0_[14]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(15),
      Q => \sect_addr_buf_reg_n_0_[15]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(16),
      Q => \sect_addr_buf_reg_n_0_[16]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(17),
      Q => \sect_addr_buf_reg_n_0_[17]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(18),
      Q => \sect_addr_buf_reg_n_0_[18]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(19),
      Q => \sect_addr_buf_reg_n_0_[19]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(20),
      Q => \sect_addr_buf_reg_n_0_[20]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(21),
      Q => \sect_addr_buf_reg_n_0_[21]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(22),
      Q => \sect_addr_buf_reg_n_0_[22]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(23),
      Q => \sect_addr_buf_reg_n_0_[23]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(24),
      Q => \sect_addr_buf_reg_n_0_[24]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(25),
      Q => \sect_addr_buf_reg_n_0_[25]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(26),
      Q => \sect_addr_buf_reg_n_0_[26]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(27),
      Q => \sect_addr_buf_reg_n_0_[27]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(28),
      Q => \sect_addr_buf_reg_n_0_[28]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(29),
      Q => \sect_addr_buf_reg_n_0_[29]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(2),
      Q => \sect_addr_buf_reg_n_0_[2]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(30),
      Q => \sect_addr_buf_reg_n_0_[30]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(31),
      Q => \sect_addr_buf_reg_n_0_[31]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(32),
      Q => \sect_addr_buf_reg_n_0_[32]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(33),
      Q => \sect_addr_buf_reg_n_0_[33]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(34),
      Q => \sect_addr_buf_reg_n_0_[34]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(35),
      Q => \sect_addr_buf_reg_n_0_[35]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(36),
      Q => \sect_addr_buf_reg_n_0_[36]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(37),
      Q => \sect_addr_buf_reg_n_0_[37]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(38),
      Q => \sect_addr_buf_reg_n_0_[38]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(39),
      Q => \sect_addr_buf_reg_n_0_[39]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(3),
      Q => \sect_addr_buf_reg_n_0_[3]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(40),
      Q => \sect_addr_buf_reg_n_0_[40]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(41),
      Q => \sect_addr_buf_reg_n_0_[41]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(42),
      Q => \sect_addr_buf_reg_n_0_[42]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(43),
      Q => \sect_addr_buf_reg_n_0_[43]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(44),
      Q => \sect_addr_buf_reg_n_0_[44]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(45),
      Q => \sect_addr_buf_reg_n_0_[45]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(46),
      Q => \sect_addr_buf_reg_n_0_[46]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(47),
      Q => \sect_addr_buf_reg_n_0_[47]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(48),
      Q => \sect_addr_buf_reg_n_0_[48]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(49),
      Q => \sect_addr_buf_reg_n_0_[49]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(4),
      Q => \sect_addr_buf_reg_n_0_[4]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(50),
      Q => \sect_addr_buf_reg_n_0_[50]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(51),
      Q => \sect_addr_buf_reg_n_0_[51]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(52),
      Q => \sect_addr_buf_reg_n_0_[52]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(53),
      Q => \sect_addr_buf_reg_n_0_[53]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(54),
      Q => \sect_addr_buf_reg_n_0_[54]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(55),
      Q => \sect_addr_buf_reg_n_0_[55]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(56),
      Q => \sect_addr_buf_reg_n_0_[56]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(57),
      Q => \sect_addr_buf_reg_n_0_[57]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(58),
      Q => \sect_addr_buf_reg_n_0_[58]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(59),
      Q => \sect_addr_buf_reg_n_0_[59]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(5),
      Q => \sect_addr_buf_reg_n_0_[5]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(60),
      Q => \sect_addr_buf_reg_n_0_[60]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(61),
      Q => \sect_addr_buf_reg_n_0_[61]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(62),
      Q => \sect_addr_buf_reg_n_0_[62]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(63),
      Q => \sect_addr_buf_reg_n_0_[63]\,
      R => \^sr\(0)
    );
\sect_addr_buf_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(6),
      Q => \sect_addr_buf_reg_n_0_[6]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(7),
      Q => \sect_addr_buf_reg_n_0_[7]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(8),
      Q => \sect_addr_buf_reg_n_0_[8]\,
      R => fifo_rctl_n_6
    );
\sect_addr_buf_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => sect_addr(9),
      Q => \sect_addr_buf_reg_n_0_[9]\,
      R => fifo_rctl_n_6
    );
sect_cnt0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => sect_cnt0_carry_n_0,
      CO(2) => sect_cnt0_carry_n_1,
      CO(1) => sect_cnt0_carry_n_2,
      CO(0) => sect_cnt0_carry_n_3,
      CYINIT => \sect_cnt_reg_n_0_[0]\,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(4 downto 1),
      S(3) => \sect_cnt_reg_n_0_[4]\,
      S(2) => \sect_cnt_reg_n_0_[3]\,
      S(1) => \sect_cnt_reg_n_0_[2]\,
      S(0) => \sect_cnt_reg_n_0_[1]\
    );
\sect_cnt0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => sect_cnt0_carry_n_0,
      CO(3) => \sect_cnt0_carry__0_n_0\,
      CO(2) => \sect_cnt0_carry__0_n_1\,
      CO(1) => \sect_cnt0_carry__0_n_2\,
      CO(0) => \sect_cnt0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(8 downto 5),
      S(3) => \sect_cnt_reg_n_0_[8]\,
      S(2) => \sect_cnt_reg_n_0_[7]\,
      S(1) => \sect_cnt_reg_n_0_[6]\,
      S(0) => \sect_cnt_reg_n_0_[5]\
    );
\sect_cnt0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__0_n_0\,
      CO(3) => \sect_cnt0_carry__1_n_0\,
      CO(2) => \sect_cnt0_carry__1_n_1\,
      CO(1) => \sect_cnt0_carry__1_n_2\,
      CO(0) => \sect_cnt0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(12 downto 9),
      S(3) => \sect_cnt_reg_n_0_[12]\,
      S(2) => \sect_cnt_reg_n_0_[11]\,
      S(1) => \sect_cnt_reg_n_0_[10]\,
      S(0) => \sect_cnt_reg_n_0_[9]\
    );
\sect_cnt0_carry__10\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__9_n_0\,
      CO(3) => \sect_cnt0_carry__10_n_0\,
      CO(2) => \sect_cnt0_carry__10_n_1\,
      CO(1) => \sect_cnt0_carry__10_n_2\,
      CO(0) => \sect_cnt0_carry__10_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(48 downto 45),
      S(3) => \sect_cnt_reg_n_0_[48]\,
      S(2) => \sect_cnt_reg_n_0_[47]\,
      S(1) => \sect_cnt_reg_n_0_[46]\,
      S(0) => \sect_cnt_reg_n_0_[45]\
    );
\sect_cnt0_carry__11\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__10_n_0\,
      CO(3 downto 2) => \NLW_sect_cnt0_carry__11_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \sect_cnt0_carry__11_n_2\,
      CO(0) => \sect_cnt0_carry__11_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_sect_cnt0_carry__11_O_UNCONNECTED\(3),
      O(2 downto 0) => sect_cnt0(51 downto 49),
      S(3) => '0',
      S(2) => \sect_cnt_reg_n_0_[51]\,
      S(1) => \sect_cnt_reg_n_0_[50]\,
      S(0) => \sect_cnt_reg_n_0_[49]\
    );
\sect_cnt0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__1_n_0\,
      CO(3) => \sect_cnt0_carry__2_n_0\,
      CO(2) => \sect_cnt0_carry__2_n_1\,
      CO(1) => \sect_cnt0_carry__2_n_2\,
      CO(0) => \sect_cnt0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(16 downto 13),
      S(3) => \sect_cnt_reg_n_0_[16]\,
      S(2) => \sect_cnt_reg_n_0_[15]\,
      S(1) => \sect_cnt_reg_n_0_[14]\,
      S(0) => \sect_cnt_reg_n_0_[13]\
    );
\sect_cnt0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__2_n_0\,
      CO(3) => \sect_cnt0_carry__3_n_0\,
      CO(2) => \sect_cnt0_carry__3_n_1\,
      CO(1) => \sect_cnt0_carry__3_n_2\,
      CO(0) => \sect_cnt0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(20 downto 17),
      S(3) => \sect_cnt_reg_n_0_[20]\,
      S(2) => \sect_cnt_reg_n_0_[19]\,
      S(1) => \sect_cnt_reg_n_0_[18]\,
      S(0) => \sect_cnt_reg_n_0_[17]\
    );
\sect_cnt0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__3_n_0\,
      CO(3) => \sect_cnt0_carry__4_n_0\,
      CO(2) => \sect_cnt0_carry__4_n_1\,
      CO(1) => \sect_cnt0_carry__4_n_2\,
      CO(0) => \sect_cnt0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(24 downto 21),
      S(3) => \sect_cnt_reg_n_0_[24]\,
      S(2) => \sect_cnt_reg_n_0_[23]\,
      S(1) => \sect_cnt_reg_n_0_[22]\,
      S(0) => \sect_cnt_reg_n_0_[21]\
    );
\sect_cnt0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__4_n_0\,
      CO(3) => \sect_cnt0_carry__5_n_0\,
      CO(2) => \sect_cnt0_carry__5_n_1\,
      CO(1) => \sect_cnt0_carry__5_n_2\,
      CO(0) => \sect_cnt0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(28 downto 25),
      S(3) => \sect_cnt_reg_n_0_[28]\,
      S(2) => \sect_cnt_reg_n_0_[27]\,
      S(1) => \sect_cnt_reg_n_0_[26]\,
      S(0) => \sect_cnt_reg_n_0_[25]\
    );
\sect_cnt0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__5_n_0\,
      CO(3) => \sect_cnt0_carry__6_n_0\,
      CO(2) => \sect_cnt0_carry__6_n_1\,
      CO(1) => \sect_cnt0_carry__6_n_2\,
      CO(0) => \sect_cnt0_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(32 downto 29),
      S(3) => \sect_cnt_reg_n_0_[32]\,
      S(2) => \sect_cnt_reg_n_0_[31]\,
      S(1) => \sect_cnt_reg_n_0_[30]\,
      S(0) => \sect_cnt_reg_n_0_[29]\
    );
\sect_cnt0_carry__7\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__6_n_0\,
      CO(3) => \sect_cnt0_carry__7_n_0\,
      CO(2) => \sect_cnt0_carry__7_n_1\,
      CO(1) => \sect_cnt0_carry__7_n_2\,
      CO(0) => \sect_cnt0_carry__7_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(36 downto 33),
      S(3) => \sect_cnt_reg_n_0_[36]\,
      S(2) => \sect_cnt_reg_n_0_[35]\,
      S(1) => \sect_cnt_reg_n_0_[34]\,
      S(0) => \sect_cnt_reg_n_0_[33]\
    );
\sect_cnt0_carry__8\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__7_n_0\,
      CO(3) => \sect_cnt0_carry__8_n_0\,
      CO(2) => \sect_cnt0_carry__8_n_1\,
      CO(1) => \sect_cnt0_carry__8_n_2\,
      CO(0) => \sect_cnt0_carry__8_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(40 downto 37),
      S(3) => \sect_cnt_reg_n_0_[40]\,
      S(2) => \sect_cnt_reg_n_0_[39]\,
      S(1) => \sect_cnt_reg_n_0_[38]\,
      S(0) => \sect_cnt_reg_n_0_[37]\
    );
\sect_cnt0_carry__9\: unisim.vcomponents.CARRY4
     port map (
      CI => \sect_cnt0_carry__8_n_0\,
      CO(3) => \sect_cnt0_carry__9_n_0\,
      CO(2) => \sect_cnt0_carry__9_n_1\,
      CO(1) => \sect_cnt0_carry__9_n_2\,
      CO(0) => \sect_cnt0_carry__9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => sect_cnt0(44 downto 41),
      S(3) => \sect_cnt_reg_n_0_[44]\,
      S(2) => \sect_cnt_reg_n_0_[43]\,
      S(1) => \sect_cnt_reg_n_0_[42]\,
      S(0) => \sect_cnt_reg_n_0_[41]\
    );
\sect_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_53,
      Q => \sect_cnt_reg_n_0_[0]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_43,
      Q => \sect_cnt_reg_n_0_[10]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_42,
      Q => \sect_cnt_reg_n_0_[11]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_41,
      Q => \sect_cnt_reg_n_0_[12]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_40,
      Q => \sect_cnt_reg_n_0_[13]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_39,
      Q => \sect_cnt_reg_n_0_[14]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_38,
      Q => \sect_cnt_reg_n_0_[15]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_37,
      Q => \sect_cnt_reg_n_0_[16]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_36,
      Q => \sect_cnt_reg_n_0_[17]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_35,
      Q => \sect_cnt_reg_n_0_[18]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_34,
      Q => \sect_cnt_reg_n_0_[19]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_52,
      Q => \sect_cnt_reg_n_0_[1]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_33,
      Q => \sect_cnt_reg_n_0_[20]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_32,
      Q => \sect_cnt_reg_n_0_[21]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_31,
      Q => \sect_cnt_reg_n_0_[22]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_30,
      Q => \sect_cnt_reg_n_0_[23]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_29,
      Q => \sect_cnt_reg_n_0_[24]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_28,
      Q => \sect_cnt_reg_n_0_[25]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_27,
      Q => \sect_cnt_reg_n_0_[26]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_26,
      Q => \sect_cnt_reg_n_0_[27]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_25,
      Q => \sect_cnt_reg_n_0_[28]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_24,
      Q => \sect_cnt_reg_n_0_[29]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_51,
      Q => \sect_cnt_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_23,
      Q => \sect_cnt_reg_n_0_[30]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_22,
      Q => \sect_cnt_reg_n_0_[31]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_21,
      Q => \sect_cnt_reg_n_0_[32]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_20,
      Q => \sect_cnt_reg_n_0_[33]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_19,
      Q => \sect_cnt_reg_n_0_[34]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_18,
      Q => \sect_cnt_reg_n_0_[35]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_17,
      Q => \sect_cnt_reg_n_0_[36]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_16,
      Q => \sect_cnt_reg_n_0_[37]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_15,
      Q => \sect_cnt_reg_n_0_[38]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_14,
      Q => \sect_cnt_reg_n_0_[39]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_50,
      Q => \sect_cnt_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_13,
      Q => \sect_cnt_reg_n_0_[40]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_12,
      Q => \sect_cnt_reg_n_0_[41]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_11,
      Q => \sect_cnt_reg_n_0_[42]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_10,
      Q => \sect_cnt_reg_n_0_[43]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_9,
      Q => \sect_cnt_reg_n_0_[44]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_8,
      Q => \sect_cnt_reg_n_0_[45]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_7,
      Q => \sect_cnt_reg_n_0_[46]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_6,
      Q => \sect_cnt_reg_n_0_[47]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_5,
      Q => \sect_cnt_reg_n_0_[48]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_4,
      Q => \sect_cnt_reg_n_0_[49]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_49,
      Q => \sect_cnt_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_3,
      Q => \sect_cnt_reg_n_0_[50]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_2,
      Q => \sect_cnt_reg_n_0_[51]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_48,
      Q => \sect_cnt_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_47,
      Q => \sect_cnt_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_46,
      Q => \sect_cnt_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_45,
      Q => \sect_cnt_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\sect_cnt_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_16,
      D => fifo_rreq_n_44,
      Q => \sect_cnt_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\sect_len_buf[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CC0FAAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[2]\,
      I1 => beat_len_buf(0),
      I2 => \start_addr_buf_reg_n_0_[2]\,
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[0]_i_1_n_0\
    );
\sect_len_buf[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[3]\,
      I1 => \start_addr_buf_reg_n_0_[3]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[1]_i_1_n_0\
    );
\sect_len_buf[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[4]\,
      I1 => \start_addr_buf_reg_n_0_[4]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[2]_i_1_n_0\
    );
\sect_len_buf[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[5]\,
      I1 => \start_addr_buf_reg_n_0_[5]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[3]_i_1_n_0\
    );
\sect_len_buf[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[6]\,
      I1 => \start_addr_buf_reg_n_0_[6]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[4]_i_1_n_0\
    );
\sect_len_buf[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[7]\,
      I1 => \start_addr_buf_reg_n_0_[7]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[5]_i_1_n_0\
    );
\sect_len_buf[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[8]\,
      I1 => \start_addr_buf_reg_n_0_[8]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[6]_i_1_n_0\
    );
\sect_len_buf[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[9]\,
      I1 => \start_addr_buf_reg_n_0_[9]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[7]_i_1_n_0\
    );
\sect_len_buf[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F033AAFF"
    )
        port map (
      I0 => \end_addr_buf_reg_n_0_[10]\,
      I1 => \start_addr_buf_reg_n_0_[10]\,
      I2 => beat_len_buf(7),
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[8]_i_1_n_0\
    );
\sect_len_buf[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AA0FCCFF"
    )
        port map (
      I0 => beat_len_buf(7),
      I1 => \end_addr_buf_reg_n_0_[11]\,
      I2 => \start_addr_buf_reg_n_0_[11]\,
      I3 => last_sect,
      I4 => first_sect,
      O => \sect_len_buf[9]_i_2_n_0\
    );
\sect_len_buf_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[0]_i_1_n_0\,
      Q => p_1_in(0),
      R => \^sr\(0)
    );
\sect_len_buf_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[1]_i_1_n_0\,
      Q => p_1_in(1),
      R => \^sr\(0)
    );
\sect_len_buf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[2]_i_1_n_0\,
      Q => p_1_in(2),
      R => \^sr\(0)
    );
\sect_len_buf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[3]_i_1_n_0\,
      Q => p_1_in(3),
      R => \^sr\(0)
    );
\sect_len_buf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[4]_i_1_n_0\,
      Q => p_1_in(4),
      R => \^sr\(0)
    );
\sect_len_buf_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[5]_i_1_n_0\,
      Q => \sect_len_buf_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\sect_len_buf_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[6]_i_1_n_0\,
      Q => \sect_len_buf_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\sect_len_buf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[7]_i_1_n_0\,
      Q => \sect_len_buf_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\sect_len_buf_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[8]_i_1_n_0\,
      Q => \sect_len_buf_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\sect_len_buf_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => p_21_in,
      D => \sect_len_buf[9]_i_2_n_0\,
      Q => \sect_len_buf_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[10]\,
      Q => \start_addr_buf_reg_n_0_[10]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[11]\,
      Q => \start_addr_buf_reg_n_0_[11]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[12]\,
      Q => p_0_in_0(0),
      R => \^sr\(0)
    );
\start_addr_buf_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[13]\,
      Q => p_0_in_0(1),
      R => \^sr\(0)
    );
\start_addr_buf_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[14]\,
      Q => p_0_in_0(2),
      R => \^sr\(0)
    );
\start_addr_buf_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[15]\,
      Q => p_0_in_0(3),
      R => \^sr\(0)
    );
\start_addr_buf_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[16]\,
      Q => p_0_in_0(4),
      R => \^sr\(0)
    );
\start_addr_buf_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[17]\,
      Q => p_0_in_0(5),
      R => \^sr\(0)
    );
\start_addr_buf_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[18]\,
      Q => p_0_in_0(6),
      R => \^sr\(0)
    );
\start_addr_buf_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[19]\,
      Q => p_0_in_0(7),
      R => \^sr\(0)
    );
\start_addr_buf_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[20]\,
      Q => p_0_in_0(8),
      R => \^sr\(0)
    );
\start_addr_buf_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[21]\,
      Q => p_0_in_0(9),
      R => \^sr\(0)
    );
\start_addr_buf_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[22]\,
      Q => p_0_in_0(10),
      R => \^sr\(0)
    );
\start_addr_buf_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[23]\,
      Q => p_0_in_0(11),
      R => \^sr\(0)
    );
\start_addr_buf_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[24]\,
      Q => p_0_in_0(12),
      R => \^sr\(0)
    );
\start_addr_buf_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[25]\,
      Q => p_0_in_0(13),
      R => \^sr\(0)
    );
\start_addr_buf_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[26]\,
      Q => p_0_in_0(14),
      R => \^sr\(0)
    );
\start_addr_buf_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[27]\,
      Q => p_0_in_0(15),
      R => \^sr\(0)
    );
\start_addr_buf_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[28]\,
      Q => p_0_in_0(16),
      R => \^sr\(0)
    );
\start_addr_buf_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[29]\,
      Q => p_0_in_0(17),
      R => \^sr\(0)
    );
\start_addr_buf_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[2]\,
      Q => \start_addr_buf_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[30]\,
      Q => p_0_in_0(18),
      R => \^sr\(0)
    );
\start_addr_buf_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[31]\,
      Q => p_0_in_0(19),
      R => \^sr\(0)
    );
\start_addr_buf_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[32]\,
      Q => p_0_in_0(20),
      R => \^sr\(0)
    );
\start_addr_buf_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[33]\,
      Q => p_0_in_0(21),
      R => \^sr\(0)
    );
\start_addr_buf_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[34]\,
      Q => p_0_in_0(22),
      R => \^sr\(0)
    );
\start_addr_buf_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[35]\,
      Q => p_0_in_0(23),
      R => \^sr\(0)
    );
\start_addr_buf_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[36]\,
      Q => p_0_in_0(24),
      R => \^sr\(0)
    );
\start_addr_buf_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[37]\,
      Q => p_0_in_0(25),
      R => \^sr\(0)
    );
\start_addr_buf_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[38]\,
      Q => p_0_in_0(26),
      R => \^sr\(0)
    );
\start_addr_buf_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[39]\,
      Q => p_0_in_0(27),
      R => \^sr\(0)
    );
\start_addr_buf_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[3]\,
      Q => \start_addr_buf_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[40]\,
      Q => p_0_in_0(28),
      R => \^sr\(0)
    );
\start_addr_buf_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[41]\,
      Q => p_0_in_0(29),
      R => \^sr\(0)
    );
\start_addr_buf_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[42]\,
      Q => p_0_in_0(30),
      R => \^sr\(0)
    );
\start_addr_buf_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[43]\,
      Q => p_0_in_0(31),
      R => \^sr\(0)
    );
\start_addr_buf_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[44]\,
      Q => p_0_in_0(32),
      R => \^sr\(0)
    );
\start_addr_buf_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[45]\,
      Q => p_0_in_0(33),
      R => \^sr\(0)
    );
\start_addr_buf_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[46]\,
      Q => p_0_in_0(34),
      R => \^sr\(0)
    );
\start_addr_buf_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[47]\,
      Q => p_0_in_0(35),
      R => \^sr\(0)
    );
\start_addr_buf_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[48]\,
      Q => p_0_in_0(36),
      R => \^sr\(0)
    );
\start_addr_buf_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[49]\,
      Q => p_0_in_0(37),
      R => \^sr\(0)
    );
\start_addr_buf_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[4]\,
      Q => \start_addr_buf_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[50]\,
      Q => p_0_in_0(38),
      R => \^sr\(0)
    );
\start_addr_buf_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[51]\,
      Q => p_0_in_0(39),
      R => \^sr\(0)
    );
\start_addr_buf_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[52]\,
      Q => p_0_in_0(40),
      R => \^sr\(0)
    );
\start_addr_buf_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[53]\,
      Q => p_0_in_0(41),
      R => \^sr\(0)
    );
\start_addr_buf_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[54]\,
      Q => p_0_in_0(42),
      R => \^sr\(0)
    );
\start_addr_buf_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[55]\,
      Q => p_0_in_0(43),
      R => \^sr\(0)
    );
\start_addr_buf_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[56]\,
      Q => p_0_in_0(44),
      R => \^sr\(0)
    );
\start_addr_buf_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[57]\,
      Q => p_0_in_0(45),
      R => \^sr\(0)
    );
\start_addr_buf_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[58]\,
      Q => p_0_in_0(46),
      R => \^sr\(0)
    );
\start_addr_buf_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[59]\,
      Q => p_0_in_0(47),
      R => \^sr\(0)
    );
\start_addr_buf_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[5]\,
      Q => \start_addr_buf_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[60]\,
      Q => p_0_in_0(48),
      R => \^sr\(0)
    );
\start_addr_buf_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[61]\,
      Q => p_0_in_0(49),
      R => \^sr\(0)
    );
\start_addr_buf_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[62]\,
      Q => p_0_in_0(50),
      R => \^sr\(0)
    );
\start_addr_buf_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[63]\,
      Q => p_0_in_0(51),
      R => \^sr\(0)
    );
\start_addr_buf_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[6]\,
      Q => \start_addr_buf_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[7]\,
      Q => \start_addr_buf_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[8]\,
      Q => \start_addr_buf_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\start_addr_buf_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => next_rreq,
      D => \start_addr_reg_n_0_[9]\,
      Q => \start_addr_buf_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\start_addr_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(8),
      Q => \start_addr_reg_n_0_[10]\,
      R => \^sr\(0)
    );
\start_addr_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(9),
      Q => \start_addr_reg_n_0_[11]\,
      R => \^sr\(0)
    );
\start_addr_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(10),
      Q => \start_addr_reg_n_0_[12]\,
      R => \^sr\(0)
    );
\start_addr_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(11),
      Q => \start_addr_reg_n_0_[13]\,
      R => \^sr\(0)
    );
\start_addr_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(12),
      Q => \start_addr_reg_n_0_[14]\,
      R => \^sr\(0)
    );
\start_addr_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(13),
      Q => \start_addr_reg_n_0_[15]\,
      R => \^sr\(0)
    );
\start_addr_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(14),
      Q => \start_addr_reg_n_0_[16]\,
      R => \^sr\(0)
    );
\start_addr_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(15),
      Q => \start_addr_reg_n_0_[17]\,
      R => \^sr\(0)
    );
\start_addr_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(16),
      Q => \start_addr_reg_n_0_[18]\,
      R => \^sr\(0)
    );
\start_addr_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(17),
      Q => \start_addr_reg_n_0_[19]\,
      R => \^sr\(0)
    );
\start_addr_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(18),
      Q => \start_addr_reg_n_0_[20]\,
      R => \^sr\(0)
    );
\start_addr_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(19),
      Q => \start_addr_reg_n_0_[21]\,
      R => \^sr\(0)
    );
\start_addr_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(20),
      Q => \start_addr_reg_n_0_[22]\,
      R => \^sr\(0)
    );
\start_addr_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(21),
      Q => \start_addr_reg_n_0_[23]\,
      R => \^sr\(0)
    );
\start_addr_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(22),
      Q => \start_addr_reg_n_0_[24]\,
      R => \^sr\(0)
    );
\start_addr_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(23),
      Q => \start_addr_reg_n_0_[25]\,
      R => \^sr\(0)
    );
\start_addr_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(24),
      Q => \start_addr_reg_n_0_[26]\,
      R => \^sr\(0)
    );
\start_addr_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(25),
      Q => \start_addr_reg_n_0_[27]\,
      R => \^sr\(0)
    );
\start_addr_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(26),
      Q => \start_addr_reg_n_0_[28]\,
      R => \^sr\(0)
    );
\start_addr_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(27),
      Q => \start_addr_reg_n_0_[29]\,
      R => \^sr\(0)
    );
\start_addr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(0),
      Q => \start_addr_reg_n_0_[2]\,
      R => \^sr\(0)
    );
\start_addr_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(28),
      Q => \start_addr_reg_n_0_[30]\,
      R => \^sr\(0)
    );
\start_addr_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(29),
      Q => \start_addr_reg_n_0_[31]\,
      R => \^sr\(0)
    );
\start_addr_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(30),
      Q => \start_addr_reg_n_0_[32]\,
      R => \^sr\(0)
    );
\start_addr_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(31),
      Q => \start_addr_reg_n_0_[33]\,
      R => \^sr\(0)
    );
\start_addr_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(32),
      Q => \start_addr_reg_n_0_[34]\,
      R => \^sr\(0)
    );
\start_addr_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(33),
      Q => \start_addr_reg_n_0_[35]\,
      R => \^sr\(0)
    );
\start_addr_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(34),
      Q => \start_addr_reg_n_0_[36]\,
      R => \^sr\(0)
    );
\start_addr_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(35),
      Q => \start_addr_reg_n_0_[37]\,
      R => \^sr\(0)
    );
\start_addr_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(36),
      Q => \start_addr_reg_n_0_[38]\,
      R => \^sr\(0)
    );
\start_addr_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(37),
      Q => \start_addr_reg_n_0_[39]\,
      R => \^sr\(0)
    );
\start_addr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(1),
      Q => \start_addr_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\start_addr_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(38),
      Q => \start_addr_reg_n_0_[40]\,
      R => \^sr\(0)
    );
\start_addr_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(39),
      Q => \start_addr_reg_n_0_[41]\,
      R => \^sr\(0)
    );
\start_addr_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(40),
      Q => \start_addr_reg_n_0_[42]\,
      R => \^sr\(0)
    );
\start_addr_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(41),
      Q => \start_addr_reg_n_0_[43]\,
      R => \^sr\(0)
    );
\start_addr_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(42),
      Q => \start_addr_reg_n_0_[44]\,
      R => \^sr\(0)
    );
\start_addr_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(43),
      Q => \start_addr_reg_n_0_[45]\,
      R => \^sr\(0)
    );
\start_addr_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(44),
      Q => \start_addr_reg_n_0_[46]\,
      R => \^sr\(0)
    );
\start_addr_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(45),
      Q => \start_addr_reg_n_0_[47]\,
      R => \^sr\(0)
    );
\start_addr_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(46),
      Q => \start_addr_reg_n_0_[48]\,
      R => \^sr\(0)
    );
\start_addr_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(47),
      Q => \start_addr_reg_n_0_[49]\,
      R => \^sr\(0)
    );
\start_addr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(2),
      Q => \start_addr_reg_n_0_[4]\,
      R => \^sr\(0)
    );
\start_addr_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(48),
      Q => \start_addr_reg_n_0_[50]\,
      R => \^sr\(0)
    );
\start_addr_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(49),
      Q => \start_addr_reg_n_0_[51]\,
      R => \^sr\(0)
    );
\start_addr_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(50),
      Q => \start_addr_reg_n_0_[52]\,
      R => \^sr\(0)
    );
\start_addr_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(51),
      Q => \start_addr_reg_n_0_[53]\,
      R => \^sr\(0)
    );
\start_addr_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(52),
      Q => \start_addr_reg_n_0_[54]\,
      R => \^sr\(0)
    );
\start_addr_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(53),
      Q => \start_addr_reg_n_0_[55]\,
      R => \^sr\(0)
    );
\start_addr_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(54),
      Q => \start_addr_reg_n_0_[56]\,
      R => \^sr\(0)
    );
\start_addr_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(55),
      Q => \start_addr_reg_n_0_[57]\,
      R => \^sr\(0)
    );
\start_addr_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(56),
      Q => \start_addr_reg_n_0_[58]\,
      R => \^sr\(0)
    );
\start_addr_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(57),
      Q => \start_addr_reg_n_0_[59]\,
      R => \^sr\(0)
    );
\start_addr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(3),
      Q => \start_addr_reg_n_0_[5]\,
      R => \^sr\(0)
    );
\start_addr_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(58),
      Q => \start_addr_reg_n_0_[60]\,
      R => \^sr\(0)
    );
\start_addr_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(59),
      Q => \start_addr_reg_n_0_[61]\,
      R => \^sr\(0)
    );
\start_addr_reg[62]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(60),
      Q => \start_addr_reg_n_0_[62]\,
      R => \^sr\(0)
    );
\start_addr_reg[63]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(61),
      Q => \start_addr_reg_n_0_[63]\,
      R => \^sr\(0)
    );
\start_addr_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(4),
      Q => \start_addr_reg_n_0_[6]\,
      R => \^sr\(0)
    );
\start_addr_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(5),
      Q => \start_addr_reg_n_0_[7]\,
      R => \^sr\(0)
    );
\start_addr_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(6),
      Q => \start_addr_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\start_addr_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => fifo_rctl_n_5,
      D => \^q\(7),
      Q => \start_addr_reg_n_0_[9]\,
      R => \^sr\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi is
  port (
    full_n_reg : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    \could_multi_bursts.ARVALID_Dummy_reg\ : out STD_LOGIC;
    m_axi_gmem_ARADDR : out STD_LOGIC_VECTOR ( 61 downto 0 );
    \could_multi_bursts.arlen_buf_reg[4]\ : out STD_LOGIC_VECTOR ( 4 downto 0 );
    ap_NS_fsm : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 32 downto 0 );
    m_axi_gmem_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_RVALID : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 8 downto 0 );
    m_axi_gmem_ARREADY : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    \data_p2_reg[61]\ : in STD_LOGIC_VECTOR ( 61 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi is
begin
bus_read: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi_read
     port map (
      D(32 downto 0) => D(32 downto 0),
      E(0) => ap_NS_fsm(2),
      Q(8 downto 0) => Q(8 downto 0),
      SR(0) => SR(0),
      ap_NS_fsm(2) => ap_NS_fsm(3),
      ap_NS_fsm(1 downto 0) => ap_NS_fsm(1 downto 0),
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      \could_multi_bursts.ARVALID_Dummy_reg_0\ => \could_multi_bursts.ARVALID_Dummy_reg\,
      \could_multi_bursts.arlen_buf_reg[4]_0\(4 downto 0) => \could_multi_bursts.arlen_buf_reg[4]\(4 downto 0),
      \data_p2_reg[61]\(61 downto 0) => \data_p2_reg[61]\(61 downto 0),
      full_n_reg => full_n_reg,
      m_axi_gmem_ARADDR(61 downto 0) => m_axi_gmem_ARADDR(61 downto 0),
      m_axi_gmem_ARREADY => m_axi_gmem_ARREADY,
      m_axi_gmem_RRESP(1 downto 0) => m_axi_gmem_RRESP(1 downto 0),
      m_axi_gmem_RVALID => m_axi_gmem_RVALID,
      sdata(31 downto 0) => sdata(31 downto 0)
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
    m_axi_gmem_AWVALID : out STD_LOGIC;
    m_axi_gmem_AWREADY : in STD_LOGIC;
    m_axi_gmem_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_gmem_AWID : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_gmem_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_AWUSER : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_WVALID : out STD_LOGIC;
    m_axi_gmem_WREADY : in STD_LOGIC;
    m_axi_gmem_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_gmem_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_WLAST : out STD_LOGIC;
    m_axi_gmem_WID : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_WUSER : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_ARVALID : out STD_LOGIC;
    m_axi_gmem_ARREADY : in STD_LOGIC;
    m_axi_gmem_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_gmem_ARID : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_gmem_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_ARUSER : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_RVALID : in STD_LOGIC;
    m_axi_gmem_RREADY : out STD_LOGIC;
    m_axi_gmem_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_gmem_RLAST : in STD_LOGIC;
    m_axi_gmem_RID : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_RUSER : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_BVALID : in STD_LOGIC;
    m_axi_gmem_BREADY : out STD_LOGIC;
    m_axi_gmem_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_BID : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_gmem_BUSER : in STD_LOGIC_VECTOR ( 0 to 0 );
    sdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    opeout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    count : in STD_LOGIC_VECTOR ( 31 downto 0 );
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
  attribute C_M_AXI_DATA_WIDTH : integer;
  attribute C_M_AXI_DATA_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 32;
  attribute C_M_AXI_GMEM_ADDR_WIDTH : integer;
  attribute C_M_AXI_GMEM_ADDR_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 64;
  attribute C_M_AXI_GMEM_ARUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_ARUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_GMEM_AWUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_AWUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_GMEM_BUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_BUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_GMEM_CACHE_VALUE : string;
  attribute C_M_AXI_GMEM_CACHE_VALUE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "4'b0011";
  attribute C_M_AXI_GMEM_DATA_WIDTH : integer;
  attribute C_M_AXI_GMEM_DATA_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 32;
  attribute C_M_AXI_GMEM_ID_WIDTH : integer;
  attribute C_M_AXI_GMEM_ID_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_GMEM_PROT_VALUE : string;
  attribute C_M_AXI_GMEM_PROT_VALUE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "3'b000";
  attribute C_M_AXI_GMEM_RUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_RUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_GMEM_USER_VALUE : integer;
  attribute C_M_AXI_GMEM_USER_VALUE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 0;
  attribute C_M_AXI_GMEM_WSTRB_WIDTH : integer;
  attribute C_M_AXI_GMEM_WSTRB_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 4;
  attribute C_M_AXI_GMEM_WUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_WUSER_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 1;
  attribute C_M_AXI_WSTRB_WIDTH : integer;
  attribute C_M_AXI_WSTRB_WIDTH of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is 4;
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
  attribute ap_ST_fsm_state1 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b000000001";
  attribute ap_ST_fsm_state2 : string;
  attribute ap_ST_fsm_state2 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b000000010";
  attribute ap_ST_fsm_state3 : string;
  attribute ap_ST_fsm_state3 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b000000100";
  attribute ap_ST_fsm_state4 : string;
  attribute ap_ST_fsm_state4 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b000001000";
  attribute ap_ST_fsm_state5 : string;
  attribute ap_ST_fsm_state5 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b000010000";
  attribute ap_ST_fsm_state6 : string;
  attribute ap_ST_fsm_state6 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b000100000";
  attribute ap_ST_fsm_state7 : string;
  attribute ap_ST_fsm_state7 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b001000000";
  attribute ap_ST_fsm_state8 : string;
  attribute ap_ST_fsm_state8 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b010000000";
  attribute ap_ST_fsm_state9 : string;
  attribute ap_ST_fsm_state9 of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "9'b100000000";
  attribute hls_module : string;
  attribute hls_module of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation : entity is "yes";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation is
  signal \<const0>\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[2]\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[3]\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[4]\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[5]\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[6]\ : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[7]\ : STD_LOGIC;
  signal ap_CS_fsm_state1 : STD_LOGIC;
  signal ap_CS_fsm_state2 : STD_LOGIC;
  signal ap_CS_fsm_state9 : STD_LOGIC;
  signal ap_NS_fsm : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal ap_rst_n_inv : STD_LOGIC;
  signal gmem_addr_reg_158 : STD_LOGIC_VECTOR ( 61 downto 0 );
  signal \^m_axi_gmem_araddr\ : STD_LOGIC_VECTOR ( 63 downto 2 );
  signal \^m_axi_gmem_arlen\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal sext_ln324_fu_148_p1 : STD_LOGIC_VECTOR ( 61 downto 0 );
  attribute FSM_ENCODING : string;
  attribute FSM_ENCODING of \ap_CS_fsm_reg[0]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[1]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[2]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[3]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[4]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[5]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[6]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[7]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[8]\ : label is "none";
begin
  m_axi_gmem_ARADDR(63 downto 2) <= \^m_axi_gmem_araddr\(63 downto 2);
  m_axi_gmem_ARADDR(1) <= \<const0>\;
  m_axi_gmem_ARADDR(0) <= \<const0>\;
  m_axi_gmem_ARBURST(1) <= \<const0>\;
  m_axi_gmem_ARBURST(0) <= \<const0>\;
  m_axi_gmem_ARCACHE(3) <= \<const0>\;
  m_axi_gmem_ARCACHE(2) <= \<const0>\;
  m_axi_gmem_ARCACHE(1) <= \<const0>\;
  m_axi_gmem_ARCACHE(0) <= \<const0>\;
  m_axi_gmem_ARID(0) <= \<const0>\;
  m_axi_gmem_ARLEN(7) <= \<const0>\;
  m_axi_gmem_ARLEN(6) <= \<const0>\;
  m_axi_gmem_ARLEN(5) <= \<const0>\;
  m_axi_gmem_ARLEN(4 downto 0) <= \^m_axi_gmem_arlen\(4 downto 0);
  m_axi_gmem_ARLOCK(1) <= \<const0>\;
  m_axi_gmem_ARLOCK(0) <= \<const0>\;
  m_axi_gmem_ARPROT(2) <= \<const0>\;
  m_axi_gmem_ARPROT(1) <= \<const0>\;
  m_axi_gmem_ARPROT(0) <= \<const0>\;
  m_axi_gmem_ARQOS(3) <= \<const0>\;
  m_axi_gmem_ARQOS(2) <= \<const0>\;
  m_axi_gmem_ARQOS(1) <= \<const0>\;
  m_axi_gmem_ARQOS(0) <= \<const0>\;
  m_axi_gmem_ARREGION(3) <= \<const0>\;
  m_axi_gmem_ARREGION(2) <= \<const0>\;
  m_axi_gmem_ARREGION(1) <= \<const0>\;
  m_axi_gmem_ARREGION(0) <= \<const0>\;
  m_axi_gmem_ARSIZE(2) <= \<const0>\;
  m_axi_gmem_ARSIZE(1) <= \<const0>\;
  m_axi_gmem_ARSIZE(0) <= \<const0>\;
  m_axi_gmem_ARUSER(0) <= \<const0>\;
  m_axi_gmem_AWADDR(63) <= \<const0>\;
  m_axi_gmem_AWADDR(62) <= \<const0>\;
  m_axi_gmem_AWADDR(61) <= \<const0>\;
  m_axi_gmem_AWADDR(60) <= \<const0>\;
  m_axi_gmem_AWADDR(59) <= \<const0>\;
  m_axi_gmem_AWADDR(58) <= \<const0>\;
  m_axi_gmem_AWADDR(57) <= \<const0>\;
  m_axi_gmem_AWADDR(56) <= \<const0>\;
  m_axi_gmem_AWADDR(55) <= \<const0>\;
  m_axi_gmem_AWADDR(54) <= \<const0>\;
  m_axi_gmem_AWADDR(53) <= \<const0>\;
  m_axi_gmem_AWADDR(52) <= \<const0>\;
  m_axi_gmem_AWADDR(51) <= \<const0>\;
  m_axi_gmem_AWADDR(50) <= \<const0>\;
  m_axi_gmem_AWADDR(49) <= \<const0>\;
  m_axi_gmem_AWADDR(48) <= \<const0>\;
  m_axi_gmem_AWADDR(47) <= \<const0>\;
  m_axi_gmem_AWADDR(46) <= \<const0>\;
  m_axi_gmem_AWADDR(45) <= \<const0>\;
  m_axi_gmem_AWADDR(44) <= \<const0>\;
  m_axi_gmem_AWADDR(43) <= \<const0>\;
  m_axi_gmem_AWADDR(42) <= \<const0>\;
  m_axi_gmem_AWADDR(41) <= \<const0>\;
  m_axi_gmem_AWADDR(40) <= \<const0>\;
  m_axi_gmem_AWADDR(39) <= \<const0>\;
  m_axi_gmem_AWADDR(38) <= \<const0>\;
  m_axi_gmem_AWADDR(37) <= \<const0>\;
  m_axi_gmem_AWADDR(36) <= \<const0>\;
  m_axi_gmem_AWADDR(35) <= \<const0>\;
  m_axi_gmem_AWADDR(34) <= \<const0>\;
  m_axi_gmem_AWADDR(33) <= \<const0>\;
  m_axi_gmem_AWADDR(32) <= \<const0>\;
  m_axi_gmem_AWADDR(31) <= \<const0>\;
  m_axi_gmem_AWADDR(30) <= \<const0>\;
  m_axi_gmem_AWADDR(29) <= \<const0>\;
  m_axi_gmem_AWADDR(28) <= \<const0>\;
  m_axi_gmem_AWADDR(27) <= \<const0>\;
  m_axi_gmem_AWADDR(26) <= \<const0>\;
  m_axi_gmem_AWADDR(25) <= \<const0>\;
  m_axi_gmem_AWADDR(24) <= \<const0>\;
  m_axi_gmem_AWADDR(23) <= \<const0>\;
  m_axi_gmem_AWADDR(22) <= \<const0>\;
  m_axi_gmem_AWADDR(21) <= \<const0>\;
  m_axi_gmem_AWADDR(20) <= \<const0>\;
  m_axi_gmem_AWADDR(19) <= \<const0>\;
  m_axi_gmem_AWADDR(18) <= \<const0>\;
  m_axi_gmem_AWADDR(17) <= \<const0>\;
  m_axi_gmem_AWADDR(16) <= \<const0>\;
  m_axi_gmem_AWADDR(15) <= \<const0>\;
  m_axi_gmem_AWADDR(14) <= \<const0>\;
  m_axi_gmem_AWADDR(13) <= \<const0>\;
  m_axi_gmem_AWADDR(12) <= \<const0>\;
  m_axi_gmem_AWADDR(11) <= \<const0>\;
  m_axi_gmem_AWADDR(10) <= \<const0>\;
  m_axi_gmem_AWADDR(9) <= \<const0>\;
  m_axi_gmem_AWADDR(8) <= \<const0>\;
  m_axi_gmem_AWADDR(7) <= \<const0>\;
  m_axi_gmem_AWADDR(6) <= \<const0>\;
  m_axi_gmem_AWADDR(5) <= \<const0>\;
  m_axi_gmem_AWADDR(4) <= \<const0>\;
  m_axi_gmem_AWADDR(3) <= \<const0>\;
  m_axi_gmem_AWADDR(2) <= \<const0>\;
  m_axi_gmem_AWADDR(1) <= \<const0>\;
  m_axi_gmem_AWADDR(0) <= \<const0>\;
  m_axi_gmem_AWBURST(1) <= \<const0>\;
  m_axi_gmem_AWBURST(0) <= \<const0>\;
  m_axi_gmem_AWCACHE(3) <= \<const0>\;
  m_axi_gmem_AWCACHE(2) <= \<const0>\;
  m_axi_gmem_AWCACHE(1) <= \<const0>\;
  m_axi_gmem_AWCACHE(0) <= \<const0>\;
  m_axi_gmem_AWID(0) <= \<const0>\;
  m_axi_gmem_AWLEN(7) <= \<const0>\;
  m_axi_gmem_AWLEN(6) <= \<const0>\;
  m_axi_gmem_AWLEN(5) <= \<const0>\;
  m_axi_gmem_AWLEN(4) <= \<const0>\;
  m_axi_gmem_AWLEN(3) <= \<const0>\;
  m_axi_gmem_AWLEN(2) <= \<const0>\;
  m_axi_gmem_AWLEN(1) <= \<const0>\;
  m_axi_gmem_AWLEN(0) <= \<const0>\;
  m_axi_gmem_AWLOCK(1) <= \<const0>\;
  m_axi_gmem_AWLOCK(0) <= \<const0>\;
  m_axi_gmem_AWPROT(2) <= \<const0>\;
  m_axi_gmem_AWPROT(1) <= \<const0>\;
  m_axi_gmem_AWPROT(0) <= \<const0>\;
  m_axi_gmem_AWQOS(3) <= \<const0>\;
  m_axi_gmem_AWQOS(2) <= \<const0>\;
  m_axi_gmem_AWQOS(1) <= \<const0>\;
  m_axi_gmem_AWQOS(0) <= \<const0>\;
  m_axi_gmem_AWREGION(3) <= \<const0>\;
  m_axi_gmem_AWREGION(2) <= \<const0>\;
  m_axi_gmem_AWREGION(1) <= \<const0>\;
  m_axi_gmem_AWREGION(0) <= \<const0>\;
  m_axi_gmem_AWSIZE(2) <= \<const0>\;
  m_axi_gmem_AWSIZE(1) <= \<const0>\;
  m_axi_gmem_AWSIZE(0) <= \<const0>\;
  m_axi_gmem_AWUSER(0) <= \<const0>\;
  m_axi_gmem_AWVALID <= \<const0>\;
  m_axi_gmem_BREADY <= \<const0>\;
  m_axi_gmem_WDATA(31) <= \<const0>\;
  m_axi_gmem_WDATA(30) <= \<const0>\;
  m_axi_gmem_WDATA(29) <= \<const0>\;
  m_axi_gmem_WDATA(28) <= \<const0>\;
  m_axi_gmem_WDATA(27) <= \<const0>\;
  m_axi_gmem_WDATA(26) <= \<const0>\;
  m_axi_gmem_WDATA(25) <= \<const0>\;
  m_axi_gmem_WDATA(24) <= \<const0>\;
  m_axi_gmem_WDATA(23) <= \<const0>\;
  m_axi_gmem_WDATA(22) <= \<const0>\;
  m_axi_gmem_WDATA(21) <= \<const0>\;
  m_axi_gmem_WDATA(20) <= \<const0>\;
  m_axi_gmem_WDATA(19) <= \<const0>\;
  m_axi_gmem_WDATA(18) <= \<const0>\;
  m_axi_gmem_WDATA(17) <= \<const0>\;
  m_axi_gmem_WDATA(16) <= \<const0>\;
  m_axi_gmem_WDATA(15) <= \<const0>\;
  m_axi_gmem_WDATA(14) <= \<const0>\;
  m_axi_gmem_WDATA(13) <= \<const0>\;
  m_axi_gmem_WDATA(12) <= \<const0>\;
  m_axi_gmem_WDATA(11) <= \<const0>\;
  m_axi_gmem_WDATA(10) <= \<const0>\;
  m_axi_gmem_WDATA(9) <= \<const0>\;
  m_axi_gmem_WDATA(8) <= \<const0>\;
  m_axi_gmem_WDATA(7) <= \<const0>\;
  m_axi_gmem_WDATA(6) <= \<const0>\;
  m_axi_gmem_WDATA(5) <= \<const0>\;
  m_axi_gmem_WDATA(4) <= \<const0>\;
  m_axi_gmem_WDATA(3) <= \<const0>\;
  m_axi_gmem_WDATA(2) <= \<const0>\;
  m_axi_gmem_WDATA(1) <= \<const0>\;
  m_axi_gmem_WDATA(0) <= \<const0>\;
  m_axi_gmem_WID(0) <= \<const0>\;
  m_axi_gmem_WLAST <= \<const0>\;
  m_axi_gmem_WSTRB(3) <= \<const0>\;
  m_axi_gmem_WSTRB(2) <= \<const0>\;
  m_axi_gmem_WSTRB(1) <= \<const0>\;
  m_axi_gmem_WSTRB(0) <= \<const0>\;
  m_axi_gmem_WUSER(0) <= \<const0>\;
  m_axi_gmem_WVALID <= \<const0>\;
  s_axi_control_BRESP(1) <= \<const0>\;
  s_axi_control_BRESP(0) <= \<const0>\;
  s_axi_control_RRESP(1) <= \<const0>\;
  s_axi_control_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\ap_CS_fsm_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_NS_fsm(0),
      Q => ap_CS_fsm_state1,
      S => ap_rst_n_inv
    );
\ap_CS_fsm_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_NS_fsm(1),
      Q => ap_CS_fsm_state2,
      R => ap_rst_n_inv
    );
\ap_CS_fsm_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_NS_fsm(2),
      Q => \ap_CS_fsm_reg_n_0_[2]\,
      R => ap_rst_n_inv
    );
\ap_CS_fsm_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \ap_CS_fsm_reg_n_0_[2]\,
      Q => \ap_CS_fsm_reg_n_0_[3]\,
      R => ap_rst_n_inv
    );
\ap_CS_fsm_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \ap_CS_fsm_reg_n_0_[3]\,
      Q => \ap_CS_fsm_reg_n_0_[4]\,
      R => ap_rst_n_inv
    );
\ap_CS_fsm_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \ap_CS_fsm_reg_n_0_[4]\,
      Q => \ap_CS_fsm_reg_n_0_[5]\,
      R => ap_rst_n_inv
    );
\ap_CS_fsm_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \ap_CS_fsm_reg_n_0_[5]\,
      Q => \ap_CS_fsm_reg_n_0_[6]\,
      R => ap_rst_n_inv
    );
\ap_CS_fsm_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \ap_CS_fsm_reg_n_0_[6]\,
      Q => \ap_CS_fsm_reg_n_0_[7]\,
      R => ap_rst_n_inv
    );
\ap_CS_fsm_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_NS_fsm(8),
      Q => ap_CS_fsm_state9,
      R => ap_rst_n_inv
    );
control_s_axi_U: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_control_s_axi
     port map (
      \FSM_onehot_rstate_reg[1]_0\ => s_axi_control_ARREADY,
      \FSM_onehot_wstate_reg[1]_0\ => s_axi_control_AWREADY,
      \FSM_onehot_wstate_reg[2]_0\ => s_axi_control_WREADY,
      O56(61 downto 0) => sext_ln324_fu_148_p1(61 downto 0),
      SR(0) => ap_rst_n_inv,
      ap_clk => ap_clk,
      count(31 downto 0) => count(31 downto 0),
      opeout(31 downto 0) => opeout(31 downto 0),
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
\gmem_addr_reg_158_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(0),
      Q => gmem_addr_reg_158(0),
      R => '0'
    );
\gmem_addr_reg_158_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(10),
      Q => gmem_addr_reg_158(10),
      R => '0'
    );
\gmem_addr_reg_158_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(11),
      Q => gmem_addr_reg_158(11),
      R => '0'
    );
\gmem_addr_reg_158_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(12),
      Q => gmem_addr_reg_158(12),
      R => '0'
    );
\gmem_addr_reg_158_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(13),
      Q => gmem_addr_reg_158(13),
      R => '0'
    );
\gmem_addr_reg_158_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(14),
      Q => gmem_addr_reg_158(14),
      R => '0'
    );
\gmem_addr_reg_158_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(15),
      Q => gmem_addr_reg_158(15),
      R => '0'
    );
\gmem_addr_reg_158_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(16),
      Q => gmem_addr_reg_158(16),
      R => '0'
    );
\gmem_addr_reg_158_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(17),
      Q => gmem_addr_reg_158(17),
      R => '0'
    );
\gmem_addr_reg_158_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(18),
      Q => gmem_addr_reg_158(18),
      R => '0'
    );
\gmem_addr_reg_158_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(19),
      Q => gmem_addr_reg_158(19),
      R => '0'
    );
\gmem_addr_reg_158_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(1),
      Q => gmem_addr_reg_158(1),
      R => '0'
    );
\gmem_addr_reg_158_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(20),
      Q => gmem_addr_reg_158(20),
      R => '0'
    );
\gmem_addr_reg_158_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(21),
      Q => gmem_addr_reg_158(21),
      R => '0'
    );
\gmem_addr_reg_158_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(22),
      Q => gmem_addr_reg_158(22),
      R => '0'
    );
\gmem_addr_reg_158_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(23),
      Q => gmem_addr_reg_158(23),
      R => '0'
    );
\gmem_addr_reg_158_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(24),
      Q => gmem_addr_reg_158(24),
      R => '0'
    );
\gmem_addr_reg_158_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(25),
      Q => gmem_addr_reg_158(25),
      R => '0'
    );
\gmem_addr_reg_158_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(26),
      Q => gmem_addr_reg_158(26),
      R => '0'
    );
\gmem_addr_reg_158_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(27),
      Q => gmem_addr_reg_158(27),
      R => '0'
    );
\gmem_addr_reg_158_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(28),
      Q => gmem_addr_reg_158(28),
      R => '0'
    );
\gmem_addr_reg_158_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(29),
      Q => gmem_addr_reg_158(29),
      R => '0'
    );
\gmem_addr_reg_158_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(2),
      Q => gmem_addr_reg_158(2),
      R => '0'
    );
\gmem_addr_reg_158_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(30),
      Q => gmem_addr_reg_158(30),
      R => '0'
    );
\gmem_addr_reg_158_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(31),
      Q => gmem_addr_reg_158(31),
      R => '0'
    );
\gmem_addr_reg_158_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(32),
      Q => gmem_addr_reg_158(32),
      R => '0'
    );
\gmem_addr_reg_158_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(33),
      Q => gmem_addr_reg_158(33),
      R => '0'
    );
\gmem_addr_reg_158_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(34),
      Q => gmem_addr_reg_158(34),
      R => '0'
    );
\gmem_addr_reg_158_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(35),
      Q => gmem_addr_reg_158(35),
      R => '0'
    );
\gmem_addr_reg_158_reg[36]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(36),
      Q => gmem_addr_reg_158(36),
      R => '0'
    );
\gmem_addr_reg_158_reg[37]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(37),
      Q => gmem_addr_reg_158(37),
      R => '0'
    );
\gmem_addr_reg_158_reg[38]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(38),
      Q => gmem_addr_reg_158(38),
      R => '0'
    );
\gmem_addr_reg_158_reg[39]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(39),
      Q => gmem_addr_reg_158(39),
      R => '0'
    );
\gmem_addr_reg_158_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(3),
      Q => gmem_addr_reg_158(3),
      R => '0'
    );
\gmem_addr_reg_158_reg[40]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(40),
      Q => gmem_addr_reg_158(40),
      R => '0'
    );
\gmem_addr_reg_158_reg[41]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(41),
      Q => gmem_addr_reg_158(41),
      R => '0'
    );
\gmem_addr_reg_158_reg[42]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(42),
      Q => gmem_addr_reg_158(42),
      R => '0'
    );
\gmem_addr_reg_158_reg[43]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(43),
      Q => gmem_addr_reg_158(43),
      R => '0'
    );
\gmem_addr_reg_158_reg[44]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(44),
      Q => gmem_addr_reg_158(44),
      R => '0'
    );
\gmem_addr_reg_158_reg[45]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(45),
      Q => gmem_addr_reg_158(45),
      R => '0'
    );
\gmem_addr_reg_158_reg[46]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(46),
      Q => gmem_addr_reg_158(46),
      R => '0'
    );
\gmem_addr_reg_158_reg[47]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(47),
      Q => gmem_addr_reg_158(47),
      R => '0'
    );
\gmem_addr_reg_158_reg[48]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(48),
      Q => gmem_addr_reg_158(48),
      R => '0'
    );
\gmem_addr_reg_158_reg[49]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(49),
      Q => gmem_addr_reg_158(49),
      R => '0'
    );
\gmem_addr_reg_158_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(4),
      Q => gmem_addr_reg_158(4),
      R => '0'
    );
\gmem_addr_reg_158_reg[50]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(50),
      Q => gmem_addr_reg_158(50),
      R => '0'
    );
\gmem_addr_reg_158_reg[51]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(51),
      Q => gmem_addr_reg_158(51),
      R => '0'
    );
\gmem_addr_reg_158_reg[52]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(52),
      Q => gmem_addr_reg_158(52),
      R => '0'
    );
\gmem_addr_reg_158_reg[53]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(53),
      Q => gmem_addr_reg_158(53),
      R => '0'
    );
\gmem_addr_reg_158_reg[54]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(54),
      Q => gmem_addr_reg_158(54),
      R => '0'
    );
\gmem_addr_reg_158_reg[55]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(55),
      Q => gmem_addr_reg_158(55),
      R => '0'
    );
\gmem_addr_reg_158_reg[56]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(56),
      Q => gmem_addr_reg_158(56),
      R => '0'
    );
\gmem_addr_reg_158_reg[57]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(57),
      Q => gmem_addr_reg_158(57),
      R => '0'
    );
\gmem_addr_reg_158_reg[58]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(58),
      Q => gmem_addr_reg_158(58),
      R => '0'
    );
\gmem_addr_reg_158_reg[59]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(59),
      Q => gmem_addr_reg_158(59),
      R => '0'
    );
\gmem_addr_reg_158_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(5),
      Q => gmem_addr_reg_158(5),
      R => '0'
    );
\gmem_addr_reg_158_reg[60]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(60),
      Q => gmem_addr_reg_158(60),
      R => '0'
    );
\gmem_addr_reg_158_reg[61]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(61),
      Q => gmem_addr_reg_158(61),
      R => '0'
    );
\gmem_addr_reg_158_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(6),
      Q => gmem_addr_reg_158(6),
      R => '0'
    );
\gmem_addr_reg_158_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(7),
      Q => gmem_addr_reg_158(7),
      R => '0'
    );
\gmem_addr_reg_158_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(8),
      Q => gmem_addr_reg_158(8),
      R => '0'
    );
\gmem_addr_reg_158_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => ap_CS_fsm_state1,
      D => sext_ln324_fu_148_p1(9),
      Q => gmem_addr_reg_158(9),
      R => '0'
    );
gmem_m_axi_U: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation_gmem_m_axi
     port map (
      D(32) => m_axi_gmem_RLAST,
      D(31 downto 0) => m_axi_gmem_RDATA(31 downto 0),
      Q(8) => ap_CS_fsm_state9,
      Q(7) => \ap_CS_fsm_reg_n_0_[7]\,
      Q(6) => \ap_CS_fsm_reg_n_0_[6]\,
      Q(5) => \ap_CS_fsm_reg_n_0_[5]\,
      Q(4) => \ap_CS_fsm_reg_n_0_[4]\,
      Q(3) => \ap_CS_fsm_reg_n_0_[3]\,
      Q(2) => \ap_CS_fsm_reg_n_0_[2]\,
      Q(1) => ap_CS_fsm_state2,
      Q(0) => ap_CS_fsm_state1,
      SR(0) => ap_rst_n_inv,
      ap_NS_fsm(3) => ap_NS_fsm(8),
      ap_NS_fsm(2 downto 0) => ap_NS_fsm(2 downto 0),
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      \could_multi_bursts.ARVALID_Dummy_reg\ => m_axi_gmem_ARVALID,
      \could_multi_bursts.arlen_buf_reg[4]\(4 downto 0) => \^m_axi_gmem_arlen\(4 downto 0),
      \data_p2_reg[61]\(61 downto 0) => gmem_addr_reg_158(61 downto 0),
      full_n_reg => m_axi_gmem_RREADY,
      m_axi_gmem_ARADDR(61 downto 0) => \^m_axi_gmem_araddr\(63 downto 2),
      m_axi_gmem_ARREADY => m_axi_gmem_ARREADY,
      m_axi_gmem_RRESP(1 downto 0) => m_axi_gmem_RRESP(1 downto 0),
      m_axi_gmem_RVALID => m_axi_gmem_RVALID,
      sdata(31 downto 0) => sdata(31 downto 0)
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
    m_axi_gmem_AWADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_gmem_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_gmem_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_AWLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_AWREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_AWVALID : out STD_LOGIC;
    m_axi_gmem_AWREADY : in STD_LOGIC;
    m_axi_gmem_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_gmem_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_WLAST : out STD_LOGIC;
    m_axi_gmem_WVALID : out STD_LOGIC;
    m_axi_gmem_WREADY : in STD_LOGIC;
    m_axi_gmem_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_BVALID : in STD_LOGIC;
    m_axi_gmem_BREADY : out STD_LOGIC;
    m_axi_gmem_ARADDR : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_gmem_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_gmem_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_ARLOCK : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_ARREGION : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_gmem_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_gmem_ARVALID : out STD_LOGIC;
    m_axi_gmem_ARREADY : in STD_LOGIC;
    m_axi_gmem_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_gmem_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_gmem_RLAST : in STD_LOGIC;
    m_axi_gmem_RVALID : in STD_LOGIC;
    m_axi_gmem_RREADY : out STD_LOGIC;
    sdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    opeout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    count : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_1_sound_operation_0_7,sound_operation,{}";
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
  signal \<const1>\ : STD_LOGIC;
  signal \^m_axi_gmem_araddr\ : STD_LOGIC_VECTOR ( 63 downto 2 );
  signal \^m_axi_gmem_arlen\ : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_inst_m_axi_gmem_AWVALID_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_gmem_BREADY_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_gmem_WLAST_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_gmem_WVALID_UNCONNECTED : STD_LOGIC;
  signal NLW_inst_m_axi_gmem_ARADDR_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_gmem_ARBURST_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_gmem_ARCACHE_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_gmem_ARID_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_gmem_ARLEN_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 5 );
  signal NLW_inst_m_axi_gmem_ARLOCK_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_gmem_ARPROT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_gmem_ARQOS_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_gmem_ARREGION_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_gmem_ARSIZE_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_gmem_ARUSER_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_gmem_AWADDR_UNCONNECTED : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal NLW_inst_m_axi_gmem_AWBURST_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_gmem_AWCACHE_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_gmem_AWID_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_gmem_AWLEN_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_inst_m_axi_gmem_AWLOCK_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_m_axi_gmem_AWPROT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_gmem_AWQOS_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_gmem_AWREGION_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_gmem_AWSIZE_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_inst_m_axi_gmem_AWUSER_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_gmem_WDATA_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_inst_m_axi_gmem_WID_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_m_axi_gmem_WSTRB_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_inst_m_axi_gmem_WUSER_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_inst_s_axi_control_BRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_s_axi_control_RRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_M_AXI_DATA_WIDTH : integer;
  attribute C_M_AXI_DATA_WIDTH of inst : label is 32;
  attribute C_M_AXI_GMEM_ADDR_WIDTH : integer;
  attribute C_M_AXI_GMEM_ADDR_WIDTH of inst : label is 64;
  attribute C_M_AXI_GMEM_ARUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_ARUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_GMEM_AWUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_AWUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_GMEM_BUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_BUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_GMEM_CACHE_VALUE : string;
  attribute C_M_AXI_GMEM_CACHE_VALUE of inst : label is "4'b0011";
  attribute C_M_AXI_GMEM_DATA_WIDTH : integer;
  attribute C_M_AXI_GMEM_DATA_WIDTH of inst : label is 32;
  attribute C_M_AXI_GMEM_ID_WIDTH : integer;
  attribute C_M_AXI_GMEM_ID_WIDTH of inst : label is 1;
  attribute C_M_AXI_GMEM_PROT_VALUE : string;
  attribute C_M_AXI_GMEM_PROT_VALUE of inst : label is "3'b000";
  attribute C_M_AXI_GMEM_RUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_RUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_GMEM_USER_VALUE : integer;
  attribute C_M_AXI_GMEM_USER_VALUE of inst : label is 0;
  attribute C_M_AXI_GMEM_WSTRB_WIDTH : integer;
  attribute C_M_AXI_GMEM_WSTRB_WIDTH of inst : label is 4;
  attribute C_M_AXI_GMEM_WUSER_WIDTH : integer;
  attribute C_M_AXI_GMEM_WUSER_WIDTH of inst : label is 1;
  attribute C_M_AXI_WSTRB_WIDTH : integer;
  attribute C_M_AXI_WSTRB_WIDTH of inst : label is 4;
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
  attribute ap_ST_fsm_state1 of inst : label is "9'b000000001";
  attribute ap_ST_fsm_state2 : string;
  attribute ap_ST_fsm_state2 of inst : label is "9'b000000010";
  attribute ap_ST_fsm_state3 : string;
  attribute ap_ST_fsm_state3 of inst : label is "9'b000000100";
  attribute ap_ST_fsm_state4 : string;
  attribute ap_ST_fsm_state4 of inst : label is "9'b000001000";
  attribute ap_ST_fsm_state5 : string;
  attribute ap_ST_fsm_state5 of inst : label is "9'b000010000";
  attribute ap_ST_fsm_state6 : string;
  attribute ap_ST_fsm_state6 of inst : label is "9'b000100000";
  attribute ap_ST_fsm_state7 : string;
  attribute ap_ST_fsm_state7 of inst : label is "9'b001000000";
  attribute ap_ST_fsm_state8 : string;
  attribute ap_ST_fsm_state8 of inst : label is "9'b010000000";
  attribute ap_ST_fsm_state9 : string;
  attribute ap_ST_fsm_state9 of inst : label is "9'b100000000";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ap_clk : signal is "xilinx.com:signal:clock:1.0 ap_clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ap_clk : signal is "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control:m_axi_gmem, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of ap_rst_n : signal is "xilinx.com:signal:reset:1.0 ap_rst_n RST";
  attribute X_INTERFACE_PARAMETER of ap_rst_n : signal is "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARREADY";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARVALID";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWREADY";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWVALID";
  attribute X_INTERFACE_INFO of m_axi_gmem_BREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem BREADY";
  attribute X_INTERFACE_INFO of m_axi_gmem_BVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem BVALID";
  attribute X_INTERFACE_INFO of m_axi_gmem_RLAST : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem RLAST";
  attribute X_INTERFACE_INFO of m_axi_gmem_RREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem RREADY";
  attribute X_INTERFACE_PARAMETER of m_axi_gmem_RREADY : signal is "XIL_INTERFACENAME m_axi_gmem, ADDR_WIDTH 64, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 16, NUM_WRITE_OUTSTANDING 16, MAX_READ_BURST_LENGTH 32, MAX_WRITE_BURST_LENGTH 16, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axi_gmem_RVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem RVALID";
  attribute X_INTERFACE_INFO of m_axi_gmem_WLAST : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem WLAST";
  attribute X_INTERFACE_INFO of m_axi_gmem_WREADY : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem WREADY";
  attribute X_INTERFACE_INFO of m_axi_gmem_WVALID : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem WVALID";
  attribute X_INTERFACE_INFO of s_axi_control_ARREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY";
  attribute X_INTERFACE_INFO of s_axi_control_ARVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID";
  attribute X_INTERFACE_INFO of s_axi_control_AWREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY";
  attribute X_INTERFACE_INFO of s_axi_control_AWVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID";
  attribute X_INTERFACE_INFO of s_axi_control_BREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BREADY";
  attribute X_INTERFACE_INFO of s_axi_control_BVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BVALID";
  attribute X_INTERFACE_INFO of s_axi_control_RREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RREADY";
  attribute X_INTERFACE_PARAMETER of s_axi_control_RREADY : signal is "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_control_RVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RVALID";
  attribute X_INTERFACE_INFO of s_axi_control_WREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WREADY";
  attribute X_INTERFACE_INFO of s_axi_control_WVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WVALID";
  attribute X_INTERFACE_INFO of count : signal is "xilinx.com:signal:data:1.0 count DATA";
  attribute X_INTERFACE_PARAMETER of count : signal is "XIL_INTERFACENAME count, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARADDR : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARADDR";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARBURST : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARBURST";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARCACHE : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARCACHE";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARLEN : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARLEN";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARLOCK : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARLOCK";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARPROT : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARPROT";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARQOS : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARQOS";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARREGION : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARREGION";
  attribute X_INTERFACE_INFO of m_axi_gmem_ARSIZE : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem ARSIZE";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWADDR : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWADDR";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWBURST : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWBURST";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWCACHE : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWCACHE";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWLEN : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWLEN";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWLOCK : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWLOCK";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWPROT : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWPROT";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWQOS : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWQOS";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWREGION : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWREGION";
  attribute X_INTERFACE_INFO of m_axi_gmem_AWSIZE : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem AWSIZE";
  attribute X_INTERFACE_INFO of m_axi_gmem_BRESP : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem BRESP";
  attribute X_INTERFACE_INFO of m_axi_gmem_RDATA : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem RDATA";
  attribute X_INTERFACE_INFO of m_axi_gmem_RRESP : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem RRESP";
  attribute X_INTERFACE_INFO of m_axi_gmem_WDATA : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem WDATA";
  attribute X_INTERFACE_INFO of m_axi_gmem_WSTRB : signal is "xilinx.com:interface:aximm:1.0 m_axi_gmem WSTRB";
  attribute X_INTERFACE_INFO of opeout : signal is "xilinx.com:signal:data:1.0 opeout DATA";
  attribute X_INTERFACE_PARAMETER of opeout : signal is "XIL_INTERFACENAME opeout, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of s_axi_control_ARADDR : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR";
  attribute X_INTERFACE_INFO of s_axi_control_AWADDR : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR";
  attribute X_INTERFACE_INFO of s_axi_control_BRESP : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BRESP";
  attribute X_INTERFACE_INFO of s_axi_control_RDATA : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RDATA";
  attribute X_INTERFACE_INFO of s_axi_control_RRESP : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RRESP";
  attribute X_INTERFACE_INFO of s_axi_control_WDATA : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WDATA";
  attribute X_INTERFACE_INFO of s_axi_control_WSTRB : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB";
  attribute X_INTERFACE_INFO of sdata : signal is "xilinx.com:signal:data:1.0 sdata DATA";
  attribute X_INTERFACE_PARAMETER of sdata : signal is "XIL_INTERFACENAME sdata, LAYERED_METADATA undef";
begin
  m_axi_gmem_ARADDR(63 downto 2) <= \^m_axi_gmem_araddr\(63 downto 2);
  m_axi_gmem_ARADDR(1) <= \<const0>\;
  m_axi_gmem_ARADDR(0) <= \<const0>\;
  m_axi_gmem_ARBURST(1) <= \<const0>\;
  m_axi_gmem_ARBURST(0) <= \<const1>\;
  m_axi_gmem_ARCACHE(3) <= \<const0>\;
  m_axi_gmem_ARCACHE(2) <= \<const0>\;
  m_axi_gmem_ARCACHE(1) <= \<const1>\;
  m_axi_gmem_ARCACHE(0) <= \<const1>\;
  m_axi_gmem_ARLEN(7) <= \<const0>\;
  m_axi_gmem_ARLEN(6) <= \<const0>\;
  m_axi_gmem_ARLEN(5) <= \<const0>\;
  m_axi_gmem_ARLEN(4 downto 0) <= \^m_axi_gmem_arlen\(4 downto 0);
  m_axi_gmem_ARLOCK(1) <= \<const0>\;
  m_axi_gmem_ARLOCK(0) <= \<const0>\;
  m_axi_gmem_ARPROT(2) <= \<const0>\;
  m_axi_gmem_ARPROT(1) <= \<const0>\;
  m_axi_gmem_ARPROT(0) <= \<const0>\;
  m_axi_gmem_ARQOS(3) <= \<const0>\;
  m_axi_gmem_ARQOS(2) <= \<const0>\;
  m_axi_gmem_ARQOS(1) <= \<const0>\;
  m_axi_gmem_ARQOS(0) <= \<const0>\;
  m_axi_gmem_ARREGION(3) <= \<const0>\;
  m_axi_gmem_ARREGION(2) <= \<const0>\;
  m_axi_gmem_ARREGION(1) <= \<const0>\;
  m_axi_gmem_ARREGION(0) <= \<const0>\;
  m_axi_gmem_ARSIZE(2) <= \<const0>\;
  m_axi_gmem_ARSIZE(1) <= \<const1>\;
  m_axi_gmem_ARSIZE(0) <= \<const0>\;
  m_axi_gmem_AWADDR(63) <= \<const0>\;
  m_axi_gmem_AWADDR(62) <= \<const0>\;
  m_axi_gmem_AWADDR(61) <= \<const0>\;
  m_axi_gmem_AWADDR(60) <= \<const0>\;
  m_axi_gmem_AWADDR(59) <= \<const0>\;
  m_axi_gmem_AWADDR(58) <= \<const0>\;
  m_axi_gmem_AWADDR(57) <= \<const0>\;
  m_axi_gmem_AWADDR(56) <= \<const0>\;
  m_axi_gmem_AWADDR(55) <= \<const0>\;
  m_axi_gmem_AWADDR(54) <= \<const0>\;
  m_axi_gmem_AWADDR(53) <= \<const0>\;
  m_axi_gmem_AWADDR(52) <= \<const0>\;
  m_axi_gmem_AWADDR(51) <= \<const0>\;
  m_axi_gmem_AWADDR(50) <= \<const0>\;
  m_axi_gmem_AWADDR(49) <= \<const0>\;
  m_axi_gmem_AWADDR(48) <= \<const0>\;
  m_axi_gmem_AWADDR(47) <= \<const0>\;
  m_axi_gmem_AWADDR(46) <= \<const0>\;
  m_axi_gmem_AWADDR(45) <= \<const0>\;
  m_axi_gmem_AWADDR(44) <= \<const0>\;
  m_axi_gmem_AWADDR(43) <= \<const0>\;
  m_axi_gmem_AWADDR(42) <= \<const0>\;
  m_axi_gmem_AWADDR(41) <= \<const0>\;
  m_axi_gmem_AWADDR(40) <= \<const0>\;
  m_axi_gmem_AWADDR(39) <= \<const0>\;
  m_axi_gmem_AWADDR(38) <= \<const0>\;
  m_axi_gmem_AWADDR(37) <= \<const0>\;
  m_axi_gmem_AWADDR(36) <= \<const0>\;
  m_axi_gmem_AWADDR(35) <= \<const0>\;
  m_axi_gmem_AWADDR(34) <= \<const0>\;
  m_axi_gmem_AWADDR(33) <= \<const0>\;
  m_axi_gmem_AWADDR(32) <= \<const0>\;
  m_axi_gmem_AWADDR(31) <= \<const0>\;
  m_axi_gmem_AWADDR(30) <= \<const0>\;
  m_axi_gmem_AWADDR(29) <= \<const0>\;
  m_axi_gmem_AWADDR(28) <= \<const0>\;
  m_axi_gmem_AWADDR(27) <= \<const0>\;
  m_axi_gmem_AWADDR(26) <= \<const0>\;
  m_axi_gmem_AWADDR(25) <= \<const0>\;
  m_axi_gmem_AWADDR(24) <= \<const0>\;
  m_axi_gmem_AWADDR(23) <= \<const0>\;
  m_axi_gmem_AWADDR(22) <= \<const0>\;
  m_axi_gmem_AWADDR(21) <= \<const0>\;
  m_axi_gmem_AWADDR(20) <= \<const0>\;
  m_axi_gmem_AWADDR(19) <= \<const0>\;
  m_axi_gmem_AWADDR(18) <= \<const0>\;
  m_axi_gmem_AWADDR(17) <= \<const0>\;
  m_axi_gmem_AWADDR(16) <= \<const0>\;
  m_axi_gmem_AWADDR(15) <= \<const0>\;
  m_axi_gmem_AWADDR(14) <= \<const0>\;
  m_axi_gmem_AWADDR(13) <= \<const0>\;
  m_axi_gmem_AWADDR(12) <= \<const0>\;
  m_axi_gmem_AWADDR(11) <= \<const0>\;
  m_axi_gmem_AWADDR(10) <= \<const0>\;
  m_axi_gmem_AWADDR(9) <= \<const0>\;
  m_axi_gmem_AWADDR(8) <= \<const0>\;
  m_axi_gmem_AWADDR(7) <= \<const0>\;
  m_axi_gmem_AWADDR(6) <= \<const0>\;
  m_axi_gmem_AWADDR(5) <= \<const0>\;
  m_axi_gmem_AWADDR(4) <= \<const0>\;
  m_axi_gmem_AWADDR(3) <= \<const0>\;
  m_axi_gmem_AWADDR(2) <= \<const0>\;
  m_axi_gmem_AWADDR(1) <= \<const0>\;
  m_axi_gmem_AWADDR(0) <= \<const0>\;
  m_axi_gmem_AWBURST(1) <= \<const0>\;
  m_axi_gmem_AWBURST(0) <= \<const1>\;
  m_axi_gmem_AWCACHE(3) <= \<const0>\;
  m_axi_gmem_AWCACHE(2) <= \<const0>\;
  m_axi_gmem_AWCACHE(1) <= \<const1>\;
  m_axi_gmem_AWCACHE(0) <= \<const1>\;
  m_axi_gmem_AWLEN(7) <= \<const0>\;
  m_axi_gmem_AWLEN(6) <= \<const0>\;
  m_axi_gmem_AWLEN(5) <= \<const0>\;
  m_axi_gmem_AWLEN(4) <= \<const0>\;
  m_axi_gmem_AWLEN(3) <= \<const0>\;
  m_axi_gmem_AWLEN(2) <= \<const0>\;
  m_axi_gmem_AWLEN(1) <= \<const0>\;
  m_axi_gmem_AWLEN(0) <= \<const0>\;
  m_axi_gmem_AWLOCK(1) <= \<const0>\;
  m_axi_gmem_AWLOCK(0) <= \<const0>\;
  m_axi_gmem_AWPROT(2) <= \<const0>\;
  m_axi_gmem_AWPROT(1) <= \<const0>\;
  m_axi_gmem_AWPROT(0) <= \<const0>\;
  m_axi_gmem_AWQOS(3) <= \<const0>\;
  m_axi_gmem_AWQOS(2) <= \<const0>\;
  m_axi_gmem_AWQOS(1) <= \<const0>\;
  m_axi_gmem_AWQOS(0) <= \<const0>\;
  m_axi_gmem_AWREGION(3) <= \<const0>\;
  m_axi_gmem_AWREGION(2) <= \<const0>\;
  m_axi_gmem_AWREGION(1) <= \<const0>\;
  m_axi_gmem_AWREGION(0) <= \<const0>\;
  m_axi_gmem_AWSIZE(2) <= \<const0>\;
  m_axi_gmem_AWSIZE(1) <= \<const1>\;
  m_axi_gmem_AWSIZE(0) <= \<const0>\;
  m_axi_gmem_AWVALID <= \<const0>\;
  m_axi_gmem_BREADY <= \<const1>\;
  m_axi_gmem_WDATA(31) <= \<const0>\;
  m_axi_gmem_WDATA(30) <= \<const0>\;
  m_axi_gmem_WDATA(29) <= \<const0>\;
  m_axi_gmem_WDATA(28) <= \<const0>\;
  m_axi_gmem_WDATA(27) <= \<const0>\;
  m_axi_gmem_WDATA(26) <= \<const0>\;
  m_axi_gmem_WDATA(25) <= \<const0>\;
  m_axi_gmem_WDATA(24) <= \<const0>\;
  m_axi_gmem_WDATA(23) <= \<const0>\;
  m_axi_gmem_WDATA(22) <= \<const0>\;
  m_axi_gmem_WDATA(21) <= \<const0>\;
  m_axi_gmem_WDATA(20) <= \<const0>\;
  m_axi_gmem_WDATA(19) <= \<const0>\;
  m_axi_gmem_WDATA(18) <= \<const0>\;
  m_axi_gmem_WDATA(17) <= \<const0>\;
  m_axi_gmem_WDATA(16) <= \<const0>\;
  m_axi_gmem_WDATA(15) <= \<const0>\;
  m_axi_gmem_WDATA(14) <= \<const0>\;
  m_axi_gmem_WDATA(13) <= \<const0>\;
  m_axi_gmem_WDATA(12) <= \<const0>\;
  m_axi_gmem_WDATA(11) <= \<const0>\;
  m_axi_gmem_WDATA(10) <= \<const0>\;
  m_axi_gmem_WDATA(9) <= \<const0>\;
  m_axi_gmem_WDATA(8) <= \<const0>\;
  m_axi_gmem_WDATA(7) <= \<const0>\;
  m_axi_gmem_WDATA(6) <= \<const0>\;
  m_axi_gmem_WDATA(5) <= \<const0>\;
  m_axi_gmem_WDATA(4) <= \<const0>\;
  m_axi_gmem_WDATA(3) <= \<const0>\;
  m_axi_gmem_WDATA(2) <= \<const0>\;
  m_axi_gmem_WDATA(1) <= \<const0>\;
  m_axi_gmem_WDATA(0) <= \<const0>\;
  m_axi_gmem_WLAST <= \<const0>\;
  m_axi_gmem_WSTRB(3) <= \<const0>\;
  m_axi_gmem_WSTRB(2) <= \<const0>\;
  m_axi_gmem_WSTRB(1) <= \<const0>\;
  m_axi_gmem_WSTRB(0) <= \<const0>\;
  m_axi_gmem_WVALID <= \<const0>\;
  s_axi_control_BRESP(1) <= \<const0>\;
  s_axi_control_BRESP(0) <= \<const0>\;
  s_axi_control_RRESP(1) <= \<const0>\;
  s_axi_control_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_sound_operation
     port map (
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      count(31 downto 0) => count(31 downto 0),
      m_axi_gmem_ARADDR(63 downto 2) => \^m_axi_gmem_araddr\(63 downto 2),
      m_axi_gmem_ARADDR(1 downto 0) => NLW_inst_m_axi_gmem_ARADDR_UNCONNECTED(1 downto 0),
      m_axi_gmem_ARBURST(1 downto 0) => NLW_inst_m_axi_gmem_ARBURST_UNCONNECTED(1 downto 0),
      m_axi_gmem_ARCACHE(3 downto 0) => NLW_inst_m_axi_gmem_ARCACHE_UNCONNECTED(3 downto 0),
      m_axi_gmem_ARID(0) => NLW_inst_m_axi_gmem_ARID_UNCONNECTED(0),
      m_axi_gmem_ARLEN(7 downto 5) => NLW_inst_m_axi_gmem_ARLEN_UNCONNECTED(7 downto 5),
      m_axi_gmem_ARLEN(4 downto 0) => \^m_axi_gmem_arlen\(4 downto 0),
      m_axi_gmem_ARLOCK(1 downto 0) => NLW_inst_m_axi_gmem_ARLOCK_UNCONNECTED(1 downto 0),
      m_axi_gmem_ARPROT(2 downto 0) => NLW_inst_m_axi_gmem_ARPROT_UNCONNECTED(2 downto 0),
      m_axi_gmem_ARQOS(3 downto 0) => NLW_inst_m_axi_gmem_ARQOS_UNCONNECTED(3 downto 0),
      m_axi_gmem_ARREADY => m_axi_gmem_ARREADY,
      m_axi_gmem_ARREGION(3 downto 0) => NLW_inst_m_axi_gmem_ARREGION_UNCONNECTED(3 downto 0),
      m_axi_gmem_ARSIZE(2 downto 0) => NLW_inst_m_axi_gmem_ARSIZE_UNCONNECTED(2 downto 0),
      m_axi_gmem_ARUSER(0) => NLW_inst_m_axi_gmem_ARUSER_UNCONNECTED(0),
      m_axi_gmem_ARVALID => m_axi_gmem_ARVALID,
      m_axi_gmem_AWADDR(63 downto 0) => NLW_inst_m_axi_gmem_AWADDR_UNCONNECTED(63 downto 0),
      m_axi_gmem_AWBURST(1 downto 0) => NLW_inst_m_axi_gmem_AWBURST_UNCONNECTED(1 downto 0),
      m_axi_gmem_AWCACHE(3 downto 0) => NLW_inst_m_axi_gmem_AWCACHE_UNCONNECTED(3 downto 0),
      m_axi_gmem_AWID(0) => NLW_inst_m_axi_gmem_AWID_UNCONNECTED(0),
      m_axi_gmem_AWLEN(7 downto 0) => NLW_inst_m_axi_gmem_AWLEN_UNCONNECTED(7 downto 0),
      m_axi_gmem_AWLOCK(1 downto 0) => NLW_inst_m_axi_gmem_AWLOCK_UNCONNECTED(1 downto 0),
      m_axi_gmem_AWPROT(2 downto 0) => NLW_inst_m_axi_gmem_AWPROT_UNCONNECTED(2 downto 0),
      m_axi_gmem_AWQOS(3 downto 0) => NLW_inst_m_axi_gmem_AWQOS_UNCONNECTED(3 downto 0),
      m_axi_gmem_AWREADY => '0',
      m_axi_gmem_AWREGION(3 downto 0) => NLW_inst_m_axi_gmem_AWREGION_UNCONNECTED(3 downto 0),
      m_axi_gmem_AWSIZE(2 downto 0) => NLW_inst_m_axi_gmem_AWSIZE_UNCONNECTED(2 downto 0),
      m_axi_gmem_AWUSER(0) => NLW_inst_m_axi_gmem_AWUSER_UNCONNECTED(0),
      m_axi_gmem_AWVALID => NLW_inst_m_axi_gmem_AWVALID_UNCONNECTED,
      m_axi_gmem_BID(0) => '0',
      m_axi_gmem_BREADY => NLW_inst_m_axi_gmem_BREADY_UNCONNECTED,
      m_axi_gmem_BRESP(1 downto 0) => B"00",
      m_axi_gmem_BUSER(0) => '0',
      m_axi_gmem_BVALID => '0',
      m_axi_gmem_RDATA(31 downto 0) => m_axi_gmem_RDATA(31 downto 0),
      m_axi_gmem_RID(0) => '0',
      m_axi_gmem_RLAST => m_axi_gmem_RLAST,
      m_axi_gmem_RREADY => m_axi_gmem_RREADY,
      m_axi_gmem_RRESP(1 downto 0) => m_axi_gmem_RRESP(1 downto 0),
      m_axi_gmem_RUSER(0) => '0',
      m_axi_gmem_RVALID => m_axi_gmem_RVALID,
      m_axi_gmem_WDATA(31 downto 0) => NLW_inst_m_axi_gmem_WDATA_UNCONNECTED(31 downto 0),
      m_axi_gmem_WID(0) => NLW_inst_m_axi_gmem_WID_UNCONNECTED(0),
      m_axi_gmem_WLAST => NLW_inst_m_axi_gmem_WLAST_UNCONNECTED,
      m_axi_gmem_WREADY => '0',
      m_axi_gmem_WSTRB(3 downto 0) => NLW_inst_m_axi_gmem_WSTRB_UNCONNECTED(3 downto 0),
      m_axi_gmem_WUSER(0) => NLW_inst_m_axi_gmem_WUSER_UNCONNECTED(0),
      m_axi_gmem_WVALID => NLW_inst_m_axi_gmem_WVALID_UNCONNECTED,
      opeout(31 downto 0) => opeout(31 downto 0),
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
      sdata(31 downto 0) => sdata(31 downto 0)
    );
end STRUCTURE;
