# 【Zynq 東方ProjectRPG Game】

## 【TOP】

<details>
    <summary>開発環境</summary></br>
      Create	2021/03/27</br>
      Author	Kimura Kouta</br>
      Board	ArtyZ7-20</br>
      Ubuntu 20.04 LTS</br>
      Vitis20.2</br>
      Vivado20.2</br>
      Vitis_HLS20.2</br>
  </details>
  </br>
  </br>

## 【ブログ】
色々やっているブログ → (https://aki-kimura.hatenablog.com/)</br>
</br>
</br>


## 【コンセプト】
最終目標は、大規模イベントの **`東方Project秋季例大祭`** に出店し販売すること。(主人公が秋姉妹なので)</br>
オリジナルのハードウェア、ソフトウェアを製作し、エンドユーザのハートを掴む。</br>
**`途中で投げ出さずに最後までやり抜くこと。`**</br>
</br>
</br>

## 【仕様】

<details>
  <summary>1. 映像描画</summary></br>
  
  FPGAを使用したHDMI出力にする。</br>
  TFT_LCDを使用した携帯機を考えたが個人では値段が高価なため断念。</br>
  素材は配布可能なものを使用。</br>
    </br>
</details>

<details>
  <summary>2. データ関連</summary></br>
  
  SDカード、もしくはUSB、もしくはQSPIフラッシュメモリを使用。</br>
  ライセンスの仕様による。</br>
  DDRメモリは現状512MByteで足りそうではあるため同じで行く予定。</br>
  </br>
</details>

<details>
  <summary>3. 操作性</summary></br>
  
  6つのタクトスイッチを使用、上下左右ABボタン。</br>
  当初はカメラモジュールとセンサを用いてモーションキャプチャーにしようとした。</br>
  非接触＆運動不足解消になると思ったが、個人では値段が高くなるため断念。</br>
  </br>
</details>

<details>
  <summary>4. 音源関連</summary></br>
  
  I2Sを使用。</br>
  48khzの音源データを使用しアンプ回路を組んで出力とする。</br>
  デジタルフィルタで音源の加工を行い、アンプ回路の規模を小さくするようにする。</br>
  音源はフリーのものを使用。</br>
  </br>
</details>

<details>
  <summary>5. 基板</summary></br>

  BOM数、BOMコストを抑えるため、**`必要最低限の部品で製作する。`**</br>
  携帯機ではなくなったためある程度の大きさは許容する。</br>
  最低でも4層基板になるため、受注時に予め値段を調べておき最も安く作りやすい大きさで製作する。</br>
  - 評価基板にあるけどいらないもの</br>
    1. イーサネットコントローラ</br>
    2. USBデバッグ関連の回路</br>
    </br>
  - 評価基板を真似るべきもの</br>
    1. Zynqと電源回りの回路</br>
    2. HDMIの出力回路</br>
    3. スイッチ関連</br>
    4. USB書き込み回路</br>
    5. SDカード回路</br>
    6. FPGAの回路保存に使用するQSPIの回路</br>
    </br>
  - 追加しなければいけないもの</br>
    1. オーディオ回路</br>
    2. SDカードを読み込み専用にするならばセーブデータ書き込み用のEEPROM</br>
  </br>
</details>

<details>
  <summary>6. 筐体</summary></br>
  適当な業者に発注する。</br>
  二次元的な加工を施す。</br>
</br>
</details>
</br>
</br>


## 【履歴】
<details>
<summary>2021/09</summary></br>
  把握している限りでは必要な機能はあとイベント実装のみ。</br>
  </br>
</details>
<details>
<summary>2021/08</summary></br>
  コメントの書き方を変更。vscodeプラグインのDocumetationをしようすることにした。</br>
  </br>
</details>
<details>
<summary>2021/07</summary></br>
  環境がUbuntuなのでファイル出力のアプリケーションに、シンボリックリンクを使用することとした。</br>
  面倒だと感じた作業はなるべく省略可していきたい。</br>
  </br>
</details>
<details>
<summary>2021/06</summary></br>
  コメントの先頭にversion情報、日付を記載するようにした。</br> 
  変更を行った場合に、ver2, ver3...と増やしていき、前の情報を消さないようにする。</br>
  関数内処理を詳しく記入するように変更した。</br>
  </br>
</details>
<details>
<summary>2021/05</summary></br>
  画面描画のソフトウェアの処理をハードウェアに移行。</br>
  </br>
</details>
<details>
<summary>2021/04</summary></br>
  プロジェクトの開始。</br>
  </br>
</details>
<details>
<summary>2021/03</summary></br>
  プロットの作成、仕様決定。</br>
  </br>
</details>