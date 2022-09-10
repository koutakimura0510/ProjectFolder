# Create 2022/6/26
# Author koutakimura
#
# ------------------------------------------------------------------------------
# Configuration options, can be used for all designs
#  
# CONFIG_VOLTAGE 3.3 or 1.8
# CFGBVS VCCO or GND
# ------------------------------------------------------------------------------
set_property CONFIG_VOLTAGE 3.3      [current_design];
set_property CFGBVS VCCO             [current_design];
# set_property INTERNAL_VREF  0.900   [get_iobanks 14]


# ------------------------------------------------------------------------------
# Bitstream SPI Set Clock Speed
# ------------------------------------------------------------------------------
set_property BITSTREAM.CONFIG.CONFIGRATE        33              [current_design];
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH      4               [current_design];
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN  DISABLE         [current_design];


# ------------------------------------------------------------------------------
# Clock Signal
#
# create_clock -name Signal -period 周期ns -waveform {duty比} [get_nets / get_ports 信号名]
# create_clock -name Signal -period 100MHz -waveform {duty比} [get_nets / get_ports 信号名]
# ------------------------------------------------------------------------------
# OSC Input 25.000MHz
# set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { iOscSystemClk }];
# create_clock -add -name iOscSystemClk -period 40.00 -waveform {0 5} [get_ports iOscSystemClk]

# OSC Input 24.576MHz
# set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { iOscAudioClk }];
# create_clock -add -name iOscAudioClk -period 40.69 -waveform {0 5} [get_ports iOscAudioClk]

# OSC Input 12.000MHz
set_property -dict { PACKAGE_PIN L17    IOSTANDARD LVCMOS33 } [get_ports { iOscSystemClk }];
create_clock -add -name iOscAudioClk -period 83.33 -waveform {0 41.66} [get_ports iOscSystemClk];

#-------------------------------------------------------------------------------
# FPGA PLL MMCM
#-------------------------------------------------------------------------------
create_generated_clock -name SysClk   [get_pins PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT0];
create_generated_clock -name MemClk   [get_pins PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT1];
create_generated_clock -name VideoClk [get_pins PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT2];
create_generated_clock -name AudioClk [get_pins PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN/CLKOUT3];
# create_generated_clock -name AudioClk [get_pins PREPROCESSER/CGB/PLLE2_ADV_CLK_GEN/CLKOUT0]
# set_false_path -from [PRE_PROCESSER/CGB/rRst_reg] -to [PROCESSER/AUDIO_TX_BLOCK/AudioTxUnit/AudioToneIndex/rDecIndex_reg[*]]
# set_false_path -from [PRE_PROCESSER/CGB/rRst_reg] -to [PROCESSER/AUDIO_TX_BLOCK/AudioTxUnit/AudioToneIndex/rIntIndex_reg[*]]

#-------------------------------------------------------------------------------
# 手動配置
#-------------------------------------------------------------------------------
set_property LOC MMCME2_ADV_X0Y0  [get_cells PRE_PROCESSER/CGB/MMCME2_BASE_CLK_GEN];
# set_property LOC PLLE2_ADV_X1Y0   [get_cells PREPROCESSER/CGB/PLLE2_ADV_CLK_GEN]
# # set_property LOC RAMB18_X8Y55 [get_cells BASE/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]
# set_property LOC RAMB36_X2Y8 [get_cells PROCESSER/PFB/ASYNC_PIXEL_BUFFER/USER_FIFO_DUAL/fifo_reg]

#-------------------------------------------------------------------------------
# Flash Rom Port
# Connected Config Memory and System Memory
# RaspberryPi と接続を目的とするため FPGA は Slave として機能する。
# ESP32 などの Slave 機能を持っているデバイスの場合は、その限りではない。
# 
# デモキットでは QSPI 通信を想定していないため、Wp・Hold・ConfigCs ピンは接続されていない。
# そのため空きポートにエラー回避のため接続している。
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33} [get_ports { ioSpiSck    	}];
set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33} [get_ports { ioSpiMiso   	}];
set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33} [get_ports { ioSpiMosi   	}];
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33} [get_ports { ioSpiWp     	}]; # PIO8  空きポートに接続
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33} [get_ports { ioSpiHold   	}]; # PIO9  空きポートに接続
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33} [get_ports { oSpiConfigCs	}]; # PIO10 空きポートに接続
set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33} [get_ports { ioSpiCs     	}];
set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33} [get_ports { iMSSel     	}];
set_property PULLUP true [get_ports ioSpiWp]
set_property PULLUP true [get_ports ioSpiHold]
set_property PULLUP true [get_ports oSpiConfigCs]
set_property PULLUP true [get_ports ioSpiCs]
set_property PULLUP true [get_ports iMSSel]


#-------------------------------------------------------------------------------
# RAM Primary
# Cmod A7 搭載 SRAM
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN M18 } [get_ports { oMemAdr[0]  }]; #IO_L11P_T1_SRCC_14 Sch=sram- a[0]
set_property -dict { PACKAGE_PIN M19 } [get_ports { oMemAdr[1]  }]; #IO_L11N_T1_SRCC_14 Sch=sram- a[1]
set_property -dict { PACKAGE_PIN K17 } [get_ports { oMemAdr[2]  }]; #IO_L12N_T1_MRCC_14 Sch=sram- a[2]
set_property -dict { PACKAGE_PIN N17 } [get_ports { oMemAdr[3]  }]; #IO_L13P_T2_MRCC_14 Sch=sram- a[3]
set_property -dict { PACKAGE_PIN P17 } [get_ports { oMemAdr[4]  }]; #IO_L13N_T2_MRCC_14 Sch=sram- a[4]
set_property -dict { PACKAGE_PIN P18 } [get_ports { oMemAdr[5]  }]; #IO_L14P_T2_SRCC_14 Sch=sram- a[5]
set_property -dict { PACKAGE_PIN R18 } [get_ports { oMemAdr[6]  }]; #IO_L14N_T2_SRCC_14 Sch=sram- a[6]
set_property -dict { PACKAGE_PIN W19 } [get_ports { oMemAdr[7]  }]; #IO_L16N_T2_A15_D31_14 Sch=sram- a[7]
set_property -dict { PACKAGE_PIN U19 } [get_ports { oMemAdr[8]  }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=sram- a[8]
set_property -dict { PACKAGE_PIN V19 } [get_ports { oMemAdr[9]  }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=sram- a[9]
set_property -dict { PACKAGE_PIN W18 } [get_ports { oMemAdr[10] }]; #IO_L16P_T2_CSI_B_14 Sch=sram- a[10]
set_property -dict { PACKAGE_PIN T17 } [get_ports { oMemAdr[11] }]; #IO_L17P_T2_A14_D30_14 Sch=sram- a[11]
set_property -dict { PACKAGE_PIN T18 } [get_ports { oMemAdr[12] }]; #IO_L17N_T2_A13_D29_14 Sch=sram- a[12]
set_property -dict { PACKAGE_PIN U17 } [get_ports { oMemAdr[13] }]; #IO_L18P_T2_A12_D28_14 Sch=sram- a[13]
set_property -dict { PACKAGE_PIN U18 } [get_ports { oMemAdr[14] }]; #IO_L18N_T2_A11_D27_14 Sch=sram- a[14]
set_property -dict { PACKAGE_PIN V16 } [get_ports { oMemAdr[15] }]; #IO_L19P_T3_A10_D26_14 Sch=sram- a[15]
set_property -dict { PACKAGE_PIN W16 } [get_ports { oMemAdr[16] }]; #IO_L20P_T3_A08_D24_14 Sch=sram- a[16]
set_property -dict { PACKAGE_PIN W17 } [get_ports { oMemAdr[17] }]; #IO_L20N_T3_A07_D23_14 Sch=sram- a[17]
set_property -dict { PACKAGE_PIN V15 } [get_ports { oMemAdr[18] }]; #IO_L21P_T3_DQS_14 Sch=sram- a[18]
set_property -dict { PACKAGE_PIN W15 } [get_ports { ioMemDq[0]  }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=sram-dq[0]
set_property -dict { PACKAGE_PIN W13 } [get_ports { ioMemDq[1]  }]; #IO_L22P_T3_A05_D21_14 Sch=sram-dq[1]
set_property -dict { PACKAGE_PIN W14 } [get_ports { ioMemDq[2]  }]; #IO_L22N_T3_A04_D20_14 Sch=sram-dq[2]
set_property -dict { PACKAGE_PIN U15 } [get_ports { ioMemDq[3]  }]; #IO_L23P_T3_A03_D19_14 Sch=sram-dq[3]
set_property -dict { PACKAGE_PIN U16 } [get_ports { ioMemDq[4]  }]; #IO_L23N_T3_A02_D18_14 Sch=sram-dq[4]
set_property -dict { PACKAGE_PIN V13 } [get_ports { ioMemDq[5]  }]; #IO_L24P_T3_A01_D17_14 Sch=sram-dq[5]
set_property -dict { PACKAGE_PIN V14 } [get_ports { ioMemDq[6]  }]; #IO_L24N_T3_A00_D16_14 Sch=sram-dq[6]
set_property -dict { PACKAGE_PIN U14 } [get_ports { ioMemDq[7]  }]; #IO_25_14 Sch=sram-dq[7]
set_property -dict { PACKAGE_PIN P19 } [get_ports { oRamOE      }]; #IO_L10P_T1_D14_14 Sch=sram-oe
set_property -dict { PACKAGE_PIN R19 } [get_ports { oRamWE      }]; #IO_L10N_T1_D15_14 Sch=sram-we
set_property -dict { PACKAGE_PIN N19 } [get_ports { oRamCE      }]; #IO_L9N_T1_DQS_D13_14 Sch=sram-ce
##
set_property IOSTANDARD LVCMOS33    [get_ports { oMemAdr[*]  }];
set_property IOSTANDARD LVCMOS33    [get_ports { ioMemDq[*]  }];
set_property IOSTANDARD LVCMOS33    [get_ports { oRamOE      }];
set_property IOSTANDARD LVCMOS33    [get_ports { oRamWE      }];
set_property IOSTANDARD LVCMOS33    [get_ports { oRamCE      }];
##
set_property SLEW FAST              [get_ports { oMemAdr[*]  }];
set_property SLEW FAST              [get_ports { ioMemDq[*]  }];
set_property SLEW FAST              [get_ports { oRamOE      }];
set_property SLEW FAST              [get_ports { oRamWE      }];
set_property SLEW FAST              [get_ports { oRamCE      }];
##
# set_property PULLUP true 			[get_ports oSramCs];



#-------------------------------------------------------------------------------
# TFT Display
# RGB24bit 対応だが、容量削減のため使用画像データを ARGB16bit(4:4:4:4) を使用している
# そのため RGB 各 8bitの 上位 4bit のみ使用している
# oTftBackLight は PWM で調光する
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[4]    }]; 
set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[5]    }]; 
set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[6]    }]; 
set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33  } [get_ports { oTftColorR[7]    }]; 
set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[4]    }]; 
set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[5]    }]; 
set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[6]    }]; 
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33  } [get_ports { oTftColorG[7]    }]; 
set_property -dict { PACKAGE_PIN W4    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[4]    }]; 
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[5]    }]; 
set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[6]    }]; 
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33  } [get_ports { oTftColorB[7]    }]; 
set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33  } [get_ports { oTftDclk         }]; 
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33  } [get_ports { oTftHSync        }]; 
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33  } [get_ports { oTftVSync        }]; 
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33  } [get_ports { oTftDe           }]; 
set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33  } [get_ports { oTftBackLight    }]; 
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33  } [get_ports { oTftRst          }]; 
set_property PULLUP true [get_ports oTftRst]

#-------------------------------------------------------------------------------
# I2C Controller
# 外部 PullUp 使用
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN M3    IOSTANDARD LVCMOS33  } [get_ports { oI2CScl  }];
set_property -dict { PACKAGE_PIN L3    IOSTANDARD LVCMOS33  } [get_ports { ioI2CSda }];
# set_property PULLUP true [get_ports oI2CScl]
# set_property PULLUP true [get_ports ioI2CSda]

#-------------------------------------------------------------------------------
# PWM Audio Port
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33  } [get_ports { oAudioMclk }];

#-------------------------------------------------------------------------------
# UART
#-------------------------------------------------------------------------------
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { uart_rxd_out }]; #IO_L7N_T1_D10_14 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { uart_txd_in  }]; #IO_L7P_T1_D09_14 Sch=uart_txd_in

#-------------------------------------------------------------------------------
# LED Port
# LEDs    => VCC Flash
# RGB LED => GND Flash 
#-------------------------------------------------------------------------------
# LEDs
set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports { oLed[0] }]; #IO_L12N_T1_MRCC_16 Sch=led[1]
set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { oLed[1] }]; #IO_L13P_T2_MRCC_16 Sch=led[2]

# RGB LED
set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports { oLedB }]; #IO_L14N_T2_SRCC_16 Sch=led0_b
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { oLedG }]; #IO_L13N_T2_MRCC_16 Sch=led0_g
set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { oLedR }]; #IO_L14P_T2_SRCC_16 Sch=led0_r

## Pmod Header JA
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { ja[0] }]; #IO_L5N_T0_D07_14 Sch=ja[1]
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_L4N_T0_D05_14 Sch=ja[2]
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L9P_T1_DQS_14 Sch=ja[3]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L8P_T1_D11_14 Sch=ja[4]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L5P_T0_D06_14 Sch=ja[7]
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L4P_T0_D04_14 Sch=ja[8]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L6N_T0_D08_VREF_14 Sch=ja[9]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L8N_T1_D12_14 Sch=ja[10]


#-------------------------------------------------------------------------------
# Test Port
#-------------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33  } [get_ports { oTestPort[0] }];
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33  } [get_ports { oTestPort[1] }];
set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33  } [get_ports { oTestPort[2] }];
set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33  } [get_ports { oTestPort[3] }];


## This file is a general .xdc for the CmodA7 rev. B
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## 12 MHz Clock Signal
#set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { sysclk }]; #IO_L12P_T1_MRCC_14 Sch=gclk
#create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {sysclk}];

## LEDs
#set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L12N_T1_MRCC_16 Sch=led[1]
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L13P_T2_MRCC_16 Sch=led[2]

## RGB LED
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports { led0_b }]; #IO_L14N_T2_SRCC_16 Sch=led0_b
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { led0_g }]; #IO_L13N_T2_MRCC_16 Sch=led0_g
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { led0_r }]; #IO_L14P_T2_SRCC_16 Sch=led0_r

## Buttons
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; #IO_L19N_T3_VREF_16 Sch=btn[0]
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L19P_T3_16 Sch=btn[1]

## Pmod Header JA
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { ja[0] }]; #IO_L5N_T0_D07_14 Sch=ja[1]
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_L4N_T0_D05_14 Sch=ja[2]
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L9P_T1_DQS_14 Sch=ja[3]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L8P_T1_D11_14 Sch=ja[4]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L5P_T0_D06_14 Sch=ja[7]
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L4P_T0_D04_14 Sch=ja[8]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L6N_T0_D08_VREF_14 Sch=ja[9]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L8N_T1_D12_14 Sch=ja[10]

## Analog XADC Pins
## Only declare these if you want to use pins 15 and 16 as single ended analog inputs. pin 15 -> vaux4, pin16 -> vaux12
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { xa_n[0] }]; #IO_L1N_T0_AD4N_35 Sch=ain_n[15]
#set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { xa_p[0] }]; #IO_L1P_T0_AD4P_35 Sch=ain_p[15]
#set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { xa_n[1] }]; #IO_L2N_T0_AD12N_35 Sch=ain_n[16]
#set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { xa_p[1] }]; #IO_L2P_T0_AD12P_35 Sch=ain_p[16]

## GPIO Pins
## Pins 15 and 16 should remain commented if using them as analog inputs
#set_property -dict { PACKAGE_PIN M3    IOSTANDARD LVCMOS33 } [get_ports { pio1  }]; #IO_L8N_T1_AD14N_35 Sch=pio[01]
#set_property -dict { PACKAGE_PIN L3    IOSTANDARD LVCMOS33 } [get_ports { pio2  }]; #IO_L8P_T1_AD14P_35 Sch=pio[02]
#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports { pio3  }]; #IO_L12P_T1_MRCC_16 Sch=pio[03]
#set_property -dict { PACKAGE_PIN K3    IOSTANDARD LVCMOS33 } [get_ports { pio4  }]; #IO_L7N_T1_AD6N_35 Sch=pio[04]
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { pio5  }]; #IO_L11P_T1_SRCC_16 Sch=pio[05]
#set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { pio6  }]; #IO_L3P_T0_DQS_AD5P_35 Sch=pio[06]
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports { pio7  }]; #IO_L6N_T0_VREF_16 Sch=pio[07]
#set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports { pio8  }]; #IO_L11N_T1_SRCC_16 Sch=pio[08]
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { pio9  }]; #IO_L6P_T0_16 Sch=pio[09]
#set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { pio10 }]; #IO_L7P_T1_AD6P_35 Sch=pio[10]
#set_property -dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { pio11 }]; #IO_L3N_T0_DQS_AD5N_35 Sch=pio[11]
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { pio12 }]; #IO_L5P_T0_AD13P_35 Sch=pio[12]
#set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports { pio13 }]; #IO_L6N_T0_VREF_35 Sch=pio[13]
#set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33 } [get_ports { pio14 }]; #IO_L5N_T0_AD13N_35 Sch=pio[14]
#set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33 } [get_ports { pio17 }]; #IO_L9N_T1_DQS_AD7N_35 Sch=pio[17]
#set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports { pio18 }]; #IO_L12P_T1_MRCC_35 Sch=pio[18]
#set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports { pio19 }]; #IO_L12N_T1_MRCC_35 Sch=pio[19]
#set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { pio20 }]; #IO_L9P_T1_DQS_AD7P_35 Sch=pio[20]
#set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports { pio21 }]; #IO_L10N_T1_AD15N_35 Sch=pio[21]
#set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports { pio22 }]; #IO_L10P_T1_AD15P_35 Sch=pio[22]
#set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports { pio23 }]; #IO_L19N_T3_VREF_35 Sch=pio[23]
#set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { pio26 }]; #IO_L2P_T0_34 Sch=pio[26]
#set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports { pio27 }]; #IO_L2N_T0_34 Sch=pio[27]
#set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports { pio28 }]; #IO_L1P_T0_34 Sch=pio[28]
#set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports { pio29 }]; #IO_L3P_T0_DQS_34 Sch=pio[29]
#set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports { pio30 }]; #IO_L1N_T0_34 Sch=pio[30]
#set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports { pio31 }]; #IO_L3N_T0_DQS_34 Sch=pio[31]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports { pio32 }]; #IO_L5N_T0_34 Sch=pio[32]
#set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports { pio33 }]; #IO_L5P_T0_34 Sch=pio[33]
#set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports { pio34 }]; #IO_L6N_T0_VREF_34 Sch=pio[34]
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { pio35 }]; #IO_L6P_T0_34 Sch=pio[35]
#set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { pio36 }]; #IO_L12P_T1_MRCC_34 Sch=pio[36]
#set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { pio37 }]; #IO_L11N_T1_SRCC_34 Sch=pio[37]
#set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports { pio38 }]; #IO_L11P_T1_SRCC_34 Sch=pio[38]
#set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { pio39 }]; #IO_L16N_T2_34 Sch=pio[39]
#set_property -dict { PACKAGE_PIN W4    IOSTANDARD LVCMOS33 } [get_ports { pio40 }]; #IO_L12N_T1_MRCC_34 Sch=pio[40]
#set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { pio41 }]; #IO_L16P_T2_34 Sch=pio[41]
#set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33 } [get_ports { pio42 }]; #IO_L9N_T1_DQS_34 Sch=pio[42]
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { pio43 }]; #IO_L13N_T2_MRCC_34 Sch=pio[43]
#set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { pio44 }]; #IO_L9P_T1_DQS_34 Sch=pio[44]
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { pio45 }]; #IO_L19P_T3_34 Sch=pio[45]
#set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { pio46 }]; #IO_L13P_T2_MRCC_34 Sch=pio[46]
#set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { pio47 }]; #IO_L14P_T2_SRCC_34 Sch=pio[47]
#set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { pio48 }]; #IO_L14N_T2_SRCC_34 Sch=pio[48]

## UART
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { uart_rxd_out }]; #IO_L7N_T1_D10_14 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { uart_txd_in  }]; #IO_L7P_T1_D09_14 Sch=uart_txd_in

## Crypto 1 Wire Interface
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { crypto_sda }]; #IO_0_14 Sch=crypto_sda

## QSPI
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { qspi_cs    }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]

## Cellular RAM
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[0]  }]; #IO_L11P_T1_SRCC_14 Sch=sram- a[0]
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[1]  }]; #IO_L11N_T1_SRCC_14 Sch=sram- a[1]
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[2]  }]; #IO_L12N_T1_MRCC_14 Sch=sram- a[2]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[3]  }]; #IO_L13P_T2_MRCC_14 Sch=sram- a[3]
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[4]  }]; #IO_L13N_T2_MRCC_14 Sch=sram- a[4]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[5]  }]; #IO_L14P_T2_SRCC_14 Sch=sram- a[5]
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[6]  }]; #IO_L14N_T2_SRCC_14 Sch=sram- a[6]
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[7]  }]; #IO_L16N_T2_A15_D31_14 Sch=sram- a[7]
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[8]  }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=sram- a[8]
#set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[9]  }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=sram- a[9]
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[10] }]; #IO_L16P_T2_CSI_B_14 Sch=sram- a[10]
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[11] }]; #IO_L17P_T2_A14_D30_14 Sch=sram- a[11]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[12] }]; #IO_L17N_T2_A13_D29_14 Sch=sram- a[12]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[13] }]; #IO_L18P_T2_A12_D28_14 Sch=sram- a[13]
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[14] }]; #IO_L18N_T2_A11_D27_14 Sch=sram- a[14]
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[15] }]; #IO_L19P_T3_A10_D26_14 Sch=sram- a[15]
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[16] }]; #IO_L20P_T3_A08_D24_14 Sch=sram- a[16]
#set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[17] }]; #IO_L20N_T3_A07_D23_14 Sch=sram- a[17]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[18] }]; #IO_L21P_T3_DQS_14 Sch=sram- a[18]
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { MemDB[0]   }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=sram-dq[0]
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { MemDB[1]   }]; #IO_L22P_T3_A05_D21_14 Sch=sram-dq[1]
#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[2]   }]; #IO_L22N_T3_A04_D20_14 Sch=sram-dq[2]
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { MemDB[3]   }]; #IO_L23P_T3_A03_D19_14 Sch=sram-dq[3]
#set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { MemDB[4]   }]; #IO_L23N_T3_A02_D18_14 Sch=sram-dq[4]
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { MemDB[5]   }]; #IO_L24P_T3_A01_D17_14 Sch=sram-dq[5]
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[6]   }]; #IO_L24N_T3_A00_D16_14 Sch=sram-dq[6]
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[7]   }]; #IO_25_14 Sch=sram-dq[7]
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { RamOEn     }]; #IO_L10P_T1_D14_14 Sch=sram-oe
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { RamWEn     }]; #IO_L10N_T1_D15_14 Sch=sram-we
#set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports { RamCEn     }]; #IO_L9N_T1_DQS_D13_14 Sch=sram-ce

## This file is a general .xdc for the CmodA7 rev. B
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## 12 MHz Clock Signal
#set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { sysclk }]; #IO_L12P_T1_MRCC_14 Sch=gclk
#create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {sysclk}];

## LEDs
#set_property -dict { PACKAGE_PIN A17   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L12N_T1_MRCC_16 Sch=led[1]
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L13P_T2_MRCC_16 Sch=led[2]

## RGB LED
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports { led0_b }]; #IO_L14N_T2_SRCC_16 Sch=led0_b
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { led0_g }]; #IO_L13N_T2_MRCC_16 Sch=led0_g
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { led0_r }]; #IO_L14P_T2_SRCC_16 Sch=led0_r

## Buttons
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { btn[0] }]; #IO_L19N_T3_VREF_16 Sch=btn[0]
#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L19P_T3_16 Sch=btn[1]

## Pmod Header JA
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { ja[0] }]; #IO_L5N_T0_D07_14 Sch=ja[1]
#set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_L4N_T0_D05_14 Sch=ja[2]
#set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { ja[2] }]; #IO_L9P_T1_DQS_14 Sch=ja[3]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L8P_T1_D11_14 Sch=ja[4]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { ja[4] }]; #IO_L5P_T0_D06_14 Sch=ja[7]
#set_property -dict { PACKAGE_PIN H19   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L4P_T0_D04_14 Sch=ja[8]
#set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L6N_T0_D08_VREF_14 Sch=ja[9]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_L8N_T1_D12_14 Sch=ja[10]

## Analog XADC Pins
## Only declare these if you want to use pins 15 and 16 as single ended analog inputs. pin 15 -> vaux4, pin16 -> vaux12
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { xa_n[0] }]; #IO_L1N_T0_AD4N_35 Sch=ain_n[15]
#set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { xa_p[0] }]; #IO_L1P_T0_AD4P_35 Sch=ain_p[15]
#set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { xa_n[1] }]; #IO_L2N_T0_AD12N_35 Sch=ain_n[16]
#set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { xa_p[1] }]; #IO_L2P_T0_AD12P_35 Sch=ain_p[16]

## GPIO Pins
## Pins 15 and 16 should remain commented if using them as analog inputs
#set_property -dict { PACKAGE_PIN M3    IOSTANDARD LVCMOS33 } [get_ports { pio1  }]; #IO_L8N_T1_AD14N_35 Sch=pio[01]
#set_property -dict { PACKAGE_PIN L3    IOSTANDARD LVCMOS33 } [get_ports { pio2  }]; #IO_L8P_T1_AD14P_35 Sch=pio[02]
#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports { pio3  }]; #IO_L12P_T1_MRCC_16 Sch=pio[03]
#set_property -dict { PACKAGE_PIN K3    IOSTANDARD LVCMOS33 } [get_ports { pio4  }]; #IO_L7N_T1_AD6N_35 Sch=pio[04]
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { pio5  }]; #IO_L11P_T1_SRCC_16 Sch=pio[05]
#set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { pio6  }]; #IO_L3P_T0_DQS_AD5P_35 Sch=pio[06]
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports { pio7  }]; #IO_L6N_T0_VREF_16 Sch=pio[07]
#set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports { pio8  }]; #IO_L11N_T1_SRCC_16 Sch=pio[08]
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { pio9  }]; #IO_L6P_T0_16 Sch=pio[09]
#set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { pio10 }]; #IO_L7P_T1_AD6P_35 Sch=pio[10]
#set_property -dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { pio11 }]; #IO_L3N_T0_DQS_AD5N_35 Sch=pio[11]
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { pio12 }]; #IO_L5P_T0_AD13P_35 Sch=pio[12]
#set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports { pio13 }]; #IO_L6N_T0_VREF_35 Sch=pio[13]
#set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33 } [get_ports { pio14 }]; #IO_L5N_T0_AD13N_35 Sch=pio[14]
#set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33 } [get_ports { pio17 }]; #IO_L9N_T1_DQS_AD7N_35 Sch=pio[17]
#set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports { pio18 }]; #IO_L12P_T1_MRCC_35 Sch=pio[18]
#set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports { pio19 }]; #IO_L12N_T1_MRCC_35 Sch=pio[19]
#set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { pio20 }]; #IO_L9P_T1_DQS_AD7P_35 Sch=pio[20]
#set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports { pio21 }]; #IO_L10N_T1_AD15N_35 Sch=pio[21]
#set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports { pio22 }]; #IO_L10P_T1_AD15P_35 Sch=pio[22]
#set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports { pio23 }]; #IO_L19N_T3_VREF_35 Sch=pio[23]
#set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { pio26 }]; #IO_L2P_T0_34 Sch=pio[26]
#set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports { pio27 }]; #IO_L2N_T0_34 Sch=pio[27]
#set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports { pio28 }]; #IO_L1P_T0_34 Sch=pio[28]
#set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports { pio29 }]; #IO_L3P_T0_DQS_34 Sch=pio[29]
#set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports { pio30 }]; #IO_L1N_T0_34 Sch=pio[30]
#set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports { pio31 }]; #IO_L3N_T0_DQS_34 Sch=pio[31]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports { pio32 }]; #IO_L5N_T0_34 Sch=pio[32]
#set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports { pio33 }]; #IO_L5P_T0_34 Sch=pio[33]
#set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports { pio34 }]; #IO_L6N_T0_VREF_34 Sch=pio[34]
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { pio35 }]; #IO_L6P_T0_34 Sch=pio[35]
#set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { pio36 }]; #IO_L12P_T1_MRCC_34 Sch=pio[36]
#set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { pio37 }]; #IO_L11N_T1_SRCC_34 Sch=pio[37]
#set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports { pio38 }]; #IO_L11P_T1_SRCC_34 Sch=pio[38]
#set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { pio39 }]; #IO_L16N_T2_34 Sch=pio[39]
#set_property -dict { PACKAGE_PIN W4    IOSTANDARD LVCMOS33 } [get_ports { pio40 }]; #IO_L12N_T1_MRCC_34 Sch=pio[40]
#set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { pio41 }]; #IO_L16P_T2_34 Sch=pio[41]
#set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33 } [get_ports { pio42 }]; #IO_L9N_T1_DQS_34 Sch=pio[42]
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { pio43 }]; #IO_L13N_T2_MRCC_34 Sch=pio[43]
#set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { pio44 }]; #IO_L9P_T1_DQS_34 Sch=pio[44]
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { pio45 }]; #IO_L19P_T3_34 Sch=pio[45]
#set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { pio46 }]; #IO_L13P_T2_MRCC_34 Sch=pio[46]
#set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { pio47 }]; #IO_L14P_T2_SRCC_34 Sch=pio[47]
#set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { pio48 }]; #IO_L14N_T2_SRCC_34 Sch=pio[48]

## UART
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { uart_rxd_out }]; #IO_L7N_T1_D10_14 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { uart_txd_in  }]; #IO_L7P_T1_D09_14 Sch=uart_txd_in

## Crypto 1 Wire Interface
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { crypto_sda }]; #IO_0_14 Sch=crypto_sda

## QSPI
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { qspi_cs    }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]

## Cellular RAM
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[0]  }]; #IO_L11P_T1_SRCC_14 Sch=sram- a[0]
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[1]  }]; #IO_L11N_T1_SRCC_14 Sch=sram- a[1]
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[2]  }]; #IO_L12N_T1_MRCC_14 Sch=sram- a[2]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[3]  }]; #IO_L13P_T2_MRCC_14 Sch=sram- a[3]
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[4]  }]; #IO_L13N_T2_MRCC_14 Sch=sram- a[4]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[5]  }]; #IO_L14P_T2_SRCC_14 Sch=sram- a[5]
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[6]  }]; #IO_L14N_T2_SRCC_14 Sch=sram- a[6]
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[7]  }]; #IO_L16N_T2_A15_D31_14 Sch=sram- a[7]
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[8]  }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=sram- a[8]
#set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[9]  }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=sram- a[9]
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[10] }]; #IO_L16P_T2_CSI_B_14 Sch=sram- a[10]
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[11] }]; #IO_L17P_T2_A14_D30_14 Sch=sram- a[11]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[12] }]; #IO_L17N_T2_A13_D29_14 Sch=sram- a[12]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[13] }]; #IO_L18P_T2_A12_D28_14 Sch=sram- a[13]
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[14] }]; #IO_L18N_T2_A11_D27_14 Sch=sram- a[14]
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[15] }]; #IO_L19P_T3_A10_D26_14 Sch=sram- a[15]
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[16] }]; #IO_L20P_T3_A08_D24_14 Sch=sram- a[16]
#set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[17] }]; #IO_L20N_T3_A07_D23_14 Sch=sram- a[17]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[18] }]; #IO_L21P_T3_DQS_14 Sch=sram- a[18]
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { MemDB[0]   }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=sram-dq[0]
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { MemDB[1]   }]; #IO_L22P_T3_A05_D21_14 Sch=sram-dq[1]
#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[2]   }]; #IO_L22N_T3_A04_D20_14 Sch=sram-dq[2]
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { MemDB[3]   }]; #IO_L23P_T3_A03_D19_14 Sch=sram-dq[3]
#set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { MemDB[4]   }]; #IO_L23N_T3_A02_D18_14 Sch=sram-dq[4]
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { MemDB[5]   }]; #IO_L24P_T3_A01_D17_14 Sch=sram-dq[5]
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[6]   }]; #IO_L24N_T3_A00_D16_14 Sch=sram-dq[6]
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[7]   }]; #IO_25_14 Sch=sram-dq[7]
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { RamOEn     }]; #IO_L10P_T1_D14_14 Sch=sram-oe
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { RamWEn     }]; #IO_L10N_T1_D15_14 Sch=sram-we
#set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports { RamCEn     }]; #IO_L9N_T1_DQS_D13_14 Sch=sram-ce

