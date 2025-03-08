/*------------------------------------------------------------------------------
 * Create 2022/8/5
 * Author koutakimura
 * -
 * SPI 通信の Master / Slave の信号生成 モジュール
 * CPOL/CPHA 0 固定
 * -
 * 2022-08-27 : ILA を入れて RaspberryPi の SPI 信号をデバッグした
 * 				Write のみだったら 10MHz 動作可能だが、Read の場合は 4MHz 程度の動作となった
 * 				取り合えず動作はして Unit ととして独立はしているので、
 * 				速度改善が必要になったら修正することにする。
 * 
 * V1.1 USIB 更新版に対応
 * V1.2 Slave mode の動作切り替えを rSpiDir から rnSpiDir に変更
 * V1.3 Master SPI 信号を Bridge で接続できるように大幅更新
 *-----------------------------------------------------------------------------*/
module SpiDecoder (
	// External Port for CPU Master
	input 					iSpiSck,
	input 					iSpiMosi,
	output 					oSpiMiso,
	input 					iSpiCs,
	// Internal Port for FPGA Slave Side
	input  [31:0]			iMUsiRd,
	output [31:0]			oDecDq,
	output [31:0]			oDecAdrs,
	output					oDecREd,
	// Control / Status
	input  					iDecEnable,
	// CLK Reset
	input 					iSRST,
	input					iSCLK
);


/**-----------------------------------------------------------------------------
 * FPGA Slave Part
 * SPI 信号をデコードし、レジスタ空間へアクセス
 * Adrs -> Data の順番で 4byte 受信する
 *-----------------------------------------------------------------------------*/
reg [31:0]	rSpiMisoSft;
reg [2:0] 	rSpiSckSft, 	rSpiCsSft,		rSpiMosiSft;
reg [31:0]	rDecDq,			rDecAdrs;
reg			rRwCmd;
reg [4:0]	rSSckCntNeg;
reg [7:0]	rGetDataSel;
reg 		qGetDataSelCke;
reg 		qPedgeSck, 		qNedgeSck;
reg 		qSSckCntNegCke;

always @(posedge iSCLK)
begin
	// Sampling part
	if (iDecEnable)				rSpiMosiSft	<= {rSpiMosiSft[1:0], iSpiMosi};
	else 						rSpiMosiSft	<= 3'b000;

	if (iDecEnable)				rSpiSckSft		<= {rSpiSckSft[1:0], iSpiSck};
	else						rSpiSckSft		<= 3'b000;

	if (iDecEnable)				rSpiCsSft		<= {rSpiCsSft[1:0],iSpiCs};
	else 						rSpiCsSft		<= 3'b111;

	// Decode Part
	if (rSpiCsSft[2])		 		rGetDataSel[0] <= 1'd0;
	else if (qGetDataSelCke) 	rGetDataSel[0] <= 1'b1;
	else 					 	rGetDataSel[0] <= rGetDataSel[0];
	
	if (rSpiCsSft[2])		 		rGetDataSel[7:1] <= 7'd0;
	else 					 	rGetDataSel[7:1] <= {rGetDataSel[6:1],rGetDataSel[0]};

	if (rSpiCsSft[2])				rSSckCntNeg <= 5'd0;
	else if (qNedgeSck)			rSSckCntNeg <= rSSckCntNeg + 1'b1;
	else 						rSSckCntNeg <= rSSckCntNeg;

	if (qPedgeSck) 				rDecDq <= {rDecDq[30:0], rSpiMosiSft[1]};
	else 		 				rDecDq <= rDecDq;

	casex ({rSpiCsSft[2], qSSckCntNegCke, qNedgeSck, rGetDataSel[0]})
		'b0110:	 rDecAdrs	<= rDecDq;
		'b1xxx:	 rDecAdrs	<= 32'd0;
		default: rDecAdrs	<= rDecAdrs;
	endcase
	
	case ({rDecAdrs[30], qSSckCntNegCke, qNedgeSck, rGetDataSel[0]})
		'b1111:	 rRwCmd	<= 1'b1;	// write cmd enable
		default: rRwCmd	<= 1'b0;
	endcase

	case ({qNedgeSck, rGetDataSel[7]})
		'b01:	 rSpiMisoSft	<= rSpiMisoSft;
		'b11:	 rSpiMisoSft	<= {rSpiMisoSft[30:0], 1'b1};
		default: rSpiMisoSft	<= iMUsiRd;
	endcase
end

always @*
begin
	case ({rSpiCsSft[2], rSpiSckSft[2:0]})
		4'b0011: qPedgeSck	<= 1'b1;
		default: qPedgeSck	<= 1'b0;
	endcase

	case ({rSpiCsSft[2], rSpiSckSft[2:0]})
		4'b0100: qNedgeSck	<= 1'b1;
		default: qNedgeSck	<= 1'b0;
	endcase

	qSSckCntNegCke <=  (rSSckCntNeg == 5'd31);
	qGetDataSelCke <= &{qSSckCntNegCke,qNedgeSck};
end

/**-----------------------------------------------------------------------------
 * Dst. Part
 *-----------------------------------------------------------------------------*/
assign oSpiMiso = rSpiMisoSft[31];
assign oDecDq  	= rDecDq;
assign oDecAdrs	= {rDecAdrs[31],rRwCmd,rDecAdrs[29:0]};
assign oDecREd 	= 1'b0;

endmodule