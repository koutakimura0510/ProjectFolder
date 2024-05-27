//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// 指定タイミングの Video Sync 信号を生成する
// 
//----------------------------------------------------------
module VideoSyncGen #(
	// 240 x 320
	parameter	pVHA = 480,		// Video Horizontal Active
	parameter	pVHB = 8,		// Video Horizontal Back
	parameter	pVHF = 43,		// Video Horizontal Front
	parameter	pVHS = 30,		// Video Horizontal Sync
	parameter	pVVA = 272,		// Video Vertical Active
	parameter	pVVB = 12,		// Video Vertical Front
	parameter	pVVF = 4,		// Video Vertical Back
	parameter	pVVS = 10,		// Video Vertical Sync
	// 240 x 320
	// parameter	pVHA = 320,		// Video Horizontal Active
	// parameter	pVHB = 24,		// Video Horizontal Back
	// parameter	pVHF = 64,		// Video Horizontal Front
	// parameter	pVHS = 16,		// Video Horizontal Sync
	// parameter	pVVA = 240,		// Video Vertical Active
	// parameter	pVVB = 11,		// Video Vertical Front
	// parameter	pVVF = 20,		// Video Vertical Back
	// parameter	pVVS = 10,		// Video Vertical Sync
	//
    parameter	pVHAW = 11
)(
	// Video Signal
    output	oHS,				// video hsync
    output	oVS,				// video vsync
    output	oDE,				// video data enable
	// Frame Status
    output	oFE,				// frame end
	//
    input	iVRST,
	input	iVCLK
);

//-----------------------------------------------------------------------------
// localparam
//-----------------------------------------------------------------------------
localparam [pVHAW:0] lpVHA			= pVHA; 
localparam [pVHAW:0] lpVVA			= pVVA; 
localparam [pVHAW:0] lpHSyncStart	= pVHA + pVHF; 
localparam [pVHAW:0] lpHSyncEnd		= pVHA + pVHF + pVHS - 1'b1;
localparam [pVHAW:0] lpHSyncMax		= pVHA + pVHF + pVHS + pVHB - 1'b1;
localparam [pVHAW:0] lpVSyncStart	= pVVA + pVVF;
localparam [pVHAW:0] lpVSyncEnd		= pVVA + pVVF + pVVS - 1'b1;
localparam [pVHAW:0] lpVSyncMax		= pVVA + pVVF + pVVS + pVVB - 1'b1;


//----------------------------------------------------------
// 水平同期カウンター
//----------------------------------------------------------
reg rHS;             		assign oHS = rHS;
reg qHSync;
reg [pVHAW:0]		rHpos;
reg qHMaxCntCke, 	qHposRst;

always @(posedge iVCLK)
begin 
	if (qHposRst)		rHpos <= {(pVHAW+1){1'b0}};
	else				rHpos <= rHpos + 1'b1;

	if (iVRST)			rHS <= 1'b1;
	else if (qHSync)	rHS <= 1'b0;
	else				rHS <= 1'b1;
end

always @*
begin
	qHposRst 	<= |{iVRST,qHMaxCntCke};
    qHMaxCntCke <= (rHpos == lpHSyncMax);
    qHSync 		<= (lpHSyncStart <= rHpos && rHpos <= lpHSyncEnd);
end


//----------------------------------------------------------
// 垂直同期カウンター
//----------------------------------------------------------
reg rVS;		                assign oVS   = rVS;
reg qVS;
reg [pVHAW:0] rVpos;
reg qVMaxCntCke,	qVposRst;

always @(posedge iVCLK) 
begin
	if (qVposRst)			rVpos <= {(pVHAW+1){1'b0}};
	else if (qHMaxCntCke)	rVpos <= rVpos + 1'b1;
	else			 		rVpos <= rVpos;

	if (iVRST)		rVS <= 1'b1;
	else if (qVS)	rVS <= 1'b0;
	else			rVS <= 1'b1;
end

always @*
begin
    qVMaxCntCke <= (rVpos == lpVSyncMax);
    qVS			<= (lpVSyncStart <= rVpos && rVpos <= lpVSyncEnd);

	casex ({iVRST, qVMaxCntCke, qHMaxCntCke})
		3'b1xx:		qVposRst <= 1'b1;
		3'b011:		qVposRst <= 1'b1;
		default: 	qVposRst <= 1'b0;
	endcase
end


//-----------------------------------------------------------------------------
// DE,FrameEnd 信号生成
//-----------------------------------------------------------------------------
reg rDE, rFE;					assign {oDE,oFE} = {rDE,rFE};
reg qDE, qFE;

always @(posedge iVCLK) 
begin
    if (iVRST)		rDE <= 1'b0;
	else if (qDE)	rDE <= 1'b1;
    else			rDE <= 1'b0;

	if (iVRST)		rFE <= 1'b0;
	else if (qFE)	rFE <= 1'b1;
	else			rFE <= 1'b0;
	//
end

always @*
begin
	qDE	<= (rHpos  < lpVHA) && (rVpos  < lpVVA);
	qFE	<= (rHpos == lpVHA) && (rVpos == lpVVA);
end

endmodule