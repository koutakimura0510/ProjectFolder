
# Efinity Interface Designer SDC
# Version: 2022.2.322.3.16
# Date: 2023-04-19 13:43

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: T20Q144
# Project: JTAG_Flash_Loader
# Timing Model: C3 (final)

# PLL Constraints
#################
create_clock -period 10.0000 iSCLK

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {iMISO}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {iMISO}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {iPLL_BR0_IN}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {iPLL_BR0_IN}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oMOSI}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oMOSI}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {onCS}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {onCS}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oSCK}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oSCK}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oLed[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oLed[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oLed[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oLed[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {oLed[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {oLed[2]}]

# JTAG Constraints
####################
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_TCK}]
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_DRCK}]
set_output_delay -clock jtag_inst1_TCK -max 0.144 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min -0.053 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.300 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.116 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.347 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.417 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.161 [get_ports {jtag_inst1_SHIFT}]
