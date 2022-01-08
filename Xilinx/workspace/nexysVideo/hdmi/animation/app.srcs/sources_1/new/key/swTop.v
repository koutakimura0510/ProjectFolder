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
    input  [4:0]    iBtn,   // bit列 -> CDLRU
    input           iEnMs,  // チャタリング除去用enable信号
    input           iEn1Ms, // 1msEnable信号
    output [4:0]    oBtn    // bit列 -> CDLRU
);

wire oBtnC, oBtnD, oBtnL, oBtnR, oBtnU;
wire [4:0] bit_check;  assign bit_check = {oBtnC, oBtnD, oBtnL, oBtnR, oBtnU};
reg  [4:0] key_now;    assign oBtn = key_now;
reg  key_up;


//----------------------------------------------------------
// 各キーの立上りbit取得
//----------------------------------------------------------
swGen SW_U(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[0]), .oBtn(oBtnU));
swGen SW_R(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[1]), .oBtn(oBtnR));
swGen SW_L(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[2]), .oBtn(oBtnL));
swGen SW_D(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[3]), .oBtn(oBtnD));
swGen SW_C(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[4]), .oBtn(oBtnC));


//----------------------------------------------------------
// 立上りのあったスイッチ入力を保存
// 長押し処理のためDFFに前回のスイッチ入力値を保存しておく
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        key_up  <= 0;
        key_now <= 0;
    end else if (bit_check != 0) begin
        key_up  <= 1'b1;
    end else if (key_up == 1'b1) begin
        if (iBtn == 0) begin
            key_up <= 0;
        end else begin
            key_now <= iBtn;
        end
    end else begin
        key_now <= 0;
    end
end

endmodule