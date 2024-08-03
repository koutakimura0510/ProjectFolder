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
module SpiSlavePort #(
	parameter 				pSfmNum 			= 3
)(
	// External Port for CPU Master
	input 					iSpiSck,
	input 					iSpiMosi,
	output 					oSpiMiso,
	input 					iSpiCs,
	input 					iSpiThru,
	// External Port for Flash Memory
	output [pSfmNum-1:0] 	oSfmSck,
	output [pSfmNum-1:0] 	oSfmMosi,
	input  [pSfmNum-1:0] 	iSfmMiso,
	output [pSfmNum-1:0] 	oSfmCs,
	// Internal Port for FPGA Slave Side
	input  [31:0]			iMUsiRd,
	output [31:0]			oDecDq,
	output [31:0]			oDecAdrs,
	output					oDecREd,
	//
	input  [pSfmNum-1:0]	iSfuSck,
	input  [pSfmNum-1:0]	iSfuMosi,
	output [pSfmNum-1:0]	oSfuMiso,
	input  [pSfmNum-1:0]	iSfuCs,
	// Control / Status
	input  [pSfmNum-1:0]	iDeviceSel,
	// CLK Reset
	input 					iSRST,
	input					iSCLK
);


/**-----------------------------------------------------------------------------
 * SpiThru Syncronasy
 *-----------------------------------------------------------------------------*/
reg rSpiThru;
 
always @(posedge iSCLK)
begin
	rSpiThru <= iSpiThru;
end

/**-----------------------------------------------------------------------------
 * Spi Signal Decoder Part (FPGA Slave Mode)
 *-----------------------------------------------------------------------------*/
reg		qDecSck,	qDecMosi,	qDecCs;
wire	wDecMiso;
reg 	qDecEnable;
 
SpiDecoder SpiDecoder(
	.iSpiSck(qDecSck),		.iSpiMosi(qDecMosi),
	.oSpiMiso(wDecMiso),	.iSpiCs(qDecCs),
	// Internal Port for FPGA Slave Side
	.iMUsiRd(iMUsiRd),
	.oDecDq(oDecDq),		.oDecAdrs(oDecAdrs),	.oDecREd(oDecREd),
	// Control / Status
	.iDecEnable(qDecEnable),
	// CLK Reset
	.iSRST(iSRST),			.iSCLK(iSCLK)
);

always @*
begin
	qDecSck		<= iSpiSck;
	qDecMosi	<= iSpiMosi;
	qDecCs		<= iSpiCs;
	qDecEnable	<= ~rSpiThru;
end


/**-----------------------------------------------------------------------------
 * SPI Bridge Part
 *-----------------------------------------------------------------------------*/
reg [pSfmNum-1:0] 	rSfmSck;
reg [pSfmNum-1:0] 	rSfmMosi;
reg [pSfmNum-1:0]	rSfmMiso;
reg [pSfmNum-1:0] 	rSfmCs;
reg [pSfmNum-1:0]	qDeviceSel;
//
genvar gen;

generate
	for (gen = 0; gen < pSfmNum; gen = gen + 1)
	begin
		// always @(posedge iSCLK)
		always @(posedge iSCLK)
		begin
			if (qDeviceSel[gen])
			begin
				rSfmSck[gen]	<= iSpiSck;
				rSfmMosi[gen]	<= iSpiMosi;
				rSfmMiso[gen]	<= iSfmMiso[gen];
				rSfmCs[gen]		<= iSpiCs;
			end
			else
			begin
				rSfmSck[gen]	<= iSfuSck[gen];
				rSfmMosi[gen]	<= iSfuMosi[gen];
				rSfmMiso[gen]	<= iSfmMiso[gen];
				rSfmCs[gen]		<= iSfuCs[gen];
			end
		end
		
		always @*
		begin
			qDeviceSel[gen] <= iDeviceSel[gen] & rSpiThru;
		end
	end
endgenerate

/**-----------------------------------------------------------------------------
 * SPI Signal Connect Part
 *-----------------------------------------------------------------------------*/
assign oSfmSck	= rSfmSck;
assign oSfmMosi	= rSfmMosi;
assign oSpiMiso	= rSpiThru ? rSfmMiso[iDeviceSel[2:1]] : wDecMiso;	// レジスタか Flash の Miso 結線
assign oSfuMiso = rSfmMiso;	// FPGA Master が通信する Flash は DeviceSel は 0 でなければならない
assign oSfmCs	= rSfmCs;

endmodule