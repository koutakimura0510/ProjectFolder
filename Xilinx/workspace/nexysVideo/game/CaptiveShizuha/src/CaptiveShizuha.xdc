### This file is a general .xdc for the Nexys Video Rev. A
### To use it in a project:
### - uncomment the lines corresponding to used pins
### - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


# ------------------------------------------------------------
# Configuration options, can be used for all designs
# ------------------------------------------------------------
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO        [current_design]


# ------------------------------------------------------------
# Bitstream SPI Set Clock Speed
# ------------------------------------------------------------
set_property BITSTREAM.CONFIG.CONFIGRATE        33              [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH      4               [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN  DISABLE         [current_design]
# set_property BITSTREAM.CONFIG.USERID            32'h22040501    [current_design]


# ------------------------------------------------------------
# Clock Signal
# dutyを指定しない場合は duty50%適応
# create_clock -name 信号名 -period 周期ns -waveform {duty比} [get_nets / get_ports 信号名]
# create_clock -name 信号名 -period 100MHz -waveform {duty比} [get_nets / get_ports 信号名]
# ------------------------------------------------------------
# OSC Input
set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { iCLK }]; #IO_L13P_T2_MRCC_34 Sch=sysclk
create_clock -add -name iCLK -period 10.00 -waveform {0 5} [get_ports iCLK]

# FPGA
create_generated_clock -name PCLK [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT0]
create_generated_clock -name TCLK [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT1]
create_generated_clock -name BCLK [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT2]

# 手動配線
set_property LOC MMCME2_ADV_X1Y2  [get_cells CGB/MMCME2_BASE_CLK_GEN]
# set_property LOC PLLE2_ADV_X1Y2   [get_cells CGB/PLLE2_BASE_CLK_GEN]
# set_property LOC X1Y2 [get_cells TGB]

set_property LOC RAMB36_X8Y27 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo]

# ------------------------------------------------------------
# 入力ポートでのデータ遅延時間を設定
# set_input_delay -clock {クロック} -max 最大遅延 [get_ports 信号名]
# set_input_delay -clock {クロック} -min 最小遅延 [get_ports 信号名]
# 
# クロック	基準となるクロック
# 最大遅延	クロックエッジ後にデータが到達する最大時間→Setupの制約
# 最小遅延	クロックエッジ後にデータが到達する最小時間→Holdの制約
# 信号名	対象となる信号名
# ------------------------------------------------------------
# 出力ポートでのデータ遅延時間を設定
# 
# set_output_delay -clock {クロック} -max 最大遅延 [get_ports 信号名]
# set_output_delay -clock {クロック} -min 最小遅延 [get_ports 信号名]
# 
# クロック	基準となるクロック
# 最大遅延	クロックエッジ後にデータが必要とする最大時間→Setupの制約
# 最小遅延	クロックエッジ後にデータが必要とする最小時間→Holdの制約
# 信号名	対象となる信号名
# ------------------------------------------------------------
# 非同期入力をタイミング解析から除外するための設定
# 
# set_false_path [-from <node_list>] [-to <node_list>] [-through <node_list>]
# 
# -from	始点のノー ド リ ス トを指定
# -to	終点のノー ド リ ス トを指定
# -through	”pin”、”port”、または”net”のノー ド リ ス ト を指定
# 例1) resetポートからすべてのレジスタへのタイミング解析の除外
# 
# set_false_path -from [get_port reset] -to [all_registers]
# 
# 例2) 2つの非同期クロックドメイン間(CLKAからCLKB)のタイ ミング解析の除外
# 
# set_false_path -from [get_clocks CLKA] -to [get_clocks CLKB]
# set_false_path -from [get_clocks CLKB] -to [get_clocks CLKA]
# 
# タイミング例外には、 set_false_path 以外に下記のコマンドがあり。
# 
# コマンド	機能
# set_multicycle_path	パスの開始点から終点までデータを伝搬させるのに必要なクロックサイクル数を指定します。
# set_max_delay
# set_min_delay	        最小パス遅延または最大パス遅延の値を指定します。
# このコマンドを使用すると、デフォルトのセットアップおよびホールド制約ではなく、ユーザーが指定した最大/最小遅延値が使用される。
# ------------------------------------------------------------
# 最大遅延：セットアップを変更する場合に使用します。
# 最小遅延：ホールドを変更する場合に使用します。
# 
# ・最大遅延コマンド例
# 
# set_max_delay <delay> [-datapath_only] [-from<node_list> ]
#                                        [-to <node_list>] [-through <node_list>]
# 
# ・最小遅延コマンド例
# 
# set_min_delay <delay> [-from <node_list>]
#                                       [-to <node_list>] [-through <node_list>]
#  
# 
# ・オプション
# 
# -datapath_only	→スラックの算出からクロックスキューを除外できる
# →set_max_delayのみサポート
# →ホールドは無視される
# -from	→クロック、入力または入出力ポート
# -to	→クロック、出力または入出力ポート
# -through	→ピン、ポート 、またはネット
# ------------------------------------------------------------


# ------------------------------------------------------------
# Port 記述一覧
# 
# 出力バッファの駆動電流 mA指定
# set_property DRIVE <2 4  8 12(初期値) 16 24> [get_ports pin]
# set_property DRIVE <2 4  8 12(初期値) 16 24> [get_ports {bus Name [id]}]
# 
# 出力バッファのスルーレート
# set_property SLEW <SLOW / FAST> [get_ports pin]
# set_property SLEW <SLOW / FAST> [get_ports {bus Name [id]}]
# 
# プルアップ・プルダウン
# set_property PULLUP TRUE / FALSE [get_ports pin]
# set_property PULLDOWN TRUE / FALSE [get_ports {bus Name [id]}]
# -------------------------------------------------------------
## LEDs
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { oLED[0] }]; #IO_L15P_T2_DQS_13 Sch=led[0]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { oLED[1] }]; #IO_L15N_T2_DQS_13 Sch=led[1]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS25 } [get_ports { oLED[2] }]; #IO_L17P_T2_13 Sch=led[2]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS25 } [get_ports { oLED[3] }]; #IO_L17N_T2_13 Sch=led[3]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS25 } [get_ports { oLED[4] }]; #IO_L14N_T2_SRCC_13 Sch=led[4]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS25 } [get_ports { oLED[5] }]; #IO_L16N_T2_13 Sch=led[5]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { oLED[6] }]; #IO_L16P_T2_13 Sch=led[6]
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { oLED[7] }]; #IO_L5P_T0_13 Sch=led[7]


## Buttons
# set_property -dict { PACKAGE_PIN F15 IOSTANDARD LVCMOS12 } [get_ports { iBtn[0] }]; #IO_0_16 Sch=btnu
# set_property -dict { PACKAGE_PIN D14 IOSTANDARD LVCMOS12 } [get_ports { iBtn[1] }]; #IO_L6P_T0_16 Sch=btnr
# set_property -dict { PACKAGE_PIN C22 IOSTANDARD LVCMOS12 } [get_ports { iBtn[2] }]; #IO_L20P_T3_16 Sch=btnl
# set_property -dict { PACKAGE_PIN D22 IOSTANDARD LVCMOS12 } [get_ports { iBtn[3] }]; #IO_L22N_T3_16 Sch=btnd
# set_property -dict { PACKAGE_PIN B22 IOSTANDARD LVCMOS12 } [get_ports { iBtn[4] }]; #IO_L20N_T3_16 Sch=btnc
set_property -dict { PACKAGE_PIN G4  IOSTANDARD LVCMOS15 } [get_ports { iRST }]; #IO_L12N_T1_MRCC_35 Sch=cpu_resetn

## Pmod header JA
# SW_LEFT  0x20
# SW_RIGHT 0x10
# SW_UP    0x01
# SW_DOWN  0x02
# SW_A     0x08
# SW_B     0x04
#set_property -dict { PACKAGE_PIN AB22  IOSTANDARD LVCMOS33 } [get_ports { ja[0] }]; #IO_L10N_T1_D15_14 Sch=ja[1]
set_property -dict { PACKAGE_PIN AB21  IOSTANDARD LVCMOS33 } [get_ports { iBtn[0] }]; #IO_L10P_T1_D14_14 Sch=ja[2]
set_property -dict { PACKAGE_PIN AB20  IOSTANDARD LVCMOS33 } [get_ports { iBtn[1] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=ja[3]
set_property -dict { PACKAGE_PIN AB18  IOSTANDARD LVCMOS33 } [get_ports { iBtn[2] }]; #IO_L17N_T2_A13_D29_14 Sch=ja[4]
#set_property -dict { PACKAGE_PIN Y21   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L9P_T1_DQS_14 Sch=ja[7]
set_property -dict { PACKAGE_PIN AA21  IOSTANDARD LVCMOS33 } [get_ports { iBtn[3] }]; #IO_L8N_T1_D12_14 Sch=ja[8]
set_property -dict { PACKAGE_PIN AA20  IOSTANDARD LVCMOS33 } [get_ports { iBtn[4] }]; #IO_L8P_T1_D11_14 Sch=ja[9]
set_property -dict { PACKAGE_PIN AA18  IOSTANDARD LVCMOS33 } [get_ports { iBtn[5] }]; #IO_L17P_T2_A14_D30_14 Sch=ja[10]


## Switches
set_property -dict { PACKAGE_PIN E22  IOSTANDARD LVCMOS12 } [get_ports { iSW[0] }]; #IO_L22P_T3_16 Sch=sw[0]
set_property -dict { PACKAGE_PIN F21  IOSTANDARD LVCMOS12 } [get_ports { iSW[1] }]; #IO_25_16 Sch=sw[1]
set_property -dict { PACKAGE_PIN G21  IOSTANDARD LVCMOS12 } [get_ports { iSW[2] }]; #IO_L24P_T3_16 Sch=sw[2]
set_property -dict { PACKAGE_PIN G22  IOSTANDARD LVCMOS12 } [get_ports { iSW[3] }]; #IO_L24N_T3_16 Sch=sw[3]
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS12 } [get_ports { iSW[4] }]; #IO_L6P_T0_15 Sch=sw[4]
set_property -dict { PACKAGE_PIN J16  IOSTANDARD LVCMOS12 } [get_ports { iSW[5] }]; #IO_0_15 Sch=sw[5]
set_property -dict { PACKAGE_PIN K13  IOSTANDARD LVCMOS12 } [get_ports { iSW[6] }]; #IO_L19P_T3_A22_15 Sch=sw[6]
set_property -dict { PACKAGE_PIN M17  IOSTANDARD LVCMOS12 } [get_ports { iSW[7] }]; #IO_25_15 Sch=sw[7]


## OLED Display
set_property -dict { PACKAGE_PIN W22   IOSTANDARD LVCMOS33 } [get_ports { oOledDC   }]; #IO_L7N_T1_D10_14 Sch=oled_dc
set_property -dict { PACKAGE_PIN U21   IOSTANDARD LVCMOS33 } [get_ports { oOledRes  }]; #IO_L4N_T0_D05_14 Sch=oled_res
set_property -dict { PACKAGE_PIN W21   IOSTANDARD LVCMOS33 } [get_ports { oOledScl  }]; #IO_L7P_T1_D09_14 Sch=oled_sclk
set_property -dict { PACKAGE_PIN Y22   IOSTANDARD LVCMOS33 } [get_ports { oOledSda  }]; #IO_L9N_T1_DQS_D13_14 Sch=oled_sdin
set_property -dict { PACKAGE_PIN P20   IOSTANDARD LVCMOS33 } [get_ports { oOledVbat }]; #IO_0_14 Sch=oled_vbat
set_property -dict { PACKAGE_PIN V22   IOSTANDARD LVCMOS33 } [get_ports { oOledVdd  }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=oled_vdd


## HDMI in
#set_property -dict { PACKAGE_PIN AA5   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_cec }]; #IO_L10P_T1_34 Sch=hdmi_rx_cec
#set_property -dict { PACKAGE_PIN W4    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_n }]; #IO_L12N_T1_MRCC_34 Sch=hdmi_rx_clk_n
#set_property -dict { PACKAGE_PIN V4    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_clk_p }]; #IO_L12P_T1_MRCC_34 Sch=hdmi_rx_clk_p
#set_property -dict { PACKAGE_PIN AB12  IOSTANDARD LVCMOS25 } [get_ports { hdmi_rx_hpa }]; #IO_L7N_T1_13 Sch=hdmi_rx_hpa
#set_property -dict { PACKAGE_PIN Y4    IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_scl }]; #IO_L11P_T1_SRCC_34 Sch=hdmi_rx_scl
#set_property -dict { PACKAGE_PIN AB5   IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_sda }]; #IO_L10N_T1_34 Sch=hdmi_rx_sda
#set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_rx_txen }]; #IO_L3P_T0_DQS_34 Sch=hdmi_rx_txen
#set_property -dict { PACKAGE_PIN AA3   IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[0] }]; #IO_L9N_T1_DQS_34 Sch=hdmi_rx_n[0]
#set_property -dict { PACKAGE_PIN Y3    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[0] }]; #IO_L9P_T1_DQS_34 Sch=hdmi_rx_p[0]
#set_property -dict { PACKAGE_PIN Y2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[1] }]; #IO_L4N_T0_34 Sch=hdmi_rx_n[1]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[1] }]; #IO_L4P_T0_34 Sch=hdmi_rx_p[1]
#set_property -dict { PACKAGE_PIN V2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_n[2] }]; #IO_L2N_T0_34 Sch=hdmi_rx_n[2]
#set_property -dict { PACKAGE_PIN U2    IOSTANDARD TMDS_33  } [get_ports { hdmi_rx_p[2] }]; #IO_L2P_T0_34 Sch=hdmi_rx_p[2]


## HDMI out
#set_property -dict { PACKAGE_PIN AA4   IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_cec }]; #IO_L11N_T1_SRCC_34 Sch=hdmi_tx_cec
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oHDMI_CLK_n }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33  } [get_ports { oHDMI_CLK_p }]; #IO_L1P_T0_34 Sch=hdmi_tx_clk_p
#set_property -dict { PACKAGE_PIN AB13  IOSTANDARD LVCMOS25 } [get_ports { hdmi_tx_hpd }]; #IO_L3N_T0_DQS_13 Sch=hdmi_tx_hpd
#set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_rscl }]; #IO_L6P_T0_34 Sch=hdmi_tx_rscl
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { hdmi_tx_rsda }]; #IO_L6N_T0_VREF_34 Sch=hdmi_tx_rsda
set_property -dict { PACKAGE_PIN Y1    IOSTANDARD LVCMOS33  } [get_ports { oHDMI_n[0] }]; #IO_L5N_T0_34 Sch=hdmi_tx_n[0]
set_property -dict { PACKAGE_PIN W1    IOSTANDARD LVCMOS33  } [get_ports { oHDMI_p[0] }]; #IO_L5P_T0_34 Sch=hdmi_tx_p[0]
set_property -dict { PACKAGE_PIN AB1   IOSTANDARD LVCMOS33  } [get_ports { oHDMI_n[1] }]; #IO_L7N_T1_34 Sch=hdmi_tx_n[1]
set_property -dict { PACKAGE_PIN AA1   IOSTANDARD LVCMOS33  } [get_ports { oHDMI_p[1] }]; #IO_L7P_T1_34 Sch=hdmi_tx_p[1]
set_property -dict { PACKAGE_PIN AB2   IOSTANDARD LVCMOS33  } [get_ports { oHDMI_n[2] }]; #IO_L8N_T1_34 Sch=hdmi_tx_n[2]
set_property -dict { PACKAGE_PIN AB3   IOSTANDARD LVCMOS33  } [get_ports { oHDMI_p[2] }]; #IO_L8P_T1_34 Sch=hdmi_tx_p[2]