#include <stdio.h>
#include <math.h>
#include <string.h>
#include <sndfile.h>

#define SAMPLE_RATE 44100
#define DURATION 5.0
#define AMPLITUDE 0.5
#define FREQUENCY 440.0

int main() {
    SNDFILE *outfile;
    SF_INFO sfinfo;
    double t, sample;

    // Initialize SF_INFO structure
    memset(&sfinfo, 0, sizeof(sfinfo));
    sfinfo.samplerate = SAMPLE_RATE;
    sfinfo.frames = (int)(DURATION * SAMPLE_RATE);
    sfinfo.channels = 1;
    sfinfo.format = SF_FORMAT_WAV | SF_FORMAT_PCM_16;

    // Open the output file
    outfile = sf_open("sawtooth_wave_output.wav", SFM_WRITE, &sfinfo);
    if (!outfile) {
        printf("Error opening output file\n");
        return 1;
    }

    // Generate and write sawtooth wave samples
    for (t = 0.0; t < DURATION; t += 1.0 / SAMPLE_RATE) {
        sample = (2.0 * t * FREQUENCY - floor(2.0 * t * FREQUENCY + 0.5)) * AMPLITUDE;
        sf_writef_double(outfile, &sample, 1);
    }

    // Close the output file
    sf_close(outfile);

    printf("WAV file generated successfully.\n");

    return 0;
}