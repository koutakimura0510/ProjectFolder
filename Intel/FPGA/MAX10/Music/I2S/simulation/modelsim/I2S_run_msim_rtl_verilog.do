transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/I2S {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/I2S/FF.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/I2S {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/I2S/I2S.v}

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/I2S {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/I2S/SIM.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  SIM

add wave *
view structure
view signals
run -all
