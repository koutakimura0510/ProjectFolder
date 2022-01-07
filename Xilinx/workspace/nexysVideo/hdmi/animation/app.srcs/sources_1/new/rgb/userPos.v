/*
 * Create 2021/1/06
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * ユーザーの描画座標データ生成
 */
module userPos
(
    input           iCLK,       // system clk
    input           iRST,       // system rst
    input  [4:0]    iBtn,       // bit -> CDLRU
    output [9:0]    oUXS,       // user xpos start   
    output [9:0]    oUYS,       // user ypos start
    output [9:0]    oUXE,       // user xpos end
    output [9:0]    oUYE        // user ypos end
);

// ユーザー座標データ出力
reg [9:0] xpos;       assign oUXS = xpos;
reg [9:0] ypos;       assign oUYS = ypos; 
assign oUXE = xpos + 32;
assign oUYE = ypos + 48;

// ユーザーx座標の生成
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        xpos <= 0;
    end else if (iBtn[1] == 1'b1) begin
        if (xpos < 608) begin
            xpos <= xpos + 1'b1;
        end
    end else if (iBtn[2] == 1'b1) begin
        if (xpos != 0) begin
            xpos <= xpos - 1'b1;
        end
    end
end


// ユーザーy座標の生成
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        ypos <= 0;
    end else if (iBtn[3] == 1'b1) begin
        if (ypos < 432) begin
            ypos <= ypos + 1'b1;
        end
    end else if (iBtn[0] == 1'b1) begin
        if (ypos != 0) begin
            ypos <= ypos - 1'b1;
        end
    end
end

endmodule