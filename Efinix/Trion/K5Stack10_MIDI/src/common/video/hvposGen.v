/*
 * Create 2022/04/02
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * Hpos Vpos 生成モジュール
 */
module hvposGen 
#(
    parameter                   pHeight     = 480,  // display height
    parameter                   pWidth      = 640,  // display width
    parameter                   pBitHeight  = 10,
    parameter                   pBitWidth   = 10
)(
    input                       iCLK,               // clk
    input                       iRST,               // Active High system rst
    input                       iCKE,               // pos update enable
    output [pBitWidth-1:0]      oDwp,               // Display Width  Pos
    output [pBitHeight-1:0]     oDhp,               // Display Height Pos
    output                      oFe                 // frame end
);


//----------------------------------------------------------
// 画面サイズ
//----------------------------------------------------------
localparam [pBitHeight-1:0] lpHeight = pHeight - 1'b1;
localparam [pBitWidth-1:0]  lpWidth  = pWidth  - 1'b1;

//----------------------------------------------------------
// 水平同期カウンター
//----------------------------------------------------------
reg [pBitWidth-1:0] rDwp;           assign oDwp = rDwp;
reg qDwe;

always @(posedge iCLK) 
begin 
    if (iRST)       rDwp <= 0;
    else if (iCKE)  rDwp <= qDwe ? 0 : rDwp + 1'b1;
    else            rDwp <= rDwp;
end

always @*
begin
    qDwe <= (rDwp == lpWidth);
end

//----------------------------------------------------------
// 垂直同期カウンター
//----------------------------------------------------------
reg [pBitHeight-1:0] rDhp;           assign oDhp = rDhp;
reg qDhe [0:1];

always @(posedge iCLK) 
begin
    if (iRST)           rDhp <= 0;
    else if (qDhe[0])   rDhp <= (qDhe[1]) ? 0 : rDhp + 1;
    else                rDhp <= rDhp;
end


always @*
begin
    qDhe[0] <= iCKE & qDwe;
    qDhe[1] <= rDhp == lpHeight;
end

//----------------------------------------------------------
// Frame End
//----------------------------------------------------------
reg qFe, rFe;                   assign oFe = rFe;

always @(posedge iCLK) 
begin
    if (iRST) rFe <= 1'b0;
    else      rFe <= qFe;
end

always @*
begin
    qFe     <= qDhe[0] & qDhe[1];
end
endmodule