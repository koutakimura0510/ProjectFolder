## This file is a general .xdc for the Spartan7 My Board
## Spartan7 FTGB 196
##
## Bank0  X0Y1 X1Y1
## Bank14 X0Y0
## Bank34 X1Y0

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
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iClk }];
create_clock -add -name iClk -period 40.00 -waveform {0 5} [get_ports iClk]

# FPGA PLL MMCM
create_generated_clock -name PixelClk [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT0]
create_generated_clock -name TmdsClk  [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT1]
create_generated_clock -name BaseClk  [get_pins CGB/MMCME2_BASE_CLK_GEN/CLKOUT2]

# 手動配線
set_property LOC MMCME2_ADV_X1Y0  [get_cells CGB/MMCME2_BASE_CLK_GEN]
# # set_property LOC PLLE2_ADV_X1Y0   [get_cells CGB/PLLE2_BASE_CLK_GEN]
# # set_property LOC RAMB18_X8Y55 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]
set_property LOC RAMB36_X2Y8 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]

# # ADUS5689
set_property -dict { PACKAGE_PIN P4    IOSTANDARD LVCMOS33} [get_ports { oApdsScl  [0]    }];
set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33} [get_ports { ioApdsSda [0]    }];
set_property -dict { PACKAGE_PIN P2    IOSTANDARD LVCMOS33} [get_ports { iApdsIntr [0]    }];
set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33} [get_ports { oApdsScl  [1]    }];
set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33} [get_ports { ioApdsSda [1]    }];
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33} [get_ports { iApdsIntr [1]    }];

# Flash Rom 1-2
set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33} [get_ports { oQspiSck  [0]    }];
set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq0 [0]    }];
set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq1 [0]    }];
set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq2 [0]    }];
set_property -dict { PACKAGE_PIN E13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq3 [0]    }];
set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS33} [get_ports { oQspiCs   [0]    }];

set_property -dict { PACKAGE_PIN H13   IOSTANDARD LVCMOS33} [get_ports { oQspiSck  [1]    }];
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33} [get_ports { oQspiCs   [1]    }];
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq0 [1]    }];
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq1 [1]    }];
set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq2 [1]    }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq3 [1]    }];

# # Config Rom
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiSck[1]     }];
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiMosi[1]    }];
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { iQspiMiso[1]    }];
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiCs[1]      }];


# ## HDMI TX
set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oHdmiClkNeg      }]; 
set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oHdmiClkPos      }]; 
set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataPos[0]  }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataNeg[0]  }]; 
set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataPos[1]  }]; 
set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataNeg[1]  }]; 
set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataPos[2]  }]; 
set_property -dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33  } [get_ports { oHdmiDataNeg[2]  }]; 
set_property -dict { PACKAGE_PIN D1    IOSTANDARD LVCMOS33  } [get_ports { ioHdmiCec        }]; 
set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33  } [get_ports { iHdmiHpd         }]; 
set_property -dict { PACKAGE_PIN F2    IOSTANDARD LVCMOS33  } [get_ports { oHdmiScl         }];
set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33  } [get_ports { ioHdmiSda        }];

# UART
set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33  } [get_ports { iUartRx }];
set_property -dict { PACKAGE_PIN P12   IOSTANDARD LVCMOS33  } [get_ports { oUartTx }];

# LED
set_property -dict { PACKAGE_PIN P10   IOSTANDARD LVCMOS33  } [get_ports { oLed[0] }];
set_property -dict { PACKAGE_PIN P11   IOSTANDARD LVCMOS33  } [get_ports { oLed[1] }];
