/*
 * Create 2022/3/27
 * Author koutakimura
 * -
 * Dot Generate Block
 * 描画用ドットデータの生成を行うブロック
 *
 */
module dgbWrapper #(
    parameter                   pHdisplay       = 640,
    parameter                   pVdisplay       = 480,
    parameter                   pPixelWidth     = 24,
    parameter                   pPixelDebug     = "yes"
)(
    input                       iBaseClk,       // Bace clk
    input                       iRst,           // Active High Sync RST
    input                       iCKE,           // Base Clk Enable
    output [pPixelWidth-1:0]    oPixel,         // 生成ピクセルデータ
    output                      oVd,            // 有効データ出力時High
    output                      oFe             // 1frame の終端時 High
);

//----------------------------------------------------------
// Bit幅生成
//----------------------------------------------------------
localparam lpBitWidth  = fBitWidth(pHdisplay);
localparam lpBitHeight = fBitWidth(pVdisplay);


//----------------------------------------------------------
// HDMI のディスプレイ信号とは別に、内部高速クロックのタイミングで
// ドットデータ生成用の内部座標データを生成
// 各ドットデータ生成モジュールが動作完了時に CKE を High にすることで、
// 座標データが更新される
//----------------------------------------------------------
wire wFe;                           assign oFe  = wFe;
wire [lpBitWidth -1:0] wDwp;
wire [lpBitHeight-1:0] wDhp;

hvposGen #(
    .pHeight        (pVdisplay),
    .pWidth         (pHdisplay),
    .pBitHeight     (lpBitHeight),
    .pBitWidth      (lpBitWidth)
) HVPOS_GEN (
    .iClk           (iBaseClk),
    .iRst           (iRst),
    .iCKE           (iCKE),
    .oDwp           (wDwp),
    .oDhp           (wDhp),
    .oFe            (wFe)
);


//----------------------------------------------------------
// 60フレームカウント時Enable出力
//----------------------------------------------------------
reg [pPixelWidth-1:0] rPixel;           assign oPixel = ~rPixel;
reg [pPixelWidth-1:0] rSqu;
reg  rVd;                               assign oVd    = rVd;
reg  qSquare;
wire wFps;

countGet #(
    .pCntSize   (2)
) COUNT_GET (
    .iClk       (iBaseClk),
    .iRst       (iRst),
    .iCKE       (wFe),
    .oCKE       (wFps)
);

generate
    if (pPixelDebug == "no")
    begin
        always @(posedge iBaseClk)
        begin
            if (iRst)           rPixel <= 0;
            else if (rVd)       rPixel <= rPixel + 1'b1;
            else                rPixel <= rPixel;
        end
    end
    else
    begin
        always @(posedge iBaseClk)
        begin
            if (iRst)       rSqu <= 'h4169e1;
            else if (wFps)  rSqu <= ~rSqu;
            else            rSqu <= rSqu;
        end

        always @(posedge iBaseClk)
        begin
            if (iRst)           rPixel <= 0;
            else if (qSquare)   rPixel <= rSqu;
            else                rPixel <= 0;
        end
    end
endgenerate

always @(posedge iBaseClk)
begin
    if (iRst)           rVd <= 1'b0;
    else                rVd <= iCKE;
end

always @*
begin
    qSquare <= (30 <= wDwp && wDwp <= 100) && (30 <= wDhp && wDhp <= 100);
end


//----------------------------------------------------------
// フィールドのドットデータ生成
//----------------------------------------------------------
// dotFieldTop DOT_FIELD_TOP (
//     .iClk(iSCLK), .iRst(iRst),
//     .iVDE(iVDE),   .iUXS(oUXS), .iUYS(oUYS), .iFXS(oFXS), .iFYS(oFYS),
//     .iHPOS(iHPOS), .iVPOS(iVPOS),
//     .oFieldDot(oFieldDot), .oMapWidth(oMapWidth), .oMapDirect(oMapDirect)
// );


//----------------------------------------------------------
// プレイヤーのドットデータ生成
//----------------------------------------------------------
// dotPlayerTop #(
//     .VMAX(480),
//     .CHIP_WIDTH(32)
// ) DOT_PLAYER_TOP (
//     .iClk(iSCLK), .iRst(iRst),
//     .iUXS(oUXS), .iUXE(oUXE), .iUYS(oUYS), .iUYE(oUYE),
//     .iHPOS(iHPOS), .iVPOS(iVPOS),
//     .iDirX(oDirX), .iDirY(oDirY),
//     .oPlayerDot(oPlayerDot)
// );

////////////////////////////////////////////////////////////
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule