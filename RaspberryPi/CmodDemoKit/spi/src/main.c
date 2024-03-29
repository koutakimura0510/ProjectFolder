/**----------------------------------------------------------
 * Create  2022/8/26
 * Author  koutakimura
 * 
 * Device:RaspberryPi 4B RAM 4GB
 * VSCode v1.7.00
 * 
 * RaspberryPi SPI通信 Master 動作
 * FPGA 搭載の携帯ゲーム機を制作するためのデバッグ用プログラム
 * 本来はFPGAが Master となりゲームデータが保存されているフラッシュメモリと通信を行うが、デバッグが大変になる。
 * そこで、OS を搭載した RaspberryPi が疑似フラッシュメモリの振る舞いをすることで、
 * 開発スピードを上げる目的がある。
 * 
 * RaspberryPi SPI は Slaveとして機能しないため、Master動作とし、
 * FPGA にゲームデータを送信し、動作を確認することでデバッグを進めることとする。
 * 
 *---------------------------------------------------------*/
#include <main.h>


/**----------------------------------------------------------
 * main 関数
 * argc コマンドライン引数の個数
 * argv[0] プログラム名
 * argv[1] 引数1
 * argv[2] 引数2 ...
 * 
 *---------------------------------------------------------*/
int main(int argc, char **argv)
{
	//----------------------------------------------------------
	// 初期設定
	//----------------------------------------------------------
	if (false == gpio_init(SPI_CLK_3_125_000_Hz))
	{
		printf("GPIO 初期設定エラーのためプログラムを終了します\r\n");
		printf("仮想メモリ経由のため sudo で実行しないと設定が行えません\r\n");
		return 1;
	}

	//----------------------------------------------------------
	// system 稼働処理 関数呼び出し
	//----------------------------------------------------------
	fpga_csr_init();

	//----------------------------------------------------------
	// 設定終了
	//----------------------------------------------------------
	if (false == gpio_close())
	{
		printf("GPIO の開放に失敗しました。\r\n");
		return 1;
	}

	printf("プログラムを終了します\n");

	return 0;
}