
# Efinity Interface Designer SDC
# Version: 2022.2.322
# Date: 2023-06-03 09:47

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: T20Q144
# Project: PrimitiveTest
# Timing Model: C3 (final)

# PLL Constraints
#################
create_clock -period 20.0000 iSCLK

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
