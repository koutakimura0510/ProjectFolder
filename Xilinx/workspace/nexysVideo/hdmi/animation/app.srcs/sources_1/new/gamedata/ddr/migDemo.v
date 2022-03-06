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
    input  [127:0]  iData,
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

reg [  7:0] rWA, rRA;
reg [127:0] rID [0:255];
reg [127:0] rOD;                        assign oData = rOD;
reg rWrdy, rRrdy, rRdv;                 assign {oWRDY, oRRDY, oRDV} = {rWrdy, rRrdy, rRdv};
reg rCH;

always @(posedge iCLK)
begin
    if (iRST)
    begin
        {rWrdy, rRrdy, rRdv}    <= {1'b1, 1'b1, 1'b0};
        rOD                     <= 128'd0;
        {rWA, rRA}              <= {8'd0, 8'd0};
        rCH                     <= 0;
    end
    else
    begin
        casex ({rCH, iAppEN, iWE})
            'b000:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b1, 1'b1, 1'b0};
            end

            'b010:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b1, 1'b0, 1'b1};
                rOD                  <= rID[rRA];
                rRA                  <= rRA + 1'b1;
                rCH                  <= 1'b1;
            end

            'b011:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b0, 1'b0, 1'b0};
                rID[rWA]             <= iData;
                rWA                  <= rWA + 1'b1;
                rCH                  <= 1'b1;
            end

            default:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b1, 1'b1, 1'b0};
                rCH                  <= 1'b0;
            end
        endcase
    end
end

endmodule