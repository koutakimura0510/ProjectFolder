transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/CLK_GEN {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/CLK_GEN/CLK_GEN.v}

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/CLK_GEN {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/CLK_GEN/TEST_CLK_GEN.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  TEST_CLK_GEN

add wave *
view structure
view signals
run -all
