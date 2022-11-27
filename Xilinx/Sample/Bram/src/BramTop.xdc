# Create 2022/11/26
# Author koutakimura
#
# ------------------------------------------------------------------------------
# Configuration options, can be used for all designs
#  
# CONFIG_VOLTAGE 3.3 or 1.8
# CFGBVS VCCO or GND
# ------------------------------------------------------------------------------
set_property CONFIG_VOLTAGE 3.3      [current_design];
set_property CFGBVS VCCO             [current_design];
# set_property INTERNAL_VREF  0.900   [get_iobanks 14]


# ------------------------------------------------------------------------------
# Bitstream SPI Set Clock Speed
# ------------------------------------------------------------------------------
set_property BITSTREAM.CONFIG.CONFIGRATE        33              [current_design];
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH      4               [current_design];
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN  DISABLE         [current_design];


# ------------------------------------------------------------------------------
# Clock Signal
#
# create_clock -name Signal -period 周期ns -waveform {duty比} [get_nets / get_ports 信号名]
# create_clock -name Signal -period 100MHz -waveform {duty比} [get_nets / get_ports 信号名]
# ------------------------------------------------------------------------------
# OSC Input 25.000MHz
# set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iOscSystemClk }];
# create_clock -add -name iOscSystemClk -period 40.00 -waveform {0 5} [get_ports iOscSystemClk]

# OSC Input 24.576MHz
# set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { iOscAudioClk }];
# create_clock -add -name iOscAudioClk -period 40.69 -waveform {0 5} [get_ports iOscAudioClk]

# OSC Input 12.000MHz
set_property -dict { PACKAGE_PIN L17    IOSTANDARD LVCMOS33 } [get_ports { iClk }];
create_clock -add -name iClk -period 83.33 -waveform {0 41.66} [get_ports iClk];

#-------------------------------------------------------------------------------
# LED Port
# LEDs    => VCC Flash
# RGB LED => GND Flash 
#-------------------------------------------------------------------------------
# LEDs
set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports { oLed }]; #IO_L12N_T1_MRCC_16 Sch=led[1]
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { iRst }]; #IO_L13P_T2_MRCC_16 Sch=led[2]