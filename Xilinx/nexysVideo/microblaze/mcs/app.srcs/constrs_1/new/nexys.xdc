### This file is a general .xdc for the Nexys Video Rev. A
### To use it in a project:
### - uncomment the lines corresponding to used pins
### - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


## Clock Signal
set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports iCLK]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports iCLK]

## LEDs
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS25} [get_ports {oLED[0]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS25} [get_ports {oLED[1]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS25} [get_ports {oLED[2]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS25} [get_ports {oLED[3]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS25} [get_ports {oLED[4]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS25} [get_ports {oLED[5]}]
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS25} [get_ports {oLED[6]}]
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS25} [get_ports {oLED[7]}]


## Buttons
# set_property -dict { PACKAGE_PIN F15 IOSTANDARD LVCMOS12 } [get_ports { iBtn[0] }]; #IO_0_16 Sch=btnu
# set_property -dict { PACKAGE_PIN D14 IOSTANDARD LVCMOS12 } [get_ports { iBtn[1] }]; #IO_L6P_T0_16 Sch=btnr
# set_property -dict { PACKAGE_PIN C22 IOSTANDARD LVCMOS12 } [get_ports { iBtn[2] }]; #IO_L20P_T3_16 Sch=btnl
# set_property -dict { PACKAGE_PIN D22 IOSTANDARD LVCMOS12 } [get_ports { iBtn[3] }]; #IO_L22N_T3_16 Sch=btnd
# set_property -dict { PACKAGE_PIN B22 IOSTANDARD LVCMOS12 } [get_ports { iBtn[4] }]; #IO_L20N_T3_16 Sch=btnc
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS15} [get_ports iRST]

## UART
set_property -dict {PACKAGE_PIN AA19 IOSTANDARD LVCMOS33} [get_ports oUartTx]
# set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { uart_tx_in }]; #IO_L14P_T2_SRCC_14 Sch=uart_tx_in

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
