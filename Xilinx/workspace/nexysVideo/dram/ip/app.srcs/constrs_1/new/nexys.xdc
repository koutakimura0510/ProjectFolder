# Clock Signal
set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { iCLK }]; #IO_L13P_T2_MRCC_34 Sch=sysclk
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5.000} [get_ports iCLK]

# LEDs
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { oLED[0] }]; #IO_L15P_T2_DQS_13 Sch=led[0]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { oLED[1] }]; #IO_L15N_T2_DQS_13 Sch=led[1]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS25 } [get_ports { oLED[2] }]; #IO_L17P_T2_13 Sch=led[2]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS25 } [get_ports { oLED[3] }]; #IO_L17N_T2_13 Sch=led[3]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { oLED[4] }]; #IO_L14N_T2_SRCC_13 Sch=led[4]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { oLED[5] }]; #IO_L16N_T2_13 Sch=led[5]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { oLED[6] }]; #IO_L16P_T2_13 Sch=led[6]
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { oLED[7] }]; #IO_L5P_T0_13 Sch=led[7]

## Buttons
# set_property -dict { PACKAGE_PIN B22 IOSTANDARD LVCMOS12 } [get_ports { iBtnC }]; #IO_L20N_T3_16 Sch=btnc
set_property -dict { PACKAGE_PIN D22 IOSTANDARD LVCMOS12 } [get_ports { iBtnD }]; #IO_L22N_T3_16 Sch=btnd
#set_property -dict { PACKAGE_PIN C22 IOSTANDARD LVCMOS12 } [get_ports { btnl }]; #IO_L20P_T3_16 Sch=btnl
#set_property -dict { PACKAGE_PIN D14 IOSTANDARD LVCMOS12 } [get_ports { btnr }]; #IO_L6P_T0_16 Sch=btnr
set_property -dict { PACKAGE_PIN F15 IOSTANDARD LVCMOS12 } [get_ports { iBtnU }]; #IO_0_16 Sch=btnu
set_property -dict { PACKAGE_PIN G4  IOSTANDARD LVCMOS12 } [get_ports { iRST }]; #IO_L12N_T1_MRCC_35 Sch=cpu_resetn

## DDR3 Port MIGを使用したらvivado上でDDRメモリのxdcファイルが生成されるため記述しない
# set_property -dict { PACKAGE_PIN M2   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[0] }]; #IO_L16N_T2_35 Sch=ddr3_addr[0]
# set_property -dict { PACKAGE_PIN M5   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[1] }]; #IO_L23N_T3_35 Sch=ddr3_addr[1]
# set_property -dict { PACKAGE_PIN L5   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[10] }]; #IO_L18P_T2_35 Sch=ddr3_addr[10]
# set_property -dict { PACKAGE_PIN N5   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[11] }]; #IO_L24N_T3_35 Sch=ddr3_addr[11]
# set_property -dict { PACKAGE_PIN N4   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[12] }]; #IO_L19P_T3_35 Sch=ddr3_addr[12]
# set_property -dict { PACKAGE_PIN P2   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[13] }]; #IO_L22P_T3_35 Sch=ddr3_addr[13]
# set_property -dict { PACKAGE_PIN P6   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[14] }]; #IO_L24P_T3_35 Sch=ddr3_addr[14]
# set_property -dict { PACKAGE_PIN M3   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[2] }]; #IO_L16P_T2_35 Sch=ddr3_addr[2]
# set_property -dict { PACKAGE_PIN M1   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[3] }]; #IO_L15P_T2_DQS_35 Sch=ddr3_addr[3]
# set_property -dict { PACKAGE_PIN L6   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[4] }]; #IO_25_35 Sch=ddr3_addr[4]
# set_property -dict { PACKAGE_PIN P1   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[5] }]; #IO_L20N_T3_35 Sch=ddr3_addr[5]
# set_property -dict { PACKAGE_PIN N3   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[6] }]; #IO_L19N_T3_VREF_35 Sch=ddr3_addr[6]
# set_property -dict { PACKAGE_PIN N2   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[7] }]; #IO_L22N_T3_35 Sch=ddr3_addr[7]
# set_property -dict { PACKAGE_PIN M6   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[8] }]; #IO_L23P_T3_35 Sch=ddr3_addr[8]
# set_property -dict { PACKAGE_PIN R1   IOSTANDARD SSTL15         } [get_ports { oDDR3_ADDR[9] }]; #IO_L20P_T3_35 Sch=ddr3_addr[9]
# set_property -dict { PACKAGE_PIN L3   IOSTANDARD SSTL15         } [get_ports { oDDR3_BA[0] }]; #IO_L14P_T2_SRCC_35 Sch=ddr3_ba[0]
# set_property -dict { PACKAGE_PIN K6   IOSTANDARD SSTL15         } [get_ports { oDDR3_BA[1] }]; #IO_L17P_T2_35 Sch=ddr3_ba[1]
# set_property -dict { PACKAGE_PIN L4   IOSTANDARD SSTL15         } [get_ports { oDDR3_BA[2] }]; #IO_L18N_T2_35 Sch=ddr3_ba[2]
# set_property -dict { PACKAGE_PIN K3   IOSTANDARD SSTL15         } [get_ports { oDDR3_CAS }]; #IO_L14N_T2_SRCC_35 Sch=ddr3_cas
# set_property -dict { PACKAGE_PIN J6   IOSTANDARD SSTL15         } [get_ports { oDDR3_CKE[0] }]; #IO_L17N_T2_35 Sch=ddr3_cke[0]
# set_property -dict { PACKAGE_PIN P4   IOSTANDARD DIFF_SSTL15    } [get_ports { oDDR3_CLK_N[0] }]; #IO_L21N_T3_DQS_35 Sch=ddr3_clk_n[0]
# set_property -dict { PACKAGE_PIN P5   IOSTANDARD DIFF_SSTL15    } [get_ports { oDDR3_CLK_P[0] }]; #IO_L21P_T3_DQS_35 Sch=ddr3_clk_p[0]
# set_property -dict { PACKAGE_PIN G3   IOSTANDARD SSTL15         } [get_ports { oDDR3_DM[0] }]; #IO_L11N_T1_SRCC_35 Sch=ddr3_dm[0]
# set_property -dict { PACKAGE_PIN F1   IOSTANDARD SSTL15         } [get_ports { oDDR3_DM[1] }]; #IO_L5N_T0_AD13N_35 Sch=ddr3_dm[1]
# set_property -dict { PACKAGE_PIN G2   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[0] }]; #IO_L8N_T1_AD14N_35 Sch=ddr3_dq[0]
# set_property -dict { PACKAGE_PIN H4   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[1] }]; #IO_L12P_T1_MRCC_35 Sch=ddr3_dq[1]
# set_property -dict { PACKAGE_PIN F3   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[10] }]; #IO_L6P_T0_35 Sch=ddr3_dq[10]
# set_property -dict { PACKAGE_PIN D2   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[11] }]; #IO_L4N_T0_35 Sch=ddr3_dq[11]
# set_property -dict { PACKAGE_PIN C2   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[12] }]; #IO_L2P_T0_AD12P_35 Sch=ddr3_dq[12]
# set_property -dict { PACKAGE_PIN A1   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[13] }]; #IO_L1N_T0_AD4N_35 Sch=ddr3_dq[13]
# set_property -dict { PACKAGE_PIN E2   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[14] }]; #IO_L4P_T0_35 Sch=ddr3_dq[14]
# set_property -dict { PACKAGE_PIN B1   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[15] }]; #IO_L1P_T0_AD4P_35 Sch=ddr3_dq[15]
# set_property -dict { PACKAGE_PIN H5   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[2] }]; #IO_L10N_T1_AD15N_35 Sch=ddr3_dq[2]
# set_property -dict { PACKAGE_PIN J1   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[3] }]; #IO_L7N_T1_AD6N_35 Sch=ddr3_dq[3]
# set_property -dict { PACKAGE_PIN K1   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[4] }]; #IO_L7P_T1_AD6P_35 Sch=ddr3_dq[4]
# set_property -dict { PACKAGE_PIN H3   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[5] }]; #IO_L11P_T1_SRCC_35 Sch=ddr3_dq[5]
# set_property -dict { PACKAGE_PIN H2   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[6] }]; #IO_L8P_T1_AD14P_35 Sch=ddr3_dq[6]
# set_property -dict { PACKAGE_PIN J5   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[7] }]; #IO_L10P_T1_AD15P_35 Sch=ddr3_dq[7]
# set_property -dict { PACKAGE_PIN E3   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[8] }]; #IO_L6N_T0_VREF_35 Sch=ddr3_dq[8]
# set_property -dict { PACKAGE_PIN B2   IOSTANDARD SSTL15         } [get_ports { ioDDR3_DQ[9] }]; #IO_L2N_T0_AD12N_35 Sch=ddr3_dq[9]
# set_property -dict { PACKAGE_PIN J2   IOSTANDARD DIFF_SSTL15    } [get_ports { ioDDR3_DQS_N[0] }]; #IO_L9N_T1_DQS_AD7N_35 Sch=ddr3_dqs_n[0]
# set_property -dict { PACKAGE_PIN K2   IOSTANDARD DIFF_SSTL15    } [get_ports { ioDDR3_DQS_P[0] }]; #IO_L9P_T1_DQS_AD7P_35 Sch=ddr3_dqs_p[0]
# set_property -dict { PACKAGE_PIN D1   IOSTANDARD DIFF_SSTL15    } [get_ports { ioDDR3_DQS_N[1] }]; #IO_L3N_T0_DQS_AD5N_35 Sch=ddr3_dqs_n[1]
# set_property -dict { PACKAGE_PIN E1   IOSTANDARD DIFF_SSTL15    } [get_ports { ioDDR3_DQS_P[1] }]; #IO_L3P_T0_DQS_AD5P_35 Sch=ddr3_dqs_p[1]
# set_property -dict { PACKAGE_PIN K4   IOSTANDARD SSTL15         } [get_ports { oDDR3_ODT }]; #IO_L13P_T2_MRCC_35 Sch=ddr3_odt
# set_property -dict { PACKAGE_PIN J4   IOSTANDARD SSTL15         } [get_ports { oDDR3_RAS }]; #IO_L13N_T2_MRCC_35 Sch=ddr3_ras
# set_property -dict { PACKAGE_PIN G1   IOSTANDARD LVCMOS15       } [get_ports { oDDR3_RESET }]; #IO_L5P_T0_AD13P_35 Sch=ddr3_reset
# set_property -dict { PACKAGE_PIN L1   IOSTANDARD SSTL15         } [get_ports { oDDR3_WE }]; #IO_L15N_T2_DQS_35 Sch=ddr3_we