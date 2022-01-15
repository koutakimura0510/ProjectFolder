/*
 * Create 2021/1/6
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * キー入力トップモジュール
 */
module swTop (
    input           iCLK, 
    input           iRST,
    input  [5:0]    iBtn,   // bit列 -> LRBADU
    input           iEnMs,  // チャタリング除去用enable信号
    output [5:0]    oBtn    // bit列 -> ABDLRU
);

`include "../include/parameter.vh"

wire oBtnA, oBtnB, oBtnD, oBtnL, oBtnR, oBtnU;
assign oBtn = {oBtnA, oBtnR, oBtnL, oBtnU, oBtnD, oBtnB};

//----------------------------------------------------------
// 各キーの立上りbit取得
//----------------------------------------------------------
swGen SW_GEN_B(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[SW_B]),     .oBtn(oBtnB));
swGen SW_GEN_D(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[SW_DOWN]),  .oBtn(oBtnD));
swGen SW_GEN_U(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[SW_UP]),    .oBtn(oBtnU));
swGen SW_GEN_L(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[SW_LEFT]),  .oBtn(oBtnL));
swGen SW_GEN_R(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[SW_RIGHT]), .oBtn(oBtnR));
swGen SW_GEN_A(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[SW_A]),     .oBtn(oBtnA));

endmodule