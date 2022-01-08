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

//----------------------------------------------------------
// 時間定数
//----------------------------------------------------------
localparam KEY_START_TIME = 14;
localparam KEY_END_TIME   = 1;
localparam KEY_COMP_TIME  = 3;


wire oBtnC, oBtnD, oBtnL, oBtnR, oBtnU;
wire [4:0] bit_check;  assign bit_check = {oBtnC, oBtnD, oBtnL, oBtnR, oBtnU};
reg  [4:0] key_now;    assign oBtn = key_now;
reg  key_up;
reg  [4:0] key_time;
reg  [4:0] key_comp;


//----------------------------------------------------------
// 各キーの立上りbit取得
//----------------------------------------------------------
swGen SW_U(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[0]), .oBtn(oBtnU));
swGen SW_R(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[1]), .oBtn(oBtnR));
swGen SW_L(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[2]), .oBtn(oBtnL));
swGen SW_D(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[3]), .oBtn(oBtnD));
swGen SW_C(.iCLK(iCLK), .iEnable(iEnMs), .iBtn(iBtn[4]), .oBtn(oBtnC));


//----------------------------------------------------------
// 長押し時の移動速度処理
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        key_time <= KEY_START_TIME;
    end else if (key_up == 1'b1) begin
        if (iEn1Ms == 1'b1) begin
            if (key_time == KEY_END_TIME) begin
                key_time <= key_comp;
            end else begin
                key_time <= key_time - 1'b1;
            end
        end
    end else begin
        key_time <= KEY_START_TIME;
    end
end


//----------------------------------------------------------
// 比較時間の設定
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        key_comp <= KEY_START_TIME;
    end else if (key_up == 1'b1) begin
        if (key_time == KEY_END_TIME && key_comp != KEY_COMP_TIME && iEn1Ms == 1'b1) begin
            key_comp <= key_comp - 1'b1;
        end
    end else begin
        key_comp <= KEY_START_TIME;
    end
end


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
    end else if (key_up == 1'b1 && key_time == KEY_END_TIME && iEn1Ms) begin
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