-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Tue May 11 08:25:35 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_MAIN_0_0_sim_netlist.vhdl
-- Design      : design_1_MAIN_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_MAIN is
  port (
    LRCLK_OUT : out STD_LOGIC;
    BCLK_reg_0 : out STD_LOGIC;
    AUDIO_DATA_OUT : out STD_LOGIC;
    COUNT_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MCLK_IN_IBUF : in STD_LOGIC;
    GP_OPERATION : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SOUND_IN : in STD_LOGIC_VECTOR ( 0 to 0 );
    RESET : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_MAIN;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_MAIN is
  signal BCLK_i_1_n_0 : STD_LOGIC;
  signal BCLK_i_2_n_0 : STD_LOGIC;
  signal \^bclk_reg_0\ : STD_LOGIC;
  signal \^count_out\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^lrclk_out\ : STD_LOGIC;
  signal LRCLK_i_1_n_0 : STD_LOGIC;
  signal SDATA_i_10_n_0 : STD_LOGIC;
  signal SDATA_i_1_n_0 : STD_LOGIC;
  signal SDATA_i_2_n_0 : STD_LOGIC;
  signal SDATA_i_3_n_0 : STD_LOGIC;
  signal SDATA_i_4_n_0 : STD_LOGIC;
  signal SDATA_i_5_n_0 : STD_LOGIC;
  signal SDATA_i_6_n_0 : STD_LOGIC;
  signal SDATA_i_7_n_0 : STD_LOGIC;
  signal SDATA_i_8_n_0 : STD_LOGIC;
  signal SDATA_i_9_n_0 : STD_LOGIC;
  signal bclk_cnt : STD_LOGIC_VECTOR ( 4 downto 1 );
  signal bclk_cnt_0 : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal \bclk_cnt_reg_n_0_[0]\ : STD_LOGIC;
  signal mclk_cnt : STD_LOGIC;
  signal mclk_cnt_i_1_n_0 : STD_LOGIC;
  signal \rp[0]_i_1_n_0\ : STD_LOGIC;
  signal \rp[10]_i_1_n_0\ : STD_LOGIC;
  signal \rp[11]_i_1_n_0\ : STD_LOGIC;
  signal \rp[12]_i_1_n_0\ : STD_LOGIC;
  signal \rp[13]_i_1_n_0\ : STD_LOGIC;
  signal \rp[14]_i_1_n_0\ : STD_LOGIC;
  signal \rp[15]_i_1_n_0\ : STD_LOGIC;
  signal \rp[16]_i_1_n_0\ : STD_LOGIC;
  signal \rp[17]_i_1_n_0\ : STD_LOGIC;
  signal \rp[18]_i_1_n_0\ : STD_LOGIC;
  signal \rp[19]_i_1_n_0\ : STD_LOGIC;
  signal \rp[1]_i_1_n_0\ : STD_LOGIC;
  signal \rp[20]_i_1_n_0\ : STD_LOGIC;
  signal \rp[21]_i_1_n_0\ : STD_LOGIC;
  signal \rp[22]_i_1_n_0\ : STD_LOGIC;
  signal \rp[23]_i_1_n_0\ : STD_LOGIC;
  signal \rp[24]_i_1_n_0\ : STD_LOGIC;
  signal \rp[25]_i_1_n_0\ : STD_LOGIC;
  signal \rp[26]_i_1_n_0\ : STD_LOGIC;
  signal \rp[27]_i_1_n_0\ : STD_LOGIC;
  signal \rp[28]_i_1_n_0\ : STD_LOGIC;
  signal \rp[29]_i_1_n_0\ : STD_LOGIC;
  signal \rp[2]_i_1_n_0\ : STD_LOGIC;
  signal \rp[30]_i_1_n_0\ : STD_LOGIC;
  signal \rp[31]_i_1_n_0\ : STD_LOGIC;
  signal \rp[31]_i_2_n_0\ : STD_LOGIC;
  signal \rp[31]_i_3_n_0\ : STD_LOGIC;
  signal \rp[3]_i_1_n_0\ : STD_LOGIC;
  signal \rp[4]_i_1_n_0\ : STD_LOGIC;
  signal \rp[5]_i_1_n_0\ : STD_LOGIC;
  signal \rp[6]_i_1_n_0\ : STD_LOGIC;
  signal \rp[7]_i_1_n_0\ : STD_LOGIC;
  signal \rp[8]_i_1_n_0\ : STD_LOGIC;
  signal \rp[9]_i_1_n_0\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_4\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_5\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_6\ : STD_LOGIC;
  signal \rp_reg[12]_i_2_n_7\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_4\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_5\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_6\ : STD_LOGIC;
  signal \rp_reg[16]_i_2_n_7\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_0\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_1\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_2\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_3\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_4\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_5\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_6\ : STD_LOGIC;
  signal \rp_reg[20]_i_2_n_7\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_0\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_1\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_2\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_3\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_4\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_5\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_6\ : STD_LOGIC;
  signal \rp_reg[24]_i_2_n_7\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_0\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_1\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_2\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_3\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_4\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_5\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_6\ : STD_LOGIC;
  signal \rp_reg[28]_i_2_n_7\ : STD_LOGIC;
  signal \rp_reg[31]_i_4_n_2\ : STD_LOGIC;
  signal \rp_reg[31]_i_4_n_3\ : STD_LOGIC;
  signal \rp_reg[31]_i_4_n_5\ : STD_LOGIC;
  signal \rp_reg[31]_i_4_n_6\ : STD_LOGIC;
  signal \rp_reg[31]_i_4_n_7\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_4\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_5\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_6\ : STD_LOGIC;
  signal \rp_reg[4]_i_2_n_7\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_4\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_5\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_6\ : STD_LOGIC;
  signal \rp_reg[8]_i_2_n_7\ : STD_LOGIC;
  signal \NLW_rp_reg[31]_i_4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_rp_reg[31]_i_4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of BCLK_i_1 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \bclk_cnt[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \bclk_cnt[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \bclk_cnt[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \bclk_cnt[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \bclk_cnt[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of mclk_cnt_i_1 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rp[31]_i_3\ : label is "soft_lutpair0";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \rp_reg[12]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \rp_reg[16]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \rp_reg[20]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \rp_reg[24]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \rp_reg[28]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \rp_reg[31]_i_4\ : label is 35;
  attribute ADDER_THRESHOLD of \rp_reg[4]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \rp_reg[8]_i_2\ : label is 35;
begin
  BCLK_reg_0 <= \^bclk_reg_0\;
  COUNT_OUT(31 downto 0) <= \^count_out\(31 downto 0);
  LRCLK_OUT <= \^lrclk_out\;
BCLK_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mclk_cnt,
      I1 => \^bclk_reg_0\,
      O => BCLK_i_1_n_0
    );
BCLK_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => RESET,
      O => BCLK_i_2_n_0
    );
BCLK_reg: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => MCLK_IN_IBUF,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => BCLK_i_1_n_0,
      Q => \^bclk_reg_0\
    );
LRCLK_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => bclk_cnt(4),
      I1 => bclk_cnt(2),
      I2 => \bclk_cnt_reg_n_0_[0]\,
      I3 => bclk_cnt(1),
      I4 => bclk_cnt(3),
      I5 => \^lrclk_out\,
      O => LRCLK_i_1_n_0
    );
LRCLK_reg: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => LRCLK_i_1_n_0,
      Q => \^lrclk_out\
    );
SDATA_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => SDATA_i_2_n_0,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => SDATA_i_1_n_0
    );
SDATA_i_10: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => GP_OPERATION(13),
      I1 => GP_OPERATION(12),
      I2 => GP_OPERATION(15),
      I3 => GP_OPERATION(14),
      O => SDATA_i_10_n_0
    );
SDATA_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D555555500000000"
    )
        port map (
      I0 => \bclk_cnt_reg_n_0_[0]\,
      I1 => bclk_cnt(1),
      I2 => bclk_cnt(2),
      I3 => bclk_cnt(3),
      I4 => bclk_cnt(4),
      I5 => SOUND_IN(0),
      O => SDATA_i_2_n_0
    );
SDATA_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => GP_OPERATION(18),
      I1 => GP_OPERATION(19),
      I2 => GP_OPERATION(16),
      I3 => GP_OPERATION(17),
      I4 => SDATA_i_7_n_0,
      O => SDATA_i_3_n_0
    );
SDATA_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => GP_OPERATION(26),
      I1 => GP_OPERATION(27),
      I2 => GP_OPERATION(24),
      I3 => GP_OPERATION(25),
      I4 => SDATA_i_8_n_0,
      O => SDATA_i_4_n_0
    );
SDATA_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => GP_OPERATION(2),
      I1 => GP_OPERATION(3),
      I2 => GP_OPERATION(0),
      I3 => GP_OPERATION(1),
      I4 => SDATA_i_9_n_0,
      O => SDATA_i_5_n_0
    );
SDATA_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => GP_OPERATION(10),
      I1 => GP_OPERATION(11),
      I2 => GP_OPERATION(8),
      I3 => GP_OPERATION(9),
      I4 => SDATA_i_10_n_0,
      O => SDATA_i_6_n_0
    );
SDATA_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => GP_OPERATION(21),
      I1 => GP_OPERATION(20),
      I2 => GP_OPERATION(23),
      I3 => GP_OPERATION(22),
      O => SDATA_i_7_n_0
    );
SDATA_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => GP_OPERATION(29),
      I1 => GP_OPERATION(28),
      I2 => GP_OPERATION(31),
      I3 => GP_OPERATION(30),
      O => SDATA_i_8_n_0
    );
SDATA_i_9: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => GP_OPERATION(4),
      I1 => GP_OPERATION(5),
      I2 => GP_OPERATION(7),
      I3 => GP_OPERATION(6),
      O => SDATA_i_9_n_0
    );
SDATA_reg: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => SDATA_i_1_n_0,
      Q => AUDIO_DATA_OUT
    );
\bclk_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \bclk_cnt_reg_n_0_[0]\,
      O => bclk_cnt_0(0)
    );
\bclk_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => bclk_cnt(1),
      I1 => \bclk_cnt_reg_n_0_[0]\,
      O => bclk_cnt_0(1)
    );
\bclk_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => bclk_cnt(1),
      I1 => \bclk_cnt_reg_n_0_[0]\,
      I2 => bclk_cnt(2),
      O => bclk_cnt_0(2)
    );
\bclk_cnt[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => bclk_cnt(2),
      I1 => \bclk_cnt_reg_n_0_[0]\,
      I2 => bclk_cnt(1),
      I3 => bclk_cnt(3),
      O => bclk_cnt_0(3)
    );
\bclk_cnt[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => bclk_cnt(3),
      I1 => bclk_cnt(1),
      I2 => \bclk_cnt_reg_n_0_[0]\,
      I3 => bclk_cnt(2),
      I4 => bclk_cnt(4),
      O => bclk_cnt_0(4)
    );
\bclk_cnt_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => bclk_cnt_0(0),
      Q => \bclk_cnt_reg_n_0_[0]\
    );
\bclk_cnt_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => bclk_cnt_0(1),
      Q => bclk_cnt(1)
    );
\bclk_cnt_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => bclk_cnt_0(2),
      Q => bclk_cnt(2)
    );
\bclk_cnt_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => bclk_cnt_0(3),
      Q => bclk_cnt(3)
    );
\bclk_cnt_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => bclk_cnt_0(4),
      Q => bclk_cnt(4)
    );
mclk_cnt_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => mclk_cnt,
      O => mclk_cnt_i_1_n_0
    );
mclk_cnt_reg: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => MCLK_IN_IBUF,
      CE => '1',
      CLR => BCLK_i_2_n_0,
      D => mclk_cnt_i_1_n_0,
      Q => mclk_cnt
    );
\rp[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => SDATA_i_3_n_0,
      I1 => SDATA_i_4_n_0,
      I2 => SDATA_i_5_n_0,
      I3 => SDATA_i_6_n_0,
      I4 => \^count_out\(0),
      O => \rp[0]_i_1_n_0\
    );
\rp[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[12]_i_2_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[10]_i_1_n_0\
    );
\rp[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[12]_i_2_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[11]_i_1_n_0\
    );
\rp[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[12]_i_2_n_4\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[12]_i_1_n_0\
    );
\rp[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[16]_i_2_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[13]_i_1_n_0\
    );
\rp[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[16]_i_2_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[14]_i_1_n_0\
    );
\rp[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[16]_i_2_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[15]_i_1_n_0\
    );
\rp[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[16]_i_2_n_4\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[16]_i_1_n_0\
    );
\rp[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[20]_i_2_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[17]_i_1_n_0\
    );
\rp[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[20]_i_2_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[18]_i_1_n_0\
    );
\rp[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[20]_i_2_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[19]_i_1_n_0\
    );
\rp[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[4]_i_2_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[1]_i_1_n_0\
    );
\rp[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[20]_i_2_n_4\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[20]_i_1_n_0\
    );
\rp[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[24]_i_2_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[21]_i_1_n_0\
    );
\rp[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[24]_i_2_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[22]_i_1_n_0\
    );
\rp[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[24]_i_2_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[23]_i_1_n_0\
    );
\rp[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[24]_i_2_n_4\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[24]_i_1_n_0\
    );
\rp[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[28]_i_2_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[25]_i_1_n_0\
    );
\rp[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[28]_i_2_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[26]_i_1_n_0\
    );
\rp[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[28]_i_2_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[27]_i_1_n_0\
    );
\rp[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[28]_i_2_n_4\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[28]_i_1_n_0\
    );
\rp[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[31]_i_4_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[29]_i_1_n_0\
    );
\rp[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[4]_i_2_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[2]_i_1_n_0\
    );
\rp[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[31]_i_4_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[30]_i_1_n_0\
    );
\rp[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEFFFF"
    )
        port map (
      I0 => SDATA_i_3_n_0,
      I1 => SDATA_i_4_n_0,
      I2 => SDATA_i_5_n_0,
      I3 => SDATA_i_6_n_0,
      I4 => \rp[31]_i_3_n_0\,
      O => \rp[31]_i_1_n_0\
    );
\rp[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[31]_i_4_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[31]_i_2_n_0\
    );
\rp[31]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => bclk_cnt(3),
      I1 => bclk_cnt(1),
      I2 => \bclk_cnt_reg_n_0_[0]\,
      I3 => bclk_cnt(2),
      I4 => bclk_cnt(4),
      O => \rp[31]_i_3_n_0\
    );
\rp[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[4]_i_2_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[3]_i_1_n_0\
    );
\rp[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[4]_i_2_n_4\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[4]_i_1_n_0\
    );
\rp[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[8]_i_2_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[5]_i_1_n_0\
    );
\rp[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[8]_i_2_n_6\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[6]_i_1_n_0\
    );
\rp[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[8]_i_2_n_5\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[7]_i_1_n_0\
    );
\rp[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[8]_i_2_n_4\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[8]_i_1_n_0\
    );
\rp[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => \rp_reg[12]_i_2_n_7\,
      I1 => SDATA_i_3_n_0,
      I2 => SDATA_i_4_n_0,
      I3 => SDATA_i_5_n_0,
      I4 => SDATA_i_6_n_0,
      O => \rp[9]_i_1_n_0\
    );
\rp_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[0]_i_1_n_0\,
      Q => \^count_out\(0)
    );
\rp_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[10]_i_1_n_0\,
      Q => \^count_out\(10)
    );
\rp_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[11]_i_1_n_0\,
      Q => \^count_out\(11)
    );
\rp_reg[12]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[12]_i_1_n_0\,
      Q => \^count_out\(12)
    );
\rp_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \rp_reg[8]_i_2_n_0\,
      CO(3) => \rp_reg[12]_i_2_n_0\,
      CO(2) => \rp_reg[12]_i_2_n_1\,
      CO(1) => \rp_reg[12]_i_2_n_2\,
      CO(0) => \rp_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \rp_reg[12]_i_2_n_4\,
      O(2) => \rp_reg[12]_i_2_n_5\,
      O(1) => \rp_reg[12]_i_2_n_6\,
      O(0) => \rp_reg[12]_i_2_n_7\,
      S(3 downto 0) => \^count_out\(12 downto 9)
    );
\rp_reg[13]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[13]_i_1_n_0\,
      Q => \^count_out\(13)
    );
\rp_reg[14]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[14]_i_1_n_0\,
      Q => \^count_out\(14)
    );
\rp_reg[15]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[15]_i_1_n_0\,
      Q => \^count_out\(15)
    );
\rp_reg[16]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[16]_i_1_n_0\,
      Q => \^count_out\(16)
    );
\rp_reg[16]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \rp_reg[12]_i_2_n_0\,
      CO(3) => \rp_reg[16]_i_2_n_0\,
      CO(2) => \rp_reg[16]_i_2_n_1\,
      CO(1) => \rp_reg[16]_i_2_n_2\,
      CO(0) => \rp_reg[16]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \rp_reg[16]_i_2_n_4\,
      O(2) => \rp_reg[16]_i_2_n_5\,
      O(1) => \rp_reg[16]_i_2_n_6\,
      O(0) => \rp_reg[16]_i_2_n_7\,
      S(3 downto 0) => \^count_out\(16 downto 13)
    );
\rp_reg[17]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[17]_i_1_n_0\,
      Q => \^count_out\(17)
    );
\rp_reg[18]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[18]_i_1_n_0\,
      Q => \^count_out\(18)
    );
\rp_reg[19]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[19]_i_1_n_0\,
      Q => \^count_out\(19)
    );
\rp_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[1]_i_1_n_0\,
      Q => \^count_out\(1)
    );
\rp_reg[20]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[20]_i_1_n_0\,
      Q => \^count_out\(20)
    );
\rp_reg[20]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \rp_reg[16]_i_2_n_0\,
      CO(3) => \rp_reg[20]_i_2_n_0\,
      CO(2) => \rp_reg[20]_i_2_n_1\,
      CO(1) => \rp_reg[20]_i_2_n_2\,
      CO(0) => \rp_reg[20]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \rp_reg[20]_i_2_n_4\,
      O(2) => \rp_reg[20]_i_2_n_5\,
      O(1) => \rp_reg[20]_i_2_n_6\,
      O(0) => \rp_reg[20]_i_2_n_7\,
      S(3 downto 0) => \^count_out\(20 downto 17)
    );
\rp_reg[21]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[21]_i_1_n_0\,
      Q => \^count_out\(21)
    );
\rp_reg[22]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[22]_i_1_n_0\,
      Q => \^count_out\(22)
    );
\rp_reg[23]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[23]_i_1_n_0\,
      Q => \^count_out\(23)
    );
\rp_reg[24]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[24]_i_1_n_0\,
      Q => \^count_out\(24)
    );
\rp_reg[24]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \rp_reg[20]_i_2_n_0\,
      CO(3) => \rp_reg[24]_i_2_n_0\,
      CO(2) => \rp_reg[24]_i_2_n_1\,
      CO(1) => \rp_reg[24]_i_2_n_2\,
      CO(0) => \rp_reg[24]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \rp_reg[24]_i_2_n_4\,
      O(2) => \rp_reg[24]_i_2_n_5\,
      O(1) => \rp_reg[24]_i_2_n_6\,
      O(0) => \rp_reg[24]_i_2_n_7\,
      S(3 downto 0) => \^count_out\(24 downto 21)
    );
\rp_reg[25]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[25]_i_1_n_0\,
      Q => \^count_out\(25)
    );
\rp_reg[26]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[26]_i_1_n_0\,
      Q => \^count_out\(26)
    );
\rp_reg[27]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[27]_i_1_n_0\,
      Q => \^count_out\(27)
    );
\rp_reg[28]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[28]_i_1_n_0\,
      Q => \^count_out\(28)
    );
\rp_reg[28]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \rp_reg[24]_i_2_n_0\,
      CO(3) => \rp_reg[28]_i_2_n_0\,
      CO(2) => \rp_reg[28]_i_2_n_1\,
      CO(1) => \rp_reg[28]_i_2_n_2\,
      CO(0) => \rp_reg[28]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \rp_reg[28]_i_2_n_4\,
      O(2) => \rp_reg[28]_i_2_n_5\,
      O(1) => \rp_reg[28]_i_2_n_6\,
      O(0) => \rp_reg[28]_i_2_n_7\,
      S(3 downto 0) => \^count_out\(28 downto 25)
    );
\rp_reg[29]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[29]_i_1_n_0\,
      Q => \^count_out\(29)
    );
\rp_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[2]_i_1_n_0\,
      Q => \^count_out\(2)
    );
\rp_reg[30]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[30]_i_1_n_0\,
      Q => \^count_out\(30)
    );
\rp_reg[31]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[31]_i_2_n_0\,
      Q => \^count_out\(31)
    );
\rp_reg[31]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \rp_reg[28]_i_2_n_0\,
      CO(3 downto 2) => \NLW_rp_reg[31]_i_4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \rp_reg[31]_i_4_n_2\,
      CO(0) => \rp_reg[31]_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_rp_reg[31]_i_4_O_UNCONNECTED\(3),
      O(2) => \rp_reg[31]_i_4_n_5\,
      O(1) => \rp_reg[31]_i_4_n_6\,
      O(0) => \rp_reg[31]_i_4_n_7\,
      S(3) => '0',
      S(2 downto 0) => \^count_out\(31 downto 29)
    );
\rp_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[3]_i_1_n_0\,
      Q => \^count_out\(3)
    );
\rp_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[4]_i_1_n_0\,
      Q => \^count_out\(4)
    );
\rp_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \rp_reg[4]_i_2_n_0\,
      CO(2) => \rp_reg[4]_i_2_n_1\,
      CO(1) => \rp_reg[4]_i_2_n_2\,
      CO(0) => \rp_reg[4]_i_2_n_3\,
      CYINIT => \^count_out\(0),
      DI(3 downto 0) => B"0000",
      O(3) => \rp_reg[4]_i_2_n_4\,
      O(2) => \rp_reg[4]_i_2_n_5\,
      O(1) => \rp_reg[4]_i_2_n_6\,
      O(0) => \rp_reg[4]_i_2_n_7\,
      S(3 downto 0) => \^count_out\(4 downto 1)
    );
\rp_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[5]_i_1_n_0\,
      Q => \^count_out\(5)
    );
\rp_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[6]_i_1_n_0\,
      Q => \^count_out\(6)
    );
\rp_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[7]_i_1_n_0\,
      Q => \^count_out\(7)
    );
\rp_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[8]_i_1_n_0\,
      Q => \^count_out\(8)
    );
\rp_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \rp_reg[4]_i_2_n_0\,
      CO(3) => \rp_reg[8]_i_2_n_0\,
      CO(2) => \rp_reg[8]_i_2_n_1\,
      CO(1) => \rp_reg[8]_i_2_n_2\,
      CO(0) => \rp_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \rp_reg[8]_i_2_n_4\,
      O(2) => \rp_reg[8]_i_2_n_5\,
      O(1) => \rp_reg[8]_i_2_n_6\,
      O(0) => \rp_reg[8]_i_2_n_7\,
      S(3 downto 0) => \^count_out\(8 downto 5)
    );
\rp_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      IS_C_INVERTED => '1'
    )
        port map (
      C => \^bclk_reg_0\,
      CE => \rp[31]_i_1_n_0\,
      CLR => BCLK_i_2_n_0,
      D => \rp[9]_i_1_n_0\,
      Q => \^count_out\(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_1_MAIN_0_0,MAIN,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "MAIN,Vivado 2020.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of CLK : signal is "xilinx.com:signal:clock:1.0 CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of CLK : signal is "XIL_INTERFACENAME CLK, ASSOCIATED_RESET RESET, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of RESET : signal is "xilinx.com:signal:reset:1.0 RESET RST";
  attribute X_INTERFACE_PARAMETER of RESET : signal is "XIL_INTERFACENAME RESET, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_MAIN
     port map (
      AUDIO_DATA_OUT => AUDIO_DATA_OUT,
      BCLK_reg_0 => BCLK_OUT,
      COUNT_OUT(31 downto 0) => COUNT_OUT(31 downto 0),
      GP_OPERATION(31 downto 0) => GP_OPERATION(31 downto 0),
      LRCLK_OUT => LRCLK_OUT,
      MCLK_IN_IBUF => MCLK_IN_IBUF,
      RESET => RESET,
      SOUND_IN(0) => SOUND_IN(0)
    );
end STRUCTURE;
