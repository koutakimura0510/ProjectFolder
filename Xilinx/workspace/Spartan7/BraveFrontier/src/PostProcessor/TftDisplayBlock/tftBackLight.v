/*
 * Create 2022/6/28
 * Author koutakimura
 * -
 * ディスプレイの明るさ調整
 * BackLight Port が トランジスタに接続されているため、
 * PWM 出力の DUty 比を変更することで調光を行う
 *
 */
module tftBackLight (
	// External Port
	output 			oTftBackLight,
	// Internal Port
	input 			iPixelClk,
	input  			iSysRst,
	input 			iBackLightControl
);



endmodule