/*
 * Create 2021/2/20
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリ制御 ハンドシェイク信号デモ動作
 */
module migDemo (
    output [127:0]  oData,
    output          oCal,
    input           iAppEN,
    input           iWE,        // write enable
    output          oWRDY,      // write ready
    output          oRDV,       // read data valid
    output          oRRDY,      // read ready
    input           iCLK,
    input           iRST,
    output          oUiCLK,
    output          oUiRST
);


////////////////////////////////////////////////////////////
assign oUiCLK = iCLK;
assign oUiRST = iRST;
assign oCal   = ~iRST;

////////////////////////////////////////////////////////////
reg rWRDY;                  assign oWRDY = rWRDY;

always @(posedge iCLK)
begin
    if (iRST)               rWRDY <= 1'b0;
    else if (iAppEN && iWE) rWRDY <= 1'b0;
    else                    rWRDY <= 1'b1;
end

////////////////////////////////////////////////////////////
reg rRDV, rRRDY;                assign {oRDV, oRRDY} = {rRDV, rRRDY};

always @(posedge iCLK)
begin
    if (iRST)                   {rRDV, rRRDY} <= {2'b01};
    else if (iAppEN && !iWE)    {rRDV, rRRDY} <= {2'b10};
    else                        {rRDV, rRRDY} <= {2'b01};
end

////////////////////////////////////////////////////////////
assign oData = (rRDV) ? 128'hffffffff_ffffffff_ffffffff_ffffffff : 0;

endmodule