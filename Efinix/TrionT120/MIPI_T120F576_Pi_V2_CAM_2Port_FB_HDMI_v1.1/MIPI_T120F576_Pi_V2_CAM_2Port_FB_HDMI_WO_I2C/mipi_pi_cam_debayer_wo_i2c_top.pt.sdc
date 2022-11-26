
# Efinity Interface Designer SDC
# Version: 2021.1.165.3.3
# Date: 2021-09-29 13:43

# Copyright (C) 2017 - 2021 Efinix Inc. All rights reserved.

# Device: T120F576
# Project: mipi_pi_cam_debayer_wo_i2c_top
# Timing Model: C4 (final)

# PLL Constraints
#################
create_clock -period 2.50 ddr_clk
create_clock -period 13.47 tx_slowclk
create_clock -waveform {0.96 2.89} -period 3.85 tx_fastclk
create_clock -period 9.62 mipi_cal_clk
create_clock -period 20.00 mipi_pclk
create_clock -period 37.00 i_sysclk
create_clock -period 10.00 axi_clk

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk_10m}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk_10m}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk_50m}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk_50m}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk_74_25m}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk_74_25m}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_xclr}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_xclr}]

# LVDS RX GPIO Constraints
############################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {i_arstn}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {i_arstn}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {cam_rstn}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {cam_rstn}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led5}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led5}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {led6}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {led6}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_dbg_mipi[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_dbg_mipi[3]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {i_scl}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {i_scl}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_scl}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_scl}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_scl_oe}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_scl_oe}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {i_sda}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {i_sda}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_sda}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_sda}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {o_sda_oe}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {o_sda_oe}]

# LVDS Rx Constraints
####################

# LVDS Tx Constraints
####################
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_1a_DATA[6] lvds_1a_DATA[5] lvds_1a_DATA[4] lvds_1a_DATA[3] lvds_1a_DATA[2] lvds_1a_DATA[1] lvds_1a_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_1a_DATA[6] lvds_1a_DATA[5] lvds_1a_DATA[4] lvds_1a_DATA[3] lvds_1a_DATA[2] lvds_1a_DATA[1] lvds_1a_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_1b_DATA[6] lvds_1b_DATA[5] lvds_1b_DATA[4] lvds_1b_DATA[3] lvds_1b_DATA[2] lvds_1b_DATA[1] lvds_1b_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_1b_DATA[6] lvds_1b_DATA[5] lvds_1b_DATA[4] lvds_1b_DATA[3] lvds_1b_DATA[2] lvds_1b_DATA[1] lvds_1b_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_1c_DATA[6] lvds_1c_DATA[5] lvds_1c_DATA[4] lvds_1c_DATA[3] lvds_1c_DATA[2] lvds_1c_DATA[1] lvds_1c_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_1c_DATA[6] lvds_1c_DATA[5] lvds_1c_DATA[4] lvds_1c_DATA[3] lvds_1c_DATA[2] lvds_1c_DATA[1] lvds_1c_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_1d_DATA[6] lvds_1d_DATA[5] lvds_1d_DATA[4] lvds_1d_DATA[3] lvds_1d_DATA[2] lvds_1d_DATA[1] lvds_1d_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_1d_DATA[6] lvds_1d_DATA[5] lvds_1d_DATA[4] lvds_1d_DATA[3] lvds_1d_DATA[2] lvds_1d_DATA[1] lvds_1d_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_2a_DATA[6] lvds_2a_DATA[5] lvds_2a_DATA[4] lvds_2a_DATA[3] lvds_2a_DATA[2] lvds_2a_DATA[1] lvds_2a_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_2a_DATA[6] lvds_2a_DATA[5] lvds_2a_DATA[4] lvds_2a_DATA[3] lvds_2a_DATA[2] lvds_2a_DATA[1] lvds_2a_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_2b_DATA[6] lvds_2b_DATA[5] lvds_2b_DATA[4] lvds_2b_DATA[3] lvds_2b_DATA[2] lvds_2b_DATA[1] lvds_2b_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_2b_DATA[6] lvds_2b_DATA[5] lvds_2b_DATA[4] lvds_2b_DATA[3] lvds_2b_DATA[2] lvds_2b_DATA[1] lvds_2b_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_2c_DATA[6] lvds_2c_DATA[5] lvds_2c_DATA[4] lvds_2c_DATA[3] lvds_2c_DATA[2] lvds_2c_DATA[1] lvds_2c_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_2c_DATA[6] lvds_2c_DATA[5] lvds_2c_DATA[4] lvds_2c_DATA[3] lvds_2c_DATA[2] lvds_2c_DATA[1] lvds_2c_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_2d_DATA[6] lvds_2d_DATA[5] lvds_2d_DATA[4] lvds_2d_DATA[3] lvds_2d_DATA[2] lvds_2d_DATA[1] lvds_2d_DATA[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_2d_DATA[6] lvds_2d_DATA[5] lvds_2d_DATA[4] lvds_2d_DATA[3] lvds_2d_DATA[2] lvds_2d_DATA[1] lvds_2d_DATA[0]}]
set_output_delay -clock tx_slowclk -max -5.230 [get_ports {lvds_clk[6] lvds_clk[5] lvds_clk[4] lvds_clk[3] lvds_clk[2] lvds_clk[1] lvds_clk[0]}]
set_output_delay -clock tx_slowclk -min -2.575 [get_ports {lvds_clk[6] lvds_clk[5] lvds_clk[4] lvds_clk[3] lvds_clk[2] lvds_clk[1] lvds_clk[0]}]

# MIPI RX Constraints
#####################################
set_output_delay -clock mipi_pclk -max -4.746 [get_ports {mipi_inst1_VC_ENA[3] mipi_inst1_VC_ENA[2] mipi_inst1_VC_ENA[1] mipi_inst1_VC_ENA[0]}]
set_output_delay -clock mipi_pclk -min -2.587 [get_ports {mipi_inst1_VC_ENA[3] mipi_inst1_VC_ENA[2] mipi_inst1_VC_ENA[1] mipi_inst1_VC_ENA[0]}]
set_output_delay -clock mipi_pclk -max -5.197 [get_ports {mipi_inst1_CLEAR}]
set_output_delay -clock mipi_pclk -min -2.498 [get_ports {mipi_inst1_CLEAR}]
set_input_delay -clock mipi_pclk -max 6.394 [get_ports {mipi_inst1_VSYNC[3] mipi_inst1_VSYNC[2] mipi_inst1_VSYNC[1] mipi_inst1_VSYNC[0]}]
set_input_delay -clock mipi_pclk -min 3.197 [get_ports {mipi_inst1_VSYNC[3] mipi_inst1_VSYNC[2] mipi_inst1_VSYNC[1] mipi_inst1_VSYNC[0]}]
set_input_delay -clock mipi_pclk -max 6.388 [get_ports {mipi_inst1_HSYNC[3] mipi_inst1_HSYNC[2] mipi_inst1_HSYNC[1] mipi_inst1_HSYNC[0]}]
set_input_delay -clock mipi_pclk -min 3.194 [get_ports {mipi_inst1_HSYNC[3] mipi_inst1_HSYNC[2] mipi_inst1_HSYNC[1] mipi_inst1_HSYNC[0]}]
set_input_delay -clock mipi_pclk -max 6.242 [get_ports {mipi_inst1_VALID}]
set_input_delay -clock mipi_pclk -min 3.121 [get_ports {mipi_inst1_VALID}]
set_input_delay -clock mipi_pclk -max 6.312 [get_ports {mipi_inst1_CNT[3] mipi_inst1_CNT[2] mipi_inst1_CNT[1] mipi_inst1_CNT[0]}]
set_input_delay -clock mipi_pclk -min 3.156 [get_ports {mipi_inst1_CNT[3] mipi_inst1_CNT[2] mipi_inst1_CNT[1] mipi_inst1_CNT[0]}]
set_input_delay -clock mipi_pclk -max 6.340 [get_ports {mipi_inst1_DATA[*]}]
set_input_delay -clock mipi_pclk -min 3.170 [get_ports {mipi_inst1_DATA[*]}]
set_input_delay -clock mipi_pclk -max 6.257 [get_ports {mipi_inst1_ERROR[*]}]
set_input_delay -clock mipi_pclk -min 3.128 [get_ports {mipi_inst1_ERROR[*]}]
set_input_delay -clock mipi_pclk -max 6.255 [get_ports {mipi_inst1_ULPS_CLK}]
set_input_delay -clock mipi_pclk -min 3.127 [get_ports {mipi_inst1_ULPS_CLK}]
set_input_delay -clock mipi_pclk -max 6.264 [get_ports {mipi_inst1_ULPS[3] mipi_inst1_ULPS[2] mipi_inst1_ULPS[1] mipi_inst1_ULPS[0]}]
set_input_delay -clock mipi_pclk -min 3.132 [get_ports {mipi_inst1_ULPS[3] mipi_inst1_ULPS[2] mipi_inst1_ULPS[1] mipi_inst1_ULPS[0]}]

# Configuration Control Constraints
#####################################
set_output_delay -clock i_sysclk -max -4.360 [get_ports {cfg_CBSEL[0]}]
set_output_delay -clock i_sysclk -max -4.360 [get_ports {cfg_CBSEL[1]}]
set_output_delay -clock i_sysclk -min -2.655 [get_ports {cfg_CBSEL[0]}]
set_output_delay -clock i_sysclk -min -2.655 [get_ports {cfg_CBSEL[1]}]
set_output_delay -clock i_sysclk -max -4.410 [get_ports {cfg_ENA}]
set_output_delay -clock i_sysclk -min -2.655 [get_ports {cfg_ENA}]

# JTAG Constraints
####################
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_TCK}]
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_DRCK}]
set_output_delay -clock jtag_inst1_TCK -max 0.111 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min 0.053 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.231 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.116 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.267 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.134 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.321 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.161 [get_ports {jtag_inst1_SHIFT}]

# DDR Constraints
#####################
set_output_delay -clock axi_clk -max -2.810 [get_ports {aaddr_0[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {aaddr_0[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {aburst_0[1] aburst_0[0]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {aburst_0[1] aburst_0[0]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {aid_0[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {aid_0[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {alen_0[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {alen_0[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {alock_0[1] alock_0[0]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {alock_0[1] alock_0[0]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {asize_0[2] asize_0[1] asize_0[0]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {asize_0[2] asize_0[1] asize_0[0]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {atype_0}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {atype_0}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {avalid_0}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {avalid_0}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {bready_0}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {bready_0}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {rready_0}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {rready_0}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {wdata_0[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {wdata_0[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {wid_0[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {wid_0[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {wlast_0}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {wlast_0}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {wstrb_0[*]}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {wstrb_0[*]}]
set_output_delay -clock axi_clk -max -2.810 [get_ports {wvalid_0}]
set_output_delay -clock axi_clk -min -2.155 [get_ports {wvalid_0}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {aready_0}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {aready_0}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {bid_0[*]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {bid_0[*]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {bvalid_0}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {bvalid_0}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {rdata_0[*]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {rdata_0[*]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {rid_0[*]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {rid_0[*]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {rlast_0}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {rlast_0}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {rresp_0[1] rresp_0[0]}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {rresp_0[1] rresp_0[0]}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {rvalid_0}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {rvalid_0}]
set_input_delay -clock axi_clk -max 8.310 [get_ports {wready_0}]
set_input_delay -clock axi_clk -min 4.155 [get_ports {wready_0}]
