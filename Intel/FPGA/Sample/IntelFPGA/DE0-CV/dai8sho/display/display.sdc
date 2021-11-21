create_clock -name CLK -period 20.000 [get_ports {CLK}]

derive_pll_clocks
derive_clock_uncertainty

set PLL0_SYSCLK \
  {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}
set PLL1_SDCLK  \
  {u0|pll_0|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk}

create_generated_clock -name PCK \
  -source [get_pins $PLL0_SYSCLK] \
  -divide_by 4 [get_nets {u0|disp_ip_0|syncgen|cnt[1]}]

create_generated_clock -name SDCLK \
  -source [get_pins $PLL1_SDCLK] \
  [get_ports {DRAM_CLK}]

set_input_delay  -clock [get_clocks $PLL0_SYSCLK] 1 [all_inputs]
set_output_delay -clock [get_clocks $PLL0_SYSCLK] 1 \
  [remove_from_collection [all_outputs] {DRAM_CLK VGA*}]
set_output_delay -clock {PCK}   1 [get_ports {VGA*}]

set_clock_groups -asynchronous \
  -group [get_clocks $PLL0_SYSCLK] \
  -group [get_clocks {PCK}]
