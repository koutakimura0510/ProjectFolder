set project_directory       [file dirname [info script]]
set project_name            "i2cSlave.xpr"
#
# Open Project
#
open_project [file join $project_directory $project_name]
set_property -name {xsim.simulate.runtime} -value {all} -objects [get_filesets sim_1]
launch_simulation
source i2cTop.tcl