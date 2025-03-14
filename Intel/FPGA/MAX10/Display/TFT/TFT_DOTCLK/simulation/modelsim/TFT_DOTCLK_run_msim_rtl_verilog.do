transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Include/SPI {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Include/SPI/SPI2.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/RC_FILTER.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/I2S_OUT.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/I2S.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/FF.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/DRAW_GEN.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/TFT_DOTCLK.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/TFT_INIT.v}
vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/HVSYNC_GEN.v}

vlog -vlog01compat -work work +incdir+/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK {/home/koutakimura/workspace/ProjectFolder/Intel/FPGA/MAX10/Display/TFT/TFT_DOTCLK/TEST.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  TEST

add wave *
view structure
view signals
run -all
