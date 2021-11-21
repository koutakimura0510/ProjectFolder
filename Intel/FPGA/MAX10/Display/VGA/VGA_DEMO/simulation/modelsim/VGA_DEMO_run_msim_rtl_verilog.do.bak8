transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Include/LEDR {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Include/LEDR/LED_DEMO.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Include/ENABLE {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Include/ENABLE/EN_GEN.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/VGA/VGA_DEMO {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/VGA/VGA_DEMO/VGA_DEMO.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/VGA/VGA_DEMO {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/VGA/VGA_DEMO/HVSYNC_GEN.v}

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/VGA/VGA_DEMO {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/VGA/VGA_DEMO/TEST.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  TEST

add wave *
view structure
view signals
run -all
