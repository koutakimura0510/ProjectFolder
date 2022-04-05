/*
 * Create 2022/3/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * Dot Generate Block
 * 描画用ドットデータの生成を行うブロック
 *
 * 2022-03-27: New Relese
 *
 */
module dgbWrapper #(
    parameter                   pHdisplay       = 640,
    parameter                   pVdisplay       = 480,
    parameter                   pPixelWidth     = 24,
    parameter                   pPixelDebug     = "yes"
)(
    input                       iBCLK,          // Bace clk
    input                       iRST,           // Active High Sync RST
    input                       iCKE,           // Base Clk Enable
    output [pPixelWidth-1:0]    oPixel,         // 生成ピクセルデータ
    output                      oVd,            // 有効データ出力時High
    output                      oFe
);

//----------------------------------------------------------
// Bit幅生成
//----------------------------------------------------------
localparam lpBitWidth  = fBitWidth(pHdisplay);
localparam lpBitHeight = fBitWidth(pVdisplay);


//----------------------------------------------------------
// ディスプレイ座標の生成
//----------------------------------------------------------
wire wFe;                           assign oFe  = wFe;
wire [lpBitWidth -1:0] wDwp;
wire [lpBitHeight-1:0] wDhp;

hvposGen #(
    .pHeight        (pVdisplay),    .pWidth         (pHdisplay),
    .pBitHeight     (lpBitHeight),  .pBitWidth      (lpBitWidth)
) HVPOS_GEN (
    .iCLK           (iBCLK),        .iRST           (iRST),
    .iCKE           (iCKE),
    .oDwp           (wDwp),         .oDhp           (wDhp),
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
    .pCntSize (2)
) COUNT_GET (
    .iCLK   (iBCLK),            .iRST   (iRST),
    .iCKE   (wFe),              .oCKE   (wFps)
);

generate
    if (pPixelDebug == "no")
    begin
        always @(posedge iBCLK)
        begin
            if (iRST)           rPixel <= 0;
            else if (rVd)       rPixel <= rPixel + 1'b1;
            else                rPixel <= rPixel;
        end
    end
    else
    begin
        always @(posedge iBCLK)
        begin
            if (iRST)       rSqu <= 'h4169e1;
            else if (wFps)  rSqu <= ~rSqu;
            else            rSqu <= rSqu;
        end

        always @(posedge iBCLK)
        begin
            if (iRST)           rPixel <= 0;
            else if (qSquare)   rPixel <= rSqu;
            else                rPixel <= 0;
        end
    end
endgenerate

always @(posedge iBCLK)
begin
    if (iRST)           rVd <= 1'b0;
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
//     .iCLK(iSCLK), .iRST(iRST),
//     .iVDE(iVDE),   .iUXS(oUXS), .iUYS(oUYS), .iFXS(oFXS), .iFYS(oFYS),
//     .iHPOS(iHPOS), .iVPOS(iVPOS),
//     .oFieldDot(oFieldDot), .oMapWidth(oMapWidth), .oMapDirect(oMapDirect)
// );


//----------------------------------------------------------
// プレイヤーのドットデータ生成
//----------------------------------------------------------
dotPlayerTop #(
    .VMAX(480),
    .CHIP_WIDTH(32)
) DOT_PLAYER_TOP (
    .iCLK(iSCLK), .iRST(iRST),
    .iUXS(oUXS), .iUXE(oUXE), .iUYS(oUYS), .iUYE(oUYE),
    .iHPOS(iHPOS), .iVPOS(iVPOS),
    .iDirX(oDirX), .iDirY(oDirY),
    .oPlayerDot(oPlayerDot)
);

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