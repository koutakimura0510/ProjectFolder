//----------------------------------------------------------
// Create  2022/4/5
// Author  koutakimura
// Editor  VSCode ver1.62.7
// Build   Vivado20.2
// Borad   Nexys Video
// -
// Latency --
// -
// CLK Generate Block
// クロックの生成を行うブロック
// 
//----------------------------------------------------------
module cgbWrapper (
    input           iCLK,           // system clk
    input           iRST,           // Active High
    output          oRST,           // Active High
    output          oTCLK,
    output          oPCLK,
    output          oBCLK
);


//----------------------------------------------------------
// Input Clk Buffer
//----------------------------------------------------------
wire wClkIbuf;

IBUF clkin1_ibufg (
    .O (wClkIbuf),
    .I (iCLK)
);

//----------------------------------------------------------
// VOC Settings
//----------------------------------------------------------
wire wLock;                     assign oRST = (~wLock)
wire wClkOutFb, wClkInFb;
wire wClkOut[0:5],
wire wunused [0:9];

MMCME2_ADV # (
    .BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (10.000),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (40.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKOUT1_DIVIDE       (4),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT1_USE_FINE_PS  ("FALSE"),
    .CLKOUT2_DIVIDE       (10),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT2_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (10.000)
) SYSTEM_CLK_GEN (
    .CLKFBOUT            (wClkOutFb),
    .CLKOUT0             (wClkOut[0]),
    .CLKOUT1             (wClkOut[1]),
    .CLKOUT2             (wClkOut[2]),
    .CLKOUT3             (wClkOut[3]),
    .CLKOUT4             (wClkOut[4]),
    .CLKOUT5             (wClkOut[5]),
    .CLKOUT6             (wClkOut[6]),

    .CLKFBOUTB           (wunused[4]),
    .CLKOUT0B            (wunused[5]),
    .CLKOUT1B            (wunused[6]),
    .CLKOUT2B            (wunused[7]),
    .CLKOUT3B            (wunused[8]),
     // Input clock control
    .CLKFBIN             (wClkInFb),
    .CLKIN1              (wClkIbuf),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (wunused[0]),
    .DRDY                (wunused[1]),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (wunused[2]),
    // Other control and status signals
    .LOCKED              (wLock),
    .CLKINSTOPPED        (wunused[3]),
    .CLKFBSTOPPED        (wunused[4]),
    .PWRDWN              (1'b0),
    .RST                 (iRST)
);

//----------------------------------------------------------
// PCLK 25  MHz Pixel
// TCLK 250 MHz TMDS
// BCLK 100 MHz Base
//----------------------------------------------------------
wire wTCLK;                     assign oTCLK;
wire wPCLK;                     assign oPCLK;
wire wBCLK;                     assign oBCLK;

BUFG clkf_buf (
    .O (wClkInFb),
    .I (wClkFb)
);

BUFG clkout1_buf (
    .O (wTCLK),
    .I (wClkOut[0])
);

BUFG clkout2_buf (
    .O (wPCLK),
    .I (wClkOut[1])
);

BUFG clkout3_buf (
    .O (wBCLK),
    .I (wClkOut[2])
);


endmodule