from PIL import Image

# 画像サイズ
width, height = 32, 32

# RGB ベース値
r_value = 00
g_value = 00

# 画像データ作成
img = Image.new("RGBA", (width, height))

for y in range(height):
    for x in range(width):
        # B値をインクリメント (0~255 の範囲で繰り返し)
        b_value = (y * width + x) % 256
        img.putpixel((x, y), (r_value, g_value, b_value, 255))  # 透過度 0xFF

# 保存
img.save("incremental_blue_32x32.png")
