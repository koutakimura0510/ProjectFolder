create_clock -name CLK  -period 20.000 [get_ports {CLK}]

derive_pll_clocks
derive_clock_uncertainty

set PLL0_SYSCLK {u0|altpll_0|sd1|pll7|clk[0]}
set PLL1_SDCLK  {u0|altpll_0|sd1|pll7|clk[1]}

create_generated_clock -name SDCLK \
  -source [get_pins $PLL1_SDCLK] \
  [get_ports {DRAM_CLK}]

set_input_delay  -clock [get_clocks $PLL0_SYSCLK] 1.5 [all_inputs]
set_output_delay -clock [get_clocks $PLL0_SYSCLK] 1 \
  [remove_from_collection [all_outputs] {DRAM_CLK}]
