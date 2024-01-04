# 2023-09-23
# Device L3GD20

# ------------------------------------------------------------------------------
# デバイス初期設定
# ------------------------------------------------------------------------------
def device_init(i2c):
    i2c.writeto_mem(0x6A, 0x20, bytearray([0x0B]))  # CTRL1 Reg, PD Default, Z,X,Y Enable
    i2c.writeto_mem(0x6A, 0x23, bytearray([0x20]))  # CTRL2

# ------------------------------------------------------------------------------
# xyz 角度取得
# ------------------------------------------------------------------------------
def get_xyz_acceleration(i2c):
    try:
        x = (i2c.readfrom_mem(0x6A, 0x29, 1)[0] << 8) | i2c.readfrom_mem(0x6A, 0x28, 1)[0]  # Msb | Lsb 
        y = (i2c.readfrom_mem(0x6A, 0x2B, 1)[0] << 8) | i2c.readfrom_mem(0x6A, 0x2A, 1)[0]
        z = (i2c.readfrom_mem(0x6A, 0x2D, 1)[0] << 8) | i2c.readfrom_mem(0x6A, 0x2C, 1)[0]

        if x >= 32768:
            x -= 65536
        if y >= 32768:
            y -= 65536
        if z >= 32768:
            z -= 65536

        x = x * 0.07
        y = y * 0.07
        z = z * 0.07

        return (x,y,z)  #タプルでまとめて返す
    except Exception:
        print("get_xyz_acceleration error")
        return (0,0,0)  #タプルでまとめて返す
