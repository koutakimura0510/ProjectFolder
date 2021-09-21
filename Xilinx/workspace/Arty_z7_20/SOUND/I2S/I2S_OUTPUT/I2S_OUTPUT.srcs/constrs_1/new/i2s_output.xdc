## Clock Signal
#set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
#create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];#set


## Switches
#set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports { RESET }];


## ChipKit Outer Digital Header
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { BCLK_OUT      }];
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { AUDIO_DATA_OUT}];
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { LRCLK_OUT     }];
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { MCLK_IN_IBUF  }];

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets MCLK_IN_IBUF];
create_clock -name xtalclk_pin -period 40.69 [get_ports { MCLK_IN_IBUF}];