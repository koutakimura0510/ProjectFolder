def convert_text_to_binary(input_file, output_file):
    with open(input_file, "r") as infile, open(output_file, "wb") as outfile:
        for line in infile:
            hex_values = line.strip().split(",")  # カンマ区切りで分割
            binary_data = bytes(int(value, 16) for value in hex_values)  # 16進数をバイナリに変換
            outfile.write(binary_data)  # バイナリファイルに書き込み

# 使用例
convert_text_to_binary("field.txt", "../src/VideoTxBlock/VideoPixelGenUnit/sim/output.bin")
convert_text_to_binary("field.txt", "res/output.bin")
print("バイナリファイルの作成が完了しました。")