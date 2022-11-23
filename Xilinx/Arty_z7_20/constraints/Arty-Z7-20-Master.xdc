## This file is a general .xdc for the ARTY Z7-20 Rev.B
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock Signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];#set

## Switches
set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports { RESET }]; #IO_L7N_T1_AD2N_35 Sch=SW0
set_property -dict { PACKAGE_PIN M19    IOSTANDARD LVCMOS33 } [get_ports { SW1 }]; #IO_L7P_T1_AD2P_35 Sch=SW1

## RGB LEDs
set_property -dict { PACKAGE_PIN L15    IOSTANDARD LVCMOS33 } [get_ports { LED_RGB[2] }]; #IO_L22N_T3_AD7P_35 Sch=LED4_B
set_property -dict { PACKAGE_PIN G17    IOSTANDARD LVCMOS33 } [get_ports { LED_RGB[1] }]; #IO_L16P_T2_35 Sch=LED4_G
set_property -dict { PACKAGE_PIN N15    IOSTANDARD LVCMOS33 } [get_ports { LED_RGB[0] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=LED4_R
set_property -dict { PACKAGE_PIN G14    IOSTANDARD LVCMOS33 } [get_ports { LED_RGB2[2] }]; #IO_0_35 Sch=LED5_B
set_property -dict { PACKAGE_PIN L14    IOSTANDARD LVCMOS33 } [get_ports { LED_RGB2[1] }]; #IO_L22P_T3_AD7P_35 Sch=LED5_G
set_property -dict { PACKAGE_PIN M15    IOSTANDARD LVCMOS33 } [get_ports { LED_RGB2[0] }]; #IO_L23N_T3_35 Sch=LED5_R

## LEDs
set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports { LED[0] }]; #IO_L6N_T0_VREF_34 Sch=LED0
set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports { LED[1] }]; #IO_L6P_T0_34 Sch=LED1
set_property -dict { PACKAGE_PIN N16    IOSTANDARD LVCMOS33 } [get_ports { LED[2] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=LED2
set_property -dict { PACKAGE_PIN M14    IOSTANDARD LVCMOS33 } [get_ports { LED[3] }]; #IO_L23P_T3_35 Sch=LED3

## Buttons
set_property -dict { PACKAGE_PIN D19    IOSTANDARD LVCMOS33 } [get_ports { BTN[0] }]; #IO_L4P_T0_35 Sch=BTN0
set_property -dict { PACKAGE_PIN D20    IOSTANDARD LVCMOS33 } [get_ports { BTN[1] }]; #IO_L4N_T0_35 Sch=BTN1
set_property -dict { PACKAGE_PIN L20    IOSTANDARD LVCMOS33 } [get_ports { BTN[2] }]; #IO_L9N_T1_DQS_AD3N_35 Sch=BTN2
set_property -dict { PACKAGE_PIN L19    IOSTANDARD LVCMOS33 } [get_ports { BTN[3] }]; #IO_L9P_T1_DQS_AD3P_35 Sch=BTN3

## Pmod Header JA
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { JA_P1 }]; #IO_L17P_T2_34 Sch=JA1_P
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { JA_N1 }]; #IO_L17N_T2_34 Sch=JA1_N
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { JA_P2 }]; #IO_L7P_T1_34 Sch=JA2_P
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { JA_N2 }]; #IO_L7N_T1_34 Sch=JA2_N
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { JA_P3 }]; #IO_L12P_T1_MRCC_34 Sch=JA3_P
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { JA_N3 }]; #IO_L12N_T1_MRCC_34 Sch=JA3_N
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { JA_P4 }]; #IO_L22P_T3_34 Sch=JA4_P
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { JA_N4 }]; #IO_L22N_T3_34 Sch=JA4_N

## Pmod Header JB
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { JB_N1 }]; #IO_L8N_T1_34 Sch=JB1_N
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { JB_P1 }]; #IO_L8P_T1_34 Sch=JB1_P
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { JB_N2 }]; #IO_L1N_T0_34 Sch=JB2_N
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { JB_P2 }]; #IO_L1P_T0_34 Sch=JB2_P
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { JB_N3 }]; #IO_L18N_T2_34 Sch=JB3_N
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { JB_P3 }]; #IO_L18P_T2_34 Sch=JB3_P
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { JB_N4 }]; #IO_L4N_T0_34 Sch=JB4_N
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { JB_P4 }]; #IO_L4P_T0_34 Sch=JB4_P

## Audio Out
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { AUD_PWM }]; #IO_L20N_T3_34 Sch=AUD_PWM
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { AUD_SD }]; #IO_L20P_T3_34 Sch=AUD_SD

## Crypto SDA 
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { CRYPTO_SDA }]; #IO_25_35 Sch=CRYPTO_SDA

## HDMI RX Signals
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { HDMI_RX_CEC }]; #IO_L13N_T2_MRCC_35 Sch=HDMI_RX_CEC
set_property -dict { PACKAGE_PIN P19   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_CLK_N }]; #IO_L13N_T2_MRCC_34 Sch=HDMI_RX_CLK_N
set_property -dict { PACKAGE_PIN N18   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_CLK_P }]; #IO_L13P_T2_MRCC_34 Sch=HDMI_RX_CLK_P
set_property -dict { PACKAGE_PIN W20   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_D_N1 }]; #IO_L16N_T2_34 Sch=HDMI_RX_D0_N
set_property -dict { PACKAGE_PIN V20   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_D_P1 }]; #IO_L16P_T2_34 Sch=HDMI_RX_D0_P
set_property -dict { PACKAGE_PIN U20   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_D_N2 }]; #IO_L15N_T2_DQS_34 Sch=HDMI_RX_D1_N
set_property -dict { PACKAGE_PIN T20   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_D_P2 }]; #IO_L15P_T2_DQS_34 Sch=HDMI_RX_D1_P
set_property -dict { PACKAGE_PIN P20   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_D_N3 }]; #IO_L14N_T2_SRCC_34 Sch=HDMI_RX_D2_N
set_property -dict { PACKAGE_PIN N20   IOSTANDARD TMDS_33  } [get_ports { HDMI_RX_D_P3 }]; #IO_L14P_T2_SRCC_34 Sch=HDMI_RX_D2_P
set_property -dict { PACKAGE_PIN T19   IOSTANDARD LVCMOS33 } [get_ports { HDMI_RX_HPD }]; #IO_25_34 Sch=HDMI_RX_HPD
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { HDMI_RX_SCL }]; #IO_L11P_T1_SRCC_34 Sch=HDMI_RX_SCL
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { HDMI_RX_SDA }]; #IO_L11N_T1_SRCC_34 Sch=HDMI_RX_SDA

## HDMI TX Signals
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { HDMI_TX_CEC }]; #IO_L19N_T3_VREF_35 Sch=HDMI_TX_CEC
set_property -dict { PACKAGE_PIN L17   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_CLK_N }]; #IO_L11N_T1_SRCC_35 Sch=HDMI_TX_CLK_N
set_property -dict { PACKAGE_PIN L16   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_CLK_P }]; #IO_L11P_T1_SRCC_35 Sch=HDMI_TX_CLK_P
set_property -dict { PACKAGE_PIN K18   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_D_N1 }]; #IO_L12N_T1_MRCC_35 Sch=HDMI_TX_D0_N
set_property -dict { PACKAGE_PIN K17   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_D_P1 }]; #IO_L12P_T1_MRCC_35 Sch=HDMI_TX_D0_P
set_property -dict { PACKAGE_PIN J19   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_D_N2 }]; #IO_L10N_T1_AD11N_35 Sch=HDMI_TX_D1_N
set_property -dict { PACKAGE_PIN K19   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_D_P2 }]; #IO_L10P_T1_AD11P_35 Sch=HDMI_TX_D1_P
set_property -dict { PACKAGE_PIN H18   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_D_N3 }]; #IO_L14N_T2_AD4N_SRCC_35 Sch=HDMI_TX_D2_N
set_property -dict { PACKAGE_PIN J18   IOSTANDARD TMDS_33  } [get_ports { HDMI_TX_D_P3 }]; #IO_L14P_T2_AD4P_SRCC_35 Sch=HDMI_TX_D2_P
set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { HDMI_TX_HPDN }]; #IO_0_34 Sch=HDMI_TX_HDPN
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { HDMI_TX_SCL }]; #IO_L8P_T1_AD10P_35 Sch=HDMI_TX_SCL
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { HDMI_TX_SDA }]; #IO_L8N_T1_AD10N_35 Sch=HDMI_TX_SDA

## ChipKit Outer Digital Header
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { CK_IO0  }]; #IO_L5P_T0_34            Sch=CK_IO0
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { CK_IO1  }]; #IO_L2N_T0_34            Sch=CK_IO1
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { CK_IO2  }]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=CK_IO2
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { CK_IO3  }]; #IO_L3N_T0_DQS_34        Sch=CK_IO3
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { CK_IO4  }]; #IO_L10P_T1_34           Sch=CK_IO4
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { CK_IO5  }]; #IO_L5N_T0_34            Sch=CK_IO5
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { CK_IO6  }]; #IO_L19P_T3_34           Sch=CK_IO6
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { CK_IO7  }]; #IO_L9N_T1_DQS_34        Sch=CK_IO7
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { CK_IO8  }]; #IO_L21P_T3_DQS_34       Sch=CK_IO8
set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { CK_IO9  }]; #IO_L21N_T3_DQS_34       Sch=CK_IO9
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { CK_IO10 }]; #IO_L9P_T1_DQS_34        Sch=CK_IO10
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { CK_IO11 }]; #IO_L19N_T3_VREF_34      Sch=CK_IO11
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { CK_IO12 }]; #IO_L23N_T3_34           Sch=CK_IO12
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { CK_IO13 }]; #IO_L23P_T3_34           Sch=CK_IO13

## ChipKit Inner Digital Header
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { CK_IO26 }]; #IO_L19N_T3_VREF_13  Sch=CK_IO26
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { CK_IO27 }]; #IO_L6N_T0_VREF_13   Sch=CK_IO27
set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports { CK_IO28 }]; #IO_L22P_T3_13       Sch=CK_IO28
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { CK_IO29 }]; #IO_L11P_T1_SRCC_13  Sch=CK_IO29
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { CK_IO30 }]; #IO_L11N_T1_SRCC_13  Sch=CK_IO30
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { CK_IO31 }]; #IO_L17N_T2_13       Sch=CK_IO31
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { CK_IO32 }]; #IO_L15P_T2_DQS_13   Sch=CK_IO32
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { CK_IO33 }]; #IO_L21N_T3_DQS_13   Sch=CK_IO33
set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { CK_IO34 }]; #IO_L16P_T2_13       Sch=CK_IO34
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { CK_IO35 }]; #IO_L22N_T3_13       Sch=CK_IO35
set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { CK_IO36 }]; #IO_L13N_T2_MRCC_13  Sch=CK_IO36
set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { CK_IO37 }]; #IO_L13P_T2_MRCC_13  Sch=cCK_IO37
set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { CK_IO38 }]; #IO_L15N_T2_DQS_13   Sch=CK_IO38
set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { CK_IO39 }]; #IO_L14N_T2_SRCC_13  Sch=CK_IO39
set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { CK_IO40 }]; #IO_L16N_T2_13       Sch=CK_IO40
set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { CK_IO41 }]; #IO_L14P_T2_SRCC_13  Sch=CK_IO41

## ChipKit Outer Analog Header - as Single-Ended Analog Inputs
## NOTE: These ports can be used as single-ended analog inputs with voltages from 0-3.3V (ChipKit analog pins A0-A5) or as digital I/O.
## WARNING: Do not use both sets of constraints at the same time!
## NOTE: The following constraints should be used with the XADC IP core when using these ports as analog inputs.
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { VAUX1_N  }]; #IO_L3N_T0_DQS_AD1N_35 Sch=CK_AN0_N   ChipKit pin=A0
set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { VAUX1_P  }]; #IO_L3P_T0_DQS_AD1P_35 Sch=CK_AN0_P   ChipKit pin=A0
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports { VAUX9_N  }]; #IO_L5N_T0_AD9N_35     Sch=CK_AN1_N   ChipKit pin=A1
set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { VAUX9_P  }]; #IO_L5P_T0_AD9P_35     Sch=CK_AN1_P   ChipKit pin=A1
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { VAUX6_N  }]; #IO_L20N_T3_AD6N_35    Sch=CK_AN2_N   ChipKit pin=A2
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { VAUX6_P  }]; #IO_L20P_T3_AD6P_35    Sch=CK_AN2_P   ChipKit pin=A2
set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { VAUX15_N }]; #IO_L24N_T3_AD15N_35   Sch=CK_AN3_N   ChipKit pin=A3
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { VAUX15_P }]; #IO_L24P_T3_AD15P_35   Sch=CK_AN3_P   ChipKit pin=A3
set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS33 } [get_ports { VAUX5_N  }]; #IO_L17N_T2_AD5N_35    Sch=CK_AN4_N   ChipKit pin=A4
set_property -dict { PACKAGE_PIN J20   IOSTANDARD LVCMOS33 } [get_ports { VAUX5_P  }]; #IO_L17P_T2_AD5P_35    Sch=CK_AN4_P   ChipKit pin=A4
set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS33 } [get_ports { VAUX13_N }]; #IO_L18N_T2_AD13N_35   Sch=CK_AN5_N   ChipKit pin=A5
set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { VAUX13_P }]; #IO_L18P_T2_AD13P_35   Sch=CK_AN5_P   ChipKit pin=A5
## ChipKit Outer Analog Header - as Digital I/O
## NOTE: The following constraints should be used when using these ports as digital I/O.
set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { CK_A0 }]; #IO_L18N_T2_13      Sch=CK_A0
set_property -dict { PACKAGE_PIN Y12   IOSTANDARD LVCMOS33 } [get_ports { CK_A1 }]; #IO_L20P_T3_13      Sch=CK_A1
set_property -dict { PACKAGE_PIN W11   IOSTANDARD LVCMOS33 } [get_ports { CK_A2 }]; #IO_L18P_T2_13      Sch=CK_A2
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { CK_A3 }]; #IO_L21P_T3_DQS_13  Sch=CK_A3
set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { CK_A4 }]; #IO_L19P_T3_13      Sch=CK_A4
set_property -dict { PACKAGE_PIN U10   IOSTANDARD LVCMOS33 } [get_ports { CK_A5 }]; #IO_L12N_T1_MRCC_13 Sch=CK_A5

## ChipKit Inner Analog Header - as Differential Analog Inputs
## NOTE: These ports can be used as differential analog inputs with voltages from 0-1.0V (ChipKit analog pins A6-A11) or as digital I/O.
## WARNING: Do not use both sets of constraints at the same time!
## NOTE: The following constraints should be used with the XADC core when using these ports as analog inputs.
set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { VAUX12_P }]; #IO_L15P_T2_DQS_AD12P_35 Sch=AD12_P   ChipKit pin=A6
set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { VAUX12_N }]; #IO_L15N_T2_DQS_AD12N_35 Sch=AD12_N   ChipKit pin=A7
set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { VAUX0_P  }]; #IO_L1P_T0_AD0P_35       Sch=AD0_P    ChipKit pin=A8
set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports { VAUX0_N  }]; #IO_L1N_T0_AD0N_35       Sch=AD0_N    ChipKit pin=A9
set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { VAUX8_P  }]; #IO_L2P_T0_AD8P_35       Sch=AD8_P    ChipKit pin=A10
set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports { VAUX8_N  }]; #IO_L2N_T0_AD8N_35       Sch=AD8_N    ChipKit pin=A11
## ChipKit Inner Analog Header - as Digital I/O
## NOTE: The following constraints should be used when using the inner analog header ports as digital I/O.
set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { CK_A6  }]; #IO_L15P_T2_DQS_AD12P_35 Sch=AD12_P
set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { CK_A7  }]; #IO_L15N_T2_DQS_AD12N_35 Sch=AD12_N
set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { CK_A8  }]; #IO_L1P_T0_AD0P_35       Sch=AD0_P
set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports { CK_A9  }]; #IO_L1N_T0_AD0N_35       Sch=AD0_N
set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { CK_A10 }]; #IO_L2P_T0_AD8P_35       Sch=AD8_P
set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports { CK_A11 }]; #IO_L2N_T0_AD8N_35       Sch=AD8_N

## ChipKit SPI
## NOTE: The ChipKit SPI header ports can also be used as digital I/O
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { CK_MISO }]; #IO_L10N_T1_34 Sch=CK_MISO
set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { CK_MOSI }]; #IO_L2P_T0_34 Sch=CK_MISO
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { CK_SCK  }]; #IO_L19P_T3_35 Sch=CK_SCK
set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { CK_SS   }]; #IO_L6P_T0_35 Sch=CK_SS

## ChipKit I2C
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { CK_SCL }]; #IO_L24N_T3_34 Sch=CK_SCL
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { CK_SDA }]; #IO_L24P_T3_34 Sch=CK_SDA

## Misc. ChipKit Ports
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS33 } [get_ports { CK_IOA }]; #IO_L20N_T3_13 Sch=CK_IOA

## Not Connected Pins
set_property PACKAGE_PIN F17 [get_ports {NETIC20_F17}]; #IO_L6N_T0_VREF_35
set_property PACKAGE_PIN G18 [get_ports {NETIC20_G18}]; #IO_L16N_T2_35
set_property PACKAGE_PIN T9 [get_ports {NETIC20_T9}]; #IO_L12P_T1_MRCC_13
set_property PACKAGE_PIN U9 [get_ports {NETIC20_U9}]; #IO_L17P_T2_13
