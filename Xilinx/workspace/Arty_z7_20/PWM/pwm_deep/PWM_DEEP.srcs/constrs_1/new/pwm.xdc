# Clock Signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];#set

# reset sw
set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports { RESET }];

# output pwm port

# output led