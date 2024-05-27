/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章             */
/* project: CLOCK24           */
/* outline: 時のカウンタ      */

module HOURCNT(
    input   CLK, RST,
    input   EN, INC,
    output  reg [1:0]   QH,
    output  reg [3:0]   QL
);

reg [4:0] cnt24;

/* 24進カウンタ */
always @( posedge CLK ) begin
    if( RST )
        cnt24 <= 5'd0;
    else if( EN | INC ) begin
        if( cnt24==5'd23 )
            cnt24 <= 5'd0;
        else
            cnt24 <= cnt24 + 1'b1;
    end
end

/* 24進カウンタの値を2桁の信号に変換 */
always @* begin
    case( cnt24 )
        5'd0   : begin QH = 2'd0; QL = 4'd0; end
        5'd1   : begin QH = 2'd0; QL = 4'd1; end
        5'd2   : begin QH = 2'd0; QL = 4'd2; end
        5'd3   : begin QH = 2'd0; QL = 4'd3; end
        5'd4   : begin QH = 2'd0; QL = 4'd4; end
        5'd5   : begin QH = 2'd0; QL = 4'd5; end
        5'd6   : begin QH = 2'd0; QL = 4'd6; end
        5'd7   : begin QH = 2'd0; QL = 4'd7; end
        5'd8   : begin QH = 2'd0; QL = 4'd8; end
        5'd9   : begin QH = 2'd0; QL = 4'd9; end
        5'd10  : begin QH = 2'd1; QL = 4'd0; end
        5'd11  : begin QH = 2'd1; QL = 4'd1; end
        5'd12  : begin QH = 2'd1; QL = 4'd2; end
        5'd13  : begin QH = 2'd1; QL = 4'd3; end
        5'd14  : begin QH = 2'd1; QL = 4'd4; end
        5'd15  : begin QH = 2'd1; QL = 4'd5; end
        5'd16  : begin QH = 2'd1; QL = 4'd6; end
        5'd17  : begin QH = 2'd1; QL = 4'd7; end
        5'd18  : begin QH = 2'd1; QL = 4'd8; end
        5'd19  : begin QH = 2'd1; QL = 4'd9; end
        5'd20  : begin QH = 2'd2; QL = 4'd0; end
        5'd21  : begin QH = 2'd2; QL = 4'd1; end
        5'd22  : begin QH = 2'd2; QL = 4'd2; end
        5'd23  : begin QH = 2'd2; QL = 4'd3; end
        default: begin QH = 2'bx; QL = 4'bx; end
    endcase
end

endmodule
