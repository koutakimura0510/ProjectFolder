# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/nexysVideo/microblaze/mcs/app.vitis/led_flash_system/_ide/scripts/systemdebugger_led_flash_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/nexysVideo/microblaze/mcs/app.vitis/led_flash_system/_ide/scripts/systemdebugger_led_flash_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent Nexys Video 210276B06483B" && level==0 && jtag_device_ctx=="jsn-Nexys Video-210276B06483B-13636093-0"}
fpga -file /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/nexysVideo/microblaze/mcs/app.vitis/led_flash/_ide/bitstream/main.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/nexysVideo/microblaze/mcs/app.vitis/main/export/main/hw/main.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow /home/koutakimura/workspace/ProjectFolder/Xilinx/workspace/nexysVideo/microblaze/mcs/app.vitis/led_flash/Debug/led_flash.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
