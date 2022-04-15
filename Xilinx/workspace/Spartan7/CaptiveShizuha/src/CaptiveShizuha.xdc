### This file is a general .xdc for the Spartan7 My Board
### Spartan7 FTGB 196

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


# ------------------------------------------------------------
# Clock Signal
# dutyを指定しない場合は duty50%適応
# create_clock -name 信号名 -period 周期ns -waveform {duty比} [get_nets / get_ports 信号名]
# create_clock -name 信号名 -period 100MHz -waveform {duty比} [get_nets / get_ports 信号名]
# ------------------------------------------------------------
# OSC Input 25MHz
set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { iClk }]; #IO_L13P_T2_MRCC_34 Sch=sysclk
create_clock -add -name iClk -period 40.00 -waveform {0 5} [get_ports iClk]

# FPGA PLL MMCM
create_generated_clock -name PCLK [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT0]
create_generated_clock -name TCLK [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT1]
create_generated_clock -name BCLK [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT2]

# 手動配線
set_property LOC MMCME2_ADV_X1Y2  [get_cells CGB/MMCME2_BASE_CLK_GEN]
# set_property LOC PLLE2_ADV_X1Y2   [get_cells CGB/PLLE2_BASE_CLK_GEN]
# set_property LOC RAMB18_X8Y55 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]
set_property LOC RAMB36_X8Y27 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]

# ADUS5689
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oApdsScl[0]     }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { ioApdsSda[0]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oApdsScl[1]     }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { ioApdsSda[1]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n

# Flash Rom 1-2
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33             } [get_ports { oQspiSck[0]     }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oQspiMosi[0]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { iQspiMiso[0]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oQspiHold[0]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { iQspiRst[0]     }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oQspiCs[0]      }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n

set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33             } [get_ports { oQspiSck[1]     }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oQspiMosi[1]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { iQspiMiso[1]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oQspiHold[1]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { iQspiRst[1]     }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oQspiCs[1]      }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n

# Config Rom
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiSck[1]     }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiMosi[1]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { iQspiMiso[1]    }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiCs[1]      }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n


## HDMI TX
set_property -dict { PACKAGE_PIN AA4   IOSTANDARD LVCMOS33  } [get_ports { ioHdmiCec        }]; #IO_L11N_T1_SRCC_34 Sch=hdmi_tx_cec
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oHdmiClkNeg      }]; #IO_L1N_T0_34 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33  } [get_ports { oHdmiClkPos      }]; #IO_L1P_T0_34 Sch=hdmi_tx_clk_p
set_property -dict { PACKAGE_PIN AB13  IOSTANDARD LVCMOS33  } [get_ports { iHdmiHpd         }]; #IO_L3N_T0_DQS_13 Sch=hdmi_tx_hpd
set_property -dict { PACKAGE_PIN Y1    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataNeg[0]  }]; #IO_L5N_T0_34 Sch=hdmi_tx_n[0]
set_property -dict { PACKAGE_PIN W1    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataPos[0]  }]; #IO_L5P_T0_34 Sch=hdmi_tx_p[0]
set_property -dict { PACKAGE_PIN AB1   IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataNeg[1]  }]; #IO_L7N_T1_34 Sch=hdmi_tx_n[1]
set_property -dict { PACKAGE_PIN AA1   IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataPos[1]  }]; #IO_L7P_T1_34 Sch=hdmi_tx_p[1]
set_property -dict { PACKAGE_PIN AB2   IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataNeg[2]  }]; #IO_L8N_T1_34 Sch=hdmi_tx_n[2]
set_property -dict { PACKAGE_PIN AB3   IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataPos[2]  }]; #IO_L8P_T1_34 Sch=hdmi_tx_p[2]
set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { oHdmiScl }]; #IO_L6P_T0_34 Sch=hdmi_tx_rscl
set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33  PULLUP TRUE} [get_ports { ioHdmiSda }]; #IO_L6N_T0_VREF_34 Sch=hdmi_tx_rsda

# Debug Pin UART
set_property -dict { PACKAGE_PIN AB3   IOSTANDARD LVCMOS33  } [get_ports { iUartRx }]; #IO_L8P_T1_34 Sch=hdmi_tx_p[2]
set_property -dict { PACKAGE_PIN AB3   IOSTANDARD LVCMOS33  } [get_ports { oUartTx }]; #IO_L8P_T1_34 Sch=hdmi_tx_p[2]

# Debug Pin Free