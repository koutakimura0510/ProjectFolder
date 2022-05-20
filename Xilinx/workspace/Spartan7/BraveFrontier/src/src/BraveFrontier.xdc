## This file is a general .xdc for the Spartan7 My Board
## Spartan7 FTGB 196
##
## Bank0  X0Y1 X1Y1
## Bank14 X0Y0
## Bank34 X1Y0

# ------------------------------------------------------------
# Configuration options, can be used for all designs
#  
# CONFIG_VOLTAGE 3.3 or 1.8
# CFGBVS VCCO or GND
# ------------------------------------------------------------
set_property CONFIG_VOLTAGE 1.8     [current_design]
set_property CFGBVS GND             [current_design]
set_property INTERNAL_VREF  0.900   [get_iobanks 14]


# ------------------------------------------------------------
# Bitstream SPI Set Clock Speed
# ------------------------------------------------------------
set_property BITSTREAM.CONFIG.CONFIGRATE        33              [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH      4               [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN  DISABLE         [current_design]


# ------------------------------------------------------------
# Clock Signal
#
# create_clock -name Signal -period 周期ns -waveform {duty比} [get_nets / get_ports 信号名]
# create_clock -name Signal -period 100MHz -waveform {duty比} [get_nets / get_ports 信号名]
# ------------------------------------------------------------
# OSC Input 25.000MHz
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iOscSystemClk }];
create_clock -add -name iOscSystemClk -period 40.00 -waveform {0 5} [get_ports iOscSystemClk]

# OSC Input 24.576MHz
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iOscAudioClk }];
create_clock -add -name iOscAudioClk -period 40.69 -waveform {0 5} [get_ports iOscAudioClk]

# USB Host Input 60.000MHz
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iUsbHostClk }];
create_clock -add -name iUsbHostClk -period 16.66 -waveform {0 5} [get_ports iUsbHostClk]

# FPGA PLL MMCM
create_generated_clock -name PixelClk [get_pins PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT0]
create_generated_clock -name TmdsClk  [get_pins PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT1]
create_generated_clock -name SysClk   [get_pins PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT2]

# 手動配置
set_property LOC MMCME2_ADV_X1Y0  [get_cells PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN]
# # set_property LOC PLLE2_ADV_X1Y0   [get_cells CGB/PLLE2_BASE_CLK_GEN]
# # set_property LOC RAMB18_X8Y55 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]
set_property LOC RAMB36_X2Y8 [get_cells PROCESSER/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]


# Flash Rom Port
set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33} [get_ports { oQspiSck[0]     }];
set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq0[0]    }];
set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq1[0]    }];
set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq2[0]    }];
set_property -dict { PACKAGE_PIN E13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq3[0]    }];
set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS33} [get_ports { oQspiCs[0]      }];

# set_property -dict { PACKAGE_PIN H13   IOSTANDARD LVCMOS33} [get_ports { oQspiSck[1]     }];
# set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33} [get_ports { oQspiCs[1]      }];
# set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq0[1]    }];
# set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq1[1]    }];
# set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq2[1]    }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq3[1]    }];

# # Config Rom Port
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiSck[1]     }];
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiMosi[1]    }];
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { iQspiMiso[1]    }];
# set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiCs[1]      }];

# PSRAM Port Data Bus
# [7:0] Data and Adrs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[0]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[1]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[2]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[3]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[4]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[5]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[6]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[7]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[8]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[9]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[10] }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[11] }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[12] }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[13] }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[14] }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDq[15] }];
set_property SLEW FAST [get_ports {ioSramDq[*]}]
set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {ioSramDq[*]}]
# DQS Bus
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDqs[0]  }];
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramDqs[1]  }];
set_property SLEW FAST [get_ports {ioSramDqs[*]}]
set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {ioSramDqs[*]}]
# Clk Bus
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramClk    }];
set_property SLEW FAST [get_ports {ioSramClk}]
set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {ioSramClk}]
# CS Bus
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS18  } [get_ports { oSramCs      }];


# TFT Display Port
set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[0]    }]; 
set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[1]    }]; 
set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[2]    }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[3]    }]; 
set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[0]    }]; 
set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[1]    }]; 
set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[2]    }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[3]    }]; 
set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[0]    }]; 
set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[1]    }]; 
set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[2]    }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[3]    }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftDclk         }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftHsync        }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftVsync        }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftDe           }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftBackLight    }]; 
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftRst          }]; 

# USB Host Controller Port
set_property -dict { PACKAGE_PIN P4    IOSTANDARD LVCMOS33  } [get_ports { oUnusedPin[0]   }];
set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33  } [get_ports { oUnusedPin[1]   }];
set_property -dict { PACKAGE_PIN P2    IOSTANDARD LVCMOS33  } [get_ports { oUnusedPin[2]   }];
set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33  } [get_ports { oApdsScl        }];
set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33  } [get_ports { ioApdsSda       }];
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33  } [get_ports { iApdsIntr       }];

# USB Controller UART Port


# USB Type-C UART Port
set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33  } [get_ports { iUartRx }];
set_property -dict { PACKAGE_PIN P12   IOSTANDARD LVCMOS33  } [get_ports { oUartTx }];


# I2S Audio Port

# LED Port
set_property -dict { PACKAGE_PIN P10   IOSTANDARD LVCMOS33  } [get_ports { oLed[0] }];
set_property -dict { PACKAGE_PIN P11   IOSTANDARD LVCMOS33  } [get_ports { oLed[1] }];

# 個別設定
# set_property PACKAGE_PIN A3       [get_ports aa]
# set_property IOSTANDARD  LVCMOS18 [get_ports aa]
# set_property PULLUP      true     [get_ports aa]

# 集団設定
# set_property PACKAGE_PIN A2       [get_ports aa[14]]
# set_property PACKAGE_PIN B2       [get_ports aa[15]]
# set_property IOSTANDARD  LVCMOS18 [get_ports aa[*]]
# set_property PULLUP      true     [get_ports aa[*]]