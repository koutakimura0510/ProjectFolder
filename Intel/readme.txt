--起動コマンド実行ファイル記入

１．テキストエディターでプロファイル設定を開く
vim ~/.profile

２．IDEの実行ファイルまでのパスを記入する
PATH=$PATH:/home/koutakimura/intelFPGA_lite/20.1/quartus/bin

３．端末上で下記コマンドを実行
quartus

４．コマンド実行後、端末にGtk-Messageが表示され、数十秒立つとIDEが起動する

--USB-Driver接続
１．/etc/udev/rules.dに
51-usbblaster.rulesファイル作成

２．接続エラー確認
 ．sudo /home/User/intelFPGA_lite/20.1/quartus/bin/jtagconfig
 .Unable to read device chain -JTAG chain brken  デバイス未接続
 .No JTAG hardware avariable USB-Blaster未接続
 .Unable to lock cahin 権限が設定されていない
