# Clock Signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }]; #set

# slide sw
set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports { SLIDE_SW[0] }]; #IO_L7N_T1_AD2N_35 Sch=SW0
set_property -dict { PACKAGE_PIN M19    IOSTANDARD LVCMOS33 } [get_ports { SLIDE_SW[1] }]; #IO_L7P_T1_AD2P_35 Sch=SW1

# output pwm port
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { CK_IO8  }]; #IO_L21P_T3_DQS_34       Sch=CK_IO8
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { AUD_PWM }]; #IO_L20N_T3_34 Sch=AUD_PWM

# output led
set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports { LED1 }];	#IO_L6N_T0_VREF_34 Sch=LED0