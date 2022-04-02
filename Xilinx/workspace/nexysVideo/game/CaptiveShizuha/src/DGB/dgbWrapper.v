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
    parameter                   pPixelWidth     = 24
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
localparam lpBitHeight = fBitWidth(pVdisplay);
localparam lpBitWidth  = fBitWidth(pHdisplay);


//----------------------------------------------------------
// ディスプレイ座標の生成
//----------------------------------------------------------
wire wFe;                           assign oFe = wFe;
wire [lpBitHeight-1:0] wDhp;
wire [lpBitWidth -1:0] wDwp;

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
wire wFps60;                            assign oVd = 1'b1;

countGet #(
    .pCntSize (59)
) COUNT_GET (
    .iCLK   (iBCLK),        .iRST   (iRST),
    .iCKE   (wFe),          .oCKE   (wFps60)
);

reg [pPixelWidth-1:0] rPixel;           assign oPixel = rPixel;

always @(posedge iBCLK)
begin
    if (iRST)           rPixel <= 0;
    else if (wFps60)    rPixel <= rPixel == ~'h008000 ? ~('h4169e1) : ~('h008000);
    else                rPixel <= rPixel;
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
// dotPlayerTop #(
//     .VMAX(480),
//     .CHIP_WIDTH(32)
// ) DOT_PLAYER_TOP (
//     .iCLK(iSCLK), .iRST(iRST),
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