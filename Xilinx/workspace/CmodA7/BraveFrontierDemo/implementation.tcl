#
# implementation.tcl  Tcl script for implementation
#
set     project_directory   [file dirname [info script]]
set     project_name        "app"
#
# Open Project
#
open_project [file join $project_directory $project_name]
#
# Run Synthesis
#
launch_runs synth_1_copy_1
wait_on_run synth_1_copy_1
#
# Run Implementation
#
#launch_runs impl_2
#wait_on_run impl_2
#open_run    impl_2
report_utilization -file [file join $project_directory "app.rpt" ]
report_timing      -file [file join $project_directory "app.rpt" ] -append
#
# Write Bitstream File
#
#launch_runs impl_2 -to_step write_bitstream -job 4
#wait_on_run impl_2
#
# Close Project
#
close_project