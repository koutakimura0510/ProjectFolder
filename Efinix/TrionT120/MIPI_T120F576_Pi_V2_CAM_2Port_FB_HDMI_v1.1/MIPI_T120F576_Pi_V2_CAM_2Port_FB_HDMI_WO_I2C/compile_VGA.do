vlib work

vlog mipi_pi_cam_debayer_top_tb.v
vlog shift_reg.v
vlog fifo.v
vlog vga_buffer.v
vlog dual_clock_fifo.v
vlog simple_dual_port_ram.v
vlog rgb_gain.v
vlog raw_to_rgb.v
vlog line_buffer.v
vlog true_dual_port_ram.v

vsim -t ps work.mipi_pi_cam_debayer_top_tb

add wave -position insertpoint  \
sim:/mipi_pi_cam_debayer_top_tb/r_mipi_pclk \
sim:/mipi_pi_cam_debayer_top_tb/r_i_arstn \
sim:/mipi_pi_cam_debayer_top_tb/r_mipi_inst1_HSYNC \
sim:/mipi_pi_cam_debayer_top_tb/r_mipi_inst1_VALID \
sim:/mipi_pi_cam_debayer_top_tb/r_in_inst1_DATA \
sim:/mipi_pi_cam_debayer_top_tb/r_vs_ram_out_5P \
sim:/mipi_pi_cam_debayer_top_tb/r_hs_ram_out_5P \
sim:/mipi_pi_cam_debayer_top_tb/r_de_ram_4_2_5P \
sim:/mipi_pi_cam_debayer_top_tb/r_slow_data_5P \
sim:/mipi_pi_cam_debayer_top_tb/w_mipi_tx_vsync_00 \
sim:/mipi_pi_cam_debayer_top_tb/w_mipi_tx_hsync_00 \
sim:/mipi_pi_cam_debayer_top_tb/w_mipi_tx_de_00 \
sim:/mipi_pi_cam_debayer_top_tb/w_mipi_tx_11 \
sim:/mipi_pi_cam_debayer_top_tb/w_mipi_tx_00 \
sim:/mipi_pi_cam_debayer_top_tb/w_mipi_tx_01