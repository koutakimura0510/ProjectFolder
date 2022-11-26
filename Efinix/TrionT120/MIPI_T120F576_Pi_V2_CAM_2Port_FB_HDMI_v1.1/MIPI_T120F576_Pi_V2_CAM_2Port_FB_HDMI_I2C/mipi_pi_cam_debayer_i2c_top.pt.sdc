
# Efinity Interface Designer SDC
# Version: 2021.1.165.3.3
# Date: 2021-09-29 13:29

# Copyright (C) 2017 - 2021 Efinix Inc. All rights reserved.

# Device: T120F576
# Project: mipi_pi_cam_debayer_i2c_top
# Timing Model: C4 (final)

# PLL Constraints
#################
create_clock -period 37.04 i_sysclk

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk_30m}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk_30m}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_o_xclr}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_o_xclr}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_rstn}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_rstn}]

# LVDS RX GPIO Constraints
############################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {i_arstn}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {i_arstn}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cam_rstn}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cam_rstn}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {DEBUG_CBSEL[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {DEBUG_CBSEL[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {DEBUG_CBSEL[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {DEBUG_CBSEL[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {DEBUG_ENA}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {DEBUG_ENA}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[3]}]

# LVDS Rx Constraints
####################

# LVDS TX GPIO Constraints
############################
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {DEBUG_DONE}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {DEBUG_DONE}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_i_scl}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_i_scl}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_o_scl}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_o_scl}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_o_scl_oe}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_o_scl_oe}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_i_sda}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_i_sda}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_o_sda}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_o_sda}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {hdmi_o_sda_oe}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {hdmi_o_sda_oe}]

# LVDS Tx Constraints
####################

# Configuration Control Constraints
#####################################
set_output_delay -clock i_sysclk -max -4.360 [get_ports {cfg_CBSEL[0]}]
set_output_delay -clock i_sysclk -max -4.360 [get_ports {cfg_CBSEL[1]}]
set_output_delay -clock i_sysclk -min -2.655 [get_ports {cfg_CBSEL[0]}]
set_output_delay -clock i_sysclk -min -2.655 [get_ports {cfg_CBSEL[1]}]
set_output_delay -clock i_sysclk -max -4.410 [get_ports {cfg_ENA}]
set_output_delay -clock i_sysclk -min -2.655 [get_ports {cfg_ENA}]
