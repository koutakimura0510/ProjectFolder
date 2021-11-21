# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BCLK_COUNT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BCLK_COUNT_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FIFO_HEIGHT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FIFO_POS_NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FIFO_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_BCLK_COUNT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_MCLK_COUNT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PLAY_START" -parent ${Page_0}


}

proc update_PARAM_VALUE.BCLK_COUNT { PARAM_VALUE.BCLK_COUNT } {
	# Procedure called to update BCLK_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BCLK_COUNT { PARAM_VALUE.BCLK_COUNT } {
	# Procedure called to validate BCLK_COUNT
	return true
}

proc update_PARAM_VALUE.BCLK_COUNT_SIZE { PARAM_VALUE.BCLK_COUNT_SIZE } {
	# Procedure called to update BCLK_COUNT_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BCLK_COUNT_SIZE { PARAM_VALUE.BCLK_COUNT_SIZE } {
	# Procedure called to validate BCLK_COUNT_SIZE
	return true
}

proc update_PARAM_VALUE.FIFO_HEIGHT { PARAM_VALUE.FIFO_HEIGHT } {
	# Procedure called to update FIFO_HEIGHT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_HEIGHT { PARAM_VALUE.FIFO_HEIGHT } {
	# Procedure called to validate FIFO_HEIGHT
	return true
}

proc update_PARAM_VALUE.FIFO_POS_NUM { PARAM_VALUE.FIFO_POS_NUM } {
	# Procedure called to update FIFO_POS_NUM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_POS_NUM { PARAM_VALUE.FIFO_POS_NUM } {
	# Procedure called to validate FIFO_POS_NUM
	return true
}

proc update_PARAM_VALUE.FIFO_WIDTH { PARAM_VALUE.FIFO_WIDTH } {
	# Procedure called to update FIFO_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_WIDTH { PARAM_VALUE.FIFO_WIDTH } {
	# Procedure called to validate FIFO_WIDTH
	return true
}

proc update_PARAM_VALUE.MAX_BCLK_COUNT { PARAM_VALUE.MAX_BCLK_COUNT } {
	# Procedure called to update MAX_BCLK_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_BCLK_COUNT { PARAM_VALUE.MAX_BCLK_COUNT } {
	# Procedure called to validate MAX_BCLK_COUNT
	return true
}

proc update_PARAM_VALUE.MAX_MCLK_COUNT { PARAM_VALUE.MAX_MCLK_COUNT } {
	# Procedure called to update MAX_MCLK_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_MCLK_COUNT { PARAM_VALUE.MAX_MCLK_COUNT } {
	# Procedure called to validate MAX_MCLK_COUNT
	return true
}

proc update_PARAM_VALUE.PLAY_START { PARAM_VALUE.PLAY_START } {
	# Procedure called to update PLAY_START when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PLAY_START { PARAM_VALUE.PLAY_START } {
	# Procedure called to validate PLAY_START
	return true
}


proc update_MODELPARAM_VALUE.MAX_MCLK_COUNT { MODELPARAM_VALUE.MAX_MCLK_COUNT PARAM_VALUE.MAX_MCLK_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_MCLK_COUNT}] ${MODELPARAM_VALUE.MAX_MCLK_COUNT}
}

proc update_MODELPARAM_VALUE.MAX_BCLK_COUNT { MODELPARAM_VALUE.MAX_BCLK_COUNT PARAM_VALUE.MAX_BCLK_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_BCLK_COUNT}] ${MODELPARAM_VALUE.MAX_BCLK_COUNT}
}

proc update_MODELPARAM_VALUE.BCLK_COUNT_SIZE { MODELPARAM_VALUE.BCLK_COUNT_SIZE PARAM_VALUE.BCLK_COUNT_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BCLK_COUNT_SIZE}] ${MODELPARAM_VALUE.BCLK_COUNT_SIZE}
}

proc update_MODELPARAM_VALUE.BCLK_COUNT { MODELPARAM_VALUE.BCLK_COUNT PARAM_VALUE.BCLK_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BCLK_COUNT}] ${MODELPARAM_VALUE.BCLK_COUNT}
}

proc update_MODELPARAM_VALUE.FIFO_HEIGHT { MODELPARAM_VALUE.FIFO_HEIGHT PARAM_VALUE.FIFO_HEIGHT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_HEIGHT}] ${MODELPARAM_VALUE.FIFO_HEIGHT}
}

proc update_MODELPARAM_VALUE.FIFO_WIDTH { MODELPARAM_VALUE.FIFO_WIDTH PARAM_VALUE.FIFO_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_WIDTH}] ${MODELPARAM_VALUE.FIFO_WIDTH}
}

proc update_MODELPARAM_VALUE.FIFO_POS_NUM { MODELPARAM_VALUE.FIFO_POS_NUM PARAM_VALUE.FIFO_POS_NUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_POS_NUM}] ${MODELPARAM_VALUE.FIFO_POS_NUM}
}

proc update_MODELPARAM_VALUE.PLAY_START { MODELPARAM_VALUE.PLAY_START PARAM_VALUE.PLAY_START } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PLAY_START}] ${MODELPARAM_VALUE.PLAY_START}
}

