vlib work
vlog -sv tb_ready_11.sv
vlog -sv efx_true_dual_port_ram.v
vlog -sv efx_dpram10.v
vlog -sv dpram_wrapper_mwm.v
vlog dpram_primitive.v
vsim -t ps +notimingchecks -voptargs="+acc" work.tdpram_tb
run -All
