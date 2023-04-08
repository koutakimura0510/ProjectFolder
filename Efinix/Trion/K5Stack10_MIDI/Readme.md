- [Efinityを使用せずにソースファイルを追加する方法](#efinityを使用せずにソースファイルを追加する方法)



## Efinityを使用せずにソースファイルを追加する方法
プロジェクト作成後に生成される、"プロジェクト.xml" に以下のように追記することで、コンパイル時に追加される。

<efx:design_info def_veri_version="verilog_2k" def_vhdl_version="vhdl_2008">
        <efx:top_module name="K5Stack10MidiTop"/>  Top module を指定する
        <efx:design_file name="src/K5Stack10MidiTop.v" version="default" library="default"/> ファイルの相対パスを指定する
</efx:design_info>