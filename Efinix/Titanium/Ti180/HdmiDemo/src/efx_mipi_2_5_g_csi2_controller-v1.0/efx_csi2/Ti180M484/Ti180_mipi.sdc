# PLL Constraints
#################
create_clock -period 10.000 mipi_clk   
create_clock -period 6.4 mipi_dphy_rx_clk_CLKOUT
create_clock -period 5 pixel_clk
create_clock -period 6.4 mipi_dphy_tx_SLOWCLK
create_clock -period 10.00 cfg_clk
create_clock -period 50.00 esc_clk
create_clock -period 40.00 pll_inst2_CLKOUT3
create_clock -period 10.00 mipi_dphy_rx_inst2_CAL_CLK
create_clock -period 50.00 mipi_dphy_tx_inst1_ESC_CLK

set_clock_groups -exclusive -group {mipi_clk} -group {mipi_dphy_rx_clk_CLKOUT} -group {pixel_clk} -group {jtag_inst1_TCK}
set_clock_groups -exclusive -group {mipi_clk} -group {mipi_dphy_tx_SLOWCLK} -group {pixel_clk} -group {jtag_inst1_TCK}


# Efinity Interface Designer SDC
# Version: 2022.M.51
# Date: 2022-03-09 19:17

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: Ti180F484
# Project: new_csi
# Timing Model: C4 (preliminary)
#               NOTE: The timing data is not final

# MIPI DPHY RX Constraints
#####################################
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 0.835 [get_ports {mipi_dphy_rx_inst2_RST0_N}]
set_output_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 0.089 [get_ports {mipi_dphy_rx_inst2_RST0_N}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN0_CLK -max 3.387 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN0_ENTER}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN0_CLK -min 2.258 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN0_ENTER}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN1_CLK -max 3.783 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN1_ENTER}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN1_CLK -min 2.522 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN1_ENTER}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN2_CLK -max 4.925 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN2_ENTER}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN2_CLK -min 3.283 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN2_ENTER}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN3_CLK -max 3.289 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN3_ENTER}]
set_input_delay -clock mipi_dphy_rx_inst2_ESC_LAN3_CLK -min 2.192 [get_ports {mipi_dphy_rx_inst2_ULPS_LAN3_ENTER}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.667 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.112 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.613 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.075 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.745 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.163 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.584 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.056 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_SOTSYNC_ERROR}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.693 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.128 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.723 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.149 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.698 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.132 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.734 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.156 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_DATA[*]}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.723 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.149 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.656 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.104 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.717 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.145 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.583 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.056 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_SKEWCAL}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.707 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.138 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.632 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.088 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.583 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.056 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.536 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.024 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_SYNC}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.645 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.097 [get_ports {mipi_dphy_rx_inst2_HS_LAN0_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.612 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.075 [get_ports {mipi_dphy_rx_inst2_HS_LAN1_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.563 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.042 [get_ports {mipi_dphy_rx_inst2_HS_LAN2_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.582 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.055 [get_ports {mipi_dphy_rx_inst2_HS_LAN3_VALID}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.647 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN0}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.098 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN0}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.592 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN1}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.061 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN1}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.591 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN2}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.060 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN2}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -max 1.613 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN3}]
set_input_delay -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}] -min 1.075 [get_ports {mipi_dphy_rx_inst2_STOPSTATE_LAN3}]

# MIPI DPHY TX Constraints
#####################################
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.776 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.190 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.716 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.272 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.764 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.320 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.695 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.279 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_DATA[*]}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.345 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.064 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.679 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.267 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.394 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.273 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.590 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.241 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_HIGHVALID}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.634 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN0}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.121 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN0}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.612 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN1}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.287 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN1}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.671 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN2}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.328 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN2}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.629 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN3}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.263 [get_ports {mipi_dphy_tx_inst1_REQUESTESC_LAN3}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.393 [get_ports {mipi_dphy_tx_inst1_HS_CLK_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.214 [get_ports {mipi_dphy_tx_inst1_HS_CLK_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.483 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.043 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.641 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.190 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.804 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.213 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.680 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.193 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_REQUEST}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.342 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.069 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.709 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.177 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.545 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.257 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 1.520 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 0.190 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_SKEWCAL}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 1.967 [get_ports {mipi_dphy_tx_inst1_ULPS_CLK_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.219 [get_ports {mipi_dphy_tx_inst1_ULPS_CLK_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.537 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN0_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.300 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN0_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.639 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN1_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.181 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN1_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.556 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN2_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.293 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN2_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.410 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN3_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.273 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN3_ENTER}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 1.821 [get_ports {mipi_dphy_tx_inst1_ULPS_CLK_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.239 [get_ports {mipi_dphy_tx_inst1_ULPS_CLK_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.910 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN0_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.172 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN0_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.781 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN1_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.205 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN1_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.395 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN2_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.386 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN2_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -max 2.491 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN3_EXIT}]
set_output_delay -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}] -min 0.306 [get_ports {mipi_dphy_tx_inst1_ULPS_LAN3_EXIT}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 2.416 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_READY}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 1.611 [get_ports {mipi_dphy_tx_inst1_HS_LAN0_READY}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 2.406 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_READY}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 1.604 [get_ports {mipi_dphy_tx_inst1_HS_LAN1_READY}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 2.610 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_READY}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 1.740 [get_ports {mipi_dphy_tx_inst1_HS_LAN2_READY}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -max 2.543 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_READY}]
set_input_delay -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}] -min 1.695 [get_ports {mipi_dphy_tx_inst1_HS_LAN3_READY}]

# JTAG Constraints
####################
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_TCK}]
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_DRCK}]
set_output_delay -clock jtag_inst1_TCK -max 0.161 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min 0.090 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.387 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.224 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.387 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.224 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.387 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.224 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.335 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.194 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.387 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.224 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.465 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.270 [get_ports {jtag_inst1_SHIFT}]

# HSIO GPIO Constraints
#########################

# Clockout Interface
######################
# mipi_dphy_rx_inst2 -clock mipi_dphy_rx_clk_CLKOUT -reference_pin [get_ports {mipi_dphy_rx_clk_CLKOUT~CLKOUT~1~38}]
# mipi_dphy_tx_inst1 -clock mipi_dphy_tx_SLOWCLK -reference_pin [get_ports {mipi_dphy_tx_SLOWCLK~CLKOUT~2~35}]
# mipi_dphy_tx_inst1 -clock mipi_dphy_tx_inst1_ESC_CLK -reference_pin [get_ports {mipi_dphy_tx_inst1_ESC_CLK~CLKOUT~1~35}]
