[改訂2版] FPGAボードで学ぶ組込みシステム開発入門　～Intel FPGA編～
　　　　　　　　例題回路及び課題回路の設計データ
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　作成：2018年1月
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　修正：2020年3月

●ご利用上の注意
　提供した回路記述、プログラムなどは自己責任の範囲でご利用ください。利用において
生じた損失や損害、その他いかなる事態も、出版社、著作権者、配布者は責任を負いかね
ます。

●開発ソフトウェアのバージョンについて
　本データはQuartus Prime Lite Edition 17.0で作成しました。必ずこのバージョンを
用いて実行してください。他のバージョンでも、回路記述やCプログラムなど流用できる
可能性はありますが未確認です。

●データ内容と利用方法
　Quartus PrimeやNios II EDSは非常に多くのファイルを生成しますので、本設計データは、
本書の内容を実施するのに必要なものに限定しました。本書を読んでプロジェクトを構築
して動作を確認して下さい。
　なおプロジェクトを構築せずにFPGAボードで試す方法は、本書Appendix II-3に記載
していますので、すぐにも動作させてみたい方はお試しください。

●トップフォルダ
・readme.txt ・・ このファイル
・DE0-CV     ・・ DE0-CV用設計データのフォルダ
・DE10-Lite  ・・ DE10-Lite用設計データのフォルダ
・DE1-SoC    ・・ DE1-SoC用設計データのフォルダ

●DE0-CVフォルダ
・DE0-CV_pin.qsf        ・・ DE0-CV用ピンアサイン・ファイル
・DE0-CV_nios2sys_top.v ・・ DE0-CV用Nios IIシステム最上位階層テンプレート
・dai2sho
　- seg7dec      ・・ 7セグメントデコーダ（2-2）
　- sec10        ・・ 1秒桁（2-3）
　- sec60        ・・ 課題：60秒計（2-4）
・dai3sho
　- clock1       ・・ 1時間計（3-1）
　- clock24      ・・ 24時間時計（3-3）
　- clock24ext   ・・ 課題：24時間時計の拡張（3-4）
・dai5sho
　- nios2pio     ・・ 7セグメントデコーダをNios IIで実現（5-2、5-3、5-4）
・dai6sho
　- nios2mypio   ・・ 自作PIOをNios IIシステムに組み込む（6-2）
　- timer        ・・ タイマー関連API解説用（6-3）
　- nios2clock1  ・・ 課題：Nios IIによる1時間計（6-4）
・dai7sho
　- ps2if        ・・ PS/2インターフェース（7-1）
　- vgaif        ・・ VGA文字表示回路（7-2）
　- ps2if_scroll ・・ 課題：スクロールホイール対応（7-3）
　- ps2vga       ・・ 課題：キーボード入力文字を画面に表示（7-3）
・dai8sho
　- sdram        ・・ SDRAMコントローラの確認（8-1）
　- display      ・・ グラフィック表示回路（8-2、8-3）
・dai9sho
　- capture      ・・ キャプチャ回路システム（9-2、9-3、9-4）
　- capture7670  ・・ キャプチャ回路システム～OV7670対応版（9-2、9-3、9-4）

●DE10-Liteフォルダ
・DE10-Lite_pin.qsf        ・・ DE10-LiteV用ピンアサイン・ファイル（第3章以外）
・DE10-Lite_pin_PSW.qsf    ・・ DE10-Lite用ピンアサイン・ファイル（プッシュSWを使用した第3章用）
・DE10-Lite_nios2sys_top.v ・・ DE10-Lite用Nios IIシステム最上位階層テンプレート
・dai2sho
　- seg7dec      ・・ 7セグメントデコーダ（2-2）
　- sec10        ・・ 1秒桁（2-3）
　- sec60        ・・ 課題：60秒計（2-4）
・dai3sho
　- clock1       ・・ 1時間計（3-1）
　- clock24      ・・ 24時間時計（3-3）
　- clock24ext   ・・ 課題：24時間時計の拡張（3-4）
・dai5sho
　- nios2pio     ・・ 7セグメントデコーダをNios IIで実現（5-2、5-3、5-4）
・dai6sho
　- nios2mypio   ・・ 自作PIOをNios IIシステムに組み込む（6-2）
　- timer        ・・ タイマー関連API解説用（6-3）
　- nios2clock1  ・・ 課題：Nios IIによる1時間計（6-4）
・dai7sho
　- ps2if        ・・ PS/2インターフェース（7-1）
　- vgaif        ・・ VGA文字表示回路（7-2）
　- ps2if_scroll ・・ 課題：スクロールホイール対応（7-3）
　- ps2vga       ・・ 課題：キーボード入力文字を画面に表示（7-3）
・dai8sho
　- sdram        ・・ SDRAMコントローラの確認（8-1）
　- display      ・・ グラフィック表示回路（8-2、8-3）
・dai9sho
　- capture      ・・ キャプチャ回路システム（9-2、9-3、9-4）
　- capture7670  ・・ キャプチャ回路システム～OV7670対応版（9-2、9-3、9-4）

●DE1-SoCフォルダ
・DE1-SoC_pin.qsf        ・・ DE1-SoC用ピンアサイン・ファイル
・DE1-SoC_nios2sys_top.v ・・ DE1-SoC用Nios IIシステム最上位階層テンプレート
・dai2sho
　- seg7dec      ・・ 7セグメントデコーダ（2-2）
　- sec10        ・・ 1秒桁（2-3）
　- sec60        ・・ 課題：60秒計（2-4）
・dai3sho
　- clock1       ・・ 1時間計（3-1）
　- clock24      ・・ 24時間時計（3-3）
　- clock24ext   ・・ 課題：24時間時計の拡張（3-4）
・dai5sho
　- nios2pio     ・・ 7セグメントデコーダをNios IIで実現（5-2、5-3、5-4）
・dai6sho
　- nios2mypio   ・・ 自作PIOをNios IIシステムに組み込む（6-2）
　- timer        ・・ タイマー関連API解説用（6-3）
　- nios2clock1  ・・ 課題：Nios IIによる1時間計（6-4）
・dai7sho
　- ps2if        ・・ PS/2インターフェース（7-1）
　- vgaif        ・・ VGA文字表示回路（7-2）
　- ps2if_scroll ・・ 課題：スクロールホイール対応（7-3）
　- ps2vga       ・・ 課題：キーボード入力文字を画面に表示（7-3）
・dai8sho
　- sdram        ・・ SDRAMコントローラの確認（8-1）
　- display      ・・ グラフィック表示回路（8-2、8-3）
　- display_full ・・ フルカラー版グラフィック表示回路（8-2、8-3）
・dai9sho
　- capture      ・・ キャプチャ回路システム（9-2、9-3、9-4）
　- capture7670  ・・ キャプチャ回路システム～OV7670対応版（9-2、9-3、9-4）


●修正履歴
・2020年/3月
　キャプチャ回路システム（dai9sho\capture、dai9sho\capture7670）内の
　　-　SCCBコントローラ：sccb.v
　　-　制御ソフトウェア：cap_test.c、movie.c
　にバグがあり修正
