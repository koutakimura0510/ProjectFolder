## 初めに
プロジェクトの共通事項として、MicroPythonで開発する場合 .pyファイルを評価ボードに書き込むため、
ソースコードやコメントを多く記載すると、ファイルサイズが大きくなる。(uf2 FW だけで 650KB 程度リソースを消費する)
そのため、ファイルに対するコメントは、Readme や アプリケーションノートを用意して PC 側で保存する。

## main.py
- RGB_LED_R, G, B
XIAO RP2040 搭載の RGB LED 制御を行う。(負論理)

- NEO_PWR, PIX
XIAO RP2040 搭載の RGB LED (NEO PIXEL) 制御を行う。
使用時は PWR を "H" にし、PIX でクロックを生成し、点灯と消灯のパラメータを送信する。
今回は用意されているライブラリを使用。
= NeoPixel (ピン番号、ピクセル数)
各色は 8bit 階調で設定可能だが、結構眩まぶしいので、0~10 ぐらいが丁度よい。


## fpga.py
- PICO_ADC
外部 3.3V を可変抵抗で分圧した電圧が入力される。
用途としては、電圧値の数値によって、FPGA Audio Volume のレジスタ設定を行い、音量の調整をする。

- TRION_CDONE
FPGA Config Done pin の状態をモニタリングする。
"H" で Config Done , "L" Not Done
Done 確認から少なくとも 30us 経過するまで、システム・リセットを維持しなければならない。

- TRION_CFGRST
FPGA Device Rst pin の制御を行う。(負論理)

- TRION_PICO_IO1
FPGA 内部 USIB のバス・スイッチを切り替える。
"H" RP2040 が Master となる。
"L" not uesd

- TRION_PICO_IO2
FPGA システム・リセット信号 (負論理)
Done 確認から少なくとも 30us 経過するまで、システム・リセットを維持しなければならない。

- TRION_PICO_IO3
unused

- TRION_PICO_MOSI, MISO, SCK, CS
SPI Master となって、FPGA のレジスタへ R/W を行う。
FPGA では システム・クロックで SCK のエッジを検出している。(同期クロック。ドメイン)
そのため、実行帯域は FPGA の動作周波数に依存する。
非同期の SCK を使用して FF を駆動しているわけではない点に注意。

## usb.py
## timer.py