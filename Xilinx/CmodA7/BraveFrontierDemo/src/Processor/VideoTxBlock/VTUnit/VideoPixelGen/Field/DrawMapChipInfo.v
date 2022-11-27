//----------------------------------------------------------
// Create 2022/11/23
// Author koutakimura
// -
// マップチップ描画データの管理を行う
//----------------------------------------------------------
module DrawMapChipInfo #(
    parameter                   		pMapChipX  		= 16,
    parameter                   		pMapChipY  		= 16,
	parameter							pInfoWidth		= 16
	// not variable
	parameter							pMapChipSize	= pMapChipX * pMapChipY,
	parameter							pBramDepth 		= pMapChipSize * (fbitWidth(pMapChipSize) - 1),
	parameter							pAdrsWidth 		= fbitWidth(pBramDepth)
)(
	// Internal Port
	input	[pInfoWidth-1:0]			iInfoWd,				// Info Write Data
	input	[pAdrsWidth-1:0]			iInfoWAdrs,				// Info Write Adrs	
	input 	[pBramNumber-1:0]			iInfoWCke,				// Info Write Enable
	//
	input	[pAdrsWidth-1:0]			iInfoRAdrs,				// Info Read Adrs
	output 	[pInfoWidth-1:0]			oInfoRd,				// Info Read Data
	//
	input 	[63:0]						iMapChipId,				// BYTE 区切りで ID 取得
	input 	[7:0]						iMapId,					// 現在の座標の MAP ID
	// Clk rst
    input								iRst,
    input								iClk
);


//-----------------------------------------------------------------------------
// BRAM に Filad 描画データを書き込み、読み込み
//-----------------------------------------------------------------------------
(* ram_style = "block" *) reg [pInfoWidth-1:0] rMapChipRam [0:2047];

always @(posedge iClk)
begin
	if (iInfoWCke)	rInfoFifo[iInfoWAdrs] <= iInfoWd;

	rInfo <= rInfoFifo[iInfoRAdrs];
end

always @*
begin
	qId[0] <= iMapId == iMapChipId[8+: 0];
	qId[1] <= iMapId == iMapChipId[8+: 8];
	qId[2] <= iMapId == iMapChipId[8+:16];
	qId[3] <= iMapId == iMapChipId[8+:24];
	qId[4] <= iMapId == iMapChipId[8+:32];
	qId[5] <= iMapId == iMapChipId[8+:40];
	qId[6] <= iMapId == iMapChipId[8+:48];
	qId[7] <= iMapId == iMapChipId[8+:56];
end


//----------------------------------------------------------
// msb側の1を検出しbit幅を取得する関数
//----------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction

endmodule