`timescale 1ns / 1ps
/*
 * Create 2021/1/29
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * プレイヤーのドットデータ作成モジュールのテストベンチ
 */


module tbDotPlayer;

parameter CYCLE = 2;

reg iCLK = 0;
reg iRST = 0;
reg  [ 9:0] iUXS = 0;
reg  [ 9:0] iUXE = 32;
reg  [ 9:0] iUYS = 0;
reg  [ 9:0] iUYE = 32;
reg  [ 9:0] iHPOS = 0;
reg  [ 9:0] iVPOS = 100;
reg  [ 1:0] iDirX = 0;
reg  [ 1:0] iDirY = 0;
wire [31:0] oPlayerDot;

dotPlayerTop #(
    .VMAX     (80)
) DOT_PLAYER_TOP (
    .iCLK       (iCLK),
    .iRST       (iRST),
    .iUXS       (iUXS),
    .iUXE       (iUXE),
    .iUYS       (iUYS),
    .iUYE       (iUYE),
    .iHPOS      (iHPOS),
    .iVPOS      (iVPOS),
    .iDirX      (iDirX),
    .iDirY      (iDirY),
    .oPlayerDot (oPlayerDot)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

always @(posedge iCLK) begin
    // #(CYCLE);
    if (iRST == 1 || iVPOS != 0)
    begin
        iHPOS = 0;
    end else begin
        if (iHPOS == 80)
        begin
            iHPOS = 0;
        end else begin
            iHPOS = iHPOS + 1;
        end
    end
end

initial begin
    iRST = 0;
    #(CYCLE * 2);
    iRST = 1;
    #(CYCLE * 4);
    iRST = 0;
    #(CYCLE * 4);
    iVPOS = 0;
    #(CYCLE * 100 * 4);
    $stop;
end

endmodule
