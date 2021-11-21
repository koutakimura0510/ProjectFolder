## Clock Signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];#set

## Switches
set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports { RESET }]; #IO_L7N_T1_AD2N_35 Sch=SW0

## RGB LEDs
set_property -dict { PACKAGE_PIN L15    IOSTANDARD LVCMOS33 } [get_ports { LED1[0] }]; #IO_L22N_T3_AD7P_35 Sch=LED4_B
set_property -dict { PACKAGE_PIN G17    IOSTANDARD LVCMOS33 } [get_ports { LED1[1] }]; #IO_L16P_T2_35 Sch=LED4_G
set_property -dict { PACKAGE_PIN N15    IOSTANDARD LVCMOS33 } [get_ports { LED1[2] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=LED4_R
set_property -dict { PACKAGE_PIN G14    IOSTANDARD LVCMOS33 } [get_ports { LED2[0] }]; #IO_0_35 Sch=LED5_B
set_property -dict { PACKAGE_PIN L14    IOSTANDARD LVCMOS33 } [get_ports { LED2[1] }]; #IO_L22P_T3_AD7P_35 Sch=LED5_G
set_property -dict { PACKAGE_PIN M15    IOSTANDARD LVCMOS33 } [get_ports { LED2[2] }]; #IO_L23N_T3_35 Sch=LED5_R

## Pmod Header JA
# set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { JA_P1 }]; #IO_L17P_T2_34 Sch=JA1_P
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { BTN[0] }]; #IO_L17N_T2_34 Sch=JA1_N
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { BTN[1] }]; #IO_L7P_T1_34 Sch=JA2_P
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { BTN[2] }]; #IO_L7N_T1_34 Sch=JA2_N
# set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { JA_P3 }]; #IO_L12P_T1_MRCC_34 Sch=JA3_P
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { BTN[3] }]; #IO_L12N_T1_MRCC_34 Sch=JA3_N
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { BTN[4] }]; #IO_L22P_T3_34 Sch=JA4_P
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { BTN[5] }]; #IO_L22N_T3_34 Sch=JA4_N
