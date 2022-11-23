
log_wave [get_objects -filter {type == in_port || type == out_port || type == inout_port || type == port} /apatb_patbit_top/AESL_inst_patbit/*]
set designtopgroup [add_wave_group "Design Top Signals"]
set cinoutgroup [add_wave_group "C InOuts" -into $designtopgroup]
set dstout__xpos__ypos__width__height__color__return_group [add_wave_group dstout__xpos__ypos__width__height__color__return(axi_slave) -into $cinoutgroup]
add_wave /apatb_patbit_top/AESL_inst_patbit/interrupt -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_BRESP -into $dstout__xpos__ypos__width__height__color__return_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_BREADY -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_BVALID -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_RRESP -into $dstout__xpos__ypos__width__height__color__return_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_RDATA -into $dstout__xpos__ypos__width__height__color__return_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_RREADY -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_RVALID -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_ARREADY -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_ARVALID -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_ARADDR -into $dstout__xpos__ypos__width__height__color__return_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_WSTRB -into $dstout__xpos__ypos__width__height__color__return_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_WDATA -into $dstout__xpos__ypos__width__height__color__return_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_WREADY -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_WVALID -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_AWREADY -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_AWVALID -into $dstout__xpos__ypos__width__height__color__return_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/s_axi_control_AWADDR -into $dstout__xpos__ypos__width__height__color__return_group -radix hex
set coutputgroup [add_wave_group "C Outputs" -into $designtopgroup]
set dstout_group [add_wave_group dstout(axi_master) -into $coutputgroup]
set rdata_group [add_wave_group "Read Channel" -into $dstout_group]
set wdata_group [add_wave_group "Write Channel" -into $dstout_group]
set ctrl_group [add_wave_group "Handshakes" -into $dstout_group]
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_BUSER -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_BID -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_BRESP -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_BREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_BVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_RRESP -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_RUSER -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_RID -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_RLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_RDATA -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_RREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_RVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARUSER -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARREGION -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARQOS -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARPROT -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARCACHE -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARLOCK -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARBURST -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARSIZE -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARLEN -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARID -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARADDR -into $rdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_ARVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_WUSER -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_WID -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_WLAST -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_WSTRB -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_WDATA -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_WREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_WVALID -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWUSER -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWREGION -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWQOS -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWPROT -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWCACHE -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWLOCK -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWBURST -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWSIZE -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWLEN -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWID -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWADDR -into $wdata_group -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWREADY -into $ctrl_group -color #ffff00 -radix hex
add_wave /apatb_patbit_top/AESL_inst_patbit/m_axi_gmem_AWVALID -into $ctrl_group -color #ffff00 -radix hex
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_patbit_top/AESL_inst_patbit/ap_rst_n -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_patbit_top/AESL_inst_patbit/ap_clk -into $clockgroup
save_wave_config patbit.wcfg
run all
quit

