transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/DIGIT_24.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/ENABLE_GENERATE.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/CNT60.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/DECODER.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/CNT24.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/SERECTOR.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/TSET.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/SEQUENCER.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/SW_GEN.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/ALARMSET.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/AL_MOVE.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/BUZZER.v}

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24 {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/DIGIT_24/DIGIT_24_sim.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  DIGIT_24_sim

add wave *
view structure
view signals
run -all
