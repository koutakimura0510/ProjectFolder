
# Efinity Interface Designer SDC
# Version: 2022.2.322.1.8
# Date: 2023-01-27 17:50

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: Ti180M484
# Project: Ti180_FMB_R1W1_k256m32_230125
# Timing Model: C4 (preliminary)
#               NOTE: The timing data is not final

# PLL Constraints
#################
create_clock -period 10.000 iSCLK
create_clock -period 30.000 iDdrFCLK
# create_clock -period 1.6835 iDdrPhy1CLK
# create_clock -period 1.6835 iDdrPhy1CLK
# create_clock -period 3.3670 iDdrPhy2CLK
create_clock -period 2.307 iDdrPCLK
create_clock -period 4.615 iDdrCCLK

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
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -max 1.890 [get_ports {ddr4_CTRL_REFRESH}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -min 1.260 [get_ports {ddr4_CTRL_REFRESH}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -max 1.890 [get_ports {ddr4_CTRL_CKE[1] ddr4_CTRL_CKE[0]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -min 1.260 [get_ports {ddr4_CTRL_CKE[1] ddr4_CTRL_CKE[0]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -max 1.890 [get_ports {ddr4_CTRL_BUSY}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -min 1.260 [get_ports {ddr4_CTRL_BUSY}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -max 1.890 [get_ports {ddr4_CTRL_CMD_Q_ALMOST_FULL}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -min 1.260 [get_ports {ddr4_CTRL_CMD_Q_ALMOST_FULL}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -max 1.890 [get_ports {ddr4_CTRL_DP_IDLE}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -min 1.260 [get_ports {ddr4_CTRL_DP_IDLE}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -max 1.890 [get_ports {ddr4_CTRL_PORT_BUSY[1] ddr4_CTRL_PORT_BUSY[0]}]
set_input_delay -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}] -min 1.260 [get_ports {ddr4_CTRL_PORT_BUSY[1] ddr4_CTRL_PORT_BUSY[0]}]

# HSIO GPIO Constraints
#########################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {iPushSw[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {iPushSw[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {iPushSw[1]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {iPushSw[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[7]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[7]}]

# Clockout Interface
######################
# ddr4 -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~1~491}]
# ddr4 -clock iSCLK -reference_pin [get_ports {iSCLK~CLKOUT~2~150}]
