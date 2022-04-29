<h1>【QSPI Flash Memory 使用方法】</h1>

- [1. デバイス](#1-デバイス)
- [2. アドレスマップ](#2-アドレスマップ)
- [3. レジスタマップ](#3-レジスタマップ)
- [4. W25N01GVxxIG 1Gbit 使用方法](#4-w25n01gvxxig-1gbit-使用方法)
- [5. W25N01 32MB 使用方法](#5-w25n01-32mb-使用方法)
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
Block       | 128 KB / 64 page * 1024
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
Program Execute | 10h | dummy | PA15-8 | PA7-0
Page Data Read | 13h | dummy | PA15-8 | PA7-0
Read | 03h | CA15-8 | CA7-0 | Dummy | D7-0n
Block Erase | d8h | dummy | PA15-8 | PA7-0
</br>

## 4. W25N01GVxxIG 1Gbit 使用方法
32MB Memory などの場合は、大容量のものとコマンドの数や手順が異なるため、都度データシートを確認すること</br>
</br>
ID | Exp
-|-
1 | Write Enable (WREN) コマンドを発行し、WEL レジスタに 1 を設定し CS を High にする</br>
2 | Block Erase を発行し、次に消去を行う Block アドレスを発行し、CS を High にし書き込み予定のブロックを消去する</br>
3 | Block Erase 後は、最大 10ms 完了にかかる</br>
4 | このとき、ステータス・レジスタの BUSY bit を確認し、0 になっていれば、プログラムは終了している</br>
5 | WEL レジスタが 0 にクリアされる</br>
6 | Write Enable (WREN) コマンドを発行し、WEL レジスタに 1 を設定し CS を High にする</br>
7 | Program Data Load を発行し、次にセクタの書き込みアドレスを発行し、書き込みデータをメモリの FIFO に順次送信 CS を High にする</br>
8 | Program Execute を発行し、次に Block と page アドレスを発行し、CS を Highにし、書き込みを開始する</br>
9 | Program Execute 後は、最大 700us 完了にかかる</br>
10 | このとき、ステータス・レジスタの BUSY bit を確認し、0 になっていれば、プログラムは終了している</br>
11 | WEL レジスタが 0 にクリアされる</br>
12 | 以下繰り返し</br>
13 | </br>
14 | [Read Flow]</br>
15 | Page Data Read を発行し、指定 page の 2048 + 64 Byte のデータを FIFO にロードする</br>
16 | Page Data Read 後は、最大 700us 完了にかかる</br>
17 | このとき、ステータス・レジスタの BUSY bit を確認し、0 になっていれば、プログラムは終了している</br>
18 | Read コマンドを発行し、ロードしたデータを、指定アドレスから順次読み出す</br>
19 | 以下繰り返し</br>
</br>

**`「注意点」`**</br>
`ブロック内のページは、下位のページアドレスから次のページに順番にプログラムする必要があります`</br>
`ブロック内の上位ページアドレス。ページを順不同でプログラミングすることは禁止されています`**</br>
</br>

## 5. W25N01 32MB 使用方法
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