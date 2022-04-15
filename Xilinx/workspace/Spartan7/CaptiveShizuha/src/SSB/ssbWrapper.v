/*
 * Create 2021/1/6
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * Switch Serialize Block
 * 非同期のスイッチ入力を指定パラメータのタイミングで同期させ出力する
 */
module ssbWrapper #(
    parameter       pMonitorTiming = 500000
)(
    input           iClk, 
    input           iRst,
    input  [5:0]    iBtn,   // bit列 -> LRBADU
    output [5:0]    oBtn    // bit列 -> ABDLRU
);

`include "../include/key.vh"

//----------------------------------------------------------
// チャタリング用enable信号
//----------------------------------------------------------
wire   oEn5ms;

enGen #(
    .pSysClk    (pMonitorTiming)
) RGB_1MS_GEN (
    .iClk(iClk), .iRst(iRst), .oEnable(oEn5ms)
);


//----------------------------------------------------------
// 各キーの立上りbit取得
//----------------------------------------------------------
wire   oBtnA, oBtnB, oBtnD, oBtnL, oBtnR, oBtnU;    assign oBtn = {oBtnA, oBtnR, oBtnL, oBtnU, oBtnD, oBtnB};

swGen SW_GEN_B(.iClk(iClk), .iEnable(oEn5ms), .iBtn(iBtn[SW_B]),     .oBtn(oBtnB));
swGen SW_GEN_D(.iClk(iClk), .iEnable(oEn5ms), .iBtn(iBtn[SW_DOWN]),  .oBtn(oBtnD));
swGen SW_GEN_U(.iClk(iClk), .iEnable(oEn5ms), .iBtn(iBtn[SW_UP]),    .oBtn(oBtnU));
swGen SW_GEN_L(.iClk(iClk), .iEnable(oEn5ms), .iBtn(iBtn[SW_LEFT]),  .oBtn(oBtnL));
swGen SW_GEN_R(.iClk(iClk), .iEnable(oEn5ms), .iBtn(iBtn[SW_RIGHT]), .oBtn(oBtnR));
swGen SW_GEN_A(.iClk(iClk), .iEnable(oEn5ms), .iBtn(iBtn[SW_A]),     .oBtn(oBtnA));

endmodule