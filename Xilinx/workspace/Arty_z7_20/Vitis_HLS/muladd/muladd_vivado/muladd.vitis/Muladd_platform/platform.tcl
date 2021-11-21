# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd_vivado/muladd.vitis/Muladd_platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd_vivado/muladd.vitis/Muladd_platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {Muladd_platform}\
-hw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd_vivado/muladd.vitis/design_1_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/Vitis_HLS/muladd/muladd_vivado/muladd.vitis}

platform write
platform generate -domains 
platform active {Muladd_platform}
platform generate
