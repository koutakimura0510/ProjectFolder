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

reg [  2:0] rWA, rRA;
reg [127:0] rID [0:7];
reg [127:0] rOD;                        assign oData = rOD;
reg rWrdy, rRrdy, rRdv;                 assign {oWRDY, oRRDY, oRDV} = {rWrdy, rRrdy, rRdv};

always @(posedge iCLK)
begin
    if (iRST)
    begin
        {rWrdy, rRrdy, rRdv}    <= {1'b1, 1'b1, 1'b0};
        rOD                     <= 128'd0;
        {rWA, rRA}              <= {8'd0, 8'd0};
    end
    else
    begin
        casex ({iAppEN, iWE})
            'b00:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b1, 1'b1, 1'b0};
            end

            'b10:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b1, 1'b0, 1'b1};
                rOD                  <= rID[rRA];
                rRA                  <= rRA + 1'b1;
            end

            'b11:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b0, 1'b1, 1'b0};
                rID[rWA]             <= iData;
                rWA                  <= rWA + 1'b1;
            end

            default:
            begin
                {rWrdy, rRrdy, rRdv} <= {1'b1, 1'b1, 1'b0};
            end
        endcase
    end
end

endmodule