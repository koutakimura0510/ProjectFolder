/*-----------------------------------------------------------------------------
 * Blank を含めないアクティブ領域の座標位置を生成する
 *
 * 22-08-29 v1.00 : new release
 * 23-08-23 v1.01 : 命名規則と設計方針の変更により更新
 *-----------------------------------------------------------------------------*/
module PixelDrawPosition #(
    parameter	pVHAW	= 11,
    parameter	pVVAW	= 11,
	parameter	pMapChipBasicBs	= 4
)(
	input	[pVHAW-1:0]	iVha,
	input	[pVVAW-1:0]	iVva,
    output 	[pVHAW-1:0]	oHpos,
    output 	[pVVAW-1:0]	oVpos,
	output	[pVHAW-1:pMapChipBasicBs]	oHposBs,
	output	[pVVAW-1:pMapChipBasicBs]	oVposBs,
    output	oFeFast,
    // CLK Reset
    input	iRST,
    input	iCKE,
    input	iCLK
);


//----------------------------------------------------------
// 水平同期カウンター
//----------------------------------------------------------
reg [pVHAW-1:0] rHpos;				assign oHpos   = rHpos;
									assign oHposBs = rHpos[pVHAW-1:pMapChipBasicBs];
reg qHposRst;
reg qHposMax;

always @(posedge iCLK)
begin 
    if (qHposRst)	rHpos <= {pVHAW{1'b0}};
    else if (iCKE)	rHpos <= rHpos + 1'b1;
    else			rHpos <= rHpos;
end

always @*
begin
    qHposMax <= (rHpos == iVha);

	casex ({iRST,iCKE,qHposMax})
		'b1xx: 		qHposRst <= 1'b1;
		'bx11: 		qHposRst <= 1'b1;
		default: 	qHposRst <= 1'b0;
	endcase
end


//----------------------------------------------------------
// 垂直同期カウンター
//----------------------------------------------------------
reg [pVVAW-1:0] rVpos;				assign oVpos   = rVpos;
									assign oVposBs = rVpos[pVVAW-1:pMapChipBasicBs];
reg qVposCke, qVposRst;

always @(posedge iCLK) 
begin
    if (qVposRst)  		rVpos <= {pVVAW{1'b0}};
    else if (qVposCke)	rVpos <= rVpos + 1'b1;
    else				rVpos <= rVpos;
end

always @*
begin
	qVposCke <= &{iCKE,qHposMax};

	casex ({iRST,iCKE,(rVpos == iVva),qHposMax})
		'b1xxx:		qVposRst <= 1'b1;
		'bx111:		qVposRst <= 1'b1;
		default: 	qVposRst <= 1'b0;
	endcase
end


//----------------------------------------------------------
// Active Frame End
//----------------------------------------------------------
reg rFeFast;							assign oFeFast = rFeFast;
reg qFeFast;
//
wire [pVVAW-1:0]	wHFast = iVha - 2'd2;

always @(posedge iCLK) 
begin
    if (iRST) 		rFeFast <= 1'b0;
	else if (iCKE)	rFeFast <= qFeFast;
    else			rFeFast <= 1'b0;
end

always @*
begin
    qFeFast <= (rVpos == iVva) & (rHpos == wHFast);	// 2pixel 速く frameEnd
end
endmodule