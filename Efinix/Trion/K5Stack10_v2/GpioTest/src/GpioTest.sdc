
# Efinity Interface Designer SDC
# Version: 2023.1.150
# Date: 2023-11-11 21:07

# Copyright (C) 2017 - 2023 Efinix Inc. All rights reserved.

# Device: T20Q144
# Project: GpioTest
# Timing Model: C3 (final)

# PLL Constraints
#################
create_clock -period 40.0000 iSCLK
create_clock -period 1000.0000 iXCLK

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {iOSC_IN}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {iOSC_IN}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oLed[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oLed[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oLed[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oLed[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oLed[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oLed[2]}]

# LVDS RX GPIO Constraints
############################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {iUSB_RX}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {iUSB_RX}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oUSB_TX}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oUSB_TX}]

# LVDS Rx Constraints
####################

# LVDS TX GPIO Constraints
############################
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oGpioBP00}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oGpioBP00}]
set_output_delay -clock iXCLK -max -5.213 [get_ports {oGpioBP01}]
set_output_delay -clock iXCLK -min -2.230 [get_ports {oGpioBP01}]
set_output_delay -clock iXCLK -max -5.213 [get_ports {oGpioBP03}]
set_output_delay -clock iXCLK -min -2.230 [get_ports {oGpioBP03}]

# LVDS Tx Constraints
####################

# JTAG Constraints
####################
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_TCK}]
set_output_delay -clock jtag_inst1_TCK -max 0.144 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min -0.053 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.300 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.116 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.417 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.161 [get_ports {jtag_inst1_SHIFT}]
# JTAG Constraints (extra... not used by current Efinity debug tools)
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_DRCK}]
# set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_RUNTEST}]
# set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RUNTEST}]
# Create separate clock groups for JTAG clocks. Remove DRCK clock from the list below if it is not defined.
# set_clock_groups -asynchronous -group {jtag_inst1_TCK jtag_inst1_DRCK}
