# OSC Input 50.000MHz
create_clock -name iSysClk -period 10.00 -waveform {0 5} [get_ports iSysClk]
# design.assign_pkg_pin("iOscClk","P19")
# io_standard LVCMOS33 [get_ports { iOscClk }];
# gpio_def PACKAGE_PIN P19 [get_ports { iOscClk }];
# create_clock -period 25 -name {clk}

# -----------------------------------------------------------
#  Banc 4C
# -----------------------------------------------------------
# User Led
# set_property -dict { PACKAGE_PIN AB16} [get_ports { oUserLed[0]  }]; # GPIOB_RXP04
# set_property -dict { PACKAGE_PIN AA16} [get_ports { oUserLed[1]  }]; # GPIOB_RXN04
# set_property -dict { PACKAGE_PIN  T15} [get_ports { oUserLed[2]  }]; # GPIOB_RXP05
# set_property -dict { PACKAGE_PIN  Y15} [get_ports { oUserLed[3]  }]; # GPIOB_RXN05
# set_property -dict { PACKAGE_PIN  Y16} [get_ports { oUserLed[4]  }]; # GPIOB_RXP06
# set_property -dict { PACKAGE_PIN  W16} [get_ports { oUserLed[5]  }]; # GPIOB_RXN06
# set_property -dict { PACKAGE_PIN AD16} [get_ports { oUserLed[6]  }]; # GPIOB_RXP07
# set_property -dict { PACKAGE_PIN AC16} [get_ports { oUserLed[7]  }]; # GPIOB_RXN07
# io_standard LVCMOS33	   [get_ports { oUserLed[*]  }];

# User Push Sw
# set_property -dict { PACKAGE_PIN AD15} [get_ports { iUserPushSw[0]  }]; # GPIOB_RXP08
# set_property -dict { PACKAGE_PIN AC15} [get_ports { iUserPushSw[1]  }]; # GPIOB_RXN08
# set_property -dict { PACKAGE_PIN  W15} [get_ports { iUserPushSw[2]  }]; # GPIOB_RXP09
# set_property -dict { PACKAGE_PIN  V15} [get_ports { iUserPushSw[3]  }]; # GPIOB_RXN09
# set_property IOSTANDARD LVCMOS33	   [get_ports { iUserPushSw[*]  }];

# # User Dip Sw
# set_property -dict { PACKAGE_PIN  U16} [get_ports { iUserDipSw[0]  }]; # GPIOB_RXP02
# set_property -dict { PACKAGE_PIN  T16} [get_ports { iUserDipSw[1]  }]; # GPIOB_RXN02
# set_property -dict { PACKAGE_PIN  T15} [get_ports { iUserDipSw[2]  }]; # GPIOB_RXP03
# set_property -dict { PACKAGE_PIN  U15} [get_ports { iUserDipSw[3]  }]; # GPIOB_RXN03
# set_property IOSTANDARD LVCMOS33	   [get_ports { iUserDipSw[*]  }];