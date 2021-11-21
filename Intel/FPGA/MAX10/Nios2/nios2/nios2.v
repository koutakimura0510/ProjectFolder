module nios2(
    /*クロック、リセット(SW[9])*/
    input CLK, RESET,

    /*スライドスイッチ、タクトスイッチ、７セグメントLED*/
    input  [8:0]  SW,
    input  [3:0]  KEY,
    output [7:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,

    /*LED、PS/2端子*/
    output [9:0]  LEDR,
    output        PS2_CLK, PS2_DAT,

    /*VGA*/
    output [3:0]  VGA_R, VGA_G, VGA_B,
	 output 			VGA_HS, VGA_VS,

    /*SDRAM*/
    output        DRAM_CLK, DARM_CKE,
    output [12:0] DRAM_ADDR,
    output [1:0]  DRAM_BA,
    output        DRAM_CAS_N, DRAM_RAS_N,
    output        DRAM_CS_N,  DRAM_WE_N,
    output        DRAM_UDQM,  DRAM_LDQM,
    input  [15:0] DRAM_DQ,

    /*GPIO*/
    inout  [35:0] GPIO
);

/* 未使用端子の固定 負論理なのでHighで消灯*/
assign HEX1 = 8'hff, HEX2 = 8'hff, HEX3 = 8'hff, HEX4 = 8'hff, HEX5 = 8'hff;

/*Qsys階層の接続*/
nios2pio u0 (
    .clk_clk (CLK),
    .reset_reset_n (~RESET),
    .pio_0_external_connection_export (HEX0),
    .pio_1_external_connection_export (SW[3:0])
);

endmodule