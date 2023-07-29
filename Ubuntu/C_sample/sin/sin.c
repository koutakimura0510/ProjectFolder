#include <stdio.h>
#include <stdint.h>
#include <math.h>

#define PI 3.14159265358979323846
#define SAMPLE_RATE 48000
#define FREQUENCY 440

void writeWAVHeader(FILE* file, int num_samples) {
    uint32_t chunk_size = 36 + num_samples * 2; // 16-bitなので2倍
    uint32_t subchunk2_size = num_samples * 2; // 16-bitなので2倍

    fwrite("RIFF", 1, 4, file);
    fwrite(&chunk_size, sizeof(chunk_size), 1, file);
    fwrite("WAVE", 1, 4, file);
    fwrite("fmt ", 1, 4, file);
    uint32_t subchunk1_size = 16;
    uint16_t audio_format = 1; // PCM
    uint16_t num_channels = 1; // モノラル
	uint16_t sample_rate = SAMPLE_RATE;
    uint32_t byte_rate = SAMPLE_RATE * 2;
    uint16_t block_align = 2;
    uint16_t bits_per_sample = 16;
    fwrite(&subchunk1_size, sizeof(subchunk1_size), 1, file);
    fwrite(&audio_format, sizeof(audio_format), 1, file);
    fwrite(&num_channels, sizeof(num_channels), 1, file);
    fwrite(&sample_rate, sizeof(SAMPLE_RATE), 1, file);
    fwrite(&byte_rate, sizeof(byte_rate), 1, file);
    fwrite(&block_align, sizeof(block_align), 1, file);
    fwrite(&bits_per_sample, sizeof(bits_per_sample), 1, file);
    fwrite("data", 1, 4, file);
    fwrite(&subchunk2_size, sizeof(subchunk2_size), 1, file);
}

int main() {
    const double amplitude = 32767.0;  // 振幅（-32767から32767の範囲で指定）
    const double duration = 1.0;       // サイン波の持続時間（秒）

    // サンプル数を計算
    int num_samples = SAMPLE_RATE * duration;

    // 1サンプルあたりの角周波数を計算
    double angular_frequency = 2.0 * PI * FREQUENCY;

    // WAVファイルを開く
    FILE* file = fopen("output.wav", "wb");
    if (!file) {
        printf("ファイルを開くことができませんでした。\n");
        return 1;
    }

    // WAVファイルヘッダを書き込む
    writeWAVHeader(file, num_samples);

    // サイン波を生成してWAVファイルに書き込む
    for (int i = 0; i < num_samples; ++i) {
        double value = amplitude * sin(angular_frequency * i / SAMPLE_RATE);
        int16_t sample = (int16_t)value;  // 16-bitの整数に変換
        fwrite(&sample, sizeof(sample), 1, file);
    }

    // ファイルを閉じる
    fclose(file);

    printf("音源データを生成し、output.wavに保存しました。\n");

    return 0;
}