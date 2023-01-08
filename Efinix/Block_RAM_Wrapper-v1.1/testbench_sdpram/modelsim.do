vlib work
vlog bram_primitive.v
vlog -sv efx_simple_dual_port_ram.v
vlog -sv bram_wrapper_mwm.v
vlog -sv sdp_ram_tb.sv
vlog efx_ram10.v
vsim -t ps +notimingchecks -voptargs="+acc" work.sdpram_tb
run -All
