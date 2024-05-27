#CLK
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { CLK }];		#IO_L13P_T2_MRCC_35 Sch=CLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];	#set

#RESET
set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports { RESET }];	#IO_L7N_T1_AD2N_35 Sch=RESET

#LED
set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports { LED1 }];	#IO_L6N_T0_VREF_34 Sch=LED0

#RGB LEDS
#set_property -dict { PACKAGE_PIN L15    IOSTANDARD LVCMOS33 } [get_ports { LED1_B }]; #IO_L22N_T3_AD7P_35 Sch=LED4_B
#set_property -dict { PACKAGE_PIN G17    IOSTANDARD LVCMOS33 } [get_ports { LED1_G }]; #IO_L16P_T2_35 Sch=LED4_G
#set_property -dict { PACKAGE_PIN N15    IOSTANDARD LVCMOS33 } [get_ports { LED1_R }]; #IO_L21P_T3_DQS_AD14P_35 Sch=LED4_R
#set_property -dict { PACKAGE_PIN G14    IOSTANDARD LVCMOS33 } [get_ports { LED2_B }]; #IO_0_35 Sch=LED5_B
#set_property -dict { PACKAGE_PIN L14    IOSTANDARD LVCMOS33 } [get_ports { LED2_G }]; #IO_L22P_T3_AD7P_35 Sch=LED5_G
#set_property -dict { PACKAGE_PIN M15    IOSTANDARD LVCMOS33 } [get_ports { LED2_R }]; #IO_L23N_T3_35 Sch=LED5_R