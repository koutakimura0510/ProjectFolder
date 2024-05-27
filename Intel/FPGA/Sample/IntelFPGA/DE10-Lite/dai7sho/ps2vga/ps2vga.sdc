create_clock -name CLK -period 20.000 [get_ports {CLK}]
derive_clock_uncertainty
set_input_delay  -clock {CLK} 1 [all_inputs]
set_output_delay -clock {CLK} 1 [all_outputs]

create_generated_clock -name PCK \
    -source {CLK} -divide_by 2 \
     [get_nets {u0|vgaif_ip_0|syncgen|PCK}]
