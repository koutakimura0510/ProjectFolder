/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章      */
/* project: display    */
/* outline: VBLANK作成 */

module disp_flag (
    input       CLK,
    input       RST,
    input       VGA_VS,
    input       CLRVBLNK,
    output  reg VBLANK
    );

/* VBLANKセット信号・・・VGA_VSをCLKで同期化 */
reg [2:0]   vblank_ff;

always @( posedge CLK ) begin
    if ( RST )
        vblank_ff <= 3'b111;
    else begin
        vblank_ff[0] <= VGA_VS;
        vblank_ff[1] <= vblank_ff[0];
        vblank_ff[2] <= vblank_ff[1];
    end
end

wire set_vblank = (vblank_ff[2:1] == 2'b10);

/* VBLANKフラグ */
always @( posedge CLK ) begin
    if ( RST )
        VBLANK <= 1'b0;
    else if ( CLRVBLNK )
        VBLANK <= 1'b0;
    else if ( set_vblank )
        VBLANK <= 1'b1;
end

endmodule
