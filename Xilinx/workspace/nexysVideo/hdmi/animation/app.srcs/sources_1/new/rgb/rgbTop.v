/*
 * Create 2021/1/6
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * 
 * RGB生成Topモジュール
 */
module rgbTop (
    input           iCLK,   // ディスプレイ描画clk
    input           iRST,   // system rst
    input  [ 4:0]   iBtn,
    input  [ 9:0]   iHPOS,
    input  [ 9:0]   iVPOS,
    input           iVDE,   // video enable
    output [23:0]   oVRGB
);


// ユーザー座標データ
wire [ 9:0] oUXS;
wire [ 9:0] oUYS;
wire [ 9:0] oUXE;
wire [ 9:0] oUYE;

// 色データ
wire [31:0] oBackARGB;      // BackGround ARGB 背景
wire [31:0] oForeARGB;      // ForeGround ARGB 前景
wire [31:0] oUserARGB;      // UserGround ARGB ユーザー
wire [31:0] oDotData;

//----------------------------------------------------------
// ユーザー座標データ生成
//----------------------------------------------------------
userPos USER_POS (
    .iCLK       (iCLK),
    .iRST       (iRST),
    .iBtn       (iBtn),
    .oUXS       (oUXS),
    .oUYS       (oUYS),
    .oUXE       (oUXE),
    .oUYE       (oUYE)
);

reg [15:0] iAddr;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        iAddr <= 0;
    end else if (480 < iVPOS) begin
        iAddr <= 0;
    end else if (oUXS <= iHPOS && iHPOS < oUXE && oUYS <= iVPOS && iVPOS < oUYE) begin
        iAddr <= iAddr + 1'b1;
    end
end

dotRom DOT_ROM (
    .iCLK       (iCLK),
    .iAddr      (iAddr),
    .oDotData   (oDotData)
);


//----------------------------------------------------------
// 描画データ生成
//----------------------------------------------------------
rgbGen BACK_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(32'hff000000), .oARGB(oBackARGB));
rgbGen FORE_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(448),  .iYE(480),  .iARGB(32'hff006400), .oARGB(oForeARGB));
rgbGen USER_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(oUXS), .iXE(oUXE), .iYS(oUYS), .iYE(oUYE), .iARGB(oDotData), .oARGB(oUserARGB));

rgbBridge RGB_BRIDGE (
    .iBackARGB      (oBackARGB),
    .iForeARGB      (oForeARGB),
    .iUserARGB      (oUserARGB),
    .oVRGB          (oVRGB)
);

endmodule