## This file is a general .xdc for the Spartan7 My Board
## Spartan7 FTGB 196
##
## Bank0  X0Y1 X1Y1
## Bank14 X0Y0
## Bank34 X1Y0

# ------------------------------------------------------------------------------
# Configuration options, can be used for all designs
#  
# CONFIG_VOLTAGE 3.3 or 1.8
# CFGBVS VCCO or GND
# ------------------------------------------------------------------------------
set_property CONFIG_VOLTAGE 1.8     [current_design]
set_property CFGBVS GND             [current_design]
set_property INTERNAL_VREF  0.900   [get_iobanks 34]


# ------------------------------------------------------------------------------
# Bitstream SPI Set Clock Speed
# ------------------------------------------------------------------------------
set_property BITSTREAM.CONFIG.CONFIGRATE        33              [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH      4               [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN  DISABLE         [current_design]


# ------------------------------------------------------------------------------
# Clock Signal
#
# create_clock -name Signal -period 周期ns -waveform {duty比} [get_nets / get_ports 信号名]
# create_clock -name Signal -period 100MHz -waveform {duty比} [get_nets / get_ports 信号名]
# ------------------------------------------------------------------------------
# OSC Input 25.000MHz
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iOscSystemClk }];
create_clock -add -name iOscSystemClk -period 40.00 -waveform {0 5} [get_ports iOscSystemClk]

# # OSC Input 24.576MHz
# set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iOscAudioClk }];
# create_clock -add -name iOscAudioClk -period 40.69 -waveform {0 5} [get_ports iOscAudioClk]

# #-------------------------------------------------------------------------------
# # FPGA PLL MMCM
# #-------------------------------------------------------------------------------
# create_generated_clock -name PixelClk [get_pins PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT0]
# create_generated_clock -name TmdsClk  [get_pins PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT1]
# create_generated_clock -name SysClk   [get_pins PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT2]

# #-------------------------------------------------------------------------------
# # 手動配置
# #-------------------------------------------------------------------------------
# set_property LOC MMCME2_ADV_X1Y0  [get_cells PREPROCESSER/CGB/MMCME2_BASE_CLK_GEN]
# # # set_property LOC PLLE2_ADV_X1Y0   [get_cells CGB/PLLE2_BASE_CLK_GEN]
# # # set_property LOC RAMB18_X8Y55 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]
# set_property LOC RAMB36_X2Y8 [get_cells PROCESSER/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]

# #-------------------------------------------------------------------------------
# # Flash Rom Port
# #-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33} [get_ports { oQspiSck     }];
# set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq0    }];
# set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq1    }];
# set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq2    }];
# set_property -dict { PACKAGE_PIN E13   IOSTANDARD LVCMOS33} [get_ports { ioQspiDq3    }];
# set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS33} [get_ports { oQspiCs      }];

# #-------------------------------------------------------------------------------
# # Config Rom Port
# #-------------------------------------------------------------------------------
# # set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiSck[1]     }];
# # set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiMosi[1]    }];
# # set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { iQspiMiso[1]    }];
# # set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oQspiCs[1]      }];

# #-------------------------------------------------------------------------------
# # PSRAM Primary Port
# #-------------------------------------------------------------------------------
# # [7:0] Data and Adrs
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[0]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[1]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[2]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[3]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[4]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[5]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[6]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[7]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[8]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[9]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[10] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[11] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[12] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[13] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[14] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDq[15] }];
# set_property SLEW FAST [get_ports {ioSrampDq[*]}]
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {ioSrampDq[*]}]
# # DQS Bus
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDqs[0]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSrampDqs[1]  }];
# set_property SLEW FAST [get_ports {ioSrampDqs[*]}]
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {ioSrampDqs[*]}]
# # Clk Bus
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { oSrampClk     }];
# set_property SLEW FAST [get_ports {oSrampClk}]
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {oSrampClk}]
# # CS Bus
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS18  } [get_ports { oSrampCs      }];
# set_property PULLUP true [get_ports oSrampCs]

# #-------------------------------------------------------------------------------
# # PSRAM Secondary Port
# #-------------------------------------------------------------------------------
# # [7:0] Data and Adrs
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[0]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[1]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[2]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[3]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[4]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[5]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[6]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[7]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[8]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[9]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[10] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[11] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[12] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[13] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[14] }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDq[15] }];
# set_property SLEW FAST [get_ports {ioSramsDq[*]}]
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {ioSramsDq[*]}]
# # DQS Bus
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDqs[0]  }];
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { ioSramsDqs[1]  }];
# set_property SLEW FAST [get_ports {ioSramsDqs[*]}]
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {ioSramsDqs[*]}]
# # Clk Bus
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { oSramsClk     }];
# set_property SLEW FAST [get_ports {oSramsClk}]
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {oSramsClk}]
# # CS Bus
# set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS18  } [get_ports { oSramsCs      }];
# set_property PULLUP true [get_ports oSramsCs]

# #-------------------------------------------------------------------------------
# # TFT Display Port
# # RGB24bit 対応だが、容量削減のため使用画像データを ARGB16bit(4:4:4:4) を使用している
# # そのため RGB 各 8bitの 上位 4bit のみ使用している
# # oTftBackLight は PWM で調光する
# #-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[4]    }]; 
# set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[5]    }]; 
# set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[6]    }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[7]    }]; 
# set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[4]    }]; 
# set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[5]    }]; 
# set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[6]    }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[7]    }]; 
# set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[4]    }]; 
# set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[5]    }]; 
# set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[6]    }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[7]    }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftDclk         }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftHsync        }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftVsync        }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftDe           }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftBackLight    }]; 
# set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftRst          }]; 
# set_property PULLUP true [get_ports oTftRst]

# #-------------------------------------------------------------------------------
# # USB Controller CH1
# #-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33  } [get_ports { iUsbCh1 }];
# set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33  } [get_ports { oUsbCh1 }];
# set_property PULLUP true [get_ports iUsbCh1]
# set_property PULLUP true [get_ports oUsbCh1]

# #-------------------------------------------------------------------------------
# # USB Controller CH2
# #-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33  } [get_ports { iUsbCh2 }];
# set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33  } [get_ports { oUsbCh2 }];
# set_property PULLUP true [get_ports iUsbCh2]
# set_property PULLUP true [get_ports oUsbCh2]

# #-------------------------------------------------------------------------------
# # USB Type-C UART Port
# #-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN P13   IOSTANDARD LVCMOS33  } [get_ports { iUartRx }];
# set_property -dict { PACKAGE_PIN P12   IOSTANDARD LVCMOS33  } [get_ports { oUartTx }];
# set_property PULLUP true [get_ports iUartRx]
# set_property PULLUP true [get_ports oUartTx]

# #-------------------------------------------------------------------------------
# # I2S Audio Port
# # Master    Clk     24.576 MHz
# # Base      Clk      3.072 MHz
# # LRChannel Clk     48.000 KHz
# # Serial    Data    16~32  Bit
# #-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN P12   IOSTANDARD LVCMOS33  } [get_ports { oAudioMclk }];
# set_property -dict { PACKAGE_PIN P12   IOSTANDARD LVCMOS33  } [get_ports { oAudioBclk }];
# set_property -dict { PACKAGE_PIN P12   IOSTANDARD LVCMOS33  } [get_ports { oAudioCclk }];
# set_property -dict { PACKAGE_PIN P12   IOSTANDARD LVCMOS33  } [get_ports { oAudioData }];

# #-------------------------------------------------------------------------------
# # LED Port
# #-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN P10   IOSTANDARD LVCMOS18  } [get_ports { oLed }];
# set_property -dict { PACKAGE_PIN P11   IOSTANDARD LVCMOS18  } [get_ports { oLed[1] }];

# # 個別設定
# # set_property PACKAGE_PIN A3       [get_ports aa]
# # set_property IOSTANDARD  LVCMOS18 [get_ports aa]
# # set_property PULLUP      true     [get_ports aa]

# # 集団設定
# # set_property PACKAGE_PIN A2       [get_ports aa[14]]
# # set_property PACKAGE_PIN B2       [get_ports aa[15]]
# # set_property IOSTANDARD  LVCMOS18 [get_ports aa[*]]
# # set_property PULLUP      true     [get_ports aa[*]]