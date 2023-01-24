
# Efinity Interface Designer SDC
# Version: 2022.1.226.2.11
# Date: 2023-01-01 22:22

# Copyright (C) 2017 - 2022 Efinix Inc. All rights reserved.

# Device: Ti180M484
# Project: Ti180MIPI25GRxHDMIV100
# Timing Model: C4 (preliminary)
#               NOTE: The timing data is not final
# Interface Designer で自動生成 (Generate Efinity Constraint Files) の機能で生成したタイミング設定を使用している。

# PLL Constraints
#################
create_clock -period 10.000 iSCLK
create_clock -period 10.000 iCfgCLK
create_clock -period 10.000 iFBCLK
create_clock -period 40.000 iBCLK
# create_clock -period 50.0000 iPCLK
# create_clock -period  5.0000 iFCLK
# create_clock -period 6.7340  iVCLK
create_clock -period 13.468  iVCLK
# create_clock -period 7.5008  pll_inst3_CLKOUT0
# create_clock -period 1.6835  pll_ddr_CLKOUT3
# create_clock -period 3.3670  pll_ddr_CLKOUT4
create_clock -name MipiDphyRx1_WORD_CLKOUT_HS -period 6.4 [get_ports MipiDphyRx1_WORD_CLKOUT_HS]
# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {iOscClk75MHz}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {iOscClk75MHz}]

set_clock_groups -exclusive  -group {MipiDphyRx1_WORD_CLKOUT_HS} -group {iSCLK} -group {iBCLK} -group {iVCLK}

# MIPI DPHY RX Constraints
#####################################
set_output_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 0.835 [get_ports {MipiDphyRx1_RST0_N}]
set_output_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 0.089 [get_ports {MipiDphyRx1_RST0_N}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -max 4.343 [get_ports {MipiDphyRx1_RX_DATA_ESC[*]}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -min 2.895 [get_ports {MipiDphyRx1_RX_DATA_ESC[*]}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -max 4.039 [get_ports {MipiDphyRx1_RX_LPDT_ESC}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -min 2.693 [get_ports {MipiDphyRx1_RX_LPDT_ESC}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -max 3.907 [get_ports {MipiDphyRx1_RX_TRIGGER_ESC[3] MipiDphyRx1_RX_TRIGGER_ESC[2] MipiDphyRx1_RX_TRIGGER_ESC[1] MipiDphyRx1_RX_TRIGGER_ESC[0]}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -min 2.605 [get_ports {MipiDphyRx1_RX_TRIGGER_ESC[3] MipiDphyRx1_RX_TRIGGER_ESC[2] MipiDphyRx1_RX_TRIGGER_ESC[1] MipiDphyRx1_RX_TRIGGER_ESC[0]}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -max 3.387 [get_ports {MipiDphyRx1_RX_ULPS_ESC_LAN0}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -min 2.258 [get_ports {MipiDphyRx1_RX_ULPS_ESC_LAN0}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -max 3.465 [get_ports {MipiDphyRx1_RX_VALID_ESC}]
set_input_delay -clock MipiDphyRx1_ESC_LAN0_CLK -min 2.310 [get_ports {MipiDphyRx1_RX_VALID_ESC}]
set_input_delay -clock MipiDphyRx1_ESC_LAN1_CLK -max 3.783 [get_ports {MipiDphyRx1_RX_ULPS_ESC_LAN1}]
set_input_delay -clock MipiDphyRx1_ESC_LAN1_CLK -min 2.522 [get_ports {MipiDphyRx1_RX_ULPS_ESC_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.607 [get_ports {MipiDphyRx1_ERR_SOT_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.071 [get_ports {MipiDphyRx1_ERR_SOT_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.619 [get_ports {MipiDphyRx1_ERR_SOT_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.079 [get_ports {MipiDphyRx1_ERR_SOT_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.667 [get_ports {MipiDphyRx1_ERR_SOT_SYNC_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.112 [get_ports {MipiDphyRx1_ERR_SOT_SYNC_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.613 [get_ports {MipiDphyRx1_ERR_SOT_SYNC_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.075 [get_ports {MipiDphyRx1_ERR_SOT_SYNC_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.627 [get_ports {MipiDphyRx1_RX_ACTIVE_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.085 [get_ports {MipiDphyRx1_RX_ACTIVE_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.644 [get_ports {MipiDphyRx1_RX_ACTIVE_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.096 [get_ports {MipiDphyRx1_RX_ACTIVE_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.693 [get_ports {MipiDphyRx1_RX_DATA_HS_LAN0[*]}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.128 [get_ports {MipiDphyRx1_RX_DATA_HS_LAN0[*]}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.723 [get_ports {MipiDphyRx1_RX_DATA_HS_LAN1[*]}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.149 [get_ports {MipiDphyRx1_RX_DATA_HS_LAN1[*]}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.723 [get_ports {MipiDphyRx1_RX_SKEW_CAL_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.149 [get_ports {MipiDphyRx1_RX_SKEW_CAL_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.656 [get_ports {MipiDphyRx1_RX_SKEW_CAL_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.104 [get_ports {MipiDphyRx1_RX_SKEW_CAL_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.707 [get_ports {MipiDphyRx1_RX_SYNC_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.138 [get_ports {MipiDphyRx1_RX_SYNC_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.632 [get_ports {MipiDphyRx1_RX_SYNC_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.088 [get_ports {MipiDphyRx1_RX_SYNC_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.645 [get_ports {MipiDphyRx1_RX_VALID_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.097 [get_ports {MipiDphyRx1_RX_VALID_HS_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.612 [get_ports {MipiDphyRx1_RX_VALID_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.075 [get_ports {MipiDphyRx1_RX_VALID_HS_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.647 [get_ports {MipiDphyRx1_STOPSTATE_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.098 [get_ports {MipiDphyRx1_STOPSTATE_LAN0}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -max 1.592 [get_ports {MipiDphyRx1_STOPSTATE_LAN1}]
set_input_delay -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}] -min 1.061 [get_ports {MipiDphyRx1_STOPSTATE_LAN1}]

# JTAG Constraints
####################
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_TCK}]
# create_clock -period <USER_PERIOD> [get_ports {jtag_inst1_DRCK}]
set_output_delay -clock jtag_inst1_TCK -max 0.117 [get_ports {jtag_inst1_TDO}]
set_output_delay -clock jtag_inst1_TCK -min -0.075 [get_ports {jtag_inst1_TDO}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.280 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.187 [get_ports {jtag_inst1_CAPTURE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.280 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.187 [get_ports {jtag_inst1_RESET}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.280 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.187 [get_ports {jtag_inst1_RUNTEST}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.243 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.162 [get_ports {jtag_inst1_SEL}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.280 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.187 [get_ports {jtag_inst1_UPDATE}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -max 0.337 [get_ports {jtag_inst1_SHIFT}]
set_input_delay -clock_fall -clock jtag_inst1_TCK -min 0.225 [get_ports {jtag_inst1_SHIFT}]

# HSIO GPIO Constraints
#########################
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {iPushSw[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {iPushSw[0]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {iPushSw[1]}]
# set_input_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {iPushSw[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[0]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[0]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[7]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[7]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[8]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[8]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[9]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[9]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[10]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[10]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[11]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[11]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[12]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[12]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[13]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[13]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[14]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[14]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Data[15]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Data[15]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511De}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511De}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Hs}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Hs}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oAdv7511Vs}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oAdv7511Vs}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[0]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[0]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oLed[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oLed[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[0]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[0]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[1]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[2]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[3]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[4]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[5]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[6]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[7]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[7]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[8]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[8]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[9]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[9]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[10]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[10]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -max <MAX CALCULATION> [get_ports {oTestPort[11]}]
# set_output_delay -clock <CLOCK> [-reference_pin <clkout_pad>] -min <MIN CALCULATION> [get_ports {oTestPort[11]}]
set_input_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~335}] -max 0.414 [get_ports {iAdv7511Scl}]
set_input_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~335}] -min 0.276 [get_ports {iAdv7511Scl}]
set_output_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~337}] -max 0.263 [get_ports {oAdv7511SclOe}]
set_output_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~337}] -min -0.140 [get_ports {oAdv7511SclOe}]
set_input_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~334}] -max 0.414 [get_ports {iAdv7511Sda}]
set_input_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~334}] -min 0.276 [get_ports {iAdv7511Sda}]
set_output_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~336}] -max 0.263 [get_ports {oAdv7511SdaOe}]
set_output_delay -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~336}] -min -0.140 [get_ports {oAdv7511SdaOe}]

# Clockout Interface
######################
# MipiDphyRx1 -clock MipiDphyRx1_WORD_CLKOUT_HS -reference_pin [get_ports {MipiDphyRx1_WORD_CLKOUT_HS~CLKOUT~1~38}]
# ioAdv7511Scl -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~335}]
# ioAdv7511Scl -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~337}]
# ioAdv7511Sda -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~334}]
# ioAdv7511Sda -clock iBCLK -reference_pin [get_ports {iBCLK~CLKOUT~333~336}]
