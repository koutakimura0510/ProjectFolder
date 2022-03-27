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
 */
module dgbWrapper #(
    parameter       pHdisplay       = 640,
    parameter       pVdisplay       = 480
)(
    input           iBCLK,          // Bace clk
    input           iRST,           // Active High
    output          oVde,           // video enable signal
    output          oFe             // frame end
);

//----------------------------------------------------------
// フィールドのドットデータ生成
//----------------------------------------------------------
dotFieldTop DOT_FIELD_TOP (
    .iCLK(iSCLK), .iRST(iRST),
    .iVDE(iVDE),   .iUXS(oUXS), .iUYS(oUYS), .iFXS(oFXS), .iFYS(oFYS),
    .iHPOS(iHPOS), .iVPOS(iVPOS),
    .oFieldDot(oFieldDot), .oMapWidth(oMapWidth), .oMapDirect(oMapDirect)
);


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

endmodule