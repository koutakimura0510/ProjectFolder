## Clock Signal
#set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
#create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];#set


## Switches
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports RESET];


## ChipKit Outer Digital Header
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports BCLK];
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports SDATA];
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports LRCLK];
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports SDATA_IN];
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports MCLK_IN_IBUF];
create_clock -name MCLK_IN_IBUF -period 40.69 [get_ports MCLK_IN_IBUF];
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets MCLK_IN_IBUF];


#set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports BCLK_IN]
# set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { MCLK_OUT_OBUF}];
#set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports LRCLK_IN]

# set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets MCLK_OUT_OBUF];
# create_clock -name xtalclk_pin_out -period 40.69 [get_ports { MCLK_OUT_OBUF }];
