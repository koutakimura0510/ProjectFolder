<h1>【QSPI Flash Memory 使用方法】</h1>

- [1. デバイス](#1-デバイス)
- [2. アドレスマップ](#2-アドレスマップ)
- [3. レジスタマップ](#3-レジスタマップ)
- [4. 使用方法](#4-使用方法)
</br></br>

## 1. デバイス
Winbond W25N01GVxxIG 1Gbit 128MB
</br></br>

## 2. アドレスマップ
規格 | 容量
-|-
Sector      | 512 byte
Spare Area  | 64 byte
Page        | 2048 byte / 4 sector / 1 Spare Area
Block       | 128 KB / 64 page
Column      | 2048 11bit
all         | 65536 page / Column
</br>

## 3. レジスタマップ
Commands | OpCode | Byte2 | Byte3 | Byte4 | Byte4
-|-|-|-|-|-
Device RESET | FFh | 
Read Status Register | 0Fh / 05h | SR Addr | S7-n
Write Status Register | 1Fh / 01h | SR Addr | S7-n
Write Enable | 06h | 
Write Disable | 04h | 
Program Data Load (write) | 02h | CA15-8 | CA7-0 | Data-n |
Read | 03h |CA15-8 | CA7-0 | Dummy | D7-0n
</br>

## 4. 使用方法
[Write]</br>
書き込み・消去コマンドを実行する場合、</br>
直前に WREN コマンドを発行し、WELレジスタに1を設定する必要がある。</br>
WREN コマンド発行時はコマンドの 1byte のみ発行し CS を High にする必要がある</br>
ページ書き込みコマンドは 1セクタ 連続書き込みが可能</br>
1Gbit はページ書き込みが可能</br>
書き込み・消去後は RDSR1 コマンドを実行し、WIP レジスタに0が入力されるまで次のコマンドを実行してはならない</br>
CS の High Low は最低 100ns 維持しなければならない</br>
「1ページ 2048 byte のメモリに書き込む際の手順」</br>
CS Low</br>
WREN コマンド発行し Enable</br>
CS High</br>
CS Low</br>
P4E(4P4E) コマンド発行し 1セクタを消去、書き込み前に 1セクタ領域を消去しなければならない</br>
RDSR1 発行し、WIP レジスタに 0 が入力されるまで待機</br>
CS High</br>
CS Low</br>
WREN コマンド発行し Enable</br>
PP(4PP) コマンド発行</br>
3~4 byte アドレス発行</br>
256byte 書き込み</br>
RDSR1 発行し、WIP レジスタに 0 が入力されるまで待機</br>
CS High</br>
CS Low</br>
書き込み終了後 WRDI コマンド発行し Disable</br>
CS High</br>
</br>