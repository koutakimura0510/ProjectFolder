-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Sun Apr  4 18:16:08 2021
-- Host        : koutakimura-MB-K700 running 64-bit Ubuntu 20.04.2 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd_vivado/muladd.gen/sources_1/bd/design_1/ip/design_1_muladd_0_0/design_1_muladd_0_0_sim_netlist.vhdl
-- Design      : design_1_muladd_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_muladd_0_0_muladd_control_s_axi_ram is
  port (
    DOADO : out STD_LOGIC_VECTOR ( 31 downto 0 );
    DOBDO : out STD_LOGIC_VECTOR ( 31 downto 0 );
    a_q0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    ADDRARDADDR : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \rdata_reg[31]\ : in STD_LOGIC;
    \rdata_reg[0]\ : in STD_LOGIC;
    \rdata_reg[1]\ : in STD_LOGIC;
    \rdata_reg[2]\ : in STD_LOGIC;
    \rdata_reg[3]\ : in STD_LOGIC;
    \rdata_reg[4]\ : in STD_LOGIC;
    \rdata_reg[5]\ : in STD_LOGIC;
    \rdata_reg[6]\ : in STD_LOGIC;
    \rdata_reg[7]\ : in STD_LOGIC;
    \rdata_reg[8]\ : in STD_LOGIC;
    \rdata_reg[9]\ : in STD_LOGIC;
    \rdata_reg[10]\ : in STD_LOGIC;
    \rdata_reg[11]\ : in STD_LOGIC;
    \rdata_reg[12]\ : in STD_LOGIC;
    \rdata_reg[13]\ : in STD_LOGIC;
    \rdata_reg[14]\ : in STD_LOGIC;
    \rdata_reg[15]\ : in STD_LOGIC;
    \rdata_reg[16]\ : in STD_LOGIC;
    \rdata_reg[17]\ : in STD_LOGIC;
    \rdata_reg[18]\ : in STD_LOGIC;
    \rdata_reg[19]\ : in STD_LOGIC;
    \rdata_reg[20]\ : in STD_LOGIC;
    \rdata_reg[21]\ : in STD_LOGIC;
    \rdata_reg[22]\ : in STD_LOGIC;
    \rdata_reg[23]\ : in STD_LOGIC;
    \rdata_reg[24]\ : in STD_LOGIC;
    \rdata_reg[25]\ : in STD_LOGIC;
    \rdata_reg[26]\ : in STD_LOGIC;
    \rdata_reg[27]\ : in STD_LOGIC;
    \rdata_reg[28]\ : in STD_LOGIC;
    \rdata_reg[29]\ : in STD_LOGIC;
    \rdata_reg[30]\ : in STD_LOGIC;
    \rdata_reg[31]_0\ : in STD_LOGIC;
    p_reg : in STD_LOGIC;
    \tmp_product__0\ : in STD_LOGIC;
    \tmp_product__0_0\ : in STD_LOGIC;
    \tmp_product__0_1\ : in STD_LOGIC;
    \tmp_product__0_2\ : in STD_LOGIC;
    \tmp_product__0_3\ : in STD_LOGIC;
    \tmp_product__0_4\ : in STD_LOGIC;
    \tmp_product__0_5\ : in STD_LOGIC;
    \tmp_product__0_6\ : in STD_LOGIC;
    \tmp_product__0_7\ : in STD_LOGIC;
    \tmp_product__0_8\ : in STD_LOGIC;
    \tmp_product__0_9\ : in STD_LOGIC;
    \tmp_product__0_10\ : in STD_LOGIC;
    \tmp_product__0_11\ : in STD_LOGIC;
    \tmp_product__0_12\ : in STD_LOGIC;
    \tmp_product__0_13\ : in STD_LOGIC;
    \tmp_product__0_14\ : in STD_LOGIC;
    \tmp_product__0_15\ : in STD_LOGIC;
    p_reg_0 : in STD_LOGIC;
    p_reg_1 : in STD_LOGIC;
    p_reg_2 : in STD_LOGIC;
    p_reg_3 : in STD_LOGIC;
    p_reg_4 : in STD_LOGIC;
    p_reg_5 : in STD_LOGIC;
    p_reg_6 : in STD_LOGIC;
    p_reg_7 : in STD_LOGIC;
    p_reg_8 : in STD_LOGIC;
    p_reg_9 : in STD_LOGIC;
    p_reg_10 : in STD_LOGIC;
    p_reg_11 : in STD_LOGIC;
    p_reg_12 : in STD_LOGIC;
    p_reg_13 : in STD_LOGIC;
    p_reg_14 : in STD_LOGIC;
    int_a_read : in STD_LOGIC;
    int_b_q1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    \gen_write[1].mem_reg_0\ : in STD_LOGIC;
    \rdata_reg[0]_0\ : in STD_LOGIC;
    \rdata_reg[1]_0\ : in STD_LOGIC;
    \rdata_reg[2]_0\ : in STD_LOGIC;
    \rdata_reg[3]_0\ : in STD_LOGIC;
    \rdata_reg[4]_0\ : in STD_LOGIC;
    \rdata_reg[5]_0\ : in STD_LOGIC;
    \rdata_reg[6]_0\ : in STD_LOGIC;
    \rdata_reg[7]_0\ : in STD_LOGIC;
    \rdata_reg[8]_0\ : in STD_LOGIC;
    \rdata_reg[9]_0\ : in STD_LOGIC;
    \rdata_reg[10]_0\ : in STD_LOGIC;
    \rdata_reg[11]_0\ : in STD_LOGIC;
    \rdata_reg[12]_0\ : in STD_LOGIC;
    \rdata_reg[13]_0\ : in STD_LOGIC;
    \rdata_reg[14]_0\ : in STD_LOGIC;
    \rdata_reg[15]_0\ : in STD_LOGIC;
    \rdata_reg[16]_0\ : in STD_LOGIC;
    \rdata_reg[17]_0\ : in STD_LOGIC;
    \rdata_reg[18]_0\ : in STD_LOGIC;
    \rdata_reg[19]_0\ : in STD_LOGIC;
    \rdata_reg[20]_0\ : in STD_LOGIC;
    \rdata_reg[21]_0\ : in STD_LOGIC;
    \rdata_reg[22]_0\ : in STD_LOGIC;
    \rdata_reg[23]_0\ : in STD_LOGIC;
    \rdata_reg[24]_0\ : in STD_LOGIC;
    \rdata_reg[25]_0\ : in STD_LOGIC;
    \rdata_reg[26]_0\ : in STD_LOGIC;
    \rdata_reg[27]_0\ : in STD_LOGIC;
    \rdata_reg[28]_0\ : in STD_LOGIC;
    \rdata_reg[29]_0\ : in STD_LOGIC;
    \rdata_reg[30]_0\ : in STD_LOGIC;
    \rdata_reg[31]_1\ : in STD_LOGIC;
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \gen_write[1].mem_reg_1\ : in STD_LOGIC;
    \gen_write[1].mem_reg_2\ : in STD_LOGIC;
    s_axi_control_WVALID : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_muladd_0_0_muladd_control_s_axi_ram : entity is "muladd_control_s_axi_ram";
end design_1_muladd_0_0_muladd_control_s_axi_ram;

architecture STRUCTURE of design_1_muladd_0_0_muladd_control_s_axi_ram is
  signal \^doado\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^dobdo\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_write[1].mem_reg_i_5_n_0\ : STD_LOGIC;
  signal \gen_write[1].mem_reg_i_6_n_0\ : STD_LOGIC;
  signal \gen_write[1].mem_reg_i_7_n_0\ : STD_LOGIC;
  signal \gen_write[1].mem_reg_i_8_n_0\ : STD_LOGIC;
  signal int_a_q1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_write[1].mem_reg\ : label is "p0_d8_p0_d8_p0_d8_p0_d8";
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_write[1].mem_reg\ : label is "p0_d8_p0_d8_p0_d8_p0_d8";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \gen_write[1].mem_reg\ : label is "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of \gen_write[1].mem_reg\ : label is 512;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of \gen_write[1].mem_reg\ : label is "control_s_axi_U/int_a/gen_write[1].mem";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of \gen_write[1].mem_reg\ : label is "RAM_TDP";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of \gen_write[1].mem_reg\ : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of \gen_write[1].mem_reg\ : label is 15;
  attribute ram_offset : integer;
  attribute ram_offset of \gen_write[1].mem_reg\ : label is 1008;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of \gen_write[1].mem_reg\ : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of \gen_write[1].mem_reg\ : label is 31;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \rdata[0]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \rdata[10]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \rdata[11]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \rdata[12]_i_2\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \rdata[13]_i_2\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \rdata[14]_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \rdata[15]_i_2\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \rdata[16]_i_2\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \rdata[17]_i_2\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \rdata[18]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rdata[19]_i_2\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rdata[1]_i_3\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \rdata[20]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rdata[21]_i_2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rdata[22]_i_2\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \rdata[23]_i_2\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \rdata[24]_i_2\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \rdata[25]_i_2\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \rdata[26]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \rdata[27]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \rdata[28]_i_2\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \rdata[29]_i_2\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \rdata[2]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \rdata[30]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \rdata[31]_i_3\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \rdata[3]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \rdata[4]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rdata[5]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \rdata[6]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rdata[7]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rdata[8]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \rdata[9]_i_2\ : label is "soft_lutpair4";
begin
  DOADO(31 downto 0) <= \^doado\(31 downto 0);
  DOBDO(31 downto 0) <= \^dobdo\(31 downto 0);
\gen_write[1].mem_reg\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(15 downto 9) => B"1111111",
      ADDRARDADDR(8 downto 5) => ADDRARDADDR(3 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(15 downto 9) => B"1111111",
      ADDRBWRADDR(8 downto 5) => Q(3 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CASCADEINA => '1',
      CASCADEINB => '1',
      CASCADEOUTA => \NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => ap_clk,
      CLKBWRCLK => ap_clk,
      DBITERR => \NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => s_axi_control_WDATA(31 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => \^doado\(31 downto 0),
      DOBDO(31 downto 0) => \^dobdo\(31 downto 0),
      DOPADOP(3 downto 0) => \NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 0) => \NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED\(3 downto 0),
      ECCPARITY(7 downto 0) => \NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => '1',
      ENBWREN => '1',
      INJECTDBITERR => \NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED\,
      INJECTSBITERR => \NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED\,
      RDADDRECC(8 downto 0) => \NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED\,
      WEA(3) => \gen_write[1].mem_reg_i_5_n_0\,
      WEA(2) => \gen_write[1].mem_reg_i_6_n_0\,
      WEA(1) => \gen_write[1].mem_reg_i_7_n_0\,
      WEA(0) => \gen_write[1].mem_reg_i_8_n_0\,
      WEBWE(7 downto 0) => B"00000000"
    );
\gen_write[1].mem_reg_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(3),
      I1 => \gen_write[1].mem_reg_1\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_0\,
      I4 => \gen_write[1].mem_reg_2\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_5_n_0\
    );
\gen_write[1].mem_reg_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(2),
      I1 => \gen_write[1].mem_reg_1\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_0\,
      I4 => \gen_write[1].mem_reg_2\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_6_n_0\
    );
\gen_write[1].mem_reg_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(1),
      I1 => \gen_write[1].mem_reg_1\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_0\,
      I4 => \gen_write[1].mem_reg_2\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_7_n_0\
    );
\gen_write[1].mem_reg_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(0),
      I1 => \gen_write[1].mem_reg_1\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_0\,
      I4 => \gen_write[1].mem_reg_2\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_8_n_0\
    );
p_reg_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(31),
      I1 => p_reg,
      I2 => p_reg_14,
      O => a_q0(31)
    );
p_reg_i_10: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(22),
      I1 => p_reg,
      I2 => p_reg_5,
      O => a_q0(22)
    );
p_reg_i_11: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(21),
      I1 => p_reg,
      I2 => p_reg_4,
      O => a_q0(21)
    );
p_reg_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(20),
      I1 => p_reg,
      I2 => p_reg_3,
      O => a_q0(20)
    );
p_reg_i_13: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(19),
      I1 => p_reg,
      I2 => p_reg_2,
      O => a_q0(19)
    );
p_reg_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(18),
      I1 => p_reg,
      I2 => p_reg_1,
      O => a_q0(18)
    );
p_reg_i_15: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(17),
      I1 => p_reg,
      I2 => p_reg_0,
      O => a_q0(17)
    );
p_reg_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(30),
      I1 => p_reg,
      I2 => p_reg_13,
      O => a_q0(30)
    );
p_reg_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(29),
      I1 => p_reg,
      I2 => p_reg_12,
      O => a_q0(29)
    );
p_reg_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(28),
      I1 => p_reg,
      I2 => p_reg_11,
      O => a_q0(28)
    );
p_reg_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(27),
      I1 => p_reg,
      I2 => p_reg_10,
      O => a_q0(27)
    );
p_reg_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(26),
      I1 => p_reg,
      I2 => p_reg_9,
      O => a_q0(26)
    );
p_reg_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(25),
      I1 => p_reg,
      I2 => p_reg_8,
      O => a_q0(25)
    );
p_reg_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(24),
      I1 => p_reg,
      I2 => p_reg_7,
      O => a_q0(24)
    );
p_reg_i_9: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(23),
      I1 => p_reg,
      I2 => p_reg_6,
      O => a_q0(23)
    );
\rdata[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(0),
      I1 => int_a_read,
      I2 => int_b_q1(0),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[0]_0\,
      O => D(0)
    );
\rdata[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(0),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[0]\,
      O => int_a_q1(0)
    );
\rdata[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(10),
      I1 => int_a_read,
      I2 => int_b_q1(10),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[10]_0\,
      O => D(10)
    );
\rdata[10]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(10),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[10]\,
      O => int_a_q1(10)
    );
\rdata[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(11),
      I1 => int_a_read,
      I2 => int_b_q1(11),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[11]_0\,
      O => D(11)
    );
\rdata[11]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(11),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[11]\,
      O => int_a_q1(11)
    );
\rdata[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(12),
      I1 => int_a_read,
      I2 => int_b_q1(12),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[12]_0\,
      O => D(12)
    );
\rdata[12]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(12),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[12]\,
      O => int_a_q1(12)
    );
\rdata[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(13),
      I1 => int_a_read,
      I2 => int_b_q1(13),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[13]_0\,
      O => D(13)
    );
\rdata[13]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(13),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[13]\,
      O => int_a_q1(13)
    );
\rdata[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(14),
      I1 => int_a_read,
      I2 => int_b_q1(14),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[14]_0\,
      O => D(14)
    );
\rdata[14]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(14),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[14]\,
      O => int_a_q1(14)
    );
\rdata[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(15),
      I1 => int_a_read,
      I2 => int_b_q1(15),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[15]_0\,
      O => D(15)
    );
\rdata[15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(15),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[15]\,
      O => int_a_q1(15)
    );
\rdata[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(16),
      I1 => int_a_read,
      I2 => int_b_q1(16),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[16]_0\,
      O => D(16)
    );
\rdata[16]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(16),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[16]\,
      O => int_a_q1(16)
    );
\rdata[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(17),
      I1 => int_a_read,
      I2 => int_b_q1(17),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[17]_0\,
      O => D(17)
    );
\rdata[17]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(17),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[17]\,
      O => int_a_q1(17)
    );
\rdata[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(18),
      I1 => int_a_read,
      I2 => int_b_q1(18),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[18]_0\,
      O => D(18)
    );
\rdata[18]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(18),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[18]\,
      O => int_a_q1(18)
    );
\rdata[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(19),
      I1 => int_a_read,
      I2 => int_b_q1(19),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[19]_0\,
      O => D(19)
    );
\rdata[19]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(19),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[19]\,
      O => int_a_q1(19)
    );
\rdata[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAEFEAEFEAEFEA"
    )
        port map (
      I0 => \rdata_reg[1]_0\,
      I1 => int_a_q1(1),
      I2 => int_a_read,
      I3 => int_b_q1(1),
      I4 => s_axi_control_ARVALID,
      I5 => \gen_write[1].mem_reg_0\,
      O => D(1)
    );
\rdata[1]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(1),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[1]\,
      O => int_a_q1(1)
    );
\rdata[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(20),
      I1 => int_a_read,
      I2 => int_b_q1(20),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[20]_0\,
      O => D(20)
    );
\rdata[20]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(20),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[20]\,
      O => int_a_q1(20)
    );
\rdata[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(21),
      I1 => int_a_read,
      I2 => int_b_q1(21),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[21]_0\,
      O => D(21)
    );
\rdata[21]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(21),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[21]\,
      O => int_a_q1(21)
    );
\rdata[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(22),
      I1 => int_a_read,
      I2 => int_b_q1(22),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[22]_0\,
      O => D(22)
    );
\rdata[22]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(22),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[22]\,
      O => int_a_q1(22)
    );
\rdata[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(23),
      I1 => int_a_read,
      I2 => int_b_q1(23),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[23]_0\,
      O => D(23)
    );
\rdata[23]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(23),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[23]\,
      O => int_a_q1(23)
    );
\rdata[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(24),
      I1 => int_a_read,
      I2 => int_b_q1(24),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[24]_0\,
      O => D(24)
    );
\rdata[24]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(24),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[24]\,
      O => int_a_q1(24)
    );
\rdata[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(25),
      I1 => int_a_read,
      I2 => int_b_q1(25),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[25]_0\,
      O => D(25)
    );
\rdata[25]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(25),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[25]\,
      O => int_a_q1(25)
    );
\rdata[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(26),
      I1 => int_a_read,
      I2 => int_b_q1(26),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[26]_0\,
      O => D(26)
    );
\rdata[26]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(26),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[26]\,
      O => int_a_q1(26)
    );
\rdata[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(27),
      I1 => int_a_read,
      I2 => int_b_q1(27),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[27]_0\,
      O => D(27)
    );
\rdata[27]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(27),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[27]\,
      O => int_a_q1(27)
    );
\rdata[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(28),
      I1 => int_a_read,
      I2 => int_b_q1(28),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[28]_0\,
      O => D(28)
    );
\rdata[28]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(28),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[28]\,
      O => int_a_q1(28)
    );
\rdata[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(29),
      I1 => int_a_read,
      I2 => int_b_q1(29),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[29]_0\,
      O => D(29)
    );
\rdata[29]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(29),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[29]\,
      O => int_a_q1(29)
    );
\rdata[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(2),
      I1 => int_a_read,
      I2 => int_b_q1(2),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[2]_0\,
      O => D(2)
    );
\rdata[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(2),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[2]\,
      O => int_a_q1(2)
    );
\rdata[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(30),
      I1 => int_a_read,
      I2 => int_b_q1(30),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[30]_0\,
      O => D(30)
    );
\rdata[30]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(30),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[30]\,
      O => int_a_q1(30)
    );
\rdata[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(31),
      I1 => int_a_read,
      I2 => int_b_q1(31),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[31]_1\,
      O => D(31)
    );
\rdata[31]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(31),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[31]_0\,
      O => int_a_q1(31)
    );
\rdata[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(3),
      I1 => int_a_read,
      I2 => int_b_q1(3),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[3]_0\,
      O => D(3)
    );
\rdata[3]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(3),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[3]\,
      O => int_a_q1(3)
    );
\rdata[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(4),
      I1 => int_a_read,
      I2 => int_b_q1(4),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[4]_0\,
      O => D(4)
    );
\rdata[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(4),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[4]\,
      O => int_a_q1(4)
    );
\rdata[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(5),
      I1 => int_a_read,
      I2 => int_b_q1(5),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[5]_0\,
      O => D(5)
    );
\rdata[5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(5),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[5]\,
      O => int_a_q1(5)
    );
\rdata[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(6),
      I1 => int_a_read,
      I2 => int_b_q1(6),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[6]_0\,
      O => D(6)
    );
\rdata[6]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(6),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[6]\,
      O => int_a_q1(6)
    );
\rdata[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(7),
      I1 => int_a_read,
      I2 => int_b_q1(7),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[7]_0\,
      O => D(7)
    );
\rdata[7]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(7),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[7]\,
      O => int_a_q1(7)
    );
\rdata[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(8),
      I1 => int_a_read,
      I2 => int_b_q1(8),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[8]_0\,
      O => D(8)
    );
\rdata[8]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(8),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[8]\,
      O => int_a_q1(8)
    );
\rdata[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00B8B8B8"
    )
        port map (
      I0 => int_a_q1(9),
      I1 => int_a_read,
      I2 => int_b_q1(9),
      I3 => s_axi_control_ARVALID,
      I4 => \gen_write[1].mem_reg_0\,
      I5 => \rdata_reg[9]_0\,
      O => D(9)
    );
\rdata[9]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^doado\(9),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[9]\,
      O => int_a_q1(9)
    );
tmp_product_i_17: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(16),
      I1 => p_reg,
      I2 => \tmp_product__0_15\,
      O => a_q0(16)
    );
tmp_product_i_18: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(15),
      I1 => p_reg,
      I2 => \tmp_product__0_14\,
      O => a_q0(15)
    );
tmp_product_i_19: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(14),
      I1 => p_reg,
      I2 => \tmp_product__0_13\,
      O => a_q0(14)
    );
tmp_product_i_20: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(13),
      I1 => p_reg,
      I2 => \tmp_product__0_12\,
      O => a_q0(13)
    );
tmp_product_i_21: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(12),
      I1 => p_reg,
      I2 => \tmp_product__0_11\,
      O => a_q0(12)
    );
tmp_product_i_22: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(11),
      I1 => p_reg,
      I2 => \tmp_product__0_10\,
      O => a_q0(11)
    );
tmp_product_i_23: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(10),
      I1 => p_reg,
      I2 => \tmp_product__0_9\,
      O => a_q0(10)
    );
tmp_product_i_24: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(9),
      I1 => p_reg,
      I2 => \tmp_product__0_8\,
      O => a_q0(9)
    );
tmp_product_i_25: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(8),
      I1 => p_reg,
      I2 => \tmp_product__0_7\,
      O => a_q0(8)
    );
tmp_product_i_26: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(7),
      I1 => p_reg,
      I2 => \tmp_product__0_6\,
      O => a_q0(7)
    );
tmp_product_i_27: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(6),
      I1 => p_reg,
      I2 => \tmp_product__0_5\,
      O => a_q0(6)
    );
tmp_product_i_28: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(5),
      I1 => p_reg,
      I2 => \tmp_product__0_4\,
      O => a_q0(5)
    );
tmp_product_i_29: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(4),
      I1 => p_reg,
      I2 => \tmp_product__0_3\,
      O => a_q0(4)
    );
tmp_product_i_30: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(3),
      I1 => p_reg,
      I2 => \tmp_product__0_2\,
      O => a_q0(3)
    );
tmp_product_i_31: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(2),
      I1 => p_reg,
      I2 => \tmp_product__0_1\,
      O => a_q0(2)
    );
tmp_product_i_32: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(1),
      I1 => p_reg,
      I2 => \tmp_product__0_0\,
      O => a_q0(1)
    );
tmp_product_i_33: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^dobdo\(0),
      I1 => p_reg,
      I2 => \tmp_product__0\,
      O => a_q0(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_muladd_0_0_muladd_control_s_axi_ram_0 is
  port (
    \gen_write[1].mem_reg_0\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \gen_write[1].mem_reg_1\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ADDRARDADDR : out STD_LOGIC_VECTOR ( 3 downto 0 );
    int_b_q1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b_q0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \rdata_reg[31]\ : in STD_LOGIC;
    \rdata_reg[0]\ : in STD_LOGIC;
    \rdata_reg[1]\ : in STD_LOGIC;
    \rdata_reg[2]\ : in STD_LOGIC;
    \rdata_reg[3]\ : in STD_LOGIC;
    \rdata_reg[4]\ : in STD_LOGIC;
    \rdata_reg[5]\ : in STD_LOGIC;
    \rdata_reg[6]\ : in STD_LOGIC;
    \rdata_reg[7]\ : in STD_LOGIC;
    \rdata_reg[8]\ : in STD_LOGIC;
    \rdata_reg[9]\ : in STD_LOGIC;
    \rdata_reg[10]\ : in STD_LOGIC;
    \rdata_reg[11]\ : in STD_LOGIC;
    \rdata_reg[12]\ : in STD_LOGIC;
    \rdata_reg[13]\ : in STD_LOGIC;
    \rdata_reg[14]\ : in STD_LOGIC;
    \rdata_reg[15]\ : in STD_LOGIC;
    \rdata_reg[16]\ : in STD_LOGIC;
    \rdata_reg[17]\ : in STD_LOGIC;
    \rdata_reg[18]\ : in STD_LOGIC;
    \rdata_reg[19]\ : in STD_LOGIC;
    \rdata_reg[20]\ : in STD_LOGIC;
    \rdata_reg[21]\ : in STD_LOGIC;
    \rdata_reg[22]\ : in STD_LOGIC;
    \rdata_reg[23]\ : in STD_LOGIC;
    \rdata_reg[24]\ : in STD_LOGIC;
    \rdata_reg[25]\ : in STD_LOGIC;
    \rdata_reg[26]\ : in STD_LOGIC;
    \rdata_reg[27]\ : in STD_LOGIC;
    \rdata_reg[28]\ : in STD_LOGIC;
    \rdata_reg[29]\ : in STD_LOGIC;
    \rdata_reg[30]\ : in STD_LOGIC;
    \rdata_reg[31]_0\ : in STD_LOGIC;
    tmp_product : in STD_LOGIC;
    \tmp_product__0\ : in STD_LOGIC;
    \tmp_product__0_0\ : in STD_LOGIC;
    \tmp_product__0_1\ : in STD_LOGIC;
    \tmp_product__0_2\ : in STD_LOGIC;
    \tmp_product__0_3\ : in STD_LOGIC;
    \tmp_product__0_4\ : in STD_LOGIC;
    \tmp_product__0_5\ : in STD_LOGIC;
    \tmp_product__0_6\ : in STD_LOGIC;
    \tmp_product__0_7\ : in STD_LOGIC;
    \tmp_product__0_8\ : in STD_LOGIC;
    \tmp_product__0_9\ : in STD_LOGIC;
    \tmp_product__0_10\ : in STD_LOGIC;
    \tmp_product__0_11\ : in STD_LOGIC;
    \tmp_product__0_12\ : in STD_LOGIC;
    \tmp_product__0_13\ : in STD_LOGIC;
    \tmp_product__0_14\ : in STD_LOGIC;
    \tmp_product__0_15\ : in STD_LOGIC;
    tmp_product_0 : in STD_LOGIC;
    tmp_product_1 : in STD_LOGIC;
    tmp_product_2 : in STD_LOGIC;
    tmp_product_3 : in STD_LOGIC;
    tmp_product_4 : in STD_LOGIC;
    tmp_product_5 : in STD_LOGIC;
    tmp_product_6 : in STD_LOGIC;
    tmp_product_7 : in STD_LOGIC;
    tmp_product_8 : in STD_LOGIC;
    tmp_product_9 : in STD_LOGIC;
    tmp_product_10 : in STD_LOGIC;
    tmp_product_11 : in STD_LOGIC;
    tmp_product_12 : in STD_LOGIC;
    tmp_product_13 : in STD_LOGIC;
    tmp_product_14 : in STD_LOGIC;
    \gen_write[1].mem_reg_2\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    \gen_write[1].mem_reg_3\ : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \gen_write[1].mem_reg_4\ : in STD_LOGIC;
    \gen_write[1].mem_reg_5\ : in STD_LOGIC;
    s_axi_control_WVALID : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_muladd_0_0_muladd_control_s_axi_ram_0 : entity is "muladd_control_s_axi_ram";
end design_1_muladd_0_0_muladd_control_s_axi_ram_0;

architecture STRUCTURE of design_1_muladd_0_0_muladd_control_s_axi_ram_0 is
  signal \^addrardaddr\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^gen_write[1].mem_reg_0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^gen_write[1].mem_reg_1\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \gen_write[1].mem_reg_i_1__0_n_0\ : STD_LOGIC;
  signal \gen_write[1].mem_reg_i_2__0_n_0\ : STD_LOGIC;
  signal \gen_write[1].mem_reg_i_3__0_n_0\ : STD_LOGIC;
  signal \gen_write[1].mem_reg_i_4__0_n_0\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTA.DATA_BIT_LAYOUT\ of \gen_write[1].mem_reg\ : label is "p0_d8_p0_d8_p0_d8_p0_d8";
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ : string;
  attribute \MEM.PORTB.DATA_BIT_LAYOUT\ of \gen_write[1].mem_reg\ : label is "p0_d8_p0_d8_p0_d8_p0_d8";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \gen_write[1].mem_reg\ : label is "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of \gen_write[1].mem_reg\ : label is 512;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of \gen_write[1].mem_reg\ : label is "control_s_axi_U/int_b/gen_write[1].mem";
  attribute RTL_RAM_TYPE : string;
  attribute RTL_RAM_TYPE of \gen_write[1].mem_reg\ : label is "RAM_TDP";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of \gen_write[1].mem_reg\ : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of \gen_write[1].mem_reg\ : label is 15;
  attribute ram_offset : integer;
  attribute ram_offset of \gen_write[1].mem_reg\ : label is 1008;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of \gen_write[1].mem_reg\ : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of \gen_write[1].mem_reg\ : label is 31;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \rdata[0]_i_3\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \rdata[10]_i_3\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \rdata[11]_i_3\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \rdata[12]_i_3\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \rdata[13]_i_3\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \rdata[14]_i_3\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \rdata[15]_i_3\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \rdata[16]_i_3\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \rdata[17]_i_3\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \rdata[18]_i_3\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \rdata[19]_i_3\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \rdata[1]_i_4\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \rdata[20]_i_3\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \rdata[21]_i_3\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \rdata[22]_i_3\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \rdata[23]_i_3\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \rdata[24]_i_3\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \rdata[25]_i_3\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \rdata[26]_i_3\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \rdata[27]_i_3\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \rdata[28]_i_3\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \rdata[29]_i_3\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \rdata[2]_i_3\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \rdata[30]_i_3\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \rdata[31]_i_4\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \rdata[3]_i_3\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \rdata[4]_i_3\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \rdata[5]_i_3\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \rdata[6]_i_3\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \rdata[7]_i_3\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \rdata[8]_i_3\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \rdata[9]_i_3\ : label is "soft_lutpair20";
begin
  ADDRARDADDR(3 downto 0) <= \^addrardaddr\(3 downto 0);
  \gen_write[1].mem_reg_0\(31 downto 0) <= \^gen_write[1].mem_reg_0\(31 downto 0);
  \gen_write[1].mem_reg_1\(31 downto 0) <= \^gen_write[1].mem_reg_1\(31 downto 0);
\gen_write[1].mem_reg\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36
    )
        port map (
      ADDRARDADDR(15 downto 9) => B"1111111",
      ADDRARDADDR(8 downto 5) => \^addrardaddr\(3 downto 0),
      ADDRARDADDR(4 downto 0) => B"11111",
      ADDRBWRADDR(15 downto 9) => B"1111111",
      ADDRBWRADDR(8 downto 5) => Q(3 downto 0),
      ADDRBWRADDR(4 downto 0) => B"11111",
      CASCADEINA => '1',
      CASCADEINB => '1',
      CASCADEOUTA => \NLW_gen_write[1].mem_reg_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_gen_write[1].mem_reg_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => ap_clk,
      CLKBWRCLK => ap_clk,
      DBITERR => \NLW_gen_write[1].mem_reg_DBITERR_UNCONNECTED\,
      DIADI(31 downto 0) => s_axi_control_WDATA(31 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => \^gen_write[1].mem_reg_0\(31 downto 0),
      DOBDO(31 downto 0) => \^gen_write[1].mem_reg_1\(31 downto 0),
      DOPADOP(3 downto 0) => \NLW_gen_write[1].mem_reg_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 0) => \NLW_gen_write[1].mem_reg_DOPBDOP_UNCONNECTED\(3 downto 0),
      ECCPARITY(7 downto 0) => \NLW_gen_write[1].mem_reg_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => '1',
      ENBWREN => '1',
      INJECTDBITERR => \NLW_gen_write[1].mem_reg_INJECTDBITERR_UNCONNECTED\,
      INJECTSBITERR => \NLW_gen_write[1].mem_reg_INJECTSBITERR_UNCONNECTED\,
      RDADDRECC(8 downto 0) => \NLW_gen_write[1].mem_reg_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => '0',
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_gen_write[1].mem_reg_SBITERR_UNCONNECTED\,
      WEA(3) => \gen_write[1].mem_reg_i_1__0_n_0\,
      WEA(2) => \gen_write[1].mem_reg_i_2__0_n_0\,
      WEA(1) => \gen_write[1].mem_reg_i_3__0_n_0\,
      WEA(0) => \gen_write[1].mem_reg_i_4__0_n_0\,
      WEBWE(7 downto 0) => B"00000000"
    );
\gen_write[1].mem_reg_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EA2A"
    )
        port map (
      I0 => \gen_write[1].mem_reg_2\(3),
      I1 => s_axi_control_ARVALID,
      I2 => \gen_write[1].mem_reg_3\,
      I3 => s_axi_control_ARADDR(3),
      O => \^addrardaddr\(3)
    );
\gen_write[1].mem_reg_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(3),
      I1 => \gen_write[1].mem_reg_4\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_3\,
      I4 => \gen_write[1].mem_reg_5\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_1__0_n_0\
    );
\gen_write[1].mem_reg_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EA2A"
    )
        port map (
      I0 => \gen_write[1].mem_reg_2\(2),
      I1 => s_axi_control_ARVALID,
      I2 => \gen_write[1].mem_reg_3\,
      I3 => s_axi_control_ARADDR(2),
      O => \^addrardaddr\(2)
    );
\gen_write[1].mem_reg_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(2),
      I1 => \gen_write[1].mem_reg_4\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_3\,
      I4 => \gen_write[1].mem_reg_5\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_2__0_n_0\
    );
\gen_write[1].mem_reg_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EA2A"
    )
        port map (
      I0 => \gen_write[1].mem_reg_2\(1),
      I1 => s_axi_control_ARVALID,
      I2 => \gen_write[1].mem_reg_3\,
      I3 => s_axi_control_ARADDR(1),
      O => \^addrardaddr\(1)
    );
\gen_write[1].mem_reg_i_3__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(1),
      I1 => \gen_write[1].mem_reg_4\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_3\,
      I4 => \gen_write[1].mem_reg_5\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_3__0_n_0\
    );
\gen_write[1].mem_reg_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EA2A"
    )
        port map (
      I0 => \gen_write[1].mem_reg_2\(0),
      I1 => s_axi_control_ARVALID,
      I2 => \gen_write[1].mem_reg_3\,
      I3 => s_axi_control_ARADDR(0),
      O => \^addrardaddr\(0)
    );
\gen_write[1].mem_reg_i_4__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888000000000000"
    )
        port map (
      I0 => s_axi_control_WSTRB(0),
      I1 => \gen_write[1].mem_reg_4\,
      I2 => s_axi_control_ARVALID,
      I3 => \gen_write[1].mem_reg_3\,
      I4 => \gen_write[1].mem_reg_5\,
      I5 => s_axi_control_WVALID,
      O => \gen_write[1].mem_reg_i_4__0_n_0\
    );
\rdata[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(0),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[0]\,
      O => int_b_q1(0)
    );
\rdata[10]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(10),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[10]\,
      O => int_b_q1(10)
    );
\rdata[11]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(11),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[11]\,
      O => int_b_q1(11)
    );
\rdata[12]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(12),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[12]\,
      O => int_b_q1(12)
    );
\rdata[13]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(13),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[13]\,
      O => int_b_q1(13)
    );
\rdata[14]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(14),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[14]\,
      O => int_b_q1(14)
    );
\rdata[15]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(15),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[15]\,
      O => int_b_q1(15)
    );
\rdata[16]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(16),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[16]\,
      O => int_b_q1(16)
    );
\rdata[17]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(17),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[17]\,
      O => int_b_q1(17)
    );
\rdata[18]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(18),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[18]\,
      O => int_b_q1(18)
    );
\rdata[19]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(19),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[19]\,
      O => int_b_q1(19)
    );
\rdata[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(1),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[1]\,
      O => int_b_q1(1)
    );
\rdata[20]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(20),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[20]\,
      O => int_b_q1(20)
    );
\rdata[21]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(21),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[21]\,
      O => int_b_q1(21)
    );
\rdata[22]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(22),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[22]\,
      O => int_b_q1(22)
    );
\rdata[23]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(23),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[23]\,
      O => int_b_q1(23)
    );
\rdata[24]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(24),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[24]\,
      O => int_b_q1(24)
    );
\rdata[25]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(25),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[25]\,
      O => int_b_q1(25)
    );
\rdata[26]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(26),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[26]\,
      O => int_b_q1(26)
    );
\rdata[27]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(27),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[27]\,
      O => int_b_q1(27)
    );
\rdata[28]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(28),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[28]\,
      O => int_b_q1(28)
    );
\rdata[29]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(29),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[29]\,
      O => int_b_q1(29)
    );
\rdata[2]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(2),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[2]\,
      O => int_b_q1(2)
    );
\rdata[30]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(30),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[30]\,
      O => int_b_q1(30)
    );
\rdata[31]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(31),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[31]_0\,
      O => int_b_q1(31)
    );
\rdata[3]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(3),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[3]\,
      O => int_b_q1(3)
    );
\rdata[4]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(4),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[4]\,
      O => int_b_q1(4)
    );
\rdata[5]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(5),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[5]\,
      O => int_b_q1(5)
    );
\rdata[6]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(6),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[6]\,
      O => int_b_q1(6)
    );
\rdata[7]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(7),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[7]\,
      O => int_b_q1(7)
    );
\rdata[8]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(8),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[8]\,
      O => int_b_q1(8)
    );
\rdata[9]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_0\(9),
      I1 => \rdata_reg[31]\,
      I2 => \rdata_reg[9]\,
      O => int_b_q1(9)
    );
\tmp_product__0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(16),
      I1 => tmp_product,
      I2 => \tmp_product__0_15\,
      O => b_q0(16)
    );
\tmp_product__0_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(7),
      I1 => tmp_product,
      I2 => \tmp_product__0_6\,
      O => b_q0(7)
    );
\tmp_product__0_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(6),
      I1 => tmp_product,
      I2 => \tmp_product__0_5\,
      O => b_q0(6)
    );
\tmp_product__0_i_12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(5),
      I1 => tmp_product,
      I2 => \tmp_product__0_4\,
      O => b_q0(5)
    );
\tmp_product__0_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(4),
      I1 => tmp_product,
      I2 => \tmp_product__0_3\,
      O => b_q0(4)
    );
\tmp_product__0_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(3),
      I1 => tmp_product,
      I2 => \tmp_product__0_2\,
      O => b_q0(3)
    );
\tmp_product__0_i_15\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(2),
      I1 => tmp_product,
      I2 => \tmp_product__0_1\,
      O => b_q0(2)
    );
\tmp_product__0_i_16\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(1),
      I1 => tmp_product,
      I2 => \tmp_product__0_0\,
      O => b_q0(1)
    );
\tmp_product__0_i_17\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(0),
      I1 => tmp_product,
      I2 => \tmp_product__0\,
      O => b_q0(0)
    );
\tmp_product__0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(15),
      I1 => tmp_product,
      I2 => \tmp_product__0_14\,
      O => b_q0(15)
    );
\tmp_product__0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(14),
      I1 => tmp_product,
      I2 => \tmp_product__0_13\,
      O => b_q0(14)
    );
\tmp_product__0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(13),
      I1 => tmp_product,
      I2 => \tmp_product__0_12\,
      O => b_q0(13)
    );
\tmp_product__0_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(12),
      I1 => tmp_product,
      I2 => \tmp_product__0_11\,
      O => b_q0(12)
    );
\tmp_product__0_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(11),
      I1 => tmp_product,
      I2 => \tmp_product__0_10\,
      O => b_q0(11)
    );
\tmp_product__0_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(10),
      I1 => tmp_product,
      I2 => \tmp_product__0_9\,
      O => b_q0(10)
    );
\tmp_product__0_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(9),
      I1 => tmp_product,
      I2 => \tmp_product__0_8\,
      O => b_q0(9)
    );
\tmp_product__0_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(8),
      I1 => tmp_product,
      I2 => \tmp_product__0_7\,
      O => b_q0(8)
    );
tmp_product_i_10: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(23),
      I1 => tmp_product,
      I2 => tmp_product_6,
      O => b_q0(23)
    );
tmp_product_i_11: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(22),
      I1 => tmp_product,
      I2 => tmp_product_5,
      O => b_q0(22)
    );
tmp_product_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(21),
      I1 => tmp_product,
      I2 => tmp_product_4,
      O => b_q0(21)
    );
tmp_product_i_13: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(20),
      I1 => tmp_product,
      I2 => tmp_product_3,
      O => b_q0(20)
    );
tmp_product_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(19),
      I1 => tmp_product,
      I2 => tmp_product_2,
      O => b_q0(19)
    );
tmp_product_i_15: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(18),
      I1 => tmp_product,
      I2 => tmp_product_1,
      O => b_q0(18)
    );
tmp_product_i_16: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(17),
      I1 => tmp_product,
      I2 => tmp_product_0,
      O => b_q0(17)
    );
tmp_product_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(31),
      I1 => tmp_product,
      I2 => tmp_product_14,
      O => b_q0(31)
    );
tmp_product_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(30),
      I1 => tmp_product,
      I2 => tmp_product_13,
      O => b_q0(30)
    );
tmp_product_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(29),
      I1 => tmp_product,
      I2 => tmp_product_12,
      O => b_q0(29)
    );
tmp_product_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(28),
      I1 => tmp_product,
      I2 => tmp_product_11,
      O => b_q0(28)
    );
tmp_product_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(27),
      I1 => tmp_product,
      I2 => tmp_product_10,
      O => b_q0(27)
    );
tmp_product_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(26),
      I1 => tmp_product,
      I2 => tmp_product_9,
      O => b_q0(26)
    );
tmp_product_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(25),
      I1 => tmp_product,
      I2 => tmp_product_8,
      O => b_q0(25)
    );
tmp_product_i_9: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^gen_write[1].mem_reg_1\(24),
      I1 => tmp_product,
      I2 => tmp_product_7,
      O => b_q0(24)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1_Multiplier_0 is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    b_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    icmp_ln7_reg_137 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1_Multiplier_0 : entity is "muladd_mul_32s_32s_32_2_1_Multiplier_0";
end design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1_Multiplier_0;

architecture STRUCTURE of design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1_Multiplier_0 is
  signal a_load_reg_1510 : STD_LOGIC;
  signal \mul_ln9_reg_161[19]_i_2_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[19]_i_3_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[19]_i_4_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[23]_i_2_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[23]_i_3_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[23]_i_4_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[23]_i_5_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[27]_i_2_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[27]_i_3_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[27]_i_4_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[27]_i_5_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[31]_i_3_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[31]_i_4_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[31]_i_5_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161[31]_i_6_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[19]_i_1_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[19]_i_1_n_1\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[19]_i_1_n_2\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[19]_i_1_n_3\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[23]_i_1_n_1\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[23]_i_1_n_2\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[23]_i_1_n_3\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[27]_i_1_n_0\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[27]_i_1_n_1\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[27]_i_1_n_2\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[27]_i_1_n_3\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[31]_i_2_n_1\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[31]_i_2_n_2\ : STD_LOGIC;
  signal \mul_ln9_reg_161_reg[31]_i_2_n_3\ : STD_LOGIC;
  signal \p_reg[16]__0_n_0\ : STD_LOGIC;
  signal p_reg_n_100 : STD_LOGIC;
  signal p_reg_n_101 : STD_LOGIC;
  signal p_reg_n_102 : STD_LOGIC;
  signal p_reg_n_103 : STD_LOGIC;
  signal p_reg_n_104 : STD_LOGIC;
  signal p_reg_n_105 : STD_LOGIC;
  signal p_reg_n_58 : STD_LOGIC;
  signal p_reg_n_59 : STD_LOGIC;
  signal p_reg_n_60 : STD_LOGIC;
  signal p_reg_n_61 : STD_LOGIC;
  signal p_reg_n_62 : STD_LOGIC;
  signal p_reg_n_63 : STD_LOGIC;
  signal p_reg_n_64 : STD_LOGIC;
  signal p_reg_n_65 : STD_LOGIC;
  signal p_reg_n_66 : STD_LOGIC;
  signal p_reg_n_67 : STD_LOGIC;
  signal p_reg_n_68 : STD_LOGIC;
  signal p_reg_n_69 : STD_LOGIC;
  signal p_reg_n_70 : STD_LOGIC;
  signal p_reg_n_71 : STD_LOGIC;
  signal p_reg_n_72 : STD_LOGIC;
  signal p_reg_n_73 : STD_LOGIC;
  signal p_reg_n_74 : STD_LOGIC;
  signal p_reg_n_75 : STD_LOGIC;
  signal p_reg_n_76 : STD_LOGIC;
  signal p_reg_n_77 : STD_LOGIC;
  signal p_reg_n_78 : STD_LOGIC;
  signal p_reg_n_79 : STD_LOGIC;
  signal p_reg_n_80 : STD_LOGIC;
  signal p_reg_n_81 : STD_LOGIC;
  signal p_reg_n_82 : STD_LOGIC;
  signal p_reg_n_83 : STD_LOGIC;
  signal p_reg_n_84 : STD_LOGIC;
  signal p_reg_n_85 : STD_LOGIC;
  signal p_reg_n_86 : STD_LOGIC;
  signal p_reg_n_87 : STD_LOGIC;
  signal p_reg_n_88 : STD_LOGIC;
  signal p_reg_n_89 : STD_LOGIC;
  signal p_reg_n_90 : STD_LOGIC;
  signal p_reg_n_91 : STD_LOGIC;
  signal p_reg_n_92 : STD_LOGIC;
  signal p_reg_n_93 : STD_LOGIC;
  signal p_reg_n_94 : STD_LOGIC;
  signal p_reg_n_95 : STD_LOGIC;
  signal p_reg_n_96 : STD_LOGIC;
  signal p_reg_n_97 : STD_LOGIC;
  signal p_reg_n_98 : STD_LOGIC;
  signal p_reg_n_99 : STD_LOGIC;
  signal \tmp_product__0_n_100\ : STD_LOGIC;
  signal \tmp_product__0_n_101\ : STD_LOGIC;
  signal \tmp_product__0_n_102\ : STD_LOGIC;
  signal \tmp_product__0_n_103\ : STD_LOGIC;
  signal \tmp_product__0_n_104\ : STD_LOGIC;
  signal \tmp_product__0_n_105\ : STD_LOGIC;
  signal \tmp_product__0_n_106\ : STD_LOGIC;
  signal \tmp_product__0_n_107\ : STD_LOGIC;
  signal \tmp_product__0_n_108\ : STD_LOGIC;
  signal \tmp_product__0_n_109\ : STD_LOGIC;
  signal \tmp_product__0_n_110\ : STD_LOGIC;
  signal \tmp_product__0_n_111\ : STD_LOGIC;
  signal \tmp_product__0_n_112\ : STD_LOGIC;
  signal \tmp_product__0_n_113\ : STD_LOGIC;
  signal \tmp_product__0_n_114\ : STD_LOGIC;
  signal \tmp_product__0_n_115\ : STD_LOGIC;
  signal \tmp_product__0_n_116\ : STD_LOGIC;
  signal \tmp_product__0_n_117\ : STD_LOGIC;
  signal \tmp_product__0_n_118\ : STD_LOGIC;
  signal \tmp_product__0_n_119\ : STD_LOGIC;
  signal \tmp_product__0_n_120\ : STD_LOGIC;
  signal \tmp_product__0_n_121\ : STD_LOGIC;
  signal \tmp_product__0_n_122\ : STD_LOGIC;
  signal \tmp_product__0_n_123\ : STD_LOGIC;
  signal \tmp_product__0_n_124\ : STD_LOGIC;
  signal \tmp_product__0_n_125\ : STD_LOGIC;
  signal \tmp_product__0_n_126\ : STD_LOGIC;
  signal \tmp_product__0_n_127\ : STD_LOGIC;
  signal \tmp_product__0_n_128\ : STD_LOGIC;
  signal \tmp_product__0_n_129\ : STD_LOGIC;
  signal \tmp_product__0_n_130\ : STD_LOGIC;
  signal \tmp_product__0_n_131\ : STD_LOGIC;
  signal \tmp_product__0_n_132\ : STD_LOGIC;
  signal \tmp_product__0_n_133\ : STD_LOGIC;
  signal \tmp_product__0_n_134\ : STD_LOGIC;
  signal \tmp_product__0_n_135\ : STD_LOGIC;
  signal \tmp_product__0_n_136\ : STD_LOGIC;
  signal \tmp_product__0_n_137\ : STD_LOGIC;
  signal \tmp_product__0_n_138\ : STD_LOGIC;
  signal \tmp_product__0_n_139\ : STD_LOGIC;
  signal \tmp_product__0_n_140\ : STD_LOGIC;
  signal \tmp_product__0_n_141\ : STD_LOGIC;
  signal \tmp_product__0_n_142\ : STD_LOGIC;
  signal \tmp_product__0_n_143\ : STD_LOGIC;
  signal \tmp_product__0_n_144\ : STD_LOGIC;
  signal \tmp_product__0_n_145\ : STD_LOGIC;
  signal \tmp_product__0_n_146\ : STD_LOGIC;
  signal \tmp_product__0_n_147\ : STD_LOGIC;
  signal \tmp_product__0_n_148\ : STD_LOGIC;
  signal \tmp_product__0_n_149\ : STD_LOGIC;
  signal \tmp_product__0_n_150\ : STD_LOGIC;
  signal \tmp_product__0_n_151\ : STD_LOGIC;
  signal \tmp_product__0_n_152\ : STD_LOGIC;
  signal \tmp_product__0_n_153\ : STD_LOGIC;
  signal \tmp_product__0_n_24\ : STD_LOGIC;
  signal \tmp_product__0_n_25\ : STD_LOGIC;
  signal \tmp_product__0_n_26\ : STD_LOGIC;
  signal \tmp_product__0_n_27\ : STD_LOGIC;
  signal \tmp_product__0_n_28\ : STD_LOGIC;
  signal \tmp_product__0_n_29\ : STD_LOGIC;
  signal \tmp_product__0_n_30\ : STD_LOGIC;
  signal \tmp_product__0_n_31\ : STD_LOGIC;
  signal \tmp_product__0_n_32\ : STD_LOGIC;
  signal \tmp_product__0_n_33\ : STD_LOGIC;
  signal \tmp_product__0_n_34\ : STD_LOGIC;
  signal \tmp_product__0_n_35\ : STD_LOGIC;
  signal \tmp_product__0_n_36\ : STD_LOGIC;
  signal \tmp_product__0_n_37\ : STD_LOGIC;
  signal \tmp_product__0_n_38\ : STD_LOGIC;
  signal \tmp_product__0_n_39\ : STD_LOGIC;
  signal \tmp_product__0_n_40\ : STD_LOGIC;
  signal \tmp_product__0_n_41\ : STD_LOGIC;
  signal \tmp_product__0_n_42\ : STD_LOGIC;
  signal \tmp_product__0_n_43\ : STD_LOGIC;
  signal \tmp_product__0_n_44\ : STD_LOGIC;
  signal \tmp_product__0_n_45\ : STD_LOGIC;
  signal \tmp_product__0_n_46\ : STD_LOGIC;
  signal \tmp_product__0_n_47\ : STD_LOGIC;
  signal \tmp_product__0_n_48\ : STD_LOGIC;
  signal \tmp_product__0_n_49\ : STD_LOGIC;
  signal \tmp_product__0_n_50\ : STD_LOGIC;
  signal \tmp_product__0_n_51\ : STD_LOGIC;
  signal \tmp_product__0_n_52\ : STD_LOGIC;
  signal \tmp_product__0_n_53\ : STD_LOGIC;
  signal \tmp_product__0_n_58\ : STD_LOGIC;
  signal \tmp_product__0_n_59\ : STD_LOGIC;
  signal \tmp_product__0_n_60\ : STD_LOGIC;
  signal \tmp_product__0_n_61\ : STD_LOGIC;
  signal \tmp_product__0_n_62\ : STD_LOGIC;
  signal \tmp_product__0_n_63\ : STD_LOGIC;
  signal \tmp_product__0_n_64\ : STD_LOGIC;
  signal \tmp_product__0_n_65\ : STD_LOGIC;
  signal \tmp_product__0_n_66\ : STD_LOGIC;
  signal \tmp_product__0_n_67\ : STD_LOGIC;
  signal \tmp_product__0_n_68\ : STD_LOGIC;
  signal \tmp_product__0_n_69\ : STD_LOGIC;
  signal \tmp_product__0_n_70\ : STD_LOGIC;
  signal \tmp_product__0_n_71\ : STD_LOGIC;
  signal \tmp_product__0_n_72\ : STD_LOGIC;
  signal \tmp_product__0_n_73\ : STD_LOGIC;
  signal \tmp_product__0_n_74\ : STD_LOGIC;
  signal \tmp_product__0_n_75\ : STD_LOGIC;
  signal \tmp_product__0_n_76\ : STD_LOGIC;
  signal \tmp_product__0_n_77\ : STD_LOGIC;
  signal \tmp_product__0_n_78\ : STD_LOGIC;
  signal \tmp_product__0_n_79\ : STD_LOGIC;
  signal \tmp_product__0_n_80\ : STD_LOGIC;
  signal \tmp_product__0_n_81\ : STD_LOGIC;
  signal \tmp_product__0_n_82\ : STD_LOGIC;
  signal \tmp_product__0_n_83\ : STD_LOGIC;
  signal \tmp_product__0_n_84\ : STD_LOGIC;
  signal \tmp_product__0_n_85\ : STD_LOGIC;
  signal \tmp_product__0_n_86\ : STD_LOGIC;
  signal \tmp_product__0_n_87\ : STD_LOGIC;
  signal \tmp_product__0_n_88\ : STD_LOGIC;
  signal \tmp_product__0_n_89\ : STD_LOGIC;
  signal \tmp_product__0_n_90\ : STD_LOGIC;
  signal \tmp_product__0_n_91\ : STD_LOGIC;
  signal \tmp_product__0_n_92\ : STD_LOGIC;
  signal \tmp_product__0_n_93\ : STD_LOGIC;
  signal \tmp_product__0_n_94\ : STD_LOGIC;
  signal \tmp_product__0_n_95\ : STD_LOGIC;
  signal \tmp_product__0_n_96\ : STD_LOGIC;
  signal \tmp_product__0_n_97\ : STD_LOGIC;
  signal \tmp_product__0_n_98\ : STD_LOGIC;
  signal \tmp_product__0_n_99\ : STD_LOGIC;
  signal tmp_product_n_100 : STD_LOGIC;
  signal tmp_product_n_101 : STD_LOGIC;
  signal tmp_product_n_102 : STD_LOGIC;
  signal tmp_product_n_103 : STD_LOGIC;
  signal tmp_product_n_104 : STD_LOGIC;
  signal tmp_product_n_105 : STD_LOGIC;
  signal tmp_product_n_106 : STD_LOGIC;
  signal tmp_product_n_107 : STD_LOGIC;
  signal tmp_product_n_108 : STD_LOGIC;
  signal tmp_product_n_109 : STD_LOGIC;
  signal tmp_product_n_110 : STD_LOGIC;
  signal tmp_product_n_111 : STD_LOGIC;
  signal tmp_product_n_112 : STD_LOGIC;
  signal tmp_product_n_113 : STD_LOGIC;
  signal tmp_product_n_114 : STD_LOGIC;
  signal tmp_product_n_115 : STD_LOGIC;
  signal tmp_product_n_116 : STD_LOGIC;
  signal tmp_product_n_117 : STD_LOGIC;
  signal tmp_product_n_118 : STD_LOGIC;
  signal tmp_product_n_119 : STD_LOGIC;
  signal tmp_product_n_120 : STD_LOGIC;
  signal tmp_product_n_121 : STD_LOGIC;
  signal tmp_product_n_122 : STD_LOGIC;
  signal tmp_product_n_123 : STD_LOGIC;
  signal tmp_product_n_124 : STD_LOGIC;
  signal tmp_product_n_125 : STD_LOGIC;
  signal tmp_product_n_126 : STD_LOGIC;
  signal tmp_product_n_127 : STD_LOGIC;
  signal tmp_product_n_128 : STD_LOGIC;
  signal tmp_product_n_129 : STD_LOGIC;
  signal tmp_product_n_130 : STD_LOGIC;
  signal tmp_product_n_131 : STD_LOGIC;
  signal tmp_product_n_132 : STD_LOGIC;
  signal tmp_product_n_133 : STD_LOGIC;
  signal tmp_product_n_134 : STD_LOGIC;
  signal tmp_product_n_135 : STD_LOGIC;
  signal tmp_product_n_136 : STD_LOGIC;
  signal tmp_product_n_137 : STD_LOGIC;
  signal tmp_product_n_138 : STD_LOGIC;
  signal tmp_product_n_139 : STD_LOGIC;
  signal tmp_product_n_140 : STD_LOGIC;
  signal tmp_product_n_141 : STD_LOGIC;
  signal tmp_product_n_142 : STD_LOGIC;
  signal tmp_product_n_143 : STD_LOGIC;
  signal tmp_product_n_144 : STD_LOGIC;
  signal tmp_product_n_145 : STD_LOGIC;
  signal tmp_product_n_146 : STD_LOGIC;
  signal tmp_product_n_147 : STD_LOGIC;
  signal tmp_product_n_148 : STD_LOGIC;
  signal tmp_product_n_149 : STD_LOGIC;
  signal tmp_product_n_150 : STD_LOGIC;
  signal tmp_product_n_151 : STD_LOGIC;
  signal tmp_product_n_152 : STD_LOGIC;
  signal tmp_product_n_153 : STD_LOGIC;
  signal tmp_product_n_58 : STD_LOGIC;
  signal tmp_product_n_59 : STD_LOGIC;
  signal tmp_product_n_60 : STD_LOGIC;
  signal tmp_product_n_61 : STD_LOGIC;
  signal tmp_product_n_62 : STD_LOGIC;
  signal tmp_product_n_63 : STD_LOGIC;
  signal tmp_product_n_64 : STD_LOGIC;
  signal tmp_product_n_65 : STD_LOGIC;
  signal tmp_product_n_66 : STD_LOGIC;
  signal tmp_product_n_67 : STD_LOGIC;
  signal tmp_product_n_68 : STD_LOGIC;
  signal tmp_product_n_69 : STD_LOGIC;
  signal tmp_product_n_70 : STD_LOGIC;
  signal tmp_product_n_71 : STD_LOGIC;
  signal tmp_product_n_72 : STD_LOGIC;
  signal tmp_product_n_73 : STD_LOGIC;
  signal tmp_product_n_74 : STD_LOGIC;
  signal tmp_product_n_75 : STD_LOGIC;
  signal tmp_product_n_76 : STD_LOGIC;
  signal tmp_product_n_77 : STD_LOGIC;
  signal tmp_product_n_78 : STD_LOGIC;
  signal tmp_product_n_79 : STD_LOGIC;
  signal tmp_product_n_80 : STD_LOGIC;
  signal tmp_product_n_81 : STD_LOGIC;
  signal tmp_product_n_82 : STD_LOGIC;
  signal tmp_product_n_83 : STD_LOGIC;
  signal tmp_product_n_84 : STD_LOGIC;
  signal tmp_product_n_85 : STD_LOGIC;
  signal tmp_product_n_86 : STD_LOGIC;
  signal tmp_product_n_87 : STD_LOGIC;
  signal tmp_product_n_88 : STD_LOGIC;
  signal tmp_product_n_89 : STD_LOGIC;
  signal tmp_product_n_90 : STD_LOGIC;
  signal tmp_product_n_91 : STD_LOGIC;
  signal tmp_product_n_92 : STD_LOGIC;
  signal tmp_product_n_93 : STD_LOGIC;
  signal tmp_product_n_94 : STD_LOGIC;
  signal tmp_product_n_95 : STD_LOGIC;
  signal tmp_product_n_96 : STD_LOGIC;
  signal tmp_product_n_97 : STD_LOGIC;
  signal tmp_product_n_98 : STD_LOGIC;
  signal tmp_product_n_99 : STD_LOGIC;
  signal \NLW_mul_ln9_reg_161_reg[31]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal NLW_p_reg_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_p_reg_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_p_reg_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_p_reg_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_p_reg_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_p_reg_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_p_reg_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_p_reg_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_p_reg_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_p_reg_PCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal NLW_tmp_product_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_tmp_product_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_tmp_product_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_tmp_product_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_tmp_product_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_tmp_product_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_tmp_product_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_tmp_product_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_tmp_product_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_tmp_product__0_CARRYCASCOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_tmp_product__0_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_tmp_product__0_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_tmp_product__0_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_tmp_product__0_PATTERNDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_tmp_product__0_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_tmp_product__0_BCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \NLW_tmp_product__0_CARRYOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \mul_ln9_reg_161_reg[19]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \mul_ln9_reg_161_reg[23]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \mul_ln9_reg_161_reg[27]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \mul_ln9_reg_161_reg[31]_i_2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of p_reg : label is "{SYNTH-10 {cell *THIS*} {string 18x15 4}}";
  attribute METHODOLOGY_DRC_VIOS of tmp_product : label is "{SYNTH-10 {cell *THIS*} {string 15x18 4}}";
  attribute METHODOLOGY_DRC_VIOS of \tmp_product__0\ : label is "{SYNTH-10 {cell *THIS*} {string 18x18 4}}";
begin
\mul_ln9_reg_161[19]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_103,
      I1 => tmp_product_n_103,
      O => \mul_ln9_reg_161[19]_i_2_n_0\
    );
\mul_ln9_reg_161[19]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_104,
      I1 => tmp_product_n_104,
      O => \mul_ln9_reg_161[19]_i_3_n_0\
    );
\mul_ln9_reg_161[19]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_105,
      I1 => tmp_product_n_105,
      O => \mul_ln9_reg_161[19]_i_4_n_0\
    );
\mul_ln9_reg_161[23]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_99,
      I1 => tmp_product_n_99,
      O => \mul_ln9_reg_161[23]_i_2_n_0\
    );
\mul_ln9_reg_161[23]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_100,
      I1 => tmp_product_n_100,
      O => \mul_ln9_reg_161[23]_i_3_n_0\
    );
\mul_ln9_reg_161[23]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_101,
      I1 => tmp_product_n_101,
      O => \mul_ln9_reg_161[23]_i_4_n_0\
    );
\mul_ln9_reg_161[23]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_102,
      I1 => tmp_product_n_102,
      O => \mul_ln9_reg_161[23]_i_5_n_0\
    );
\mul_ln9_reg_161[27]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_95,
      I1 => tmp_product_n_95,
      O => \mul_ln9_reg_161[27]_i_2_n_0\
    );
\mul_ln9_reg_161[27]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_96,
      I1 => tmp_product_n_96,
      O => \mul_ln9_reg_161[27]_i_3_n_0\
    );
\mul_ln9_reg_161[27]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_97,
      I1 => tmp_product_n_97,
      O => \mul_ln9_reg_161[27]_i_4_n_0\
    );
\mul_ln9_reg_161[27]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_98,
      I1 => tmp_product_n_98,
      O => \mul_ln9_reg_161[27]_i_5_n_0\
    );
\mul_ln9_reg_161[31]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_91,
      I1 => tmp_product_n_91,
      O => \mul_ln9_reg_161[31]_i_3_n_0\
    );
\mul_ln9_reg_161[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_92,
      I1 => tmp_product_n_92,
      O => \mul_ln9_reg_161[31]_i_4_n_0\
    );
\mul_ln9_reg_161[31]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_93,
      I1 => tmp_product_n_93,
      O => \mul_ln9_reg_161[31]_i_5_n_0\
    );
\mul_ln9_reg_161[31]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => p_reg_n_94,
      I1 => tmp_product_n_94,
      O => \mul_ln9_reg_161[31]_i_6_n_0\
    );
\mul_ln9_reg_161_reg[19]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \mul_ln9_reg_161_reg[19]_i_1_n_0\,
      CO(2) => \mul_ln9_reg_161_reg[19]_i_1_n_1\,
      CO(1) => \mul_ln9_reg_161_reg[19]_i_1_n_2\,
      CO(0) => \mul_ln9_reg_161_reg[19]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => p_reg_n_103,
      DI(2) => p_reg_n_104,
      DI(1) => p_reg_n_105,
      DI(0) => '0',
      O(3 downto 0) => D(19 downto 16),
      S(3) => \mul_ln9_reg_161[19]_i_2_n_0\,
      S(2) => \mul_ln9_reg_161[19]_i_3_n_0\,
      S(1) => \mul_ln9_reg_161[19]_i_4_n_0\,
      S(0) => \p_reg[16]__0_n_0\
    );
\mul_ln9_reg_161_reg[23]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \mul_ln9_reg_161_reg[19]_i_1_n_0\,
      CO(3) => \mul_ln9_reg_161_reg[23]_i_1_n_0\,
      CO(2) => \mul_ln9_reg_161_reg[23]_i_1_n_1\,
      CO(1) => \mul_ln9_reg_161_reg[23]_i_1_n_2\,
      CO(0) => \mul_ln9_reg_161_reg[23]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => p_reg_n_99,
      DI(2) => p_reg_n_100,
      DI(1) => p_reg_n_101,
      DI(0) => p_reg_n_102,
      O(3 downto 0) => D(23 downto 20),
      S(3) => \mul_ln9_reg_161[23]_i_2_n_0\,
      S(2) => \mul_ln9_reg_161[23]_i_3_n_0\,
      S(1) => \mul_ln9_reg_161[23]_i_4_n_0\,
      S(0) => \mul_ln9_reg_161[23]_i_5_n_0\
    );
\mul_ln9_reg_161_reg[27]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \mul_ln9_reg_161_reg[23]_i_1_n_0\,
      CO(3) => \mul_ln9_reg_161_reg[27]_i_1_n_0\,
      CO(2) => \mul_ln9_reg_161_reg[27]_i_1_n_1\,
      CO(1) => \mul_ln9_reg_161_reg[27]_i_1_n_2\,
      CO(0) => \mul_ln9_reg_161_reg[27]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => p_reg_n_95,
      DI(2) => p_reg_n_96,
      DI(1) => p_reg_n_97,
      DI(0) => p_reg_n_98,
      O(3 downto 0) => D(27 downto 24),
      S(3) => \mul_ln9_reg_161[27]_i_2_n_0\,
      S(2) => \mul_ln9_reg_161[27]_i_3_n_0\,
      S(1) => \mul_ln9_reg_161[27]_i_4_n_0\,
      S(0) => \mul_ln9_reg_161[27]_i_5_n_0\
    );
\mul_ln9_reg_161_reg[31]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \mul_ln9_reg_161_reg[27]_i_1_n_0\,
      CO(3) => \NLW_mul_ln9_reg_161_reg[31]_i_2_CO_UNCONNECTED\(3),
      CO(2) => \mul_ln9_reg_161_reg[31]_i_2_n_1\,
      CO(1) => \mul_ln9_reg_161_reg[31]_i_2_n_2\,
      CO(0) => \mul_ln9_reg_161_reg[31]_i_2_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => p_reg_n_92,
      DI(1) => p_reg_n_93,
      DI(0) => p_reg_n_94,
      O(3 downto 0) => D(31 downto 28),
      S(3) => \mul_ln9_reg_161[31]_i_3_n_0\,
      S(2) => \mul_ln9_reg_161[31]_i_4_n_0\,
      S(1) => \mul_ln9_reg_161[31]_i_5_n_0\,
      S(0) => \mul_ln9_reg_161[31]_i_6_n_0\
    );
p_reg: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "CASCADE",
      BCASCREG => 1,
      BREG => 1,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 0) => B"000000000000000000000000000000",
      ACIN(29) => \tmp_product__0_n_24\,
      ACIN(28) => \tmp_product__0_n_25\,
      ACIN(27) => \tmp_product__0_n_26\,
      ACIN(26) => \tmp_product__0_n_27\,
      ACIN(25) => \tmp_product__0_n_28\,
      ACIN(24) => \tmp_product__0_n_29\,
      ACIN(23) => \tmp_product__0_n_30\,
      ACIN(22) => \tmp_product__0_n_31\,
      ACIN(21) => \tmp_product__0_n_32\,
      ACIN(20) => \tmp_product__0_n_33\,
      ACIN(19) => \tmp_product__0_n_34\,
      ACIN(18) => \tmp_product__0_n_35\,
      ACIN(17) => \tmp_product__0_n_36\,
      ACIN(16) => \tmp_product__0_n_37\,
      ACIN(15) => \tmp_product__0_n_38\,
      ACIN(14) => \tmp_product__0_n_39\,
      ACIN(13) => \tmp_product__0_n_40\,
      ACIN(12) => \tmp_product__0_n_41\,
      ACIN(11) => \tmp_product__0_n_42\,
      ACIN(10) => \tmp_product__0_n_43\,
      ACIN(9) => \tmp_product__0_n_44\,
      ACIN(8) => \tmp_product__0_n_45\,
      ACIN(7) => \tmp_product__0_n_46\,
      ACIN(6) => \tmp_product__0_n_47\,
      ACIN(5) => \tmp_product__0_n_48\,
      ACIN(4) => \tmp_product__0_n_49\,
      ACIN(3) => \tmp_product__0_n_50\,
      ACIN(2) => \tmp_product__0_n_51\,
      ACIN(1) => \tmp_product__0_n_52\,
      ACIN(0) => \tmp_product__0_n_53\,
      ACOUT(29 downto 0) => NLW_p_reg_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => a_q0(31),
      B(16) => a_q0(31),
      B(15) => a_q0(31),
      B(14 downto 0) => a_q0(31 downto 17),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_p_reg_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_p_reg_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_p_reg_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => a_load_reg_1510,
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '1',
      CLK => ap_clk,
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_p_reg_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"1010101",
      OVERFLOW => NLW_p_reg_OVERFLOW_UNCONNECTED,
      P(47) => p_reg_n_58,
      P(46) => p_reg_n_59,
      P(45) => p_reg_n_60,
      P(44) => p_reg_n_61,
      P(43) => p_reg_n_62,
      P(42) => p_reg_n_63,
      P(41) => p_reg_n_64,
      P(40) => p_reg_n_65,
      P(39) => p_reg_n_66,
      P(38) => p_reg_n_67,
      P(37) => p_reg_n_68,
      P(36) => p_reg_n_69,
      P(35) => p_reg_n_70,
      P(34) => p_reg_n_71,
      P(33) => p_reg_n_72,
      P(32) => p_reg_n_73,
      P(31) => p_reg_n_74,
      P(30) => p_reg_n_75,
      P(29) => p_reg_n_76,
      P(28) => p_reg_n_77,
      P(27) => p_reg_n_78,
      P(26) => p_reg_n_79,
      P(25) => p_reg_n_80,
      P(24) => p_reg_n_81,
      P(23) => p_reg_n_82,
      P(22) => p_reg_n_83,
      P(21) => p_reg_n_84,
      P(20) => p_reg_n_85,
      P(19) => p_reg_n_86,
      P(18) => p_reg_n_87,
      P(17) => p_reg_n_88,
      P(16) => p_reg_n_89,
      P(15) => p_reg_n_90,
      P(14) => p_reg_n_91,
      P(13) => p_reg_n_92,
      P(12) => p_reg_n_93,
      P(11) => p_reg_n_94,
      P(10) => p_reg_n_95,
      P(9) => p_reg_n_96,
      P(8) => p_reg_n_97,
      P(7) => p_reg_n_98,
      P(6) => p_reg_n_99,
      P(5) => p_reg_n_100,
      P(4) => p_reg_n_101,
      P(3) => p_reg_n_102,
      P(2) => p_reg_n_103,
      P(1) => p_reg_n_104,
      P(0) => p_reg_n_105,
      PATTERNBDETECT => NLW_p_reg_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_p_reg_PATTERNDETECT_UNCONNECTED,
      PCIN(47) => \tmp_product__0_n_106\,
      PCIN(46) => \tmp_product__0_n_107\,
      PCIN(45) => \tmp_product__0_n_108\,
      PCIN(44) => \tmp_product__0_n_109\,
      PCIN(43) => \tmp_product__0_n_110\,
      PCIN(42) => \tmp_product__0_n_111\,
      PCIN(41) => \tmp_product__0_n_112\,
      PCIN(40) => \tmp_product__0_n_113\,
      PCIN(39) => \tmp_product__0_n_114\,
      PCIN(38) => \tmp_product__0_n_115\,
      PCIN(37) => \tmp_product__0_n_116\,
      PCIN(36) => \tmp_product__0_n_117\,
      PCIN(35) => \tmp_product__0_n_118\,
      PCIN(34) => \tmp_product__0_n_119\,
      PCIN(33) => \tmp_product__0_n_120\,
      PCIN(32) => \tmp_product__0_n_121\,
      PCIN(31) => \tmp_product__0_n_122\,
      PCIN(30) => \tmp_product__0_n_123\,
      PCIN(29) => \tmp_product__0_n_124\,
      PCIN(28) => \tmp_product__0_n_125\,
      PCIN(27) => \tmp_product__0_n_126\,
      PCIN(26) => \tmp_product__0_n_127\,
      PCIN(25) => \tmp_product__0_n_128\,
      PCIN(24) => \tmp_product__0_n_129\,
      PCIN(23) => \tmp_product__0_n_130\,
      PCIN(22) => \tmp_product__0_n_131\,
      PCIN(21) => \tmp_product__0_n_132\,
      PCIN(20) => \tmp_product__0_n_133\,
      PCIN(19) => \tmp_product__0_n_134\,
      PCIN(18) => \tmp_product__0_n_135\,
      PCIN(17) => \tmp_product__0_n_136\,
      PCIN(16) => \tmp_product__0_n_137\,
      PCIN(15) => \tmp_product__0_n_138\,
      PCIN(14) => \tmp_product__0_n_139\,
      PCIN(13) => \tmp_product__0_n_140\,
      PCIN(12) => \tmp_product__0_n_141\,
      PCIN(11) => \tmp_product__0_n_142\,
      PCIN(10) => \tmp_product__0_n_143\,
      PCIN(9) => \tmp_product__0_n_144\,
      PCIN(8) => \tmp_product__0_n_145\,
      PCIN(7) => \tmp_product__0_n_146\,
      PCIN(6) => \tmp_product__0_n_147\,
      PCIN(5) => \tmp_product__0_n_148\,
      PCIN(4) => \tmp_product__0_n_149\,
      PCIN(3) => \tmp_product__0_n_150\,
      PCIN(2) => \tmp_product__0_n_151\,
      PCIN(1) => \tmp_product__0_n_152\,
      PCIN(0) => \tmp_product__0_n_153\,
      PCOUT(47 downto 0) => NLW_p_reg_PCOUT_UNCONNECTED(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_p_reg_UNDERFLOW_UNCONNECTED
    );
\p_reg[0]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_105\,
      Q => D(0),
      R => '0'
    );
\p_reg[10]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_95\,
      Q => D(10),
      R => '0'
    );
\p_reg[11]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_94\,
      Q => D(11),
      R => '0'
    );
\p_reg[12]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_93\,
      Q => D(12),
      R => '0'
    );
\p_reg[13]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_92\,
      Q => D(13),
      R => '0'
    );
\p_reg[14]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_91\,
      Q => D(14),
      R => '0'
    );
\p_reg[15]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_90\,
      Q => D(15),
      R => '0'
    );
\p_reg[16]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_89\,
      Q => \p_reg[16]__0_n_0\,
      R => '0'
    );
\p_reg[1]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_104\,
      Q => D(1),
      R => '0'
    );
\p_reg[2]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_103\,
      Q => D(2),
      R => '0'
    );
\p_reg[3]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_102\,
      Q => D(3),
      R => '0'
    );
\p_reg[4]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_101\,
      Q => D(4),
      R => '0'
    );
\p_reg[5]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_100\,
      Q => D(5),
      R => '0'
    );
\p_reg[6]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_99\,
      Q => D(6),
      R => '0'
    );
\p_reg[7]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_98\,
      Q => D(7),
      R => '0'
    );
\p_reg[8]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_97\,
      Q => D(8),
      R => '0'
    );
\p_reg[9]__0\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \tmp_product__0_n_96\,
      Q => D(9),
      R => '0'
    );
tmp_product: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 1,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 1,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 1,
      BREG => 1,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 17) => B"0000000000000",
      A(16 downto 0) => a_q0(16 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_tmp_product_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => b_q0(31),
      B(16) => b_q0(31),
      B(15) => b_q0(31),
      B(14 downto 0) => b_q0(31 downto 17),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_tmp_product_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_tmp_product_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_tmp_product_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => a_load_reg_1510,
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => a_load_reg_1510,
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '1',
      CLK => ap_clk,
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_tmp_product_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_tmp_product_OVERFLOW_UNCONNECTED,
      P(47) => tmp_product_n_58,
      P(46) => tmp_product_n_59,
      P(45) => tmp_product_n_60,
      P(44) => tmp_product_n_61,
      P(43) => tmp_product_n_62,
      P(42) => tmp_product_n_63,
      P(41) => tmp_product_n_64,
      P(40) => tmp_product_n_65,
      P(39) => tmp_product_n_66,
      P(38) => tmp_product_n_67,
      P(37) => tmp_product_n_68,
      P(36) => tmp_product_n_69,
      P(35) => tmp_product_n_70,
      P(34) => tmp_product_n_71,
      P(33) => tmp_product_n_72,
      P(32) => tmp_product_n_73,
      P(31) => tmp_product_n_74,
      P(30) => tmp_product_n_75,
      P(29) => tmp_product_n_76,
      P(28) => tmp_product_n_77,
      P(27) => tmp_product_n_78,
      P(26) => tmp_product_n_79,
      P(25) => tmp_product_n_80,
      P(24) => tmp_product_n_81,
      P(23) => tmp_product_n_82,
      P(22) => tmp_product_n_83,
      P(21) => tmp_product_n_84,
      P(20) => tmp_product_n_85,
      P(19) => tmp_product_n_86,
      P(18) => tmp_product_n_87,
      P(17) => tmp_product_n_88,
      P(16) => tmp_product_n_89,
      P(15) => tmp_product_n_90,
      P(14) => tmp_product_n_91,
      P(13) => tmp_product_n_92,
      P(12) => tmp_product_n_93,
      P(11) => tmp_product_n_94,
      P(10) => tmp_product_n_95,
      P(9) => tmp_product_n_96,
      P(8) => tmp_product_n_97,
      P(7) => tmp_product_n_98,
      P(6) => tmp_product_n_99,
      P(5) => tmp_product_n_100,
      P(4) => tmp_product_n_101,
      P(3) => tmp_product_n_102,
      P(2) => tmp_product_n_103,
      P(1) => tmp_product_n_104,
      P(0) => tmp_product_n_105,
      PATTERNBDETECT => NLW_tmp_product_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_tmp_product_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47) => tmp_product_n_106,
      PCOUT(46) => tmp_product_n_107,
      PCOUT(45) => tmp_product_n_108,
      PCOUT(44) => tmp_product_n_109,
      PCOUT(43) => tmp_product_n_110,
      PCOUT(42) => tmp_product_n_111,
      PCOUT(41) => tmp_product_n_112,
      PCOUT(40) => tmp_product_n_113,
      PCOUT(39) => tmp_product_n_114,
      PCOUT(38) => tmp_product_n_115,
      PCOUT(37) => tmp_product_n_116,
      PCOUT(36) => tmp_product_n_117,
      PCOUT(35) => tmp_product_n_118,
      PCOUT(34) => tmp_product_n_119,
      PCOUT(33) => tmp_product_n_120,
      PCOUT(32) => tmp_product_n_121,
      PCOUT(31) => tmp_product_n_122,
      PCOUT(30) => tmp_product_n_123,
      PCOUT(29) => tmp_product_n_124,
      PCOUT(28) => tmp_product_n_125,
      PCOUT(27) => tmp_product_n_126,
      PCOUT(26) => tmp_product_n_127,
      PCOUT(25) => tmp_product_n_128,
      PCOUT(24) => tmp_product_n_129,
      PCOUT(23) => tmp_product_n_130,
      PCOUT(22) => tmp_product_n_131,
      PCOUT(21) => tmp_product_n_132,
      PCOUT(20) => tmp_product_n_133,
      PCOUT(19) => tmp_product_n_134,
      PCOUT(18) => tmp_product_n_135,
      PCOUT(17) => tmp_product_n_136,
      PCOUT(16) => tmp_product_n_137,
      PCOUT(15) => tmp_product_n_138,
      PCOUT(14) => tmp_product_n_139,
      PCOUT(13) => tmp_product_n_140,
      PCOUT(12) => tmp_product_n_141,
      PCOUT(11) => tmp_product_n_142,
      PCOUT(10) => tmp_product_n_143,
      PCOUT(9) => tmp_product_n_144,
      PCOUT(8) => tmp_product_n_145,
      PCOUT(7) => tmp_product_n_146,
      PCOUT(6) => tmp_product_n_147,
      PCOUT(5) => tmp_product_n_148,
      PCOUT(4) => tmp_product_n_149,
      PCOUT(3) => tmp_product_n_150,
      PCOUT(2) => tmp_product_n_151,
      PCOUT(1) => tmp_product_n_152,
      PCOUT(0) => tmp_product_n_153,
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_tmp_product_UNDERFLOW_UNCONNECTED
    );
\tmp_product__0\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 1,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 1,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 1,
      BREG => 1,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 17) => B"0000000000000",
      A(16 downto 0) => b_q0(16 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29) => \tmp_product__0_n_24\,
      ACOUT(28) => \tmp_product__0_n_25\,
      ACOUT(27) => \tmp_product__0_n_26\,
      ACOUT(26) => \tmp_product__0_n_27\,
      ACOUT(25) => \tmp_product__0_n_28\,
      ACOUT(24) => \tmp_product__0_n_29\,
      ACOUT(23) => \tmp_product__0_n_30\,
      ACOUT(22) => \tmp_product__0_n_31\,
      ACOUT(21) => \tmp_product__0_n_32\,
      ACOUT(20) => \tmp_product__0_n_33\,
      ACOUT(19) => \tmp_product__0_n_34\,
      ACOUT(18) => \tmp_product__0_n_35\,
      ACOUT(17) => \tmp_product__0_n_36\,
      ACOUT(16) => \tmp_product__0_n_37\,
      ACOUT(15) => \tmp_product__0_n_38\,
      ACOUT(14) => \tmp_product__0_n_39\,
      ACOUT(13) => \tmp_product__0_n_40\,
      ACOUT(12) => \tmp_product__0_n_41\,
      ACOUT(11) => \tmp_product__0_n_42\,
      ACOUT(10) => \tmp_product__0_n_43\,
      ACOUT(9) => \tmp_product__0_n_44\,
      ACOUT(8) => \tmp_product__0_n_45\,
      ACOUT(7) => \tmp_product__0_n_46\,
      ACOUT(6) => \tmp_product__0_n_47\,
      ACOUT(5) => \tmp_product__0_n_48\,
      ACOUT(4) => \tmp_product__0_n_49\,
      ACOUT(3) => \tmp_product__0_n_50\,
      ACOUT(2) => \tmp_product__0_n_51\,
      ACOUT(1) => \tmp_product__0_n_52\,
      ACOUT(0) => \tmp_product__0_n_53\,
      ALUMODE(3 downto 0) => B"0000",
      B(17) => '0',
      B(16 downto 0) => a_q0(16 downto 0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => \NLW_tmp_product__0_BCOUT_UNCONNECTED\(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => \NLW_tmp_product__0_CARRYCASCOUT_UNCONNECTED\,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => \NLW_tmp_product__0_CARRYOUT_UNCONNECTED\(3 downto 0),
      CEA1 => '0',
      CEA2 => a_load_reg_1510,
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => a_load_reg_1510,
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => ap_clk,
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => \NLW_tmp_product__0_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => \NLW_tmp_product__0_OVERFLOW_UNCONNECTED\,
      P(47) => \tmp_product__0_n_58\,
      P(46) => \tmp_product__0_n_59\,
      P(45) => \tmp_product__0_n_60\,
      P(44) => \tmp_product__0_n_61\,
      P(43) => \tmp_product__0_n_62\,
      P(42) => \tmp_product__0_n_63\,
      P(41) => \tmp_product__0_n_64\,
      P(40) => \tmp_product__0_n_65\,
      P(39) => \tmp_product__0_n_66\,
      P(38) => \tmp_product__0_n_67\,
      P(37) => \tmp_product__0_n_68\,
      P(36) => \tmp_product__0_n_69\,
      P(35) => \tmp_product__0_n_70\,
      P(34) => \tmp_product__0_n_71\,
      P(33) => \tmp_product__0_n_72\,
      P(32) => \tmp_product__0_n_73\,
      P(31) => \tmp_product__0_n_74\,
      P(30) => \tmp_product__0_n_75\,
      P(29) => \tmp_product__0_n_76\,
      P(28) => \tmp_product__0_n_77\,
      P(27) => \tmp_product__0_n_78\,
      P(26) => \tmp_product__0_n_79\,
      P(25) => \tmp_product__0_n_80\,
      P(24) => \tmp_product__0_n_81\,
      P(23) => \tmp_product__0_n_82\,
      P(22) => \tmp_product__0_n_83\,
      P(21) => \tmp_product__0_n_84\,
      P(20) => \tmp_product__0_n_85\,
      P(19) => \tmp_product__0_n_86\,
      P(18) => \tmp_product__0_n_87\,
      P(17) => \tmp_product__0_n_88\,
      P(16) => \tmp_product__0_n_89\,
      P(15) => \tmp_product__0_n_90\,
      P(14) => \tmp_product__0_n_91\,
      P(13) => \tmp_product__0_n_92\,
      P(12) => \tmp_product__0_n_93\,
      P(11) => \tmp_product__0_n_94\,
      P(10) => \tmp_product__0_n_95\,
      P(9) => \tmp_product__0_n_96\,
      P(8) => \tmp_product__0_n_97\,
      P(7) => \tmp_product__0_n_98\,
      P(6) => \tmp_product__0_n_99\,
      P(5) => \tmp_product__0_n_100\,
      P(4) => \tmp_product__0_n_101\,
      P(3) => \tmp_product__0_n_102\,
      P(2) => \tmp_product__0_n_103\,
      P(1) => \tmp_product__0_n_104\,
      P(0) => \tmp_product__0_n_105\,
      PATTERNBDETECT => \NLW_tmp_product__0_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \NLW_tmp_product__0_PATTERNDETECT_UNCONNECTED\,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47) => \tmp_product__0_n_106\,
      PCOUT(46) => \tmp_product__0_n_107\,
      PCOUT(45) => \tmp_product__0_n_108\,
      PCOUT(44) => \tmp_product__0_n_109\,
      PCOUT(43) => \tmp_product__0_n_110\,
      PCOUT(42) => \tmp_product__0_n_111\,
      PCOUT(41) => \tmp_product__0_n_112\,
      PCOUT(40) => \tmp_product__0_n_113\,
      PCOUT(39) => \tmp_product__0_n_114\,
      PCOUT(38) => \tmp_product__0_n_115\,
      PCOUT(37) => \tmp_product__0_n_116\,
      PCOUT(36) => \tmp_product__0_n_117\,
      PCOUT(35) => \tmp_product__0_n_118\,
      PCOUT(34) => \tmp_product__0_n_119\,
      PCOUT(33) => \tmp_product__0_n_120\,
      PCOUT(32) => \tmp_product__0_n_121\,
      PCOUT(31) => \tmp_product__0_n_122\,
      PCOUT(30) => \tmp_product__0_n_123\,
      PCOUT(29) => \tmp_product__0_n_124\,
      PCOUT(28) => \tmp_product__0_n_125\,
      PCOUT(27) => \tmp_product__0_n_126\,
      PCOUT(26) => \tmp_product__0_n_127\,
      PCOUT(25) => \tmp_product__0_n_128\,
      PCOUT(24) => \tmp_product__0_n_129\,
      PCOUT(23) => \tmp_product__0_n_130\,
      PCOUT(22) => \tmp_product__0_n_131\,
      PCOUT(21) => \tmp_product__0_n_132\,
      PCOUT(20) => \tmp_product__0_n_133\,
      PCOUT(19) => \tmp_product__0_n_134\,
      PCOUT(18) => \tmp_product__0_n_135\,
      PCOUT(17) => \tmp_product__0_n_136\,
      PCOUT(16) => \tmp_product__0_n_137\,
      PCOUT(15) => \tmp_product__0_n_138\,
      PCOUT(14) => \tmp_product__0_n_139\,
      PCOUT(13) => \tmp_product__0_n_140\,
      PCOUT(12) => \tmp_product__0_n_141\,
      PCOUT(11) => \tmp_product__0_n_142\,
      PCOUT(10) => \tmp_product__0_n_143\,
      PCOUT(9) => \tmp_product__0_n_144\,
      PCOUT(8) => \tmp_product__0_n_145\,
      PCOUT(7) => \tmp_product__0_n_146\,
      PCOUT(6) => \tmp_product__0_n_147\,
      PCOUT(5) => \tmp_product__0_n_148\,
      PCOUT(4) => \tmp_product__0_n_149\,
      PCOUT(3) => \tmp_product__0_n_150\,
      PCOUT(2) => \tmp_product__0_n_151\,
      PCOUT(1) => \tmp_product__0_n_152\,
      PCOUT(0) => \tmp_product__0_n_153\,
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => \NLW_tmp_product__0_UNDERFLOW_UNCONNECTED\
    );
tmp_product_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Q(0),
      I1 => icmp_ln7_reg_137,
      O => a_load_reg_1510
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_muladd_0_0_muladd_control_s_axi is
  port (
    DOADO : out STD_LOGIC_VECTOR ( 31 downto 0 );
    DOBDO : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \gen_write[1].mem_reg\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \gen_write[1].mem_reg_0\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_rst_n_inv : out STD_LOGIC;
    a_q0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    int_a_write_reg_0 : out STD_LOGIC;
    \FSM_onehot_rstate_reg[1]_0\ : out STD_LOGIC;
    int_b_write_reg_0 : out STD_LOGIC;
    b_q0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \FSM_onehot_wstate_reg[1]_0\ : out STD_LOGIC;
    s_axi_control_BVALID : out STD_LOGIC;
    s_axi_control_WREADY : out STD_LOGIC;
    s_axi_control_RVALID : out STD_LOGIC;
    interrupt : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \ap_CS_fsm_reg[1]\ : out STD_LOGIC;
    ap_NS_fsm1 : out STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    int_ap_ready_reg_0 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \rdata_reg[31]_0\ : in STD_LOGIC;
    \rdata_reg[0]_0\ : in STD_LOGIC;
    \rdata_reg[1]_0\ : in STD_LOGIC;
    \rdata_reg[2]_0\ : in STD_LOGIC;
    \rdata_reg[3]_0\ : in STD_LOGIC;
    \rdata_reg[4]_0\ : in STD_LOGIC;
    \rdata_reg[5]_0\ : in STD_LOGIC;
    \rdata_reg[6]_0\ : in STD_LOGIC;
    \rdata_reg[7]_0\ : in STD_LOGIC;
    \rdata_reg[8]_0\ : in STD_LOGIC;
    \rdata_reg[9]_0\ : in STD_LOGIC;
    \rdata_reg[10]_0\ : in STD_LOGIC;
    \rdata_reg[11]_0\ : in STD_LOGIC;
    \rdata_reg[12]_0\ : in STD_LOGIC;
    \rdata_reg[13]_0\ : in STD_LOGIC;
    \rdata_reg[14]_0\ : in STD_LOGIC;
    \rdata_reg[15]_0\ : in STD_LOGIC;
    \rdata_reg[16]_0\ : in STD_LOGIC;
    \rdata_reg[17]_0\ : in STD_LOGIC;
    \rdata_reg[18]_0\ : in STD_LOGIC;
    \rdata_reg[19]_0\ : in STD_LOGIC;
    \rdata_reg[20]_0\ : in STD_LOGIC;
    \rdata_reg[21]_0\ : in STD_LOGIC;
    \rdata_reg[22]_0\ : in STD_LOGIC;
    \rdata_reg[23]_0\ : in STD_LOGIC;
    \rdata_reg[24]_0\ : in STD_LOGIC;
    \rdata_reg[25]_0\ : in STD_LOGIC;
    \rdata_reg[26]_0\ : in STD_LOGIC;
    \rdata_reg[27]_0\ : in STD_LOGIC;
    \rdata_reg[28]_0\ : in STD_LOGIC;
    \rdata_reg[29]_0\ : in STD_LOGIC;
    \rdata_reg[30]_0\ : in STD_LOGIC;
    \rdata_reg[31]_1\ : in STD_LOGIC;
    tmp_product : in STD_LOGIC;
    \tmp_product__0\ : in STD_LOGIC;
    \tmp_product__0_0\ : in STD_LOGIC;
    \tmp_product__0_1\ : in STD_LOGIC;
    \tmp_product__0_2\ : in STD_LOGIC;
    \tmp_product__0_3\ : in STD_LOGIC;
    \tmp_product__0_4\ : in STD_LOGIC;
    \tmp_product__0_5\ : in STD_LOGIC;
    \tmp_product__0_6\ : in STD_LOGIC;
    \tmp_product__0_7\ : in STD_LOGIC;
    \tmp_product__0_8\ : in STD_LOGIC;
    \tmp_product__0_9\ : in STD_LOGIC;
    \tmp_product__0_10\ : in STD_LOGIC;
    \tmp_product__0_11\ : in STD_LOGIC;
    \tmp_product__0_12\ : in STD_LOGIC;
    \tmp_product__0_13\ : in STD_LOGIC;
    \tmp_product__0_14\ : in STD_LOGIC;
    \tmp_product__0_15\ : in STD_LOGIC;
    p_reg : in STD_LOGIC;
    p_reg_0 : in STD_LOGIC;
    p_reg_1 : in STD_LOGIC;
    p_reg_2 : in STD_LOGIC;
    p_reg_3 : in STD_LOGIC;
    p_reg_4 : in STD_LOGIC;
    p_reg_5 : in STD_LOGIC;
    p_reg_6 : in STD_LOGIC;
    p_reg_7 : in STD_LOGIC;
    p_reg_8 : in STD_LOGIC;
    p_reg_9 : in STD_LOGIC;
    p_reg_10 : in STD_LOGIC;
    p_reg_11 : in STD_LOGIC;
    p_reg_12 : in STD_LOGIC;
    p_reg_13 : in STD_LOGIC;
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_ARVALID : in STD_LOGIC;
    \rdata_reg[31]_2\ : in STD_LOGIC;
    \rdata_reg[0]_1\ : in STD_LOGIC;
    \rdata_reg[1]_1\ : in STD_LOGIC;
    \rdata_reg[2]_1\ : in STD_LOGIC;
    \rdata_reg[3]_1\ : in STD_LOGIC;
    \rdata_reg[4]_1\ : in STD_LOGIC;
    \rdata_reg[5]_1\ : in STD_LOGIC;
    \rdata_reg[6]_1\ : in STD_LOGIC;
    \rdata_reg[7]_1\ : in STD_LOGIC;
    \rdata_reg[8]_1\ : in STD_LOGIC;
    \rdata_reg[9]_1\ : in STD_LOGIC;
    \rdata_reg[10]_1\ : in STD_LOGIC;
    \rdata_reg[11]_1\ : in STD_LOGIC;
    \rdata_reg[12]_1\ : in STD_LOGIC;
    \rdata_reg[13]_1\ : in STD_LOGIC;
    \rdata_reg[14]_1\ : in STD_LOGIC;
    \rdata_reg[15]_1\ : in STD_LOGIC;
    \rdata_reg[16]_1\ : in STD_LOGIC;
    \rdata_reg[17]_1\ : in STD_LOGIC;
    \rdata_reg[18]_1\ : in STD_LOGIC;
    \rdata_reg[19]_1\ : in STD_LOGIC;
    \rdata_reg[20]_1\ : in STD_LOGIC;
    \rdata_reg[21]_1\ : in STD_LOGIC;
    \rdata_reg[22]_1\ : in STD_LOGIC;
    \rdata_reg[23]_1\ : in STD_LOGIC;
    \rdata_reg[24]_1\ : in STD_LOGIC;
    \rdata_reg[25]_1\ : in STD_LOGIC;
    \rdata_reg[26]_1\ : in STD_LOGIC;
    \rdata_reg[27]_1\ : in STD_LOGIC;
    \rdata_reg[28]_1\ : in STD_LOGIC;
    \rdata_reg[29]_1\ : in STD_LOGIC;
    \rdata_reg[30]_1\ : in STD_LOGIC;
    \rdata_reg[31]_3\ : in STD_LOGIC;
    \tmp_product__0_16\ : in STD_LOGIC;
    \tmp_product__0_17\ : in STD_LOGIC;
    \tmp_product__0_18\ : in STD_LOGIC;
    \tmp_product__0_19\ : in STD_LOGIC;
    \tmp_product__0_20\ : in STD_LOGIC;
    \tmp_product__0_21\ : in STD_LOGIC;
    \tmp_product__0_22\ : in STD_LOGIC;
    \tmp_product__0_23\ : in STD_LOGIC;
    \tmp_product__0_24\ : in STD_LOGIC;
    \tmp_product__0_25\ : in STD_LOGIC;
    \tmp_product__0_26\ : in STD_LOGIC;
    \tmp_product__0_27\ : in STD_LOGIC;
    \tmp_product__0_28\ : in STD_LOGIC;
    \tmp_product__0_29\ : in STD_LOGIC;
    \tmp_product__0_30\ : in STD_LOGIC;
    \tmp_product__0_31\ : in STD_LOGIC;
    \tmp_product__0_32\ : in STD_LOGIC;
    tmp_product_0 : in STD_LOGIC;
    tmp_product_1 : in STD_LOGIC;
    tmp_product_2 : in STD_LOGIC;
    tmp_product_3 : in STD_LOGIC;
    tmp_product_4 : in STD_LOGIC;
    tmp_product_5 : in STD_LOGIC;
    tmp_product_6 : in STD_LOGIC;
    tmp_product_7 : in STD_LOGIC;
    tmp_product_8 : in STD_LOGIC;
    tmp_product_9 : in STD_LOGIC;
    tmp_product_10 : in STD_LOGIC;
    tmp_product_11 : in STD_LOGIC;
    tmp_product_12 : in STD_LOGIC;
    tmp_product_13 : in STD_LOGIC;
    tmp_product_14 : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_control_RREADY : in STD_LOGIC;
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ap_enable_reg_pp0_iter2 : in STD_LOGIC;
    ap_enable_reg_pp0_iter3 : in STD_LOGIC;
    icmp_ln7_fu_111_p2 : in STD_LOGIC;
    ap_enable_reg_pp0_iter0 : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \int_ap_return_reg[31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_muladd_0_0_muladd_control_s_axi : entity is "muladd_control_s_axi";
end design_1_muladd_0_0_muladd_control_s_axi;

architecture STRUCTURE of design_1_muladd_0_0_muladd_control_s_axi is
  signal \FSM_onehot_rstate[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_rstate[2]_i_1_n_0\ : STD_LOGIC;
  signal \^fsm_onehot_rstate_reg[1]_0\ : STD_LOGIC;
  signal \FSM_onehot_rstate_reg_n_0_[2]\ : STD_LOGIC;
  signal \FSM_onehot_wstate[1]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate[3]_i_1_n_0\ : STD_LOGIC;
  signal \^fsm_onehot_wstate_reg[1]_0\ : STD_LOGIC;
  signal \FSM_onehot_wstate_reg_n_0_[2]\ : STD_LOGIC;
  signal ap_idle : STD_LOGIC;
  signal \^ap_rst_n_inv\ : STD_LOGIC;
  signal ap_start : STD_LOGIC;
  signal aw_hs : STD_LOGIC;
  signal int_a_address1 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal int_a_read : STD_LOGIC;
  signal int_a_read0 : STD_LOGIC;
  signal int_a_write_i_1_n_0 : STD_LOGIC;
  signal int_a_write_i_2_n_0 : STD_LOGIC;
  signal int_a_write_reg_n_0 : STD_LOGIC;
  signal int_ap_done : STD_LOGIC;
  signal int_ap_done_i_1_n_0 : STD_LOGIC;
  signal int_ap_done_i_2_n_0 : STD_LOGIC;
  signal int_ap_idle : STD_LOGIC;
  signal int_ap_ready : STD_LOGIC;
  signal int_ap_return : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal int_ap_start3_out : STD_LOGIC;
  signal int_ap_start_i_1_n_0 : STD_LOGIC;
  signal int_auto_restart : STD_LOGIC;
  signal int_auto_restart_i_1_n_0 : STD_LOGIC;
  signal int_auto_restart_i_2_n_0 : STD_LOGIC;
  signal int_b_q1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal int_b_read : STD_LOGIC;
  signal int_b_read0 : STD_LOGIC;
  signal int_b_write_i_1_n_0 : STD_LOGIC;
  signal int_b_write_reg_n_0 : STD_LOGIC;
  signal int_gie_i_1_n_0 : STD_LOGIC;
  signal int_gie_reg_n_0 : STD_LOGIC;
  signal \int_ier[0]_i_1_n_0\ : STD_LOGIC;
  signal \int_ier[1]_i_1_n_0\ : STD_LOGIC;
  signal \int_ier[1]_i_2_n_0\ : STD_LOGIC;
  signal \int_ier[1]_i_3_n_0\ : STD_LOGIC;
  signal \int_ier_reg_n_0_[0]\ : STD_LOGIC;
  signal \int_ier_reg_n_0_[1]\ : STD_LOGIC;
  signal int_isr6_out : STD_LOGIC;
  signal \int_isr[0]_i_1_n_0\ : STD_LOGIC;
  signal \int_isr[1]_i_1_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal p_1_in0_in : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \rdata[0]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[0]_i_7_n_0\ : STD_LOGIC;
  signal \rdata[10]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[11]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[12]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[13]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[14]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[15]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[16]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[17]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[18]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[19]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_2_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_5_n_0\ : STD_LOGIC;
  signal \rdata[1]_i_6_n_0\ : STD_LOGIC;
  signal \rdata[20]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[21]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[22]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[23]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[24]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[25]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[26]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[27]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[28]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[29]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[2]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[30]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_10_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_11_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_1_n_0\ : STD_LOGIC;
  signal \rdata[31]_i_5_n_0\ : STD_LOGIC;
  signal \rdata[3]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[4]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[5]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[6]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[7]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[8]_i_4_n_0\ : STD_LOGIC;
  signal \rdata[9]_i_4_n_0\ : STD_LOGIC;
  signal \^s_axi_control_bvalid\ : STD_LOGIC;
  signal \waddr_reg_n_0_[0]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[1]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[2]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[3]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[4]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[5]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[6]\ : STD_LOGIC;
  signal \waddr_reg_n_0_[7]\ : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_rstate_reg[1]\ : label is "RDIDLE:010,RDDATA:100,iSTATE:001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_rstate_reg[2]\ : label is "RDIDLE:010,RDDATA:100,iSTATE:001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[1]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[2]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_wstate_reg[3]\ : label is "WRDATA:0100,WRRESP:1000,WRIDLE:0010,iSTATE:0001";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ap_CS_fsm[1]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of int_a_read_i_1 : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of int_a_write_i_2 : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of int_ap_done_i_2 : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of int_ap_idle_i_1 : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of int_ap_start_i_1 : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of int_ap_start_i_2 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of int_b_read_i_1 : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of int_gie_i_1 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \int_ier[1]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \int_isr[0]_i_2\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \rdata[31]_i_11\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \rdata[31]_i_12\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \rdata[31]_i_13\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of s_axi_control_WREADY_INST_0 : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \temp_reg_93[0]_i_1\ : label is "soft_lutpair34";
begin
  \FSM_onehot_rstate_reg[1]_0\ <= \^fsm_onehot_rstate_reg[1]_0\;
  \FSM_onehot_wstate_reg[1]_0\ <= \^fsm_onehot_wstate_reg[1]_0\;
  ap_rst_n_inv <= \^ap_rst_n_inv\;
  s_axi_control_BVALID <= \^s_axi_control_bvalid\;
\FSM_onehot_rstate[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55555555000CFFFF"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => s_axi_control_RREADY,
      I2 => int_b_read,
      I3 => int_a_read,
      I4 => \FSM_onehot_rstate_reg_n_0_[2]\,
      I5 => \^fsm_onehot_rstate_reg[1]_0\,
      O => \FSM_onehot_rstate[1]_i_1_n_0\
    );
\FSM_onehot_rstate[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEAEEEE44404444"
    )
        port map (
      I0 => \^fsm_onehot_rstate_reg[1]_0\,
      I1 => \FSM_onehot_rstate_reg_n_0_[2]\,
      I2 => int_a_read,
      I3 => int_b_read,
      I4 => s_axi_control_RREADY,
      I5 => s_axi_control_ARVALID,
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
      R => \^ap_rst_n_inv\
    );
\FSM_onehot_rstate_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_rstate[2]_i_1_n_0\,
      Q => \FSM_onehot_rstate_reg_n_0_[2]\,
      R => \^ap_rst_n_inv\
    );
\FSM_onehot_wstate[1]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => ap_rst_n,
      O => \^ap_rst_n_inv\
    );
\FSM_onehot_wstate[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BA30BA3F"
    )
        port map (
      I0 => s_axi_control_BREADY,
      I1 => s_axi_control_AWVALID,
      I2 => \^fsm_onehot_wstate_reg[1]_0\,
      I3 => \^s_axi_control_bvalid\,
      I4 => \FSM_onehot_wstate_reg_n_0_[2]\,
      O => \FSM_onehot_wstate[1]_i_2_n_0\
    );
\FSM_onehot_wstate[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8888888FFFF8888"
    )
        port map (
      I0 => \^fsm_onehot_wstate_reg[1]_0\,
      I1 => s_axi_control_AWVALID,
      I2 => s_axi_control_ARVALID,
      I3 => \^fsm_onehot_rstate_reg[1]_0\,
      I4 => \FSM_onehot_wstate_reg_n_0_[2]\,
      I5 => s_axi_control_WVALID,
      O => \FSM_onehot_wstate[2]_i_1_n_0\
    );
\FSM_onehot_wstate[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08880888FFFF0888"
    )
        port map (
      I0 => s_axi_control_WVALID,
      I1 => \FSM_onehot_wstate_reg_n_0_[2]\,
      I2 => \^fsm_onehot_rstate_reg[1]_0\,
      I3 => s_axi_control_ARVALID,
      I4 => \^s_axi_control_bvalid\,
      I5 => s_axi_control_BREADY,
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
      R => \^ap_rst_n_inv\
    );
\FSM_onehot_wstate_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \FSM_onehot_wstate[2]_i_1_n_0\,
      Q => \FSM_onehot_wstate_reg_n_0_[2]\,
      R => \^ap_rst_n_inv\
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
      R => \^ap_rst_n_inv\
    );
\ap_CS_fsm[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4555"
    )
        port map (
      I0 => int_ap_ready_reg_0(1),
      I1 => int_ap_ready_reg_0(2),
      I2 => int_ap_ready_reg_0(0),
      I3 => ap_start,
      O => D(0)
    );
\ap_CS_fsm[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FBFBF000"
    )
        port map (
      I0 => ap_enable_reg_pp0_iter2,
      I1 => ap_enable_reg_pp0_iter3,
      I2 => int_ap_ready_reg_0(0),
      I3 => ap_start,
      I4 => int_ap_ready_reg_0(1),
      O => D(1)
    );
ap_enable_reg_pp0_iter0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7777700000000000"
    )
        port map (
      I0 => icmp_ln7_fu_111_p2,
      I1 => int_ap_ready_reg_0(1),
      I2 => ap_start,
      I3 => int_ap_ready_reg_0(0),
      I4 => ap_enable_reg_pp0_iter0,
      I5 => ap_rst_n,
      O => \ap_CS_fsm_reg[1]\
    );
int_a: entity work.design_1_muladd_0_0_muladd_control_s_axi_ram
     port map (
      ADDRARDADDR(3 downto 0) => int_a_address1(3 downto 0),
      D(31 downto 0) => p_0_in(31 downto 0),
      DOADO(31 downto 0) => DOADO(31 downto 0),
      DOBDO(31 downto 0) => DOBDO(31 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      a_q0(31 downto 0) => a_q0(31 downto 0),
      ap_clk => ap_clk,
      \gen_write[1].mem_reg_0\ => \^fsm_onehot_rstate_reg[1]_0\,
      \gen_write[1].mem_reg_1\ => int_a_write_reg_n_0,
      \gen_write[1].mem_reg_2\ => \FSM_onehot_wstate_reg_n_0_[2]\,
      int_a_read => int_a_read,
      int_b_q1(31 downto 0) => int_b_q1(31 downto 0),
      p_reg => tmp_product,
      p_reg_0 => p_reg,
      p_reg_1 => p_reg_0,
      p_reg_10 => p_reg_9,
      p_reg_11 => p_reg_10,
      p_reg_12 => p_reg_11,
      p_reg_13 => p_reg_12,
      p_reg_14 => p_reg_13,
      p_reg_2 => p_reg_1,
      p_reg_3 => p_reg_2,
      p_reg_4 => p_reg_3,
      p_reg_5 => p_reg_4,
      p_reg_6 => p_reg_5,
      p_reg_7 => p_reg_6,
      p_reg_8 => p_reg_7,
      p_reg_9 => p_reg_8,
      \rdata_reg[0]\ => \rdata_reg[0]_0\,
      \rdata_reg[0]_0\ => \rdata[0]_i_4_n_0\,
      \rdata_reg[10]\ => \rdata_reg[10]_0\,
      \rdata_reg[10]_0\ => \rdata[10]_i_4_n_0\,
      \rdata_reg[11]\ => \rdata_reg[11]_0\,
      \rdata_reg[11]_0\ => \rdata[11]_i_4_n_0\,
      \rdata_reg[12]\ => \rdata_reg[12]_0\,
      \rdata_reg[12]_0\ => \rdata[12]_i_4_n_0\,
      \rdata_reg[13]\ => \rdata_reg[13]_0\,
      \rdata_reg[13]_0\ => \rdata[13]_i_4_n_0\,
      \rdata_reg[14]\ => \rdata_reg[14]_0\,
      \rdata_reg[14]_0\ => \rdata[14]_i_4_n_0\,
      \rdata_reg[15]\ => \rdata_reg[15]_0\,
      \rdata_reg[15]_0\ => \rdata[15]_i_4_n_0\,
      \rdata_reg[16]\ => \rdata_reg[16]_0\,
      \rdata_reg[16]_0\ => \rdata[16]_i_4_n_0\,
      \rdata_reg[17]\ => \rdata_reg[17]_0\,
      \rdata_reg[17]_0\ => \rdata[17]_i_4_n_0\,
      \rdata_reg[18]\ => \rdata_reg[18]_0\,
      \rdata_reg[18]_0\ => \rdata[18]_i_4_n_0\,
      \rdata_reg[19]\ => \rdata_reg[19]_0\,
      \rdata_reg[19]_0\ => \rdata[19]_i_4_n_0\,
      \rdata_reg[1]\ => \rdata_reg[1]_0\,
      \rdata_reg[1]_0\ => \rdata[1]_i_2_n_0\,
      \rdata_reg[20]\ => \rdata_reg[20]_0\,
      \rdata_reg[20]_0\ => \rdata[20]_i_4_n_0\,
      \rdata_reg[21]\ => \rdata_reg[21]_0\,
      \rdata_reg[21]_0\ => \rdata[21]_i_4_n_0\,
      \rdata_reg[22]\ => \rdata_reg[22]_0\,
      \rdata_reg[22]_0\ => \rdata[22]_i_4_n_0\,
      \rdata_reg[23]\ => \rdata_reg[23]_0\,
      \rdata_reg[23]_0\ => \rdata[23]_i_4_n_0\,
      \rdata_reg[24]\ => \rdata_reg[24]_0\,
      \rdata_reg[24]_0\ => \rdata[24]_i_4_n_0\,
      \rdata_reg[25]\ => \rdata_reg[25]_0\,
      \rdata_reg[25]_0\ => \rdata[25]_i_4_n_0\,
      \rdata_reg[26]\ => \rdata_reg[26]_0\,
      \rdata_reg[26]_0\ => \rdata[26]_i_4_n_0\,
      \rdata_reg[27]\ => \rdata_reg[27]_0\,
      \rdata_reg[27]_0\ => \rdata[27]_i_4_n_0\,
      \rdata_reg[28]\ => \rdata_reg[28]_0\,
      \rdata_reg[28]_0\ => \rdata[28]_i_4_n_0\,
      \rdata_reg[29]\ => \rdata_reg[29]_0\,
      \rdata_reg[29]_0\ => \rdata[29]_i_4_n_0\,
      \rdata_reg[2]\ => \rdata_reg[2]_0\,
      \rdata_reg[2]_0\ => \rdata[2]_i_4_n_0\,
      \rdata_reg[30]\ => \rdata_reg[30]_0\,
      \rdata_reg[30]_0\ => \rdata[30]_i_4_n_0\,
      \rdata_reg[31]\ => \rdata_reg[31]_0\,
      \rdata_reg[31]_0\ => \rdata_reg[31]_1\,
      \rdata_reg[31]_1\ => \rdata[31]_i_5_n_0\,
      \rdata_reg[3]\ => \rdata_reg[3]_0\,
      \rdata_reg[3]_0\ => \rdata[3]_i_4_n_0\,
      \rdata_reg[4]\ => \rdata_reg[4]_0\,
      \rdata_reg[4]_0\ => \rdata[4]_i_4_n_0\,
      \rdata_reg[5]\ => \rdata_reg[5]_0\,
      \rdata_reg[5]_0\ => \rdata[5]_i_4_n_0\,
      \rdata_reg[6]\ => \rdata_reg[6]_0\,
      \rdata_reg[6]_0\ => \rdata[6]_i_4_n_0\,
      \rdata_reg[7]\ => \rdata_reg[7]_0\,
      \rdata_reg[7]_0\ => \rdata[7]_i_4_n_0\,
      \rdata_reg[8]\ => \rdata_reg[8]_0\,
      \rdata_reg[8]_0\ => \rdata[8]_i_4_n_0\,
      \rdata_reg[9]\ => \rdata_reg[9]_0\,
      \rdata_reg[9]_0\ => \rdata[9]_i_4_n_0\,
      s_axi_control_ARVALID => s_axi_control_ARVALID,
      s_axi_control_WDATA(31 downto 0) => s_axi_control_WDATA(31 downto 0),
      s_axi_control_WSTRB(3 downto 0) => s_axi_control_WSTRB(3 downto 0),
      s_axi_control_WVALID => s_axi_control_WVALID,
      \tmp_product__0\ => \tmp_product__0\,
      \tmp_product__0_0\ => \tmp_product__0_0\,
      \tmp_product__0_1\ => \tmp_product__0_1\,
      \tmp_product__0_10\ => \tmp_product__0_10\,
      \tmp_product__0_11\ => \tmp_product__0_11\,
      \tmp_product__0_12\ => \tmp_product__0_12\,
      \tmp_product__0_13\ => \tmp_product__0_13\,
      \tmp_product__0_14\ => \tmp_product__0_14\,
      \tmp_product__0_15\ => \tmp_product__0_15\,
      \tmp_product__0_2\ => \tmp_product__0_2\,
      \tmp_product__0_3\ => \tmp_product__0_3\,
      \tmp_product__0_4\ => \tmp_product__0_4\,
      \tmp_product__0_5\ => \tmp_product__0_5\,
      \tmp_product__0_6\ => \tmp_product__0_6\,
      \tmp_product__0_7\ => \tmp_product__0_7\,
      \tmp_product__0_8\ => \tmp_product__0_8\,
      \tmp_product__0_9\ => \tmp_product__0_9\
    );
int_a_read_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => s_axi_control_ARADDR(7),
      I1 => s_axi_control_ARADDR(6),
      I2 => \^fsm_onehot_rstate_reg[1]_0\,
      I3 => s_axi_control_ARVALID,
      O => int_a_read0
    );
int_a_read_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => int_a_read0,
      Q => int_a_read,
      R => \^ap_rst_n_inv\
    );
int_a_write_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF400040004000"
    )
        port map (
      I0 => s_axi_control_AWADDR(7),
      I1 => s_axi_control_AWADDR(6),
      I2 => s_axi_control_AWVALID,
      I3 => \^fsm_onehot_wstate_reg[1]_0\,
      I4 => int_a_write_i_2_n_0,
      I5 => int_a_write_reg_n_0,
      O => int_a_write_i_1_n_0
    );
int_a_write_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8FFF"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => \^fsm_onehot_rstate_reg[1]_0\,
      I2 => \FSM_onehot_wstate_reg_n_0_[2]\,
      I3 => s_axi_control_WVALID,
      O => int_a_write_i_2_n_0
    );
int_a_write_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => int_a_write_i_1_n_0,
      Q => int_a_write_reg_n_0,
      R => \^ap_rst_n_inv\
    );
int_ap_done_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEAA"
    )
        port map (
      I0 => int_ap_ready_reg_0(2),
      I1 => int_ap_done_i_2_n_0,
      I2 => s_axi_control_ARADDR(4),
      I3 => int_ap_done,
      O => int_ap_done_i_1_n_0
    );
int_ap_done_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFF7"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => \^fsm_onehot_rstate_reg[1]_0\,
      I2 => s_axi_control_ARADDR(2),
      I3 => \rdata[31]_i_10_n_0\,
      O => int_ap_done_i_2_n_0
    );
int_ap_done_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => int_ap_done_i_1_n_0,
      Q => int_ap_done,
      R => \^ap_rst_n_inv\
    );
int_ap_idle_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => int_ap_ready_reg_0(0),
      I1 => ap_start,
      O => ap_idle
    );
int_ap_idle_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => ap_idle,
      Q => int_ap_idle,
      R => \^ap_rst_n_inv\
    );
int_ap_ready_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => int_ap_ready_reg_0(2),
      Q => int_ap_ready,
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(0),
      Q => int_ap_return(0),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(10),
      Q => int_ap_return(10),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(11),
      Q => int_ap_return(11),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(12),
      Q => int_ap_return(12),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(13),
      Q => int_ap_return(13),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(14),
      Q => int_ap_return(14),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(15),
      Q => int_ap_return(15),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(16),
      Q => int_ap_return(16),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(17),
      Q => int_ap_return(17),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(18),
      Q => int_ap_return(18),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(19),
      Q => int_ap_return(19),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(1),
      Q => int_ap_return(1),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(20),
      Q => int_ap_return(20),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(21),
      Q => int_ap_return(21),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(22),
      Q => int_ap_return(22),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(23),
      Q => int_ap_return(23),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(24),
      Q => int_ap_return(24),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(25),
      Q => int_ap_return(25),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(26),
      Q => int_ap_return(26),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(27),
      Q => int_ap_return(27),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(28),
      Q => int_ap_return(28),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(29),
      Q => int_ap_return(29),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(2),
      Q => int_ap_return(2),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(30),
      Q => int_ap_return(30),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(31),
      Q => int_ap_return(31),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(3),
      Q => int_ap_return(3),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(4),
      Q => int_ap_return(4),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(5),
      Q => int_ap_return(5),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(6),
      Q => int_ap_return(6),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(7),
      Q => int_ap_return(7),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(8),
      Q => int_ap_return(8),
      R => \^ap_rst_n_inv\
    );
\int_ap_return_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => int_ap_ready_reg_0(2),
      D => \int_ap_return_reg[31]_0\(9),
      Q => int_ap_return(9),
      R => \^ap_rst_n_inv\
    );
int_ap_start_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FBF8"
    )
        port map (
      I0 => int_auto_restart,
      I1 => int_ap_ready_reg_0(2),
      I2 => int_ap_start3_out,
      I3 => ap_start,
      O => int_ap_start_i_1_n_0
    );
int_ap_start_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2000"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => \waddr_reg_n_0_[2]\,
      I2 => s_axi_control_WSTRB(0),
      I3 => int_auto_restart_i_2_n_0,
      O => int_ap_start3_out
    );
int_ap_start_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => int_ap_start_i_1_n_0,
      Q => ap_start,
      R => \^ap_rst_n_inv\
    );
int_auto_restart_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFBF0080"
    )
        port map (
      I0 => s_axi_control_WDATA(7),
      I1 => int_auto_restart_i_2_n_0,
      I2 => s_axi_control_WSTRB(0),
      I3 => \waddr_reg_n_0_[2]\,
      I4 => int_auto_restart,
      O => int_auto_restart_i_1_n_0
    );
int_auto_restart_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0111000000000000"
    )
        port map (
      I0 => \waddr_reg_n_0_[3]\,
      I1 => \int_ier[1]_i_3_n_0\,
      I2 => s_axi_control_ARVALID,
      I3 => \^fsm_onehot_rstate_reg[1]_0\,
      I4 => \FSM_onehot_wstate_reg_n_0_[2]\,
      I5 => s_axi_control_WVALID,
      O => int_auto_restart_i_2_n_0
    );
int_auto_restart_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => int_auto_restart_i_1_n_0,
      Q => int_auto_restart,
      R => \^ap_rst_n_inv\
    );
int_b: entity work.design_1_muladd_0_0_muladd_control_s_axi_ram_0
     port map (
      ADDRARDADDR(3 downto 0) => int_a_address1(3 downto 0),
      Q(3 downto 0) => Q(3 downto 0),
      ap_clk => ap_clk,
      b_q0(31 downto 0) => b_q0(31 downto 0),
      \gen_write[1].mem_reg_0\(31 downto 0) => \gen_write[1].mem_reg\(31 downto 0),
      \gen_write[1].mem_reg_1\(31 downto 0) => \gen_write[1].mem_reg_0\(31 downto 0),
      \gen_write[1].mem_reg_2\(3) => \waddr_reg_n_0_[5]\,
      \gen_write[1].mem_reg_2\(2) => \waddr_reg_n_0_[4]\,
      \gen_write[1].mem_reg_2\(1) => \waddr_reg_n_0_[3]\,
      \gen_write[1].mem_reg_2\(0) => \waddr_reg_n_0_[2]\,
      \gen_write[1].mem_reg_3\ => \^fsm_onehot_rstate_reg[1]_0\,
      \gen_write[1].mem_reg_4\ => int_b_write_reg_n_0,
      \gen_write[1].mem_reg_5\ => \FSM_onehot_wstate_reg_n_0_[2]\,
      int_b_q1(31 downto 0) => int_b_q1(31 downto 0),
      \rdata_reg[0]\ => \rdata_reg[0]_1\,
      \rdata_reg[10]\ => \rdata_reg[10]_1\,
      \rdata_reg[11]\ => \rdata_reg[11]_1\,
      \rdata_reg[12]\ => \rdata_reg[12]_1\,
      \rdata_reg[13]\ => \rdata_reg[13]_1\,
      \rdata_reg[14]\ => \rdata_reg[14]_1\,
      \rdata_reg[15]\ => \rdata_reg[15]_1\,
      \rdata_reg[16]\ => \rdata_reg[16]_1\,
      \rdata_reg[17]\ => \rdata_reg[17]_1\,
      \rdata_reg[18]\ => \rdata_reg[18]_1\,
      \rdata_reg[19]\ => \rdata_reg[19]_1\,
      \rdata_reg[1]\ => \rdata_reg[1]_1\,
      \rdata_reg[20]\ => \rdata_reg[20]_1\,
      \rdata_reg[21]\ => \rdata_reg[21]_1\,
      \rdata_reg[22]\ => \rdata_reg[22]_1\,
      \rdata_reg[23]\ => \rdata_reg[23]_1\,
      \rdata_reg[24]\ => \rdata_reg[24]_1\,
      \rdata_reg[25]\ => \rdata_reg[25]_1\,
      \rdata_reg[26]\ => \rdata_reg[26]_1\,
      \rdata_reg[27]\ => \rdata_reg[27]_1\,
      \rdata_reg[28]\ => \rdata_reg[28]_1\,
      \rdata_reg[29]\ => \rdata_reg[29]_1\,
      \rdata_reg[2]\ => \rdata_reg[2]_1\,
      \rdata_reg[30]\ => \rdata_reg[30]_1\,
      \rdata_reg[31]\ => \rdata_reg[31]_2\,
      \rdata_reg[31]_0\ => \rdata_reg[31]_3\,
      \rdata_reg[3]\ => \rdata_reg[3]_1\,
      \rdata_reg[4]\ => \rdata_reg[4]_1\,
      \rdata_reg[5]\ => \rdata_reg[5]_1\,
      \rdata_reg[6]\ => \rdata_reg[6]_1\,
      \rdata_reg[7]\ => \rdata_reg[7]_1\,
      \rdata_reg[8]\ => \rdata_reg[8]_1\,
      \rdata_reg[9]\ => \rdata_reg[9]_1\,
      s_axi_control_ARADDR(3 downto 0) => s_axi_control_ARADDR(5 downto 2),
      s_axi_control_ARVALID => s_axi_control_ARVALID,
      s_axi_control_WDATA(31 downto 0) => s_axi_control_WDATA(31 downto 0),
      s_axi_control_WSTRB(3 downto 0) => s_axi_control_WSTRB(3 downto 0),
      s_axi_control_WVALID => s_axi_control_WVALID,
      tmp_product => tmp_product,
      tmp_product_0 => tmp_product_0,
      tmp_product_1 => tmp_product_1,
      tmp_product_10 => tmp_product_10,
      tmp_product_11 => tmp_product_11,
      tmp_product_12 => tmp_product_12,
      tmp_product_13 => tmp_product_13,
      tmp_product_14 => tmp_product_14,
      tmp_product_2 => tmp_product_2,
      tmp_product_3 => tmp_product_3,
      tmp_product_4 => tmp_product_4,
      tmp_product_5 => tmp_product_5,
      tmp_product_6 => tmp_product_6,
      tmp_product_7 => tmp_product_7,
      tmp_product_8 => tmp_product_8,
      tmp_product_9 => tmp_product_9,
      \tmp_product__0\ => \tmp_product__0_16\,
      \tmp_product__0_0\ => \tmp_product__0_17\,
      \tmp_product__0_1\ => \tmp_product__0_18\,
      \tmp_product__0_10\ => \tmp_product__0_27\,
      \tmp_product__0_11\ => \tmp_product__0_28\,
      \tmp_product__0_12\ => \tmp_product__0_29\,
      \tmp_product__0_13\ => \tmp_product__0_30\,
      \tmp_product__0_14\ => \tmp_product__0_31\,
      \tmp_product__0_15\ => \tmp_product__0_32\,
      \tmp_product__0_2\ => \tmp_product__0_19\,
      \tmp_product__0_3\ => \tmp_product__0_20\,
      \tmp_product__0_4\ => \tmp_product__0_21\,
      \tmp_product__0_5\ => \tmp_product__0_22\,
      \tmp_product__0_6\ => \tmp_product__0_23\,
      \tmp_product__0_7\ => \tmp_product__0_24\,
      \tmp_product__0_8\ => \tmp_product__0_25\,
      \tmp_product__0_9\ => \tmp_product__0_26\
    );
int_b_read_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => s_axi_control_ARADDR(6),
      I1 => s_axi_control_ARADDR(7),
      I2 => \^fsm_onehot_rstate_reg[1]_0\,
      I3 => s_axi_control_ARVALID,
      O => int_b_read0
    );
int_b_read_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => int_b_read0,
      Q => int_b_read,
      R => \^ap_rst_n_inv\
    );
int_b_write_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF400040004000"
    )
        port map (
      I0 => s_axi_control_AWADDR(6),
      I1 => s_axi_control_AWADDR(7),
      I2 => s_axi_control_AWVALID,
      I3 => \^fsm_onehot_wstate_reg[1]_0\,
      I4 => int_a_write_i_2_n_0,
      I5 => int_b_write_reg_n_0,
      O => int_b_write_i_1_n_0
    );
int_b_write_reg: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => int_b_write_i_1_n_0,
      Q => int_b_write_reg_n_0,
      R => \^ap_rst_n_inv\
    );
int_gie_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BFFF8000"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => int_auto_restart_i_2_n_0,
      I2 => \waddr_reg_n_0_[2]\,
      I3 => s_axi_control_WSTRB(0),
      I4 => int_gie_reg_n_0,
      O => int_gie_i_1_n_0
    );
int_gie_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => int_gie_i_1_n_0,
      Q => int_gie_reg_n_0,
      R => \^ap_rst_n_inv\
    );
\int_ier[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => s_axi_control_WSTRB(0),
      I2 => \waddr_reg_n_0_[2]\,
      I3 => \int_ier[1]_i_2_n_0\,
      I4 => \int_ier_reg_n_0_[0]\,
      O => \int_ier[0]_i_1_n_0\
    );
\int_ier[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFB0008"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => s_axi_control_WSTRB(0),
      I2 => \waddr_reg_n_0_[2]\,
      I3 => \int_ier[1]_i_2_n_0\,
      I4 => \int_ier_reg_n_0_[1]\,
      O => \int_ier[1]_i_1_n_0\
    );
\int_ier[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EAFFFFFFFFFFFFFF"
    )
        port map (
      I0 => \int_ier[1]_i_3_n_0\,
      I1 => s_axi_control_ARVALID,
      I2 => \^fsm_onehot_rstate_reg[1]_0\,
      I3 => \FSM_onehot_wstate_reg_n_0_[2]\,
      I4 => s_axi_control_WVALID,
      I5 => \waddr_reg_n_0_[3]\,
      O => \int_ier[1]_i_2_n_0\
    );
\int_ier[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \waddr_reg_n_0_[7]\,
      I1 => \waddr_reg_n_0_[1]\,
      I2 => \waddr_reg_n_0_[0]\,
      I3 => \waddr_reg_n_0_[6]\,
      I4 => \waddr_reg_n_0_[4]\,
      I5 => \waddr_reg_n_0_[5]\,
      O => \int_ier[1]_i_3_n_0\
    );
\int_ier_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \int_ier[0]_i_1_n_0\,
      Q => \int_ier_reg_n_0_[0]\,
      R => \^ap_rst_n_inv\
    );
\int_ier_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \int_ier[1]_i_1_n_0\,
      Q => \int_ier_reg_n_0_[1]\,
      R => \^ap_rst_n_inv\
    );
\int_isr[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F777F888"
    )
        port map (
      I0 => s_axi_control_WDATA(0),
      I1 => int_isr6_out,
      I2 => \int_ier_reg_n_0_[0]\,
      I3 => int_ap_ready_reg_0(2),
      I4 => p_1_in0_in(0),
      O => \int_isr[0]_i_1_n_0\
    );
\int_isr[0]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \waddr_reg_n_0_[2]\,
      I1 => s_axi_control_WSTRB(0),
      I2 => \int_ier[1]_i_2_n_0\,
      O => int_isr6_out
    );
\int_isr[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F777F888"
    )
        port map (
      I0 => s_axi_control_WDATA(1),
      I1 => int_isr6_out,
      I2 => \int_ier_reg_n_0_[1]\,
      I3 => int_ap_ready_reg_0(2),
      I4 => p_1_in0_in(1),
      O => \int_isr[1]_i_1_n_0\
    );
\int_isr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \int_isr[0]_i_1_n_0\,
      Q => p_1_in0_in(0),
      R => \^ap_rst_n_inv\
    );
\int_isr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => \int_isr[1]_i_1_n_0\,
      Q => p_1_in0_in(1),
      R => \^ap_rst_n_inv\
    );
interrupt_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
        port map (
      I0 => int_gie_reg_n_0,
      I1 => p_1_in0_in(1),
      I2 => p_1_in0_in(0),
      O => interrupt
    );
\rdata[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000222E2222"
    )
        port map (
      I0 => \rdata[0]_i_7_n_0\,
      I1 => s_axi_control_ARADDR(4),
      I2 => s_axi_control_ARADDR(2),
      I3 => s_axi_control_ARADDR(3),
      I4 => int_ap_return(0),
      I5 => \rdata[1]_i_5_n_0\,
      O => \rdata[0]_i_4_n_0\
    );
\rdata[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => p_1_in0_in(0),
      I1 => \int_ier_reg_n_0_[0]\,
      I2 => s_axi_control_ARADDR(3),
      I3 => int_gie_reg_n_0,
      I4 => s_axi_control_ARADDR(2),
      I5 => ap_start,
      O => \rdata[0]_i_7_n_0\
    );
\rdata[10]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(10),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[10]_i_4_n_0\
    );
\rdata[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(11),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[11]_i_4_n_0\
    );
\rdata[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(12),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[12]_i_4_n_0\
    );
\rdata[13]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(13),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[13]_i_4_n_0\
    );
\rdata[14]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(14),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[14]_i_4_n_0\
    );
\rdata[15]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(15),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[15]_i_4_n_0\
    );
\rdata[16]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(16),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[16]_i_4_n_0\
    );
\rdata[17]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(17),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[17]_i_4_n_0\
    );
\rdata[18]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(18),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[18]_i_4_n_0\
    );
\rdata[19]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(19),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[19]_i_4_n_0\
    );
\rdata[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000001005555"
    )
        port map (
      I0 => \rdata[1]_i_5_n_0\,
      I1 => s_axi_control_ARADDR(2),
      I2 => s_axi_control_ARADDR(3),
      I3 => int_ap_return(1),
      I4 => s_axi_control_ARADDR(4),
      I5 => \rdata[1]_i_6_n_0\,
      O => \rdata[1]_i_2_n_0\
    );
\rdata[1]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \rdata[31]_i_11_n_0\,
      I1 => s_axi_control_ARADDR(6),
      I2 => s_axi_control_ARADDR(5),
      I3 => s_axi_control_ARADDR(7),
      I4 => s_axi_control_ARADDR(0),
      I5 => s_axi_control_ARADDR(1),
      O => \rdata[1]_i_5_n_0\
    );
\rdata[1]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"53F053F053F053FF"
    )
        port map (
      I0 => p_1_in0_in(1),
      I1 => \int_ier_reg_n_0_[1]\,
      I2 => s_axi_control_ARADDR(2),
      I3 => s_axi_control_ARADDR(3),
      I4 => s_axi_control_ARADDR(4),
      I5 => int_ap_done,
      O => \rdata[1]_i_6_n_0\
    );
\rdata[20]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(20),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[20]_i_4_n_0\
    );
\rdata[21]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(21),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[21]_i_4_n_0\
    );
\rdata[22]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(22),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[22]_i_4_n_0\
    );
\rdata[23]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(23),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[23]_i_4_n_0\
    );
\rdata[24]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(24),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[24]_i_4_n_0\
    );
\rdata[25]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(25),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[25]_i_4_n_0\
    );
\rdata[26]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(26),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[26]_i_4_n_0\
    );
\rdata[27]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(27),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[27]_i_4_n_0\
    );
\rdata[28]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(28),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[28]_i_4_n_0\
    );
\rdata[29]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(29),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[29]_i_4_n_0\
    );
\rdata[2]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => int_ap_idle,
      I1 => s_axi_control_ARADDR(4),
      I2 => int_ap_return(2),
      I3 => int_ap_done_i_2_n_0,
      O => \rdata[2]_i_4_n_0\
    );
\rdata[30]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(30),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[30]_i_4_n_0\
    );
\rdata[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FEEE"
    )
        port map (
      I0 => int_b_read,
      I1 => int_a_read,
      I2 => \^fsm_onehot_rstate_reg[1]_0\,
      I3 => s_axi_control_ARVALID,
      O => \rdata[31]_i_1_n_0\
    );
\rdata[31]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => s_axi_control_ARADDR(3),
      I1 => s_axi_control_ARADDR(6),
      I2 => s_axi_control_ARADDR(5),
      I3 => s_axi_control_ARADDR(7),
      I4 => s_axi_control_ARADDR(0),
      I5 => s_axi_control_ARADDR(1),
      O => \rdata[31]_i_10_n_0\
    );
\rdata[31]_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => \^fsm_onehot_rstate_reg[1]_0\,
      O => \rdata[31]_i_11_n_0\
    );
\rdata[31]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => int_a_write_reg_n_0,
      I1 => s_axi_control_WVALID,
      I2 => s_axi_control_ARVALID,
      I3 => \^fsm_onehot_rstate_reg[1]_0\,
      O => int_a_write_reg_0
    );
\rdata[31]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => int_b_write_reg_n_0,
      I1 => s_axi_control_WVALID,
      I2 => s_axi_control_ARVALID,
      I3 => \^fsm_onehot_rstate_reg[1]_0\,
      O => int_b_write_reg_0
    );
\rdata[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0202000200000000"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => \rdata[31]_i_11_n_0\,
      I3 => s_axi_control_ARADDR(2),
      I4 => s_axi_control_ARADDR(3),
      I5 => int_ap_return(31),
      O => \rdata[31]_i_5_n_0\
    );
\rdata[3]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => int_ap_ready,
      I1 => s_axi_control_ARADDR(4),
      I2 => int_ap_return(3),
      I3 => int_ap_done_i_2_n_0,
      O => \rdata[3]_i_4_n_0\
    );
\rdata[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(4),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[4]_i_4_n_0\
    );
\rdata[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(5),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[5]_i_4_n_0\
    );
\rdata[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(6),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[6]_i_4_n_0\
    );
\rdata[7]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"00E2"
    )
        port map (
      I0 => int_auto_restart,
      I1 => s_axi_control_ARADDR(4),
      I2 => int_ap_return(7),
      I3 => int_ap_done_i_2_n_0,
      O => \rdata[7]_i_4_n_0\
    );
\rdata[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(8),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[8]_i_4_n_0\
    );
\rdata[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0020002000000020"
    )
        port map (
      I0 => s_axi_control_ARADDR(4),
      I1 => \rdata[31]_i_10_n_0\,
      I2 => int_ap_return(9),
      I3 => \rdata[31]_i_11_n_0\,
      I4 => s_axi_control_ARADDR(2),
      I5 => s_axi_control_ARADDR(3),
      O => \rdata[9]_i_4_n_0\
    );
\rdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(0),
      Q => s_axi_control_RDATA(0),
      R => '0'
    );
\rdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(10),
      Q => s_axi_control_RDATA(10),
      R => '0'
    );
\rdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(11),
      Q => s_axi_control_RDATA(11),
      R => '0'
    );
\rdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(12),
      Q => s_axi_control_RDATA(12),
      R => '0'
    );
\rdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(13),
      Q => s_axi_control_RDATA(13),
      R => '0'
    );
\rdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(14),
      Q => s_axi_control_RDATA(14),
      R => '0'
    );
\rdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(15),
      Q => s_axi_control_RDATA(15),
      R => '0'
    );
\rdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(16),
      Q => s_axi_control_RDATA(16),
      R => '0'
    );
\rdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(17),
      Q => s_axi_control_RDATA(17),
      R => '0'
    );
\rdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(18),
      Q => s_axi_control_RDATA(18),
      R => '0'
    );
\rdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(19),
      Q => s_axi_control_RDATA(19),
      R => '0'
    );
\rdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(1),
      Q => s_axi_control_RDATA(1),
      R => '0'
    );
\rdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(20),
      Q => s_axi_control_RDATA(20),
      R => '0'
    );
\rdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(21),
      Q => s_axi_control_RDATA(21),
      R => '0'
    );
\rdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(22),
      Q => s_axi_control_RDATA(22),
      R => '0'
    );
\rdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(23),
      Q => s_axi_control_RDATA(23),
      R => '0'
    );
\rdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(24),
      Q => s_axi_control_RDATA(24),
      R => '0'
    );
\rdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(25),
      Q => s_axi_control_RDATA(25),
      R => '0'
    );
\rdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(26),
      Q => s_axi_control_RDATA(26),
      R => '0'
    );
\rdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(27),
      Q => s_axi_control_RDATA(27),
      R => '0'
    );
\rdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(28),
      Q => s_axi_control_RDATA(28),
      R => '0'
    );
\rdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(29),
      Q => s_axi_control_RDATA(29),
      R => '0'
    );
\rdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(2),
      Q => s_axi_control_RDATA(2),
      R => '0'
    );
\rdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(30),
      Q => s_axi_control_RDATA(30),
      R => '0'
    );
\rdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(31),
      Q => s_axi_control_RDATA(31),
      R => '0'
    );
\rdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(3),
      Q => s_axi_control_RDATA(3),
      R => '0'
    );
\rdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(4),
      Q => s_axi_control_RDATA(4),
      R => '0'
    );
\rdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(5),
      Q => s_axi_control_RDATA(5),
      R => '0'
    );
\rdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(6),
      Q => s_axi_control_RDATA(6),
      R => '0'
    );
\rdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(7),
      Q => s_axi_control_RDATA(7),
      R => '0'
    );
\rdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(8),
      Q => s_axi_control_RDATA(8),
      R => '0'
    );
\rdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata[31]_i_1_n_0\,
      D => p_0_in(9),
      Q => s_axi_control_RDATA(9),
      R => '0'
    );
s_axi_control_RVALID_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \FSM_onehot_rstate_reg_n_0_[2]\,
      I1 => int_b_read,
      I2 => int_a_read,
      O => s_axi_control_RVALID
    );
s_axi_control_WREADY_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"70"
    )
        port map (
      I0 => s_axi_control_ARVALID,
      I1 => \^fsm_onehot_rstate_reg[1]_0\,
      I2 => \FSM_onehot_wstate_reg_n_0_[2]\,
      O => s_axi_control_WREADY
    );
\temp_reg_93[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => int_ap_ready_reg_0(0),
      I1 => ap_start,
      O => ap_NS_fsm1
    );
\waddr[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_axi_control_AWVALID,
      I1 => \^fsm_onehot_wstate_reg[1]_0\,
      O => aw_hs
    );
\waddr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(0),
      Q => \waddr_reg_n_0_[0]\,
      R => '0'
    );
\waddr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(1),
      Q => \waddr_reg_n_0_[1]\,
      R => '0'
    );
\waddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(2),
      Q => \waddr_reg_n_0_[2]\,
      R => '0'
    );
\waddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(3),
      Q => \waddr_reg_n_0_[3]\,
      R => '0'
    );
\waddr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(4),
      Q => \waddr_reg_n_0_[4]\,
      R => '0'
    );
\waddr_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(5),
      Q => \waddr_reg_n_0_[5]\,
      R => '0'
    );
\waddr_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(6),
      Q => \waddr_reg_n_0_[6]\,
      R => '0'
    );
\waddr_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => aw_hs,
      D => s_axi_control_AWADDR(7),
      Q => \waddr_reg_n_0_[7]\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1 is
  port (
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    b_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 0 to 0 );
    icmp_ln7_reg_137 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1 : entity is "muladd_mul_32s_32s_32_2_1";
end design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1;

architecture STRUCTURE of design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1 is
begin
muladd_mul_32s_32s_32_2_1_Multiplier_0_U: entity work.design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1_Multiplier_0
     port map (
      D(31 downto 0) => D(31 downto 0),
      Q(0) => Q(0),
      a_q0(31 downto 0) => a_q0(31 downto 0),
      ap_clk => ap_clk,
      b_q0(31 downto 0) => b_q0(31 downto 0),
      icmp_ln7_reg_137 => icmp_ln7_reg_137
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_muladd_0_0_muladd is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_AWREADY : out STD_LOGIC;
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_WREADY : out STD_LOGIC;
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARREADY : out STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_control_RVALID : out STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_BVALID : out STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    interrupt : out STD_LOGIC
  );
  attribute C_S_AXI_CONTROL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CONTROL_ADDR_WIDTH of design_1_muladd_0_0_muladd : entity is 8;
  attribute C_S_AXI_CONTROL_DATA_WIDTH : integer;
  attribute C_S_AXI_CONTROL_DATA_WIDTH of design_1_muladd_0_0_muladd : entity is 32;
  attribute C_S_AXI_CONTROL_WSTRB_WIDTH : integer;
  attribute C_S_AXI_CONTROL_WSTRB_WIDTH of design_1_muladd_0_0_muladd : entity is 4;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of design_1_muladd_0_0_muladd : entity is 32;
  attribute C_S_AXI_WSTRB_WIDTH : integer;
  attribute C_S_AXI_WSTRB_WIDTH of design_1_muladd_0_0_muladd : entity is 4;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_muladd_0_0_muladd : entity is "muladd";
  attribute ap_ST_fsm_pp0_stage0 : string;
  attribute ap_ST_fsm_pp0_stage0 of design_1_muladd_0_0_muladd : entity is "3'b010";
  attribute ap_ST_fsm_state1 : string;
  attribute ap_ST_fsm_state1 of design_1_muladd_0_0_muladd : entity is "3'b001";
  attribute ap_ST_fsm_state7 : string;
  attribute ap_ST_fsm_state7 of design_1_muladd_0_0_muladd : entity is "3'b100";
  attribute hls_module : string;
  attribute hls_module of design_1_muladd_0_0_muladd : entity is "yes";
end design_1_muladd_0_0_muladd;

architecture STRUCTURE of design_1_muladd_0_0_muladd is
  signal \<const0>\ : STD_LOGIC;
  signal a_ce0 : STD_LOGIC;
  signal a_q0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal add_ln7_fu_105_p2 : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
  signal \ap_CS_fsm_reg_n_0_[0]\ : STD_LOGIC;
  signal ap_CS_fsm_state7 : STD_LOGIC;
  signal ap_NS_fsm : STD_LOGIC_VECTOR ( 2 downto 1 );
  signal ap_NS_fsm1 : STD_LOGIC;
  signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
  signal ap_enable_reg_pp0_iter1 : STD_LOGIC;
  signal ap_enable_reg_pp0_iter2 : STD_LOGIC;
  signal ap_enable_reg_pp0_iter3 : STD_LOGIC;
  signal ap_enable_reg_pp0_iter4 : STD_LOGIC;
  signal ap_enable_reg_pp0_iter4_i_1_n_0 : STD_LOGIC;
  signal ap_rst_n_inv : STD_LOGIC;
  signal b_q0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal control_s_axi_U_n_0 : STD_LOGIC;
  signal control_s_axi_U_n_1 : STD_LOGIC;
  signal control_s_axi_U_n_10 : STD_LOGIC;
  signal control_s_axi_U_n_100 : STD_LOGIC;
  signal control_s_axi_U_n_101 : STD_LOGIC;
  signal control_s_axi_U_n_102 : STD_LOGIC;
  signal control_s_axi_U_n_103 : STD_LOGIC;
  signal control_s_axi_U_n_104 : STD_LOGIC;
  signal control_s_axi_U_n_105 : STD_LOGIC;
  signal control_s_axi_U_n_106 : STD_LOGIC;
  signal control_s_axi_U_n_107 : STD_LOGIC;
  signal control_s_axi_U_n_108 : STD_LOGIC;
  signal control_s_axi_U_n_109 : STD_LOGIC;
  signal control_s_axi_U_n_11 : STD_LOGIC;
  signal control_s_axi_U_n_110 : STD_LOGIC;
  signal control_s_axi_U_n_111 : STD_LOGIC;
  signal control_s_axi_U_n_112 : STD_LOGIC;
  signal control_s_axi_U_n_113 : STD_LOGIC;
  signal control_s_axi_U_n_114 : STD_LOGIC;
  signal control_s_axi_U_n_115 : STD_LOGIC;
  signal control_s_axi_U_n_116 : STD_LOGIC;
  signal control_s_axi_U_n_117 : STD_LOGIC;
  signal control_s_axi_U_n_118 : STD_LOGIC;
  signal control_s_axi_U_n_119 : STD_LOGIC;
  signal control_s_axi_U_n_12 : STD_LOGIC;
  signal control_s_axi_U_n_120 : STD_LOGIC;
  signal control_s_axi_U_n_121 : STD_LOGIC;
  signal control_s_axi_U_n_122 : STD_LOGIC;
  signal control_s_axi_U_n_123 : STD_LOGIC;
  signal control_s_axi_U_n_124 : STD_LOGIC;
  signal control_s_axi_U_n_125 : STD_LOGIC;
  signal control_s_axi_U_n_126 : STD_LOGIC;
  signal control_s_axi_U_n_127 : STD_LOGIC;
  signal control_s_axi_U_n_13 : STD_LOGIC;
  signal control_s_axi_U_n_14 : STD_LOGIC;
  signal control_s_axi_U_n_15 : STD_LOGIC;
  signal control_s_axi_U_n_16 : STD_LOGIC;
  signal control_s_axi_U_n_161 : STD_LOGIC;
  signal control_s_axi_U_n_163 : STD_LOGIC;
  signal control_s_axi_U_n_17 : STD_LOGIC;
  signal control_s_axi_U_n_18 : STD_LOGIC;
  signal control_s_axi_U_n_19 : STD_LOGIC;
  signal control_s_axi_U_n_2 : STD_LOGIC;
  signal control_s_axi_U_n_20 : STD_LOGIC;
  signal control_s_axi_U_n_202 : STD_LOGIC;
  signal control_s_axi_U_n_203 : STD_LOGIC;
  signal control_s_axi_U_n_21 : STD_LOGIC;
  signal control_s_axi_U_n_22 : STD_LOGIC;
  signal control_s_axi_U_n_23 : STD_LOGIC;
  signal control_s_axi_U_n_24 : STD_LOGIC;
  signal control_s_axi_U_n_25 : STD_LOGIC;
  signal control_s_axi_U_n_26 : STD_LOGIC;
  signal control_s_axi_U_n_27 : STD_LOGIC;
  signal control_s_axi_U_n_28 : STD_LOGIC;
  signal control_s_axi_U_n_29 : STD_LOGIC;
  signal control_s_axi_U_n_3 : STD_LOGIC;
  signal control_s_axi_U_n_30 : STD_LOGIC;
  signal control_s_axi_U_n_31 : STD_LOGIC;
  signal control_s_axi_U_n_32 : STD_LOGIC;
  signal control_s_axi_U_n_33 : STD_LOGIC;
  signal control_s_axi_U_n_34 : STD_LOGIC;
  signal control_s_axi_U_n_35 : STD_LOGIC;
  signal control_s_axi_U_n_36 : STD_LOGIC;
  signal control_s_axi_U_n_37 : STD_LOGIC;
  signal control_s_axi_U_n_38 : STD_LOGIC;
  signal control_s_axi_U_n_39 : STD_LOGIC;
  signal control_s_axi_U_n_4 : STD_LOGIC;
  signal control_s_axi_U_n_40 : STD_LOGIC;
  signal control_s_axi_U_n_41 : STD_LOGIC;
  signal control_s_axi_U_n_42 : STD_LOGIC;
  signal control_s_axi_U_n_43 : STD_LOGIC;
  signal control_s_axi_U_n_44 : STD_LOGIC;
  signal control_s_axi_U_n_45 : STD_LOGIC;
  signal control_s_axi_U_n_46 : STD_LOGIC;
  signal control_s_axi_U_n_47 : STD_LOGIC;
  signal control_s_axi_U_n_48 : STD_LOGIC;
  signal control_s_axi_U_n_49 : STD_LOGIC;
  signal control_s_axi_U_n_5 : STD_LOGIC;
  signal control_s_axi_U_n_50 : STD_LOGIC;
  signal control_s_axi_U_n_51 : STD_LOGIC;
  signal control_s_axi_U_n_52 : STD_LOGIC;
  signal control_s_axi_U_n_53 : STD_LOGIC;
  signal control_s_axi_U_n_54 : STD_LOGIC;
  signal control_s_axi_U_n_55 : STD_LOGIC;
  signal control_s_axi_U_n_56 : STD_LOGIC;
  signal control_s_axi_U_n_57 : STD_LOGIC;
  signal control_s_axi_U_n_58 : STD_LOGIC;
  signal control_s_axi_U_n_59 : STD_LOGIC;
  signal control_s_axi_U_n_6 : STD_LOGIC;
  signal control_s_axi_U_n_60 : STD_LOGIC;
  signal control_s_axi_U_n_61 : STD_LOGIC;
  signal control_s_axi_U_n_62 : STD_LOGIC;
  signal control_s_axi_U_n_63 : STD_LOGIC;
  signal control_s_axi_U_n_64 : STD_LOGIC;
  signal control_s_axi_U_n_65 : STD_LOGIC;
  signal control_s_axi_U_n_66 : STD_LOGIC;
  signal control_s_axi_U_n_67 : STD_LOGIC;
  signal control_s_axi_U_n_68 : STD_LOGIC;
  signal control_s_axi_U_n_69 : STD_LOGIC;
  signal control_s_axi_U_n_7 : STD_LOGIC;
  signal control_s_axi_U_n_70 : STD_LOGIC;
  signal control_s_axi_U_n_71 : STD_LOGIC;
  signal control_s_axi_U_n_72 : STD_LOGIC;
  signal control_s_axi_U_n_73 : STD_LOGIC;
  signal control_s_axi_U_n_74 : STD_LOGIC;
  signal control_s_axi_U_n_75 : STD_LOGIC;
  signal control_s_axi_U_n_76 : STD_LOGIC;
  signal control_s_axi_U_n_77 : STD_LOGIC;
  signal control_s_axi_U_n_78 : STD_LOGIC;
  signal control_s_axi_U_n_79 : STD_LOGIC;
  signal control_s_axi_U_n_8 : STD_LOGIC;
  signal control_s_axi_U_n_80 : STD_LOGIC;
  signal control_s_axi_U_n_81 : STD_LOGIC;
  signal control_s_axi_U_n_82 : STD_LOGIC;
  signal control_s_axi_U_n_83 : STD_LOGIC;
  signal control_s_axi_U_n_84 : STD_LOGIC;
  signal control_s_axi_U_n_85 : STD_LOGIC;
  signal control_s_axi_U_n_86 : STD_LOGIC;
  signal control_s_axi_U_n_87 : STD_LOGIC;
  signal control_s_axi_U_n_88 : STD_LOGIC;
  signal control_s_axi_U_n_89 : STD_LOGIC;
  signal control_s_axi_U_n_9 : STD_LOGIC;
  signal control_s_axi_U_n_90 : STD_LOGIC;
  signal control_s_axi_U_n_91 : STD_LOGIC;
  signal control_s_axi_U_n_92 : STD_LOGIC;
  signal control_s_axi_U_n_93 : STD_LOGIC;
  signal control_s_axi_U_n_94 : STD_LOGIC;
  signal control_s_axi_U_n_95 : STD_LOGIC;
  signal control_s_axi_U_n_96 : STD_LOGIC;
  signal control_s_axi_U_n_97 : STD_LOGIC;
  signal control_s_axi_U_n_98 : STD_LOGIC;
  signal control_s_axi_U_n_99 : STD_LOGIC;
  signal i_reg_820 : STD_LOGIC;
  signal i_reg_82_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \i_reg_82_reg__0\ : STD_LOGIC_VECTOR ( 4 to 4 );
  signal icmp_ln7_fu_111_p2 : STD_LOGIC;
  signal icmp_ln7_reg_137 : STD_LOGIC;
  signal \icmp_ln7_reg_137[0]_i_1_n_0\ : STD_LOGIC;
  signal icmp_ln7_reg_137_pp0_iter1_reg : STD_LOGIC;
  signal \icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal icmp_ln7_reg_137_pp0_iter2_reg : STD_LOGIC;
  signal icmp_ln7_reg_137_pp0_iter3_reg : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_16 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_17 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_18 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_19 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_20 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_21 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_22 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_23 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_24 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_25 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_26 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_27 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_28 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_29 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_30 : STD_LOGIC;
  signal mul_32s_32s_32_2_1_U1_n_31 : STD_LOGIC;
  signal mul_ln9_reg_161 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \mul_ln9_reg_161[31]_i_1_n_0\ : STD_LOGIC;
  signal \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\ : STD_LOGIC_VECTOR ( 31 downto 16 );
  signal p_reg_i_16_n_0 : STD_LOGIC;
  signal p_reg_i_17_n_0 : STD_LOGIC;
  signal p_reg_i_18_n_0 : STD_LOGIC;
  signal p_reg_i_19_n_0 : STD_LOGIC;
  signal p_reg_i_20_n_0 : STD_LOGIC;
  signal p_reg_i_21_n_0 : STD_LOGIC;
  signal p_reg_i_22_n_0 : STD_LOGIC;
  signal p_reg_i_23_n_0 : STD_LOGIC;
  signal p_reg_i_24_n_0 : STD_LOGIC;
  signal p_reg_i_25_n_0 : STD_LOGIC;
  signal p_reg_i_26_n_0 : STD_LOGIC;
  signal p_reg_i_27_n_0 : STD_LOGIC;
  signal p_reg_i_28_n_0 : STD_LOGIC;
  signal p_reg_i_29_n_0 : STD_LOGIC;
  signal p_reg_i_30_n_0 : STD_LOGIC;
  signal \rdata_reg[0]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[0]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[10]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[10]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[11]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[11]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[12]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[12]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[13]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[13]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[14]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[14]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[15]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[15]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[16]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[16]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[17]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[17]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[18]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[18]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[19]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[19]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[1]_i_7_n_0\ : STD_LOGIC;
  signal \rdata_reg[1]_i_8_n_0\ : STD_LOGIC;
  signal \rdata_reg[20]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[20]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[21]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[21]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[22]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[22]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[23]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[23]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[24]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[24]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[25]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[25]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[26]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[26]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[27]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[27]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[28]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[28]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[29]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[29]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[2]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[2]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[30]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[30]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[31]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[31]_i_7_n_0\ : STD_LOGIC;
  signal \rdata_reg[31]_i_8_n_0\ : STD_LOGIC;
  signal \rdata_reg[31]_i_9_n_0\ : STD_LOGIC;
  signal \rdata_reg[3]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[3]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[4]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[4]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[5]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[5]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[6]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[6]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[7]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[7]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[8]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[8]_i_6_n_0\ : STD_LOGIC;
  signal \rdata_reg[9]_i_5_n_0\ : STD_LOGIC;
  signal \rdata_reg[9]_i_6_n_0\ : STD_LOGIC;
  signal temp_reg_930 : STD_LOGIC;
  signal \temp_reg_93[0]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[0]_i_5_n_0\ : STD_LOGIC;
  signal \temp_reg_93[0]_i_6_n_0\ : STD_LOGIC;
  signal \temp_reg_93[0]_i_7_n_0\ : STD_LOGIC;
  signal \temp_reg_93[12]_i_2_n_0\ : STD_LOGIC;
  signal \temp_reg_93[12]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93[12]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[12]_i_5_n_0\ : STD_LOGIC;
  signal \temp_reg_93[16]_i_2_n_0\ : STD_LOGIC;
  signal \temp_reg_93[16]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93[16]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[16]_i_5_n_0\ : STD_LOGIC;
  signal \temp_reg_93[20]_i_2_n_0\ : STD_LOGIC;
  signal \temp_reg_93[20]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93[20]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[20]_i_5_n_0\ : STD_LOGIC;
  signal \temp_reg_93[24]_i_2_n_0\ : STD_LOGIC;
  signal \temp_reg_93[24]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93[24]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[24]_i_5_n_0\ : STD_LOGIC;
  signal \temp_reg_93[28]_i_2_n_0\ : STD_LOGIC;
  signal \temp_reg_93[28]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93[28]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[28]_i_5_n_0\ : STD_LOGIC;
  signal \temp_reg_93[4]_i_2_n_0\ : STD_LOGIC;
  signal \temp_reg_93[4]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93[4]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[4]_i_5_n_0\ : STD_LOGIC;
  signal \temp_reg_93[8]_i_2_n_0\ : STD_LOGIC;
  signal \temp_reg_93[8]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93[8]_i_4_n_0\ : STD_LOGIC;
  signal \temp_reg_93[8]_i_5_n_0\ : STD_LOGIC;
  signal temp_reg_93_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \temp_reg_93_reg[0]_i_3_n_0\ : STD_LOGIC;
  signal \temp_reg_93_reg[0]_i_3_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[0]_i_3_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[0]_i_3_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[0]_i_3_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[0]_i_3_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[0]_i_3_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[0]_i_3_n_7\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \temp_reg_93_reg[28]_i_1_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[28]_i_1_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[28]_i_1_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \temp_reg_93_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \tmp_product__0_i_18_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_19_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_20_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_21_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_22_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_23_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_24_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_25_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_26_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_27_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_28_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_29_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_30_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_31_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_32_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_33_n_0\ : STD_LOGIC;
  signal \tmp_product__0_i_34_n_0\ : STD_LOGIC;
  signal tmp_product_i_34_n_0 : STD_LOGIC;
  signal tmp_product_i_35_n_0 : STD_LOGIC;
  signal tmp_product_i_36_n_0 : STD_LOGIC;
  signal tmp_product_i_37_n_0 : STD_LOGIC;
  signal tmp_product_i_38_n_0 : STD_LOGIC;
  signal tmp_product_i_39_n_0 : STD_LOGIC;
  signal tmp_product_i_40_n_0 : STD_LOGIC;
  signal tmp_product_i_41_n_0 : STD_LOGIC;
  signal tmp_product_i_42_n_0 : STD_LOGIC;
  signal tmp_product_i_43_n_0 : STD_LOGIC;
  signal tmp_product_i_44_n_0 : STD_LOGIC;
  signal tmp_product_i_45_n_0 : STD_LOGIC;
  signal tmp_product_i_46_n_0 : STD_LOGIC;
  signal tmp_product_i_47_n_0 : STD_LOGIC;
  signal tmp_product_i_48_n_0 : STD_LOGIC;
  signal tmp_product_i_49_n_0 : STD_LOGIC;
  signal tmp_product_i_50_n_0 : STD_LOGIC;
  signal tmp_product_i_51_n_0 : STD_LOGIC;
  signal tmp_product_i_52_n_0 : STD_LOGIC;
  signal tmp_product_i_53_n_0 : STD_LOGIC;
  signal tmp_product_i_54_n_0 : STD_LOGIC;
  signal tmp_product_i_55_n_0 : STD_LOGIC;
  signal tmp_product_i_56_n_0 : STD_LOGIC;
  signal tmp_product_i_57_n_0 : STD_LOGIC;
  signal tmp_product_i_58_n_0 : STD_LOGIC;
  signal tmp_product_i_59_n_0 : STD_LOGIC;
  signal tmp_product_i_60_n_0 : STD_LOGIC;
  signal tmp_product_i_61_n_0 : STD_LOGIC;
  signal tmp_product_i_62_n_0 : STD_LOGIC;
  signal tmp_product_i_63_n_0 : STD_LOGIC;
  signal tmp_product_i_64_n_0 : STD_LOGIC;
  signal tmp_product_i_65_n_0 : STD_LOGIC;
  signal tmp_product_i_66_n_0 : STD_LOGIC;
  signal \NLW_temp_reg_93_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ap_CS_fsm[2]_i_1\ : label is "soft_lutpair43";
  attribute FSM_ENCODING : string;
  attribute FSM_ENCODING of \ap_CS_fsm_reg[0]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[1]\ : label is "none";
  attribute FSM_ENCODING of \ap_CS_fsm_reg[2]\ : label is "none";
  attribute SOFT_HLUTNM of ap_enable_reg_pp0_iter4_i_1 : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \i_reg_82[0]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \i_reg_82[1]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \i_reg_82[2]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \i_reg_82[3]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \i_reg_82[4]_i_2\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \i_reg_82[4]_i_3\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \icmp_ln7_reg_137[0]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1\ : label is "soft_lutpair42";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[0]_i_3\ : label is 11;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[12]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[16]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[20]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[24]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[28]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[4]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \temp_reg_93_reg[8]_i_1\ : label is 11;
begin
  s_axi_control_BRESP(1) <= \<const0>\;
  s_axi_control_BRESP(0) <= \<const0>\;
  s_axi_control_RRESP(1) <= \<const0>\;
  s_axi_control_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\ap_CS_fsm[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => ap_CS_fsm_pp0_stage0,
      I1 => ap_enable_reg_pp0_iter3,
      I2 => ap_enable_reg_pp0_iter2,
      O => ap_NS_fsm(2)
    );
\ap_CS_fsm_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => control_s_axi_U_n_202,
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
      D => ap_NS_fsm(1),
      Q => ap_CS_fsm_pp0_stage0,
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
      Q => ap_CS_fsm_state7,
      R => ap_rst_n_inv
    );
ap_enable_reg_pp0_iter0_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => control_s_axi_U_n_203,
      Q => ap_enable_reg_pp0_iter0,
      R => '0'
    );
ap_enable_reg_pp0_iter1_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_enable_reg_pp0_iter0,
      Q => ap_enable_reg_pp0_iter1,
      R => ap_rst_n_inv
    );
ap_enable_reg_pp0_iter2_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_enable_reg_pp0_iter1,
      Q => ap_enable_reg_pp0_iter2,
      R => ap_rst_n_inv
    );
ap_enable_reg_pp0_iter3_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_enable_reg_pp0_iter2,
      Q => ap_enable_reg_pp0_iter3,
      R => ap_rst_n_inv
    );
ap_enable_reg_pp0_iter4_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ap_enable_reg_pp0_iter2,
      I1 => ap_enable_reg_pp0_iter3,
      O => ap_enable_reg_pp0_iter4_i_1_n_0
    );
ap_enable_reg_pp0_iter4_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => ap_enable_reg_pp0_iter4_i_1_n_0,
      Q => ap_enable_reg_pp0_iter4,
      R => ap_rst_n_inv
    );
control_s_axi_U: entity work.design_1_muladd_0_0_muladd_control_s_axi
     port map (
      D(1) => ap_NS_fsm(1),
      D(0) => control_s_axi_U_n_202,
      DOADO(31) => control_s_axi_U_n_0,
      DOADO(30) => control_s_axi_U_n_1,
      DOADO(29) => control_s_axi_U_n_2,
      DOADO(28) => control_s_axi_U_n_3,
      DOADO(27) => control_s_axi_U_n_4,
      DOADO(26) => control_s_axi_U_n_5,
      DOADO(25) => control_s_axi_U_n_6,
      DOADO(24) => control_s_axi_U_n_7,
      DOADO(23) => control_s_axi_U_n_8,
      DOADO(22) => control_s_axi_U_n_9,
      DOADO(21) => control_s_axi_U_n_10,
      DOADO(20) => control_s_axi_U_n_11,
      DOADO(19) => control_s_axi_U_n_12,
      DOADO(18) => control_s_axi_U_n_13,
      DOADO(17) => control_s_axi_U_n_14,
      DOADO(16) => control_s_axi_U_n_15,
      DOADO(15) => control_s_axi_U_n_16,
      DOADO(14) => control_s_axi_U_n_17,
      DOADO(13) => control_s_axi_U_n_18,
      DOADO(12) => control_s_axi_U_n_19,
      DOADO(11) => control_s_axi_U_n_20,
      DOADO(10) => control_s_axi_U_n_21,
      DOADO(9) => control_s_axi_U_n_22,
      DOADO(8) => control_s_axi_U_n_23,
      DOADO(7) => control_s_axi_U_n_24,
      DOADO(6) => control_s_axi_U_n_25,
      DOADO(5) => control_s_axi_U_n_26,
      DOADO(4) => control_s_axi_U_n_27,
      DOADO(3) => control_s_axi_U_n_28,
      DOADO(2) => control_s_axi_U_n_29,
      DOADO(1) => control_s_axi_U_n_30,
      DOADO(0) => control_s_axi_U_n_31,
      DOBDO(31) => control_s_axi_U_n_32,
      DOBDO(30) => control_s_axi_U_n_33,
      DOBDO(29) => control_s_axi_U_n_34,
      DOBDO(28) => control_s_axi_U_n_35,
      DOBDO(27) => control_s_axi_U_n_36,
      DOBDO(26) => control_s_axi_U_n_37,
      DOBDO(25) => control_s_axi_U_n_38,
      DOBDO(24) => control_s_axi_U_n_39,
      DOBDO(23) => control_s_axi_U_n_40,
      DOBDO(22) => control_s_axi_U_n_41,
      DOBDO(21) => control_s_axi_U_n_42,
      DOBDO(20) => control_s_axi_U_n_43,
      DOBDO(19) => control_s_axi_U_n_44,
      DOBDO(18) => control_s_axi_U_n_45,
      DOBDO(17) => control_s_axi_U_n_46,
      DOBDO(16) => control_s_axi_U_n_47,
      DOBDO(15) => control_s_axi_U_n_48,
      DOBDO(14) => control_s_axi_U_n_49,
      DOBDO(13) => control_s_axi_U_n_50,
      DOBDO(12) => control_s_axi_U_n_51,
      DOBDO(11) => control_s_axi_U_n_52,
      DOBDO(10) => control_s_axi_U_n_53,
      DOBDO(9) => control_s_axi_U_n_54,
      DOBDO(8) => control_s_axi_U_n_55,
      DOBDO(7) => control_s_axi_U_n_56,
      DOBDO(6) => control_s_axi_U_n_57,
      DOBDO(5) => control_s_axi_U_n_58,
      DOBDO(4) => control_s_axi_U_n_59,
      DOBDO(3) => control_s_axi_U_n_60,
      DOBDO(2) => control_s_axi_U_n_61,
      DOBDO(1) => control_s_axi_U_n_62,
      DOBDO(0) => control_s_axi_U_n_63,
      \FSM_onehot_rstate_reg[1]_0\ => s_axi_control_ARREADY,
      \FSM_onehot_wstate_reg[1]_0\ => s_axi_control_AWREADY,
      Q(3 downto 0) => i_reg_82_reg(3 downto 0),
      a_q0(31 downto 0) => a_q0(31 downto 0),
      \ap_CS_fsm_reg[1]\ => control_s_axi_U_n_203,
      ap_NS_fsm1 => ap_NS_fsm1,
      ap_clk => ap_clk,
      ap_enable_reg_pp0_iter0 => ap_enable_reg_pp0_iter0,
      ap_enable_reg_pp0_iter2 => ap_enable_reg_pp0_iter2,
      ap_enable_reg_pp0_iter3 => ap_enable_reg_pp0_iter3,
      ap_rst_n => ap_rst_n,
      ap_rst_n_inv => ap_rst_n_inv,
      b_q0(31 downto 0) => b_q0(31 downto 0),
      \gen_write[1].mem_reg\(31) => control_s_axi_U_n_64,
      \gen_write[1].mem_reg\(30) => control_s_axi_U_n_65,
      \gen_write[1].mem_reg\(29) => control_s_axi_U_n_66,
      \gen_write[1].mem_reg\(28) => control_s_axi_U_n_67,
      \gen_write[1].mem_reg\(27) => control_s_axi_U_n_68,
      \gen_write[1].mem_reg\(26) => control_s_axi_U_n_69,
      \gen_write[1].mem_reg\(25) => control_s_axi_U_n_70,
      \gen_write[1].mem_reg\(24) => control_s_axi_U_n_71,
      \gen_write[1].mem_reg\(23) => control_s_axi_U_n_72,
      \gen_write[1].mem_reg\(22) => control_s_axi_U_n_73,
      \gen_write[1].mem_reg\(21) => control_s_axi_U_n_74,
      \gen_write[1].mem_reg\(20) => control_s_axi_U_n_75,
      \gen_write[1].mem_reg\(19) => control_s_axi_U_n_76,
      \gen_write[1].mem_reg\(18) => control_s_axi_U_n_77,
      \gen_write[1].mem_reg\(17) => control_s_axi_U_n_78,
      \gen_write[1].mem_reg\(16) => control_s_axi_U_n_79,
      \gen_write[1].mem_reg\(15) => control_s_axi_U_n_80,
      \gen_write[1].mem_reg\(14) => control_s_axi_U_n_81,
      \gen_write[1].mem_reg\(13) => control_s_axi_U_n_82,
      \gen_write[1].mem_reg\(12) => control_s_axi_U_n_83,
      \gen_write[1].mem_reg\(11) => control_s_axi_U_n_84,
      \gen_write[1].mem_reg\(10) => control_s_axi_U_n_85,
      \gen_write[1].mem_reg\(9) => control_s_axi_U_n_86,
      \gen_write[1].mem_reg\(8) => control_s_axi_U_n_87,
      \gen_write[1].mem_reg\(7) => control_s_axi_U_n_88,
      \gen_write[1].mem_reg\(6) => control_s_axi_U_n_89,
      \gen_write[1].mem_reg\(5) => control_s_axi_U_n_90,
      \gen_write[1].mem_reg\(4) => control_s_axi_U_n_91,
      \gen_write[1].mem_reg\(3) => control_s_axi_U_n_92,
      \gen_write[1].mem_reg\(2) => control_s_axi_U_n_93,
      \gen_write[1].mem_reg\(1) => control_s_axi_U_n_94,
      \gen_write[1].mem_reg\(0) => control_s_axi_U_n_95,
      \gen_write[1].mem_reg_0\(31) => control_s_axi_U_n_96,
      \gen_write[1].mem_reg_0\(30) => control_s_axi_U_n_97,
      \gen_write[1].mem_reg_0\(29) => control_s_axi_U_n_98,
      \gen_write[1].mem_reg_0\(28) => control_s_axi_U_n_99,
      \gen_write[1].mem_reg_0\(27) => control_s_axi_U_n_100,
      \gen_write[1].mem_reg_0\(26) => control_s_axi_U_n_101,
      \gen_write[1].mem_reg_0\(25) => control_s_axi_U_n_102,
      \gen_write[1].mem_reg_0\(24) => control_s_axi_U_n_103,
      \gen_write[1].mem_reg_0\(23) => control_s_axi_U_n_104,
      \gen_write[1].mem_reg_0\(22) => control_s_axi_U_n_105,
      \gen_write[1].mem_reg_0\(21) => control_s_axi_U_n_106,
      \gen_write[1].mem_reg_0\(20) => control_s_axi_U_n_107,
      \gen_write[1].mem_reg_0\(19) => control_s_axi_U_n_108,
      \gen_write[1].mem_reg_0\(18) => control_s_axi_U_n_109,
      \gen_write[1].mem_reg_0\(17) => control_s_axi_U_n_110,
      \gen_write[1].mem_reg_0\(16) => control_s_axi_U_n_111,
      \gen_write[1].mem_reg_0\(15) => control_s_axi_U_n_112,
      \gen_write[1].mem_reg_0\(14) => control_s_axi_U_n_113,
      \gen_write[1].mem_reg_0\(13) => control_s_axi_U_n_114,
      \gen_write[1].mem_reg_0\(12) => control_s_axi_U_n_115,
      \gen_write[1].mem_reg_0\(11) => control_s_axi_U_n_116,
      \gen_write[1].mem_reg_0\(10) => control_s_axi_U_n_117,
      \gen_write[1].mem_reg_0\(9) => control_s_axi_U_n_118,
      \gen_write[1].mem_reg_0\(8) => control_s_axi_U_n_119,
      \gen_write[1].mem_reg_0\(7) => control_s_axi_U_n_120,
      \gen_write[1].mem_reg_0\(6) => control_s_axi_U_n_121,
      \gen_write[1].mem_reg_0\(5) => control_s_axi_U_n_122,
      \gen_write[1].mem_reg_0\(4) => control_s_axi_U_n_123,
      \gen_write[1].mem_reg_0\(3) => control_s_axi_U_n_124,
      \gen_write[1].mem_reg_0\(2) => control_s_axi_U_n_125,
      \gen_write[1].mem_reg_0\(1) => control_s_axi_U_n_126,
      \gen_write[1].mem_reg_0\(0) => control_s_axi_U_n_127,
      icmp_ln7_fu_111_p2 => icmp_ln7_fu_111_p2,
      int_a_write_reg_0 => control_s_axi_U_n_161,
      int_ap_ready_reg_0(2) => ap_CS_fsm_state7,
      int_ap_ready_reg_0(1) => ap_CS_fsm_pp0_stage0,
      int_ap_ready_reg_0(0) => \ap_CS_fsm_reg_n_0_[0]\,
      \int_ap_return_reg[31]_0\(31 downto 0) => temp_reg_93_reg(31 downto 0),
      int_b_write_reg_0 => control_s_axi_U_n_163,
      interrupt => interrupt,
      p_reg => p_reg_i_30_n_0,
      p_reg_0 => p_reg_i_29_n_0,
      p_reg_1 => p_reg_i_28_n_0,
      p_reg_10 => p_reg_i_19_n_0,
      p_reg_11 => p_reg_i_18_n_0,
      p_reg_12 => p_reg_i_17_n_0,
      p_reg_13 => p_reg_i_16_n_0,
      p_reg_2 => p_reg_i_27_n_0,
      p_reg_3 => p_reg_i_26_n_0,
      p_reg_4 => p_reg_i_25_n_0,
      p_reg_5 => p_reg_i_24_n_0,
      p_reg_6 => p_reg_i_23_n_0,
      p_reg_7 => p_reg_i_22_n_0,
      p_reg_8 => p_reg_i_21_n_0,
      p_reg_9 => p_reg_i_20_n_0,
      \rdata_reg[0]_0\ => \rdata_reg[0]_i_5_n_0\,
      \rdata_reg[0]_1\ => \rdata_reg[0]_i_6_n_0\,
      \rdata_reg[10]_0\ => \rdata_reg[10]_i_5_n_0\,
      \rdata_reg[10]_1\ => \rdata_reg[10]_i_6_n_0\,
      \rdata_reg[11]_0\ => \rdata_reg[11]_i_5_n_0\,
      \rdata_reg[11]_1\ => \rdata_reg[11]_i_6_n_0\,
      \rdata_reg[12]_0\ => \rdata_reg[12]_i_5_n_0\,
      \rdata_reg[12]_1\ => \rdata_reg[12]_i_6_n_0\,
      \rdata_reg[13]_0\ => \rdata_reg[13]_i_5_n_0\,
      \rdata_reg[13]_1\ => \rdata_reg[13]_i_6_n_0\,
      \rdata_reg[14]_0\ => \rdata_reg[14]_i_5_n_0\,
      \rdata_reg[14]_1\ => \rdata_reg[14]_i_6_n_0\,
      \rdata_reg[15]_0\ => \rdata_reg[15]_i_5_n_0\,
      \rdata_reg[15]_1\ => \rdata_reg[15]_i_6_n_0\,
      \rdata_reg[16]_0\ => \rdata_reg[16]_i_5_n_0\,
      \rdata_reg[16]_1\ => \rdata_reg[16]_i_6_n_0\,
      \rdata_reg[17]_0\ => \rdata_reg[17]_i_5_n_0\,
      \rdata_reg[17]_1\ => \rdata_reg[17]_i_6_n_0\,
      \rdata_reg[18]_0\ => \rdata_reg[18]_i_5_n_0\,
      \rdata_reg[18]_1\ => \rdata_reg[18]_i_6_n_0\,
      \rdata_reg[19]_0\ => \rdata_reg[19]_i_5_n_0\,
      \rdata_reg[19]_1\ => \rdata_reg[19]_i_6_n_0\,
      \rdata_reg[1]_0\ => \rdata_reg[1]_i_7_n_0\,
      \rdata_reg[1]_1\ => \rdata_reg[1]_i_8_n_0\,
      \rdata_reg[20]_0\ => \rdata_reg[20]_i_5_n_0\,
      \rdata_reg[20]_1\ => \rdata_reg[20]_i_6_n_0\,
      \rdata_reg[21]_0\ => \rdata_reg[21]_i_5_n_0\,
      \rdata_reg[21]_1\ => \rdata_reg[21]_i_6_n_0\,
      \rdata_reg[22]_0\ => \rdata_reg[22]_i_5_n_0\,
      \rdata_reg[22]_1\ => \rdata_reg[22]_i_6_n_0\,
      \rdata_reg[23]_0\ => \rdata_reg[23]_i_5_n_0\,
      \rdata_reg[23]_1\ => \rdata_reg[23]_i_6_n_0\,
      \rdata_reg[24]_0\ => \rdata_reg[24]_i_5_n_0\,
      \rdata_reg[24]_1\ => \rdata_reg[24]_i_6_n_0\,
      \rdata_reg[25]_0\ => \rdata_reg[25]_i_5_n_0\,
      \rdata_reg[25]_1\ => \rdata_reg[25]_i_6_n_0\,
      \rdata_reg[26]_0\ => \rdata_reg[26]_i_5_n_0\,
      \rdata_reg[26]_1\ => \rdata_reg[26]_i_6_n_0\,
      \rdata_reg[27]_0\ => \rdata_reg[27]_i_5_n_0\,
      \rdata_reg[27]_1\ => \rdata_reg[27]_i_6_n_0\,
      \rdata_reg[28]_0\ => \rdata_reg[28]_i_5_n_0\,
      \rdata_reg[28]_1\ => \rdata_reg[28]_i_6_n_0\,
      \rdata_reg[29]_0\ => \rdata_reg[29]_i_5_n_0\,
      \rdata_reg[29]_1\ => \rdata_reg[29]_i_6_n_0\,
      \rdata_reg[2]_0\ => \rdata_reg[2]_i_5_n_0\,
      \rdata_reg[2]_1\ => \rdata_reg[2]_i_6_n_0\,
      \rdata_reg[30]_0\ => \rdata_reg[30]_i_5_n_0\,
      \rdata_reg[30]_1\ => \rdata_reg[30]_i_6_n_0\,
      \rdata_reg[31]_0\ => \rdata_reg[31]_i_6_n_0\,
      \rdata_reg[31]_1\ => \rdata_reg[31]_i_7_n_0\,
      \rdata_reg[31]_2\ => \rdata_reg[31]_i_8_n_0\,
      \rdata_reg[31]_3\ => \rdata_reg[31]_i_9_n_0\,
      \rdata_reg[3]_0\ => \rdata_reg[3]_i_5_n_0\,
      \rdata_reg[3]_1\ => \rdata_reg[3]_i_6_n_0\,
      \rdata_reg[4]_0\ => \rdata_reg[4]_i_5_n_0\,
      \rdata_reg[4]_1\ => \rdata_reg[4]_i_6_n_0\,
      \rdata_reg[5]_0\ => \rdata_reg[5]_i_5_n_0\,
      \rdata_reg[5]_1\ => \rdata_reg[5]_i_6_n_0\,
      \rdata_reg[6]_0\ => \rdata_reg[6]_i_5_n_0\,
      \rdata_reg[6]_1\ => \rdata_reg[6]_i_6_n_0\,
      \rdata_reg[7]_0\ => \rdata_reg[7]_i_5_n_0\,
      \rdata_reg[7]_1\ => \rdata_reg[7]_i_6_n_0\,
      \rdata_reg[8]_0\ => \rdata_reg[8]_i_5_n_0\,
      \rdata_reg[8]_1\ => \rdata_reg[8]_i_6_n_0\,
      \rdata_reg[9]_0\ => \rdata_reg[9]_i_5_n_0\,
      \rdata_reg[9]_1\ => \rdata_reg[9]_i_6_n_0\,
      s_axi_control_ARADDR(7 downto 0) => s_axi_control_ARADDR(7 downto 0),
      s_axi_control_ARVALID => s_axi_control_ARVALID,
      s_axi_control_AWADDR(7 downto 0) => s_axi_control_AWADDR(7 downto 0),
      s_axi_control_AWVALID => s_axi_control_AWVALID,
      s_axi_control_BREADY => s_axi_control_BREADY,
      s_axi_control_BVALID => s_axi_control_BVALID,
      s_axi_control_RDATA(31 downto 0) => s_axi_control_RDATA(31 downto 0),
      s_axi_control_RREADY => s_axi_control_RREADY,
      s_axi_control_RVALID => s_axi_control_RVALID,
      s_axi_control_WDATA(31 downto 0) => s_axi_control_WDATA(31 downto 0),
      s_axi_control_WREADY => s_axi_control_WREADY,
      s_axi_control_WSTRB(3 downto 0) => s_axi_control_WSTRB(3 downto 0),
      s_axi_control_WVALID => s_axi_control_WVALID,
      tmp_product => tmp_product_i_34_n_0,
      tmp_product_0 => tmp_product_i_49_n_0,
      tmp_product_1 => tmp_product_i_48_n_0,
      tmp_product_10 => tmp_product_i_39_n_0,
      tmp_product_11 => tmp_product_i_38_n_0,
      tmp_product_12 => tmp_product_i_37_n_0,
      tmp_product_13 => tmp_product_i_36_n_0,
      tmp_product_14 => tmp_product_i_35_n_0,
      tmp_product_2 => tmp_product_i_47_n_0,
      tmp_product_3 => tmp_product_i_46_n_0,
      tmp_product_4 => tmp_product_i_45_n_0,
      tmp_product_5 => tmp_product_i_44_n_0,
      tmp_product_6 => tmp_product_i_43_n_0,
      tmp_product_7 => tmp_product_i_42_n_0,
      tmp_product_8 => tmp_product_i_41_n_0,
      tmp_product_9 => tmp_product_i_40_n_0,
      \tmp_product__0\ => tmp_product_i_66_n_0,
      \tmp_product__0_0\ => tmp_product_i_65_n_0,
      \tmp_product__0_1\ => tmp_product_i_64_n_0,
      \tmp_product__0_10\ => tmp_product_i_55_n_0,
      \tmp_product__0_11\ => tmp_product_i_54_n_0,
      \tmp_product__0_12\ => tmp_product_i_53_n_0,
      \tmp_product__0_13\ => tmp_product_i_52_n_0,
      \tmp_product__0_14\ => tmp_product_i_51_n_0,
      \tmp_product__0_15\ => tmp_product_i_50_n_0,
      \tmp_product__0_16\ => \tmp_product__0_i_34_n_0\,
      \tmp_product__0_17\ => \tmp_product__0_i_33_n_0\,
      \tmp_product__0_18\ => \tmp_product__0_i_32_n_0\,
      \tmp_product__0_19\ => \tmp_product__0_i_31_n_0\,
      \tmp_product__0_2\ => tmp_product_i_63_n_0,
      \tmp_product__0_20\ => \tmp_product__0_i_30_n_0\,
      \tmp_product__0_21\ => \tmp_product__0_i_29_n_0\,
      \tmp_product__0_22\ => \tmp_product__0_i_28_n_0\,
      \tmp_product__0_23\ => \tmp_product__0_i_27_n_0\,
      \tmp_product__0_24\ => \tmp_product__0_i_26_n_0\,
      \tmp_product__0_25\ => \tmp_product__0_i_25_n_0\,
      \tmp_product__0_26\ => \tmp_product__0_i_24_n_0\,
      \tmp_product__0_27\ => \tmp_product__0_i_23_n_0\,
      \tmp_product__0_28\ => \tmp_product__0_i_22_n_0\,
      \tmp_product__0_29\ => \tmp_product__0_i_21_n_0\,
      \tmp_product__0_3\ => tmp_product_i_62_n_0,
      \tmp_product__0_30\ => \tmp_product__0_i_20_n_0\,
      \tmp_product__0_31\ => \tmp_product__0_i_19_n_0\,
      \tmp_product__0_32\ => \tmp_product__0_i_18_n_0\,
      \tmp_product__0_4\ => tmp_product_i_61_n_0,
      \tmp_product__0_5\ => tmp_product_i_60_n_0,
      \tmp_product__0_6\ => tmp_product_i_59_n_0,
      \tmp_product__0_7\ => tmp_product_i_58_n_0,
      \tmp_product__0_8\ => tmp_product_i_57_n_0,
      \tmp_product__0_9\ => tmp_product_i_56_n_0
    );
\i_reg_82[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => i_reg_82_reg(0),
      O => add_ln7_fu_105_p2(0)
    );
\i_reg_82[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => i_reg_82_reg(0),
      I1 => i_reg_82_reg(1),
      O => add_ln7_fu_105_p2(1)
    );
\i_reg_82[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => i_reg_82_reg(0),
      I1 => i_reg_82_reg(1),
      I2 => i_reg_82_reg(2),
      O => add_ln7_fu_105_p2(2)
    );
\i_reg_82[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => i_reg_82_reg(3),
      I1 => i_reg_82_reg(0),
      I2 => i_reg_82_reg(1),
      I3 => i_reg_82_reg(2),
      O => add_ln7_fu_105_p2(3)
    );
\i_reg_82[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => ap_enable_reg_pp0_iter0,
      I1 => ap_CS_fsm_pp0_stage0,
      I2 => icmp_ln7_fu_111_p2,
      O => i_reg_820
    );
\i_reg_82[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \i_reg_82_reg__0\(4),
      I1 => i_reg_82_reg(2),
      I2 => i_reg_82_reg(1),
      I3 => i_reg_82_reg(0),
      I4 => i_reg_82_reg(3),
      O => add_ln7_fu_105_p2(4)
    );
\i_reg_82[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000100"
    )
        port map (
      I0 => i_reg_82_reg(1),
      I1 => i_reg_82_reg(0),
      I2 => i_reg_82_reg(2),
      I3 => \i_reg_82_reg__0\(4),
      I4 => i_reg_82_reg(3),
      O => icmp_ln7_fu_111_p2
    );
\i_reg_82_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => i_reg_820,
      D => add_ln7_fu_105_p2(0),
      Q => i_reg_82_reg(0),
      R => ap_NS_fsm1
    );
\i_reg_82_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => i_reg_820,
      D => add_ln7_fu_105_p2(1),
      Q => i_reg_82_reg(1),
      R => ap_NS_fsm1
    );
\i_reg_82_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => i_reg_820,
      D => add_ln7_fu_105_p2(2),
      Q => i_reg_82_reg(2),
      R => ap_NS_fsm1
    );
\i_reg_82_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => i_reg_820,
      D => add_ln7_fu_105_p2(3),
      Q => i_reg_82_reg(3),
      R => ap_NS_fsm1
    );
\i_reg_82_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => i_reg_820,
      D => add_ln7_fu_105_p2(4),
      Q => \i_reg_82_reg__0\(4),
      R => ap_NS_fsm1
    );
\icmp_ln7_reg_137[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => icmp_ln7_fu_111_p2,
      I1 => ap_CS_fsm_pp0_stage0,
      I2 => icmp_ln7_reg_137,
      O => \icmp_ln7_reg_137[0]_i_1_n_0\
    );
\icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => icmp_ln7_reg_137,
      I1 => ap_CS_fsm_pp0_stage0,
      I2 => icmp_ln7_reg_137_pp0_iter1_reg,
      O => \icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1_n_0\
    );
\icmp_ln7_reg_137_pp0_iter1_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \icmp_ln7_reg_137_pp0_iter1_reg[0]_i_1_n_0\,
      Q => icmp_ln7_reg_137_pp0_iter1_reg,
      R => '0'
    );
\icmp_ln7_reg_137_pp0_iter2_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => icmp_ln7_reg_137_pp0_iter1_reg,
      Q => icmp_ln7_reg_137_pp0_iter2_reg,
      R => '0'
    );
\icmp_ln7_reg_137_pp0_iter3_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => icmp_ln7_reg_137_pp0_iter2_reg,
      Q => icmp_ln7_reg_137_pp0_iter3_reg,
      R => '0'
    );
\icmp_ln7_reg_137_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => '1',
      D => \icmp_ln7_reg_137[0]_i_1_n_0\,
      Q => icmp_ln7_reg_137,
      R => '0'
    );
mul_32s_32s_32_2_1_U1: entity work.design_1_muladd_0_0_muladd_mul_32s_32s_32_2_1
     port map (
      D(31 downto 16) => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(31 downto 16),
      D(15) => mul_32s_32s_32_2_1_U1_n_16,
      D(14) => mul_32s_32s_32_2_1_U1_n_17,
      D(13) => mul_32s_32s_32_2_1_U1_n_18,
      D(12) => mul_32s_32s_32_2_1_U1_n_19,
      D(11) => mul_32s_32s_32_2_1_U1_n_20,
      D(10) => mul_32s_32s_32_2_1_U1_n_21,
      D(9) => mul_32s_32s_32_2_1_U1_n_22,
      D(8) => mul_32s_32s_32_2_1_U1_n_23,
      D(7) => mul_32s_32s_32_2_1_U1_n_24,
      D(6) => mul_32s_32s_32_2_1_U1_n_25,
      D(5) => mul_32s_32s_32_2_1_U1_n_26,
      D(4) => mul_32s_32s_32_2_1_U1_n_27,
      D(3) => mul_32s_32s_32_2_1_U1_n_28,
      D(2) => mul_32s_32s_32_2_1_U1_n_29,
      D(1) => mul_32s_32s_32_2_1_U1_n_30,
      D(0) => mul_32s_32s_32_2_1_U1_n_31,
      Q(0) => ap_CS_fsm_pp0_stage0,
      a_q0(31 downto 0) => a_q0(31 downto 0),
      ap_clk => ap_clk,
      b_q0(31 downto 0) => b_q0(31 downto 0),
      icmp_ln7_reg_137 => icmp_ln7_reg_137
    );
\mul_ln9_reg_161[31]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => icmp_ln7_reg_137_pp0_iter2_reg,
      O => \mul_ln9_reg_161[31]_i_1_n_0\
    );
\mul_ln9_reg_161_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_31,
      Q => mul_ln9_reg_161(0),
      R => '0'
    );
\mul_ln9_reg_161_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_21,
      Q => mul_ln9_reg_161(10),
      R => '0'
    );
\mul_ln9_reg_161_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_20,
      Q => mul_ln9_reg_161(11),
      R => '0'
    );
\mul_ln9_reg_161_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_19,
      Q => mul_ln9_reg_161(12),
      R => '0'
    );
\mul_ln9_reg_161_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_18,
      Q => mul_ln9_reg_161(13),
      R => '0'
    );
\mul_ln9_reg_161_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_17,
      Q => mul_ln9_reg_161(14),
      R => '0'
    );
\mul_ln9_reg_161_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_16,
      Q => mul_ln9_reg_161(15),
      R => '0'
    );
\mul_ln9_reg_161_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(16),
      Q => mul_ln9_reg_161(16),
      R => '0'
    );
\mul_ln9_reg_161_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(17),
      Q => mul_ln9_reg_161(17),
      R => '0'
    );
\mul_ln9_reg_161_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(18),
      Q => mul_ln9_reg_161(18),
      R => '0'
    );
\mul_ln9_reg_161_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(19),
      Q => mul_ln9_reg_161(19),
      R => '0'
    );
\mul_ln9_reg_161_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_30,
      Q => mul_ln9_reg_161(1),
      R => '0'
    );
\mul_ln9_reg_161_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(20),
      Q => mul_ln9_reg_161(20),
      R => '0'
    );
\mul_ln9_reg_161_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(21),
      Q => mul_ln9_reg_161(21),
      R => '0'
    );
\mul_ln9_reg_161_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(22),
      Q => mul_ln9_reg_161(22),
      R => '0'
    );
\mul_ln9_reg_161_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(23),
      Q => mul_ln9_reg_161(23),
      R => '0'
    );
\mul_ln9_reg_161_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(24),
      Q => mul_ln9_reg_161(24),
      R => '0'
    );
\mul_ln9_reg_161_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(25),
      Q => mul_ln9_reg_161(25),
      R => '0'
    );
\mul_ln9_reg_161_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(26),
      Q => mul_ln9_reg_161(26),
      R => '0'
    );
\mul_ln9_reg_161_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(27),
      Q => mul_ln9_reg_161(27),
      R => '0'
    );
\mul_ln9_reg_161_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(28),
      Q => mul_ln9_reg_161(28),
      R => '0'
    );
\mul_ln9_reg_161_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(29),
      Q => mul_ln9_reg_161(29),
      R => '0'
    );
\mul_ln9_reg_161_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_29,
      Q => mul_ln9_reg_161(2),
      R => '0'
    );
\mul_ln9_reg_161_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(30),
      Q => mul_ln9_reg_161(30),
      R => '0'
    );
\mul_ln9_reg_161_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => \muladd_mul_32s_32s_32_2_1_Multiplier_0_U/p_reg__1\(31),
      Q => mul_ln9_reg_161(31),
      R => '0'
    );
\mul_ln9_reg_161_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_28,
      Q => mul_ln9_reg_161(3),
      R => '0'
    );
\mul_ln9_reg_161_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_27,
      Q => mul_ln9_reg_161(4),
      R => '0'
    );
\mul_ln9_reg_161_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_26,
      Q => mul_ln9_reg_161(5),
      R => '0'
    );
\mul_ln9_reg_161_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_25,
      Q => mul_ln9_reg_161(6),
      R => '0'
    );
\mul_ln9_reg_161_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_24,
      Q => mul_ln9_reg_161(7),
      R => '0'
    );
\mul_ln9_reg_161_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_23,
      Q => mul_ln9_reg_161(8),
      R => '0'
    );
\mul_ln9_reg_161_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \mul_ln9_reg_161[31]_i_1_n_0\,
      D => mul_32s_32s_32_2_1_U1_n_22,
      Q => mul_ln9_reg_161(9),
      R => '0'
    );
p_reg_i_16: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_32,
      Q => p_reg_i_16_n_0,
      R => '0'
    );
p_reg_i_17: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_33,
      Q => p_reg_i_17_n_0,
      R => '0'
    );
p_reg_i_18: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_34,
      Q => p_reg_i_18_n_0,
      R => '0'
    );
p_reg_i_19: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_35,
      Q => p_reg_i_19_n_0,
      R => '0'
    );
p_reg_i_20: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_36,
      Q => p_reg_i_20_n_0,
      R => '0'
    );
p_reg_i_21: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_37,
      Q => p_reg_i_21_n_0,
      R => '0'
    );
p_reg_i_22: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_38,
      Q => p_reg_i_22_n_0,
      R => '0'
    );
p_reg_i_23: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_39,
      Q => p_reg_i_23_n_0,
      R => '0'
    );
p_reg_i_24: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_40,
      Q => p_reg_i_24_n_0,
      R => '0'
    );
p_reg_i_25: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_41,
      Q => p_reg_i_25_n_0,
      R => '0'
    );
p_reg_i_26: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_42,
      Q => p_reg_i_26_n_0,
      R => '0'
    );
p_reg_i_27: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_43,
      Q => p_reg_i_27_n_0,
      R => '0'
    );
p_reg_i_28: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_44,
      Q => p_reg_i_28_n_0,
      R => '0'
    );
p_reg_i_29: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_45,
      Q => p_reg_i_29_n_0,
      R => '0'
    );
p_reg_i_30: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_46,
      Q => p_reg_i_30_n_0,
      R => '0'
    );
\rdata_reg[0]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_31,
      Q => \rdata_reg[0]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[0]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_95,
      Q => \rdata_reg[0]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[10]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_21,
      Q => \rdata_reg[10]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[10]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_85,
      Q => \rdata_reg[10]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[11]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_20,
      Q => \rdata_reg[11]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[11]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_84,
      Q => \rdata_reg[11]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[12]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_19,
      Q => \rdata_reg[12]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[12]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_83,
      Q => \rdata_reg[12]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[13]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_18,
      Q => \rdata_reg[13]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[13]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_82,
      Q => \rdata_reg[13]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[14]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_17,
      Q => \rdata_reg[14]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[14]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_81,
      Q => \rdata_reg[14]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[15]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_16,
      Q => \rdata_reg[15]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[15]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_80,
      Q => \rdata_reg[15]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[16]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_15,
      Q => \rdata_reg[16]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[16]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_79,
      Q => \rdata_reg[16]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[17]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_14,
      Q => \rdata_reg[17]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[17]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_78,
      Q => \rdata_reg[17]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[18]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_13,
      Q => \rdata_reg[18]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[18]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_77,
      Q => \rdata_reg[18]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[19]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_12,
      Q => \rdata_reg[19]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[19]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_76,
      Q => \rdata_reg[19]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[1]_i_7\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_30,
      Q => \rdata_reg[1]_i_7_n_0\,
      R => '0'
    );
\rdata_reg[1]_i_8\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_94,
      Q => \rdata_reg[1]_i_8_n_0\,
      R => '0'
    );
\rdata_reg[20]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_11,
      Q => \rdata_reg[20]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[20]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_75,
      Q => \rdata_reg[20]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[21]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_10,
      Q => \rdata_reg[21]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[21]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_74,
      Q => \rdata_reg[21]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[22]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_9,
      Q => \rdata_reg[22]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[22]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_73,
      Q => \rdata_reg[22]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[23]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_8,
      Q => \rdata_reg[23]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[23]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_72,
      Q => \rdata_reg[23]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[24]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_7,
      Q => \rdata_reg[24]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[24]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_71,
      Q => \rdata_reg[24]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[25]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_6,
      Q => \rdata_reg[25]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[25]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_70,
      Q => \rdata_reg[25]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[26]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_5,
      Q => \rdata_reg[26]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[26]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_69,
      Q => \rdata_reg[26]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[27]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_4,
      Q => \rdata_reg[27]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[27]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_68,
      Q => \rdata_reg[27]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[28]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_3,
      Q => \rdata_reg[28]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[28]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_67,
      Q => \rdata_reg[28]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[29]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_2,
      Q => \rdata_reg[29]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[29]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_66,
      Q => \rdata_reg[29]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[2]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_29,
      Q => \rdata_reg[2]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[2]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_93,
      Q => \rdata_reg[2]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[30]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_1,
      Q => \rdata_reg[30]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[30]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_65,
      Q => \rdata_reg[30]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[31]_i_6\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => control_s_axi_U_n_161,
      Q => \rdata_reg[31]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[31]_i_7\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_0,
      Q => \rdata_reg[31]_i_7_n_0\,
      R => '0'
    );
\rdata_reg[31]_i_8\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => control_s_axi_U_n_163,
      Q => \rdata_reg[31]_i_8_n_0\,
      R => '0'
    );
\rdata_reg[31]_i_9\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_64,
      Q => \rdata_reg[31]_i_9_n_0\,
      R => '0'
    );
\rdata_reg[3]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_28,
      Q => \rdata_reg[3]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[3]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_92,
      Q => \rdata_reg[3]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[4]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_27,
      Q => \rdata_reg[4]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[4]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_91,
      Q => \rdata_reg[4]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[5]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_26,
      Q => \rdata_reg[5]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[5]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_90,
      Q => \rdata_reg[5]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[6]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_25,
      Q => \rdata_reg[6]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[6]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_89,
      Q => \rdata_reg[6]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[7]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_24,
      Q => \rdata_reg[7]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[7]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_88,
      Q => \rdata_reg[7]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[8]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_23,
      Q => \rdata_reg[8]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[8]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_87,
      Q => \rdata_reg[8]_i_6_n_0\,
      R => '0'
    );
\rdata_reg[9]_i_5\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_6_n_0\,
      D => control_s_axi_U_n_22,
      Q => \rdata_reg[9]_i_5_n_0\,
      R => '0'
    );
\rdata_reg[9]_i_6\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => \rdata_reg[31]_i_8_n_0\,
      D => control_s_axi_U_n_86,
      Q => \rdata_reg[9]_i_6_n_0\,
      R => '0'
    );
\temp_reg_93[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => ap_enable_reg_pp0_iter4,
      I1 => icmp_ln7_reg_137_pp0_iter3_reg,
      O => temp_reg_930
    );
\temp_reg_93[0]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(3),
      I1 => temp_reg_93_reg(3),
      O => \temp_reg_93[0]_i_4_n_0\
    );
\temp_reg_93[0]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(2),
      I1 => temp_reg_93_reg(2),
      O => \temp_reg_93[0]_i_5_n_0\
    );
\temp_reg_93[0]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(1),
      I1 => temp_reg_93_reg(1),
      O => \temp_reg_93[0]_i_6_n_0\
    );
\temp_reg_93[0]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(0),
      I1 => temp_reg_93_reg(0),
      O => \temp_reg_93[0]_i_7_n_0\
    );
\temp_reg_93[12]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(15),
      I1 => temp_reg_93_reg(15),
      O => \temp_reg_93[12]_i_2_n_0\
    );
\temp_reg_93[12]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(14),
      I1 => temp_reg_93_reg(14),
      O => \temp_reg_93[12]_i_3_n_0\
    );
\temp_reg_93[12]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(13),
      I1 => temp_reg_93_reg(13),
      O => \temp_reg_93[12]_i_4_n_0\
    );
\temp_reg_93[12]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(12),
      I1 => temp_reg_93_reg(12),
      O => \temp_reg_93[12]_i_5_n_0\
    );
\temp_reg_93[16]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(19),
      I1 => temp_reg_93_reg(19),
      O => \temp_reg_93[16]_i_2_n_0\
    );
\temp_reg_93[16]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(18),
      I1 => temp_reg_93_reg(18),
      O => \temp_reg_93[16]_i_3_n_0\
    );
\temp_reg_93[16]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(17),
      I1 => temp_reg_93_reg(17),
      O => \temp_reg_93[16]_i_4_n_0\
    );
\temp_reg_93[16]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(16),
      I1 => temp_reg_93_reg(16),
      O => \temp_reg_93[16]_i_5_n_0\
    );
\temp_reg_93[20]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(23),
      I1 => temp_reg_93_reg(23),
      O => \temp_reg_93[20]_i_2_n_0\
    );
\temp_reg_93[20]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(22),
      I1 => temp_reg_93_reg(22),
      O => \temp_reg_93[20]_i_3_n_0\
    );
\temp_reg_93[20]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(21),
      I1 => temp_reg_93_reg(21),
      O => \temp_reg_93[20]_i_4_n_0\
    );
\temp_reg_93[20]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(20),
      I1 => temp_reg_93_reg(20),
      O => \temp_reg_93[20]_i_5_n_0\
    );
\temp_reg_93[24]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(27),
      I1 => temp_reg_93_reg(27),
      O => \temp_reg_93[24]_i_2_n_0\
    );
\temp_reg_93[24]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(26),
      I1 => temp_reg_93_reg(26),
      O => \temp_reg_93[24]_i_3_n_0\
    );
\temp_reg_93[24]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(25),
      I1 => temp_reg_93_reg(25),
      O => \temp_reg_93[24]_i_4_n_0\
    );
\temp_reg_93[24]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(24),
      I1 => temp_reg_93_reg(24),
      O => \temp_reg_93[24]_i_5_n_0\
    );
\temp_reg_93[28]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => temp_reg_93_reg(31),
      I1 => mul_ln9_reg_161(31),
      O => \temp_reg_93[28]_i_2_n_0\
    );
\temp_reg_93[28]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(30),
      I1 => temp_reg_93_reg(30),
      O => \temp_reg_93[28]_i_3_n_0\
    );
\temp_reg_93[28]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(29),
      I1 => temp_reg_93_reg(29),
      O => \temp_reg_93[28]_i_4_n_0\
    );
\temp_reg_93[28]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(28),
      I1 => temp_reg_93_reg(28),
      O => \temp_reg_93[28]_i_5_n_0\
    );
\temp_reg_93[4]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(7),
      I1 => temp_reg_93_reg(7),
      O => \temp_reg_93[4]_i_2_n_0\
    );
\temp_reg_93[4]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(6),
      I1 => temp_reg_93_reg(6),
      O => \temp_reg_93[4]_i_3_n_0\
    );
\temp_reg_93[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(5),
      I1 => temp_reg_93_reg(5),
      O => \temp_reg_93[4]_i_4_n_0\
    );
\temp_reg_93[4]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(4),
      I1 => temp_reg_93_reg(4),
      O => \temp_reg_93[4]_i_5_n_0\
    );
\temp_reg_93[8]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(11),
      I1 => temp_reg_93_reg(11),
      O => \temp_reg_93[8]_i_2_n_0\
    );
\temp_reg_93[8]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(10),
      I1 => temp_reg_93_reg(10),
      O => \temp_reg_93[8]_i_3_n_0\
    );
\temp_reg_93[8]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(9),
      I1 => temp_reg_93_reg(9),
      O => \temp_reg_93[8]_i_4_n_0\
    );
\temp_reg_93[8]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => mul_ln9_reg_161(8),
      I1 => temp_reg_93_reg(8),
      O => \temp_reg_93[8]_i_5_n_0\
    );
\temp_reg_93_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[0]_i_3_n_7\,
      Q => temp_reg_93_reg(0),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[0]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \temp_reg_93_reg[0]_i_3_n_0\,
      CO(2) => \temp_reg_93_reg[0]_i_3_n_1\,
      CO(1) => \temp_reg_93_reg[0]_i_3_n_2\,
      CO(0) => \temp_reg_93_reg[0]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => mul_ln9_reg_161(3 downto 0),
      O(3) => \temp_reg_93_reg[0]_i_3_n_4\,
      O(2) => \temp_reg_93_reg[0]_i_3_n_5\,
      O(1) => \temp_reg_93_reg[0]_i_3_n_6\,
      O(0) => \temp_reg_93_reg[0]_i_3_n_7\,
      S(3) => \temp_reg_93[0]_i_4_n_0\,
      S(2) => \temp_reg_93[0]_i_5_n_0\,
      S(1) => \temp_reg_93[0]_i_6_n_0\,
      S(0) => \temp_reg_93[0]_i_7_n_0\
    );
\temp_reg_93_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[8]_i_1_n_5\,
      Q => temp_reg_93_reg(10),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[8]_i_1_n_4\,
      Q => temp_reg_93_reg(11),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[12]_i_1_n_7\,
      Q => temp_reg_93_reg(12),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \temp_reg_93_reg[8]_i_1_n_0\,
      CO(3) => \temp_reg_93_reg[12]_i_1_n_0\,
      CO(2) => \temp_reg_93_reg[12]_i_1_n_1\,
      CO(1) => \temp_reg_93_reg[12]_i_1_n_2\,
      CO(0) => \temp_reg_93_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => mul_ln9_reg_161(15 downto 12),
      O(3) => \temp_reg_93_reg[12]_i_1_n_4\,
      O(2) => \temp_reg_93_reg[12]_i_1_n_5\,
      O(1) => \temp_reg_93_reg[12]_i_1_n_6\,
      O(0) => \temp_reg_93_reg[12]_i_1_n_7\,
      S(3) => \temp_reg_93[12]_i_2_n_0\,
      S(2) => \temp_reg_93[12]_i_3_n_0\,
      S(1) => \temp_reg_93[12]_i_4_n_0\,
      S(0) => \temp_reg_93[12]_i_5_n_0\
    );
\temp_reg_93_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[12]_i_1_n_6\,
      Q => temp_reg_93_reg(13),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[12]_i_1_n_5\,
      Q => temp_reg_93_reg(14),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[12]_i_1_n_4\,
      Q => temp_reg_93_reg(15),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[16]_i_1_n_7\,
      Q => temp_reg_93_reg(16),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \temp_reg_93_reg[12]_i_1_n_0\,
      CO(3) => \temp_reg_93_reg[16]_i_1_n_0\,
      CO(2) => \temp_reg_93_reg[16]_i_1_n_1\,
      CO(1) => \temp_reg_93_reg[16]_i_1_n_2\,
      CO(0) => \temp_reg_93_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => mul_ln9_reg_161(19 downto 16),
      O(3) => \temp_reg_93_reg[16]_i_1_n_4\,
      O(2) => \temp_reg_93_reg[16]_i_1_n_5\,
      O(1) => \temp_reg_93_reg[16]_i_1_n_6\,
      O(0) => \temp_reg_93_reg[16]_i_1_n_7\,
      S(3) => \temp_reg_93[16]_i_2_n_0\,
      S(2) => \temp_reg_93[16]_i_3_n_0\,
      S(1) => \temp_reg_93[16]_i_4_n_0\,
      S(0) => \temp_reg_93[16]_i_5_n_0\
    );
\temp_reg_93_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[16]_i_1_n_6\,
      Q => temp_reg_93_reg(17),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[16]_i_1_n_5\,
      Q => temp_reg_93_reg(18),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[16]_i_1_n_4\,
      Q => temp_reg_93_reg(19),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[0]_i_3_n_6\,
      Q => temp_reg_93_reg(1),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[20]_i_1_n_7\,
      Q => temp_reg_93_reg(20),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \temp_reg_93_reg[16]_i_1_n_0\,
      CO(3) => \temp_reg_93_reg[20]_i_1_n_0\,
      CO(2) => \temp_reg_93_reg[20]_i_1_n_1\,
      CO(1) => \temp_reg_93_reg[20]_i_1_n_2\,
      CO(0) => \temp_reg_93_reg[20]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => mul_ln9_reg_161(23 downto 20),
      O(3) => \temp_reg_93_reg[20]_i_1_n_4\,
      O(2) => \temp_reg_93_reg[20]_i_1_n_5\,
      O(1) => \temp_reg_93_reg[20]_i_1_n_6\,
      O(0) => \temp_reg_93_reg[20]_i_1_n_7\,
      S(3) => \temp_reg_93[20]_i_2_n_0\,
      S(2) => \temp_reg_93[20]_i_3_n_0\,
      S(1) => \temp_reg_93[20]_i_4_n_0\,
      S(0) => \temp_reg_93[20]_i_5_n_0\
    );
\temp_reg_93_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[20]_i_1_n_6\,
      Q => temp_reg_93_reg(21),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[20]_i_1_n_5\,
      Q => temp_reg_93_reg(22),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[20]_i_1_n_4\,
      Q => temp_reg_93_reg(23),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[24]_i_1_n_7\,
      Q => temp_reg_93_reg(24),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \temp_reg_93_reg[20]_i_1_n_0\,
      CO(3) => \temp_reg_93_reg[24]_i_1_n_0\,
      CO(2) => \temp_reg_93_reg[24]_i_1_n_1\,
      CO(1) => \temp_reg_93_reg[24]_i_1_n_2\,
      CO(0) => \temp_reg_93_reg[24]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => mul_ln9_reg_161(27 downto 24),
      O(3) => \temp_reg_93_reg[24]_i_1_n_4\,
      O(2) => \temp_reg_93_reg[24]_i_1_n_5\,
      O(1) => \temp_reg_93_reg[24]_i_1_n_6\,
      O(0) => \temp_reg_93_reg[24]_i_1_n_7\,
      S(3) => \temp_reg_93[24]_i_2_n_0\,
      S(2) => \temp_reg_93[24]_i_3_n_0\,
      S(1) => \temp_reg_93[24]_i_4_n_0\,
      S(0) => \temp_reg_93[24]_i_5_n_0\
    );
\temp_reg_93_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[24]_i_1_n_6\,
      Q => temp_reg_93_reg(25),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[24]_i_1_n_5\,
      Q => temp_reg_93_reg(26),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[24]_i_1_n_4\,
      Q => temp_reg_93_reg(27),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[28]_i_1_n_7\,
      Q => temp_reg_93_reg(28),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \temp_reg_93_reg[24]_i_1_n_0\,
      CO(3) => \NLW_temp_reg_93_reg[28]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \temp_reg_93_reg[28]_i_1_n_1\,
      CO(1) => \temp_reg_93_reg[28]_i_1_n_2\,
      CO(0) => \temp_reg_93_reg[28]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => mul_ln9_reg_161(30 downto 28),
      O(3) => \temp_reg_93_reg[28]_i_1_n_4\,
      O(2) => \temp_reg_93_reg[28]_i_1_n_5\,
      O(1) => \temp_reg_93_reg[28]_i_1_n_6\,
      O(0) => \temp_reg_93_reg[28]_i_1_n_7\,
      S(3) => \temp_reg_93[28]_i_2_n_0\,
      S(2) => \temp_reg_93[28]_i_3_n_0\,
      S(1) => \temp_reg_93[28]_i_4_n_0\,
      S(0) => \temp_reg_93[28]_i_5_n_0\
    );
\temp_reg_93_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[28]_i_1_n_6\,
      Q => temp_reg_93_reg(29),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[0]_i_3_n_5\,
      Q => temp_reg_93_reg(2),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[28]_i_1_n_5\,
      Q => temp_reg_93_reg(30),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[28]_i_1_n_4\,
      Q => temp_reg_93_reg(31),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[0]_i_3_n_4\,
      Q => temp_reg_93_reg(3),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[4]_i_1_n_7\,
      Q => temp_reg_93_reg(4),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \temp_reg_93_reg[0]_i_3_n_0\,
      CO(3) => \temp_reg_93_reg[4]_i_1_n_0\,
      CO(2) => \temp_reg_93_reg[4]_i_1_n_1\,
      CO(1) => \temp_reg_93_reg[4]_i_1_n_2\,
      CO(0) => \temp_reg_93_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => mul_ln9_reg_161(7 downto 4),
      O(3) => \temp_reg_93_reg[4]_i_1_n_4\,
      O(2) => \temp_reg_93_reg[4]_i_1_n_5\,
      O(1) => \temp_reg_93_reg[4]_i_1_n_6\,
      O(0) => \temp_reg_93_reg[4]_i_1_n_7\,
      S(3) => \temp_reg_93[4]_i_2_n_0\,
      S(2) => \temp_reg_93[4]_i_3_n_0\,
      S(1) => \temp_reg_93[4]_i_4_n_0\,
      S(0) => \temp_reg_93[4]_i_5_n_0\
    );
\temp_reg_93_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[4]_i_1_n_6\,
      Q => temp_reg_93_reg(5),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[4]_i_1_n_5\,
      Q => temp_reg_93_reg(6),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[4]_i_1_n_4\,
      Q => temp_reg_93_reg(7),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[8]_i_1_n_7\,
      Q => temp_reg_93_reg(8),
      R => ap_NS_fsm1
    );
\temp_reg_93_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \temp_reg_93_reg[4]_i_1_n_0\,
      CO(3) => \temp_reg_93_reg[8]_i_1_n_0\,
      CO(2) => \temp_reg_93_reg[8]_i_1_n_1\,
      CO(1) => \temp_reg_93_reg[8]_i_1_n_2\,
      CO(0) => \temp_reg_93_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => mul_ln9_reg_161(11 downto 8),
      O(3) => \temp_reg_93_reg[8]_i_1_n_4\,
      O(2) => \temp_reg_93_reg[8]_i_1_n_5\,
      O(1) => \temp_reg_93_reg[8]_i_1_n_6\,
      O(0) => \temp_reg_93_reg[8]_i_1_n_7\,
      S(3) => \temp_reg_93[8]_i_2_n_0\,
      S(2) => \temp_reg_93[8]_i_3_n_0\,
      S(1) => \temp_reg_93[8]_i_4_n_0\,
      S(0) => \temp_reg_93[8]_i_5_n_0\
    );
\temp_reg_93_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => temp_reg_930,
      D => \temp_reg_93_reg[8]_i_1_n_6\,
      Q => temp_reg_93_reg(9),
      R => ap_NS_fsm1
    );
\tmp_product__0_i_18\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_111,
      Q => \tmp_product__0_i_18_n_0\,
      R => '0'
    );
\tmp_product__0_i_19\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_112,
      Q => \tmp_product__0_i_19_n_0\,
      R => '0'
    );
\tmp_product__0_i_20\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_113,
      Q => \tmp_product__0_i_20_n_0\,
      R => '0'
    );
\tmp_product__0_i_21\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_114,
      Q => \tmp_product__0_i_21_n_0\,
      R => '0'
    );
\tmp_product__0_i_22\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_115,
      Q => \tmp_product__0_i_22_n_0\,
      R => '0'
    );
\tmp_product__0_i_23\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_116,
      Q => \tmp_product__0_i_23_n_0\,
      R => '0'
    );
\tmp_product__0_i_24\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_117,
      Q => \tmp_product__0_i_24_n_0\,
      R => '0'
    );
\tmp_product__0_i_25\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_118,
      Q => \tmp_product__0_i_25_n_0\,
      R => '0'
    );
\tmp_product__0_i_26\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_119,
      Q => \tmp_product__0_i_26_n_0\,
      R => '0'
    );
\tmp_product__0_i_27\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_120,
      Q => \tmp_product__0_i_27_n_0\,
      R => '0'
    );
\tmp_product__0_i_28\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_121,
      Q => \tmp_product__0_i_28_n_0\,
      R => '0'
    );
\tmp_product__0_i_29\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_122,
      Q => \tmp_product__0_i_29_n_0\,
      R => '0'
    );
\tmp_product__0_i_30\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_123,
      Q => \tmp_product__0_i_30_n_0\,
      R => '0'
    );
\tmp_product__0_i_31\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_124,
      Q => \tmp_product__0_i_31_n_0\,
      R => '0'
    );
\tmp_product__0_i_32\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_125,
      Q => \tmp_product__0_i_32_n_0\,
      R => '0'
    );
\tmp_product__0_i_33\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_126,
      Q => \tmp_product__0_i_33_n_0\,
      R => '0'
    );
\tmp_product__0_i_34\: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_127,
      Q => \tmp_product__0_i_34_n_0\,
      R => '0'
    );
tmp_product_i_34: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => ap_clk,
      CE => '1',
      D => a_ce0,
      Q => tmp_product_i_34_n_0,
      R => '0'
    );
tmp_product_i_35: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_96,
      Q => tmp_product_i_35_n_0,
      R => '0'
    );
tmp_product_i_36: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_97,
      Q => tmp_product_i_36_n_0,
      R => '0'
    );
tmp_product_i_37: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_98,
      Q => tmp_product_i_37_n_0,
      R => '0'
    );
tmp_product_i_38: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_99,
      Q => tmp_product_i_38_n_0,
      R => '0'
    );
tmp_product_i_39: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_100,
      Q => tmp_product_i_39_n_0,
      R => '0'
    );
tmp_product_i_40: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_101,
      Q => tmp_product_i_40_n_0,
      R => '0'
    );
tmp_product_i_41: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_102,
      Q => tmp_product_i_41_n_0,
      R => '0'
    );
tmp_product_i_42: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_103,
      Q => tmp_product_i_42_n_0,
      R => '0'
    );
tmp_product_i_43: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_104,
      Q => tmp_product_i_43_n_0,
      R => '0'
    );
tmp_product_i_44: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_105,
      Q => tmp_product_i_44_n_0,
      R => '0'
    );
tmp_product_i_45: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_106,
      Q => tmp_product_i_45_n_0,
      R => '0'
    );
tmp_product_i_46: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_107,
      Q => tmp_product_i_46_n_0,
      R => '0'
    );
tmp_product_i_47: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_108,
      Q => tmp_product_i_47_n_0,
      R => '0'
    );
tmp_product_i_48: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_109,
      Q => tmp_product_i_48_n_0,
      R => '0'
    );
tmp_product_i_49: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_110,
      Q => tmp_product_i_49_n_0,
      R => '0'
    );
tmp_product_i_50: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_47,
      Q => tmp_product_i_50_n_0,
      R => '0'
    );
tmp_product_i_51: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_48,
      Q => tmp_product_i_51_n_0,
      R => '0'
    );
tmp_product_i_52: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_49,
      Q => tmp_product_i_52_n_0,
      R => '0'
    );
tmp_product_i_53: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_50,
      Q => tmp_product_i_53_n_0,
      R => '0'
    );
tmp_product_i_54: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_51,
      Q => tmp_product_i_54_n_0,
      R => '0'
    );
tmp_product_i_55: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_52,
      Q => tmp_product_i_55_n_0,
      R => '0'
    );
tmp_product_i_56: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_53,
      Q => tmp_product_i_56_n_0,
      R => '0'
    );
tmp_product_i_57: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_54,
      Q => tmp_product_i_57_n_0,
      R => '0'
    );
tmp_product_i_58: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_55,
      Q => tmp_product_i_58_n_0,
      R => '0'
    );
tmp_product_i_59: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_56,
      Q => tmp_product_i_59_n_0,
      R => '0'
    );
tmp_product_i_60: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_57,
      Q => tmp_product_i_60_n_0,
      R => '0'
    );
tmp_product_i_61: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_58,
      Q => tmp_product_i_61_n_0,
      R => '0'
    );
tmp_product_i_62: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_59,
      Q => tmp_product_i_62_n_0,
      R => '0'
    );
tmp_product_i_63: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_60,
      Q => tmp_product_i_63_n_0,
      R => '0'
    );
tmp_product_i_64: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_61,
      Q => tmp_product_i_64_n_0,
      R => '0'
    );
tmp_product_i_65: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_62,
      Q => tmp_product_i_65_n_0,
      R => '0'
    );
tmp_product_i_66: unisim.vcomponents.FDRE
     port map (
      C => ap_clk,
      CE => tmp_product_i_34_n_0,
      D => control_s_axi_U_n_63,
      Q => tmp_product_i_66_n_0,
      R => '0'
    );
tmp_product_i_67: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ap_CS_fsm_pp0_stage0,
      I1 => ap_enable_reg_pp0_iter0,
      O => a_ce0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_muladd_0_0 is
  port (
    s_axi_control_AWADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_control_AWVALID : in STD_LOGIC;
    s_axi_control_AWREADY : out STD_LOGIC;
    s_axi_control_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_WVALID : in STD_LOGIC;
    s_axi_control_WREADY : out STD_LOGIC;
    s_axi_control_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_BVALID : out STD_LOGIC;
    s_axi_control_BREADY : in STD_LOGIC;
    s_axi_control_ARADDR : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_control_ARVALID : in STD_LOGIC;
    s_axi_control_ARREADY : out STD_LOGIC;
    s_axi_control_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_RVALID : out STD_LOGIC;
    s_axi_control_RREADY : in STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    interrupt : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_muladd_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_muladd_0_0 : entity is "design_1_muladd_0_0,muladd,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_muladd_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_muladd_0_0 : entity is "HLS";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_muladd_0_0 : entity is "muladd,Vivado 2020.2";
  attribute hls_module : string;
  attribute hls_module of design_1_muladd_0_0 : entity is "yes";
end design_1_muladd_0_0;

architecture STRUCTURE of design_1_muladd_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal NLW_inst_s_axi_control_BRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_inst_s_axi_control_RRESP_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_S_AXI_CONTROL_ADDR_WIDTH : integer;
  attribute C_S_AXI_CONTROL_ADDR_WIDTH of inst : label is 8;
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
  attribute ap_ST_fsm_pp0_stage0 : string;
  attribute ap_ST_fsm_pp0_stage0 of inst : label is "3'b010";
  attribute ap_ST_fsm_state1 : string;
  attribute ap_ST_fsm_state1 of inst : label is "3'b001";
  attribute ap_ST_fsm_state7 : string;
  attribute ap_ST_fsm_state7 of inst : label is "3'b100";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ap_clk : signal is "xilinx.com:signal:clock:1.0 ap_clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ap_clk : signal is "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_control, ASSOCIATED_RESET ap_rst_n, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of ap_rst_n : signal is "xilinx.com:signal:reset:1.0 ap_rst_n RST";
  attribute X_INTERFACE_PARAMETER of ap_rst_n : signal is "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of interrupt : signal is "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT";
  attribute X_INTERFACE_PARAMETER of interrupt : signal is "XIL_INTERFACENAME interrupt, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute X_INTERFACE_INFO of s_axi_control_ARREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARREADY";
  attribute X_INTERFACE_INFO of s_axi_control_ARVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARVALID";
  attribute X_INTERFACE_INFO of s_axi_control_AWREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWREADY";
  attribute X_INTERFACE_INFO of s_axi_control_AWVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWVALID";
  attribute X_INTERFACE_INFO of s_axi_control_BREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BREADY";
  attribute X_INTERFACE_INFO of s_axi_control_BVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BVALID";
  attribute X_INTERFACE_INFO of s_axi_control_RREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RREADY";
  attribute X_INTERFACE_PARAMETER of s_axi_control_RREADY : signal is "XIL_INTERFACENAME s_axi_control, ADDR_WIDTH 8, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, FREQ_HZ 100000000, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_control_RVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RVALID";
  attribute X_INTERFACE_INFO of s_axi_control_WREADY : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WREADY";
  attribute X_INTERFACE_INFO of s_axi_control_WVALID : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WVALID";
  attribute X_INTERFACE_INFO of s_axi_control_ARADDR : signal is "xilinx.com:interface:aximm:1.0 s_axi_control ARADDR";
  attribute X_INTERFACE_INFO of s_axi_control_AWADDR : signal is "xilinx.com:interface:aximm:1.0 s_axi_control AWADDR";
  attribute X_INTERFACE_INFO of s_axi_control_BRESP : signal is "xilinx.com:interface:aximm:1.0 s_axi_control BRESP";
  attribute X_INTERFACE_INFO of s_axi_control_RDATA : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RDATA";
  attribute X_INTERFACE_INFO of s_axi_control_RRESP : signal is "xilinx.com:interface:aximm:1.0 s_axi_control RRESP";
  attribute X_INTERFACE_INFO of s_axi_control_WDATA : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WDATA";
  attribute X_INTERFACE_INFO of s_axi_control_WSTRB : signal is "xilinx.com:interface:aximm:1.0 s_axi_control WSTRB";
begin
  s_axi_control_BRESP(1) <= \<const0>\;
  s_axi_control_BRESP(0) <= \<const0>\;
  s_axi_control_RRESP(1) <= \<const0>\;
  s_axi_control_RRESP(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.design_1_muladd_0_0_muladd
     port map (
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      interrupt => interrupt,
      s_axi_control_ARADDR(7 downto 0) => s_axi_control_ARADDR(7 downto 0),
      s_axi_control_ARREADY => s_axi_control_ARREADY,
      s_axi_control_ARVALID => s_axi_control_ARVALID,
      s_axi_control_AWADDR(7 downto 0) => s_axi_control_AWADDR(7 downto 0),
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
      s_axi_control_WVALID => s_axi_control_WVALID
    );
end STRUCTURE;
