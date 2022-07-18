# OSC Input 50.000MHz
set_property -dict { PACKAGE_PIN GPIOR_186_PLLIN0    IOSTANDARD LVCMOS33 } [get_ports { iOscClk }];
create_clock -add -name iOscClk -period 20.00 -waveform {0 5} [get_ports iOscClk]
# create_clock -period 25 -name {clk}

# -----------------------------------------------------------
#  Banc 4C
# -----------------------------------------------------------
# User Led
set_property -dict { PACKAGE_PIN GPIOB_RXP04} [get_ports { oUserLed[0]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN04} [get_ports { oUserLed[1]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXP05} [get_ports { oUserLed[2]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN05} [get_ports { oUserLed[3]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXP06} [get_ports { oUserLed[4]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN06} [get_ports { oUserLed[5]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXP07} [get_ports { oUserLed[6]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN07} [get_ports { oUserLed[7]  }];

# User Push Sw
set_property -dict { PACKAGE_PIN GPIOB_RXP08} [get_ports { iUserPushSw[0]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN08} [get_ports { iUserPushSw[1]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXP09} [get_ports { iUserPushSw[2]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN09} [get_ports { iUserPushSw[3]  }];

# User Dip Sw
set_property -dict { PACKAGE_PIN GPIOB_RXP02} [get_ports { iUserDipSw[0]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN02} [get_ports { iUserDipSw[1]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXP03} [get_ports { iUserDipSw[2]  }];
set_property -dict { PACKAGE_PIN GPIOB_RXN03} [get_ports { iUserDipSw[3]  }];