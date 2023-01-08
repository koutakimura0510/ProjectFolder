vlib work
vlog bram_primitive.v
vlog -sv efx_single_port_ram.v
vlog -sv bram_wrapper_mwm.v
vlog -sv sp_ram_tb.sv
vlog efx_ram10.v
vsim -t ps +notimingchecks -voptargs="+acc" work.spram_tb
run -All
