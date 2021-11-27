/*
 * Create 2021/11/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * Romの初期化の記述方法を試すためのプロジェクト
 *
 * initial文で初期値を設定したらきちんとBRAMが使用されていた。
 * (* ram_style = "BLOCK" *) 制約を書いたらBRAMが設定されていた
 * 書き込みと読み込み処理をしてもBRAMが設定されていた
 */
module romTop(
    input iCLK,
    input iRST,
    output [3:0] led
);


reg [15:0] rp;
reg [15:0] d;       assign led = d[3:0];

(* ram_style = "BLOCK" *) reg[15:0] sinRom[0:255];
// reg[15:0] sinRom[0:255];
initial begin
    sinRom[16'd0] = 16'd128;
    sinRom[16'd1] = 16'd131;
    sinRom[16'd2] = 16'd134;
    sinRom[16'd3] = 16'd137;
    sinRom[16'd4] = 16'd140;
    sinRom[16'd5] = 16'd143;
    sinRom[16'd6] = 16'd146;
    sinRom[16'd7] = 16'd149;
    sinRom[16'd8] = 16'd153;
    sinRom[16'd9] = 16'd156;
    sinRom[16'd10] = 16'd159;
    sinRom[16'd11] = 16'd162;
    sinRom[16'd12] = 16'd165;
    sinRom[16'd13] = 16'd168;
    sinRom[16'd14] = 16'd171;
    sinRom[16'd15] = 16'd174;
    sinRom[16'd16] = 16'd177;
    sinRom[16'd17] = 16'd180;
    sinRom[16'd18] = 16'd182;
    sinRom[16'd19] = 16'd185;
    sinRom[16'd20] = 16'd188;
    sinRom[16'd21] = 16'd191;
    sinRom[16'd22] = 16'd194;
    sinRom[16'd23] = 16'd196;
    sinRom[16'd24] = 16'd199;
    sinRom[16'd25] = 16'd201;
    sinRom[16'd26] = 16'd204;
    sinRom[16'd27] = 16'd207;
    sinRom[16'd28] = 16'd209;
    sinRom[16'd29] = 16'd211;
    sinRom[16'd30] = 16'd214;
    sinRom[16'd31] = 16'd216;
    sinRom[16'd32] = 16'd218;
    sinRom[16'd33] = 16'd220;
    sinRom[16'd34] = 16'd223;
    sinRom[16'd35] = 16'd225;
    sinRom[16'd36] = 16'd227;
    sinRom[16'd37] = 16'd229;
    sinRom[16'd38] = 16'd231;
    sinRom[16'd39] = 16'd232;
    sinRom[16'd40] = 16'd234;
    sinRom[16'd41] = 16'd236;
    sinRom[16'd42] = 16'd238;
    sinRom[16'd43] = 16'd239;
    sinRom[16'd44] = 16'd241;
    sinRom[16'd45] = 16'd242;
    sinRom[16'd46] = 16'd243;
    sinRom[16'd47] = 16'd245;
    sinRom[16'd48] = 16'd246;
    sinRom[16'd49] = 16'd247;
    sinRom[16'd50] = 16'd248;
    sinRom[16'd51] = 16'd249;
    sinRom[16'd52] = 16'd250;
    sinRom[16'd53] = 16'd251;
    sinRom[16'd54] = 16'd252;
    sinRom[16'd55] = 16'd253;
    sinRom[16'd56] = 16'd253;
    sinRom[16'd57] = 16'd254;
    sinRom[16'd58] = 16'd254;
    sinRom[16'd59] = 16'd255;
    sinRom[16'd60] = 16'd255;
    sinRom[16'd61] = 16'd255;
    sinRom[16'd62] = 16'd255;
    sinRom[16'd63] = 16'd255;
    sinRom[16'd64] = 16'd255;
    sinRom[16'd65] = 16'd255;
    sinRom[16'd66] = 16'd255;
    sinRom[16'd67] = 16'd255;
    sinRom[16'd68] = 16'd255;
    sinRom[16'd69] = 16'd254;
    sinRom[16'd70] = 16'd254;
    sinRom[16'd71] = 16'd253;
    sinRom[16'd72] = 16'd253;
    sinRom[16'd73] = 16'd252;
    sinRom[16'd74] = 16'd251;
    sinRom[16'd75] = 16'd251;
    sinRom[16'd76] = 16'd250;
    sinRom[16'd77] = 16'd249;
    sinRom[16'd78] = 16'd248;
    sinRom[16'd79] = 16'd247;
    sinRom[16'd80] = 16'd245;
    sinRom[16'd81] = 16'd244;
    sinRom[16'd82] = 16'd243;
    sinRom[16'd83] = 16'd241;
    sinRom[16'd84] = 16'd240;
    sinRom[16'd85] = 16'd238;
    sinRom[16'd86] = 16'd237;
    sinRom[16'd87] = 16'd235;
    sinRom[16'd88] = 16'd233;
    sinRom[16'd89] = 16'd232;
    sinRom[16'd90] = 16'd230;
    sinRom[16'd91] = 16'd228;
    sinRom[16'd92] = 16'd226;
    sinRom[16'd93] = 16'd224;
    sinRom[16'd94] = 16'd222;
    sinRom[16'd95] = 16'd219;
    sinRom[16'd96] = 16'd217;
    sinRom[16'd97] = 16'd215;
    sinRom[16'd98] = 16'd213;
    sinRom[16'd99] = 16'd210;
    sinRom[16'd100] = 16'd208;
    sinRom[16'd101] = 16'd205;
    sinRom[16'd102] = 16'd203;
    sinRom[16'd103] = 16'd200;
    sinRom[16'd104] = 16'd198;
    sinRom[16'd105] = 16'd195;
    sinRom[16'd106] = 16'd192;
    sinRom[16'd107] = 16'd189;
    sinRom[16'd108] = 16'd187;
    sinRom[16'd109] = 16'd184;
    sinRom[16'd110] = 16'd181;
    sinRom[16'd111] = 16'd178;
    sinRom[16'd112] = 16'd175;
    sinRom[16'd113] = 16'd172;
    sinRom[16'd114] = 16'd169;
    sinRom[16'd115] = 16'd166;
    sinRom[16'd116] = 16'd163;
    sinRom[16'd117] = 16'd160;
    sinRom[16'd118] = 16'd157;
    sinRom[16'd119] = 16'd154;
    sinRom[16'd120] = 16'd151;
    sinRom[16'd121] = 16'd148;
    sinRom[16'd122] = 16'd145;
    sinRom[16'd123] = 16'd142;
    sinRom[16'd124] = 16'd139;
    sinRom[16'd125] = 16'd135;
    sinRom[16'd126] = 16'd132;
    sinRom[16'd127] = 16'd129;
    sinRom[16'd128] = 16'd126;
    sinRom[16'd129] = 16'd123;
    sinRom[16'd130] = 16'd120;
    sinRom[16'd131] = 16'd116;
    sinRom[16'd132] = 16'd113;
    sinRom[16'd133] = 16'd110;
    sinRom[16'd134] = 16'd107;
    sinRom[16'd135] = 16'd104;
    sinRom[16'd136] = 16'd101;
    sinRom[16'd137] = 16'd98;
    sinRom[16'd138] = 16'd95;
    sinRom[16'd139] = 16'd92;
    sinRom[16'd140] = 16'd89;
    sinRom[16'd141] = 16'd86;
    sinRom[16'd142] = 16'd83;
    sinRom[16'd143] = 16'd80;
    sinRom[16'd144] = 16'd77;
    sinRom[16'd145] = 16'd74;
    sinRom[16'd146] = 16'd71;
    sinRom[16'd147] = 16'd68;
    sinRom[16'd148] = 16'd66;
    sinRom[16'd149] = 16'd63;
    sinRom[16'd150] = 16'd60;
    sinRom[16'd151] = 16'd57;
    sinRom[16'd152] = 16'd55;
    sinRom[16'd153] = 16'd52;
    sinRom[16'd154] = 16'd50;
    sinRom[16'd155] = 16'd47;
    sinRom[16'd156] = 16'd45;
    sinRom[16'd157] = 16'd42;
    sinRom[16'd158] = 16'd40;
    sinRom[16'd159] = 16'd38;
    sinRom[16'd160] = 16'd36;
    sinRom[16'd161] = 16'd33;
    sinRom[16'd162] = 16'd31;
    sinRom[16'd163] = 16'd29;
    sinRom[16'd164] = 16'd27;
    sinRom[16'd165] = 16'd25;
    sinRom[16'd166] = 16'd23;
    sinRom[16'd167] = 16'd22;
    sinRom[16'd168] = 16'd20;
    sinRom[16'd169] = 16'd18;
    sinRom[16'd170] = 16'd17;
    sinRom[16'd171] = 16'd15;
    sinRom[16'd172] = 16'd14;
    sinRom[16'd173] = 16'd12;
    sinRom[16'd174] = 16'd11;
    sinRom[16'd175] = 16'd10;
    sinRom[16'd176] = 16'd8;
    sinRom[16'd177] = 16'd7;
    sinRom[16'd178] = 16'd6;
    sinRom[16'd179] = 16'd5;
    sinRom[16'd180] = 16'd4;
    sinRom[16'd181] = 16'd4;
    sinRom[16'd182] = 16'd3;
    sinRom[16'd183] = 16'd2;
    sinRom[16'd184] = 16'd2;
    sinRom[16'd185] = 16'd1;
    sinRom[16'd186] = 16'd1;
    sinRom[16'd187] = 16'd0;
    sinRom[16'd188] = 16'd0;
    sinRom[16'd189] = 16'd0;
    sinRom[16'd190] = 16'd0;
    sinRom[16'd191] = 16'd0;
    sinRom[16'd192] = 16'd0;
    sinRom[16'd193] = 16'd0;
    sinRom[16'd194] = 16'd0;
    sinRom[16'd195] = 16'd0;
    sinRom[16'd196] = 16'd0;
    sinRom[16'd197] = 16'd1;
    sinRom[16'd198] = 16'd1;
    sinRom[16'd199] = 16'd2;
    sinRom[16'd200] = 16'd2;
    sinRom[16'd201] = 16'd3;
    sinRom[16'd202] = 16'd4;
    sinRom[16'd203] = 16'd5;
    sinRom[16'd204] = 16'd6;
    sinRom[16'd205] = 16'd7;
    sinRom[16'd206] = 16'd8;
    sinRom[16'd207] = 16'd9;
    sinRom[16'd208] = 16'd10;
    sinRom[16'd209] = 16'd12;
    sinRom[16'd210] = 16'd13;
    sinRom[16'd211] = 16'd14;
    sinRom[16'd212] = 16'd16;
    sinRom[16'd213] = 16'd17;
    sinRom[16'd214] = 16'd19;
    sinRom[16'd215] = 16'd21;
    sinRom[16'd216] = 16'd23;
    sinRom[16'd217] = 16'd24;
    sinRom[16'd218] = 16'd26;
    sinRom[16'd219] = 16'd28;
    sinRom[16'd220] = 16'd30;
    sinRom[16'd221] = 16'd32;
    sinRom[16'd222] = 16'd35;
    sinRom[16'd223] = 16'd37;
    sinRom[16'd224] = 16'd39;
    sinRom[16'd225] = 16'd41;
    sinRom[16'd226] = 16'd44;
    sinRom[16'd227] = 16'd46;
    sinRom[16'd228] = 16'd48;
    sinRom[16'd229] = 16'd51;
    sinRom[16'd230] = 16'd54;
    sinRom[16'd231] = 16'd56;
    sinRom[16'd232] = 16'd59;
    sinRom[16'd233] = 16'd61;
    sinRom[16'd234] = 16'd64;
    sinRom[16'd235] = 16'd67;
    sinRom[16'd236] = 16'd70;
    sinRom[16'd237] = 16'd73;
    sinRom[16'd238] = 16'd75;
    sinRom[16'd239] = 16'd78;
    sinRom[16'd240] = 16'd81;
    sinRom[16'd241] = 16'd84;
    sinRom[16'd242] = 16'd87;
    sinRom[16'd243] = 16'd90;
    sinRom[16'd244] = 16'd93;
    sinRom[16'd245] = 16'd96;
    sinRom[16'd246] = 16'd99;
    sinRom[16'd247] = 16'd102;
    sinRom[16'd248] = 16'd106;
    sinRom[16'd249] = 16'd109;
    sinRom[16'd250] = 16'd112;
    sinRom[16'd251] = 16'd115;
    sinRom[16'd252] = 16'd118;
    sinRom[16'd253] = 16'd121;
    sinRom[16'd254] = 16'd124;
    sinRom[16'd255] = 16'd127;
end

// readポイント更新
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        rp <= 16'd0;
    end else begin
        if (rp == 16'd255) begin
            rp <= 16'd0;
        end else begin
            rp <= rp + 16'd1;
        end
    end
end

// romデータ読み出し
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        d <= 16'd0;
    end else begin
        d <= sinRom[rp];
    end
end

endmodule
