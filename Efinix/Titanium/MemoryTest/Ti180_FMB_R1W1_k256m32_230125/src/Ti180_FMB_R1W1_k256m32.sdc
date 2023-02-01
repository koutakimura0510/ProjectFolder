
# Efinity Interface Designer SDC
# Version: 2022.2.322.1.8
# Date: 2023-01-30 11:05

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: Ti180M484
# Project: Ti180_FMB_R1W1_k256m32_230125
# Timing Model: C4 (preliminary)
#               NOTE: The timing data is not final

# PLL Constraints
#################
create_clock -period 10.000 iSCLK
create_clock -period 7.5008 iDdrFCLK
# create_clock -period 0.938 pll_ddr_CLKOUT3
# create_clock -period 1.876 pll_ddr_CLKOUT4

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {iOscDdr}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {iOscDdr}]

# DDR Constraints
#####################
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 3.675 [get_ports {ddr4_ARSTN_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.000 [get_ports {ddr4_ARSTN_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARADDR_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARADDR_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARAPCMD_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARAPCMD_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARBURST_0[1] ddr4_ARBURST_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARBURST_0[1] ddr4_ARBURST_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARID_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARID_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARLEN_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARLEN_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARSIZE_0[2] ddr4_ARSIZE_0[1] ddr4_ARSIZE_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARSIZE_0[2] ddr4_ARSIZE_0[1] ddr4_ARSIZE_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARVALID_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARVALID_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARLOCK_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARLOCK_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_ARQOS_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_ARQOS_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWADDR_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWADDR_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWAPCMD_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.350 [get_ports {ddr4_AWAPCMD_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWALLSTRB_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWALLSTRB_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWBURST_0[1] ddr4_AWBURST_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWBURST_0[1] ddr4_AWBURST_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWCOBUF_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWCOBUF_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWID_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWID_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWLEN_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWLEN_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWSIZE_0[2] ddr4_AWSIZE_0[1] ddr4_AWSIZE_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWSIZE_0[2] ddr4_AWSIZE_0[1] ddr4_AWSIZE_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWVALID_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWVALID_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWLOCK_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWLOCK_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWCACHE_0[3] ddr4_AWCACHE_0[2] ddr4_AWCACHE_0[1] ddr4_AWCACHE_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWCACHE_0[3] ddr4_AWCACHE_0[2] ddr4_AWCACHE_0[1] ddr4_AWCACHE_0[0]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_AWQOS_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_AWQOS_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_BREADY_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_BREADY_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_RREADY_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_RREADY_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WDATA_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WDATA_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WLAST_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WLAST_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WSTRB_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WSTRB_0[*]}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.310 [get_ports {ddr4_WVALID_0}]
set_output_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min -0.140 [get_ports {ddr4_WVALID_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_ARREADY_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_ARREADY_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.520 [get_ports {ddr4_AWREADY_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.680 [get_ports {ddr4_AWREADY_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.520 [get_ports {ddr4_BID_0[*]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.680 [get_ports {ddr4_BID_0[*]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_BRESP_0[1] ddr4_BRESP_0[0]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_BRESP_0[1] ddr4_BRESP_0[0]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_BVALID_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_BVALID_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RDATA_0[*]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RDATA_0[*]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RID_0[*]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RID_0[*]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RLAST_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RLAST_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RRESP_0[1] ddr4_RRESP_0[0]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RRESP_0[1] ddr4_RRESP_0[0]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_RVALID_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_RVALID_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -max 2.625 [get_ports {ddr4_WREADY_0}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}] -min 1.750 [get_ports {ddr4_WREADY_0}]

# HSIO GPIO Constraints
#########################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {inPbSwX[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {inPbSwX[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {inPbSwX[1]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {inPbSwX[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLedX[7]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLedX[7]}]

# Clockout Interface
######################
# ddr4 -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}]
