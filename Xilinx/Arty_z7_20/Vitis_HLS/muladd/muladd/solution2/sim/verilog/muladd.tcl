
log_wave [get_objects -filter {type == in_port || type == out_port || type == inout_port || type == port} /apatb_muladd_top/AESL_inst_muladd/*]
set designtopgroup [add_wave_group "Design Top Signals"]
set coutputgroup [add_wave_group "C Outputs" -into $designtopgroup]
set return_group [add_wave_group return(wire) -into $coutputgroup]
add_wave /apatb_muladd_top/AESL_inst_muladd/ap_return -into $return_group -radix hex
set cinputgroup [add_wave_group "C Inputs" -into $designtopgroup]
set b_group [add_wave_group b(memory) -into $cinputgroup]
add_wave /apatb_muladd_top/AESL_inst_muladd/b_q0 -into $b_group -radix hex
add_wave /apatb_muladd_top/AESL_inst_muladd/b_ce0 -into $b_group -color #ffff00 -radix hex
add_wave /apatb_muladd_top/AESL_inst_muladd/b_address0 -into $b_group -radix hex
set a_group [add_wave_group a(memory) -into $cinputgroup]
add_wave /apatb_muladd_top/AESL_inst_muladd/a_q0 -into $a_group -radix hex
add_wave /apatb_muladd_top/AESL_inst_muladd/a_ce0 -into $a_group -color #ffff00 -radix hex
add_wave /apatb_muladd_top/AESL_inst_muladd/a_address0 -into $a_group -radix hex
set blocksiggroup [add_wave_group "Block-level IO Handshake" -into $designtopgroup]
add_wave /apatb_muladd_top/AESL_inst_muladd/ap_start -into $blocksiggroup
add_wave /apatb_muladd_top/AESL_inst_muladd/ap_done -into $blocksiggroup
add_wave /apatb_muladd_top/AESL_inst_muladd/ap_idle -into $blocksiggroup
add_wave /apatb_muladd_top/AESL_inst_muladd/ap_ready -into $blocksiggroup
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_muladd_top/AESL_inst_muladd/ap_rst -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_muladd_top/AESL_inst_muladd/ap_clk -into $clockgroup
save_wave_config muladd.wcfg
run all
quit

