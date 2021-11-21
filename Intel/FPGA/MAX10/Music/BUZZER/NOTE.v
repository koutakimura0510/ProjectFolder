module NOTE(
    CLK, RESET, ENABLE, ENABLE_PWM, GPIO
);

input CLK, RESET, ENABLE, ENABLE_PWM;
inout GPIO;
reg [2:0] cnt;
reg [7:0] note, pwm_cnt;

always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        cnt <= 3'h0;
    end
    else if (ENABLE == 1'b1) begin
        if (cnt == 3'h7) begin
            cnt <= 3'h0;
        end
		  else begin
            cnt <= cnt + 3'h1;
        end
    end
end

always @* begin
    case (cnt)
        3'h0: note <= 8'd127;
        3'h1: note <= 8'd89;
        3'h2: note <= 8'd84;
        3'h3: note <= 8'd79;
        3'h4: note <= 8'd75;
        3'h5: note <= 8'd71;
        3'h6: note <= 8'd67;
        3'h7: note <= 8'd63;
    endcase
end

always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        pwm_cnt <= 8'h0;
    end
    else if (ENABLE_PWM == 1'b1) begin
        if (pwm_cnt == 8'hff) begin
            pwm_cnt <= 8'h0;
        end
        else begin
            pwm_cnt <= pwm_cnt + 8'h1;
        end
    end
end

assign GPIO = (pwm_cnt < note) ? 1'b1 : 1'b0;

endmodule