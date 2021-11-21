/**------------------------------------------------------
 * 描画色の生成モジュール
 *-------------------------------------------------------*/
module DRAW_GEN (
    input CLK, RESET, ENABLE, DE,
    output reg [17:0] COLOR
);

reg [3:0] state;

always @(posedge CLK or negedge RESET) begin
    if (RESET == 1'b0) begin
        state <= 4'h0;
    end else if (ENABLE == 1'b1 && DE == 1'b0) begin
        if (state == 4'hf) begin
            state <= 4'h0;
        end else begin
            state <= state + 4'h1;
        end
    end
end

always @(state) begin
    case (state)
        4'h0:   COLOR <= 18'b100000_000000_000000;
        4'h1:   COLOR <= 18'b000000_100000_000000;
        4'h2:   COLOR <= 18'b000000_000000_100000;
        4'h3:   COLOR <= 18'b100000_100000_000000;
        4'h4:   COLOR <= 18'b000000_100000_100000;
        4'h5:   COLOR <= 18'b100000_000000_100000;
        4'h6:   COLOR <= 18'b100000_100000_100000;
        4'h7:   COLOR <= 18'b111000_000111_000100;
        4'h8:   COLOR <= 18'b000111_011000_111000;
        4'h9:   COLOR <= 18'b000000_000000_000000;
        4'ha:   COLOR <= 18'b000001_000000_000000;
        4'hb:   COLOR <= 18'b011110_110000_000011;
        4'hc:   COLOR <= 18'b000000_001111_001111;
        4'hd:   COLOR <= 18'b110000_000000_111111;
        4'he:   COLOR <= 18'b000000_111111_100000;
        4'hf:   COLOR <= 18'b111111_111111_111111;
        default:COLOR <= 18'b000010_000000_001110;
    endcase
end

endmodule