
/tools/Xilinx/Vivado/2020.2/bin/xelab xil_defaultlib.apatb_muladd_top glbl -prj muladd.prj -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_12 -L axi_protocol_checker_v1_1_13 -L axis_protocol_checker_v1_1_11 -L axis_protocol_checker_v1_1_12 -L xil_defaultlib -L unisims_ver -L xpm  -L floating_point_v7_0_18 -L floating_point_v7_1_11 --lib "ieee_proposed=./ieee_proposed" -s muladd -debug wave
/tools/Xilinx/Vivado/2020.2/bin/xsim --noieeewarnings muladd -tclbatch muladd.tcl -view muladd_dataflow_ana.wcfg -protoinst muladd.protoinst

