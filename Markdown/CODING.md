# 【git commit カンニング】
## 「commitの書き方」
1行目 [fix]右移動時の描画のバグ修正</br>
2行目 空行</br>
3行目 詳細な説明</br>
</br>
一つのファイルに一つのコミットをするようにする。</br>
複数ファイルを一括でコミットしないようにする。</br>
コミットの癖をつけておく。</br>
</br>

---
**fix：**</br>
バグ修正

---
**hotfix：**</br>
クリティカルなバグ修正

---
**add：**</br>
新規（ファイル）機能追加

---
**update：**</br>
機能修正（バグではない）

---
**change：**</br>
仕様変更

---
**clean：**</br>
整理（リファクタリング等）

---
**disable：**</br>
無効化（コメントアウト等）

---
**remove：**</br>
削除（ファイル）

---
**upgrade：**</br>
バージョンアップ

---
**revert：**</br>
変更取り消し

---
</br>

# 【変数名早見表】
**add / remove**</br>
追加する、削除する。
リストなどに値を入れる場合などにも使われる。
特に、末尾に追加する場合は append、先頭に追加する場合は prepend を使う。
Add A to B で、A を B に加える。
Remove A from B で、B から A を取り除く。

---
**start / stop**</br>
開始する、止める。名詞だと開始、停止。
静止状態から動き出す感じが start。
途中からでも使える。
バーコードや通信の符号で StartCode / StopCode という使い方をする。

---
**begin / end**</br>
始める、終わる。
最初の一歩を踏み出す感じが begin。
始めにしか使えない。
C 言語では慣例的に、begin は包含、end は排他としている。

---
**first / last**</br>
初め、終わり。
単純な並びの場合や数を数える場合は first を使う。
数えられない場合は beginning を使う。

---
**min / max**</br>
最小、最大。

---
**top / last**</br>
先頭、末尾。
順位やレベルを意識する場合は top を使う。

---
**head / tail**</br>
頭・尾から転じて先頭・末尾。
ファイルの先頭や末尾を表すのに使う。

---
**header / footer**</br>
ヘッダー、フッター。
本文を表す場合は text や body が使われる。

---
**top / bottom**</br>
頂上、底辺。

---
**up / down**</br>
上へ、下へ。

---
**upper case / lower case**</br>
大文字、小文字。

---
**wide / narrow**</br>
広い、狭いから転じて全角、半角。
full-width と half-width でも全角と半角。
two-byte character と one-byte character で 2 バイト文字と 1 バイト文字。

---
**under / over**</br>
未満、超過。

---
**or under / and over**</br>
以下、以上。
greater than とか not less than など多数の言い方がある。
省略語も多く、LE / GE が多く使われる。
LE は less than or equal, less or equal のこと。

---
**go / back**</br>
前へ、後ろへ。
異なる階層間の移動のイメージ。

---
**previous / next**</br>
前の、次の。
同じ階層での横移動のイメージ。
動詞にする場合は、goNext, moveNext など。

---
**forward / backward**</br>
前方、後方。

---
**foreground / background**</br>
前景、背景。
プログラミングでは使わないが middle-ground で中景という言い方もある。

---
**push / pull**</br>
入れる、引っ張る。
Git のコマンドで使われている。
git push と反対の動作は git pull ではなく git fetch となる。

---
**push / pop**</br>
箱に入れる、中から取り出す。
皿を重ねるイメージ。
スタックに対して使う。

---
**enqueue / dequeue**</br>
キューに追加する、キューから取り出す。
queue は待ち行列の意味。
末尾は上上(ueue)で覚えておくとスペルに迷わない。

---
**before / after**</br>
適用前、適用後。

---
**parent / child / children / sibling / self**</br>
親、子、子供達、兄弟、自身。
XML や Tree の Node を示す場合などに。

---
**ancestors / descendants**</br>
先祖、子孫。
たいてい複数形で用いる。
Git の履歴などに。

---
**do / undo / redo**</br>
実行、取り消し、再実行。
電子カルテの do は ditto (前と同じ) の意味。

---
**backup / restore**</br>
データベースをバックアップする、復元する。

**create / delete / restore**</br>
ファイルを作成する、削除する、復元する。

---
**connect / disconnect**</br>
回線を接続する、切断する。
略す場合は conn とすることが多い。

---
**source / destination**</br>
送り元、送り先。
略す場合は src, dst とすることが多い。

---
**input / output**</br>
入力する、出力する。
デバイス(画面やキーボードなど)からの入出力。
ファイルなどの場合は変換がないときに使う。

---
**import / export**</br>
取り込む、輸入する、インポート。
外に出す、輸出する、エクスポート。
内容を変更してから処理する場合に使う。

---
**explicit / implicit**</br>
明示的な、暗黙的な。
ex- の語幹は out- なので、開放的。
迷ったら import / export の関係を思い出すとよい。

---
**lossy / lossless**</br>
不可逆、可逆。

---
**encode / decode**</br>
エンコード、デコード。
符号化する、複合する。

---
**encrypt / decrypt**</br>
暗号化する、解読(復号)する。
日本語の問題だが、「暗号化する」の反対は「復号"化"する」ではないので注意。

---
**download / upload**</br>
ダウンロードする、アップロードする。

---
**request / response**</br>
要求、希望、リクエスト。
返答、反応、レスポンス。

---
**request / respond**</br>
リクエストする、返答する。

---
**fetch / post**</br>
取得する、投稿する。
ネットワーク越しにデータを取ってくる場合は fetch が使える。
post の代わりに send でも可。

---
**serialize / deserialize**</br>
シリアライズする、復元する。
シリアライズとはメモリ上にあるデータをファイル形式に変換する処理。

---
**save / load**</br>
保存する、読み込む。
読み出して取り込む(設定する)までが load。

---
**set / unset / reset**</br>
設定する、解除する、初期位置に再設定する。

---
**lock / unlock**</br>
ロックする、解除する。

---
**attach / detach**</br>
結びつける、切り離す。
データベースのファイルや外部プログラムのデバッグ時に使用されている。

---
**suspend / resume**</br>
休止する、復帰する。

---
**enable / disable**</br>
有効にする、無効にする。

---
**activate / deactivate**</br>
アクティブ化する、非アクティブ化する。

---
**show / hide**</br>
表示する、非表示にする。

---
**visible / hidden**</br>
表示の、非表示の。
hidden の方が invisible より物理的な感じ。

---
**valid / invalid**</br>
有効な、無効な。
validation で検証の意味。

---
**collapse / expand**</br>
折りたたむ、展開する。
ツリーを操作する場合に使う。

---
**zero padding / zero suppression**</br>
ゼロ埋め、ゼロ抑制。
123 → 00123 が5桁のゼロパディング。
00123 → 123 がゼロサプレス。

---
**normal / abnormal**</br>
正常、異常。
明確な基準があって、当てはまっているか。

---
**normal / error**</br>
正常、異常。
正常(通常、普通)とそれに失敗したこと。

---
**regular / irregular**</br>
規則的な、不規則的な。日常的な、非日常的な。
一定の繰り返しパターンがあり、そこに当てはまるか。
テレビ出演者のことをレギュラーと呼ぶが、毎回出演することから。

---
**general / special**</br>
一般的な、特別な。
general は全体的、世間一般な感じ。

---
**ordinal / special**</br>
平凡な、特別な。
ordinal は特筆すべきことがないネガティブな感じ。

---
**common / special**</br>
共通の、固有の。

---
**common / personal**</br>
共用の、個人の。
common settings で共通設定。
shared は持ち主がいて分け与える意味での共有。

---
**common / uncommon**</br>
ありふれた、ありふれていない。

---
**available / unavailable**</br>
利用可能、利用不可または入手可能、入手不可。

---
**success / failure**</br>
成功、失敗。
success と error を使う場合も。
OK と NG は和製英語なため、工場くらいでしか通じない。

---
**accept / refuse**</br>
承諾する、拒否する。

---
**allow / deny**</br>
許可する、拒否する。アラウ、ディナイと発音する。
ファイルシステムのパーミッションやネットワーク関連では失敗するとよく denied と言われる。

---