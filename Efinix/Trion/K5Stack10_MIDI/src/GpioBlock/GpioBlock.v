/*-----------------------------------------------------------------------------
 * GPIO の制御を司るブロック
 * 
 * 23-04-08 v1.00 : New Release
 * 23-09-29 v1.01 : I2C Slave 機能追加
 *-----------------------------------------------------------------------------*/
module GpioBlock #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8,
	parameter pGpioWidth = 16
)(
	// GPIO Output Ctrl
	output [pGpioWidth-1:0] 	oGpioR,
	output [pGpioWidth-1:0] 	oGpioDir,
	// GPIO Alt Mode Signal
	input  [pGpioWidth-1:0] 	iGpioAltMode,
	// GPIO Input
	input  [pGpioWidth-1:0] 	iGpioIn,
	//
	input 						iI2cSclSlave,
	input 						iI2cSdaSlave,
	output						oI2cOeSlave,
	// Bus Master Read
	output [pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] 	iSUsiWd,
	input  [pUsiBusWidth-1:0] 	iSUsiAdrs,
    // CLK Reset
    input  iSCLK,
    input  iSRST
);

//----------------------------------------------------------
// Csr Space
//----------------------------------------------------------
wire [pGpioWidth-1:0] wGpioOutCtrl;
wire [pGpioWidth-1:0] wGpioDir;				assign oGpioDir = wGpioDir;
wire [pGpioWidth-1:0] wGpioAltModeCsr;

GpioCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pGpioWidth(pGpioWidth)
) GpioCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// CSR
	.oGpioOutCtrl(wGpioOutCtrl),
	.oGpioDir(wGpioDir),	.oGpioAltMode(wGpioAltModeCsr),
	.iGpioIn(iGpioIn),
    // CLK RST
	.iSRST(iSRST),			.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// I2C Slave
//-----------------------------------------------------------------------------
localparam lpI2cSlaveAdrs = 7'h20;



//-----------------------------------------------------------------------------
// IO Part
//-----------------------------------------------------------------------------
genvar gpioX;
reg [pGpioWidth-1:0] rGpioR; 		assign oGpioR = rGpioR;

generate
	for (gpioX = 0; gpioX < pGpioWidth; gpioX = gpioX + 1)
	begin
		always @(posedge iSCLK)
		begin
			rGpioR[gpioX] <= wGpioAltModeCsr[gpioX] ? iGpioAltMode[gpioX] : wGpioOutCtrl[gpioX];
		end
	end
endgenerate

endmodule