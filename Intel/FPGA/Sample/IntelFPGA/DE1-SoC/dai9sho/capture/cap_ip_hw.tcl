# TCL File Generated by Component Editor 17.0
# Mon Sep 04 15:09:56 GMT+09:00 2017
# DO NOT MODIFY


# 
# cap_ip "cap_ip" v1.0
#  2017.09.04.15:09:56
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module cap_ip
# 
set_module_property DESCRIPTION ""
set_module_property NAME cap_ip
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME cap_ip
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL cap_ip
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file cap_ip.v VERILOG PATH CAP_HDL/cap_ip.v TOP_LEVEL_FILE
add_fileset_file cap_ctrl.v VERILOG PATH CAP_HDL/cap_ctrl.v
add_fileset_file cap_flag.v VERILOG PATH CAP_HDL/cap_flag.v
add_fileset_file cap_in.v VERILOG PATH CAP_HDL/cap_in.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point avalon_master_0
# 
add_interface avalon_master_0 avalon start
set_interface_property avalon_master_0 addressUnits SYMBOLS
set_interface_property avalon_master_0 associatedClock clock
set_interface_property avalon_master_0 associatedReset reset
set_interface_property avalon_master_0 bitsPerSymbol 8
set_interface_property avalon_master_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_master_0 burstcountUnits WORDS
set_interface_property avalon_master_0 doStreamReads false
set_interface_property avalon_master_0 doStreamWrites false
set_interface_property avalon_master_0 holdTime 0
set_interface_property avalon_master_0 linewrapBursts false
set_interface_property avalon_master_0 maximumPendingReadTransactions 0
set_interface_property avalon_master_0 maximumPendingWriteTransactions 0
set_interface_property avalon_master_0 readLatency 0
set_interface_property avalon_master_0 readWaitTime 1
set_interface_property avalon_master_0 setupTime 0
set_interface_property avalon_master_0 timingUnits Cycles
set_interface_property avalon_master_0 writeWaitTime 0
set_interface_property avalon_master_0 ENABLED true
set_interface_property avalon_master_0 EXPORT_OF ""
set_interface_property avalon_master_0 PORT_NAME_MAP ""
set_interface_property avalon_master_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_master_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_master_0 avm_waitrequest waitrequest Input 1
add_interface_port avalon_master_0 avm_address address Output 26
add_interface_port avalon_master_0 avm_write write Output 1
add_interface_port avalon_master_0 avm_writedata writedata Output 16
add_interface_port avalon_master_0 avm_burstcount burstcount Output 5


# 
# connection point conduit_end_0
# 
add_interface conduit_end_0 conduit end
set_interface_property conduit_end_0 associatedClock clock
set_interface_property conduit_end_0 associatedReset reset
set_interface_property conduit_end_0 ENABLED true
set_interface_property conduit_end_0 EXPORT_OF ""
set_interface_property conduit_end_0 PORT_NAME_MAP ""
set_interface_property conduit_end_0 CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end_0 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_0 coe_PCLK pclk Input 1
add_interface_port conduit_end_0 coe_VSYNC vsync Input 1
add_interface_port conduit_end_0 coe_HREF href Input 1
add_interface_port conduit_end_0 coe_CAMDATA camdata Input 8
add_interface_port conduit_end_0 coe_XCLK xclk Output 1
add_interface_port conduit_end_0 coe_CAPADDR capaddr Input 26
add_interface_port conduit_end_0 coe_CAPON capon Input 1
add_interface_port conduit_end_0 coe_CLRCBLNK clrcblnk Input 1
add_interface_port conduit_end_0 coe_CBLANK cblank Output 1

