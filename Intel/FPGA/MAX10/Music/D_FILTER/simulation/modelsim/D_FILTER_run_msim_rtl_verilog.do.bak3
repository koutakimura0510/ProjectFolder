transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/SPI.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/RC_FILTER.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/I2S_OUT.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/I2S.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/FF.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/D_FILTER.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/DECODER.v}

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Music/D_FILTER/TEST.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  TEST

add wave *
view structure
view signals
run -all
