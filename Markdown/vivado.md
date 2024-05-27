# 【Vivadoエラー処理まとめ】
Vivadoを操作していてエラー処理に詰まった内容を残しておく。</br>
- [【Vivadoエラー処理まとめ】](#vivadoエラー処理まとめ)
  - [DRC RPBF-3](#drc-rpbf-3)
</br>
</br>

## DRC RPBF-3
[DRC RPBF-3] IO port buffering is incomplete: Device port ioDDR3_DQS_n[1] expects both input and output buffering but the buffers are incomplete.</br>
inoutでの端子使用時に、出力のみ又は入力のみで使用していると、片方でしか使っていないというエラーを出してくれる。
</br>