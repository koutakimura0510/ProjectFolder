# Create 2022/6/26
# Author koutakimura
#
# ------------------------------------------------------------------------------
# Configuration options, can be used for all designs
#  
# CONFIG_VOLTAGE 3.3 or 1.8
# CFGBVS VCCO or GND
# ------------------------------------------------------------------------------
set_property CONFIG_VOLTAGE 1.8     [current_design]
set_property CFGBVS GND             [current_design]
set_property INTERNAL_VREF  0.900   [get_iobanks 14]


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

# OSC Input 24.576MHz
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { iOscAudioClk }];
create_clock -add -name iOscAudioClk -period 40.69 -waveform {0 5} [get_ports iOscAudioClk]

#-------------------------------------------------------------------------------
# FPGA PLL MMCM
#-------------------------------------------------------------------------------
create_generated_clock -name PixelClk [get_pins PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT0]
create_generated_clock -name MemClk   [get_pins PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT1]
create_generated_clock -name SysClk   [get_pins PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT2]
# create_generated_clock -name AudioClk [get_pins PREPROCESSER/CGB/PLLE2_ADV_CLK_GEN/CLKOUT0]

#-------------------------------------------------------------------------------
# 手動配置
#-------------------------------------------------------------------------------
set_property LOC MMCME2_ADV_X1Y0  [get_cells PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN]
# set_property LOC PLLE2_ADV_X1Y0   [get_cells PREPROCESSER/CGB/PLLE2_ADV_CLK_GEN]
# # set_property LOC RAMB18_X8Y55 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]
# set_property LOC RAMB36_X2Y8 [get_cells PROCESSER/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]

#-------------------------------------------------------------------------------
# Flash Rom Port
# Connected Config Memory and System Memory
# Sck は Config 用の CCLK に直接つないでいるため、プリミティブを使用して通常ピンとして動作させる
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS18} [get_ports { ioSpiSck    	}]
set_property -dict { PACKAGE_PIN B12   IOSTANDARD LVCMOS18} [get_ports { ioSpiMiso   	}]
set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS18} [get_ports { ioSpiMosi   	}]
set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS18} [get_ports { ioSpiWp     	}]
set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS18} [get_ports { ioSpiHold   	}]
set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS18} [get_ports { oSpiConfigCs	}]
set_property -dict { PACKAGE_PIN A12   IOSTANDARD LVCMOS18} [get_ports { ioSpiCs     	}]
set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS18} [get_ports { iMSSel     	}]
# set_property PULLUP true [get_ports ioSpiWp]
# set_property PULLUP true [get_ports ioSpiHold]
# set_property PULLUP true [get_ports oSpiConfigCs]
# set_property PULLUP true [get_ports ioSpiCs]
# set_property PULLUP true [get_ports iMSSel]


#-------------------------------------------------------------------------------
# PSRAM Primary
#-------------------------------------------------------------------------------
# [7:0] Data and Adrs
set_property -dict { PACKAGE_PIN C14} [get_ports { ioSramDq[0]  }];
set_property -dict { PACKAGE_PIN B14} [get_ports { ioSramDq[1]  }];
set_property -dict { PACKAGE_PIN F14} [get_ports { ioSramDq[2]  }];
set_property -dict { PACKAGE_PIN D14} [get_ports { ioSramDq[3]  }];
set_property -dict { PACKAGE_PIN E13} [get_ports { ioSramDq[4]  }];
set_property -dict { PACKAGE_PIN D13} [get_ports { ioSramDq[5]  }];
set_property -dict { PACKAGE_PIN C12} [get_ports { ioSramDq[6]  }];
set_property -dict { PACKAGE_PIN B13} [get_ports { ioSramDq[7]  }];
set_property -dict { PACKAGE_PIN P13} [get_ports { ioSramDq[8]  }];
set_property -dict { PACKAGE_PIN N14} [get_ports { ioSramDq[9]  }];
set_property -dict { PACKAGE_PIN M13} [get_ports { ioSramDq[10] }];
set_property -dict { PACKAGE_PIN J13} [get_ports { ioSramDq[11] }];
set_property -dict { PACKAGE_PIN H14} [get_ports { ioSramDq[12] }];
set_property -dict { PACKAGE_PIN H13} [get_ports { ioSramDq[13] }];
set_property -dict { PACKAGE_PIN G14} [get_ports { ioSramDq[14] }];
set_property -dict { PACKAGE_PIN F13} [get_ports { ioSramDq[15] }];
set_property IOSTANDARD HSTL_II_18    [get_ports { ioSramDq[*]  }];
set_property SLEW FAST                [get_ports { ioSramDq[*]  }];
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports { ioSramDq[*]  }];
# DQS Bus
set_property -dict { PACKAGE_PIN J14} [get_ports { ioSramDqs[0] }];
set_property -dict { PACKAGE_PIN L14} [get_ports { ioSramDqs[1] }];
set_property IOSTANDARD HSTL_II_18    [get_ports { ioSramDqs[*] }];
set_property SLEW FAST                [get_ports { ioSramDqs[*] }];
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports { ioSramDqs[*] }];
# Clk Bus
set_property -dict { PACKAGE_PIN M14   IOSTANDARD HSTL_II_18} [get_ports { oSramClk     }];
set_property SLEW FAST [get_ports {oSramClk}];
# set_property IN_TERM UNTUNED_SPLIT_25 [get_ports {oSramClk}];
# CS Bus
set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS18  } [get_ports { oSramCs      }];
set_property PULLUP true [get_ports oSramCs];

#-------------------------------------------------------------------------------
# TFT Display
# RGB24bit 対応だが、容量削減のため使用画像データを ARGB16bit(4:4:4:4) を使用している
# そのため RGB 各 8bitの 上位 4bit のみ使用している
# oTftBackLight は PWM で調光する
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN A2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[4]    }]; 
set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[5]    }]; 
set_property -dict { PACKAGE_PIN C3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[6]    }]; 
set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[7]    }]; 
set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[4]    }]; 
set_property -dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[5]    }]; 
set_property -dict { PACKAGE_PIN B5    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[6]    }]; 
set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[7]    }]; 
set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[4]    }]; 
set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[5]    }]; 
set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[6]    }]; 
set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[7]    }]; 
set_property -dict { PACKAGE_PIN D2    IOSTANDARD LVCMOS33  } [get_ports { oTftDclk         }]; 
set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33  } [get_ports { oTftHsync        }]; 
set_property -dict { PACKAGE_PIN F2    IOSTANDARD LVCMOS33  } [get_ports { oTftVsync        }]; 
set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33  } [get_ports { oTftDe           }]; 
set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33  } [get_ports { oTftBackLight    }]; 
set_property -dict { PACKAGE_PIN D1    IOSTANDARD LVCMOS33  } [get_ports { oTftRst          }]; 
set_property PULLUP true [get_ports oTftRst]

#-------------------------------------------------------------------------------
# I2C Controller
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33  } [get_ports { oI2CScl  }];
set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33  } [get_ports { ioI2CSda }];
set_property PULLUP true [get_ports oI2CScl]
set_property PULLUP true [get_ports ioI2CSda]

#-------------------------------------------------------------------------------
# I2S Audio Port
# Master    Clk     24.576 MHz
# Base      Clk      3.072 MHz
# LRChannel Clk     48.000 KHz
# Serial    Data    16~32  Bit
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN P5    IOSTANDARD LVCMOS33  } [get_ports { oAudioMclk }];
set_property -dict { PACKAGE_PIN P4    IOSTANDARD LVCMOS33  } [get_ports { oAudioBclk }];
set_property -dict { PACKAGE_PIN P2    IOSTANDARD LVCMOS33  } [get_ports { oAudioCclk }];
set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33  } [get_ports { oAudioData }];

#-------------------------------------------------------------------------------
# UART
#-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33  } [get_ports { oUartTx  }];
# set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33  } [get_ports { iUartRx  }];
# set_property PULLUP true [get_ports oUartTx]
# set_property PULLUP true [get_ports iUartRx]

#-------------------------------------------------------------------------------
# LED Port Shift Register
#-------------------------------------------------------------------------------
# set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33  } [get_ports { oLedEdge[0] }];
# set_property -dict { PACKAGE_PIN C5    IOSTANDARD LVCMOS33  } [get_ports { oLedEdge[1] }];
# set_property -dict { PACKAGE_PIN E4    IOSTANDARD LVCMOS33  } [get_ports { oLedClk }];
# set_property DRIVE 4 [get_ports {oLedEdge[0]}];
# set_property DRIVE 4 [get_ports {oLedEdge[1]}];
# set_property DRIVE 4 [get_ports {oLedClk}];