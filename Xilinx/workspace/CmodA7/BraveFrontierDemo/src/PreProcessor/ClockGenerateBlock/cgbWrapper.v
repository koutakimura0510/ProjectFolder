//----------------------------------------------------------
// Create  2022/4/5
// Author  koutakimura
// -
// Latency --
// -
// CLK Generate Block
// クロックの生成を行うブロック
// --
// MMCM
// 7 シリーズ デバイス ファミリで使用可能な MMCM (Mixed Mode Clock Manager) には、次の機能があります。
// 
// パワーダウン モード
// 周波数合成
// 入力クロック切り替え
// 分数除算
// ダイナミック位相シフト
// --
// PLL
// 7 シリーズ デバイス ファミリの PLL には、MMCM と同じ機能が多く備わっていますが、次のような違いがあります。
// 
// VCO 周波数範囲の最小値および最大値が高い
// 分数除算がない
// ダイナミック位相シフトがない
// O0 から O5 までの 6 つの出力クロック (MMCM の場合は O0 から O6)
// 出力クロックの 4 つに対して補数出力なし
//----------------------------------------------------------
module cgbWrapper #(
    parameter       pSystemPll      = "on",
    parameter       pAudioPll       = "on"
)(
	// External Port
    input           iClk,           // system clk
    input           iAudioClk,
	// Internal Port
    output          oRst,           // Active High
    output          oAudioRst,
    output          oMemClk,
    output          oVideoClk,
    output          oSysClk,
    output          oAudioClk
);


//----------------------------------------------------------
// CLK Settings
//----------------------------------------------------------
localparam      lpBandWidth      = "OPTIMIZED"; // Rst Active High
localparam      lpStartWait      = "FALSE";     // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
localparam real lpClkIn1Period   = 83.333;      // 12 [MHz]
localparam      lpClkIn1Div      = 1;           // 12 [MHz] / 1 = 12 [MHz]

// VOC 分周回路設定
// Spped Grade 1 = (600 ~ 1200MHz)
localparam real lpClkOutMult     = 60.000;      // OSC MHz * Mult = VOC[MHz]
localparam real lpClk0OutDivF    = 8.000;       // VOC MHz / DivF =  Clk0[MHz]
localparam      lpClk1OutDiv     = 18;          // VOC MHz / Div  =  Clk1[MHz]
localparam      lpClk2OutDiv     = 80;          // VOC MHz / Div  =  Clk2[MHz]
localparam      lpClk3OutDiv     = 29;          // VOC MHz / Div  =  Clk3[MHz]
localparam      lpClk4OutDiv     = 10;          // <Reserved>
localparam      lpClk5OutDiv     = 10;          // <Reserved>

generate
    if (pSystemPll == "on")
    begin
        wire wLock;
        wire wClkOutFb, wClkInFb, wClkIbuf;
        wire [6:0] wClkOut;
        wire [8:0] wunused;

        MMCME2_BASE # (
            // 入力クロック (Div 1 ~ 56)
            .CLKIN1_PERIOD        (lpClkIn1Period),
            .DIVCLK_DIVIDE        (lpClkIn1Div),

            // コントロール設定
            .BANDWIDTH            (lpBandWidth),
            .CLKOUT4_CASCADE      ("FALSE"),
            .STARTUP_WAIT         (lpStartWait),

            // Ref In Jitter (0.000 ~ 0.999)
            .REF_JITTER1          (0.0), 

            // 小数逓倍 (2.000 ~ 64.000)
            .CLKFBOUT_MULT_F      (lpClkOutMult),

            // 小数分周 (1.000 ~ 128.000)
            .CLKOUT0_DIVIDE_F     (lpClk0OutDivF),

            // 整数分周 (1 ~ 128)
            .CLKOUT1_DIVIDE       (lpClk1OutDiv),
            .CLKOUT2_DIVIDE       (lpClk2OutDiv),
            .CLKOUT3_DIVIDE       (lpClk3OutDiv),
            .CLKOUT4_DIVIDE       (lpClk4OutDiv),
            .CLKOUT5_DIVIDE       (lpClk5OutDiv),

            // 位相調整 (-360.000 ~ 360.000)
            .CLKFBOUT_PHASE       (0.000),
            .CLKOUT0_PHASE        (0.000),
            .CLKOUT1_PHASE        (0.000),
            .CLKOUT2_PHASE        (0.000),
            .CLKOUT3_PHASE        (0.000),
            .CLKOUT4_PHASE        (0.000),
            .CLKOUT5_PHASE        (0.000),

            // Duty比 (0.001 ~ 0.999)
            .CLKOUT0_DUTY_CYCLE   (0.500),
            .CLKOUT1_DUTY_CYCLE   (0.500),
            .CLKOUT2_DUTY_CYCLE   (0.500),
            .CLKOUT3_DUTY_CYCLE   (0.500),
            .CLKOUT4_DUTY_CYCLE   (0.500),
            .CLKOUT5_DUTY_CYCLE   (0.500)
        ) MMCME2_BASE_CLK_GEN (
            .CLKOUT0              (wClkOut[0]),      // 1-bit output
            .CLKOUT1              (wClkOut[1]),      // 1-bit output
            .CLKOUT2              (wClkOut[2]),      // 1-bit output
            .CLKOUT3              (wClkOut[3]),      // 1-bit output
            .CLKOUT4              (wClkOut[4]),      // 1-bit output
            .CLKOUT5              (wClkOut[5]),      // 1-bit output
            .CLKOUT6              (wClkOut[6]),      // 1-bit output
            .CLKFBOUT             (wClkOutFb),       // 1-bit output FeedBack

            // Bと付く部分は反転出力 DDRに使用
            .CLKFBOUTB            (wunused[0]),
            .CLKOUT0B             (wunused[1]),
            .CLKOUT1B             (wunused[2]),
            .CLKOUT2B             (wunused[3]),
            .CLKOUT3B             (wunused[4]),
            .CLKFBIN              (wClkInFb),        // 1-bit input  BUFG Clk
            .CLKIN1               (wClkIbuf),        // 1-bit input  IBUF Clk
            .LOCKED               (wLock),           // 1-bit output IBUF Clk
            .PWRDWN               (1'b0),            // 1-bit input  Power Down
            .RST                  (1'b0)
        );

        //----------------------------------------------------------
        // iClk は IBUF 経由後、FeedBack経由してBUFG通すような図がデータシートに記載してあったのでそうしている
        //----------------------------------------------------------
        IBUF # (
            .IBUF_LOW_PWR   ("FALSE"),
            .IOSTANDARD     ("DEFAULT")
        ) IBUF_iClk (    
            .O              (wClkIbuf),
            .I              (iClk)
        );

        BUFG BUFG_iClk (
            .O              (wClkInFb),
            .I              (wClkOutFb)
        );

        //---------------------------------------------------------------------------
        // Buffer経由して使用
        //---------------------------------------------------------------------------
        wire wMemClk;                      assign oMemClk   = wMemClk;
        wire wVideoClk;                    assign oVideoClk = wVideoClk;
        wire wSysClk;                      assign oSysClk   = wSysClk;
        wire wAudioClk;                    assign oAudioClk = wAudioClk;

        BUFG BUFG_CLKO_0 (
            .O (wVideoClk),
            .I (wClkOut[2])
        );

        BUFG BUFG_CLKO_1 (
            .O (wMemClk),
            .I (wClkOut[1])
        );

        BUFG BUFG_CLKO_2 (
            .O (wSysClk),
            .I (wClkOut[0])
        );

        BUFG BUFG_CLKO_3 (
            .O (wAudioClk),
            .I (wClkOut[3])
        );
		//
        wire 	wSysRst;                   assign oRst 		= wSysRst;
        wire 	wAudioRst;                 assign oAudioRst = wAudioRst;
		reg 	rRst;
		reg 	rAudioRst;

		always @(posedge wSysClk)
		begin
			if (wLock) 	rRst <= 1'b0;
			else 		rRst <= 1'b1;
		end

		always @(posedge wAudioClk)
		begin
			if (wLock) 	rAudioRst <= 1'b0;
			else 		rAudioRst <= 1'b1;
		end
		//
        BUFG BufgSysRst (
            .O (wSysRst),
            .I (rRst)
        );

        BUFG BufgAudioRst (
            .O (wAudioRst),
            .I (rAudioRst)
        );
    end
endgenerate



//----------------------------------------------------------
// Audio CLK
//----------------------------------------------------------

// generate
//     if (pAudioPll == "on")
//     begin
//         wire wAudioLock;                     assign oAudioRst = ~wAudioLock;
//         wire        wAudioClkIbuf;
//         wire        wAudioClkInFb;
//         wire        wAudioClkOutFb;
//         wire [5:0]  wAudioClkOut;
//         wire [15:0] wDrpOutData;
//         wire        wDrpReady;

//         PLLE2_ADV #(
//             .BANDWIDTH          ("OPTIMIZED"),  // OPTIMIZED, HIGH, LOW
//             .CLKFBOUT_MULT      (50),           // Multiply value for all CLKOUT, (2-64)
//             .CLKFBOUT_PHASE     (0.0),          // Phase offset in degrees of CLKFB, (-360.000-360.000).
//             // CLKIN_PERIOD: Input clock period in nS to ps resolution (i.e. 33.333 is 30 MHz).
//             .CLKIN1_PERIOD      (40.69),
//             .CLKIN2_PERIOD      (0.0),
//             // CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for CLKOUT (1-128)
//             .CLKOUT0_DIVIDE     (50),
//             .CLKOUT1_DIVIDE     (1),
//             .CLKOUT2_DIVIDE     (1),
//             .CLKOUT3_DIVIDE     (1),
//             .CLKOUT4_DIVIDE     (1),
//             .CLKOUT5_DIVIDE     (1),
//             // CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.001-0.999).
//             .CLKOUT0_DUTY_CYCLE (0.5),
//             .CLKOUT1_DUTY_CYCLE (0.5),
//             .CLKOUT2_DUTY_CYCLE (0.5),
//             .CLKOUT3_DUTY_CYCLE (0.5),
//             .CLKOUT4_DUTY_CYCLE (0.5),
//             .CLKOUT5_DUTY_CYCLE (0.5),
//             // CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
//             .CLKOUT0_PHASE      (0.0),
//             .CLKOUT1_PHASE      (0.0),
//             .CLKOUT2_PHASE      (0.0),
//             .CLKOUT3_PHASE      (0.0),
//             .CLKOUT4_PHASE      (0.0),
//             .CLKOUT5_PHASE      (0.0),
//             .COMPENSATION       ("ZHOLD"),      // ZHOLD, BUF_IN, EXTERNAL, INTERNAL
//             .DIVCLK_DIVIDE      (1),            // Master division value (1-56)
//             // REF_JITTER: Reference input jitter in UI (0.000-0.999).
//             .REF_JITTER1        (0.0),
//             .REF_JITTER2        (0.0),
//             .STARTUP_WAIT       ("FALSE")       // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
//         ) PLLE2_ADV_CLK_GEN (
//             // Clock Outputs: 1-bit (each) output: User configurable clock outputs
//             .CLKOUT0            (wAudioClkOut[0]),  // 1-bit output: CLKOUT0
//             .CLKOUT1            (wAudioClkOut[1]),  // 1-bit output: CLKOUT1
//             .CLKOUT2            (wAudioClkOut[2]),  // 1-bit output: CLKOUT2
//             .CLKOUT3            (wAudioClkOut[3]),  // 1-bit output: CLKOUT3
//             .CLKOUT4            (wAudioClkOut[4]),  // 1-bit output: CLKOUT4
//             .CLKOUT5            (wAudioClkOut[5]),  // 1-bit output: CLKOUT5
//             .CLKFBOUT           (wAudioClkOutFb),   // 1-bit output: Feedback clock
//             // DRP Ports: 16-bit (each) output: Dynamic reconfiguration ports
//             .DO                 (wDrpOutData),      // 16-bit output: DRP data
//             .DRDY               (qDrpReady),        // 1-bit output: DRP ready
//             // Feedback Clocks: 1-bit (each) output: Clock feedback ports
//             .LOCKED             (wAudioLock),       // 1-bit output: LOCK
//             // Clock Inputs: 1-bit (each) input: Clock inputs
//             .CLKIN1             (wAudioClkIbuf),    // 1-bit input: Primary clock
//             .CLKIN2             (1'b0),             // 1-bit input: Secondary clock
//             // Control Ports: 1-bit (each) input: PLL control ports
//             .CLKINSEL           (1'b1),             // 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
//             .PWRDWN             (1'b0),             // 1-bit input: Power-down
//             .RST                (1'b0),             // 1-bit input: Reset
//             // DRP Ports: 7-bit (each) input: Dynamic reconfiguration ports
//             .DADDR              (7'd0),             // 7-bit input: DRP address
//             .DCLK               (1'b0),             // 1-bit input: DRP clock
//             .DEN                (1'b0),             // 1-bit input: DRP enable
//             .DI                 (16'd0),            // 16-bit input: DRP data
//             .DWE                (1'b0),             // 1-bit input: DRP write enable
//             // Feedback Clocks: 1-bit (each) input: Clock feedback ports
//             .CLKFBIN            (wAudioClkInFb)     // 1-bit input: Feedback clock
//         );


//         //----------------------------------------------------------
//         // Audio Ibuf
//         //----------------------------------------------------------
//         IBUF # (
//             .IBUF_LOW_PWR   ("FALSE"),
//             .IOSTANDARD     ("DEFAULT")
//         ) IBUF_AudioClk (    
//             .O              (wAudioClkIbuf),
//             .I              (iAudioClk)
//         );

//         BUFG BUFG_AudioClk (
//             .O              (wAudioClkInFb),
//             .I              (wAudioClkOutFb)
//         );

//         //----------------------------------------------------------
//         // Audio Output
//         //----------------------------------------------------------
//         wire wAudioClk;                      assign oAudioClk   = wAudioClk;

//         BUFG BUFG_AUDIO_CLKO_1 (
//             .O (wAudioClk),
//             .I (wAudioClkOut[0])
//         );
//     end
//     else
//     begin
// 		// CmodA7 では I2S ではなく PWM のため、SystemCLK 使用
//         wire wAudioLock;                     assign oAudioRst   = 1'b0;
//         wire wAudioBufg;                     assign oAudioClk   = 1'b0;

//         // wire wAudioLock;                     assign oAudioRst   = wAudioLock;
//         // wire wAudioBufg;                     assign oAudioClk   = wAudioBufg;
//         // wire wAudioClk;

//         // IBUF # (
//         //     .IBUF_LOW_PWR   ("FALSE"),
//         //     .IOSTANDARD     ("DEFAULT")
//         // ) IBUF_AudioClk (    
//         //     .O              (wAudioClk),
//         //     .I              (iAudioClk)
//         // );

//         // BUFG BUFG_AudioClk (
//         //     .O              (wAudioBufg),
//         //     .I              (wAudioClk)
//         // );

//         // rstGen #(
//         //     .pRstFallTime   (100),
// 		// 	.pBufgUsed		("yes")
//         // ) AUDIO_RST (
//         //     .iClk           (wAudioBufg),
//         //     .oRst           (wAudioLock)
//         // );
//     end
// endgenerate


endmodule