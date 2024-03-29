# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S_app_system/_ide/scripts/debugger_i2s_app-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S_app_system/_ide/scripts/debugger_i2s_app-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Arty Z7 003017A5C80CA" && level==0 && jtag_device_ctx=="jsn-Arty Z7-003017A5C80CA-23727093-0"}
fpga -file /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S_app/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S/export/I2S/hw/design_1_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S_app/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/Arty_z7_20/SOUND/I2S/I2S_OUTPUT/I2S_OUTPUT.vitis/I2S_app/Debug/I2S_app.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
