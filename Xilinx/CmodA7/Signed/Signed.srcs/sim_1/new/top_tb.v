
//-----------------------------------------------------------------------------
// Create  2022/9/28
// Author  koutakimura
// -
// Veriog で module を Instance した場合の signed の取り扱いを確認するテストベンチ
// 結果として下記になる
// module の input,output 宣言部分には signed は必要。もしくはモジュール内で 1bit幅の大きい wireなどにキャストする
// module と接続する wire 宣言には signed は必要。記述を消して実行すると、En が立ち上がらなくなる
// unsigned と signed で計算すると 整数にキャストされるので注意が必要
// 
// https://master-long.hatenadiary.org/entry/20100404/1270377523
//-----------------------------------------------------------------------------
`timescale 1ns / 1ps
module top_tb;


//-----------------------------------------------------------------------------
// clk / rst gen
//-----------------------------------------------------------------------------
localparam lpCycle = 2;
reg rClk = 0;
reg rRst = 0;

always
begin
	#(lpCycle/2);
	rClk = ~rClk;
end


//-----------------------------------------------------------------------------
// 負の値生成
//-----------------------------------------------------------------------------
localparam lpBitWidth = 4;

wire signed [lpBitWidth:0] wDec;

Signed #(
	.pBitWidth	(lpBitWidth)
) sign (
	.oDec	(wDec),
	.iRst	(rRst),
	.iClk 	(rClk)
);


//-----------------------------------------------------------------------------
// wire が 負の値を獲得できているか判定するための En信号
//-----------------------------------------------------------------------------
reg rJuge;

always @(posedge rClk)
begin
	if (wDec == -1)	rJuge <= 1'b1;
	else			rJuge <= 1'b0;
end


//-----------------------------------------------------------------------------
// simlation start
//-----------------------------------------------------------------------------
initial begin
	rRst = 1;
	#(lpCycle*4);
	rRst = 0;
	#(lpCycle*4);
	$stop;
end


/* 参考ソースコード
module signed_mul (
    // INPUT
    input   signed  [7:0]   DATA_A, // signed             (8bit)
    input           [3:0]   COEF,       // signedではない!  (4bit)
    // OUTPUT
    output  signed  [7+3+1:0] ANS_0,    // 8bit+4bit=12bit
    output  signed  [7+3+1:0] ANS_1,
    output  signed  [7+3+1:0] ANS_2,
    output  signed  [7+3+1:0] ANS_3
);

    // wire 宣言
    // COEFを符号拡張するためのwire
    wire    signed  [4:0]   COEF_SGN;


    // 普通に乗算(間違い)
    //   COEFがunsignedなので signed * unsignedとなり、
    //   DATA_Aがunsignedにキャストされてしまう
    assign  ANS_0 = DATA_A * COEF;


    // COEFをキャストして乗算(間違い)
    //   COEFはunsignedのつもりなのに4'b1010のように
    //   最上位ビットが1のとき、負の値にされてしまう
    assign  ANS_1 = DATA_A * $signed(COEF);


    // COEFを符号拡張して乗算(正しい)
    //   COEFはunsignedなので頭に０を付ければsignedにキャストできる
    assign  ANS_2 = DATA_A * $signed({1'b0,COEF});


    // COEFを符号拡張してsignedのwireに入れてから乗算(正しい)
    assign  COEF_SGN[4:0] = {1'b0,COEF[3:0]};
    assign  ANS_3 = DATA_A * COEF_SGN;
*/
endmodule