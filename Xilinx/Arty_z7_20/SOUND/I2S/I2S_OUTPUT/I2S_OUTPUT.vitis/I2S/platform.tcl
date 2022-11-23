# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {I2S}\
-hw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -fsbl-target {psu_cortexa53_0} -out {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis}

platform write
platform generate -domains 
platform active {I2S}
domain active {zynq_fsbl}
bsp reload
domain active {standalone_domain}
bsp reload
bsp setlib -name xilffs -ver 4.4
bsp config use_lfn "1"
bsp config use_mkfs "true"
bsp write
bsp reload
catch {bsp regenerate}
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform active {I2S}
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {/home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/design_1_wrapper.xsa}
platform clean
platform generate
