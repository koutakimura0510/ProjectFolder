//----------------------------------------------------------
// Enable信号生成モジュール
//----------------------------------------------------------
module enGen #(
    parameter pSysClk = 25000000  // 分周クロックの値を指定
)(
    input   iCLK, 
    input   iRST,
    output  oEnable
);

localparam lpCtuCNTBits	= fBitWidth(pSysClk);

reg [lpCtuCNTBits-1:0] tmp_count;
assign oEnable = (tmp_count == (pSysClk-1)) ? 1'b1 : 1'b0;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmp_count <= 0;
    end else if (oEnable == 1'b1) begin
        tmp_count <= 0;
    end else begin
        tmp_count <= tmp_count + 1'b1;
    end
end

// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule
